unit Step2;

interface

type
  TOrder = class
    function Amount: integer;
  end;

  TOrderValidator = class
    procedure ValidateOrder(aOrder: TOrder);
  end;

  TOrderProcessor = class
  private
    FOrderValidator: TOrderValidator;
  public
    constructor Create(aOrderValidator: TOrderValidator);
    destructor Destroy; override;
    procedure ProcessOrder(aOrder: TOrder);
  end;

procedure ProcessOrders2;

implementation

uses
      System.SysUtils
    ;

procedure ProcessOrders2;
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

constructor TOrderProcessor.Create(aOrderValidator: TOrderValidator);
begin
  inherited Create;
  FOrderValidator := aOrderValidator;
end;

destructor TOrderProcessor.Destroy;
begin
  FOrderValidator.Free;
  inherited Destroy;
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
