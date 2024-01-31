unit uLifetimeRegistration;

interface

uses
    Spring.Container
  ;

procedure RegisterStuff(aContainer: TContainer);

implementation

uses
      uSingletonDemo
    ;

procedure RegisterStuff(aContainer: TContainer);
begin
  aContainer.RegisterType<ILogger, TConsoleLogger>.AsSingleton();
  aContainer.RegisterType<ICarPartManager, TCarPartManager>;
  aContainer.Build;
end;

end.
                                                                                                             z