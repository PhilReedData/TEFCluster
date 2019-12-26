# Investigating further text analysis of TEF2 statements 
Exploring the Teaching Excellence Framework (TEF) 2017 submissions 
using topic modelling to look for language differences between awards. 
Work for PGCert assignment 2019-20. 

### Contents
1. [Introduction](#1-introduction)
2. [Method](#2-method)
3. [Analysis](#3-analysis)
4. [Conclusions](#4-conclusions)
5. [References](#5-references)
6. [Directory structure](#6-directory-structure)


### Live interactive visualisations
- See the [🇬🇧whole visualisation](result/LDA_plot.html)
- See breakdown by award:
  [🥇gold visualisation](result/LDA_plot_gold.html), 
  [🥈silver visualisation](result/LDA_plot_silver.html) and 
  [🥉bronze visualisation](result/LDA_plot_bronze.html)
- See breakdown by level: [🏨HEI visualisation](result/LDA_plot_hei.html) and
  [🏫FEC visualisation](result/LDA_plot_fec.html)

## 1. Introduction

The Teaching Excellence Framework (TEF) is a major policy initiative in higher 
education. [Moore, Higham, Sanders et al. (2017)](#5-references) 
explain how the submissions made
by providers in the TEF Year Two (TEF2) process provided a 
detailed source of evidence for excellence in teaching and impact evaluation 
practice. The Higher Education Academy (HEA) commissioned a research team to 
devise and undertake a data mining process on the text content of each 
submission. The results provided an initial guidance of a gold, silver or 
bronze award, some of which were adjusted by a panel before deciding a final 
outcome ([Kernohan (2017)](#5-references)).

There are further data mining techniques and visualisation tools which
can be used to study the submission texts in the following ways:

 1. To look at what UK education institutions are saying as a whole.
 2. To compare statements of institutions by the award they were given.
 3. To compare statements of higher and further education levels.

These findings may be able to assist or guide future work. The R programming 
language has been used to prepare and analyse the data files.

## 2. Method

The TEF2 statement texts and award data were downloaded from
the [Office for Students](#5-references) website.
These data files are available in CSV and/or Excel format. 
The statements are available in PDF format. 
Work was required to convert and interpret files using R.

LDA (Latent Direchlet Allocation) is a topic modelling technique that has been 
used to analyse the statements. It has been applied in previous work
by [Poon, Goloshchapova et al. (2018)](#5-references). 
The statements (documents) are taken through a series of pre-processing steps 
including stemming and removing stop-words, then the LDA process 
('_text2vec_') is applied. The pre-processing could be further improved 
after running the LDA process the first time by customising the list of 
stop-words or by tokenising instead of stemming.

The LDA process aims to identify topics that are covered in one or more 
documents by looking at the frequency and co-occurence of words. A 
hyper-parameter for this model, 'number of latent topics', was set to 50.

Two output matrices are produced:

 - A list of 50 keywords for each of the topics selected.
 - The probability of relevance of each topic in each document.

The six most likely keywords are shown in the analyses below. These lists are 
useful for identifying garbage terms, some of which could be removed if re-running 
the process. The identified topics may include terms which a human can identify 
as being related to the same real topic. 

The '_LDAvis_' software is used to visualise the topics, list which terms have 
been identified, and map how the topics relate to each other.
(Topics with more terms in common appear in close proximity on the intertopic 
distance maps).
Interpreting the _LDAvis_ output can help to further refine the LDA process.

After running the LDA process on the whole set of documents, it was repeated 
with subsets for each of the gold, silver and bronze awarded institutions, 
with a visualisation for each. 
It was also repeated with subsets for higher and further education institutions.

## 3. Analysis

### Most salient terms
These terms are most important within the identified topics. 
Note that all terms have been stemmed (the ends of words are removed so that 
'support', 'supporting' and 'supported' are treated the same, for example).

|Rank|	🇬🇧Whole |🥇Gold	|🥈Silver|🥉Bronze|🏨HEI | 🏫 FEC |
|---:|--------|-------|-------|------|----|-----|
|1	|student	|student|	student|	student|univers|colleg |
|2|	univers|	univers|	univers	|colleg|student|student |
|3	|colleg	|teach	|colleg|	univers|teach |learn |
|4	|learn	|colleg	|learn|	teach|learn|educ |
|5	|support	|learn	|teach	|progamm|employ |support |
|6  |teach   |support | support|support|support|higher|

### Most frequent terms

These terms are most frequent, regardless of topics.

|Rank|	🇬🇧Whole |🥇Gold	|🥈Silver|🥉Bronze|🏨HEI | 🏫FEC |
|---:|--------|-------|-------|------|----|-----|
|1	|student	|student	|student	|student| student|  student|
|2	|univers	|univers	|learn	|learn|univers| colleg|
|3	|learn	|support	|univers	|colleg|learn | support|
|4	|support	|teach	|develop	|support|support | learn|
|5	|teach	|learn	|teach	|develop| teach | develop|
|6  |colleg  |provid  |employ   |univers|develop|staff|

- All institutions talk about students more than anything else.
- HEI institutions talk about universities, while LEC institutions talk about colleges, as one might expect (although this could be when they mention their own name)
- HEI institutions talk more about employment/employability and teaching than FEC.
- All institutions talk about teaching and/or learning a lot.
- Gold and bronze institutions talk a lot about support.
- In a brief comparison with the study of corporate social responsibility in Poon et al. (2018), the topics identified in TEF2 overlap more; the same terms appear more often in multiple topics. This could mean that TEF2 submissions use a lot of the same language as each other. Further refinement of the LDA process is required to make that claim with confidence.

### Major topics
These are the six most salient terms from each of the five widest distributed
topics for each study (the largest circles in the visualisation). 

- The tables are excerpts from the `*_word_vectors_for_each_topic.csv` files.
- The charts are intertopic distance maps where each circle is a topic and
topic 1 is coloured red. Topics with similar terms appear close on the chart.
- See the visualisations for each study for interactive maps and tables with percentages.

#### 🇬🇧Whole
See the [🇬🇧whole visualisation](result/LDA_plot.html)

|Topic 1 | Topic 2 | Topic 3 | Topic 4 | Topic 5 |
|--------|---------|---------|---------|---------|
|support |teach    |work     |learn    |univers|
|student |learn    |research |employ   |student|
|learn   |student  |graduat  |support  |teach|
|develop |success  |learn    |teach    |undergradu|
|includ  |experi   |employ   |skill    |studi|
|feedback|demonstr |practic  |profession|academ|

![whole intertopic distance map](result/maps/map1_whole.png)

- Much overlap between topics.
- Would need to look further at all 50 topics to find ones that are clearer.

#### 🥇Gold
See the [🥇gold visualisation](result/LDA_plot_gold.html)

|Topic 1 | Topic 2 | Topic 3 | Topic 4 | Topic 5 |
|--------|---------|---------|---------|---------|
|student |univers  |student  |practic  |well |
|support |teach    |academ   |staff    |first |
|improv  |student  |support  |learn    |year |
|research|learn    |also     |feedback |provid |
|inform  |studi    |use      |includ   |three |
|data    |subject  |person   |programm |take |

![gold intertopic distance map](result/maps/map2_gold.png)


#### 🥈Silver
See the  [🥈silver visualisation](result/LDA_plot_silver.html) 

|Topic 1 | Topic 2 | Topic 3 | Topic 4 | Topic 5 |
|--------|---------|---------|---------|---------|
|develop |learn    |student  |student  |colleg   |
|learn   |develop  |provid   |metric   |student |
|teach   |programm |programm |tef      |part    |
|profession|student|feedback |employ   |progress|
|staff   |support  |learn    |data     |work    |
|practic |staff    |access   |assess   |area    |

![silver intertopic distance map](result/maps/map3_silver.png)

#### 🥉Bronze
See the   [🥉bronze visualisation](result/LDA_plot_bronze.html)

|Topic 1 | Topic 2 | Topic 3 | Topic 4 | Topic 5 |
|--------|---------|---------|---------|---------|
|employ  |student  |student  |colleg   |learn|
|work    |learn    |staff    |higher   |ukprn|
|skill   |develop  |develop  |provis   |can|
|feedback|project  |support  |develop  |name|
|use     |support  |higher   |learn    |event|
|student |research |innov    |degree   |offer|

![bronze intertopic distance map](result/maps/map4_bronze.png)

- No particular differences between gold, silver and bronze awarded institutions.

#### 🏨HEI
See the [🏨HEI visualisation](result/LDA_plot_hei.html) 

|Topic 1 | Topic 2 | Topic 3 | Topic 4 | Topic 5 |
|--------|---------|---------|---------|---------|
|student |learn    |univers  |develop  |support |
|feedback|develop  |student  |learn    |employ |
|academ  |work     |employ   |research |teach |
|offer   |experi   |studi    |staff    |sector |
|work    |profession|enhanc  |institut |improv | 
|librari |staff    |engag    |provid   |work |

![HEI intertopic distance map](result/maps/map5_hei.png)

#### 🏫FEC
See the   [🏫FEC visualisation](result/LDA_plot_fec.html)

|Topic 1 | Topic 2 | Topic 3 | Topic 4 | Topic 5 |
|--------|---------|---------|---------|---------|
|student |student  |colleg   |employ   |student|
|support |develop  |educ     |higher   |within|
|skill   |learn    |learn    |progress |engag|
|use     |support  |work     |programm |academ|
|cours   |skill    |provis   |student  |develop|
|develop |work     |curriculum|ensur   |support|

![FEC intertopic distance map](result/maps/map6_fec.png)

## 4. Conclusions

- LDA analysis can help to further understand the results as a whole.
- We can be reassured that the process confirms the most obvious expectations (the main focus is students, teaching and learning).
- We can begin to identify topics but there is much overlap.
- So far, there are no outstanding differences between gold, silver and bronze awarded institutions.
- More work is required to refine the process; it might work better if the data set was larger or if the pre-processing was customised further. The code could be further optimised.
- We could extend to look at multiple years of submissions.

## 5. References

Moore, J, Higham, L, Sanders, J, Jones, S, Candarli, D, Mountford-Zimdars, A 2017, 
'[Evidencing teaching excellence: Analysis of the TEF2 provider 
submissions](https://s3.eu-west-2.amazonaws.com/assets.creode.advancehe-document-manager/documents/hea/private/hub/download/TEF2%20Provider%20Submissions%20Review_2_1568037563.pdf)', _Higher Education Academy_.

Office for Students 2019, 
[TEF data](https://www.officeforstudents.org.uk/advice-and-guidance/teaching/tef-data/get-the-data/), 
_Office for Students_. 

Poon, S-H, Goloshchapova, I, Pritchard, M & Reed, P 2018, 
'[Corporate Social Responsibility Reports: Topic Analysis and Big Data 
Approach](https://www.doi.org/10.1080/1351847X.2019.1572637)',
_European Journal of Finance_.

Kernohan, D 2017, 
'[TEF results - Who moved up and who fell down?](https://wonkhe.com/blogs/tef-results-who-moved-up-and-who-fell-down/)',
_Wonkhe_.

## 6. Directory structure
`data/`

- `raw/` (excluded from version control)
    - `tef_y2_allcontext.csv` contextual data
    - `tef_y2_allmetrics.csv` all the metrics
    - `tefyeartwo_awards.xlsx` all the outcomes/awards
    - `TEFYearTwo_AllSubmissions/` folder
        - 232 files with names such as:
        - `10000055_Abingdon and Witney College_Submission.pdf`
        - `PROVIDER_TEFUKPRN` underscore `PROVIDER_NAME` underscore `.pdf`
    - `TEFYearTwo_AllSubmissions_txt/` folder
        - We convert all the PDF documents to TXT files.
- `processed/`
    - `tdm.rds` text document matrix data for the whole (may use later)
    - `gold_tdm.rds` text document matrix data for the gold awards
    - `silver_tdm.rds` text document matrix data for the silver
    - `bronze_tdm.rds` text document matrix data for the bronze
    - `hei_tdm.rds` text document matrix data for higher education
    - `fec_tdm.rds` text document matrix data for further education 

`code/` 

- `convert_pdf2txt.R` Convert directory in one go from PDF to txt
- `text2vec_whole.R` Perform LDA (column for award) and create visualization
- `text2vec_gold.R` Just gold awarded institutions (run after 'whole')
- `text2vec_silver.R` Just silver awarded institutions (run after 'whole')
- `text2vec_bronze.R` Just bronze awarded institutions (run after 'whole')
- `text2vec_hei.R` Just 'HigherEducationInstitution' (run after 'whole')
- `text2vec_fec.R` Just 'FurtherEducationCollege' (run after 'whole')

`result/`

- `LDA_plot.Rmd` The knitR file to launch the visualization
- [`LDA_plot.html`](result/LDA_plot.html) The knitted visualization
- `whole_doc_topic_probabilities.csv` Probability of each topic in each doc
- `whole_word_vectors_for_each_topic.csv` Which words occur in which topics
- `ldavis/` folder
   - The HTML, CSS and JavaScript files for the `LDA_plot.html` file
- `LDA_plot_gold.Rmd`
- [`LDA_plot_gold.html`](result/LDA_plot_gold.html) 
- `gold_doc_topic_probabilities.csv`
- `gold_word_vectors_for_each_topic.csv`
- `gold_ldavis/` folder
- `LDA_plot_silver.Rmd`
- [`LDA_plot_silver.html`](result/LDA_plot_silver.html) 
- `silver_doc_topic_probabilities.csv`
- `silver_word_vectors_for_each_topic.csv`
- `silver_ldavis/` folder
- `LDA_plot_bronze.Rmd`
- [`LDA_plot_bronze.html`](result/LDA_plot_bronze.html) 
- `bronze_doc_topic_probabilities.csv`
- `bronze_word_vectors_for_each_topic.csv`
- `bronze_ldavis/` folder
- `LDA_plot_hei.Rmd`
- [`LDA_plot_hei.html`](result/LDA_plot_hei.html) 
- `hei_doc_topic_probabilities.csv`
- `hei_word_vectors_for_each_topic.csv`
- `hei_ldavis/` folder
- `LDA_plot_fec.Rmd`
- [`LDA_plot_rec.html`](result/LDA_plot_fec.html) 
- `fec_doc_topic_probabilities.csv`
- `fec_word_vectors_for_each_topic.csv`
- `fec_ldavis/` folder
- `maps/` folder
   - `map1_whole.png` Intertopic distance map for whole
   - `map2_gold.png` Intertopic distance map for gold
   - `map3_silver.png` Intertopic distance map for silver
   - `map4_bronze.png` Intertopic distance map for bronze
   - `map5_hei.png` Intertopic distance map for HEI
   - `map6_fec.png` Intertopic distance map for FEC
