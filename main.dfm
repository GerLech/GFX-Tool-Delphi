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
    Left = 946
    Top = 4
    Width = 42
    Height = 15
    Alignment = taRightJustify
    Caption = 'Sprache'
    OnDblClick = languageDblClick
  end
  object msgsavimg: TLabel
    Left = 352
    Top = 624
    Width = 123
    Height = 15
    Caption = 'Bild zuerst umwandeln!'
    Visible = False
  end
  object msgsavfont: TLabel
    Left = 403
    Top = 616
    Width = 166
    Height = 15
    Caption = 'Der Font braucht einen Namen!'
    Visible = False
  end
  object msgsavcol: TLabel
    Left = 336
    Top = 536
    Width = 198
    Height = 15
    Caption = 'Farbe existiert bereits! '#220'berschreiben?'
    Visible = False
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1058
    Height = 730
    ActivePage = pictures
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 1054
    ExplicitHeight = 729
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
      object Label9: TLabel
        Left = 33
        Top = 39
        Width = 35
        Height = 15
        Caption = 'Name:'
      end
      object LoadImg: TButton
        Left = 24
        Top = 8
        Width = 161
        Height = 25
        Caption = 'Bild laden'
        TabOrder = 0
        OnClick = LoadImgClick
      end
      object ConvertImg: TButton
        Left = 782
        Top = 8
        Width = 207
        Height = 25
        Caption = 'Bild umwandeln'
        TabOrder = 1
        OnClick = ConvertImgClick
      end
      object res: TMemo
        Left = 56
        Top = 113
        Width = 951
        Height = 569
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
        Caption = 'Bild speichern'
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
          OnClick = showSize
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
          OnChange = showSize
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
        Height = 566
        Caption = 'Original Bild'
        Color = clGradientInactiveCaption
        ParentBackground = False
        TabOrder = 8
        VerticalAlignment = taAlignTop
        object ScrollBox1: TScrollBox
          Left = 11
          Top = 41
          Width = 478
          Height = 512
          TabOrder = 0
          object img: TImage
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 468
            Height = 502
            Align = alClient
            AutoSize = True
            Center = True
            Proportional = True
            Stretch = True
            ExplicitLeft = -80
            ExplicitTop = 163
            ExplicitWidth = 500
            ExplicitHeight = 137
          end
        end
      end
      object Panel5: TPanel
        Left = 527
        Top = 120
        Width = 500
        Height = 568
        Margins.Right = 0
        Margins.Bottom = 0
        Anchors = []
        BevelEdges = []
        BevelOuter = bvNone
        Caption = 'Umgewandeltes Bild'
        Color = clGradientInactiveCaption
        Ctl3D = True
        ParentBackground = False
        ParentCtl3D = False
        TabOrder = 9
        VerticalAlignment = taAlignTop
        ExplicitLeft = 524
        ExplicitTop = 119
        object ScrollBox3: TScrollBox
          Left = 11
          Top = 41
          Width = 478
          Height = 512
          TabOrder = 0
          object img1: TImage
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 468
            Height = 502
            Align = alClient
            AutoSize = True
            Center = True
            Proportional = True
            Stretch = True
            Transparent = True
            ExplicitLeft = 0
            ExplicitWidth = 460
            ExplicitHeight = 504
          end
        end
      end
      object size: TEdit
        Left = 24
        Top = 37
        Width = 161
        Height = 23
        ReadOnly = True
        TabOrder = 10
        Text = '0 x 0'
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
      object Label14: TLabel
        Left = 873
        Top = 472
        Width = 63
        Height = 15
        Caption = 'Schwellwert'
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
      object baseline: TNumberBox
        Left = 960
        Top = 266
        Width = 65
        Height = 23
        MaxValue = 50.000000000000000000
        TabOrder = 2
        Value = 33.000000000000000000
        SpinButtonOptions.Placement = nbspInline
      end
      object SavFont: TButton
        Left = 856
        Top = 64
        Width = 169
        Height = 25
        Caption = 'Font speichern'
        TabOrder = 3
        OnClick = SavFontClick
      end
      object lineheight: TNumberBox
        Left = 960
        Top = 306
        Width = 65
        Height = 23
        MaxValue = 50.000000000000000000
        TabOrder = 4
        Value = 33.000000000000000000
        SpinButtonOptions.Placement = nbspInline
      end
      object newfont: TButton
        Left = 856
        Top = 344
        Width = 169
        Height = 25
        Caption = 'Werte '#252'bernehmen'
        TabOrder = 5
        OnClick = newfontClick
      end
      object Button1: TButton
        Left = 856
        Top = 384
        Width = 169
        Height = 25
        Caption = 'Alle Zeichen l'#246'schen'
        TabOrder = 6
        OnClick = Button1Click
      end
      object fontheight: TNumberBox
        Left = 960
        Top = 221
        Width = 65
        Height = 23
        MinValue = 10.000000000000000000
        MaxValue = 50.000000000000000000
        TabOrder = 7
        Value = 42.000000000000000000
        SpinButtonOptions.Placement = nbspInline
      end
      object ScrollBox2: TScrollBox
        Left = 11
        Top = 6
        Width = 822
        Height = 694
        HorzScrollBar.Visible = False
        VertScrollBar.ButtonSize = 16
        TabOrder = 8
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
      object BtnNewFont: TButton
        Left = 856
        Top = 424
        Width = 169
        Height = 25
        Caption = 'Neue Schrift erzeugen'
        TabOrder = 9
        OnClick = BtnNewFontClick
      end
      object swm: TNumberBox
        Left = 942
        Top = 467
        Width = 68
        Height = 23
        MaxValue = 255.000000000000000000
        TabOrder = 10
        Value = 210.000000000000000000
        SpinButtonOptions.Placement = nbspInline
      end
    end
    object palette: TTabSheet
      Caption = 'Farbpalette'
      ImageIndex = 2
      object clist: TListBox
        Left = 40
        Top = 16
        Width = 265
        Height = 665
        Style = lbOwnerDrawVariable
        TabOrder = 0
        OnClick = clistClick
        OnDrawItem = clistDrawItem
      end
      object Panel6: TPanel
        Left = 488
        Top = 208
        Width = 393
        Height = 265
        Caption = 'Farbe bearbeiten'
        Color = clGradientInactiveCaption
        ParentBackground = False
        TabOrder = 1
        VerticalAlignment = taAlignTop
        DesignSize = (
          393
          265)
        object Label10: TLabel
          Left = 72
          Top = 84
          Width = 18
          Height = 15
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Rot'
        end
        object Label11: TLabel
          Left = 64
          Top = 124
          Width = 26
          Height = 15
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Gr'#252'n'
        end
        object Label12: TLabel
          Left = 67
          Top = 164
          Width = 23
          Height = 15
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Blau'
        end
        object Label13: TLabel
          Left = 37
          Top = 28
          Width = 53
          Height = 15
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Farbname'
        end
        object shcol: TShape
          Left = 232
          Top = 80
          Width = 105
          Height = 105
          Brush.Color = clBlack
          OnMouseDown = shcolMouseDown
        end
        object rval: TNumberBox
          Left = 96
          Top = 80
          Width = 89
          Height = 23
          LargeStep = 16.000000000000000000
          MaxValue = 248.000000000000000000
          SmallStep = 8.000000000000000000
          TabOrder = 0
          SpinButtonOptions.Placement = nbspInline
          UseMouseWheel = True
          OnExit = rvalChangeValue
        end
        object gval: TNumberBox
          Left = 96
          Top = 120
          Width = 89
          Height = 23
          LargeStep = 8.000000000000000000
          MaxValue = 252.000000000000000000
          SmallStep = 4.000000000000000000
          TabOrder = 1
          SpinButtonOptions.Placement = nbspInline
          UseMouseWheel = True
          OnExit = rvalChangeValue
        end
        object bval: TNumberBox
          Left = 96
          Top = 160
          Width = 89
          Height = 23
          LargeStep = 16.000000000000000000
          MaxValue = 248.000000000000000000
          SmallStep = 8.000000000000000000
          TabOrder = 2
          SpinButtonOptions.Placement = nbspInline
          UseMouseWheel = True
          OnExit = rvalChangeValue
        end
        object colnam: TEdit
          Left = 96
          Top = 24
          Width = 233
          Height = 23
          CharCase = ecUpperCase
          MaxLength = 18
          TabOrder = 3
        end
        object savcol: TButton
          Left = 48
          Top = 216
          Width = 129
          Height = 25
          Caption = 'Speichern'
          TabOrder = 4
          OnClick = savcolClick
        end
        object clearcol: TButton
          Left = 199
          Top = 216
          Width = 138
          Height = 25
          Caption = 'L'#246'schen'
          Enabled = False
          TabOrder = 5
          OnClick = clearcolClick
        end
      end
      object palload: TButton
        Left = 488
        Top = 104
        Width = 129
        Height = 25
        Caption = 'Palette laden'
        TabOrder = 2
        OnClick = palloadClick
      end
      object palsav: TButton
        Left = 752
        Top = 104
        Width = 129
        Height = 25
        Caption = 'Palette Speichern'
        TabOrder = 3
        OnClick = palsavClick
      end
    end
  end
  object language: TComboBox
    Left = 1000
    Top = 0
    Width = 50
    Height = 23
    Style = csDropDownList
    CharCase = ecUpperCase
    TabOrder = 1
    OnChange = languageChange
    Items.Strings = (
      '*'
      'GE'
      'EN')
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
    Title = 'Fontdatei '#246'ffnen'
    Left = 108
    Top = 610
  end
  object sdf: TSaveDialog
    DefaultExt = 'h'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Includefile speichern'
    Left = 160
    Top = 608
  end
  object cd: TColorDialog
    Left = 212
    Top = 610
  end
  object odp: TOpenDialog
    DefaultExt = 'h'
    Title = 'Palette laden'
    Left = 268
    Top = 610
  end
  object sdp: TSaveDialog
    DefaultExt = 'h'
    Title = 'Palette speichern'
    Left = 324
    Top = 610
  end
end
