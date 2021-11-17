#' Summary Statistics for a Numeric Column in a Dataframe
#'
#' This function takes in a dataframe and a numerical column in that dataframe and outputs a data.frame of summary statistics (mean, median, max, min, standard deviation, and count), as well as a histogram of that column's distribution with a vertical line representing the mean.
#' @param data The data.frame to be inputted. This is named `data` because it describes what the first argument should be — a data.frame.
#' @param col The numerical column to be used for calculating summary statistics. This is named `col` because it describes what the second argument should be — a column.
#' @return A data.frame of summary statistics (mean, median, max, min, standard deviation, and count), as well as a histogram.
#' @examples
#' summary_stats_column(mtcars,hp)
#' summary_stats_column(mtcars, mpg)
#' @importFrom magrittr "%>%"
#' @export

summary_stats_column <- function(data, col) {
  calculations <- dplyr::summarise(data,
                                   is_numeric = is.numeric({{col}}),
                                   class = class({{col}}))
  if(!calculations$is_numeric){
    stop("Selected column is not numeric. Column is: ", calculations$class)
  }

  summary_table <- data %>%
    dplyr::summarise(mean = mean({{col}}, na.rm = TRUE),
                     median = median({{col}}, na.rm = TRUE),
                     max = max({{col}}, na.rm = TRUE),
                     min = min({{col}}, na.rm = TRUE),
                     st_dev = sd({{col}}, na.rm = TRUE),
                     count = dplyr::n())

  summary_plot <- ggplot2::ggplot(data) +
    ggplot2::geom_histogram(ggplot2::aes({{col}}),
                   bins = 30) +
    ggplot2::geom_vline(ggplot2::aes(xintercept = mean({{col}})),
               linetype = "dashed", size = 0.6)

  output <- list(summary_table, summary_plot)
  return(output)
}
