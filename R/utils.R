

#' ModelControl
#' Utility function to check the classification model object
#'
#' @param model  random forest classification model. Must be FMDV_model. See [FMDV_model].
#'
#' @return warnings
#'
#' @export
#'
#' @examples
#' ModelControl(FMDV_model)
ModelControl<- function(model){

  if (is.null(model)){
    stop("Model argument must be indicated and cannot be null.Try model=FMDV_model")
  }

  if (methods::is(model)!="ranger"){
    stop("Model must be a ranger object. Try model=FMDV_model")
  }

  if (!"info" %in% names(model)){
    stop("Model must include the info object. Try model=FMDV_model")
  }
  if (!"date" %in% names(model)){
    stop("Model must include the date object. Try model=FMDV_model")
  }


}


#' Ignore unused imports
#'
#' @return nothing
#'
#'
ignore_unused_imports <- function() {
  # elminate NOTE y R CMD CHECK as suggested in https://r-pkgs.org/dependencies-in-practice.html
  DT::dataTableOutput
  bslib::bootstrap
  shinyWidgets::actionGroupButtons
  shinyjs::click
  tibble::add_row
  rmarkdown::clean_site
  }
