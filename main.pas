unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtDlgs, Vcl.ExtCtrls, vcl.Imaging.pnglang,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, vcl.NumberBox, System.IOUtils, System.IniFiles,
  Vcl.ComCtrls,pixeledit, System.Types, languageIni;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    pictures: TTabSheet;
    img: TImage;
    Label2: TLabel;
    LoadImg: TButton;
    ConvertImg: TButton;
    res: TMemo;
    e_name: TEdit;
    SaveImg: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    vert: TCheckBox;
    num: TNumberBox;
    Panel2: TPanel;
    Label3: TLabel;
    inv: TCheckBox;
    sw: TNumberBox;
    Panel3: TPanel;
    mono: TRadioButton;
    gray: TRadioButton;
    rgb_mod: TRadioButton;
    od: TOpenPictureDialog;
    sd: TSaveDialog;
    fonts: TTabSheet;
    getfont: TButton;
    odf: TOpenDialog;
    e_namef: TEdit;
    Label4: TLabel;
    Label7: TLabel;
    baseline: TNumberBox;
    Label5: TLabel;
    fontheight: TNumberBox;
    SavFont: TButton;
    sdf: TSaveDialog;
    Label6: TLabel;
    lineheight: TNumberBox;
    newfont: TButton;
    Button1: TButton;
    Panel4: TPanel;
    Panel5: TPanel;
    img1: TImage;
    language: TComboBox;
    Label8: TLabel;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    gllist: TPaintBox;
    ScrollBox3: TScrollBox;
    Label9: TLabel;
    size: TEdit;
    procedure LoadImgClick(Sender: TObject);
    procedure ConvertImgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SaveImgClick(Sender: TObject);
    procedure getfontClick(Sender: TObject);
    procedure gllistPaint(Sender: TObject);
    procedure gllistMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ScrollBox1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure SavFontClick(Sender: TObject);
    procedure newfontClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure languageChange(Sender: TObject);
    procedure languageDblClick(Sender: TObject);
    procedure showSize(Sender: TObject);
  private
    { Private-Deklarationen }
    imgPath: string;
    imgSavePath : String;
    fontPath: string;
    fontSavePath : String;
    bms : array [0..256000] of byte;
    gls : array [0..255] of tglyph;
    bmsize : longint;
    first : byte;
    last : byte;
    flinespace : byte;
    maxwidth : integer;
    fbaseline : integer;
    descender : integer;
    ffontheight : integer;
    function ColorToRGB(c: TColor): word;
    function ColorToMono(c: TColor): byte;
    function col565Tocol888(col:word) : TColor;
    function ColorToGray(c: TColor): byte;
    function GrayToColor(col:Byte) : TColor;
    procedure convertPart(w:integer;h:integer; xo:integer; yo:integer; cnv:tCanvas; cnv1:tCanvas);
    procedure loadFont(fn : String);
    function readUntil(var fs : TStreamReader; pattern : String; cend : Char) : boolean;
    function readChar(var b : Char; var  fs : TStreamReader):boolean;
    function readHexByte(var  fs : TStreamReader):integer;
    function readInteger(var num:integer; var fs:TStreamReader; cend :Char) : boolean;
    procedure drawGlyph(index : integer);
    function GetBlock(index : integer)  : TMemArray;
    function RemoveBlock(Index : integer): integer;
    procedure InsertBlock(Index : integer; data : TMemArray);
    procedure showGlyphs;
    procedure clearGlyphs;
    function SaveFont(filename : string):Boolean;
    procedure WriteToIni(key:string; value : string);
    procedure WriteToIniInt(key:string; value : integer);
  public
    { Public-Deklarationen }
end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.LoadImgClick(Sender: TObject);
begin
  od.InitialDir := imgPath;
  if od.Execute then
    if FileExists(od.FileName) then
    begin
      { If it exists, load the data into the image component. }
      img.Picture.LoadFromFile(od.FileName);
      //img1.Canvas.Brush.Color := clWhite;
      //img1.Canvas.FillRect(img1.Canvas.ClipRect);
      showSize(self);
      e_name.Text := TPath.GetFileNameWithoutExtension(od.FileName);
      writeToIni('ImgPath',TPath.GetDirectoryName(od.FileName));
      res.Lines.Clear;
    end
  else
    begin
      { Otherwise raise an exception. }
      raise Exception.Create('File does not exist.');
      e_name.Text := '';
    end;
end;

procedure TForm1.newfontClick(Sender: TObject);
begin
  fbaseline := Round(baseline.Value);
  ffontheight := Round(fontheight.Value);
  flinespace := Round(lineheight.value);
end;

procedure TForm1.ConvertImgClick(Sender: TObject);
var i, x,y,n : integer;
    bmp, bmp1: tBitmap;

begin
  bmp := TBitmap.Create;
  bmp1 := TBitmap.Create;
  try
    bmp.PixelFormat := pf32bit;
    bmp.Width := img.Picture.Width;
    bmp.Height := img.Picture.Height;
    bmp.Transparent := false;
    bmp1.PixelFormat := pf24bit;
    bmp1.Width := img.Picture.Width;
    bmp1.Height := img.Picture.Height;
    bmp1.Transparent := false;
    bmp1.TransparentColor := clGradientInactiveCaption;
    bmp1.TransparentMode := tmfixed;
    bmp.Canvas.Draw(0, 0, img.Picture.Graphic,128);
    bmp1.Canvas.Draw(0, 0, img.Picture.Graphic,128);
    //img1.Canvas.Draw(0, 0, img.Picture.Graphic,128);
    n := num.ValueInt;
    if vert.Checked then
      begin
        x:=img.Picture.Width;
        y:=img.Picture.Height div n;
      end
    else
      Begin
        x:=img.Picture.Width div n;
        y:=img.Picture.Height;
      End;
    img1.Picture := nil;
    res.Lines.Clear;
    if (n>1) then
    begin
      if mono.Checked then
        res .Lines.Add('const uint8_t PROGMEM '+e_name.Text+' ['+inttostr(n)+']['+inttostr(((x+7) div 8) * y)+'] = {')
      else if gray.Checked then
        res.Lines.Add('const uint8_t PROGMEM '+e_name.Text+' ['+inttostr(n)+']['+inttostr(x * y)+'] = {')
      else
        res.Lines.Add('const uint16_t PROGMEM '+e_name.Text+' ['+inttostr(n)+']['+inttostr(x * y)+'] = {');
         for i := 0 to n-1 do
      begin
      if vert.Checked then   convertPart(x,y,0,i * y, bmp.Canvas,bmp1.Canvas)  else  convertPart(x,y,i * x,0,bmp.Canvas,bmp1.Canvas) ;
      res.Lines.Add(',');
      end;

      res.Lines.Add('};') ;
    end
    else
    begin
      if mono.Checked then
        res .Lines.Add('const uint8_t PROGMEM '+e_name.Text+' ['+inttostr(((x+7) div 8) * y)+'] = ')
      else if gray.Checked then
        res.Lines.Add('const uint8_t PROGMEM '+e_name.Text+' ['+inttostr(x * y)+'] = {')
      else
        res.Lines.Add('const uint16_t PROGMEM '+e_name.Text+' ['+inttostr(x * y)+'] = ');
        convertPart(x,y,0,0,bmp.Canvas,bmp1.Canvas);
      res.Lines.Add(';') ;
    end;
    img1.Picture.Bitmap := bmp1;
  finally
    bmp.Free;
  end;



end;

procedure TForm1.SaveImgClick(Sender: TObject);
begin
  if res.Lines.Count > 0 then
  begin
    sd.InitialDir := imgSavePath;
    sd.DefaultExt := 'h';
    sd.Filter := 'Image header|*.h';
    sd.FileName := e_name.Text + '.h';
    if sd.Execute then
    begin
        res.Lines.SaveToFile(sd.FileName);
        writeToIni('ImgSavePath',TPath.GetDirectoryName(sd.FileName));
    end;
  end
  else
  begin
    MessageDlg('Bild zuerst umwandeln!',mtError, [mbOK], 0);
  end;
end;

procedure TForm1.SavFontClick(Sender: TObject);
begin
  if e_namef.Text <> '' then
  begin
    sdf.InitialDir := fontSavePath;
    sdf.DefaultExt := 'h';
    sdf.Filter := 'Font header|*.h';
    sdf.FileName := e_namef.Text + '.h';
    if sdf.Execute then
    begin
        SaveFont(sdf.FileName);
        writeToIni('FontSavePath',TPath.GetDirectoryName(sdf.FileName));
    end;
  end
  else
  begin
    MessageDlg('Der Font braucht einen Namen!',mtError, [mbOK], 0);
  end;
end;

procedure TForm1.convertPart(w: Integer; h: Integer; xo: Integer; yo: Integer; cnv:tCanvas; cnv1:tCanvas);
var ix,iy,b:integer;
  row:String;
  rgbw:word;
  grayval : byte;
  m:byte;
  bit : byte;
  c:TColor;
  cnt,bytes : integer;
begin
    cnt := 0;
    bytes := ((w+7) div 8) - 1;
    row := '{';
    for iy := 0 to h-1 do
    begin
      if mono.Checked then
      begin 
        for ix := 0 to bytes do
        begin
          m:= 0;
          for b := 0 to 7 do
          begin
            if (b + ix * 8) < w then
            begin
              c := cnv.Pixels[ix * 8 +b+xo,iy+yo];
              bit := ColorToMono(c);
              if inv.Checked then bit := abs(bit-1);

              if (bit = 1) then
                cnv1.Pixels[ix * 8 +b+xo,iy+yo]:= clBlack
              else
                cnv1.Pixels[ix * 8 +b+xo,iy+yo]:= clWhite;
              m := (m shl 1) or bit;
            end
            else m := m shl 1;
          end;
          row := row+'0x'+ inttohex(m) + ',';
        end
      end
      else
      begin
        for ix := 0 to w-1 do
        begin
           c := cnv.Pixels[ix+xo,iy+yo];
           if gray.Checked then
           begin
             grayval := ColorToGray(c);
             cnv1.Pixels[ix+xo,iy+yo]:= GrayToColor(grayval);
             row := row+'0x'+ inttohex(grayval) + ',';
           end
           else
           begin
             rgbw := ColorToRGB(c);
             cnv1.Pixels[ix+xo,iy+yo]:= col565Tocol888(rgbw);
             row := row+'0x'+ inttohex(rgbw) + ',';
           end;
           cnt := cnt+1;
           if cnt >128 then
           begin
             cnt := 0;
             res.Lines.Add(row);
             row := '';
           end;
        end;
      end;
    end;
    row:= row+'}';
    res.Lines.Add(row);
end;

procedure TForm1.FormCreate(Sender: TObject);
var ini: TIniFile;
  filename: String;
  lng : integer;
begin
  filename := ExtractFilePath(ParamStr(0)) + 'config.ini'; //???
  ini := TIniFile.Create(filename);
  try
    ImgPath := Ini.ReadString('Config', 'ImgPath', TPath.GetPicturesPath());
    ImgSavePath := Ini.ReadString('Config', 'ImgSavePath', TPath.GetPicturesPath());
    fontPath := Ini.ReadString('Config', 'FontPath', TPath.GetDocumentsPath());
    fontSavePath := Ini.ReadString('Config', 'FontSavePath', TPath.GetDocumentsPath());
    lng := Ini.ReadInteger('Config','Language',0);
    newFontClick(self);
  finally
    ini.Free;
  end;
  clearGlyphs;
  language.Items.Clear;
  TLangIni.GetLanguages(language.Items);
  if language.Items.Count > lng then
  begin
    language.ItemIndex := lng;
    TLangIni.ReadLanguage(self,'Main',language.Text);
  end
  else
  begin
     language.ItemIndex := -1;
  end;
end;


procedure TForm1.getfontClick(Sender: TObject);
begin
  odf.InitialDir := fontPath;
  if odf.Execute then
    if FileExists(odf.FileName) then
    begin
      { If it exists, load the data into the image component. }
      loadFont(odf.FileName);
      e_namef.Text := TPath.GetFileNameWithoutExtension(odf.FileName);
      writeToIni('FontPath',TPath.GetDirectoryName(odf.FileName));
    end
  else
    begin
      { Otherwise raise an exception. }
      raise Exception.Create('File does not exist.');
      e_name.Text := '';
    end;
end;

procedure TForm1.gllistMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var r,c,index,newindex,res,i,l,l1 : integer;
    m : TMemArray;
    g : TGlyph;
begin
  c := x div 50;
  r := y div 70;
  index := r * 16 +c;

  g.w := 0;
  g.h := 0;
  g.adv := 5;
  g.xo := 0;
  g.yo := 0;
  setLength(m , 0);
  PE.Baseline := fBaseline;
  PE.Fontheight := fFontheight;
  if (index < 256) then
  begin
    PE.Glyph := gls[index];
    g := gls[index];
    PE.Pixels := GetBlock(index);
  end;
  PE.Index:= index;
  res := PE.ShowModal;
  if res = mrOk then
  begin
    newindex := PE.Index;
    if (true) then
    begin
      if newindex <> index then
      begin
        l:=removeBlock(newindex);
        m := PE.Pixels;
        l1 :=  length(m);
        for i := newindex + 1 to 255 do  gls[i].offset := gls[i].offset - l + l1;
        g := PE.Glyph;
        g.offset := gls[newindex].offset;
        gls[newindex] := g;
        insertBlock(newindex,m);
        showGlyphs;
      end
      else
      begin
        if (PE.Glyph.w = g.w) and (PE.Glyph.h = g.h) then   //keine Größenänderung
        begin
          gls[index] := PE.Glyph;
          m := PE.Pixels;
          for i := 0 to length(m) - 1 do bms[i+gls[index].offset] := m[i];
        end
        else
        begin
          l:=removeBlock(index);
          m := PE.Pixels;
          l1 :=  length(m);
          for i := index + 1 to 255 do  gls[i].offset := gls[i].offset - l + l1;
          gls[index] := PE.Glyph;
          insertBlock(index,m);
          showGlyphs;
        end;
      end;
    end;
    gllistPaint(self);
  end;

end;

procedure TForm1.gllistPaint(Sender: TObject);
var i:integer;
begin
  for i := 0 to 255 do drawGlyph(i);
end;

function TForm1.ColorToRGB(c: TColor): word;
var
  r,g,b : byte;
begin
  r:= getRVAlue(c);
  g:= getGVAlue(c);
  b:= getBVAlue(c);
  Result := (((r shr 3) and 31) shl 11) + (((g shr 2) and 63) shl 5) +  ((b shr 3) and 31);
end;

function TForm1.col565Tocol888(col:word) : TColor;
var r,g,b : byte;
begin
  r :=   (col and $F800) shr 8;
  g :=   (col and $07E0) shr 3;
  b :=   (col and $001F) shl 3;
  Result := RGB(r,g,b);
end;

function TForm1.ColorToMono(c: TColor): byte;
var
  r,g,b : byte;
  rgbw : word;
  s : word;
begin
  s := sw.ValueInt;
  Result := 0;
  r:= getRVAlue(c);
  g:= getGVAlue(c);
  b:= getBVAlue(c);
  rgbw := (r+b+g) div 3;
  if rgbw > s then  Result := 1;
end;

function TForm1.ColorToGray(c: TColor): Byte;
var
  r,g,b : byte;
begin
  r:= getRVAlue(c);
  g:= getGVAlue(c);
  b:= getBVAlue(c);
  Result := (r+b+g) div 3;
end;

function TForm1.GrayToColor(col: Byte): TColor;
begin
  Result := RGB(col,col,col);
end;

procedure TForm1.languageChange(Sender: TObject);
begin
  tlangini.ReadLanguage(self,'Main',language.Text);
  TLangIni.ReadLanguage(PE,'PE',language.Text);
  writeToIniInt('Language',language.ItemIndex)
end;

procedure TForm1.languageDblClick(Sender: TObject);
var l : string;
begin
  if language.ItemIndex < 0 then l:= '1GE' else l := language.Text;
  tLangIni.buildIni(self,'Main',l);
  tLangIni.buildIni(PE,'PE',l);
  MessageDlg('Ini file created', mtInformation,[mbOK],0);
end;


procedure TForm1.loadFont(fn: string);
var fs : TStreamReader;
    c : Char;
    n,i,d,adv,bl : integer;
    index : longint;
    f : boolean;
    r : tglyph;
begin
  fs := TStreamReader.Create(tFilestream.Create(fn,fmOpenRead),TEncoding.UTF8);
  try
    index := 0;
    readUntil(fs,'PROGMEM','}');
   if readUntil(fs,'{','}') then
    begin
      repeat
        n := readHexByte(fs);
        if n >= 0 then
        begin
          bms[index] := n;
          inc(index);
        end;

      until (n < 0);
    end;
    bmsize := index;
    bl := 0; maxwidth := 0; descender := 0;
    readUntil(fs,'PROGMEM','}');
    if readUntil(fs,'{','}') then
    begin
      f:= true;
      index := 0;
      while f do
      begin
        f := readUntil(fs,'{','}');
        if f then
        begin
          f := readInteger(n,fs,',');
          if f then r.offset := n;
          if f then f := readInteger(n,fs,',');
          if f then r.w := n;
          if f then f := readInteger(n,fs,',');
          if f then r.h := n;
          if f then f := readInteger(n,fs,',');
          if f then r.adv := n;
          if f then f := readInteger(n,fs,',');
          if f then r.xo := n;
          if f then f := readInteger(n,fs,'}');
          if f then r.yo := n;
          if f then
          begin
            d := r.h - 1 + r.yo;
            if d > descender then descender := d;

            if r.yo < bl then bl := r.yo;
            if (r.xo + r.w) > maxwidth  then maxwidth := r.xo+r.w;

            gls[index] := r;
            inc(index);
          end;
          if f then f := readChar(c,fs);
          if f and (c <> ',') then f:= false;

        end;
      end;
    end;

    readUntil(fs,'PROGMEM','}');
    first := readHexByte(fs);
    last := readHexByte(fs);
    //expand glyphlist to 0 .. 255;
    adv :=25;
    for i := last-first downto 0 do gls[i+first] := gls[i];
    r.offset:=0; r.w:=0; r.h := 0; r.adv := adv; r.xo := 0; r.yo := 0;
    for i := 0 to first - 1 do gls[i]:=r;
    r.offset := bmsize;
    for i := last+1 to 255 do gls[i] := r;
    if readUntil(fs,',','}') then readInteger(n, fs, '}');
    lineheight.Value := n;
    flinespace := n;
    bl := (bl * -1) + 1;
    Baseline.Value := bl;
    fbaseline := bl;
    fontheight.Value := bl + descender;
    ffontheight := bl + descender;
    //gllist.Height := 16 * (fontheight +1) + 1;
    //gllist.Width := 16 * (maxwidth + 1)+1;
    gllist.Canvas.Brush.Color := clsilver;
    gllist.Canvas.FillRect(gllist.Canvas.ClipRect);
    gllist.Repaint;
    for i := 0 to 255 do drawGlyph(i);


  finally
    fs.BaseStream.Free;
    fs.Free
  end;
end;

function TForm1.readUntil(var fs : TStreamReader; pattern : String; cend : Char) : boolean;
var ci, cl : integer;
    b: Char;
    m : boolean;
begin
  cl := length(pattern);
  ci := 0;
  m := false;
  b := chr(0);
  while (not m) and (b <> cend) and (readChar(b,fs)) do
  begin
    if b =  pattern[ci+1] then  ci:=ci+1 else ci := 0 ;
    m := (ci = cl);
  end;
  Result := m;
end;

function TForm1.readHexByte(var fs: TStreamReader): Integer;
var v:String;
begin
  result := -1;
  if readUntil(fs,'0x','}') then
  begin
    v := '$'+Char(fs.Read) + Char(fs.Read);
    result := StrToInt(v);
  end;
end;

function TForm1.readChar(var b: Char; var fs: TStreamReader): Boolean;
var f,comment : boolean;
    x,y : byte;
begin
  comment := false;
  f := false;
  repeat
    x := fs.Peek;
    if (x=10) or (x = 13) then
    begin
      comment := false;
      y := fs.Read;
    end
    else
    begin
      if (x = 47) and (not comment) then
      begin
        b := Char(fs.Read);
        y := fs.Peek;
        comment :=  (y = 47);
        f := not comment;
        if comment then y := fs.Read;
        
      end
      else
      begin
        if (x > 32) AND (not comment) then
        begin
          b := Char(fs.Read);
          f := true;
        end
        else
        begin
          y := fs.Read;
        end;
      end;
    end;
  until (f or (x=0));
  result := (x <> 0)
end;

function TForm1.readInteger(var num: Integer; var fs: TStreamReader; cend: Char): Boolean;
var f : boolean;
    v : String;
    c : Char;
begin
  f := false;
  v := '';
  result :=  readChar(c,fs);
  if result then
  begin
    v := v + c;
    while (fs.Peek > 0) and (not f)  do
    begin
      c:= Char(fs.Read);
      f := (c = cend);
      if (not f) then v := v + c;
    end;
    v := Trim(v);
    num := StrToInt(v);
  end;

end;


procedure TForm1.showGlyphs;
var i :integer;
    g: TGlyph;
begin
{
lg.lines.add('Bitmap: '+intToStr(bmsize));
for i := 0 to 255 do
  begin
    g := gls[i];
    lg.Lines.Add(inttostr(i)+' - '+inttostr(g.offset));
  end;   }
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  clearGlyphs;
  gllist.Repaint;
end;

procedure TForm1.clearGlyphs;
var i :integer;
    r: TGlyph;
begin
  r.offset:=0; r.w:=0; r.h := 0; r.adv := round(fbaseline * 0.7); r.xo := 0; r.yo := 0;
  for i := 0 to 255 do  gls[i] := r;
  maxwidth := r.adv;
  bmsize := 0;
  newFontClick(self);
end;

procedure TForm1.drawGlyph(index: Integer);
var xp,yp,r,c,i,j,bi,fh,bl : integer;
    g:tglyph;
    bm : byte;
    w : word;
begin
  fh := ffontheight;
  bl := fbaseline;
  r := Index div 16;
  c := Index mod 16;
  xp := c * 50;
  yp := r * 70;
  g := gls[index];
  gllist.Canvas.Rectangle(xp,yp,xp+maxwidth + 2,yp+fh+2);
  w := 128; bi:= g.offset; bm := bms[bi];
  for i := 0 to g.h - 1 do
  begin
    for j := 0 to g.w -1 do
    begin
    if (bm and w) > 0 then gllist.Canvas.Pixels[xp + j +g.xo+1, yp + i +bl + g.yo+1] := clBlack;
    w := w shr 1;
    if (w = 0) then
    begin
      inc(bi);
      w := 128;
      bm := bms[bi];
    end;

    end;

  end;
  gllist.Canvas.TextOut(xp +2,yp+fh+3,IntToHex(index,2) + ' ' + char(index));

end;

function TForm1.GetBlock(index : integer) : TMemArray;
var b, e, i : integer;

begin
  b := gls[index].offset;
  if index >= last then e:= bmsize else e:= gls[index + 1].offset;
  SetLength(Result, e - b);
  for i := 0 to e-b-1 do Result[i] := bms[b + i];
    
end;

function TForm1.RemoveBlock(Index: Integer):integer;
var b, e, i, l : integer;

begin
  b := gls[index].offset;
  if index >= 255 then e:= bmsize else e:= gls[index + 1].offset;
  l := e-b;
  if l > 0 then for i := 0 to bmsize - b do bms[b + i] := bms[e + i];
  bmsize := bmsize -l;
  result := l;
end;

procedure TForm1.ScrollBox1MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  LTopLeft, LTopRight, LBottomLeft, LBottomRight: SmallInt;
  LPoint: TPoint;
  ScrollBox: TScrollBox;
begin
  ScrollBox := TScrollBox(Sender);
  LPoint := ScrollBox.ClientToScreen(Point(0,0));
  LTopLeft := LPoint.X;
  LTopRight := LTopLeft + ScrollBox.ClientWidth;
  LBottomLeft := LPoint.Y;
  LBottomRight := LBottomLeft + ScrollBox.ClientWidth;
  if (MousePos.X >= LTopLeft) and
    (MousePos.X <= LTopRight) and
    (MousePos.Y >= LBottomLeft) and
    (MousePos.Y <= LBottomRight) then
  begin
    ScrollBox.VertScrollBar.Position := ScrollBox.VertScrollBar.Position - WheelDelta;
    Handled := True;
  end;
end;

procedure TForm1.InsertBlock(Index: Integer; data : TMemArray);
var b,l,i : integer;
begin
  b:=gls[index].offset;
  l := Length(data);
  if (bmsize + l) < length(bms) then
  begin
    for i := bmsize downto b do
    begin
      bms[i + l] := bms[i];
    end;
    for i := 0 to l-1 do
      bms[b+i]:= data[i];
  end;

  bmsize := bmsize + l;
end;

function TForm1.SaveFont(filename: string):boolean;
var
  f : Textfile;
  var i : integer;
      v : String;
      g:tglyph;
begin
  AssignFile(f, FileName,CP_UTF8);
  try
    Rewrite(f);
    Writeln(f, 'const uint8_t '+e_namef.Text+'Bitmaps[] PROGMEM = {');
    for I := 0 to bmsize - 2 do
    begin
      v:= '0x'+intToHex(bms[i],2)+', ';
      if (i mod 12) = 0 then write(f,'    ');

      if (i mod 12) = 11 then WriteLn(f,v) else Write(f,v);
    end;
    Writeln(f,'0x'+intToHex(bms[bmsize - 1],2)+'};');
    Writeln(f,'');
    Writeln(f,'const GFXglyph '+e_namef.text + 'Glyphs[] PROGMEM = {');
    for i := 0 to 255 do
    begin
      g := gls[i];
      write(f,'    {');

      write(f,inttostr(g.offset)+', ');
      write(f,inttostr(g.w)+', ');
      write(f,inttostr(g.h)+', ');
      write(f,inttostr(g.adv)+', ');
      write(f,inttostr(g.xo)+', ');
      if i = 255 then
        write(f,inttostr(g.yo)+'}};'+char(9)+'//0x'+IntToHex(i,2)+'    ')
      else
        write(f,inttostr(g.yo)+'},'+char(9)+'//0x'+IntToHex(i,2) + '    ') ;
      if (i in [32..91,93..127,159..255]) then write(f,chr(i));
      writeln(f,'');
    end;
    writeln(f,'');
    writeln(f,'const GFXfont '+e_namef.Text+' PROGMEM = {');
    writeln(f,'    (uint8_t *)'+e_namef.Text+'Bitmaps, (GFXglyph *)'+e_namef.Text+'Glyphs,');
    writeln(f,'    0x00, 0xFF, '+inttostr(flinespace)+'};');
    writeln(f,'');
    writeln(f,'//Approx. '+inttostr(bmsize + 1785)+' bytes');
    Result := True;
  finally
    CloseFile(f);
  end;
end;

procedure TForm1.WriteToIni(key: string; value: string);
var filename : string;
    ini: TIniFile;
begin
      filename := ExtractFilePath(ParamStr(0)) + 'config.ini';
      ini := TIniFile.Create(filename);
      try
        Ini.WriteString('Config', key, value);
      finally
        ini.Free;
      end;
end;
procedure TForm1.WriteToIniInt(key: string; value: integer);
var filename : string;
    ini: TIniFile;
begin
      filename := ExtractFilePath(ParamStr(0)) + 'config.ini';
      ini := TIniFile.Create(filename);
      try
        Ini.WriteInteger('Config', key, value);
      finally
        ini.Free;
      end;
end;

procedure TForm1.showSize(Sender: TObject);
var w,h,n : integer;

begin
  w := img.Picture.Width;
  h := img.Picture.Height;
  n := num.ValueInt;
  if vert.Checked then h := h div n else w := w div n;
  size.Text := IntToStr(w)+' x '+IntToStr(h);
end;
end.
