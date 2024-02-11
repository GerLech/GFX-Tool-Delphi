unit pixeledit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.NumberBox, System.ImageList, Vcl.ImgList, Vcl.Buttons, Vcl.Mask, LanguageIni ;

type
  TGlyph = record
  offset : word;
  w : Integer;
  h : Integer;
  adv : Integer;
  xo : Integer;
  yo : Integer;
  end;

  TMemArray = Array of Byte;

  TPE = class(TForm)
    pb: TPaintBox;
    Button1: TButton;
    Button2: TButton;
    nbw: TNumberBox;
    Label7: TLabel;
    nbh: TNumberBox;
    Label1: TLabel;
    nbadv: TNumberBox;
    Label2: TLabel;
    nbxo: TNumberBox;
    Label3: TLabel;
    nbyo: TNumberBox;
    Label4: TLabel;
    le: TPaintBox;
    FD: TFontDialog;
    Letter: TEdit;
    Button3: TButton;
    Button4: TButton;
    mvleft: TSpeedButton;
    ImageList1: TImageList;
    mvup: TSpeedButton;
    mvright: TSpeedButton;
    mvdown: TSpeedButton;
    sw: TNumberBox;
    lix: TLabel;
    nix: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    HL1: TNumberBox;
    HL2: TNumberBox;
    Label8: TLabel;
    Panel1: TPanel;
    Label9: TLabel;
    procedure pbPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nbxoChangeValue(Sender: TObject);
    procedure nbyoChangeValue(Sender: TObject);
    procedure nbwChangeValue(Sender: TObject);
    procedure nbhChangeValue(Sender: TObject);
    procedure nbadvChangeValue(Sender: TObject);
    procedure pbMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LetterChange(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure moveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lePaint(Sender: TObject);
    procedure nixChange(Sender: TObject);
    procedure nixKeyPress(Sender: TObject; var Key: Char);
    procedure HL1ChangeValue(Sender: TObject);

  private
    { Private-Deklarationen }
    FGlyph : TGlyph;
    FBaseline : integer;
    FIndex : integer;
    ffontheight : integer;
    xOffset:integer;
    yOffset:integer;
    FReady : Byte;
    FBm : array[0..50,0..50] of boolean;
    procedure PaintGrid;
    procedure SetGlyph(val : TGlyph);
    procedure SetPixels(val : TMemArray);
    procedure SetIndex(val : integer);
    procedure SetBaseline(val : integer);
    procedure SetFontheight(val : integer);
    function GetPixels: TMemArray;
    function CheckRow(r:integer):boolean;
    function CheckCol(c:integer):boolean;
    function pixelBlack(col : TColor) : boolean;
  public
    { Public-Deklarationen }
    property Index : integer read FIndex write SetIndex;
    property Glyph : tGlyph read FGlyph write SetGlyph;
    property Pixels : TMemArray read GetPixels write SetPixels;
    property Baseline : Integer read FBaseLine write setBaseline;
    property Fontheight : Integer read fFontHeight write SetFontHeight;
    property Ready : Byte read FReady write FReady;
  end;

var
  PE: TPE;

implementation

uses main;

{$R *.dfm}
procedure TPE.pbMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var x1,x2,y1,y2,r,c : integer;
begin
  x1:=xOffset * 10; x2 := (xOffset + glyph.w) * 10;
  y1:=yOffset * 10; y2 := (yOffset + glyph.h) * 10;
  if (x >= x1) and (y >= y1) and (x <= x2) and (y <= y2) then
  begin
    c := (x - x1) div 10;
    r := (y - y1) div 10;
    FBm[c,r] := not FBm[c,r];
    PaintGrid;
  end;
end;

procedure TPE.pbPaint(Sender: TObject);
begin
  PaintGrid;
end;

procedure TPE.SetGlyph(val: TGlyph);
begin
  FGlyph := val;
  nbw.Value := val.w;
  nbh.Value := val.h;
  nbadv.Value := val.adv;
  nbxo.Value := val.xo;
  nbyo.Value := val.yo;
  PaintGrid;
  Ready := Ready OR 2;
end;

procedure TPE.SetIndex(val: Integer);
var c:char;
begin
  FIndex := val;
  nix.text := InttoHex(val,2);
  if Index > 32 then
  begin
    c:=char(index);

    letter.Text := c;
    letterChange(letter);
  end;
  
end;


procedure TPE.SetFontheight(val: Integer);
begin
  FFontheight := val;
  Ready := Ready OR 1
end;

procedure TPE.SetBaseline(val: Integer);
begin
  fBaseline := val;
end;

procedure TPE.PaintGrid;
var c,r,xo :integer;
    rc : TRect;
begin
  pb.Canvas.Brush.Color := clSilver;
  pb.Canvas.Pen.Color := clGray;
  pb.Canvas.Pen.Width := 1;
  for r := 0 to 50 do
    for c := 0 to 50 do
    begin
       rc := Rect(c*10,r*10, (c+1)*10, (r +1) * 10);
       pb.Canvas.FillRect(rc);
       pb.Canvas.Rectangle(rc);
    end;
  if (Ready >= 7) then
  begin
   xOffset := glyph.xo;
   if xOffset < 0 then xOffset:=0;
   
   yOffset :=baseline + glyph.yo;
   for r := 0 to glyph.h -1 do
     for c := 0 to glyph.w - 1 do
     begin
       if FBm[c,r] then pb.Canvas.Brush.Color := clBlack else pb.Canvas.Brush.Color := clWhite;
       rc := Rect((xOffset+c)*10,(yOffset+r)*10, (xOffset+c+1)*10, (yOffset + r +1) * 10);
       pb.Canvas.FillRect(rc);
       pb.Canvas.Rectangle(rc);

     end;


  end;

  pb.Canvas.Pen.Width := 2;
  pb.Canvas.Pen.Color := clYellow;
  pb.Canvas.MoveTo(0,(baseline+1) * 10); pb.Canvas.LineTo(500,(baseline+1) * 10);
  if glyph.xo <0 then xo := glyph.xo * -1 else xo :=0;
  pb.Canvas.Pen.Color := clRed;
  pb.Canvas.MoveTo(xo*10,0); pb.Canvas.LineTo(xo * 10,500);
  pb.Canvas.Pen.Color := clAqua;
  pb.Canvas.MoveTo((xo + Glyph.adv) * 10,0); pb.Canvas.LineTo((xo+glyph.adv) * 10,500);
  pb.Canvas.Pen.Color := clLime;
  pb.Canvas.MoveTo(0,Round(HL1.Value) * 10); pb.Canvas.LineTo(500,Round(HL1.Value) * 10);
  pb.Canvas.MoveTo(0,Round(HL2.Value) * 10); pb.Canvas.LineTo(500,Round(HL2.Value) * 10);
  pb.Canvas.Pen.Color := clRed;
  pb.Canvas.MoveTo(0,(fontheight+1) * 10); pb.Canvas.LineTo(500,(fontheight+1) * 10);
end;

procedure TPE.Button3Click(Sender: TObject);
var xmin,xmax,ymin,ymax,r,c : integer;
    f : boolean;
    col : TColor;
begin
  r:=0; f := false;
  xmax := 0; xmin := 0;
  ymax := 0; ymin := 0;
  while (r<50) and (not f) do
  begin
    f := checkrow(r);
    if f then ymin := r;
    inc(r);
  end;
  r:=49; f := false;
  while (r>=0) and (not f) do
  begin
    f := checkrow(r);
    if f then ymax := r;
    dec(r);
  end;
  c:=0; f := false;
  while (c<50) and (not f) do
  begin
    f := checkcol(c);
    if f then xmin := c;
    inc(c);
  end;
  c:=49; f := false;
  while (c>=0) and (not f) do
  begin
    f := checkcol(c);
    if f then xmax := c;
    dec(c);
  end;
  fglyph.w := xmax - xmin + 1;
  fglyph.h := ymax - ymin + 1;
  fglyph.yo := (fglyph.h -1) * -1;
  nbyo.Value := fglyph.yo;
  nbw.Value := fglyph.w;
  nbh.Value := fglyph.h;
  for c := 0 to fglyph.w do
    begin
    for r := 0 to fglyph.h do
      begin
      col := le.Canvas.Pixels[xmin+c,ymin+r];
       FBm[c,r] := pixelBlack(col);
      end;
    end;
  PaintGrid;
end;

function TPe.pixelBlack(col: TColor): Boolean;
var
  r,g,b : byte;
begin
  r:= getRVAlue(col);
  g:= getGVAlue(col);
  b:= getBVAlue(col);
  Result := ((r+b+g) div 3) < sw.Value;
end;

function TPE.checkrow(r:integer):boolean;
var c:integer;
begin
  result:= false; c:=0;
  while(c < 50) and (not result) do
  begin
    result := pixelBlack(le.Canvas.Pixels[c,r]);
    inc(c);
  end;
end;

function TPE.checkcol(c:integer):boolean;
var r:integer;
begin
  result:= false; r:=0;
  while(r < 50) and (not result) do
  begin
    result := pixelBlack(le.Canvas.Pixels[c,r]);
    inc(r);
  end;
end;

procedure TPE.Button4Click(Sender: TObject);
begin
  if fd.Execute then
  begin
    le.Canvas.Font:= fd.Font;
    LetterChange(self);
  end;
end;

procedure TPE.FormCreate(Sender: TObject);
begin
  Ready := 0;
  TLangIni.ReadLanguage(self,'PE', Form1.language.Text);
end;

procedure TPE.FormShow(Sender: TObject);
begin
    le.Canvas.Font:= fd.Font;
    LetterChange(self);
end;

function TPE.GetPixels: TMemArray;
var l,i,c,r : integer;
    m : word;
    b : byte;
begin
  l := (glyph.w * glyph.h + 7) div 8;
  SetLength(Result,l);
  b:=0; m:= 128; i:= 0;
  for r := 0 to glyph.h - 1 do
    for c := 0 to glyph.w - 1 do
      begin
        if FBm[c,r] then b := b or m;
        m := m shr 1;
        if m = 0 then
        begin
          m := 128;
          result[i]:=b;
          b:=0;
          inc(i);
        end;
      end;
  if i < l then result[i] := b;

end;

procedure TPE.HL1ChangeValue(Sender: TObject);
begin
  paintGrid;
end;

procedure TPE.lePaint(Sender: TObject);
begin
    le.Canvas.Brush.Color := clWhite;
    le.Canvas.Font := FD.Font;
    le.Canvas.FillRect(le.Canvas.ClipRect);
    le.Canvas.TextOut(0,0,letter.Text);
end;

procedure TPE.LetterChange(Sender: TObject);
begin
    le.Canvas.Brush.Color := clWhite;
    le.Canvas.Font := FD.Font;
    le.Canvas.FillRect(le.Canvas.ClipRect);
    le.Canvas.TextOut(0,0,letter.Text);
end;

procedure TPE.moveClick(Sender: TObject);
var c,r :integer;
begin
  if TSpeedButton(sender).Name = 'mvup' then
  begin
    for r := 1 to glyph.h  do for c := 0 to Glyph.w do  fBm[c,r-1] := FBm[c,r];
    for c := 0 to Glyph.w do  fBm[c,Glyph.h] := false;
  end;
  if TSpeedButton(sender).Name = 'mvdown' then
  begin
    for r := glyph.h downto 1  do for c := 0 to Glyph.w do  fBm[c,r] := FBm[c,r-1];
    for c := 0 to Glyph.w do  fBm[c,0] := false;
  end;
  if TSpeedButton(sender).Name = 'mvleft' then
  begin
    for c := 1 to glyph.w  do for r := 0 to Glyph.h do  fBm[c-1,r] := FBm[c,r];
    for r := 0 to Glyph.h do  fBm[Glyph.w,r] := false;
  end;
  if TSpeedButton(sender).Name = 'mvright' then
  begin
    for c := glyph.w downto 1  do for r := 0 to Glyph.h do  fBm[c,r] := FBm[c-1,r];
    for r := 0 to Glyph.h do  fBm[0,r] := false;
  end;
paintGrid;
end;

procedure TPE.nbadvChangeValue(Sender: TObject);
var n:integer;
begin
  n := round(nbadv.Value);
  fglyph.adv := n;
  paintGrid;
end;

procedure TPE.nbhChangeValue(Sender: TObject);
var n:integer;
begin
  n := round(nbh.Value);
  fglyph.h := n;
  paintGrid;
end;

procedure TPE.nbwChangeValue(Sender: TObject);
var n:integer;
begin
  n := round(nbw.Value);
  fglyph.w := n;
  paintGrid;
end;

procedure TPE.nbxoChangeValue(Sender: TObject);
var n:integer;
begin
  n := Round(nbxo.Value);
  fglyph.xo := n;
  paintGrid;
end;

procedure TPE.nbyoChangeValue(Sender: TObject);
var n:integer;
begin
  n := Round(nbyo.Value);
  fglyph.yo := n;
  paintGrid;
end;
procedure TPE.nixChange(Sender: TObject);
begin
  FIndex := StrToInt('$'+nix.Text);
end;

procedure TPE.nixKeyPress(Sender: TObject; var Key: Char);
begin
  if NOT (key in ['0'..'9','a'..'f','A'..'F',Char(VK_LEFT),Char(VK_Right),Char(VK_BACK),Char(VK_DELETE)])
       then key := #0;
end;

procedure TPE.SetPixels(val : TMemArray);
var bi, r, c : integer;
    bm : byte;
    m : word;
begin
  for r := 0 to 50 do
    for c := 0 to 50 do
      FBm[c,r]:= false;
  if Length(val) > 0 then
  begin
    bi := 0; m := 128; bm := val[bi];
    for r := 0 to glyph.h - 1 do
      for c := 0 to glyph.w - 1 do
        begin
        FBm[c,r] := (bm and m) > 0;
        m := m shr 1;
        if (m = 0) then
        begin
          m := 128;
          inc(bi);
          if bi < length(val) then bm := val[bi];
        end;
        end;
  end;
  Ready := Ready OR 4;
end;

end.
