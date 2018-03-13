
@echo off
:: Get Administrator privilige by UAC
setlocal
set uac=~uac_permission_tmp_%random%
md "%SystemRoot%\system32\%uac%" 2>nul
if %errorlevel%==0 (
    rd "%SystemRoot%\system32\%uac%" >nul 2>nul
) else (
    echo set uac = CreateObject^("Shell.Application"^)>"%temp%\%uac%.vbs"
    echo uac.ShellExecute "%~s0","","","runas",1 >>"%temp%\%uac%.vbs"
    echo WScript.Quit >>"%temp%\%uac%.vbs"
    "%temp%\%uac%.vbs" /f
    del /f /q "%temp%\%uac%.vbs" & exit 
)
endlocal

:: Admin
echo Check the ~\vimfiles
if not exist %USERPROFILE%\vimfiles mklink /D %USERPROFILE%\vimfiles %~dp0
echo Check the ~\_vsvimrc
if not exist %USERPROFILE%\_vsvimrc mklink %USERPROFILE%\_vsvimrc %~dp0\vsvim.vim
echo Check the ~\.ctags
if not exist %USERPROFILE%\.ctags mklink %USERPROFILE%\.ctags %~dp0\_ctags
echo Check the ~\.gitconfig
if not exist %USERPROFILE%\.gitconfig mklink %USERPROFILE%\.gitconfig %~dp0\_gitconfig

pause
