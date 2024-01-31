program DISimpleStepByStep;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Spring.Container,
  Step1 in 'Step1.pas',
  Step2 in 'Step2.pas',
  Step3 in 'Step3.pas',
  OrderInterfaces in 'OrderInterfaces.pas',
  Step4 in 'Step4.pas',
  Step5 in 'Step5.pas',
  Step6 in 'Step6.pas',
  uOrder in 'uOrder.pas',
  uOrderValidator in 'uOrderValidator.pas';

begin
  try
    GlobalContainer.Build;
    Randomize;
    ProcessOrders1;
    ProcessOrders2;
    ProcessOrders3;
    ProcessOrders4;
  //  ProcessOrders5;
    ProcessOrders6;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
