  !include "MUI2.nsh"
  !define MUI_ICON "icon.ico"
  !define MUI_UNICON "icon.ico"
  !define MUI_PRODUCT "Pastexen"
  !define MUI_FILE "Pastexen.exe"
  BrandingText "Pastexen Installation"            
  CRCCheck On

  Name "Pastexen"

  OutFile "Pastexen.exe"

  InstallDir "$PROGRAMFILES\${MUI_PRODUCT}"
  
  InstallDirRegKey HKCU "Software\Pastexen" ""

  SetCompressor /SOLID lzma

  !define MUI_ABORTWARNING

  !insertmacro MUI_PAGE_LICENSE "License.txt"
  ;!insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_LANGUAGE "Russian"
  !insertmacro MUI_LANGUAGE "English"



Section "Main"

SetOutPath "$INSTDIR"

Sectionin RO

  File /r "pastexen\*.*"

  CreateShortCut "$DESKTOP\${MUI_PRODUCT}.lnk" "$INSTDIR\${MUI_FILE}" ""

  CreateShortCut "$SMSTARTUP\${MUI_PRODUCT}.lnk" "$INSTDIR\${MUI_FILE}"

  WriteRegStr HKCU "Software\Pastexen" "" $INSTDIR

  WriteUninstaller "$INSTDIR\Uninstall.exe"
  
  WriteRegStr HKCR "*\shell\Pastexen" "" "Share (Pastexen)"
  WriteRegStr HKCR "*\shell\Pastexen\command" "" "$INSTDIR\${MUI_FILE} %1"
  
  #todo: write records only for supported extensions

SectionEnd



Section "Uninstall"

  Delete "$INSTDIR\Uninstall.exe"
  Delete "$SMSTARTUP\${MUI_PRODUCT}.lnk"
  Delete "$INSTDIR\*.*"
  Delete "$DESKTOP\${MUI_PRODUCT}.lnk"

  RMDir "$INSTDIR"

  DeleteRegKey /ifempty HKCU "Software\Pastexen"

SectionEnd




Function .onInit

  SetOutPath $TEMP
  File /oname=pastexen.bmp "pastexen.bmp"
  advsplash::show 2000 2000 250 -1 $TEMP\pastexen
  !insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd



