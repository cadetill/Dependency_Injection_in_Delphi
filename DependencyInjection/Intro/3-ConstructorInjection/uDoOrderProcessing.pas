unit uDoOrderProcessing;

interface

procedure DoOrderProcessing;

implementation

uses
     uOrder
   , uOrderValidator
   , uOrderEntry
   , uOrderProcessor
   ;

procedure DoOrderProcessing;
var
  Order: TOrder;
  OrderProcessor: IOrderProcessor;
  OrderValidator: IOrderValidator;
  OrderEntry: IOrderEntry;
begin
  Order := TOrder.Create;
  OrderValidator := TOrderValidator.Create;
  OrderEntry := TOrderEntry.Create;
  try
    OrderProcessor := TOrderProcessor.Create(OrderValidator, OrderEntry);
    if OrderProcessor.ProcessOrder(Order) then
    begin
      WriteLn('Order successfully processed....');
    end;
  finally
    Order.Free;
  end;
end;

end.
