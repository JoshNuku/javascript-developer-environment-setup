
[Tasks]
Name: "installgit"; Description: "Install Git"; GroupDescription: "Select software to install:"; Flags: unchecked
Name: "installnode"; Description: "Install Node.js LTS"; Flags: unchecked
Name: "installvscode"; Description: "Install Visual Studio Code"; Flags: unchecked
Name: "installchrome"; Description: "Install Google Chrome"; Flags: unchecked
Name: "installcursor"; Description: "Install Cursor AI Assistant"; Flags: unchecked
Name: "installmongodb"; Description: "Install MongoDB"; Flags: unchecked
Name: "installmongosh"; Description: "Install Mongo Shell (mongosh)"; Flags: unchecked
Name: "installnpmglobal"; Description: "Install global npm packages (eslint, prettier, typescript, nodemon)"; Flags: unchecked
Name: "installnpmframeworks"; Description: "Install popular JS frameworks globally (react, next, express, etc.)"; Flags: unchecked
Name: "installvscodeexts"; Description: "Install VSCode extensions (ESLint, Prettier, npm Intellisense, etc.)"; Flags: unchecked

[Files]
Source: "setup-dev.ps1"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Run]
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -File ""{tmp}\setup-dev.ps1"" {paramflags}"; Flags: runhidden waituntilterminated

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

  if IsTaskSelected('installcursor') then
    ParamFlags := ParamFlags + ' -InstallCursor';

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

  WizardForm.RunList.Items[0] := 'powershell.exe -ExecutionPolicy Bypass -File "' +
    ExpandConstant('{tmp}\setup-dev.ps1') + '"' + ParamFlags;

  Result := '';
end;
