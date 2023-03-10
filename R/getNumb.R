# Auxiliary function to get species number

getNumb <- function(df,
                    verbose = verbose) {

  l_uri <- length(df$powo_uri)
  # Creating empty lists to save data of interest during all search.
  list_spp <- list_html <- list_grepl <- vector("list", length = l_uri)

  for (i in seq_along(df$powo_uri)) {
    # The tryCatch function helps skipping error in for-loop.
    tryCatch({
      # Adding a pause 300 seconds of um pause every 500th search,
      # because POWO website cannot permit constant search.
      if (i %% 500 == 0) {
        Sys.sleep(300)
      }

      list_html[[i]] <- readLines(paste(df$powo_uri[i]), warn = F)
      # Adding a counter to identify each running search.
      tf <- df$powo_uri == df$powo_uri[i]
      if (verbose) {
        gen <- df$genus[tf]
        fam <- df$family[tf]
        print(paste0("Searching spp number of... ",
                     gen, " ",
                     fam, " ", i, "/",
                     length(list_spp)))
      }

      list_grepl[[i]] <- grepl(">Includes\\s", list_html[[i]])
      list_spp[[i]] <- gsub(".*>Includes\\s", "",
                            list_html[[i]][list_grepl[[i]]])
      list_spp[[i]] <- gsub("\\sAccepted.+", "",
                            list_spp[[i]][grepl("\\sAccepted\\s",
                                                list_spp[[i]])])

      # The function below will print any search error (e.g. site address of a
      # specific genus is not opening for some reason).
    }, error = function(e) {cat(paste("ERROR:", df$genus[tf], df$family[tf]),
                                conditionMessage(e), "\n")})
  }

  # Filling in with "NA" those genera for which the search failed to open the
  # POWO site.
  temp <- lapply(list_spp, is.null)
  list_spp[unlist(temp)] <- NA
  temp <- lapply(list_spp, function(x) length(x) == 0)
  list_spp[unlist(temp)] <- NA

  # Extracting the number of species from the list during the POWO searching.
  df$species_number <- unlist(list_spp, use.names = F)
  df$species_number <- as.numeric(df$species_number)

  return(df)
}
