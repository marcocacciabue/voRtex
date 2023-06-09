
#' Classify FMDV pipeline
#'
#' Wrapper function that performs all the recommended step. This includes
#' \describe{
#'   \item{Kcounter}{# Count Kmers and normalize data}
#'   \item{PredictionCaller}{Run prediction pipeline}
#'   \item{QualityControl}{Check Quality of the input data and classification results}
#'   \item{Quality_filter}{For sequences with any FLAG present set result Clade to LowQuality}
#' }
#'
#' @param inputFile string path relative to the working directory of the input file. Must be in fasta format.
#' @param outputFile string path relative to the working directory of the output file. Default = "results.csv"
#' @param write_result Logical. If True writes result as a .csv file. If false returns a data.frame.
#' @inheritParams QualityControl
#'
#'
#' @return a comma-delimited file or a data.frame
#' @export
#'
#' @examples
#'
#' \dontrun{
#' file_path<-system.file("extdata","KY404934.1.fasta",package="voRtex")
#'
#' ClassifyInfinity(inputFile=file_path,model=FMDV_model)
#' }
ClassifyInfinity<-function(inputFile,
                           outputFile="results.csv",
                           model,
                           QC_value=0.6,
                           Length_value=0.5,
                           N_value=2,
                           write_result=FALSE){

  sequence<-ape::read.FASTA(inputFile,type = "DNA")

  # Count Kmers and normalize data

  NormalizedData <- Kcounter(SequenceData=sequence,model=model)
  #  Run prediction pipeline

  PredictedData <- PredictionCaller(NormalizedData=NormalizedData,model=model)

  #  Check Quality of the input data and classification results
  PredictedData <- QualityControl(PredictedData,
                                  model=model,
                                  QC_value=QC_value,
                                  Length_value=Length_value,
                                  N_value=N_value)
  # For sequences with any FLAG present set result Clade to LowQuality

  PredictedData <- Quality_filter(PredictedData)

  if(write_result){
    utils::write.csv2(PredictedData,outputFile)
  }else{
    return(PredictedData)
  }

}
