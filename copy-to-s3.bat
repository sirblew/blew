@echo off                          
REM This script will copy the contents of the given directory and all sub directories to the configured S3 bucket
REM Brendan Lewis 22/07/2014

SET BUCKET=xxxx
SET AWS_ACCESS_KEY_ID=xxxx
SET AWS_SECRET_ACCESS_KEY=xxx

IF "%1"=="" GOTO USAGE
SET COPYDIR=%1
if not exist %COPYDIR% GOTO USAGE
:MAIN
echo Syncing %COPYDIR% to s3://%BUCKET%
aws s3 sync %COPYDIR% s3://%BUCKET% --acl private
echo Done!
echo Contents of "%BUCKET%" bucket:
aws s3 ls %BUCKET%
GOTO END

:USAGE
echo Usage: %0 directory-to-copy
:END
