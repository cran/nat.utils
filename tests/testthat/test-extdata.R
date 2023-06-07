context("test-extdata.R")

test_that("can make a neuronlist from parts", {
  delayedAssign('wurgle', read_nl_from_parts('sample.rds', package='nat.utils'))
  expect_is(wurgle, 'neuronlist')
})

test_that("we can get extdata", {
  owd=getwd()
  on.exit(setwd(owd))
  
  p1 <- make_fake_package(inside_library = F, package = 'rhubarb', as_installed = F)
  on.exit(unlink(p1, recursive = T), add = T)
  setwd(p1['package'])
  expect_equal(find_extdata(package = 'rhubarb'), file.path("inst","extdata"))
  
  # inside data folder
  setwd(file.path(p1['package'], "data"))
  expect_true(nzchar(find_extdata(package = 'rhubarb')))
  
  # one up from package
  setwd(file.path(p1['base']))
  expect_equal(find_extdata(package = 'rhubarb'), file.path("rhubarb","inst","extdata"))

  p2 <- make_fake_package(inside_library = T, package = 'rhubarb', as_installed = T)
  on.exit(unlink(p2, recursive = T), add = T)
  setwd(p2['package'])
  expect_equal(find_extdata(package = 'rhubarb'), "extdata")
  
  # inside data folder
  setwd(file.path(p2['package'], "data"))
  expect_true(nzchar(find_extdata(package = 'rhubarb')))
  
  # one up from package
  fakelib <- file.path(p2['base'], 'library')
  setwd(fakelib)
  expect_equal(find_extdata(package = 'rhubarb'), file.path("rhubarb","extdata"))
  
  # as if that was our library and we are somewhere different
  setwd(tempdir())
  curlib <- .libPaths()
  on.exit(.libPaths(curlib), add = T)
  .libPaths(c(fakelib, curlib))
  expect_true(nzchar(find_extdata(package = 'rhubarb')))
})
