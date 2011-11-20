unit camada;

interface

//uses graphics, classes, Windows;

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Grids, ExtCtrls, StdCtrls, ComCtrls, ToolWin, checklst, bde,
  Buttons;

type
  TCamada = class

  private
    { Private declarations }
    bitmap:   TBitmap;
    pstretchWidth, pstretchHeight: integer;
  public
    { Public declarations }
    width, height:   integer;
    top, left:       integer;
    Canvas: TCanvas;
    procedure SetStretchWidth(newwidth: integer);
    function  GetStretchWidth: integer;
    procedure SetStretchHeight(newheight: integer);
    function  GetStretchHeight: integer;
    procedure Desenhe;
    procedure SetBitmap(bmp: TBitmap);
    constructor Create(parentCanvas: TCanvas);
    destructor Destroy; override;
  published
    property stretchWidth:Integer read GetStretchWidth write SetStretchWidth;
    property stretchHeight:Integer read GetStretchHeight write SetStretchHeight;
  end;

implementation

procedure TCamada.Desenhe;
var
   bmp:   TBitmap;
begin
     bmp := TBitmap.create;
     bmp.width  := stretchwidth;
     bmp.Height := stretchheight;
     bmp.TransparentMode := tmAuto;
     bmp.Transparent := true;
     bmp.Canvas.StretchDraw(Rect(0,0,stretchwidth,stretchheight), bitmap);
     Canvas.StretchDraw(Rect(0,0,width,height), bmp);

     bmp.Destroy;
end;

constructor TCamada.Create(parentCanvas: TCanvas);
begin
     inherited Create;
     bitmap := TBitmap.Create;
     Canvas := parentCanvas;
     top := 0; left := 0; width := 0; height := 0;
     bitmap.TransparentMode := tmAuto;
     bitmap.Transparent := true;
end;

destructor TCamada.Destroy;
begin
     bitmap.Destroy;

     inherited Destroy;
end;

procedure TCamada.SetBitmap(bmp: TBitmap);
begin
     bitmap.width  := bmp.width;
     bitmap.height := bmp.height;
     bitmap.Canvas.StretchDraw (Rect(0,0,bitmap.width,bitmap.height), bmp);
end;
procedure TCamada.SetStretchWidth(newwidth: integer);
begin
          pstretchWidth  := newwidth;
end;
function  TCamada.GetStretchWidth: integer;
begin
     Result := pstretchWidth;
end;
procedure TCamada.SetStretchHeight(newHeight: integer);
begin
          pstretchHeight  := newHeight;
end;
function  TCamada.GetStretchHeight: integer;
begin
     Result := pstretchHeight;
end;
end.
