# Convert pdfs in a folder to txt in another folder
library(pdftools)

convert_pdf2txt_dir <- function(pdf_dir, txt_dir) {
  # Create output dir, ignore warning if it already exists
  dir.create(file.path(txt_dir), showWarnings = FALSE)
  
  files <- list.files(pdf_dir, pattern = "\\.pdf$")
  for (i in 1:length(files)) {
    # Read text content of a PDF file
    txt <- pdf_text(file.path(pdf_dir, files[i]))
    # Save txt to new file
    new_name <- paste(tools::file_path_sans_ext(files[i]), ".txt", sep="")
    writeLines(txt, file.path(txt_dir, new_name))
  }
}


convert_pdf2txt_dir('data/raw/TEFYearTwo_AllSubmissions/',
                      'data/raw/TEFYearTwo_AllSubmissions_txt')
