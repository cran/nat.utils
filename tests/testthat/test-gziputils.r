context("gzip utility functions")

test_that('digest(,algo="crc32") and gzip.crc agree',{
  require(digest)
  rdsfile=system.file('help/aliases.rds')
  crc1=gzip.crc(rdsfile)
  tf=tempfile()
  on.exit(unlink(tf))
  saveRDS(readRDS(rdsfile),file=tf,compress=F)
  crc2=digest(file=tf,algo='crc32')
  expect_equal(crc1,crc2)
})

test_that('is.gzip works',{
  expect_true(is.gzip(system.file('help/aliases.rds')))
  
  notgzipfile=tempfile()
  expect_true(is.na(is.gzip(notgzipfile)))
  writeLines('not a gzip', notgzipfile)
  expect_false(is.gzip(notgzipfile))
  
  expect_warning(rval<-gzip.crc(notgzipfile))
  expect_true(is.na(rval))
  # make an empty file
  writeBin(logical(), notgzipfile)
  expect_warning(gzip.crc(notgzipfile))
  
  con=gzfile(gzipfile<-tempfile(),open='wt')
  writeLines('This one is gzipped', con)
  close(con)
  expect_true(is.gzip(gzipfile))
  
  unlink(c(notgzipfile,gzipfile))
})
