object DMDados: TDMDados
  OldCreateOrder = False
  Height = 400
  Width = 622
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Herick\Desktop\faculdade\quarto semestre\LINGU' +
        'AGEM DE PROGRAMA'#199#195'O II\Chat_Horus\Banco\DADOS.FDB'
      'Port=3050'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 120
    Top = 64
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 120
    Top = 144
  end
end
