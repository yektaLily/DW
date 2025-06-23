files <- list.files(pattern = "\\.qmd$")
pkgs <- unique(unlist(
  lapply(files, function(f) {
    lines <- readLines(f)
    matches <- regmatches(lines, gregexpr("library\\(([^)]+)\\)|require\\(([^)]+)\\)", lines)) # nolint
    unlist(lapply(matches, function(x) gsub(".*\\(([^)]+)\\).*", "\\1", x)))
  })
))
cat("install.packages(c(\n  \"", paste(pkgs, collapse = "\",\n  \""), "\"\n))\n", sep = "") # nolint


