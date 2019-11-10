# TEFCluster
Explore the Teaching Excellence Framework (TEF) submissions using clustering and related techniques. Work by Phil Reed for PGCert assignment 2019-20. 

[Jump straight to visualisation](result/LDA_plot.html) _work in progress_

Uses [TEF data from Office for Students](https://www.officeforstudents.org.uk/advice-and-guidance/teaching/tef-data/get-the-data/).

## Method

Use LDA clustering technique as in <a href="https://www.research.manchester.ac.uk/portal/en/publications/corporate-social-responsibility-reports(111f0746-0250-4206-a4a9-300b5e39df59).html">previous work</a>.

Perform the text2vec process after cleaning the data, then 
create a visualisation of the topics.

## Directory structure
`data/`

- `raw/` (excluded from version control)
    - `tef_y2_allcontext.csv` 
    - `tef_y2_allmetrics.csv`
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

`code/` 

- `convert_pdf2txt.R` Convert directory in one go from PDF to txt
- ... (convert plural to singular for whole directory) _to do_
- `text2vec_whole.R` Perform LDA and create visualization
  - ...

`result/`

- `LDA_plot.Rmd` The knitR file to launch the visualization
- [`LDA_plot.html`](result/LDA_plot.html) The knitted visualization
- `whole_doc_topic_probabilities.csv` Probability of each topic in each doc
- `whole_word_vectors_for_each_topic.csv` Which words occur in which topics
- `ldavis/` folder
   - The HTML, CSS and JavaScript files for the `LDA_plot.html` file

## Next steps
- Further clean the data, manual work, maybe tokenize instead of stem.
- Identify what the major topics are and which ones used by which applicants.
- Consider the gold/silver/bronze award (perhaps three visualisations).
- Consider HE/FE and other splits.