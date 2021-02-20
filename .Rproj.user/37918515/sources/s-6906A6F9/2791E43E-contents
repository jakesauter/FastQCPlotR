#' Function for plotting Per Base Sequencing Quality from FastQC
#'
#' This functions plots the values provided from the \link{reading_in} function.
#'
#'
#' @importFrom ggplot2 ggplot geom_point facet_wrap
#' @importFrom magrittr `%>%`
#' @importFrom dplyr ensym
#'
#' @param df Dataframe as shown in the vignette.
#'
#' @param yaxis ggplot2 compatible symbol relating to a column in df. Passed
#'   to geom_point to plot the y-axis variable.
#'
#' @param color ggplot2 compatible symbol relating to a column in df. Passed
#'   to geom_point to the color parameter.
#'
#' @param facet_by ggplot2 compatible symbol relating to a column in df. Passed
#'   to facet_wrap.
#'
#' @return ggplot plot of the data (invisibly).
#'
#' @examples
#' fastqc_plotr_sample_df %>%
#'    plot_per_base_seq_qual()
#'
#'
#' @export
plot_per_base_seq_qual <- function(df,
                                   yaxis=NULL,
                                   color=NULL,
                                   facet_by=NULL) {

  yaxis <- if (base::missing(yaxis)) sym("Mean") else  enquo(yaxis)
  color <- if (base::missing(color)) sym("sample_name") else  enquo(color)
  facet_by <- if (base::missing(facet_by)) sym("sample_group") else  enquo(facet_by)


  p <- df %>%
    ggplot() +
    geom_point(aes(x = Base,
                   y = !!yaxis,
                   color = !!color)) +
  facet_wrap(vars(!!facet_by))

  plot(p)

  invisible(p)
}





