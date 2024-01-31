unit Step1;

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
    constructor Create;
    destructor Destroy; override;
    procedure ProcessOrder(aOrder: TOrder);
  end;

procedure ProcessOrders1;

implementation

uses
      System.SysUtils
    ;

procedure ProcessOrders1;
var
  Order: TOrder;
  OrderProcessor: TOrderProcessor;
begin
  OrderProcessor := TOrderProcessor.Create;
  try


    OrderProcessor.ProcessOrder(TOrder.Create);
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

constructor TOrderProcessor.Create;
begin
  FOrderValidator := TOrderValidator.Create;
end;

destructor TOrderProcessor.Destroy;
begin
  FOrderValidator.Free;
  inherited;
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
