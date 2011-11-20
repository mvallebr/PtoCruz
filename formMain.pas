unit formMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ToolWin, Buttons;

type
  TfrmMain = class(TForm)
    MainMenu: TMainMenu;
    Arquivo1: TMenuItem;
    Abrir1: TMenuItem;
    Novo1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    Salvar1: TMenuItem;
    SalvarComo1: TMenuItem;
    Ajuda1: TMenuItem;
    Sobre1: TMenuItem;
    Janela1: TMenuItem;
    LadoaLado1: TMenuItem;
    EmCascata1: TMenuItem;
    LadoaladoHorizontal1: TMenuItem;
    Arrumarcones1: TMenuItem;
    StatusBar1: TStatusBar;
    ToolBar3: TToolBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure Sair1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Novo1Click(Sender: TObject);
    procedure LadoaLado1Click(Sender: TObject);
    procedure EmCascata1Click(Sender: TObject);
    procedure LadoaladoHorizontal1Click(Sender: TObject);
    procedure Arrumarcones1Click(Sender: TObject);
    procedure Arquivo1Click(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure StatusBar1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Salvar1Click(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SalvarComo1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     numFiles: integer;
  end;

var
  frmMain: TfrmMain;

implementation

uses formBordado, formSobre, formNovo;

{$R *.DFM}

procedure TfrmMain.Sair1Click(Sender: TObject);
begin
     Close;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
     numFiles := 0;
end;

procedure TfrmMain.Novo1Click(Sender: TObject);
var
   frmnew:  TfrmNovo;
begin
     frmnew := TfrmNovo.create(self);
     frmnew.ShowModal;
     frmNew.free;
end;

procedure TfrmMain.LadoaLado1Click(Sender: TObject);
begin
     tileMode := tbVertical;
     tile;
end;

procedure TfrmMain.EmCascata1Click(Sender: TObject);
begin
     Cascade;
end;

procedure TfrmMain.LadoaladoHorizontal1Click(Sender: TObject);
begin
     tileMode := tbHorizontal;
     tile;
end;

procedure TfrmMain.Arrumarcones1Click(Sender: TObject);
begin
     ArrangeIcons;
end;

procedure TfrmMain.Arquivo1Click(Sender: TObject);
begin
     if (ActiveMDIChild=nil) then begin
        Salvar1.Enabled := false;
        SalvarComo1.enabled := false;
     end else begin
        Salvar1.Enabled := true;
        SalvarComo1.enabled := true;
     end;
end;

procedure TfrmMain.Sobre1Click(Sender: TObject);
var
   frmSobre: TfrmSobre;
begin
     frmSobre := TfrmSobre.create(self);
     frmSobre.ShowModal;
     frmSobre.free;
end;

procedure TfrmMain.StatusBar1Click(Sender: TObject);
begin
     ShowMessage(IntToStr(self.PixelsPerInch));
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
begin
     Novo1Click(Sender);
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
begin
     Abrir1Click(Sender);
end;

procedure TfrmMain.Salvar1Click(Sender: TObject);
begin
     ShowMessage('Em implementação!');
end;

procedure TfrmMain.Abrir1Click(Sender: TObject);
begin
     ShowMessage('Em implementação!');
end;

procedure TfrmMain.SpeedButton3Click(Sender: TObject);
begin
     Salvar1Click(Sender);
end;

procedure TfrmMain.SalvarComo1Click(Sender: TObject);
begin
     ShowMessage('Em implementação!');
end;

end.
