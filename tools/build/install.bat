set root_dir=%~dp0

set service_path=%root_dir%aliyun_assist_service.exe

SC QUERY "AliyunService" > NUL
IF ERRORLEVEL 1060 GOTO NOTEXIST
GOTO EXIST

:NOTEXIST
ECHO not exist aliyun service
GOTO END

:EXIST
ECHO exist aliyun service

sc query |find /i "AliyunService" >nul 2>nul

if not errorlevel 1 (goto exist_running) else goto notexist_running

:exist_running

echo exist Aliyun server running
net stop "AliyunService"
goto :end_running

:notexist_running

echo not exist Aliyun server running

goto :end_running

:end_running

sc delete "AliyunService" 
GOTO END

:END


sc create "AliyunService" binPath= "%service_path% --service" start= auto
net start "AliyunService"