#' Function for parsing the text output of FastQC
#'
#' This functions extracts the values for a specific test run by FastQC on a
#' single fastq file.
#'
#' @importFrom data.table fread
#' @importFrom magrittr `%>%`
#'
#' @param file string that specifies the path to an individual FastQC result file
#' (tyically named "fastqc_data.txt"
#'
#' @param test Indicate which test results should be extracted. Default:
#' "Per base sequence quality". Other options are, for example, "Per tile sequence quality",
#' "Per sequence quality score" etc.
#'
#' @param sample_name adds an additional column to the resulting data frame
#' containing a user-specified sample name (e.g. “WT_1_ERR458493”)
#'
#' @return data.frame with the values of a single FastQC test result.
#'
#' @examples \dontrun{
#' res <- reading_in(file = "acinar-3_S9_L001_R1_001_fastqc/fastqc_data.txt")
#' }
#'
#' @export
reading_in <- function(file,
                       test = "Per base sequence quality",
                       sample_name = NULL){

  ## generate the string that will be used for the file parsing
  syscommand <- paste0("sed -n '/", test, "/,/END_MODULE/p' ", file, " | grep -v '^>>'")

  ## use the fread command, which can interpret UNIX commands on the fly to
  ## read in the correct portion of the FastQC result
  df <-
    data.table::fread(
      cmd = syscommand,
      header = TRUE) %>%
    as.data.frame() %>%
    rename(Base = `#Base`)


  if (!is.null(sample_name) && is.character(sample_name)) {
     df <- cbind(df, sample_name)
  } else if (!is.character(sample_name)) {
    message(paste('sample_name parameter must be a character vector!'),
                  ' sample_name will not be included!')
  }

  return(df)
}


#' Packages used to the vignette
#'
#' @import ggplot2 dplyr knitr
vignette_fun <- function() {
  "Packages used in vignettes"
}





