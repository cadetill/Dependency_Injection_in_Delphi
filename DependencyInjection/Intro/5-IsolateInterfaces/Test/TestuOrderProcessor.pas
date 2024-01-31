unit TestuOrderProcessor;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, uOrder, uOrderEntry, uOrderValidator, uOrderProcessor, uOrderInterfaces;

type
  // Test methods for class TOrderProcessor

  TestTOrderProcessor = class(TTestCase)
  strict private
    FOrderProcessor: IOrderProcessor;
  published
    procedure TestProcessOrder;
  end;

implementation

uses
  uOrderMocks;

procedure TestTOrderProcessor.TestProcessOrder;
var
  aOrder: TOrder;
begin
  // TODO: Setup method call parameters
  FOrderProcessor := TOrderProcessor.Create(TMockOrderValidator.Create, TMockOrderEntry.Create);
  aOrder := TOrder.Create;
  try

    // We can check success, but...
    Check(FOrderProcessor.ProcessOrder(aOrder));

    // how do we check that the order really made it to the database?
    // Or do we even want to....?

  finally
    aOrder.Free;
  end;
  // TODO: Validate method results
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTOrderProcessor.Suite);
end.

