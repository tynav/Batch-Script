@echo off
@setlocal enableextensions enabledelayedexpansion
	title VSAT Scripts Menu
		color 0a

:: REVISION CONTROL
:: REVISION 15
:: 13 DEC 2021


REM ==================================================================================================================================

:z
cls

::: __      __     _____      _______    _______     _______ _______ ______ __  __  _____  
::: \ \    / /    / ____|  /\|__   __|  / ____\ \   / / ____|__   __|  ____|  \/  |/ ____|
:::  \ \  / /____| (___   /  \  | |    | (___  \ \_/ / (___    | |  | |__  | \  / | (___  
:::   \ \/ /______\___ \ / /\ \ | |     \___ \  \   / \___ \   | |  |  __| | |\/| |\___ \  
:::    \  /       ____) / ____ \| |     ____) |  | |  ____) |  | |  | |____| |  | |____) | 
:::     \/       |_____/_/    \_\_|    |_____/   |_| |_____/   |_|  |______|_|  |_|_____/  
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
echo Version 1.0                                                                  Revision 15
echo=========================================================================================
echo=========================================================================================
echo=========================================================================================
echo======                                                                             ======
echo======                  Enter 1 to restart services and scripts (VSAT-L)           ======
echo======                  Enter 2 to restart services and scripts (VSAT-M)           ======
echo======                  Enter 3 to restart services and scripts (VSAT-S)           ======
echo======                  Enter 4 to view all current connections (ALL)              ======
echo======                  Enter 5 to ping all devices (VSAT-L)                       ======
echo======                  Enter 6 to ping all devices (VSAT-M)                       ======
echo======                  Enter 7 to ping all devices (VSAT-S)                       ======
echo======                  Enter 8 to flush ARP cache                                 ======
echo======                  Enter 9 to see Page 2                                      ======
echo======                                                                             ======
echo=========================================================================================
echo=========================================================================================
echo=========================================================================================
echo                                                                                   PAGE 1
set /p ans="Selection:"                                                

if %ans%==1 (
goto a
)
if %ans%==2 (
goto b
)
if %ans%==3 (
goto c
)
if %ans%==4 (
goto d
)
if %ans%==5 (
goto e
)
if %ans%==6 (
goto f
)
if %ans%==7 (
goto g
)
if %ans%==8 (
goto k
)
if %ans%==9 (
goto y
)

REM ==================================================================================================================================

:y 
cls
:::
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
echo Version 1.0                                                                  Revision 15
echo=========================================================================================
echo=========================================================================================
echo=========================================================================================
echo======                                                                             ======
echo======                  Enter 1 to access Systech GUI (VSAT-L)                     ======
echo======                  Enter 2 to access Digi GUI (VSAT-S/VSAT-M)                 ======
echo======                  Enter 3 to access KU GUI (VSAT-L)                          ======
echo======                  Enter 4 to access CodeMettle                               ======
echo======                  Enter 5 to access RMR GUI                                  ======
echo======                  Enter 6 to restart Sherpa services                         ======
echo======                  Enter 7 to output "How-to" guide                           ======
echo======                  Enter 8 to output readme file                              ======
echo======                  Enter 9 to see Page 3                                      ======
echo======                                                                             ======
echo=========================================================================================
echo=========================================================================================
echo=========================================================================================
echo                                                                                   PAGE 2
set /p ans="Selection:"

if %ans%==1 (
goto i
)
if %ans%==2 (
goto j
)
if %ans%==3 (
goto h
)
if %ans%==4 (
goto m
)
if %ans%==5 (
goto n
)
if %ans%==6 (
goto l
)
if %ans%==7 (
goto o
)
if %ans%==8 (
goto p
)
if %ans%==9 (
goto x
)

REM ==================================================================================================================================

:x 
cls
:::
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
echo Version 1.0                                                                  Revision 15
echo=========================================================================================
echo=========================================================================================
echo=========================================================================================
echo======                                                                             ======
echo======                  Enter 1 to view system info and current hotfixes           ======
echo======                  Enter 2 to view current Windows version                    ======
echo======                  Enter 3 to flush DNS cache                                 ======
echo======                  Enter 4 to view this script's current version              ======
echo======                  Enter 5 to ping an IP connection                           ======
:: echo======                  Enter 6 to                                		  ======
:: echo======                  Enter 7 to                                                 ======
:: echo======                  Enter 8 to                                                 ======
echo======                  Enter 6 to see Page 1                                      ======
echo======                                                                             ======
echo=========================================================================================
echo=========================================================================================
echo=========================================================================================
echo                                                                                   PAGE 3
set /p ans="Selection:"

if %ans%==1 (
goto 1
)
if %ans%==2 (
goto 2
)
if %ans%==3 (
goto 3
)
if %ans%==4 (
goto 4
)
if %ans%==5 (
goto 6
)
if %ans%==6 (
goto z
)
if %ans%==7 (
goto 7
)
if %ans%==8 (
goto 8
)
if %ans%==9 (
goto z
)

REM ==================================================================================================================================

:a
	cls
		:: Clears ARP Cache and resolves MAC Addresses for IPs.

			echo ### Clearing ARP Cache/IP Database..

				netsh interface ip delete arpcache

		:: Stops then starts services

			echo ### Restarting Sherpa services..

				:stop
					sc stop Sherpa
					ping 127.0.0.1 -n 10 -w 1000 >nul

					sc query sherpa | find /I "STATE" | find "STOPPED"
					if errorlevel 1 goto :stop
					goto :start

					:start
						echo ### Starting Sherpa services..
					net start | find /i "Sherpa">nul && goto :start
					sc start Sherpa

			echo ### Disabling CodeMettle

		:: PUSHD and POPD manipulates the directories by setting the directory to a specific location then returning to that location after a process is finished.
		:: CALL allows another script to run inside a batch script.

				PUSHD "C:\Program Files\SherpaServer\setup"
					CALL ..\bin\cam-repl gd-on-L.py
				POPD

			echo ### CodeMettle disabled, restart ACU. Once ACU is fully restarted, press any key to continue
		pause >nul

			echo ### Enabling CodeMettle

				PUSHD "C:\Program Files\SherpaServer\setup"
					CALL ..\bin\cam-repl ftpclient.py
					CALL ..\bin\cam-repl gd-off-L.py
				POPD

			echo ### Done
			echo ### CodeMettle enabled. Press any key to return to menu..
		pause >nul
	goto z

REM ==================================================================================================================================

:b
	cls
		:: Clears ARP Cache and resolves MAC Addresses for IPs.

			echo ### Clearing ARP Cache/IP Database..

				netsh interface ip delete arpcache

		:: Stops then starts services

			echo ### Restarting Sherpa services..

					sc stop Sherpa
					ping 127.0.0.1 -n 10 -w 1000 >nul

					sc query sherpa | find /I "STATE" | find "STOPPED"
					if errorlevel 1 goto :stop
					goto :start

					:start
					net start | find /i "Sherpa">nul && goto :start
					sc start Sherpa

			echo ### Disabling CodeMettle

		:: PUSHD and POPD manipulates the directories by setting the directory to a specific location then returning to that location after a process is finished.
		:: CALL allows another script to run inside a batch script.

				PUSHD "C:\Program Files\SherpaServer\setup"
					CALL ..\bin\cam-repl gd-on-M.py -f
				POPD

			echo ### CodeMettle disabled, restart ACU. Once ACU is fully restarted, press any key to continue
		pause >nul

			echo ### Enabling CodeMettle

				PUSHD "C:\Program Files\SherpaServer\setup"
					CALL ..\bin\cam-repl ftpclient.py
					CALL ..\bin\cam-repl gd-off-M.py -f
				POPD

			echo ### Done
			echo ### CodeMettle enabled. Press any key to return to menu..
		pause >nul
	goto z

REM ==================================================================================================================================

:c
	cls
		:: Clears ARP Cache and resolves MAC Addresses for IPs.

			echo ### Clearing ARP Cache/IP Database..

				netsh interface ip delete arpcache

		:: Stops then starts services
			
			echo ### Restarting Sherpa services..

					sc stop Sherpa
					ping 127.0.0.1 -n 10 -w 1000 >nul

					sc query sherpa | find /I "STATE" | find "STOPPED"
					if errorlevel 1 goto :stop
					goto :start

					:start
					net start | find /i "Sherpa">nul && goto :start
					sc start Sherpa

			echo ### Disabling CodeMettle

		:: PUSHD and POPD manipulates the directories by setting the directory to a specific location then returning to that location after a process is finished.
		:: CALL allows another script to run inside a batch script.

				PUSHD "C:\Program Files\SherpaServer\setup"
					CALL ..\bin\cam-repl gd-on-S.py -f
				POPD

			echo ### CodeMettle disabled, restart ACU. Once ACU is fully restarted, press any key to continue
		pause >nul

			echo ### Enabling CodeMettle

				PUSHD "C:\Program Files\SherpaServer\setup"
					CALL ..\bin\cam-repl ftpclient.py
					CALL ..\bin\cam-repl gd-off-S.py -f
				POPD

			echo ### Done
			echo ### CodeMettle enabled. Press any key to return to menu..
		pause >nul
	goto z

REM ==================================================================================================================================

:d
	cls
		echo ### Displaying all active connections..
					arp -a
				echo ### Press any key to return to menu..
			pause >NUL
	goto z
	
:e
	cls
		echo ### Establishing connections.. (Press Ctrl + C to cancel action)
			
	ping -n 1 "localhost" | findstr /r /c:"[0-9] *ms"
if %errorlevel% == 0 (
	echo === Laptop is UP. ===
) else (
	echo === Laptop is DOWN. ===
)

ping -n 1 "10.165.50.39" | findstr /r /c:"[0-9] *ms"
if %errorlevel% == 0 (
	echo === 323T is UP. ===
) else (
	echo === 323T is DOWN. ===
)

ping -n 1 "10.165.50.221" | findstr /r /c:"[0-9] *ms"
if %errorlevel% == 0 (
	echo === EBEM 1 is UP. ===
) else (
	echo === EBEM 1 is DOWN. ===
)

ping -n 1 "10.165.50.222" | findstr /r /c:"[0-9] *ms"
if %errorlevel% == 0 (
	echo === EBEM 2 is UP. ===
) else (
	echo === EBEM 2 is DOWN. ===
)

ping -n 1 "10.165.50.223" | findstr /r /c:"[0-9] *ms"
if %errorlevel% == 0 (
	echo === EBEM 3 is UP. ===
) else (
	echo === EBEM 3 is DOWN. ===
)


ping -n 1 "10.165.50.110" | findstr /r /c:"[0-9] *ms"
if %errorlevel% == 0 (
	echo === KU HPA is UP. ===
) else (
	echo === KU HPA is DOWN. ===
)

ping -n 1 "10.165.50.115" | findstr /r /c:"[0-9] *ms"
if %errorlevel% == 0 (
	echo === KA HPA is UP. ===
) else (
	echo === KA HPA is DOWN. ===
)

ping -n 1 "10.165.50.118" | findstr /r /c:"[0-9] *ms"
if %errorlevel% == 0 (
	echo === X HPA is UP. ===
) else (
	echo === X HPA is DOWN. ===
)

ping -n 1 "10.165.50.150" | findstr /r /c:"[0-9] *ms"
if %errorlevel% == 0 (
	echo === UPS is UP. ===
) else (
	echo === UPS is DOWN. ===
)

ping -n 1 "10.165.50.160" | findstr /r /c:"[0-9] *ms"
if %errorlevel% == 0 (
	echo === ECU is UP. ===
) else (
	echo === ECU is DOWN. ===
)

ping -n 1 "10.165.50.200" | findstr /r /c:"[0-9] *ms"
if %errorlevel% == 0 (
	echo === RMR is UP. ===
) else (
	echo === RMR is DOWN. ===
)
			echo ### Done
			echo ### Press any key to return to menu..
pause>nul
	goto z

REM ==================================================================================================================================

:f
	cls
	echo ### Establishing connections.. (Press Ctrl + C to cancel action)

		ping -n 1 "localhost" | findstr /r /c:"[0-9] *ms"
			if %errorlevel% == 0 (
				echo === Laptop is UP. ===
					) else (
				echo === Laptop is DOWN. ===
				)

		ping -n 1 "10.165.50.200" | findstr /r /c:"[0-9] *ms"
			if %errorlevel% == 0 (
				echo === RMR is UP. ===
					) else (
				echo === RMR is DOWN. ===
				)

		ping -n 1 "10.165.50.3" | findstr /r /c:"[0-9] *ms"
			if %errorlevel% == 0 (
				echo === DIGI is UP. ===
					) else (
				echo === DIGI is DOWN. ===
				)

			echo ### Done
			echo ### Press any key to return to menu..
pause>nul
	goto z

REM ==================================================================================================================================

:g
	cls
	echo ### Establishing connections.. (Press Ctrl + C to cancel action)

		ping -n 1 "localhost" | findstr /r /c:"[0-9] *ms"
			if %errorlevel% == 0 (
				echo === Laptop is UP. ===
					) else (
				echo === Laptop is DOWN. ===
				)

		ping -n 1 "10.165.50.200" | findstr /r /c:"[0-9] *ms"
			if %errorlevel% == 0 (
				echo === RMR is UP. ===
					) else (
				echo === RMR is DOWN. ===
				)

		ping -n 1 "10.165.50.3" | findstr /r /c:"[0-9] *ms"
			if %errorlevel% == 0 (
				echo === DIGI is UP. ===
					) else (
				echo === DIGI is DOWN. ===
				)

			echo ### Done
			echo ### Press any key to return to menu..
pause>nul
	goto z

REM ==================================================================================================================================

:h
	cls
		start explorer "http://10.165.50.110/"
	goto y

REM ==================================================================================================================================

:i
	cls
		start explorer "http://10.165.50.21/"
	goto y

REM ==================================================================================================================================

:j
	cls
		start explorer "http://10.165.50.3/"
	goto y

REM ==================================================================================================================================

:k
	cls
		echo ### Clearing IP cache
			netsh interface ip delete arpcache
		echo ### Done
		echo ### Press any key to return to menu...
pause>nul
	goto z

REM ==================================================================================================================================

:l
	cls
		echo ### Restarting Sherpa services..

					sc stop Sherpa
					ping 127.0.0.1 -n 10 -w 1000 >nul

					sc query sherpa | find /I "STATE" | find "STOPPED"
					if errorlevel 1 goto :stop
					goto :start

					:start
					net start | find /i "Sherpa">nul && goto :start
					sc start Sherpa

		echo ### Done
		echo ### Press any key to return to menu...
pause>nul
	goto y

REM ==================================================================================================================================

:m
	cls
		start explorer "http://localhost/"
	goto y

REM ==================================================================================================================================

:n
	cls
		start explorer "http://10.165.50.200/"
	goto y

REM ==================================================================================================================================

:o
	cls
echo ===============================================
echo ===	      QUICK HELP GUIDE		    ===
echo ===============================================
echo Command to reset IP directory / Clear IP Cache:
echo 	(This will clear and reset IP cache and automatically discover all dynamic IPs on the system's network)
echo 		netsh interface ip delete arpcache
echo.
echo.
echo Troubleshooting steps if you are unable to make connection to Linkway Modems:
echo 	1) Verify if (SecureCRT is off) in CodeMettle if trying to access via CodeMettle
echo 	2) Verify if (SecureCRT is on) in CodeMettle if trying to access via SecureCRT
echo 	3) Access Systech GUI
echo 	4) In the left-hand menu, go to "Reset Ports/Restart Device"
echo 	5) Select all ports on page
echo 	6) Reset ports
echo 	7) Restart Systech device
echo.
echo.
echo Accessing KA Band GUI: *VSAT-L*
echo	1) In the Windows Search Bar, search for "Wavestream"
echo 	2) Open program "Wavestream GUI"
echo 	3) On the program's GUI, select the drop down of serial ports, it will show:
echo 		- COMM1
echo		- COMM2
echo		- COMM3
echo		- ETHERNET
echo 	4) Select "Ethernet"
echo 	5) Click the top "connections" tab, set the IP to 10.165.50.115
echo 	8) In the main interface of the program, select the "Start" button and it was establish a connection
echo.
echo.
echo Accessing X Band GUI: *VSAT-L*
echo 	1) Open "HPA CONTROL UTILITY" found on Desktop or Windows Search
echo 	2) Settings are as followed:
echo			IP: 10.165.50.118
echo			Port: 2000
echo			Use Ethernet: Yes
echo.
echo.
echo Default IP Directory:
echo 	(Note: 303T and KU/KA SSPA for VSAT-S AND VSAT-M are not noted below, they are serial connections)
echo 	(Note: If you have received a NEW HPA, verify IP address is set to default instead of manufacturer given IP)
echo 	(As stated above, those connections can be found on serial COMM ports via device manager)
echo 		***THESE ARE DYNAMIC IP ADDRESSES***
echo			 Systech Switch - 10.165.50.21
echo 			323T ACU - 10.165.50.39 (VSAT-L)
echo 			KU BAND - 10.165.50.110 (VSAT-L)
echo 			KA BAND - 10.165.50.115 (VSAT-L)
echo 			X BAND - 10.165.50.118 (VSAT-L)
echo 			UPS - 10.165.50.150
echo 			ECU - 10.165.50.160
echo 			RMR - 10.165.50.200
echo 			EBEM 1 - 10.165.50.221
echo 			EBEM 2 - 10.165.50.222
echo 			EBEM 3 - 10.165.50.223
echo 			LINKWAY 1 - 10.165.50.21:8001/9001 (IP:RAW/TELNET)
echo 			LINKWAY 2 - 10.165.50.21:8002/9002 (IP:RAW/TELNET)
echo 			LINKWAY 3 - 10.165.50.21:8003/9003 (IP:RAW/TELNET)
echo 			DIGI - 10.165.50.3
echo.
echo.
echo Zeroing an EBEM Modem:
echo 	1) While modem is on, press and hold shaded keys on the front panel of modem
echo 	2) Modem will restart, once done, set modem to local
echo 	3) Login to admin, password: 123456
echo 	4) Set new admin password to "654321"
echo 	5) Set user password to "654321"
echo 	6) Click right to next step on modem
echo 	7) Fill keys until screen reads "100 PCT"
echo 	8) Click right to next step on modem
echo 	9) Fill keys with "0" until modem screen is filled with "0"
echo 	10) Once finished and entered, modem with prompt restart 
echo.
echo.
echo Default Order for Auto-Acquire Steps:
echo 	PosToTrack = Acquiring Satellite = Satellite Acquired = Box Scan = Cross Scan = Zeroing
echo 	Zeroed = Optrack Fast Learn = Optrack Settle Out
echo.
echo.
echo Accessing BIOS and BOOT MENU on Getac B300 and S410:
echo 	F10 for BOOT MENU
echo 	F2 Key on start-up for BIOS 
echo 	Default Bios Password: VSat678*!
echo 	(Password could change depending on unit's password policy)
echo.
echo.
echo Upgrading or Downgrading EBEM Modem Firmware:
echo 	1. Verify your current firmware verison on the EBEM Modem
echo 	2. Verify the firmware version you are installing
echo 	3. Connect the EBEM directly to the laptop via ethernent
echo 	4. In the Windows searchbar, search for EBEM LCT V3 or find it under "VSAT Docs"
echo 	5. Install EBEM LCT v3 using the current version of Java already installed on the laptop
echo 	6. Once installed, turn the EBEM modem on and configure settings on the program for MD-1366
echo 	7. On the top bar of the program, look for configuration window
echo 	8. On the configuration window, you will have a box on the leftand right of the GUI, this is 
echo		where you will select your modem and select "Firmware Upgrade"
echo 	9. Once your modem is selected, load up the correct firmware file.
echo 	10. After everything is set, continue with the installation, this will take 20-40 minutes
echo 	11. Once finished, zeroize your EBEM modem
echo 	12. Reverify EBEM firmware
echo.
echo.
echo Default Getac B300/S410 Network Configuration:
echo 	IPv4 - 10.165.50.101
echo 	Gateway - 255.255.255.0
echo.
echo.
echo Basic SecureCRT commands for LWS2 modem:
echo 	lws2_stat (Checks status of LWS2)
echo 	lws2_stop (Stops LWS2 services)
echo    lws2_start (Starts LWS2 services)
echo 	-cw (Sets clearwave frequency)
echo 	-p (Sets power of frequency, measured in dB)
echo 	-t (Sets time of how long frequency will be established)
echo 	-f (Sets frequency based on Hz)
echo.
echo.
echo.
echo ### Press enter to return to menu..
			
		pause>nul
	goto y

REM ==================================================================================================================================

:p
	cls

echo ===========================================================
echo ===========================================================
echo ===========================================================
echo ===						        ===
echo ===	  Readme for "VSAT Scripts Menu":	        ===
echo ===						        ===
echo ===========================================================
echo ===========================================================
echo ===========================================================
echo.
echo 		DIRECTORY FOR READ ME:
echo 		*FORMAT IS: Selection-Page*
echo.
echo		SECTION 1: SELECTIONS (1-1) (2-1) (3-1) 
echo			- System Reset
echo		SECTION 2: SELECTIONS (4-1)
echo			- IP/Network Connections Established
echo		SECTION 3: SELECTIONS (5-1) (6-1) (7-1)
echo			- Terminal Equipment Connection Status
echo		SECTION 4: SELECTIONS (8-1) (9-1) (1-2) (2-2) (2-3) (2-4) (2-5) (2-6) (2-7) (2-8) (2-9)
echo.
echo ===========================================================
echo ===========================================================
echo ===========================================================
echo ===						        ===
echo ===			How to use		        ===
echo ===						        ===
echo ===========================================================
echo ===========================================================
echo ===========================================================
echo.
echo 	Accessing V-SAT SYSTEMS SCRIPT MENU
echo		1) Right click "VSAT Scripts Menu"
echo		2) Run as administrator
echo		3) When prompted to open CMD Prompt with admin, select "Yes"
echo		4) Select a value (1-9) to navigate the GUI depending on your needs
echo		5) Press "enter" and follow on screen directions
echo.
echo 	Improved system restart/reset
echo		1) Select a value (1-3) depending on what system you are on
echo		2) Press "enter" and follow on screen directions
echo.
echo ===========================================================
echo ===========================================================
echo ===========================================================
echo ===						        ===
echo ===			SECTION 1           	        ===
echo ===						        ===
echo ===========================================================
echo ===========================================================
echo ===========================================================
echo.
echo 	(While running batch scripts and command shortcuts, MUST run as admin)
echo.
echo 	This batch file will follow this order for selections (1-1), (2-1), and (3-1):
echo		1. Clears/Resets ARP Cache
echo		2. Stops Sherpa Services
echo		3. Starts Sherpa Services
echo		4. Disables CodeMettle (via already sourced python script from Sherpa)
echo		5. Enables CodeMettle (via already sourced python script from Sherpa)
echo.
echo ===========================================================
echo ===========================================================
echo ===========================================================
echo ===						        ===
echo ===			SECTION 2                       ===
echo ===						        ===
echo ===========================================================
echo ===========================================================
echo ===========================================================
echo.
echo 	Selection (4-1) is a shortcut access to view ALL active dynamic/static IPs that were found on the terminal.
echo 	Default item IPs can be found in the quick reference text file.
echo.
echo ===========================================================
echo ===========================================================
echo ===========================================================
echo ===						        ===
echo ===			SECTION 3          	        ===
echo ===						        ===
echo ===========================================================
echo ===========================================================
echo ===========================================================
echo.
echo 	Selection (5-1) (6-1) (7-1) executes a script to automatically ping each specific item in the terminal.
echo 	This is an ease of access tool to simplify the process of verifying connections within the network.
echo.
echo ===========================================================
echo ===========================================================
echo ===========================================================
echo ===						        ===
echo ===			SECTION 4           	        ===
echo ===						        ===
echo ===========================================================
echo ===========================================================
echo ===========================================================
echo.
echo 	Selection (8-1) resets the ARP cache and resolves MAC addresses for any dynamic IPs connected to the system.
echo 	Selection (9-1) sends the user to PAGE 2 of the script.
echo 	Selections (1-2)(2-2)(3-2)(4-2)(5-2) are quick command links to open web browser GUIs for ease of access.
echo 	Selection (6-2) executes a simple stop and start command for "Sherpa" services.
echo 	Selection (7-2) outputs a quick reference guide into the terminal.
echo 	Selection (8-2) outputs this readme file.
echo 	Selection (9-2) returns the user back to PAGE 1 of the batch script.
echo.
echo.
echo.
echo ### Press enter to return to menu..
			
		pause>nul
	goto y

REM ==================================================================================================================================

:1
	cls
		
			Systeminfo
		echo.
	echo ### Press enter to return to menu..

		pause>nul
	goto x

REM ==================================================================================================================================

:2
	cls
		
			ver
		echo.
	echo ### Press enter to return to menu..

		pause>nul
	goto x

REM ==================================================================================================================================

:3
	cls
		
			ipconfig /flushdns
		echo.
	echo ### Press enter to return to menu..

		pause>nul
	goto x

REM ==================================================================================================================================

:4
	cls
echo.
echo.
echo.
echo =================================
echo =================================
echo =================================	
echo ==========             ==========
echo ==========             ==========
echo ========== VERSION 1.0 ==========
echo ========== REVISION 15 ==========
echo ========== 12 DEC 2021 ==========
echo ==========             ==========
echo ==========             ==========
echo =================================
echo =================================
echo =================================	
		echo.
		echo.
		echo.
	echo ### Press enter to return to menu..

		pause>nul
	goto x
REM ==================================================================================================================================

:5
	cls
		
			
		echo.
	echo ### Press enter to return to menu..

		pause>nul
	goto x
REM ==================================================================================================================================

:6
cls
echo =============================================================
echo ====            Enter IP address to ping..               ====
echo =============================================================

set /p adress=IP address:

ping %adress% & echo. & pause. 
		echo.
	echo ### Press enter to return to menu..
		pause>nul

		
	goto x
REM ==================================================================================================================================

:7
	cls
		
			
		echo.
	echo ### Press enter to return to menu..

		pause>nul
	goto x
REM ==================================================================================================================================

:8
	cls
		
			
		echo.
	echo ### Press enter to return to menu..

		pause>nul
	goto x