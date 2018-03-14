##' convert base plot to grob object
##'
##'
##' @title base2grob
##' @param x expression or formula of base plot function call. e.g. expression(pie(1:5)) or ~plot(1:10, 1:10)
##' @return grob object
##' @importFrom gridGraphics grid.echo
##' @importFrom grid grid.grabExpr
##' @importFrom grid grid.draw
##' @export
##' @examples
##' base2grob(~plot(rnorm(10)))
##' @author Guangchuang Yu
base2grob <- function(x) {
    if (!inherits(x, "expression") && !inherits(x, "formula")) {
        stop("input should be expression or formula of base plot function call")
    }
    old.par=par(no.readonly=TRUE)
    on.exit(suppressWarnings(par(old.par, no.readonly=TRUE)))

    plot_fun <- function() grid.draw(x)
    grob <- grid.grabExpr(grid.echo(plot_fun))
    
    invisible(grob)
}


##' @importFrom grid grid.draw
##' @method grid.draw expression
##' @export
grid.draw.expression <- function(x, recording = TRUE) {

    ## taken from cowplot vignette
    par(xpd = NA, # switch off clipping, necessary to always see axis labels
        bg = "transparent", # switch off background to avoid obscuring adjacent plots
        oma = c(2, 2, 0, 0), # move plot to the right and up
        mgp = c(2, 1, 0) # move axis labels closer to axis
        )

    eval(x)
}

##' @method grid.draw formula
##' @export
grid.draw.formula <- function(x, recording = TRUE) {
    xx = as.character(x)[2]
    grid.draw.expression(parse(text=xx))
}

