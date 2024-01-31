unit uContainerStuff;

interface

uses
     Spring.Container
   , Spring.Services
   ;

type
  IFirearm = interface
  ['{47C93F4A-D07F-4E66-964C-6E21A3F4AB17}']
    procedure Fire;
  end;

  IAimingDevice = interface
  ['{3DB34251-B82B-443D-AF1C-7182DC46D014}']
    procedure Aim;
  end;

  TScope = class(TInterfacedObject, IAimingDevice)
    procedure Aim;
  end;

  TNormalSight = class(TInterfacedObject, IAimingDevice)
    procedure Aim;
  end;

  IClip = interface
  ['{14683A11-8CA0-4553-83D1-F6CB6CB6B562}']
    procedure LoadIntoWeapon;
  end;

  T14RoundClip = class(TInterfacedObject, IClip)
    procedure LoadIntoWeapon;
  end;

  TRifle = class(TInterfacedObject, IFirearm)
  private
    FHasScope: Boolean;
    FScope: IAimingDevice;
    FMetalSight: IAimingDevice;
  public
    Clip: IClip;
    procedure Fire;
    [Inject('scope')]
    property Scope: IAimingDevice read FScope write FScope;
    property MetalSight: IAimingDevice read FMetalSight write FMetalSight;
  end;

procedure DoStuff;
procedure UseRifleWithScope;

implementation

procedure UseRifleWithScope;
var
  Rifle: TRifle;
begin
  Rifle := ServiceLocator.GetService<TRifle>;
  try
    // Clip exists because of field injection
    Rifle.Clip.LoadIntoWeapon;
    // MetalSight exists because of call to InjectProperty
    Rifle.MetalSight.Aim;
    // Scope exists because of [Inject] attribute
    Rifle.Scope.Aim;
    Rifle.Fire
  finally
    Rifle.Free;
  end;
end;

procedure DoStuff;
var
  Rifle: IFirearm;
begin
  Rifle := ServiceLocator.GetService<TRifle>;
  Rifle.Fire
end;

{ TRegisterExample }


procedure TRifle.Fire;
begin
  WriteLn('Bang!');
end;

{ TScope }

procedure TScope.Aim;
begin
  Writeln('Put scope''s crosshairs on the target');
end;

{ TNormalSight }

procedure TNormalSight.Aim;
begin
  WriteLn('Stare down the metal sight');
end;

{ T14RoundClip }

procedure T14RoundClip.LoadIntoWeapon;
begin
  WriteLn('Weapon now loaded with 14 rounds.');
end;

initialization
  GlobalContainer.RegisterType<TRifle>.Implements<IFirearm>.InjectProperty('MetalSight', 'sight')
                                                           .InjectField('Clip');
  GlobalContainer.RegisterType<TScope>.Implements<IAimingDevice>('scope').AsDefault<IAimingDevice>;
  GlobalContainer.RegisterType<TNormalSight>.Implements<IAimingDevice>('sight');
  GlobalContainer.RegisterType<T14RoundClip>.Implements<IClip>;




end.
