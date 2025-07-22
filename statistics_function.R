
# functions for statistics

descriptive_stats <- function(data, columns) {
  # Ensure input columns exist
  missing_cols <- setdiff(columns, names(data))
  if (length(missing_cols) > 0) {
    stop(paste("Columns not found:", paste(missing_cols, collapse = ", ")))
  }
  
  # Initialize result list
  results <- list()
  
  for (col in columns) {
    col_data <- data[[col]]
    
    if (!is.numeric(col_data)) {
      warning(paste("Skipping non-numeric column:", col))
      next
    }
    
    stats <- list(
      Mean = mean(col_data, na.rm = TRUE),
      Median = median(col_data, na.rm = TRUE),
      SD = sd(col_data, na.rm = TRUE),
      Min = min(col_data, na.rm = TRUE),
      Max = max(col_data, na.rm = TRUE),
      N = sum(!is.na(col_data)),
      NA_Count = sum(is.na(col_data))
    )
    
    results[[col]] <- stats
  }
  
  return(results)
}
