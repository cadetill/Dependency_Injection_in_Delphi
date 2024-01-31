unit uNoServiceLocator;

interface

uses
      Spring.Container
    , Spring.Services
    ;

type
  IWeapon = interface
  ['{B5BE0086-4FD2-4523-A99C-21C8EA23B93C}']
    procedure WieldWeapon;
  end;

  IShield = interface
  ['{9B54C1E8-3061-49FF-A17C-D69655209802}']
    procedure Block;
  end;

  IFightable = interface
  ['{A24A33AD-ADD5-442A-A909-1BF7D3FE0237}']
    procedure Fight;
  end;

  TSword = class(TInterfacedObject, IWeapon)
  private
    FHasValeryanSteel: Boolean;
  public
    constructor Create(aHasValeryanSteel: Boolean);
    procedure WieldWeapon;
    property HasValeryanSteel: boolean read FHasValeryanSteel;
  end;

  TDagger = class(TInterfacedObject, IWeapon)
    procedure WieldWeapon;
  end;

  TSharpEdgedShield = class(TInterfacedObject, IWeapon, IShield)
    procedure WieldWeapon;
    procedure Block;
  end;

  TKnight = class(TInterfacedObject, IFightable)
  private
    FWeapon: IWeapon;
  public
    constructor Create(aWeapon: IWeapon);
    procedure Fight;
  end;

  TKing = class(TInterfacedObject, IFightable)
  private
    FWeapon: IWeapon;
    FName: string;
  public
    constructor Create(aWeapon: IWeapon; aName: string);
    procedure Fight;
  end;


TDemoMethods = class
private
  [Inject('arthur')]
  FKing: IFightable;
  FSword: IWeapon;
  FWeapon: IWeapon;
  FKnight: IFightable;
  FShield: IShield;
  FShieldWeapon: IWeapon;
public
  constructor Create(aShieldWeapon: IWeapon);
  procedure SwingSword;
  procedure FightWithShield;
  procedure KnightFights;
  procedure KingFights;
  [Inject]
  procedure SetShield(aShield: IShield);
  property Knight: IFightable read FKnight write FKnight;
end;

implementation

uses
       System.SysUtils
     ;

procedure TDemoMethods.KingFights;
begin
  FKing.Fight;
end;

procedure TDemoMethods.KnightFights;
begin
  Knight.Fight;
end;


constructor TDemoMethods.Create(aShieldWeapon: IWeapon);
begin
  FShieldWeapon := aShieldWeapon;
end;

procedure TDemoMethods.FightWithShield;
begin
  FShield.Block;
  FShieldWeapon.WieldWeapon;
end;

procedure TDemoMethods.SetShield(aShield: IShield);
begin
  FShield := aShield;
end;

procedure TDemoMethods.SwingSword;
begin
  FSword.WieldWeapon;
end;

constructor TKnight.Create(aWeapon: IWeapon);
begin
  inherited Create;
  FWeapon := aWeapon;
end;

procedure TKnight.Fight;
begin
  Write('The Knight engages in battle! ');
  FWeapon.WieldWeapon;
end;

{ TSword }

constructor TSword.Create(aHasValeryanSteel: Boolean);
begin
  FHasValeryanSteel := aHasValeryanSteel;
end;

procedure TSword.WieldWeapon;
begin
  if HasValeryanSteel then
  begin
    WriteLn('Swing with a blaze of fire!');
  end else
  begin
    Writeln('Swing with an ordinary swipe');
  end;
end;

{ TDagger }

procedure TDagger.WieldWeapon;
begin
  WriteLn('Stab with the dagger');
end;

{ TSharpEdgedShield }

procedure TSharpEdgedShield.Block;
begin
  WriteLn('Block the enemy''s blow!');
end;

procedure TSharpEdgedShield.WieldWeapon;
begin
  Writeln('Slice with the sharp edge of the shield');
end;

{ TKing }

constructor TKing.Create(aWeapon: IWeapon; aName: string);
begin
  FWeapon := aWeapon;
  FName := aName;
end;

procedure TKing.Fight;
begin
  Write(Format('King %s enters the battle! ', [FName]));
  FWeapon.WieldWeapon;
end;

initialization

  GlobalContainer.RegisterType<TKing>.Implements<IFightable>('arthur').InjectConstructor(['sword', 'Arthur']);


  GlobalContainer.RegisterType<TSword>.Implements<IWeapon>('sword').AsDefault<IWeapon>;
  GlobalContainer.RegisterType<TDagger>.Implements<IWeapon>('dagger');
  GlobalContainer.RegisterType<TSharpEdgedShield>.Implements<IWeapon>('sharpshield')
                                                 .Implements<IShield>(' shield')
                                                 .AsDefault<IShield>;

  GlobalContainer.RegisterType<TKnight>.Implements<IFightable>('knight')
                                       .InjectConstructor(['sword']);

  GlobalContainer.RegisterType<TDemoMethods>.InjectField('FSword', 'sword')
                                            .InjectField('FWeapon', 'dagger')
                                            .InjectProperty('Knight', 'knight')
                                            .InjectConstructor(['sharpshield']);

end.
