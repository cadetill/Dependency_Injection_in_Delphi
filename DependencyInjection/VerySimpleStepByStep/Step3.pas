unit Step3;

interface

type
  TOrder = class
    function Amount: integer;
  end;

  IOrderValidator = interface
  ['{4CCA1F87-21C2-4755-9E6F-8573B909CE11}']
  procedure ValidateOrder(aOrder: TOrder);
  end;

  TOrderValidator = class(TInterfacedObject, IOrderValidator)
    procedure ValidateOrder(aOrder: TOrder);
  end;

  TOrderProcessor = class
  private
    FOrderValidator: IOrderValidator;
  public
    constructor Create(aOrderValidator: IOrderValidator);
    procedure ProcessOrder(aOrder: TOrder);
  end;

procedure ProcessOrders3;

implementation

uses
      System.SysUtils
    ;

procedure ProcessOrders3;
var
  Order: TOrder;
  OrderProcessor: TOrderProcessor;
begin
  OrderProcessor := TOrderProcessor.Create(TOrderValidator.Create);
  try
    Order := TOrder.Create;
    try
      OrderProcessor.ProcessOrder(Order);
    finally
      Order.Free;
    end;
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


procedure TOrderProcessor.ProcessOrder(aOrder: TOrder);
begin
  FOrderValidator.ValidateOrder(aOrder);
end;

{ TOrderValidator }

procedure TOrderValidator.ValidateOrder(aOrder: TOrder);
begin
  WriteLn('Order is valid for $' + IntToStr(aOrder.Amount));
end;

end.
