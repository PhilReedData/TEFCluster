# Investigating further text analysis techniques with TEF2 statements 
Exploring the Teaching Excellence Framework (TEF) 2017 submissions 
using clustering and related techniques to make suggestions for 
future analysis. 
Work by Phil Reed for PGCert assignment 2019-20. 

### Contents
- [Introduction](#introduction)
- [Method](#method)
- [Analysis](#analysis)
- [Conclusions](#conclusions)
- [References](#references)
- [Directory structure](#directory-structure)
- [Next steps](#next-steps)


### Figures
- See the [🇬🇧whole visualisation](result/LDA_plot.html)
- See breakdown by award:
  [🥇gold visualisation](result/LDA_plot_gold.html), 
  [🥈silver visualisation](result/LDA_plot_silver.html) and 
  [🥉bronze visualisation](result/LDA_plot_bronze.html)
- See breakdown by level: [🏨HEI visualisation](result/LDA_plot_hei.html) and
  [🏫FEC visualisation](result/LDA_plot_fec.html)

## Introduction

An exploration of further analysis that could be used for TEF, following 
_Evidencing teaching excellence: Analysis of the TEF2 provider submissions_,
by Joanne Moore, Louise Higham and 
John Sanders (ARC Network), in partnership with Steven Jones, Duygy Candarli 
(University of Manchester) and Anna Mountford-Zimdars (University of Exeter).
[[1]](#references)

Uses _TEF data from Office for Students_. [[2]](#references)

## Method

Use LDA clustering technique as in <a href="https://www.research.manchester.ac.uk/portal/en/publications/corporate-social-responsibility-reports(111f0746-0250-4206-a4a9-300b5e39df59).html">previous work</a>.

Perform the text2vec process after cleaning the data, then 
create a visualisation of the topics that are automatically identified.

Analyse the results, look for trends.

## Analysis

### Most salient terms
These terms are most important within the identified topics.

|Rank|	🇬🇧Whole |🥇Gold	|🥈Silver|🥉Bronze|🏨HEI | 🏫 FEC |
|---:|--------|-------|-------|------|----|-----|
|1	|student	|student|	student|	student|univers|colleg |
|2|	univers|	univers|	univers	|colleg|student|student |
|3	|colleg	|teach	|colleg|	univers|teach |learn |
|4	|learn	|colleg	|learn|	teach|learn|educ |
|5	|support	|learn	|teach	|progamm|employ |support |

### Most frequent terms

These terms are most frequent, regardless of topics.

|Rank|	🇬🇧Whole |🥇Gold	|🥈Silver|🥉Bronze|🏨HEI | 🏫FEC |
|---:|--------|-------|-------|------|----|-----|
|1	|student	|student	|student	|student| student|  student|
|2	|univers	|univers	|learn	|learn|univers| colleg|
|3	|learn	|support	|univers	|colleg|learn | support|
|4	|support	|teach	|develop	|support|support | learn|
|5	|teach	|learn	|teach	|develop| teach | develop|

- All institutions talk about students more than anything else.
- HEI insitutions talk about universities, while LEC institutions talk about colleges, as one might expect (although this could be when they mention their own name)
- HEI institutions talk more about employment/employability and teaching than FEC.
- All institutions talk about teaching and/or learning a lot.
- Gold and bronze institutions talk a lot about support.

### Major topics
These are the six most salient terms from each of the five 'largest' topics
for each study. 

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

- Topics have been identified in ...
- Much overlap between topics.

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

## Conclusions

_to do_

- LDA analysis can help to further understand the results as a whole.
- Reassured that we can confirm expectations (main focus is students, teaching and learning).
- Begun to identify topics but there is much overlap.
- No outstanding differences between gold, silver and bronze awarded institutions.
- Requires more work to refine process, might work better if the data set was larger.
- Could extend to look at multiple years of submissions.

## References

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

## Directory structure
`data/`

- `raw/` (excluded from version control)
    - `tef_y2_allcontext.csv` 
    - `tef_y2_allmetrics.csv`
    - `tefyeartwo_awards.xlsx`
    - `TEFYearTwo_AllSubmissions/` folder
        - 232 files with names such as:
        - `10000055_Abingdon and Witney College_Submission.pdf`
        - `PROVIDER_TEFUKPRN` underscore `PROVIDER_NAME` underscore `.pdf`
    - `TEFYearTwo_AllSubmissions_txt/` folder
        - We convert all the PDF documents to TXT files.
    - (`TEFYearTwo_AllSubmissions_txt_pl2sin/` folder) _to do_
        - (We replace all plural words with the singular forms.) _to do_
- `processed/`
    - `tdm.rds` text document matrix data
    - `gold_tdm.rds`
    - `silver_tdm.rds`
    - `bronze_tdm.rds`
    - `hei_tdm.rds`
    - `fec_tdm.rds`

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
   
   

## Next steps
- Further clean the data, manual work, maybe tokenize instead of stem.
- Identify what the major topics are and which ones used by which applicants.
