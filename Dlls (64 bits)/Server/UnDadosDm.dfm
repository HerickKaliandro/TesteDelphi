object DmDados: TDmDados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 314
  Width = 449
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Carlos\Desktop\Nova pasta\Chat_Horus\Banco\DAD' +
        'OS.FDB'
      'Protocol=TCPIP'
      'Server=127.0.0.1'
      'Port=3050'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 157
    Top = 72
  end
end
