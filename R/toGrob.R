##' convert base plot to grob object
##'
##'
##' @title base2grob
##' @param x expression or formula of base plot function call. e.g. expression(pie(1:5)) or ~plot(1:10, 1:10)
##' @return grob object
##' @importFrom gridGraphics grid.echo
##' @importFrom grid grid.grab
##' @importFrom grid grid.draw
##' @export
##' @examples
##' base2grob(~plot(rnorm(10)))
##' @author Guangchuang Yu
base2grob <- function(x) {
    if (!inherits(x, "expression") && !inherits(x, "formula")) {
        stop("input should be expression or formula of base plot function call")
    }
    tmp <- grid.draw(x) ## base plot may return value via `invisible()`
    grid.echo()
    invisible(grid.grab())
}


##' @importFrom grid grid.draw
##' @method grid.draw expression
##' @export
grid.draw.expression <- function(x, recording = TRUE) {
    eval(x)
}

##' @method grid.draw formula
##' @export
grid.draw.formula <- function(x, recording = TRUE) {
    xx = as.character(x)[2]
    eval(parse(text=xx))
}

