FilePath <- system.file("extdata", "SRR12664421_full_coverage.bed",
                        package = "voRtex", mustWork = TRUE)

data <- read.table(FilePath, col.names = c("reference", "startpos", "endpos", "coverage"))


test_that("output format control", {
  output <- compute_coverage(data, windowsize = 50, logarize = TRUE)

  expect_s3_class(output, "data.frame")

  expect_identical(colnames(output), c("pos", "Coverage"))
})
