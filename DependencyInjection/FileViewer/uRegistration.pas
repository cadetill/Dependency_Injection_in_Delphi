unit uRegistration;

interface

procedure RegisterInterfaces;
procedure RegisterDisplayers;

implementation

uses
      Spring.Container
    , uFileDisplayerInterfaces
    , uFilenameGetter
    , uFileDisplayer
    , uFileNameExtensionGetter
    , uFileDisplayerRegistry
    , uTextFileDisplayer
    , uPictureDisplayer
    ;

procedure RegisterInterfaces;
begin
  GlobalContainer.RegisterType<IDisplayOnPanel, TFileDisplayer>;
  GlobalContainer.RegisterType<IFileExtensionGetter, TFileExtensionGetter>;
  GlobalContainer.RegisterType<IFilenameGetter, TFilenameGetter>;
  GlobalContainer.Build;
end;

procedure RegisterDisplayers;
var
  TextFileDisplayer: IDisplayFile;
  PictureFileDisplayer: IDisplayFile;
begin
  TextFileDisplayer := TTextFileDisplayer.Create;
  FileDisplayerRegistry.AddDisplayer('.txt', TextFileDisplayer);
  FileDisplayerRegistry.AddDisplayer('.pas', TextFileDisplayer);
  FileDisplayerRegistry.AddDisplayer('.dpr', TextFileDisplayer);
  FileDisplayerRegistry.AddDisplayer('.dproj', TextFileDisplayer);
  FileDisplayerRegistry.AddDisplayer('.xml', TextFileDisplayer);

  PictureFileDisplayer := TPictureDisplayer.Create;
  FileDisplayerRegistry.AddDisplayer('.jpg', PictureFileDisplayer);
  FileDisplayerRegistry.AddDisplayer('.bmp', PictureFileDisplayer);
  FileDisplayerRegistry.AddDisplayer('.png', PictureFileDisplayer);
  FileDisplayerRegistry.AddDisplayer('.gif', PictureFileDisplayer);
end;

end.
