[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{35070FA4-AFC7-44D2-BA7A-5D610244C667}
AppName=Emacs
AppVerName={cm:NameAndVersion,Emacs, 23.4}
AppPublisher=GNU
AppPublisherURL=http://www.gnu.org/software/emacs
AppSupportURL=http://www.gnu.org/software/emacs
AppUpdatesURL=http://www.gnu.org/software/emacs
DefaultDirName={pf}\GNU\Emacs
DefaultGroupName="GNU Emacs"
OutputDir=.
OutputBaseFilename="emacs-23.4-setup"
Compression=lzma
SolidCompression=yes
VersionInfoCompany=GNU
VersionInfoVersion=23.4.0.1
VersionInfoDescription=GNU Emacs 23.4 setup

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"; LicenseFile: "emacs-23.4\COPYING"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; Flags: unchecked
Name: "contextmenu"; Description: "Add emacs to context menu"

[Files]
Source: "emacs-23.4\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: default.el; DestDir: "{app}\site-lisp"; Flags: ignoreversion; Tasks: contextmenu
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\GNU Emacs"; Filename: "{app}\bin\runemacs.exe"; WorkingDir: "%UserProfile%"
Name: "{group}\{cm:UninstallProgram,GNU Emacs}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\GNU Emacs"; Filename: "{app}\bin\runemacs.exe"; WorkingDir: "%UserProfile%"; Tasks: desktopicon

[Registry]
Root: HKCR; Subkey: "*\shell\emacs"; ValueType: string; ValueData: "Edit with emacs"; Flags: uninsdeletekey; Tasks: contextmenu
Root: HKCR; Subkey: "*\shell\emacs\command"; ValueType: string; ValueData: """{app}\bin\emacsclientw.exe"" -n -a ""{app}\bin\runemacs.exe"" ""%1"""; Tasks: contextmenu

[Run]
Filename: "{app}\bin\runemacs.exe"; Description: "{cm:LaunchProgram,Emacs}"; Flags: nowait postinstall skipifsilent






