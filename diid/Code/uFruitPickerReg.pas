unit uFruitPickerReg;

interface

uses
    Spring.Container
  ;

procedure RegisterFruitPickers(aContainer: TContainer);

implementation

uses
      uFruitPickerIntf
    , uFruitPickersImpl
    ;

procedure RegisterFruitPickers(aContainer: TContainer);
begin
  aContainer.RegisterType<IFruitPicker, THumanFruitPicker>('human').AsDefault;
  aContainer.RegisterType<IFruitPicker, TMechanicalFruitPicker>('mechanical');
  aContainer.RegisterType<IFruitPicker, TRobotFruitPicker>('robot');
  aContainer.Build;
end;

end.
