@echo off

set ROOTCA_CERT="./cert/OISTE WISeKey Global Root GB CA.pem"

set ROOTCA_ALIAS1="oiste_wisekey_global_root_gb_ca"
set ROOTCA_ALIAS2="oistewisekeyglobalrootgbca"
set CACERTS_PASSWORD=changeit

set RETURN_VALUE=
set TEMP_FILE=temp_output.txt
set TEMP_FILE2=temp_output2.txt


CALL :IsExistRootCA %ROOTCA_ALIAS1%
IF ["%RETURN_VALUE%"]==[""] (
    CALL :IsExistRootCA  %ROOTCA_ALIAS2%
)

IF ["%RETURN_VALUE%"]==[""] (
    keytool -import -cacerts -noprompt -file %ROOTCA_CERT% -alias %ROOTCA_ALIAS1% -storepass %CACERTS_PASSWORD%
    echo Import RootCA : %ROOTCA_ALIAS1%
    goto :eof 
)

echo Already Included RootCA : %RETURN_VALUE%
pause

:: Check Root Certificate
:IsExistRootCA
call keytool -list -cacerts -storepass %CACERTS_PASSWORD% > %TEMP_FILE%
call findstr /i /c:"%ROOTCA_ALIAS1%" %TEMP_FILE% > %TEMP_FILE2%
set /p RETURN_VALUE=<%TEMP_FILE2%
del %TEMP_FILE% %TEMP_FILE2%
EXIT /B 0