unit uOrder;

interface

implementation

uses
     OrderInterfaces
   , Spring.Container
   ;

type

  TOrder = class(TInterfacedObject, IOrder)
    function Amount: integer;
  end;

  { TOrder }

function TOrder.Amount: integer;
begin
  Result := Random(1000) + 1
end;

initialization
  GlobalContainer.RegisterType<TOrder>.Implements<IOrder>;

end.
