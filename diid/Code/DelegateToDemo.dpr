program DelegateToDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Spring.Container,
  System.SysUtils,
  uDelegateTo in 'uDelegateTo.pas',
  uDelegateToRegistration in 'uDelegateToRegistration.pas';

var
  Container: TContainer;

begin
  Container := TContainer.Create;
  try try
    RegisterStuff(Container);
    OutputName(Container);
  finally
    Container.Free;
  end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
