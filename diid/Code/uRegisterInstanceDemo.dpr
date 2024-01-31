program uRegisterInstanceDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Spring.Container,
  uWorkersAndTools in 'uWorkersAndTools.pas';

var
  Container: TContainer;

begin
  Container := TContainer.Create;
  try try
    Main(Container);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  finally
    Container.Free;
  end;
  Readln;
end.
