\name{species_traits}
\alias{species_traits}

\title{Merge species with gap-filled traits and photosynthetic pathways}

\description{
  This function merges a list of plant species, or all species present in an AusPlots dataset,
  with a static table of gap-filled plant traits and photosynthetic pathways.
  
  Species names can optionally be standardised using accepted names obtained through APCalign.
  Trait information is merged based on the species name. If a species is not present in the
  trait dataset, the corresponding trait fields are returned as NA.
}

\usage{
  species_traits(species_list = NULL,
                 ausplots = NULL,
                 trait_table,
                 species_name = c("SN", "HD"))
}

\arguments{
  
  \item{species_list}{
    A character vector containing species names to merge with the trait dataset.
    If provided, the function will return trait information only for these species.
  }
  
  \item{ausplots}{
    An AusPlots dataset generated using \code{\link{get_ausplots}}.
    If provided, all species present in \code{veg.vouchers} will be extracted and
    matched with the trait dataset.
  }
  
  \item{trait_table}{
    A dataframe containing gap-filled trait information for plant species.
    The dataframe must include a column called \code{species} that contains species names.
    Additional columns may include traits such as photosynthetic pathway, SLA, seed mass,
    or other functional traits.
  }
  
  \item{species_name}{
    Which species name field to extract from \code{veg.vouchers} when using an AusPlots dataset.
    
    Options include:
      \describe{
        \item{"SN"}{Standardised species name (default).}
        \item{"HD"}{Herbarium determination name.}
      }
  }
  
}

\details{
  
  This function facilitates the integration of species occurrence data from the
  AusPlots monitoring network with externally compiled trait datasets.
  
  Species names can originate from two sources:
    
    \itemize{
      
      \item A user-provided vector of species names.
      
      \item Species extracted from an AusPlots dataset using the
      \code{\link{get_ausplots}} function.
    }
  
  The function performs a left join between the species list and the provided
  trait dataset, ensuring that all species are retained in the output.
  
  Species that are not present in the trait dataset will still be returned,
  with missing trait values represented as NA.
  
  This behaviour allows users to identify species for which trait information
  is unavailable.
  
}

\value{
  
  Returns a dataframe containing species names and trait values of leaf length, leaf width, leaf area, leaf mass per area, maximum plant height, seed length and seed dry mass from the
  provided trait dataset.
  
  The output includes one row per species.
  
}

\references{
  
  Australian Plant Census (APC) and Australian Plant Name Index (APNI).
  
  AusPlots ecosystem surveillance monitoring dataset, Terrestrial Ecosystem
  Research Network (TERN).
  
}

\seealso{
  
  \code{\link{get_ausplots}}
  
  \code{\link{species_table}}
  
}

\author{
  Irene Martin-Fores
}

\examples{
  
  \dontrun{
    
    library(ausplotsR)
    
    ausplots_data <- get_ausplots(veg.vouchers = TRUE)
    
    traits <- read.csv("traits_gapfilled.csv")
    
    species_traits(
      ausplots = ausplots_data,
      trait_table = traits
    )
    
  }
  
}