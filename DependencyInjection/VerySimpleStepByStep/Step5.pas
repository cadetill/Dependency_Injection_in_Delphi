unit Step5;

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

procedure ProcessOrders5;

implementation

uses
      System.SysUtils
    , Spring.Container
    , Spring.Services
    ;

procedure ProcessOrders5;
var
  Order: IOrder;
  OrderValidator: IOrderValidator;
  OrderProcessor: TOrderProcessor;
begin
  OrderValidator := ServiceLocator.GetService<IOrderValidator>;
  OrderProcessor := TOrderProcessor.Create(OrderValidator);
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

initialization
 // We have to comment this out for Step6 to work.
 // GlobalContainer.RegisterType<TOrderValidator>.Implements<IOrderValidator>

end.
