% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/powoGenera.R
\name{powoGenera}
\alias{powoGenera}
\title{Extract list of genera from POWO}
\usage{
powoGenera(family, genus = NULL, country = NULL,
           verbose = TRUE, save = FALSE, dir, filename)
}
\arguments{
\item{family}{Either one family name or a vector of multiple families that
is present in POWO.}

\item{genus}{Either one genus name or a vector of multiple genera
that are present in POWO. If any genus name is not provided, then the
function will search all accepted genera known for the target family.}

\item{country}{Either one country name or a vector of multiple countries.
If country names are provided, then the function will return only the genera
that are native to such countries, according to POWO.}

\item{verbose}{Logical, if \code{FALSE}, the searched results will not be
printed in the console in full.}

\item{save}{Logical, if \code{FALSE}, the searched results will not be saved
on disk.}

\item{dir}{Pathway to the computer's directory, where the file will be saved
provided that the argument \code{save} is set up in \code{TRUE}. The default
is to create a directory named \strong{results_powoGenera} and the searched
results will be saved within a subfolder named by the current date.}

\item{filename}{Name of the output file to be saved. The default is to
create a file entitled \strong{output}.}
}
\value{
Table in .csv format.
}
\description{
Produces a CSV file listing all genera with associated number
of accepted species and geographical distribution for any angiosperm
family at
\href{https://powo.science.kew.org/}{Plants of the World Online (POWO)}.
}
\examples{
\donttest{
library(expowo)

powoGenera(family = "Lecythidaceae",
           verbose = TRUE,
           save = FALSE,
           dir = "results_powoGenera/",
           filename = "Lecythidaceae_genera")

powoGenera(family = "Lecythidaceae",
           genus = "Bertholletia",
           country = c("Argentina", "Brazil", "French Guiana"),
           verbose = TRUE,
           save = FALSE,
           dir = "results_powoGenera/",
           filename = "Lecythidaceae_search")
}

}
\seealso{
\code{\link{megaGen}}

\code{\link{topGen}}

\code{\link{powoSpecies}}

\code{\link{powoFam}}

\code{\link{POWOcodes}}
}
\author{
Debora Zuanny & Domingos Cardoso
}
