unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, iniFiles, unit2, unit3;

type


  { Tlogowanie }

  Tlogowanie = class(TForm)
    btnlogin: TButton;
    btnkoniec: TButton;
    DBGrid1: TDBGrid;
    pamietajlogin: TCheckBox;
    login: TEdit;
    haslo: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    wersja: TLabel;

    procedure btnkoniecClick(Sender: TObject);
    procedure btnloginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure hasloChange(Sender: TObject);
 //   procedure FormShow(Sender: TObject);
   // procedure hasloChange(Sender: TObject);
    procedure hasloKeyPress(Sender: TObject; var Key: char);
    procedure loginChange(Sender: TObject);
  //  procedure loginChange(Sender: TObject);
    procedure loginKeyPress(Sender: TObject; var Key: char);
    procedure pamietajloginClick(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  logowanie: Tlogowanie;
  INI:TiniFile;
  pamiec:Boolean;
  pamiec_login: string;


implementation

{$R *.lfm}

{ Tlogowanie }
procedure Tlogowanie.pamietajloginClick(Sender: TObject);
begin
  INI:=tinifile.create(extractFilePath(application.exeName)+'serwis.ini');
  try
    INI.WriteBool('utawienia', 'pamiec',pamietajlogin.checked);
  finally
     INI.free;
  end;
  pamiec:=pamietajlogin.checked;
end;

procedure Tlogowanie.FormCreate(Sender: TObject);
begin
 INI:=tinifile.create(extractFilePath(application.exeName)+'serwis.ini');
  try
    pamiec:=INI.ReadBool('utawienia', 'pamiec',False);
    pamiec_login:=INI.ReadString('utawienia', 'login','');
  finally
     INI.free;
  end;
  pamietajlogin.checked:=pamiec;
end;



procedure Tlogowanie.FormShow(Sender: TObject);
begin
  btnlogin.Enabled:=False;
  if pamiec then
  begin
   haslo.SetFocus;
   login.text:=pamiec_login;
  end
  else
  begin
    login.SetFocus;
  end;
end;

procedure Tlogowanie.loginChange(Sender: TObject);
begin
  if (login.text='') or (haslo.text='') then
  btnlogin.Enabled:=False
  else
  btnlogin.Enabled:=True;
end;

procedure Tlogowanie.hasloChange(Sender: TObject);
begin
   if (login.text='') or (haslo.text='') then
  btnlogin.Enabled:=False
  else
  btnlogin.Enabled:=True;
end;

 procedure Tlogowanie.loginKeyPress(Sender: TObject; var Key: char);
begin
  if key=#13
  then
  haslo.SetFocus;
  //key:=#0;
end;

procedure Tlogowanie.hasloKeyPress(Sender: TObject; var Key: char);
begin
 if key=#13
  then
  btnlogin.Click;
  //key:=#0;
end;








procedure Tlogowanie.btnkoniecClick(Sender: TObject);
begin
  if MessageDlg('Czy na pewno wyjsc z programu?', mtConfirmation, mbYesNo, 0)=mrYes
  then
  begin
    application.Terminate;
  end;
end;

procedure Tlogowanie.btnloginClick(Sender: TObject);
begin


  with Data.IBQuzytkownicy, SQL do
 begin
   Close;
   Clear;
   Add('select id, login, haslo, imie, nazwisko, stanowisko, aktywny, usun, opis from uzytkownicy');
   Add ('where login=:login and haslo=:haslo and aktywny=:aktywny and usun=:usun');
   ParamByName('login').AsString:=login.Text;
   ParamByName('haslo').AsString:=haslo.Text;
   ParamByName('aktywny').AsInteger:=1;
   ParamByName('usun').AsInteger:=0;
   Open;
    end;
  if data.IBQuzytkownicy.FieldByName('login').AsString=login.Text then
  begin


    if pamiec then
                  begin
               INI:=tinifile.create(extractFilePath(application.exeName)+'serwis.ini');
                try
                INI.WriteString('utawienia', 'login',login.Text);
                finally
                INI.free;
                end;        //prawda
    end;
 main.Show;
 logowanie.Hide;
    end
  else
  begin

    if pamiec then
       begin
         haslo.Text:='';
         haslo.SetFocus;//
       end
       else
       begin
         login.Text:='';
         haslo.Text:='';
         login.SetFocus;

         //
       end;

    //falsz
    end;
  end;



end.

