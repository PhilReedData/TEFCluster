#text2vec_fec.R

# Package installation
# ====================
##devtools::install_github('Rdatatable/data.table')
## ^ To use rbindtable(). On macOS may require: 
##https://www.r-bloggers.com/using-osx-compiling-an-r-package-from-source-issues-with-fopenmp-try-this/

#install.packages('data.table')
#install.packages('tm')
#devtools::install_github('dselivanov/text2vec')
#install.packages('SnowballC')
#install.packages('LDAvis')
#install.packages('servr')

# Load libraries
# ==============
library(data.table)
library(tidyverse)
library(readxl)
library(tm)
library(text2vec)
library(SnowballC)
library(LDAvis)
library(servr)

# Reading files
# =============

# Get HEI/FEC status from CSV file (keep relevant, unique columns)
context <- read_csv('data/raw/tef_y2_allcontext.csv')
context <- context %>%
  select(PROVIDER_NAME, PROVIDER_TEFUKPRN, PROVIDER_TYPE) %>% 
  distinct()
context <- context[context$PROVIDER_TYPE == "FurtherEducationCollege", ]
fec_prns <- context[
    context$PROVIDER_TYPE == "FurtherEducationCollege",
    ][['PROVIDER_TEFUKPRN']]


#dir_input <- 'data/raw/TEFYearTwo_AllSubmissions_txt_pl2sin'
# Not written the plural to singular code or dir yet
dir_input <- 'data/raw/TEFYearTwo_AllSubmissions_txt'
files <- list.files(dir_input, full.names = TRUE, pattern = "\\.txt$")
files_short <- list.files(dir_input, full.names = FALSE, pattern = "\\.txt$")
prn_start <- 1
prn_end <- 8 # first 8 characters are the prn number
name_start <- 10
name_end <- 100 # max length; will cut off tail below
# Get vector of just the prn index numbers
files_prns <- sapply(files_short, USE.NAMES = FALSE, 
                     function(x) substr(x, prn_start, prn_end))
# Keep just the HEI or LEC files and files_short
fec_files_short <- sapply(files_short, USE.NAMES = FALSE,
                    function(x) {
                      # Get the prn from the filename, return it if in list
                      if (substr(x, prn_start, prn_end) %in% fec_prns) x
                      else NA
                    })
# remove NA
fec_files_short <- fec_files_short[!is.na(fec_files_short)]
fec_files <- sapply(fec_files_short, USE.NAMES= FALSE,
                       function(x) paste0(dir_input,'/',x))

# Read award data from Excel, keep those we have files for, sorted by prn
award_excel <- 'data/raw/tefyeartwo_awards.xlsx'
award_sheet <- 'TEF2017 Awards'
award_range <- 'A5:G300'
award_df <- read_excel(award_excel, sheet=award_sheet, range = award_range) %>%
  select('Provider UKPRN', 'TEF Year Two award') %>%
  rename(prn = 'Provider UKPRN', award = 'TEF Year Two award') %>%
  filter(prn %in% files_prns)
# Sort the awards by prn
award_df <- award_df[order(award_df$prn),]
# Find missing awards and add to award_df
missing_prns <- setdiff(files_prns, award_df$prn)
award_df <- add_row(award_df, prn = missing_prns, award = 'Missing')
# Sort again
award_df <- award_df[order(award_df$prn),]
# Should be same length
#length(files_prns) == nrow(award_df)
# Make vectors of prn for each award
gold_prns <- award_df[award_df$award == 'Gold', ][['prn']]
silver_prns <- award_df[award_df$award == 'Silver', ][['prn']]
bronze_prns <- award_df[award_df$award == 'Bronze', ][['prn']]


# Load text content of files into list
text_list <- lapply(fec_files, 
                    function(x) data.frame(
                      document_txt = paste(readLines(x), collapse = " ")))

# Form a data gram with all texts (Complex!)
## rbindlist() requires data.table package; may be able to use rbind() instead
textdf <- rbindlist(text_list) 
#textdf <- rbind(text_list) 
# Document ID is an interger index. Maybe should use the prn ID instead.
textdf <- textdf %>% 
  bind_cols(data.frame(document_id = 1:nrow(textdf))) %>%
  mutate(document_txt = as.character(document_txt))

# efficient way to convert to data frame
setDT(textdf)
setkey(textdf, document_id)
set.seed(2017L)



# Create document-term matrix
# ===========================
# define preprocessing function and tokenization
prep_fun <- function(x) {
  x %>%
    # to lower case
    str_to_lower %>%
    # remove non-alphanum characters
    str_replace_all("[^[:alnum:]]", " ") %>%
    # remove all numbers and dots
    str_replace_all("[^\\w][\\d\\.]+", " ") %>%
    # collapse multiple spaces
    str_replace_all("\\s+", " ") %>%
    # remove separate letters with space at beginning and non-alphanum at end
    str_replace_all("\\s[A-Za-z][^\\dA-Za-z]", " ")
}

# stemming (could use word_tokenizer instead)
tok_fun <- function(x) {
  tokens <- word_tokenizer(x)
  lapply(tokens, SnowballC::wordStem, language="en")
}

# Use default English stopwords (for now)
stopwords <- tm::stopwords("english")

it_train <- itoken(textdf$document_txt,
                   preprocessor = prep_fun,
                   tokenizer = tok_fun,
                   ids = textdf$document_id,
                   progressbar = TRUE)

# Create vocabulary with bigrams or not
t1 <- Sys.time()
vocab <- create_vocabulary(it_train, stopwords = stopwords)
print(difftime(Sys.time(), t1, units = 'mins'))

# Option to prune vocab from uncommon terms (in only a few docs)
pruned_vocab <- prune_vocabulary(vocab, 
                                 term_count_min = 10,
                                 doc_proportion_max = 1,
                                 doc_proportion_min = 0
                                )

# create tdm
vectorizer <- vocab_vectorizer(pruned_vocab)

#document term matrix
dtm <- create_dtm(it_train, vectorizer)


# Save dtm for LDA validation
# ===========================
saveRDS(dtm, 'data/processed/fec_dtm.rds')


# LDA model
# =========
topics_number <- 50

# set seed to provide reproducibility
set.seed(7654)

lda_model <-
  LDA$new(n_topics = topics_number,
          doc_topic_prior = 0.005, 
          topic_word_prior = 0.001)

# Slow command next
doc_topic_dist <- 
  lda_model$fit_transform(dtm, n_iter = 1000, convergence_tol = 0.001,
                          check_convergence_every_n = 10)

# LDA Results
# ===========
word_vectors <- lda_model$get_top_words(n = 50, lambda = 1)

# get number of words for each topic
word_vectors_to_write <- data.frame(word_vectors)
names(word_vectors_to_write) <- paste0('topic_', 1:topics_number)

# topics for each document, including the award
# Bind data frames assuming same order and number of rows
doc_topic_dist_to_write <- 
  data.frame(files = fec_files_short, 
             prn = substr(fec_files_short, prn_start, prn_end),
             name = str_replace_all(
               substr(files_short, name_start, name_end),
               '_Submission.txt', '')
             ) %>% 
  bind_cols(select(award_df, award)) %>%
  bind_cols(data.frame(doc_topic_dist))
names(doc_topic_dist_to_write) <- 
  c('file_name', 'prn', 'name', 'award', paste0('topic_', 1:topics_number))

# Writing LDA results
# ===================
fwrite(word_vectors_to_write, 'result/fec_word_vectors_for_each_topic.csv')
fwrite(doc_topic_dist_to_write, 'result/fec_doc_topic_probabilities.csv')


# Create visualization
# ====================
lda_model$plot(out.dir = "result/fec_ldavis", 
               open.browser=FALSE, reorder.topics = FALSE)
