unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, sqldb, db, FileUtil;

type

  { TData }

  TData = class(TDataModule)
    IDSuzytkownicy: TDataSource;
    IBConnection1: TIBConnection;
    IBQuzytkownicy: TSQLQuery;
    IBTuzytkownicy: TSQLTransaction;
    //procedure IBConnection1AfterConnect(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Data: TData;

implementation

{$R *.lfm}

{ TData }



end.

