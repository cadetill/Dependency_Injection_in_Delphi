program DILifetimeDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Spring.Container,
  uSingletonDemo in 'uSingletonDemo.pas',
  uLifetimeRegistration in 'uLifetimeRegistration.pas';

var
  Container: TContainer;

begin
  Container := TContainer.Create;
  try try
    RegisterStuff(Container);
    ProcessCarPart(Container);
    ProcessCarPart(Container);
    ReadLn;
  finally
    Container.Free;
  end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
