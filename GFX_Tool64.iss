; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "GFX_Tool64"
#define MyAppVersion "3.1"
#define MyAppPublisher "Gerald Lechner"
#define MyAppURL "https://github.com/GerLech/GFX-Tool-Delphi"
#define MyAppExeName "GFXTool.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{B0811D43-2280-44BF-854F-3289CA295238}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
OutputDir=C:\Users\Gerald\OneDrive\Documents\Embarcadero\Studio\Projekte\GFX-Tool\Win64
OutputBaseFilename=GFX_Tool64_Setup
SetupIconFile=C:\Users\Gerald\OneDrive\Documents\Embarcadero\Studio\Projekte\GFX-Tool\GFXTool_Icon.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Users\Gerald\OneDrive\Documents\Embarcadero\Studio\Projekte\GFX-Tool\Win64\Debug\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Gerald\OneDrive\Documents\Embarcadero\Studio\Projekte\GFX-Tool\Win64\Debug\lang1GE.ini"; DestDir: "{commonappdata}\GFX_Tool\"; Flags: ignoreversion
Source: "C:\Users\Gerald\OneDrive\Documents\Embarcadero\Studio\Projekte\GFX-Tool\Win64\Debug\lang2EN.ini"; DestDir: "{commonappdata}\GFX_Tool\"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

