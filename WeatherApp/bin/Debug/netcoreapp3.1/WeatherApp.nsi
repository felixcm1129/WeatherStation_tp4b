; example1.nsi
;
; This script is perhaps one of the simplest NSIs you can make. All of the
; optional settings are left to their default settings. The installer simply 
; prompts the user asking them where to install, and drops a copy of example1.nsi
; there. 
;
; example2.nsi expands on this by adding a uninstaller and start menu shortcuts.

;--------------------------------

;!include "MUI2.nsh"


; The name of the installer
Name "WeatherAppInstaller"

; The file to write
OutFile "WeatherAppInstaller.exe"

; Request application privileges for Windows Vista
RequestExecutionLevel user

;Interface Settings
;!define MUI_ABORTWARNING
;---------------------------------------


; Build Unicode installer
Unicode True

; The default installation directory
InstallDir $PROFILE\1539902

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\WeatherAppInstaller" "Install_Dir"
;--------------------------------

; Pages

Page components 
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

; The stuff to install
Section "WeatherAppInstaller" ;

  SectionIn RO

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File Microsoft.Extensions.Configuration.Abstractions.dll
  File Microsoft.Extensions.Configuration.Binder.dll
  File Microsoft.Extensions.Configuration.dll
  File Microsoft.Extensions.Configuration.FileExtensions.dll
  File Microsoft.Extensions.Configuration.Json.dll
  File Microsoft.Extensions.Configuration.UserSecrets.dll
  File Microsoft.Extensions.DependencyInjection.Abstractions.dll
  File Microsoft.Extensions.DependencyInjection.dll
  File Microsoft.Extensions.FileProviders.Abstractions.dll
  File Microsoft.Extensions.FileProviders.Physical.dll
  FILE Microsoft.Extensions.FileSystemGlobbing.dll
  FILE Microsoft.Extensions.Options.ConfigurationExtensions.dll
  FILE Microsoft.Extensions.Options.dll
  FILE Microsoft.Extensions.Primitives.dll
  FILE Newtonsoft.Json.Bson.dll
  FILE Newtonsoft.Json.dll
  FILE OpenWeatherAPI.dll
  FILE OpenWeatherAPI.pdb
  FILE System.Net.Http.Formatting.dll
  File WeatherApp.deps.json
  FILE WeatherApp.dll
  FILE WeatherApp.exe
  File WeatherApp.pdb
  FILE Cloudy.ico
  FILE appsettings.json
  File WeatherApp.runtimeconfig.dev.json
  File WeatherApp.runtimeconfig.json

  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\WeatherAppInstaller "Install_Dir" "$INSTDIR"

  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\1539902" "DisplayName" "WeatherAppInstaller"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\1539902" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\1539902" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\1539902" "NoRepair" 1
  WriteUninstaller "$INSTDIR\uninstall.exe"
  
SectionEnd ; end the section

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts and Desktop ShortCut"

  CreateDirectory "$SMPROGRAMS\1539902"
  CreateShortcut "$SMPROGRAMS\1539902\Uninstall.lnk" "$INSTDIR\uninstall.exe"
  CreateShortcut "$SMPROGRAMS\1539902\WeatherApp.lnk" "$INSTDIR\WeatherApp.exe" "" "$INSTDIR\Cloudy.ico"
  CreateShortcut "$DESKTOP\WeatherApp.lnk" "$INSTDIR\WeatherApp.exe" "" "$INSTDIR\Cloudy.ico"

SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\1539902"
  DeleteRegKey HKLM SOFTWARE\WeatherAppInstaller

  ; Remove files and uninstaller, always remove uninstaller first
  Delete $INSTDIR\uninstall.exe
  Delete $INSTDIR\Microsoft.Extensions.Configuration.Abstractions.dll
  Delete $INSTDIR\Microsoft.Extensions.Configuration.Binder.dll
  Delete $INSTDIR\Microsoft.Extensions.Configuration.dll
  Delete $INSTDIR\Microsoft.Extensions.Configuration.FileExtensions.dll
  Delete $INSTDIR\Microsoft.Extensions.Configuration.Json.dll
  Delete $INSTDIR\Microsoft.Extensions.Configuration.UserSecrets.dll
  Delete $INSTDIR\Microsoft.Extensions.DependencyInjection.Abstractions.dll
  Delete $INSTDIR\Microsoft.Extensions.DependencyInjection.dll
  Delete $INSTDIR\Microsoft.Extensions.FileProviders.Abstractions.dll
  Delete $INSTDIR\Microsoft.Extensions.FileProviders.Physical.dll
  Delete $INSTDIR\Microsoft.Extensions.FileSystemGlobbing.dll
  Delete $INSTDIR\Microsoft.Extensions.Options.ConfigurationExtensions.dll
  Delete $INSTDIR\Microsoft.Extensions.Options.dll
  Delete $INSTDIR\Microsoft.Extensions.Primitives.dll
  Delete $INSTDIR\Newtonsoft.Json.Bson.dll
  Delete $INSTDIR\Newtonsoft.Json.dll
  Delete $INSTDIR\OpenWeatherAPI.dll
  Delete $INSTDIR\OpenWeatherAPI.pdb
  Delete $INSTDIR\System.Net.Http.Formatting.dll
  Delete $INSTDIR\WeatherApp.dll
  Delete $INSTDIR\WeatherApp.exe
  Delete $INSTDIR\appsettings.json
  Delete $INSTDIR\WeatherApp.deps.json
  Delete $INSTDIR\WeatherApp.runtimeconfig.dev.json
  Delete $INSTDIR\WeatherApp.runtimeconfig.json
  Delete $INSTDIR\WeatherApp.pdb

  Delete Cloudy.ico

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\1539902\*.lnk"
  Delete "$DESKTOP\WeatherApp.lnk"

  ; Remove directories
  RMDir "$SMPROGRAMS\1539902"
  RMDir "$INSTDIR"

SectionEnd