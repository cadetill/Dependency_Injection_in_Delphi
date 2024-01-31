unit uOrderValidator;

interface

implementation

uses
      OrderInterfaces
    , Spring.Container
    , System.SysUtils
    ;

type

  TOrderValidator = class(TInterfacedObject, IOrderValidator)
    procedure ValidateOrder(aOrder: IOrder);
  end;

{ TOrderValidator }

procedure TOrderValidator.ValidateOrder(aOrder: IOrder);
begin
  WriteLn('Order is valid for $' + IntToStr(aOrder.Amount));
end;

initialization
  GlobalContainer.RegisterType<TOrderValidator>.Implements<IOrderValidator>;

end.
