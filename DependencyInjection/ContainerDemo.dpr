program ContainerDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Spring.Container,
  Spring.Services,
  uNoServiceLocatorDemo in 'uNoServiceLocatorDemo.pas',
  uContainerStuff in 'uContainerStuff.pas';


var
  TempBattlefield: TBattlefield;


begin
  try
    GlobalContainer.Build;

    DoStuff;

    UseRifleWithScope;


   TempBattleField := TBattlefield.Create;
   try
     TempBattlefield.AddFighter(TKnight.Create(TSword.Create));
     FightBattle(TempBattlefield);
   finally
     TempBattlefield.Free;
   end;

    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
