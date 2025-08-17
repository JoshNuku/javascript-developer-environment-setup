#define MyAppName "JavaScript Developer Environment Setup"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Joshua Nuku"
#define MyAppURL "https://github.com/JoshNuku/javascript-developer-environment-setup"

[Setup]
AppId={{78E67587-F4B1-4075-BBC8-6CE3A5697360}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}

CreateAppDir=no
PrivilegesRequired=admin

LicenseFile=LICENSE.txt
InfoBeforeFile=PreInstallInfo.txt
InfoAfterFile=PostInstallInfo.txt

OutputDir=.
OutputBaseFilename=js-dev-env-setup
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "installgit"; Description: "Install Git"; GroupDescription: "Select software to install:"; Flags: unchecked
Name: "installnode"; Description: "Install Node.js LTS"; Flags: unchecked
Name: "installvscode"; Description: "Install Visual Studio Code"; Flags: unchecked
Name: "installchrome"; Description: "Install Google Chrome"; Flags: unchecked
Name: "installmongodb"; Description: "Install MongoDB"; Flags: unchecked
Name: "installmongosh"; Description: "Install Mongo Shell (mongosh)"; Flags: unchecked
Name: "installnpmglobal"; Description: "Install global npm packages (eslint, prettier, typescript, nodemon)"; Flags: unchecked
Name: "installnpmframeworks"; Description: "Install popular JS frameworks globally (react, next, express, etc.)"; Flags: unchecked
Name: "installvscodeexts"; Description: "Install VSCode extensions (ESLint, Prettier, npm Intellisense, etc.)"; Flags: unchecked

[Files]
Source: "setup-dev.ps1"; DestDir: "{tmp}"; Flags: deleteafterinstall

; Removed [Run] section because we run PowerShell dynamically in code

[Code]
var
  ParamFlags: String;

procedure InitializeWizard();
begin
  ParamFlags := '';
end;

function PrepareToInstall(var NeedsRestart: Boolean): String;
begin
  ParamFlags := '';

  if IsTaskSelected('installgit') then
    ParamFlags := ParamFlags + ' -InstallGit';

  if IsTaskSelected('installnode') then
    ParamFlags := ParamFlags + ' -InstallNode';

  if IsTaskSelected('installvscode') then
    ParamFlags := ParamFlags + ' -InstallVSCode';

  if IsTaskSelected('installchrome') then
    ParamFlags := ParamFlags + ' -InstallChrome';

  if IsTaskSelected('installmongodb') then
    ParamFlags := ParamFlags + ' -InstallMongoDB';

  if IsTaskSelected('installmongosh') then
    ParamFlags := ParamFlags + ' -InstallMongoSH';

  if IsTaskSelected('installnpmglobal') then
    ParamFlags := ParamFlags + ' -InstallNpmGlobals';

  if IsTaskSelected('installnpmframeworks') then
    ParamFlags := ParamFlags + ' -InstallNpmFrameworks';

  if IsTaskSelected('installvscodeexts') then
    ParamFlags := ParamFlags + ' -InstallVSCodeExts';

  Result := '';
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: Integer;
  CmdLine: String;
begin
  if CurStep = ssPostInstall then
  begin
    CmdLine := 'powershell.exe -ExecutionPolicy Bypass -File "' + ExpandConstant('{tmp}\setup-dev.ps1') + '"' + ParamFlags;
    if not Exec('powershell.exe', '-ExecutionPolicy Bypass -File "' + ExpandConstant('{tmp}\setup-dev.ps1') + '"' + ParamFlags, '', SW_HIDE, ewWaitUntilTerminated, ResultCode) then
    begin
      MsgBox('Failed to run setup script. Error code: ' + IntToStr(ResultCode), mbError, MB_OK);
      WizardForm.Close;
    end;
  end;
end;