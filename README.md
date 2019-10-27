# TEFCluster
Explore the Teaching Excellence Framework (TEF) submissions using clustering and related techniques.

Uses [TEF data from Office for Students](https://www.officeforstudents.org.uk/advice-and-guidance/teaching/tef-data/get-the-data/).

## Method

Use LDA clustering technique as in <a href="https://www.research.manchester.ac.uk/portal/en/publications/corporate-social-responsibility-reports(111f0746-0250-4206-a4a9-300b5e39df59).html">previous work</a>.

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
- `input/`
    - ...

`code/` 

  - `convert_pdf2txt` (convert directory in one go)
  - ...


