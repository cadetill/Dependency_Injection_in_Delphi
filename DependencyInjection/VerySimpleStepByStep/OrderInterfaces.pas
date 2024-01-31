unit OrderInterfaces;

interface

type

  IOrder = interface
  ['{B4680E66-2642-40CC-B4EB-EEE9172F49B1}']
    function Amount: integer;
  end;

  IOrderValidator = interface
  ['{4CCA1F87-21C2-4755-9E6F-8573B909CE11}']
    procedure ValidateOrder(aOrder: IOrder);
  end;

implementation

end.
