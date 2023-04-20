#' Lotka-Volterra Competition Model
#'
#' @param initial_conditions A vector of initial conditions for the model stating the initial population of species 1 and species 2.
#' @param parameters A vector of parameters for the model stating the intrinsic growth rate of species 1 (r1), the intrinsic growth rate of species 2 (r2), the carrying capacity of species 1 (K1), the carrying capacity of species 2 (K2), the competition coefficient of species 1 (alpha), and the competition coefficient of species 2 (beta).
#' @param time A vector of time points to solve the model at
#' @return A data frame with the time points and the population of species 1 and species 2 at each time point.
#' @importFrom deSolve ode
#' @export
#'
#' @examples
#' initial_conditions <- c(x1 = 50, x2 = 30)
#' parameters <- c(r1 = 0.1, r2 = 0.1, K1 = 100, K2 = 200, alpha = 0.5, beta = 0.7)
#' time <- seq(0, 100, by = 0.1)
#' results_df <- lotka_volterra_competition(initial_conditions, parameters, time)

lotka_volterra_competition <- function(initial_conditions, parameters, time) {
    competition_model <- function(time, state, parameters) {
        # Initial state variables
        x1 <- state[1] # Species 1
        x2 <- state[2] # Species 2

        # Parameters
        r1 <- parameters["r1"] # Intrinsic growth rate of species 1
        r2 <- parameters["r2"] # Intrinsic growth rate of species 2
        K1 <- parameters["K1"] # Carrying capacity of species 1
        K2 <- parameters["K2"] # Carrying capacity of species 2
        alpha <- parameters["alpha"] # Competition coefficient of species 1
        beta <- parameters["beta"] # Competition coefficient of species 2

        # Differential equations
        dx1 <- r1 * x1 * (1 - (x1 + alpha * x2) / K1)
        dx2 <- r2 * x2 * (1 - (x2 + beta * x1) / K2)

        # Return results
        return(list(c(dx1, dx2)))
    }
    #Solve the ODEs
    results <- deSolve::ode(y = initial_conditions, times = time, func = competition_model, parms = parameters)

    #Convert the output to a data frame
    results_df <- as.data.frame(results)
    colnames(results_df) <- c("time", "species_1", "species_2")

    return(results_df)
}