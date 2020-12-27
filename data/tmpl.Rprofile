# ~/.Rprofile
local({
	# set default mirror
	r = getOption("repos")
	r["CRAN"] = "https://cloud.r-project.org"
	options(repos = r)
})

# set locale (if not available or want to switch)
# Sys.setenv(LANGUAGE = "it")
# Sys.setenv(LANGUAGE = "de")
# Sys.setenv(LANGUAGE = "fr")
# Sys.setenv(LANGUAGE = "es")

# set prompt
#options(prompt = "RVE> ")

# set number of digits
options(digits = 4)

# set signif.stars
options(show.signif.starts = TRUE)

# set default for strings
#options(stringAsFactors = TRUE)

#.First <- function() {
# message("Welcome ", Sys.getenv("USER"))	
#}

# 
# show the loaded libraries/packages
#
loaded.packages <- function() {
  (.packages())	
}

#
# detach a library previously loaded
#
unlibrary <- function(pkg, character.only = FALSE) {
  if(!character.only)
  {
    pkg <- deparse(substitute(pkg))
  }
  search_item <- paste("package", pkg, sep = ":")
  while(search_item %in% search())
  {
    detach(search_item, unload = TRUE, character.only = TRUE)
  }
}
