@echo off
setlocal enabledelayexpand

REM Navigate to the script directory
cd /d "C:\wamp64\www\idrac_temp\"

REM Define PHP executable path
set PHP_EXE=C:\wamp64\bin\php\php7.4.0\php.exe

REM Define log file for debugging
set LOG_FILE=C:\wamp64\www\idrac_temp\task_scheduler.log

REM Get current date/time for logging
for /f "tokens=2-4 delimiters=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
for /f "tokens=1-2 delimiters=/:" %%a in ('time /t') do (set mytime=%%a: %%b)

REM Log task execution start
echo [%mydate% %mytime%] Task started >> "%LOG_FILE%"

REM Run the PHP script
"%PHP_EXE%" idrac. php hourly >> "%LOG_FILE%" 2>&1

REM Log completion
echo [%mydate% %mytime%] Task completed >> "%LOG_FILE%"