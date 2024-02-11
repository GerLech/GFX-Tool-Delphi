unit LanguageIni;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.IniFiles,
  Vcl.StdCtrls, vcl.ComCtrls, vcl.ExtCtrls, System.IOUtils;

type
  TLangIni = class(TObject)
private
protected
public
  class procedure buildIni(comp : TComponent; sect : String; lang : String);
  class procedure ReadLanguage(comp : TComponent; sect : String; lang: string);
  class procedure GetLanguages(list : Tstrings);
end;

implementation

class procedure TLangIni.buildIni(comp: TComponent; sect: string; lang: string);
var i:integer;
    ini : TIniFile;
    filename : string;

procedure handleComp(c: TComponent; sect : string);
var i:integer;
    x : string;
begin
  if not ini.ValueExists(sect,c.name) then
  begin
    x := '';
    if (c is TTabSheet) then x := (c AS TTabSheet).Caption;
    if (c is TLabel) then x := (c AS TLabel).Caption;
    if (c is TButton) then x := (c AS TButton).Caption;
    if (c is TPanel) then x := (c AS TPanel).Caption;
    if (c is TCheckBox) then x := (c AS TCheckBox).Caption;
    if (c is TRadioButton) then x := (c AS TRadioButton).Caption;
    if (x <> '') then Ini.WriteString(sect, c.name, x);
  end;
  if c.ComponentCount > 0 then
    for i := 0 to c.ComponentCount -1 do handleComp(c.Components[i],sect);
end;

begin
    filename := ExtractFilePath(ParamStr(0)) + 'lang'+lang+'.ini';
    ini := TIniFile.Create(filename);
    try
      for i := 0 to comp.ComponentCount - 1 do  handleComp(comp.Components[i],Sect);
    finally
      ini.Free;
    end;
end;

class procedure TLangIni.ReadLanguage(comp : TComponent; sect : string; lang: string);
var ini : TiniFile;
    l   : TStringList;
    filename : string;
    i  : integer;
    c  : Tcomponent;
begin
    filename := ExtractFilePath(ParamStr(0)) + 'lang'+lang+'.ini';
    l:= TStringlist.Create;
    try
      ini := TIniFile.Create(filename);
      try
        ini.ReadSection(sect,l);
        for i := 0 to l.Count - 1 do
        begin
          c := comp.FindComponent(l[i]);
          if (c is TTabSheet) then (c AS TTabSheet).Caption := ini.ReadString(sect,l[i],'');
          if (c is TLabel) then (c AS TLabel).Caption := ini.ReadString(sect,l[i],'');
          if (c is TButton) then (c AS TButton).Caption := ini.ReadString(sect,l[i],'');
          if (c is TPanel) then (c AS TPanel).Caption := ini.ReadString(sect,l[i],'');
          if (c is TCheckBox) then (c AS TCheckBox).Caption := ini.ReadString(sect,l[i],'');
          if (c is TRadioButton) then (c AS TRadioButton).Caption := ini.ReadString(sect,l[i],'');
        end;
      finally
        ini.Free;
      end;
    finally
      l.Free;
    end;

end;

class procedure TLangIni.GetLanguages(list : Tstrings);
var SR : TsearchRec;
     dir: String;
     nam : String;
begin
dir := ExtractFilePath(ParamStr(0));
if FindFirst(dir+'lang*.ini',faNormal,SR) = 0 then
  begin
    try
     repeat
      nam := TPath.GetFileNameWithoutExtension(SR.Name);
      nam := nam.Substring(4);
      list.add(nam);
     until FindNext(SR)<>0;
    finally
     FindClose(SR); //Nach jedem findfirst nötig, um sr freizugeben!
    end;
  end;
end;

end.
