unit uNoServiceLocatorDemo;

interface

uses
      Spring.Container
    , Spring.Services
    , Spring.Collections
    ;

type
  IWeapon = interface
  ['{0F63DF32-F65F-4708-958E-E1931814EC33}']
    procedure Weild;
  end;

  IFighter = interface
  ['{0C926753-A70D-40E3-8C35-85CA2C4B18CA}']
    procedure Fight;
  end;

  TBattleField = class
  private
    FFighter: IFighter;
  public
    procedure AddFighter(aFighter: IFighter);
    procedure Battle;
  end;

  TSword = class(TInterfacedObject, IWeapon)
    procedure Weild;
  end;

  TKnight = class(TInterfacedObject, IFighter)
  private
    FWeapon: IWeapon;
 public
    constructor Create(aWeapon: IWeapon);
    procedure Fight;
  end;

procedure FightBattle(aBattlefield: TBattlefield);

implementation

procedure FightBattle(aBattlefield: TBattlefield);
begin
  aBattlefield.Battle;
end;

{ TBattleField }

procedure TBattleField.AddFighter(aFighter: IFighter);
begin
  FFighter := aFighter;
end;

procedure TBattleField.Battle;
begin
  WriteLn('The Battle is on!');
  FFighter.Fight;
end;

{ TKnight }

constructor TKnight.Create(aWeapon: IWeapon);
begin
  inherited Create;
  FWeapon := aWeapon;
end;

procedure TKnight.Fight;
begin
  WriteLn('The knight swings into action!');
  FWeapon.Weild;
end;

{ TSword }

procedure TSword.Weild;
begin
  WriteLn('"Swoosh" goes the sword!');
end;

initialization

  GlobalContainer.RegisterType<TBattleField>.InjectMethod('AddFighter', ['knight']);

  GlobalContainer.RegisterType<TSword>.Implements<IWeapon>('sword');
  GlobalContainer.RegisterType<TKnight>.Implements<IFighter>('knight').InjectConstructor(['sword']);


end.
