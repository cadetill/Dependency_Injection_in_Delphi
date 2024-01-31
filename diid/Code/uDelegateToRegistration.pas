unit uDelegateToRegistration;

interface

uses
    Spring.Container,
    uDelegateTo
  ;

procedure RegisterStuff(aContainer: TContainer);

implementation

procedure RegisterStuff(aContainer: TContainer);
begin
  aContainer.RegisterType<IWindowsUser, TWindowsUser>.DelegateTo(
        function: TWindowsUser
        begin
          Result := TWindowsUser.Create(GetLocalUserName);
        end
        );
  aContainer.Build;
end;

end.
