# ============================================================
# species_traits()
# Merge species list (or all species in an ausplots object)
# with a trait table supplied by the user
# ============================================================

species_traits <- function(species_list = NULL,
                           ausplots = NULL,
                           trait_table,
                           species_name = c("SN", "HD")) {
  
  species_name <- match.arg(species_name)
  
  # -----------------------------
  # 1. checks
  # -----------------------------
  if (missing(trait_table)) {
    stop("Please provide a trait_table.")
  }
  
  if (!is.data.frame(trait_table)) {
    stop("trait_table must be a data.frame.")
  }
  
  if (!"species_name" %in% names(trait_table)) {
    stop("trait_table must contain a column called 'species_name'.")
  }
  
  if (is.null(species_list) & is.null(ausplots)) {
    stop("Provide either species_list or ausplots.")
  }
  
  if (!is.null(species_list) & !is.null(ausplots)) {
    stop("Provide only one of species_list OR ausplots.")
  }
  
  # -----------------------------
  # 2. get species list
  # -----------------------------
  
  if (!is.null(species_list)) {
    
    species_df <- data.frame(
      species_name = unique(as.character(species_list)),
      stringsAsFactors = FALSE
    )
    
  } else {
    
    if (is.null(ausplots$veg.vouch)) {
      stop("ausplots$veg.vouchers is missing.")
    }
    
    species_column <- switch(
      species_name,
      SN = "standardised_name",
      HD = "herbarium_determination"
    )
    
    if (!species_column %in% names(ausplots$veg.vouch)) {
      stop("Column ", species_column, " not found in veg.vouchers.")
    }
    
    sp <- ausplots$veg.vouch[[species_column]]
    sp <- unique(sp[!is.na(sp)])
    
    species_df <- data.frame(
      species_name = sp,
      stringsAsFactors = FALSE
    )
    
  }
  
  # -----------------------------
  # 3. prepare trait table
  # -----------------------------
  
  trait_table$species_name <- as.character(trait_table$species_name)
  species_df$species_name <- as.character(species_df$species_name)
  
  trait_table <- trait_table[!duplicated(trait_table$species_name), ]
  
  # -----------------------------
  # 4. left join (keep all species)
  # -----------------------------
  
  output <- merge(
    species_df,
    trait_table,
    by = "species_name",
    all.x = TRUE,
    sort = FALSE
  )
  
  output <- output[match(species_df$species_name, output$species_name), ]
  
  rownames(output) <- NULL
  
  return(output)
}

