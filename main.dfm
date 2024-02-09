object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'GFX -Tool'
  ClientHeight = 730
  ClientWidth = 1058
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Label8: TLabel
    Left = 790
    Top = 277
    Width = 63
    Height = 15
    Caption = 'Schwellwert'
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1058
    Height = 730
    ActivePage = pictures
    Align = alClient
    TabOrder = 0
    object pictures: TTabSheet
      Caption = 'Bilder'
      DesignSize = (
        1050
        700)
      object Label2: TLabel
        Left = 737
        Top = 60
        Width = 35
        Height = 15
        Caption = 'Name:'
      end
      object LoadImg: TButton
        Left = 24
        Top = 8
        Width = 161
        Height = 25
        Caption = 'File '#246'ffnen'
        TabOrder = 0
        OnClick = LoadImgClick
      end
      object ConvertImg: TButton
        Left = 835
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Umwandeln'
        TabOrder = 1
        OnClick = ConvertImgClick
      end
      object res: TMemo
        Left = 56
        Top = 408
        Width = 951
        Height = 122
        ScrollBars = ssBoth
        TabOrder = 2
        Visible = False
      end
      object e_name: TEdit
        Left = 783
        Top = 58
        Width = 206
        Height = 23
        TabOrder = 3
      end
      object SaveImg: TButton
        Left = 24
        Top = 64
        Width = 161
        Height = 25
        Caption = 'File speichern'
        TabOrder = 4
        OnClick = SaveImgClick
      end
      object Panel1: TPanel
        Left = 210
        Top = 8
        Width = 143
        Height = 81
        BevelKind = bkSoft
        Caption = 'Bilderstreifen'
        TabOrder = 5
        VerticalAlignment = taAlignTop
        object Label1: TLabel
          Left = 15
          Top = 30
          Width = 42
          Height = 15
          Caption = 'Kacheln'
        end
        object vert: TCheckBox
          Left = 40
          Top = 56
          Width = 73
          Height = 17
          Caption = 'vertikal'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object num: TNumberBox
          Left = 63
          Top = 27
          Width = 65
          Height = 23
          MinValue = 1.000000000000000000
          MaxValue = 100.000000000000000000
          TabOrder = 1
          Value = 1.000000000000000000
          SpinButtonOptions.Placement = nbspInline
        end
      end
      object Panel2: TPanel
        Left = 527
        Top = 8
        Width = 186
        Height = 81
        BevelKind = bkSoft
        Caption = 'Einfarbig'
        TabOrder = 6
        VerticalAlignment = taAlignTop
        object Label3: TLabel
          Left = 10
          Top = 53
          Width = 63
          Height = 15
          Caption = 'Schwellwert'
        end
        object inv: TCheckBox
          Left = 55
          Top = 21
          Width = 97
          Height = 20
          Caption = 'Invertiert'
          TabOrder = 0
        end
        object sw: TNumberBox
          Left = 96
          Top = 47
          Width = 65
          Height = 23
          MaxValue = 255.000000000000000000
          TabOrder = 1
          Value = 128.000000000000000000
          SpinButtonOptions.Placement = nbspInline
        end
      end
      object Panel3: TPanel
        Left = 370
        Top = 8
        Width = 143
        Height = 81
        BevelKind = bkSoft
        Caption = 'Modus'
        TabOrder = 7
        VerticalAlignment = taAlignTop
        object mono: TRadioButton
          Left = 16
          Top = 16
          Width = 113
          Height = 17
          Caption = '1 Bit einfarbig'
          TabOrder = 0
        end
        object gray: TRadioButton
          Left = 16
          Top = 36
          Width = 113
          Height = 17
          Caption = '8 Bit einfarbig'
          TabOrder = 1
        end
        object rgb_mod: TRadioButton
          Left = 16
          Top = 56
          Width = 113
          Height = 17
          Caption = '16 Bit mehrfarbig'
          Checked = True
          TabOrder = 2
          TabStop = True
        end
      end
      object Panel4: TPanel
        Left = 13
        Top = 115
        Width = 500
        Height = 500
        Caption = 'Original Bild'
        Color = clGradientInactiveCaption
        ParentBackground = False
        TabOrder = 8
        VerticalAlignment = taAlignTop
        object img: TImage
          AlignWithMargins = True
          Left = 0
          Top = 28
          Width = 500
          Height = 472
          AutoSize = True
          Center = True
        end
      end
      object Panel5: TPanel
        Left = 538
        Top = 115
        Width = 500
        Height = 500
        Margins.Right = 0
        Margins.Bottom = 0
        Anchors = []
        BevelEdges = []
        BevelOuter = bvNone
        BorderWidth = 2
        BorderStyle = bsSingle
        Caption = 'Umgewandeltes Bild'
        Color = clWhite
        ParentBackground = False
        TabOrder = 9
        VerticalAlignment = taAlignTop
        object img1: TImage
          Left = 1
          Top = 28
          Width = 492
          Height = 468
          Center = True
          Transparent = True
        end
      end
    end
    object fonts: TTabSheet
      Caption = 'Schriften'
      ImageIndex = 1
      object Label4: TLabel
        Left = 856
        Top = 155
        Width = 35
        Height = 15
        Caption = 'Name:'
      end
      object Label7: TLabel
        Left = 855
        Top = 269
        Width = 55
        Height = 15
        Caption = 'Grundlinie'
      end
      object Label5: TLabel
        Left = 856
        Top = 224
        Width = 67
        Height = 15
        Caption = 'Gesamth'#246'he'
      end
      object Label6: TLabel
        Left = 856
        Top = 309
        Width = 59
        Height = 15
        Caption = 'Zeilenh'#246'he'
      end
      object getfont: TButton
        Left = 856
        Top = 24
        Width = 169
        Height = 25
        Caption = 'Font einlesen'
        TabOrder = 0
        OnClick = getfontClick
      end
      object e_namef: TEdit
        Left = 856
        Top = 176
        Width = 169
        Height = 23
        TabOrder = 1
      end
      object ScrollBox1: TScrollBox
        Left = 3
        Top = 3
        Width = 822
        Height = 694
        HorzScrollBar.Visible = False
        VertScrollBar.ButtonSize = 16
        TabOrder = 2
        OnMouseWheel = ScrollBox1MouseWheel
        object gllist: TPaintBox
          Left = 0
          Top = 0
          Width = 801
          Height = 1120
          Align = alTop
          OnMouseDown = gllistMouseDown
          OnPaint = gllistPaint
          ExplicitWidth = 800
        end
      end
      object baseline: TNumberBox
        Left = 960
        Top = 266
        Width = 65
        Height = 23
        MaxValue = 50.000000000000000000
        TabOrder = 3
        Value = 33.000000000000000000
        SpinButtonOptions.Placement = nbspInline
      end
      object SavFont: TButton
        Left = 856
        Top = 64
        Width = 169
        Height = 25
        Caption = 'Font speichern'
        TabOrder = 4
        OnClick = SavFontClick
      end
      object lineheight: TNumberBox
        Left = 960
        Top = 306
        Width = 65
        Height = 23
        MaxValue = 50.000000000000000000
        TabOrder = 5
        Value = 33.000000000000000000
        SpinButtonOptions.Placement = nbspInline
      end
      object newfont: TButton
        Left = 856
        Top = 344
        Width = 169
        Height = 25
        Caption = 'Werte '#252'bernehmen'
        TabOrder = 6
        OnClick = newfontClick
      end
      object Button1: TButton
        Left = 856
        Top = 384
        Width = 169
        Height = 25
        Caption = 'Alle Zeichen l'#246'schen'
        TabOrder = 7
        OnClick = Button1Click
      end
      object fontheight: TNumberBox
        Left = 960
        Top = 221
        Width = 65
        Height = 23
        MinValue = 10.000000000000000000
        MaxValue = 50.000000000000000000
        TabOrder = 8
        Value = 42.000000000000000000
        SpinButtonOptions.Placement = nbspInline
      end
    end
  end
  object od: TOpenPictureDialog
    InitialDir = 'C:\Projekte\Arduino\AZ-Delivery\tft-bilder-anzeigen'
    Title = 'Bilddatei '#246'ffnen'
    Top = 608
  end
  object sd: TSaveDialog
    DefaultExt = 'h'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Includefile speichern'
    Left = 56
    Top = 608
  end
  object odf: TOpenDialog
    DefaultExt = 'h'
    Left = 108
    Top = 610
  end
  object sdf: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 156
    Top = 610
  end
end
