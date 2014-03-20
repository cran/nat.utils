context("file system utility functions")

test_that('abs2rel works',{
  testans=abs2rel("/Volumes/JData/JPeople/Sebastian/images","/Volumes/JData/JPeople/")
  realans="Sebastian/images"
  expect_equal(testans,realans)
  
  testans=abs2rel("/Volumes/JData/JPeople/Sebastian/images","/Volumes/JData/JPeople")
  realans="Sebastian/images"
  expect_equal(testans,realans)
  
  expect_error(abs2rel("/some/other/path","/Volumes/JData/JPeople/",
                       StopIfNoCommonPath=TRUE),)
  
  expect_warning(testans<-abs2rel("/some/other/path","/Volumes/JData/JPeople/"))
  realans="/some/other/path"
  expect_equal(testans,realans)
})

test_that('touch works',{
  tf=replicate(2,tempfile())
  on.exit(unlink(tf))
  
  expect_error(touch(tf[1],Create=FALSE),
      info="Throws exception if Create=FALSE and file does not exist")
  
  expect_true(touch(tf[1]))
  expect_true(file.exists(tf[1]),"touching a file without other argument creates it")
  expect_true(touch(tf[2]))
  
  t1=ISOdatetime(2001, 1, 1, 12, 12, 12)
  t2=ISOdatetime(2011, 1, 1, 12, 12, 12)
  expect_true(touch(tf[1],t1))
  expect_true(touch(tf[2],t2,Create=FALSE),
      "Check no error when Create=FALSE and target file exists")
  fis=file.info(tf)
  fis$mtime
  expect_equivalent(fis$mtime[1],t1,"Change to a specific time")
  expect_equivalent(fis$mtime[2],t2,"Change to a specific time")
  
  # Change modification time to that of a reference file, leaving access intact
  expect_true(touch(tf[2],reference = tf[1],timestoupdate = "modification"))
  fis2=file.info(tf[2])
  expect_equal(fis2$mtime,fis$mtime[1],
               info="Change mtime to that of a reference file")
  expect_equal(fis2$atime,fis$atime[2],info="Leave atime intact")
})
