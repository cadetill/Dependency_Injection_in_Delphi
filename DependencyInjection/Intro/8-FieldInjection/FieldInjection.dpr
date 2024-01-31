program FieldInjection;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Spring.Container,
  uDoOrderProcessing in 'uDoOrderProcessing.pas',
  uOrderEntry in 'uOrderEntry.pas',
  uOrderInterfaces in 'uOrderInterfaces.pas',
  uOrderProcessor in 'uOrderProcessor.pas',
  uOrderValidator in 'uOrderValidator.pas';

begin
  try
    GlobalContainer.Build;
    DoOrderProcessing;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
