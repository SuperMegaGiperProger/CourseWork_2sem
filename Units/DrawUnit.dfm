object Form1: TForm1
  Left = 237
  Top = 41
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  AlphaBlendValue = 10
  AutoScroll = False
  Caption = 'EasyMaps'
  ClientHeight = 994
  ClientWidth = 1433
  Color = clGradientInactiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCanResize = FormCanResize
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  PixelsPerInch = 96
  TextHeight = 13
  object mapImage: TImage
    Left = 0
    Top = 0
    Width = 1433
    Height = 993
    OnMouseDown = mapImageMouseDown
    OnMouseMove = mapImageMouseMove
    OnMouseUp = mapImageMouseUp
  end
  object Label1: TLabel
    Left = 1232
    Top = 976
    Width = 201
    Height = 17
    AutoSize = False
    Caption = #1043#1077#1086#1076#1072#1085#1085#1099#1077' '#1074#1079#1103#1090#1099' '#1089
    Color = clWhite
    ParentColor = False
    Transparent = False
  end
  object Label2: TLabel
    Left = 1336
    Top = 976
    Width = 93
    Height = 13
    Caption = 'OpenStreetMap.org'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
    OnClick = Label2Click
    OnMouseEnter = Label2MouseEnter
    OnMouseLeave = Label2MouseLeave
  end
  object SpeedButton1: TSpeedButton
    Left = 1384
    Top = 880
    Width = 25
    Height = 25
    Caption = '+'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'FreeMono'
    Font.Style = [fsBold]
    Margin = 4
    ParentFont = False
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 1384
    Top = 904
    Width = 25
    Height = 25
    Caption = '-'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'FreeMono'
    Font.Style = [fsBold]
    Margin = 4
    ParentFont = False
    OnClick = SpeedButton2Click
  end
  object Gauge: TGauge
    Left = 160
    Top = 488
    Width = 1129
    Height = 33
    ForeColor = clGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Progress = 0
    Visible = False
  end
  object Label3: TLabel
    Left = 592
    Top = 448
    Width = 255
    Height = 36
    Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1082#1072#1088#1090#1099'..'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -32
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object BitBtn4: TBitBtn
    Left = 17
    Top = 240
    Width = 25
    Height = 25
    Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1077' '#1087#1091#1085#1082#1090#1099' '#1089#1083#1077#1076#1086#1074#1072#1085#1080#1103
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    WordWrap = True
    OnClick = BitBtn4Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object LoadBtn: TBitBtn
    Left = 642
    Top = 460
    Width = 145
    Height = 25
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1082#1072#1088#1090#1091
    TabOrder = 1
    OnClick = LoadBtnClick
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 272
    Width = 97
    Height = 57
    Hint = 
      #1042#1099#1073#1086#1088': '#1085#1072#1095#1072#1083#1086' '#1080#1083#1080' '#1082#1086#1085#1077#1094' '#1087#1091#1090#1080' '#1091#1082#1072#1079#1099#1074#1072#1077#1090' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100', '#1080#1083#1080' '#1087#1088#1086#1075#1088#1072#1084 +
      #1084#1072' '#1074#1099#1073#1080#1088#1072#1077#1090' '#1086#1087#1090#1080#1084#1072#1083#1100#1085#1091#1102' '#1090#1086#1095#1082#1091' '#1089#1090#1072#1088#1090#1072' '#1080#1083#1080' '#1092#1080#1085#1080#1096#1072
    Caption = #1047#1072#1092#1080#1082#1089#1080#1088#1086#1074#1072#1090#1100
    Color = clGradientInactiveCaption
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    object CheckBoxStart: TCheckBox
      Left = 8
      Top = 16
      Width = 81
      Height = 17
      Hint = #1055#1077#1088#1074#1099#1081' '#1087#1091#1085#1082#1090' '#1089#1083#1077#1076#1086#1074#1072#1085#1080#1103
      Caption = #1057#1090#1072#1088#1090
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 0
    end
    object CheckBoxFinish: TCheckBox
      Left = 8
      Top = 32
      Width = 81
      Height = 17
      Hint = #1055#1086#1089#1083#1077#1076#1085#1080#1081' '#1087#1091#1085#1082#1090' '#1089#1083#1077#1076#1086#1074#1072#1085#1080#1103
      Caption = #1060#1080#1085#1080#1096
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 1
    end
  end
  object BitBtn2: TBitBtn
    Left = 16
    Top = 336
    Width = 97
    Height = 25
    Hint = #1055#1088#1086#1083#1086#1078#1080#1090#1100' '#1082#1088#1072#1090#1095#1072#1081#1096#1080#1081' '#1087#1091#1090#1100
    Caption = #1053#1072#1081#1090#1080' '#1087#1091#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = BitBtn2Click
    Kind = bkRetry
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 368
    Width = 97
    Height = 57
    Hint = #1058#1080#1087' '#1087#1077#1088#1077#1076#1074#1080#1078#1077#1085#1080#1103
    Caption = #1055#1077#1088#1077#1076#1074#1080#1078#1077#1085#1080#1077
    Color = clGradientInactiveCaption
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    object CheckBoxCar: TCheckBox
      Left = 8
      Top = 16
      Width = 81
      Height = 17
      Caption = #1053#1072' '#1084#1072#1096#1080#1085#1077
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object CheckBoxFoot: TCheckBox
      Left = 8
      Top = 32
      Width = 73
      Height = 17
      Caption = #1055#1077#1096#1082#1086#1084
      TabOrder = 1
    end
  end
  object ComboBoxCity: TComboBox
    Left = 643
    Top = 496
    Width = 145
    Height = 21
    ItemHeight = 13
    Sorted = True
    TabOrder = 5
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1082#1072#1088#1090#1091
    Items.Strings = (
      #1057#1080#1085#1075#1072#1087#1091#1088
      #1056#1080#1075#1072
      #1052#1080#1085#1089#1082
      #1051#1072#1089'-'#1042#1077#1075#1072#1089
      #1050#1080#1077#1074
      #1043#1083#1072#1079#1075#1086
      'Test Map')
  end
  object BitBtn1: TBitBtn
    Left = 52
    Top = 240
    Width = 25
    Height = 25
    Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1091#1085#1082#1090' '#1089#1083#1077#1076#1086#1074#1072#1085#1080#1103
    ModalResult = 7
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = BitBtn1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333FFFFF333333000033333388888833333333333F888888FFF333
      000033338811111188333333338833FFF388FF33000033381119999111833333
      38F338888F338FF30000339119933331111833338F388333383338F300003391
      13333381111833338F8F3333833F38F3000039118333381119118338F38F3338
      33F8F38F000039183333811193918338F8F333833F838F8F0000391833381119
      33918338F8F33833F8338F8F000039183381119333918338F8F3833F83338F8F
      000039183811193333918338F8F833F83333838F000039118111933339118338
      F3833F83333833830000339111193333391833338F33F8333FF838F300003391
      11833338111833338F338FFFF883F83300003339111888811183333338FF3888
      83FF83330000333399111111993333333388FFFFFF8833330000333333999999
      3333333333338888883333330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BitBtn3: TBitBtn
    Left = 88
    Top = 240
    Width = 25
    Height = 25
    Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1091#1085#1082#1090' '#1089#1083#1077#1076#1086#1074#1072#1085#1080#1103
    ModalResult = 6
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = BitBtn3Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object GroupBox3: TGroupBox
    Left = 16
    Top = 432
    Width = 97
    Height = 41
    Caption = #1044#1083#1080#1085#1072' '#1087#1091#1090#1080', '#1084
    TabOrder = 8
    object LabelDist: TLabel
      Left = 9
      Top = 20
      Width = 6
      Height = 13
      Caption = '0'
    end
  end
  object GroupBoxLoad: TGroupBox
    Left = 800
    Top = 496
    Width = 129
    Height = 81
    Caption = #1058#1080#1087' '#1076#1086#1088#1086#1075
    TabOrder = 9
    object CheckBoxCarLoad: TCheckBox
      Left = 8
      Top = 24
      Width = 113
      Height = 17
      Caption = #1040#1074#1090#1086#1084#1086#1073#1080#1083#1100#1085#1099#1077
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object CheckBoxFootLoad: TCheckBox
      Left = 8
      Top = 48
      Width = 97
      Height = 17
      Caption = #1055#1077#1096#1077#1093#1086#1076#1085#1099#1077
      TabOrder = 1
    end
  end
  object BitBtn5: TBitBtn
    Left = 1264
    Top = 8
    Width = 113
    Height = 35
    Caption = #1042#1099#1073#1088#1072#1090#1100' '#1082#1072#1088#1090#1091
    TabOrder = 10
    WordWrap = True
    OnClick = BitBtn5Click
    Kind = bkRetry
  end
  object SettingsBtn: TBitBtn
    Left = 1384
    Top = 8
    Width = 35
    Height = 35
    Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1080
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = SettingsBtnClick
    Glyph.Data = {
      060A0000424D060A000000000000420000002800000019000000190000000100
      200003000000C4090000130B0000130B00000000000000000000000000FF0000
      FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFF9F9F9FF7C7C7CFF000000FF000000FF000000FF64
      6464FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFF272727FF000000FF000000FF00
      0000FF151515FFE4E4E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF
      CFCFFFA2A2A2FFDADADAFFFFFFFFFFFFFFFFFFE2E2E2FF1F1F1FFF000000FF00
      0000FF000000FF161616FFDCDCDCFFFFFFFFFFFFFFFFFFD5D5D5FF9F9F9FFFCB
      CBCBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBA
      BABAFF1D1D1DFF000000FF2F2F2FFFBFBFBFFFC6C6C6FF6D6D6DFF040404FF00
      0000FF000000FF000000FF070707FF656565FFC9C9C9FFB9B9B9FF282828FF00
      0000FF1B1B1BFFB6B6B6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0
      D0D0FF131313FF000000FF000000FF000000FF1B1B1BFF1D1D1DFF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF1C1C1CFF141414FF00
      0000FF000000FF000000FF1B1B1BFFCBCBCBFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF898989FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FFA0A0A0FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFE7E7E7FF131313FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF282828FFD5D5D5FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6D6D6FF030303FF000000FF000000FF00
      0000FF000000FF000000FF010101FF171717FF202020FF181818FF010101FF00
      0000FF000000FF000000FF000000FF000000FF141414FFB8B8B8FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E9FF0B0B0BFF000000FF00
      0000FF000000FF000000FF141414FF7A7A7AFFBDBDBDFFD3D3D3FFBDBDBDFF7A
      7A7AFF1C1C1CFF000000FF000000FF000000FF000000FF1C1C1CFFC9C9C9FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7E7E7FFE1E1E1FF6E6E6EFF000000FF00
      0000FF000000FF000000FF080808FFBABABAFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFB1B1B1FF1B1B1BFF000000FF000000FF000000FF000000FF64
      6464FFDCDCDCFFE4E4E4FFFFFFFFFF707070FF171717FF171717FF060606FF00
      0000FF000000FF000000FF000000FF7C7C7CFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7AFF010101FF000000FF000000FF00
      0000FF070707FF161616FF151515FF646464FF2E2E2EFF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FFE7E7E7FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBDBDBDFF181818FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF2C2C2CFF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3D3D3FF202020FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF2D2D2DFF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FFE7E7E7FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBDBDBDFF17
      1717FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF85
      8585FF2A2A2AFF252525FF000000FF000000FF000000FF000000FF000000FF74
      7474FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A
      7A7AFF010101FF000000FF000000FF000000FF030303FF1E1E1EFF272727FF7C
      7C7CFFF5F5F5FFE1E1E1FFE0E0E0FF7E7E7EFF000000FF000000FF000000FF00
      0000FF0D0D0DFFB0B0B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBB
      BBBBFF141414FF000000FF000000FF000000FF000000FF6D6D6DFFE2E2E2FFDF
      DFDFFFF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFE8E8E8FF080808FF000000FF00
      0000FF000000FF000000FF0D0D0DFF747474FFE7E7E7FFFFFFFFFFE7E7E7FF7C
      7C7CFF080808FF000000FF000000FF000000FF000000FF1C1C1CFFC5C5C5FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9D9D9FF0B0B0BFF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF1B1B1BFFBF
      BFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6E6E6FF232323FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF2F2F2FFFDADADAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8FFF00
      0000FF010101FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FFA3A3A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDA
      DADAFF0D0D0DFF000000FF010101FF000000FF0B0B0BFF080808FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF0A0A0AFF030303FF00
      0000FF000000FF000000FF1E1E1EFFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFCCCCCCFF0D0D0DFF000000FF232323FFD9D9D9FFE8E8E8FF7E
      7E7EFF000000FF000000FF000000FF000000FF060606FF6E6E6EFFE9E9E9FFD6
      D6D6FF131313FF000000FF131313FFBBBBBBFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDADADAFF8F8F8FFFE6E6E6FFFFFFFFFFFF
      FFFFFFE0E0E0FF252525FF000000FF000000FF000000FF171717FFE1E1E1FFFF
      FFFFFFFFFFFFFFE8E8E8FF8A8A8AFFD0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFE1E1E1FF2A2A2AFF000000FF000000FF000000FF171717FFE7
      E7E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFF5F5F5FF858585FF2C2C2CFF2C2C2CFF2E2E2EFF70
      7070FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF}
  end
  object GroupBoxSettings: TGroupBox
    Left = 312
    Top = 336
    Width = 793
    Height = 305
    Caption = 'Settings'
    TabOrder = 12
    object Label4: TLabel
      Left = 16
      Top = 40
      Width = 48
      Height = 13
      Caption = #1057#1082#1086#1088#1086#1089#1090#1100
    end
    object Label5: TLabel
      Left = 656
      Top = 40
      Width = 110
      Height = 13
      Caption = #1050#1072#1095#1077#1089#1090#1074#1086' '#1087#1088#1086#1088#1080#1089#1086#1074#1082#1080
    end
    object Label6: TLabel
      Left = 16
      Top = 168
      Width = 57
      Height = 13
      Caption = #1062#1074#1077#1090' '#1076#1086#1088#1086#1075
    end
    object Label7: TLabel
      Left = 168
      Top = 168
      Width = 50
      Height = 13
      Caption = #1062#1074#1077#1090' '#1087#1091#1090#1080
    end
    object Label8: TLabel
      Left = 472
      Top = 168
      Width = 57
      Height = 13
      Caption = #1060#1086#1085' '#1082#1072#1088#1090#1099
    end
    object Label9: TLabel
      Left = 320
      Top = 168
      Width = 69
      Height = 13
      Caption = #1062#1074#1077#1090' '#1089#1090#1088#1077#1083#1086#1082
    end
    object TrackBarDrawingRadius: TTrackBar
      Left = 8
      Top = 56
      Width = 769
      Height = 33
      Hint = #1057#1080#1085#1080#1084' '#1074#1099#1076#1077#1083#1077#1085#1072' '#1086#1087#1090#1080#1084#1072#1083#1100#1085#1072#1103' '#1086#1073#1088#1072#1089#1090#1100
      Max = 100
      ParentShowHint = False
      Position = 10
      SelEnd = 15
      SelStart = 5
      ShowHint = True
      TabOrder = 0
      OnChange = TrackBarDrawingRadiusChange
    end
    object BitBtn6: TBitBtn
      Left = 712
      Top = 272
      Width = 75
      Height = 25
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080' '#1074#1099#1081#1090#1080
      Caption = #1042#1099#1081#1090#1080
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BitBtn6Click
      Kind = bkCancel
    end
    object CheckBoxFootRoad: TCheckBox
      Left = 16
      Top = 120
      Width = 513
      Height = 17
      Caption = 
        #1042#1076#1086#1083#1100' '#1083#1102#1073#1086#1081' '#1076#1086#1088#1086#1075#1080' '#1084#1086#1078#1085#1086' '#1093#1086#1076#1080#1090#1100', '#1076#1072#1078#1077' '#1077#1089#1083#1080' '#1086#1085#1072' '#1085#1077' '#1080#1084#1077#1077#1090' '#1087#1077#1096#1077#1093#1086#1076#1085 +
        #1086#1081' '#1079#1086#1085#1099
      TabOrder = 2
    end
    object ColorGridRoads: TColorGrid
      Left = 16
      Top = 184
      Width = 100
      Height = 100
      ForegroundIndex = 9
      BackgroundIndex = 9
      BackgroundEnabled = False
      TabOrder = 3
      OnChange = ColorGridRoadsChange
    end
    object ColorGridWay: TColorGrid
      Left = 168
      Top = 184
      Width = 100
      Height = 100
      ForegroundIndex = 2
      BackgroundEnabled = False
      TabOrder = 4
      OnChange = ColorGridWayChange
    end
    object ColorGridBackground: TColorGrid
      Left = 472
      Top = 184
      Width = 100
      Height = 100
      ForegroundIndex = 15
      BackgroundEnabled = False
      TabOrder = 5
      OnChange = ColorGridBackgroundChange
    end
    object ColorGridArrow: TColorGrid
      Left = 320
      Top = 184
      Width = 100
      Height = 100
      BackgroundEnabled = False
      TabOrder = 6
      OnChange = ColorGridArrowChange
    end
  end
end
