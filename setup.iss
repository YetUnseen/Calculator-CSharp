[Setup]
AppName=Hesap Makinesi
AppVersion=1.0
AppPublisher=Universite Projesi
; 32-bit Program Files (x86) klasörüne kurulmaya zorlar
DefaultDirName={pf32}\Hesap Makinesi
DefaultGroupName=Hesap Makinesi
; EULA metninin çekileceği dosya
LicenseFile=contract.txt
OutputDir=Output
OutputBaseFilename=setup
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
//to the respective directory of the calculator app file

[Icons]
Name: "{group}\Hesap Makinesi"; Filename: "{app}\CalculatorApp.exe"
Name: "{commondesktop}\Hesap Makinesi"; Filename: "{app}\CalculatorApp.exe"; Tasks: desktopicon

[Code]
var
  ValidationEdit: TEdit;
  ValidationLabel: TLabel;
  GeneratedCode: String;

procedure ValidationEditChange(Sender: TObject);
begin
  if Trim(ValidationEdit.Text) = GeneratedCode then
  begin
    WizardForm.LicenseAcceptedRadio.Enabled := True;
  end
  else
  begin
    WizardForm.LicenseAcceptedRadio.Enabled := False;
    WizardForm.LicenseAcceptedRadio.Checked := False;
    WizardForm.LicenseNotAcceptedRadio.Checked := True;
  end;
end;

procedure InitializeWizard();
begin
  Randomize;
  GeneratedCode := IntToStr(100000 + Random(900000));

  ValidationLabel := TLabel.Create(WizardForm);
  ValidationLabel.Parent := WizardForm.LicensePage;
  ValidationLabel.Caption := 'Sözleşmenin altındaki 6 haneli doğrulama kodunu giriniz:';
  ValidationLabel.Left := WizardForm.LicenseAcceptedRadio.Left;
  ValidationLabel.Top := WizardForm.LicenseNotAcceptedRadio.Top + WizardForm.LicenseNotAcceptedRadio.Height + 15;
  ValidationLabel.AutoSize := True;

  ValidationEdit := TEdit.Create(WizardForm);
  ValidationEdit.Parent := WizardForm.LicensePage;
  ValidationEdit.Left := ValidationLabel.Left;
  ValidationEdit.Top := ValidationLabel.Top + ValidationLabel.Height + 4;
  ValidationEdit.Width := 100;
  ValidationEdit.OnChange := @ValidationEditChange;

  WizardForm.LicenseAcceptedRadio.Enabled := False;
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpLicense then
  begin
    WizardForm.LicenseMemo.Text := WizardForm.LicenseMemo.Text + #13#10 + #13#10 + 
                                   '--------------------------------------------------' + #13#10 +
                                   'DOGRULAMA KODU: ' + GeneratedCode + #13#10 +
                                   '--------------------------------------------------';
  end;
end;
