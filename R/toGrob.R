##' convert base plot to grob object
##'
##'
##' @title base2grob
##' @param x expression or formula of base plot function call, e.g. expression(pie(1:5)) or ~plot(1:10, 1:10);
##' or a function that plots to an R graphics device when called, e.g. function() plot(sqrt)
##' @return grob object
##' @importFrom gridGraphics grid.echo
##' @importFrom grid grid.grabExpr
##' @importFrom grid grid.draw
##' @export
##' @examples
##' base2grob(~plot(rnorm(10)))
##' @author Guangchuang Yu
base2grob <- function(x) {
    old.par=par(no.readonly=TRUE)
    on.exit(suppressWarnings(par(old.par, no.readonly=TRUE)))

    grid.grabExpr(grid.echo(base_plot_fun(x)))
}



##' @importFrom grid grid.draw
##' @method grid.draw expression
##' @export
grid.draw.expression <- function(x, recording = TRUE) {
    old.par=par(no.readonly=TRUE)
    on.exit(suppressWarnings(par(old.par, no.readonly=TRUE)))

    base_plot_fun(x)()
}

##' @method grid.draw formula
##' @export
grid.draw.formula <- grid.draw.expression


##' @method grid.draw function
##' @export
grid.draw.function <- grid.draw.expression

base_plot_fun <- function(x) {
    if (!inherits(x, "expression") &&
        !inherits(x, "formula")    &&
        !inherits(x, "function")) {

        stop('Argument needs to be of class "expression", "formula", ',
           'or a function that plots to an R graphics device when called, ',
           'but is a ', class(x))
    }

    if (inherits(x, "formula")) {
        ## convert to expression
        x <- parse(text=as.character(x)[2])
    }

    function() {
        set_par()
        if (inherits(x, "function"))
            return(x())
        eval(x)
    }
}

##' @importFrom graphics par
##' @importFrom grDevices dev.list
##' @importFrom grDevices dev.new
##' @importFrom grDevices dev.off
set_par <- function() {
    if (is.null(dev.list())) {
        dev.new()
        on.exit(dev.off())
    }

    ## https://github.com/wilkelab/cowplot/issues/69#issuecomment-318866413
    par(xpd = NA, # switch off clipping, necessary to always see axis labels
        bg = "transparent", # switch off background to avoid obscuring adjacent plots
        oma = c(2, 2, 0, 0), # move plot to the right and up
        mgp = c(2, 1, 0) # move axis labels closer to axis
        )
}
