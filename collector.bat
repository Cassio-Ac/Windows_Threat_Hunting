@echo off
echo #################################################################################################################################
echo Changing the hibernation settings, is highly recommended that you verify it in the windows settings
powercfg.exe -h off 
::This should make the machine do not hibernate anymore, even though is highly recommended that you verify by yourself
::Tell The script where the container or the external drive used in the information gathering is mounted
echo %cd% > tmpPwd
set /p pwd=< tmpPwd
del tmpPwd
echo The drive is mounted in %pwd:~0,1%


echo #################################################################################################################################
ipconfig
::From the information above tell witch is the administrators group based in the language of the windows
net localgroup | findstr /i administr > tmpAdmin
set /p group=< tmpAdmin
del tmpAdmin

echo The administrators group is %group:~1,30%
set /p lugar=Where the gathering is being made? (OM_SESSION) .....
set /p rede=Witch is the IP of the machine? (Use underline instead of dot, ex 10_0_0_42) .......


set pasta=%lugar%_%computername%_%rede%
echo Creating folder named %pasta%
cls

echo #################################################################################################################################
SET Processor
::From the information above, tell if the system is X64 or not
echo Verifying proccessor_architecture
set proccessor_architecture > tmpProc
set /p processador_var= < tmpProc
del tmpProc

cls

echo #################################################################################################################################
echo Creating a folder that you must rename it after
mkdir %pwd:~0,1%:\%pasta%\
mkdir %pwd:~0,1%:\%pasta%\documents\
cls

echo #################################################################################################################################
echo Saving Date and Time
date /t > %pwd:~0,1%:\%pasta%\data_hora.txt
time /t >> %pwd:~0,1%:\%pasta%\data_hora.txt
systeminfo | find Fuso >> %pwd:~0,1%:\%pasta%\data_hora.txt
systeminfo | find Time Zone >> %pwd:~0,1%:\%pasta%\data_hora.txt
cls


echo #################################################################################################################################
echo Begin the Information Gathering
echo Collecting Serial Number
wmic bios get serialnumber > %pwd:~0,1%:\%pasta%\numero_serial.txt
echo Collecting SID
.\sysinternals\psgetsid -nobanner -accepteula >>  %pwd:~0,1%:\%pasta%\SID.txt
sc query > %pwd:~0,1%:\%pasta%\services.txt
wmic process > %pwd:~0,1%:\%pasta%\wmicProcess.txt
findstr /i "defender kaspersky mcafee avast kasp avg panda avira" %pwd:~0,1%:\%pasta%\services.txt > %pwd:~0,1%:\%pasta%\Antivirus.txt
systeminfo > %pwd:~0,1%:\%pasta%\systeminfo.txt
ipconfig > %pwd:~0,1%:\%pasta%\ipconfig.txt
tasklist > %pwd:~0,1%:\%pasta%\tasklist.txt
tasklist /v >  %pwd:~0,1%:\%pasta%\tasklist_V.txt
netstat -ano > %pwd:~0,1%:\%pasta%\netstat.txt
net localgroup %grupo:~1,30% > %pwd:~0,1%:\%pasta%\admins.txt
dir c:\Users > %pwd:~0,1%:\%pasta%\pasta_usuarios.txt
net config workstation  > %pwd:~0,1%:\%pasta%\config.txt
echo Collecting Authenticated Users 
.\sysinternals\psloggedon -nobanner -accepteula > %pwd:~0,1%:\%pasta%\authenticated_users.txt
netstat -rn > %pwd:~0,1%:\%pasta%\routes.txt
net use > %pwd:~0,1%:\%pasta%\shares.txt
net file > %pwd:~0,1%:\%pasta%\opened_files.txt
net sessions > %pwd:~0,1%:\%pasta%\sessions_opened.txt
tasklist /M > %pwd:~0,1%:\%pasta%\proceses_and_modules.txt
.\sysinternals\logonsessions -p -nobanner -accepteula > %pwd:~0,1%:\%pasta%\proceses_logon_session.txt
cls 


echo #################################################################################################################################
echo Gathering Windows Event logs
::Here the three most important windows event logs will be saved
mkdir %pwd:~0,1%:\%pasta%\event_log
wevtutil epl System  %pwd:~0,1%:\%pasta%\event_log\%computername%_System_log.evtx
wevtutil epl Security  %pwd:~0,1%:\%pasta%\event_log\%computername%_Security_log.evtx
wevtutil epl Application  %pwd:~0,1%:\%pasta%\event_log\%computername%_Application_log.evtx
cls 


echo #################################################################################################################################
echo Begin memory gathering, this may take a while
::Memory gathering, based in the answer that you gave about the architecture
if "%processador_var:~23,5%"=="AMD64" (.\winpmem_mini_x64_rc2.exe %pwd:~0,1%:\%pasta%\mem.img ) else (.\winpmem_mini_x86.exe %pwd:~0,1%:\%pasta%\mem.img) 
::Loki takes about 6 hours to complete his analisys, once the script reaches this step, you are now free to run the Redline script as well and leave the machine do his job
cls


echo #################################################################################################################################
echo Zipping files 
.\7za.exe a -tzip %pasta% %pwd:~0,1%:\%pasta% 
del /f /q /s %pwd:~0,1%:\%pasta%\*
for /d %%x in (%pwd:~0,1%:\%pasta%\*) do @rd /s /q "%%x"
move %pasta%.zip %pwd:~0,1%:\%pasta%\
cls


echo #################################################################################################################################
echo Loki takes about six hours to complete, be patient....
.\loki\loki.exe -l %pwd:~0,1%:\%pasta%\loki.txt
cls

echo #################################################################################################################################
echo Finished, remember to move the Redline output to the %pasta% folder and rename it!
