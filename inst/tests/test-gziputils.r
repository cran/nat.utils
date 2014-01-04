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
