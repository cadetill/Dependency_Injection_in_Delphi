unit Step4;

interface

uses
      OrderInterfaces
    ;

type
  TOrder = class(TInterfacedObject, IOrder)
    function Amount: integer;
  end;

  TOrderValidator = class(TInterfacedObject, IOrderValidator)
    procedure ValidateOrder(aOrder: IOrder);
  end;

  TOrderProcessor = class
  private
    FOrderValidator: IOrderValidator;
  public
    constructor Create(aOrderValidator: IOrderValidator);
    procedure ProcessOrder(aOrder: IOrder);
  end;

procedure ProcessOrders4;

implementation

uses
      System.SysUtils
    ;

procedure ProcessOrders4;
var
  Order: IOrder;
  OrderProcessor: TOrderProcessor;
begin
  OrderProcessor := TOrderProcessor.Create(TOrderValidator.Create);
  try
    Order := TOrder.Create;
    OrderProcessor.ProcessOrder(Order);
  finally
    OrderProcessor.Free;
  end;
end;

{ TOrder }

function TOrder.Amount: integer;
begin
  Result := Random(1000) + 1
end;

{ TOrderProcessor }

constructor TOrderProcessor.Create(aOrderValidator: IOrderValidator);
begin
  inherited Create;
  FOrderValidator := aOrderValidator;
end;


procedure TOrderProcessor.ProcessOrder(aOrder:IOrder);
begin
  FOrderValidator.ValidateOrder(aOrder);
end;

{ TOrderValidator }

procedure TOrderValidator.ValidateOrder(aOrder: IOrder);
begin
  WriteLn('Order is valid for $' + IntToStr(aOrder.Amount));
end;

end.
