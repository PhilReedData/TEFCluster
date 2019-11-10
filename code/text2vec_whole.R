#text2vec_whole.R

# Package installation
# ====================
##devtools::install_github('Rdatatable/data.table')
## ^ To use rbindtable(). On macOS may require: 
##https://www.r-bloggers.com/using-osx-compiling-an-r-package-from-source-issues-with-fopenmp-try-this/

#install.packages('data.table')
#install.packages('tm')
#devtools::install_github('dselivanov/text2vec')
#install.packages('SnowballC')

# Load libraries
# ==============
library(data.table)
library(tidyverse)
library(tm)
library(text2vec)
library(SnowballC)

# Reading files
# =============

#dir_input <- 'data/raw/TEFYearTwo_AllSubmissions_txt_pl2sin'
# Not written the plural to singular code or dir yet
dir_input <- 'data/raw/TEFYearTwo_AllSubmissions_txt'
files <- list.files(dir_input, full.names = TRUE, pattern = "\\.txt$")

# Load text content of files into list
text_list <- lapply(files, 
                    function(x) data.frame(
                      document_txt = paste(readLines(x), collapse = " ")))

# Form a data gram with all texts (Complex!)
## rbindlist() requires data.table package; may be able to use rbind() instead
textdf <- rbindlist(text_list) 
#textdf <- rbind(text_list) 
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

# stemming
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
saveRDS(dtm, 'data/processed/dtm.rds')


# LDA model
# =========
topics_number <- 100

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

# topics for each document
doc_topic_dist_to_write <- 
  data.frame(files = files) %>% 
  bind_cols(data.frame(doc_topic_dist))
names(doc_topic_dist_to_write) <- 
  c('file_name', paste0('topic_', 1:topics_number))

# Writing LDA results
# ===================
fwrite(word_vectors_to_write, 'result/whole_word_vectors_for_each_topic.csv')
fwrite(doc_topic_dist_to_write, 'result/whole_doc_topic_probabilities.csv')