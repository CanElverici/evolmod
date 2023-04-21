#' Lotka-Volterra Predator-Prey Model
#'
#' @param initial_conditions A vector of initial conditions for the model stating the initial population of prey (x) and predator (y).
#' @param parameters A vector of parameters for the model stating the prey growth rate (a), predator death rate (b), predator's efficiency at converting food to new predators (c), and the predator's rate of consumption of prey (d).
#' @param time A vector of time points to solve the model at
#' @return A data frame with the time points and the population of prey and predator at each time point.
#' @importFrom deSolve ode
#' @export
#'
#' @examples
#' initial_conditions <- c(x = 40, y = 9)
#' parameters <- c(a = 0.1, b = 0.02, c = 0.0005, d = 0.3)
#' time <- seq(0, 200, by = 0.1)
#' results_df <- lotka_volterra_preypredator(initial_conditions, parameters, time)

lotka_volterra_preypredator <- function(initial_conditions, parameters, time) {
  predator_prey_model <- function(time, state, parameters) {
    # State variables
    x <- state[1] # Prey
    y <- state[2] # Predator

    # Parameters
    a <- parameters["a"] # Prey growth rate
    b <- parameters["b"] # Predator death rate
    c <- parameters["c"] # Predator's efficiency at converting food to new predators
    d <- parameters["d"] # Predator's rate of consumption of prey

    # Differential equations
    dx <- a * x - c * x * y
    dy <- -b * y + d * x * y

    # Return results
    return(list(c(dx, dy)))
  }

  # Solve the ODEs
  results <- deSolve::ode(y = initial_conditions, times = time, func = predator_prey_model, parms = parameters)

  # Convert the output to a data frame
  results_df <- as.data.frame(results)
  colnames(results_df) <- c("time", "prey", "predator")

  return(results_df)
}
