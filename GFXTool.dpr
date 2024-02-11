program GFXTool;

uses
  Vcl.Forms,
  main in 'main.pas' {Form1},
  pixeledit in 'pixeledit.pas' {PE},
  LanguageIni in 'LanguageIni.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TPE, PE);
  Application.Run;
end.
