test_that("make_chunks works", {
  expect_equal(make_chunks(size=5, chunksize=2), c(1,1,2,2,3))
  expect_equal(make_chunks(size=4, chunksize=2), c(1,1,2,2))
  
  expect_equal(make_chunks(1:5, nchunks=2), list(`1`=c(1:3), `2`=c(4,5)))
  expect_equal(make_chunks(1:5, chunksize=2), list(`1`=c(1,2), `2`=c(3,4), `3`=5))
  
  expect_error(make_chunks(1:5, nchunks=2, chunksize = 2))
  expect_error(make_chunks(1:5))
  expect_error(make_chunks(1:5, nchunks = 0))
  expect_error(make_chunks(1:5, chunksize = -1))
})
