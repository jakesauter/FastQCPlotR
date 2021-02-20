#' Dataframe of FastQC Per base sequence quality
#'
#' A data.frame of Results for Per base sequence quality
#' of 4 sequencing lanes.
#'
#' @format A data frame with 204 observations and 9 variables:
#' \describe{
#'   \item{Base}{Number of base read in sequncing cycle process.}
#'   \item{Mean}{Mean sequencing base quality.}
#'   \item{Median}{Median of sequencing base quality.}
#'   \item{Lower Quartile}{Lower Quartile of sequencing base quality.}
#'   \item{Upper Quartile}{Upper Quartile of sequencing base quality.}
#'   \item{10th Percentile}{10th Percentile of sequencing base quality.}
#'   \item{90th Percentile}{90th Percentile of sequencing base quality.}
#'   \item{sample_name}{Run accession number given to "sample_name" argument of reading_in.}
#'   \item{sample_group}{Sample group identifier used to plot data.}
#' }
#'
#' @export
"fastqc_plotr_sample_df"

