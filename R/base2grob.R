##' base2grob
##'
##' This package is deprecated. Please switch over to using [ggplotify].
##' @name base2grob
##' @docType package
##' @import ggplotify
NULL

##' @usage NULL
##' @rdname base2grob
##' @export
base2grob <- ggplotify::base2grob


##' @importFrom grid grid.draw
##' @method grid.draw expression
##' @export
grid.draw.expression <- getFromNamespace("grid.draw.expression", "ggplotify")

##' @method grid.draw formula
##' @export
grid.draw.formula <- grid.draw.expression

##' @method grid.draw function
##' @export
grid.draw.function <- grid.draw.expression



.onAttach <- function(...) {
    message <- "The base2grob package has been deprecated. Please switch over to the ggplotify package"

    packageStartupMessage(message)
}
