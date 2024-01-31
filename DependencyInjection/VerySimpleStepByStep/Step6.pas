unit Step6;

interface

uses
      OrderInterfaces
    ;

type

  TOrderProcessor = class
  private
    FOrderValidator: IOrderValidator;
  public
    constructor Create(aOrderValidator: IOrderValidator);
    procedure ProcessOrder(aOrder: IOrder);
  end;

procedure ProcessOrders6;

implementation

uses
      System.SysUtils
    , Spring.Container
    , Spring.Services
    ;

procedure ProcessOrders6;
var
  Order: IOrder;
  OrderValidator: IOrderValidator;
  OrderProcessor: TOrderProcessor;
begin
  OrderValidator := ServiceLocator.GetService<IOrderValidator>;
  OrderProcessor := TOrderProcessor.Create(OrderValidator);
  try
    Order := ServiceLocator.GetService<IOrder>;
    OrderProcessor.ProcessOrder(Order);
  finally
    OrderProcessor.Free;
  end;
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

end.
