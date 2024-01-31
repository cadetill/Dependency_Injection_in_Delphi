program uRegisterFactoryDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Spring.Container,
  uCoffeeMaker in 'uCoffeeMaker.pas';

type
  {$M+}
  TCoffeeMakerFactory = reference to function(const aCoffeeBrand: string; const aBrewingMinutes: integer): ICoffeeMaker;
  TCupCoffeeMakerFactory = reference to function(const aCupType: string): ICoffeeMaker;
  {$M-}

var
  CoffeeName: string;
  CupName: string;
  BrewingMinutes: integer;
  CoffeeMakerFactory: TCoffeeMakerFactory;
  CupCoffeeMakerFactory: TCupCoffeeMakerFactory;
  CoffeeMaker: ICoffeeMaker;
  Container: TContainer;
begin
  Container := TContainer.Create;
  try try
    Container.RegisterType<ICoffeeMaker, TCoffeeMaker>('regular');
    Container.RegisterType<ICoffeeMaker, TCupCoffeeMaker>('cup');

    Container.RegisterFactory<TCoffeeMakerFactory>.AsFactory('regular');
    Container.RegisterFactory<TCupCoffeeMakerFactory>.AsFactory('cup');
    Container.Build;

    Write('What kind of coffee do you want to make? ');
    ReadLn(CoffeeName);

    Write('How many minutes? ');
    ReadLn(BrewingMinutes);

    CoffeeMakerFactory := Container.Resolve<TCoffeeMakerFactory>();
    CoffeeMaker := CoffeeMakerFactory(CoffeeName, BrewingMinutes);
    CoffeeMaker.MakeCoffee;

    Writeln;

    Write('What kind of cup do you want to make?');
    Readln(CupName);
    CupCoffeeMakerFactory := Container.Resolve<TCupCoffeeMakerFactory>();
    CoffeeMaker := CupCoffeeMakerFactory(CupName);
    CoffeeMaker.MakeCoffee;
  finally
    Container.Free;
  end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
