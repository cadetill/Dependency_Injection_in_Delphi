unit uPrimitiveConstructorInjection;

interface

uses
      Spring.Container,
      Spring.Container.Common
    ;

type
  TPerson = class
  private
    FOccupation: string;
    FName: string;
    FAge: integer;
    function GetName: string;
    function GetAge: integer;
    function GetOccupation: string;
  public
    constructor Create([Inject('name')]aName: string; [Inject('age')]aAge: integer; [Inject('occupation')]aOccupation: string);
    property Name: string read GetName;
    property Age: integer read GetAge;
    property Occupation: string read GetOccupation;
  end;

procedure Main(aContainer: TContainer);

implementation

uses
       System.SysUtils
     , WinAPI.Windows
     ;

function GetLocalUserName: string;
var
  aLength: DWORD;
  aUserName: array [0 .. Max_Path - 1] of Char;
begin
  aLength := Max_Path;
  if not GetUserName(aUserName, aLength) then
  begin
    raise Exception.CreateFmt('Win32 Error %d: %s', [GetLastError, SysErrorMessage(GetLastError)]);
  end;
  Result := string(aUserName);
end;


procedure Main(aContainer: TContainer);
var
  TempName: TPerson;
begin
  Randomize;
  aContainer.RegisterType<TPerson>;
  aContainer.RegisterType<string>('name').DelegateTo(
                                   function: string
                                   begin
                                     Result := GetLocalUsername;
                                   end
                                   );
  aContainer.RegisterType<string>('occupation').DelegateTo(
                                   function: string
                                   begin
                                     Result := 'plumber';
                                   end
                                   );

  aContainer.RegisterType<integer>('age').DelegateTo(
                                   function: integer
                                   begin
                                     Result := Random(100);
                                   end
                                   );
  aContainer.Build;

  TempName := aContainer.Resolve<TPerson>;
  WriteLn(TempName.Name, ' is ', TempName.Age, ' years old', ' and is a ', TempName.Occupation);
  Readln;
end;

{ TName }

constructor TPerson.Create(aName: string; aAge: integer; aOccupation: string);
begin
  inherited Create;
  FName := aName;
  FAge := aAge;
  FOccupation := aOccupation;
end;

function TPerson.GetAge: integer;
begin
  Result := FAge;
end;

function TPerson.GetName: string;
begin
  Result := FName;
end;

function TPerson.GetOccupation: string;
begin
  Result := FOccupation;
end;

initialization


end.
