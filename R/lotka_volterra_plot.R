#' Lotka-Volterra Competition Model Plot
#'
#' @param results_df A data frame with the time points and the population of species 1 and species 2 at each time point.
#' @return A plot of the Lotka-Volterra Competition Model.
#' @importFrom ggplot2 ggplot aes geom_line theme_minimal labs
#' @export
#'
#' @examples
#' \dontrun{
#' initial_conditions <- c(x1 = 50, x2 = 30)
#' parameters <- c(r1 = 0.1, r2 = 0.1, K1 = 100, K2 = 200, alpha = 0.5, beta = 0.7)
#' time <- seq(0, 100, by = 0.1)
#' results_df <- lotka_volterra_competition(initial_conditions, parameters, time)
#' lotka_volterra_plot(results_df)
#' }
lotka_volterra_plot <- function(results_df) {
  long_df <- reshape2::melt(results_df, id.vars = "time", variable.name = "species", value.name = "population")
  # Create the plot
  plot <- ggplot2::ggplot(data = long_df, ggplot2::aes(x = time, y = population, color = species)) +
    ggplot2::geom_line(size = 1) +
    ggplot2::theme_minimal() +
    ggplot2::labs(
      title = "Lotka-Volterra Competition Model",
      x = "Time",
      y = "Population",
      color = "Species"
    )
  return(plot)
}