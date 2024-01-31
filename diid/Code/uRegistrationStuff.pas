unit uRegistrationStuff;

interface

uses
    Spring.Container
  ;

procedure RegisterStuff(aContainer: TContainer);

implementation

uses
    uFieldInjection
  , uAttributes
  , uNoServiceLocatorDemo
  ;




procedure RegisterStuff(aContainer: TContainer);
begin
  aContainer.RegisterType<IBrake, TBrakes>;
  aContainer.RegisterType<IEngine, TEngine>;
  aContainer.RegisterType<ICar, TCar>.InjectField('FBrakes');

  aContainer.RegisterType<IWeapon, TSword>('sword').AsDefault;
  aContainer.RegisterType<IWeapon,TSpear>('spear');
  aContainer.RegisterType<IFighter, TKnight>('knight');
  aContainer.RegisterType<TBattleField>;

  aContainer.RegisterType<ICowboy, TCowboy>;
  aContainer.RegisterType<IHorse, THorse>;
  aContainer.Build;
end;


end.
