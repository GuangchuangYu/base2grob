##' convert base plot to grob object
##'
##'
##' @title base2grob
##' @param x expression or formula of base plot function call, e.g. expression(pie(1:5)) or ~plot(1:10, 1:10);
##' or a function that plots to an R graphics device when called, e.g. function() plot(sqrt)
##' @return grob object
##' @importFrom gridGraphics grid.echo
##' @importFrom grid grid.grabExpr
##' @export
##' @examples
##' base2grob(~plot(rnorm(10)))
##' @author Guangchuang Yu
base2grob <- function(x) {
    old.par=par(no.readonly=TRUE)
    on.exit(suppressWarnings(par(old.par, no.readonly=TRUE)))

    grid.grabExpr(grid.echo(base_plot_fun(x)))
}




