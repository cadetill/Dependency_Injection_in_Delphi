unit uPropertyInjection;

interface

type
  INinjaStar = interface
    procedure Throw;
  end;

  INinjaSword = interface
    procedure Swing;
  end;

  TNinja = class
  private
    FNinjaStar: INinjaStar;
    FNinjaSword: INinjaSword;
  public
    constructor Create(aSword: INinjaSword);
    property NinjaStar: INinjaStar read FNinjaStar write FNinjaStar;
  end;

implementation

{ TNinja }

constructor TNinja.Create(aSword: INinjaSword);
begin
  inherited Create;
  FNinjaSword := aSword;
  FNinjaStar := nil;
end;

end.
