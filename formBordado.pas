unit formBordado;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Grids, ExtCtrls, StdCtrls, ComCtrls, ToolWin, checklst, bde,
  Buttons, printers;


type
  TfrmBordado = class(TForm)
    MainMenu: TMainMenu;
    Ponto1: TMenuItem;
    Editar1: TMenuItem;
    Camada1: TMenuItem;
    Editar2: TMenuItem;
    Bordado1: TMenuItem;
    Atualizar1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter2: TSplitter;
    Splitter1: TSplitter;
    ScrollBox: TScrollBox;
    Bordado: TImage;
    Opes1: TMenuItem;
    Cordagradeprimria1: TMenuItem;
    Cordagradesecundria1: TMenuItem;
    Cordofundo1: TMenuItem;
    ColorDialog: TColorDialog;
    Visualizar1: TMenuItem;
    Grade: TMenuItem;
    Editar3: TMenuItem;
    N1: TMenuItem;
    Grade2: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    camadas: TCheckListBox;
    ToolBar1: TToolBar;
    btnNewCamada: TSpeedButton;
    btnDelCamada: TSpeedButton;
    ToolButton1: TToolButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    GroupBox2: TGroupBox;
    lstContornos: TCheckListBox;
    ToolBar2: TToolBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ToolButton2: TToolButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    ToolBar3: TToolBar;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    Splitter3: TSplitter;
    ToolBar4: TToolBar;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    Splitter4: TSplitter;
    N2: TMenuItem;
    Imprimir1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Atualizar1Click(Sender: TObject);
    procedure Cordagradeprimria1Click(Sender: TObject);
    procedure Cordagradesecundria1Click(Sender: TObject);
    procedure Cordofundo1Click(Sender: TObject);
    procedure GradeClick(Sender: TObject);
    procedure Editar3Click(Sender: TObject);
    procedure Editar1Click(Sender: TObject);
    procedure Editar2Click(Sender: TObject);
    procedure Grade2Click(Sender: TObject);
    procedure camadasClickCheck(Sender: TObject);
    procedure Imprimir1Click(Sender: TObject);
  private
    { Private declarations }
    cor1:                   TColor;
    cor2:                   TColor;
  public
    { Public declarations }
    tamquadrado:            integer;
    tamquadradof:           Real;
    Tamanho, tamanho2:      TSize;
    procedure DesenheContornos;
    procedure DesenheGrade;
    procedure DesenheCelulas;
    procedure DesenheTudo;
  end;

procedure create_formBordado(Filename:String; w, h:integer);
var
  frmBordado: TfrmBordado;
implementation
uses formMain, camada;
{$R *.DFM}
procedure create_formBordado(Filename:String; w, h:integer);
var
   frmnew:  TfrmBordado;
   bmp:     TBitmap;
   pic:     TPicture;
   camada:  TCamada;
begin
     try
        bmp := TBitmap.Create;
        pic := TPicture.create;
        bmp.TransparentMode := tmAuto;
        bmp.Transparent := true;
        pic.LoadFromFile(Filename);
        bmp.width := pic.Width;
        bmp.height:= pic.Height;
        bmp.canvas.Draw (0,0,pic.Graphic);
        pic.free;
     except
           ShowMessage('Não consegui ler uma imagem do arquivo!');
           exit;
     end;

     Inc(frmMain.numFiles);
     frmnew := TfrmBordado.create(Application);
     frmnew.caption := 'Bordado ' + IntToStr(frmMain.numFiles);
     frmNew.Tamanho.cx := w div 2;
     frmNew.Tamanho.cy := h div 2;
     frmNew.Bordado.Picture.Bitmap.Width  := Round(frmNew.Tamanho.cx*frmNew.tamquadradof)+1;
     frmNew.Bordado.Picture.Bitmap.Height := Round(frmNew.Tamanho.cy*frmNew.tamquadradof)+1;

     camada := TCamada.create(frmNew.Bordado.Picture.Bitmap.Canvas);
     camada.width  := frmNew.Bordado.Picture.Bitmap.Width;
     camada.height := frmNew.Bordado.Picture.Bitmap.Height;
     camada.stretchwidth := frmNew.Tamanho.cx;
     camada.stretchheight := frmNew.Tamanho.cy;
     camada.SetBitmap(bmp);
     frmNew.camadas.Items.Objects[0]:=camada;
     frmNew.camadas.Checked[0] := true;
     
     frmNew.DesenheTudo;
     bmp.free;
end;

procedure TfrmBordado.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action := caFree;

end;

procedure TfrmBordado.FormCreate(Sender: TObject);
var
   tamtemp: real;
begin
     //Inicializa ponteiros e variáveis

     bordado.picture.bitmap.Canvas.Brush.Color := ScrollBox.Color;
     cor1 := clGray;
     cor2 := clBlack;
     //Seta tamanho dos quadrados em pixels
     tamtemp := self.PixelsPerInch / 2.53298; //Um centímetro
     tamtemp := tamtemp * 2; //Dois centímetros
     tamtemp := tamtemp / 10; //dois milímetros
     tamquadrado := round(tamtemp);
     tamquadradof := tamtemp;
     tamanho2.cx := 10;
     tamanho2.cy := 10;

end;

procedure TfrmBordado.DesenheContornos;
var
   cor: TColor;
begin
     with Bordado.Canvas do begin
          //Guarda a cor antiga da caneta
          cor := Pen.color;

          //Desenha arco de brincadeira...
          Pen.color := clBlack;
//          Polygon([Point(0,0), Point(15,15), Point(30,5)]);
          //Restaura a cor antiga da caneta
          Pen.color := cor;
     end;

end;

procedure TfrmBordado.DesenheGrade;
var
   cor: TColor;
   i: integer;
begin
     with bordado.Picture.Bitmap.Canvas do begin
     //Guarda a cor antiga da caneta
     cor := Pen.color;
     if grade.Checked then begin
          //Desenha grade primária
          Pen.Color := cor1;
          Pen.Width := 1;
          Application.ProcessMessages;
          //Usei muitas multiplicações dentro do loop para evitar erros
          // de arredondamento, mesmo sabendo que é mais lento.
          for i := 0 to round(Bordado.width/tamquadradof) do begin
              MoveTo(round(i*tamquadradof), 0);
              LineTo(round(i*tamquadradof), Bordado.Height);
          end;
          for i := 0 to round(Bordado.height/tamquadradof) do begin
              MoveTo(0, round(i*tamquadradof));
              LineTo(Bordado.Width, round(i*tamquadradof));
          end;
     end;
     if grade2.checked then begin
          //Desenha grade secundária
          Pen.Color := cor2;
          Pen.Width := 2;
//          brush.color := cor2;
//          bordado.Picture.Bitmap.Canvas.Ellipse (0,0,300,170);
          Application.ProcessMessages;
          for i := 0 to round(Bordado.width/tamquadradof)div tamanho2.cx  do begin
              MoveTo(round(tamanho2.cx*i*tamquadradof), 0);
              LineTo(round(tamanho2.cx*i*tamquadradof), Bordado.Height);
          end;
          for i := 0 to round(Bordado.height/tamquadradof)div tamanho2.cy do begin
              MoveTo(0, round(tamanho2.cy*i*tamquadradof));
              LineTo(Bordado.Width, round(tamanho2.cy*i*tamquadradof));
          end;
          //Restaura a cor antiga da caneta
          Pen.color := cor;
          Pen.Width := 1;
     end;
     end;
end;
procedure TfrmBordado.DesenheCelulas;
var
   i:     integer;
begin
     for i := 0 to camadas.items.count-1 do
         if camadas.Checked[i] then
            TCamada(camadas.Items.Objects[i]).Desenhe;
end;

procedure TfrmBordado.DesenheTudo;
begin
     Bordado.Picture.Bitmap.Canvas.FillRect (Rect(0,0,Bordado.width, Bordado.height));
     DesenheCelulas;
     DesenheGrade;
     DesenheContornos;
end;

procedure TfrmBordado.FormPaint(Sender: TObject);
begin
//
end;

procedure TfrmBordado.FormDestroy(Sender: TObject);
begin
     camadas.Destroy;
end;

procedure TfrmBordado.Atualizar1Click(Sender: TObject);
begin
     DesenheTudo;
end;

procedure TfrmBordado.Cordagradeprimria1Click(Sender: TObject);
begin
     if ColorDialog.Execute then
        cor1 := ColorDialog.Color;
     DesenheTudo;
end;

procedure TfrmBordado.Cordagradesecundria1Click(Sender: TObject);
begin
     if ColorDialog.Execute then
        cor2 := ColorDialog.Color;
     DesenheTudo;
end;

procedure TfrmBordado.Cordofundo1Click(Sender: TObject);
begin
     if ColorDialog.Execute then  begin
        Scrollbox.Color := ColorDialog.Color;
        Bordado.picture.Bitmap.canvas.brush.Color := ColorDialog.Color;
        DesenheTudo;
     end;
end;

procedure TfrmBordado.GradeClick(Sender: TObject);
begin
     Grade.checked := not Grade.checked;
     DesenheTudo;
end;

procedure TfrmBordado.Editar3Click(Sender: TObject);
begin
     ShowMessage('Não Implementado!');
end;

procedure TfrmBordado.Editar1Click(Sender: TObject);
begin
     ShowMessage('Não Implementado!');
end;

procedure TfrmBordado.Editar2Click(Sender: TObject);
begin
     ShowMessage('Não Implementado!');
end;

procedure TfrmBordado.Grade2Click(Sender: TObject);
begin
     Grade2.checked := not Grade2.checked;
     DesenheTudo;
end;

procedure TfrmBordado.camadasClickCheck(Sender: TObject);
begin
     Desenhetudo;
end;

procedure TfrmBordado.Imprimir1Click(Sender: TObject);
begin
     with Printer do
    begin
      BeginDoc;
      Canvas.Draw((PageWidth - Bordado.Width) div 2,
                  (PageHeight - Bordado.Height) div 2,
                  Bordado.Picture.Bitmap);
      EndDoc;
      end;
end;

end.
