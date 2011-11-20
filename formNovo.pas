unit formNovo;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, Dialogs, ExtDlgs, Spin;

type
  TfrmNovo = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    OKBtn: TButton;
    CancelBtn: TButton;
    HelpBtn: TButton;
    Label1: TLabel;
    edtArquivo: TEdit;
    Button1: TButton;
    dlgArquivo: TOpenPictureDialog;
    RadioGroup1: TRadioGroup;
    CheckBox1: TCheckBox;
    edtLargura: TSpinEdit;
    Label2: TLabel;
    edtAltura: TSpinEdit;
    Label3: TLabel;
    chkPreservar: TCheckBox;
    imgpreview: TImage;
    procedure Button1Click(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure chkPreservarClick(Sender: TObject);
    procedure edtLarguraExit(Sender: TObject);
    procedure edtAlturaExit(Sender: TObject);
    procedure edtAlturaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpinEdit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtLarguraKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure edtLarguraChange(Sender: TObject);
    procedure edtAlturaChange(Sender: TObject);
  private
    { Private declarations }
    bmpwidth, bmpheight:   integer;
    procedure update_img_size;
  public
    { Public declarations }
  end;

var
  frmNovo: TfrmNovo;

implementation

uses formBordado;
{$R *.DFM}


procedure TfrmNovo.Button1Click(Sender: TObject);
begin
     if dlgArquivo.Execute then begin
        try
              imgpreview.Picture.loadfromfile(dlgarquivo.filename);
              bmpwidth := imgpreview.Picture.width;
              bmpheight := imgpreview.Picture.height;
              if chkPreservar.Checked then
                 edtAltura.value := round(edtLargura.Value*bmpheight/bmpwidth);
              edtArquivo.text := dlgArquivo.FileName;
              update_img_size;
        except
              ShowMessage('Não pude abrir o arquivo especificado!');
        end;
     end;

end;

procedure TfrmNovo.OKBtnClick(Sender: TObject);
begin
     if trim(edtArquivo.text)<>'' then begin
          create_formBordado(edtArquivo.text,edtLargura.value, edtAltura.value);
          Close;
     end else
         ShowMessage('Por favor, digite o nome do arquivo!');

end;

procedure TfrmNovo.chkPreservarClick(Sender: TObject);
begin
     if chkPreservar.Checked then
        edtAltura.value := round(edtLargura.Value*bmpheight/bmpwidth);
end;

procedure TfrmNovo.edtLarguraExit(Sender: TObject);
begin
     if chkPreservar.Checked then
        edtAltura.value := round(edtLargura.Value*bmpheight/bmpwidth);
end;

procedure TfrmNovo.edtAlturaExit(Sender: TObject);
begin
     if chkPreservar.Checked then
        edtLargura.value := round(edtAltura.Value*bmpwidth/bmpheight);
end;

procedure TfrmNovo.edtAlturaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=13 then
        edtAlturaExit(Sender);
end;

procedure TfrmNovo.SpinEdit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=13 then
        edtLarguraExit(Sender);
end;

procedure TfrmNovo.edtLarguraKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=13 then
        edtLarguraExit(Sender);
end;

procedure TfrmNovo.FormCreate(Sender: TObject);
begin
     bmpwidth :=1;
     bmpheight := 1;
     Button1Click(Sender);
end;

procedure TfrmNovo.edtLarguraChange(Sender: TObject);
begin
     update_img_size;
end;

procedure TfrmNovo.edtAlturaChange(Sender: TObject);
begin
     update_img_size;
end;

procedure TfrmNovo.update_img_size;
begin
     if (edtLargura.value/edtAltura.value)>(bmpwidth/bmpheight) then begin
        if (bmpwidth>bmpheight) then
           imgpreview.width := 185
        else
            imgpreview.width := round(153*bmpwidth/bmpheight);
        imgpreview.height := round(imgpreview.width*edtAltura.Value/edtLargura.Value);
     end else begin
         if (bmpwidth>bmpheight) then
            imgpreview.height := round(185*bmpheight/bmpwidth)
         else
             imgpreview.height := 153;
         imgpreview.width := round(imgpreview.height*edtLargura.Value/edtAltura.Value);
     end;
end;

end.

