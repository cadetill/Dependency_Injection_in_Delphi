program uLazyDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Spring.Container,
  uExpensiveProcess in 'uExpensiveProcess.pas';

var
  Container: TContainer;

begin
  Container := TContainer.Create;
  try try
    Main(Container);
  finally
    Container.Free;
  end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
