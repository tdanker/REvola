context("test_tool1")
test_that("we reproduce the original table at 1e-6 tolerance", {
  reproduced <- tool1_table(demand$'2014', availability$`2014`)
  reproduced$hour<-paste0("h", 1:nrow(reproduced))
  reproduced <- reproduced[,c(13,1:12)]
  reproduced[1,10]<-NA
  original.file<-system.file("extdata", "spreadsheet_tool_1.xlsm", package = "REvola")
  original <- readxl::read_xlsx(original.file, sheet = "tool", skip=16)[,1:13]
  expect_equivalent(reproduced, original, tolerance=1e-6)
})

context("test_tool2")
test_that("we reproduce the original table at 1e-14 tolerance", {
  reproduced <- tool2_table(demand$'2014', availability$`2014`)
  reproduced$hour<-paste0("h", 1:nrow(reproduced))
  reproduced <- reproduced[,c(13,1:12)]
  reproduced[1,10]<-NA
  reproduced[1,9]<-NA
  reproduced[1,8]<-NA
  original.file<-system.file("extdata", "spreadsheet_tool_2.xlsm", package = "REvola")
  original <- readxl::read_xlsx(original.file, sheet = "tool", skip=16)[,1:13]
  expect_equivalent(reproduced, original, tolerance=1e-14)
})

