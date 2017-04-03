@ECHO OFF
REM From:https://github.com/azavie/EDU-Batch
REM This is a script to install a specified network printer for which you have the driver and know the IP Address.
REM The script is made for Windows 7 and up, though paths may change between OS
REM Documentation is included and there are reference links for the scripts and programs called.
REM All variable names are arbitrary, as is the value of the "PRINTERNAME" variable

REM =================VARIABLE DECLARATION=================

REM Set Variable scope to local
SETLOCAL

REM Set variable "IPADDRESS" to the IP Address of the Printer to install
SET IPADDRESS=192.168.100.21

REM Set variable "PRINTERNAME" to the Printer Name to be displayed (arbitrary value)
SET PRINTERNAME="Brother HL-2270DW"

REM Set variable "PRINTERMODEL" to the Printer Driver model (specified in the .inf file)
SET PRINTERMODEL="Brother HL-2270DW series"

REM Set variable "INFPATH" to the path of the Print Driver .inf file (varies based on where you stored this)
SET INFPATH=\\Storageserver\printers\hl-2270\BROHLB0A.INF

REM =================PRINTER INSTALLATION=================

REM Creates a TCP/IP printer port for the specified IP address through the Prnport visual basic script
REM https://technet.microsoft.com/en-us/library/cc754352.aspx
cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\Prnport.vbs -a -r %IPADDRESS% -h %IPADDRESS% -o raw -n 9100
ECHO Creating network printer port for IP address %IPADDRESS%

REM Installs the print driver for the specified model using the specified .inf file through the printui.dll
REM https://technet.microsoft.com/en-us/library/ee624057.aspx
rundll32 printui.dll PrintUIEntry /ia /m %PRINTERMODEL% /f %INFPATH%

REM Installs the printer for the specified model, name, and IP address using the specified .inf file through printui.dll
REM https://technet.microsoft.com/en-us/library/ee624057.aspx
Echo Installing %PRINTERNAME%
rundll32 printui.dll PrintUIEntry /if /b %PRINTERNAME% /f %INFPATH% /r %IPADDRESS% /m %PRINTERMODEL%

REM ==== Set as Default printer remove the comment
REM ECHO Setting %PRINTER% as the default printer
REM rundll32 printui.dll,PrintUIEntry /y /n %PRINTER%


ECHO Instalation of %PRINTERNAME% complete

ECHO press any key to exit

REM Ends local variables
ENDLOCAL
pause
exit
