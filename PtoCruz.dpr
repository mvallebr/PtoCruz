program PtoCruz;

uses
  Forms,
  formMain in 'formMain.pas' {frmMain},
  formBordado in 'formBordado.pas' {frmBordado},
  formSobre in 'formSobre.pas' {frmSobre},
  ponto in 'ponto.pas',
  formNovo in 'formNovo.pas' {frmNovo},
  camada in 'camada.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
