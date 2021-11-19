object FormServidor: TFormServidor
  Left = 0
  Top = 0
  ClientHeight = 463
  ClientWidth = 748
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 748
    Height = 463
    Align = alClient
    DataSource = DataSource1
    DrawingStyle = gdsGradient
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PROTOCOLO'
        Title.Caption = 'Protocolo'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IDPARCEIRO'
        Title.Caption = 'ID Conex'#227'o'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SENHA'
        Title.Caption = 'Senha'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LATENCIA'
        Title.Caption = 'Lat'#234'ncia'
        Width = 60
        Visible = True
      end>
  end
  object DataSource1: TDataSource
    DataSet = QryConexoes
    Left = 64
    Top = 144
  end
  object QryConexoes: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'PROTOCOLO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ID'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'IDPARCEIRO'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'SENHA'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'LATENCIA'
        DataType = ftString
        Size = 10
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 64
    Top = 96
    object QryConexoesPROTOCOLO: TStringField
      FieldName = 'PROTOCOLO'
      Size = 10
    end
    object QryConexoesID: TStringField
      FieldName = 'ID'
      Size = 11
    end
    object QryConexoesIDPARCEIRO: TStringField
      FieldName = 'IDPARCEIRO'
      Size = 11
    end
    object QryConexoesSENHA: TStringField
      FieldName = 'SENHA'
      Size = 4
    end
    object QryConexoesLATENCIA: TStringField
      FieldName = 'LATENCIA'
      Size = 10
    end
  end
  object tReload: TTimer
    Interval = 5000
    OnTimer = tReloadTimer
    Left = 648
    Top = 40
  end
end