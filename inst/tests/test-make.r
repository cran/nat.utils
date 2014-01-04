context("make system utility functions")

test_that('RunCmdForNewerInput works',{
  # make a test directory
  tf=replicate(5,tempfile())
  for (i in 1:2) cat("Hello",i,"!",file=tf[i])
  Sys.sleep(1.5)
  for (i in 3:4) cat("Hello",i,"!",file=tf[i])
  on.exit(unlink(tf[1:4]))
  
  expect_false(
    RunCmdForNewerInput(NULL,infiles=tf[1],outfile=tf[3]),
    'one older input file')
  
  expect_true(
    RunCmdForNewerInput(NULL,infiles=tf[4],outfile=tf[1]),
    'one newer input file')
  
  expect_false(
    RunCmdForNewerInput(NULL,infiles=c(tf[1],tf[2]),outfile=tf[3]),
    'multiple older inputfiles')
  
  expect_true(
    RunCmdForNewerInput(NULL,infiles=c(tf[4],tf[1]),outfile=tf[2]),
    'one newer and one older input file')
  
  expect_false(
    RunCmdForNewerInput(NULL,infiles=tf[5],outfile=tf[2]),
    'single missing input file')
  
  expect_false(
    RunCmdForNewerInput(NULL,infiles=character(0),outfile=tf[2]),
    'empty input file vector')
  
  expect_false(
    RunCmdForNewerInput(NULL,infiles=c(tf[1],tf[5]),outfile=tf[2]),
    'one input missing, another present')
  
  expect_true(
    RunCmdForNewerInput(NULL,infiles=c(tf[1],tf[4]),outfile=tf[5]),
    'missing output file')
  
  expect_false(
    RunCmdForNewerInput(NULL,infiles=tf[1],outfile=c(tf[3],tf[4])),
    'single older input, multiple newer outputs')
  
  expect_false(
    RunCmdForNewerInput(NULL,infiles=c(tf[1],tf[2]),outfile=c(tf[3],tf[4])),
    'multiple older inputs, multiple newer outputs')
  
  expect_true(
    RunCmdForNewerInput(NULL,infiles=tf[3],outfile=c(tf[1],tf[4])),
    'single input, multiple outputs, of which one is older')
  
  expect_true(
    RunCmdForNewerInput(NULL,infiles=c(tf[1],tf[2]),outfile=c(tf[4],tf[5])),
    'one missing output file, older inputs')
  
  expect_true(
    RunCmdForNewerInput(NULL,infiles=c(tf[1],tf[4]),outfile=c(tf[2],tf[3])),
    'multiple inputs, multiple outputs, one older')
  
  expect_output(expect_true(
    RunCmdForNewerInput(NULL,infiles=c(tf[1],tf[4]),outfile=c(tf[2],tf[3]),Verbose=TRUE),
    'multiple inputs, multiple outputs, one older'),'Overwriting')
})