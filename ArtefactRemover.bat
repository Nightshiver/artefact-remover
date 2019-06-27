@ECHO OFF
CLS
:MENU

ECHO.
ECHO #############################################################
ECHO # Artefact Remover      v0.3      21JUN2019      MAIN MENU  #
ECHO #############################################################
ECHO #  1) File Options                                          #
ECHO #  2) Folder Options                                        #
ECHO #  3) Registry Options                                      #
ECHO #  4) Services Options                                      #
ECHO #  5) Process Options                                       #
ECHO #  6) Create a System Restore Point                         #
ECHO #  8) Exit                                                  #
ECHO #############################################################
ECHO.
SET /P a="Enter number to select task: "
SET a=%m:~0,2%
if "%a%"=="1" GOTO file
if "%a%"=="2" GOTO folder
if "%a%"=="3" GOTO reg
if "%a%"=="4" GOTO serv
if "%a%"=="5" GOTO proc
if "%a%"=="6" GOTO saveme
if "%a%"=="8" GOTO End
CLS


:file
ECHO #############################################################
ECHO #                   File Options                            #
ECHO #############################################################
ECHO # You can use wildcards, but be careful.                    #
ECHO # 1) Delete file(s)                                         #
ECHO # 2) Delete files in multiple directories                   #
ECHO # 3) Main Menu                                              #
ECHO #############################################################
SET /P b="Enter number to select task: "
if "%b%"=="1" GOTO delfile1
if "%b%"=="2" GOTO delfile2
if "%b%"=="3" GOTO MENU

:: Delete a file
:delfile1
SET /P filepath1="Enter the file path of the file you wish to delete: "
SET filepath1=%filepath1%
IF "%filepath1%"=="" GOTO Error
CD "%filepath1%"
DEL /f /q /s "%filepath1%" > NUL
CLS
GOTO file

:: Delete files in multiple directories
:delfile2
SET /P filepath1="Enter the file paths of the files you wish to delete: "
SET filepath1=%filepath1%
CALL :multifile %filepath1%
CLS
GOTO file

:multifile
FOR %%# in (%*) DO (
	IF "%%#" == "" (
		GOTO Error
	) ELSE (
		ECHO Processing %%~#....
		CD "%%~#"
		DEL /f /q /s "%%~#" > NUL
		PAUSE
	)
)
GOTO :file

:folder
ECHO #############################################################
ECHO #                    Folder Options                         #
ECHO #############################################################
ECHO # 1) Delete the folder and everything in it                 #
ECHO # 2) Main Menu                                              #
ECHO #############################################################
SET /P c="Enter number to select task: "
if "%c%"=="1" GOTO delfolder1
if "%c%"=="2" GOTO MENU

:: Delete a folder and all files inside
:delfolder1
SET /P folder="Enter the path of the folder you wish to delete: "
SET folder=%folder%
IF "%folder%"=="" GOTO Error
RMDIR /q /s "%folder%" > NUL
CLS
GOTO folder


:reg
ECHO #############################################################
ECHO #                   Registry Options                        #
ECHO #############################################################
ECHO # You can use wildcards, but be careful.                    #
ECHO # 1) Delete a registry key                                  #
ECHO # 2) Delete values inside registry keys                     #
ECHO # 3) Main Menu                                              #
ECHO #############################################################
SET /P d="Enter number to select task: "
if "%d%"=="1" GOTO delreg1
if "%d%"=="2" GOTO delreg2
if "%d%"=="3" GOTO MENU

:: Delete a registry key
:delreg1
SET /P regdel="Enter the registry key path you wish to delete: "
SET regdel=%regdel%
IF "%regdel%"=="" GOTO Error
REG DELETE "%regdel%" /f > NUL
CLS
GOTO reg

:: Delete a specific value under a registry key
:delreg2
SET /P keypath="Enter the registry key path for the value you wish to delete: "
SET /P regvalue="Enter the value you wish to delete: "
SET keypath=%keypath%
SET regvalue=%regvalue%
IF "%keypath%"=="" GOTO Error
IF "%regvalue%"=="" GOTO Error
REG DELETE "%keypath%" /v "%regvalue%" /f > NUL
CLS
GOTO reg


:proc
ECHO #############################################################
ECHO #                   Process Options                         #
ECHO #############################################################
ECHO # You can use wildcards, but be careful.                    #
ECHO # 1) Kill by PID                                            #
ECHO # 2) Kill by Proc Name                                      #
ECHO # 3) Main Menu                                              #
ECHO #############################################################
SET /P e="Enter number to select task: "
if "%e%"=="1" GOTO killpid
if "%e%"=="2" GOTO killname
if "%e%"=="3" GOTO MENU

:: Kill a process by PID
:killpid
SET /P killpid="Enter PID number you wish to kill: "
SET killpid=%killpid%
IF "%killpid%"=="" GOTO Error
TASKKILL /pid "%killpid%" /f > NUL
CLS
GOTO proc

:: Kill a process by name
:killname
ECHO "Use quotes if there are spaces in the process name."
SET /P killname="Enter the process name you wish to kill: "
SET killname=%killname%
IF "%killname%"=="" GOTO Error
TASKKILL /im "%killname%" /f > NUL
CLS
GOTO proc


:serv
ECHO #############################################################
ECHO #                   Service Options                         #
ECHO #############################################################
ECHO # You can use wildcards, but be careful.                    #
ECHO # 1) Stop a running service.                                #
ECHO # 2) Delete a service.                                      #
ECHO # 3) Main Menu                                              #
ECHO #############################################################
SET /P e="Enter number to select task: "
if "%e%"=="1" GOTO stopserv1
if "%e%"=="2" GOTO delserv
if "%e%"=="3" GOTO MENU

:: Stop a running service
:stopserv1
SET /P stopserv="Enter service name (case sensitive) you wish to stop: "
SET stopserv=%stopserv%
IF "%stopserv%"=="" GOTO Error
ECHO Stopping service, please give some time for operation to complete.
SC stop "%stopserv%" > NUL
TIMEOUT /t 10 /NOBREAK
ECHO.
CLS
GOTO serv

:: Delete a service
:delserv
SET /P delserv="Enter service name (case sensitive) you wish to delete: "
SET delserv=%delserv%
IF "%delserv%"=="" GOTO Error
SC delete "%delserv%" > NUL
CLS
GOTO serv

:saveme
wmic /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "%DATE%", 100, 1
ECHO Restore point created and has been named according to the current date.
PAUSE
CLS
GOTO MENU

:Error
ECHO You didn't enter anything.
PAUSE
CLS
GOTO MENU

:Error1
ECHO You cannot put a space after your entry.
PAUSE
CLS
GOTO MENU

:End
EXIT