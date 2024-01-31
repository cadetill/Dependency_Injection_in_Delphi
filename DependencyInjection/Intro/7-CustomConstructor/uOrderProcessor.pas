unit uOrderProcessor;

interface

implementation

uses
       uOrder
     , uOrderInterfaces
     , Spring.Container
     , Spring.Services
     ;

type
  TOrderProcessor = class(TInterfacedObject, IOrderProcessor)
  private
    FOrderValidator: IOrderValidator;
    FOrderEntry: IOrderEntry;
  public
    constructor Create(aOrderValidator: IOrderValidator; aOrderEntry: IOrderEntry);
    function ProcessOrder(aOrder: TOrder): Boolean;
  end;

{ TOrderProcessor }

constructor TOrderProcessor.Create(aOrderValidator: IOrderValidator; aOrderEntry: IOrderEntry);
begin
  FOrderValidator := aOrderValidator;
  FOrderEntry := aOrderEntry;
end;

function TOrderProcessor.ProcessOrder(aOrder: TOrder): Boolean;
var
  OrderIsValid: Boolean;
begin
  Result := False;
  OrderIsValid := FOrderValidator.ValidateOrder(aOrder);
  if OrderIsValid then
  begin
    Result := FOrderEntry.EnterOrderIntoDatabase(aOrder);
  end;

  {$IFDEF CONSOLEAPP}
    WriteLn('Order has been processed....');
  {$ENDIF}
end;

initialization
  GlobalContainer.RegisterComponent<TOrderProcessor>.Implements<IOrderProcessor>.DelegateTo(
    function: TOrderProcessor
    begin
      Result := TOrderProcessor.Create(ServiceLocator.GetService<IOrderValidator>, ServiceLocator.GetService<IOrderEntry>);
    end
  );

end.
