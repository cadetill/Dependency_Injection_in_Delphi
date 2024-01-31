program IsolateInterfaces;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uDoOrderProcessing in 'uDoOrderProcessing.pas',
  uOrderEntry in 'uOrderEntry.pas',
  uOrderInterfaces in 'uOrderInterfaces.pas',
  uOrderProcessor in 'uOrderProcessor.pas',
  uOrderValidator in 'uOrderValidator.pas';

begin
  try
    DoOrderProcessing;
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
