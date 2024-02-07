unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, ClipBrd, IniFiles, Process, Types, Unit2;

type

  { TForm1 }

  TMyThread = class(TThread)
  protected
    procedure Execute; override;
  end;

  TForm1 = class(TForm)
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ListBox1: TListBox;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    SaveDialog1: TSaveDialog;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    Timer1: TTimer;
    ToggleBox1: TToggleBox;
    TrayIcon1: TTrayIcon;
    procedure Button2Click(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox6Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ToggleBox1Change(Sender: TObject);
    procedure ExecuteCommand(Command: String; ClipText: String);
    procedure TrayIcon1Click(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer; ARect: TRect; State: TOwnerDrawState);
    procedure TimerThreadConnection;
  private

  public

  end;

var
  Form1: TForm1;
  NewText: String = '';  //Save the Current ClipBoard Text to a Variable
  WorkingDir: String = '';  //Default Working Directory
  RunningTasks: Integer = 0;  //Amount of currently running Tasks
  Settings: TIniFile;  //Settings ini File

implementation

{$R *.lfm}

{ TForm1 }

procedure TMyThread.Execute;  //Override the Thread Execution with my call to the Command Execution
begin
   
   if Form1.CheckBox5.Checked then begin

     if MessageDlg('cmd.exe /c ' + Form1.Edit1.Text + NewText + Form1.Edit2.Text + LineEnding + 'Do you want to continue and execute this Command?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin  //Display Command in Debug Mode and ask for Confrmation

       Form1.ExecuteCommand(Form1.Edit1.Text + NewText + Form1.Edit2.Text, Unit1.NewText);  //Execute Command with the ClipBoard String and the Edit Fields

     end;

   end
   else begin

     Form1.ExecuteCommand(Form1.Edit1.Text + NewText + Form1.Edit2.Text, Unit1.NewText);  //Execute Command with the ClipBoard String and the Edit Fields

   end;

end;

procedure TForm1.TimerThreadConnection;  //Connect the Thred running with the Clipboard Detection in the Timer because the Timer should not create new threads in its Loop
var
  Thread: TMyThread;  //Define the Thread
begin

  Thread := TMyThread.Create(True);  //Create with auto free

  Thread.Start;  //Execute

  Thread.FreeOnTerminate := True;  //Free after Termination

end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer; ARect: TRect; State: TOwnerDrawState);  //Function to custom color the ListBox output based on Success
begin

  ListBox1.Canvas.FillRect(ARect);  //Fill the Rect Structure

  if Length(ListBox1.Items[Index]) > 0 then begin

  if ListBox1.Items[Index][1] = #10 then begin  //Detect the 'O' for SUCCESS

    ListBox1.Canvas.Brush.Color := $0000CE00;  //Make it Green for OK
    ListBox1.Canvas.TextOut(ARect.Left, ARect.Top, RightStr(ListBox1.Items[Index], Length(ListBox1.Items[Index]) - 1));  //Draw Everything and fix the displayed String

  end
  else if ListBox1.Items[Index][1] = #13 then begin

    ListBox1.Canvas.Brush.Color := clred;  //Make it Rd for FAIL otherwise
    ListBox1.Canvas.TextOut(ARect.Left, ARect.Top, RightStr(ListBox1.Items[Index], Length(ListBox1.Items[Index]) - 1));  //Draw Everything and fix the displayed String

  end
  else begin  //Ignore otherwise (for Debug and List import)

    ListBox1.Canvas.TextOut(ARect.Left, ARect.Top, ListBox1.Items[Index]);  //Draw Everything and fix the displayed String

  end;

  end;

end;

procedure TForm1.ExecuteCommand(Command: String; ClipText: String);  //Custom Command execution procedure through cmd
begin

  with TProcess.Create(nil) do begin  //Create a new Process to run Cmd

    Inc(RunningTasks);  //Increase Amount of running Tasks
    CurrentDirectory := WorkingDir;  //Set current Directory

    Executable := 'cmd.exe';  //Set cmd.exe as executable
    Parameters.Add('/c');  //the "/c" Parameter allows us to append a new command
    Parameters.Add(Command);  //Add the real command to be executed as parameter

    if NOT CheckBox2.Checked then begin  //Check for Pipe Setting

      if NOT CheckBox1.Checked then begin  //Chek for CLI Setting

        Options := [poWaitOnExit, poNoConsole];  //Do set the options to get the result and wait for it and also hide the console

      end
      else begin

        Options := [poWaitOnExit];  //Do set the options to get the result and wait for it and also hide the console

      end;

    end
    else begin

      if NOT CheckBox1.Checked then begin  //Chek for CLI Setting

        Options := [poUsePipes, poWaitOnExit, poNoConsole];  //Do set the options to get the result and wait for it and also hide the console

      end
      else begin

        Options := [poUsePipes, poWaitOnExit];  //Do set the options to get the result and wait for it and also hide the console

      end;

    end;

    Execute;  //Execute the Process 

    if ExitStatus = 0 then begin  //Check for Exit Status

       ListBox1.Items.Add(#10 + ClipText);  //Add an 'O' for SUCCESS (will be removed later)

    end
    else begin

       ListBox1.Items.Add(#13 + ClipText);  //Add an 'X' for FAIL (will be removed later)

    end;

    Free;  //Free the Process
    Dec(RunningTasks);  //Decrease Amount of running Tasks

   end;

end;

procedure TForm1.TrayIcon1Click(Sender: TObject);  //Click on TrayIcon
begin

  Form1.Visible := NOT(Form1.Visible);  //Switch Form Visibility

end;

procedure TForm1.Button2Click(Sender: TObject);  //Choose a new default Working Directory
begin

  if SelectDirectoryDialog1.Execute then begin  //Check for Execution

    WorkingDir := SelectDirectoryDialog1.FileName;  //Set Working Directory
    Form1.Caption := 'ClipeXec - ' + WorkingDir;  //Set Working Directory Name to Title

  end;

end;

procedure TForm1.CheckBox3Change(Sender: TObject);  //Topmost Setting
begin

  if CheckBox3.Checked then begin  //Check for Setting

    Form1.FormStyle := fsSystemStayOnTop;  //Enable Topmost Status

  end
  else begin

    Form1.FormStyle := fsNormal;  //Disable Topmost Status

  end;

end;

procedure TForm1.CheckBox6Change(Sender: TObject);  //Auto Save/Load Settings Checkbox Change
begin

  if NOT CheckBox6.Checked then begin  //Check for disabled Saving Settings

    if FileExists(ExtractFilePath(Application.ExeName) + 'ClipeXec.ini') then begin  //Check if Settings where allready created

      if MessageDlg('Unsetting this Option will delete the Settings File.' + LineEnding + 'Do you want to continue?', mtWarning, [mbYes, mbNo], 0) = mrYes then begin  //Ask if user wnats to delete current settings

        DeleteFile(ExtractFilePath(Application.ExeName) + 'ClipeXec.ini');  //Delete the Settings File

      end
      else begin

        CheckBox6.Checked := True;  //Check Checkbox again

      end;

    end;

  end;

end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);  //Events before Closure
begin

  if RunningTasks = 1 then begin  //Check for running Tasks

    if MessageDlg('There is still ' + IntToStr(RunningTasks) + ' Task running in the background.' + LineEnding + 'Do you really want to close the Application?', mtWarning, [mbYes, mbNo], 0) = mrYes then begin
      
      TrayIcon1.Visible := False;  //Hide TrayIcon early to prevent it from not diasppearing
      CanClose := True;  //Allow Closing

    end
    else begin

      CanClose := False;  //Prevent Closing

    end;

  end
  else if RunningTasks > 1 then begin  //Check for running Tasks

    if MessageDlg('There are still ' + IntToStr(RunningTasks) + ' Tasks running in the background.' + LineEnding + 'Do you really want to close the Application?', mtWarning, [mbYes, mbNo], 0) = mrYes then begin
      
      TrayIcon1.Visible := False;  //Hide TrayIcon early to prevent it from not diasppearing
      CanClose := True;  //Allow Closing

    end
    else begin

      CanClose := False;  //Prevent Closing

    end;

  end
  else begin
    
    TrayIcon1.Visible := False;  //Hide TrayIcon early to prevent it from not diasppearing
    CanCLose := True; //Allow Closing

  end;

  if (CheckBox6.Checked = True) AND (CanClose = True) then begin

    Settings := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ClipeXec.ini');  //Create Settings File

    try

      Settings.WriteString('Settings', 'Show CLI', BoolToStr(CheckBox1.Checked));
      Settings.WriteString('Settings', 'Use Pipes', BoolToStr(CheckBox2.Checked));
      Settings.WriteString('Settings', 'Topmost', BoolToStr(CheckBox3.Checked));
      Settings.WriteString('Settings', 'Auto Clear Clipboard', BoolToStr(CheckBox4.Checked));
      Settings.WriteString('Settings', 'Command Confirmation', BoolToStr(CheckBox5.Checked));
      Settings.WriteString('Settings', 'Auto Save/Load Settings', BoolToStr(CheckBox6.Checked));
      Settings.WriteString('Settings', 'Prefix CMD', '"' + Edit1.Text + '"');
      Settings.WriteString('Settings', 'Suffix CMD', '"' + Edit2.Text + '"');
      Settings.WriteString('Settings', 'Working Directory', '"' + WorkingDir + '"');

    finally

      Settings.Free;  //Free Settings File

    end;

  end;

  

end;

procedure TForm1.FormCreate(Sender: TObject);  //Startup Events
begin

  ClipBoard.AsText := '';  //Reset the Clipboard Contents to prevent accidental Execution
  WorkingDir := ExtractFilePath(Application.ExeName);  //Set Application Folder as current Directory
  TrayIcon1.Show;  //Show Tray Icon

  if FileExists(ExtractFilePath(Application.ExeName) + 'ClipeXec.ini') then begin  //Check if Settings File is Present

    Settings := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ClipeXec.ini');

    try

      CheckBox1.Checked := StrToBool(Settings.ReadString('Settings', 'Show CLI', '0'));
      CheckBox2.Checked := StrToBool(Settings.ReadString('Settings', 'Use Pipes', '-1'));
      CheckBox3.Checked := StrToBool(Settings.ReadString('Settings', 'Topmost', '0'));
      CheckBox4.Checked := StrToBool(Settings.ReadString('Settings', 'Auto Clear Clipboard', '0'));
      CheckBox5.Checked := StrToBool(Settings.ReadString('Settings', 'Command Confirmation', '0'));
      CheckBox6.Checked := StrToBool(Settings.ReadString('Settings', 'Auto Save/Load Settings', '-1'));
      Edit1.Text := Settings.ReadString('Settings', 'Prefix CMD', '');
      Edit2.Text := Settings.ReadString('Settings', 'Suffix CMD', '');
      WorkingDir := Settings.ReadString('Settings', 'Working Directory', ExtractFilePath(Application.ExeName));

    finally

      Settings.Free //Free Settings File

    end;

  end;

  Form1.Caption := 'ClipeXec - ' + WorkingDir;  //Set Working Directory Name to Title

end;

procedure TForm1.Image1Click(Sender: TObject);  //Logo Click
var
  PopupForm: TForm2;  //Set new Form as About Form
begin

  PopupForm := TForm2.Create(nil);  //Create the Form

  try

    PopupForm.ShowModal; // Show Form2 as a modal dialog

  finally

    PopupForm.Free;  //Free the Form

  end;

end;

procedure TForm1.Image2Click(Sender: TObject);  //Import Listbox
begin

  if OpenDialog1.Execute then begin  //Check for Execution

    ListBox1.Items.LoadFromFile(OpenDialog1.FileName);  //Load Listbox Content from File
    Label3.Caption := IntToStr(ListBox1.Items.Count);  //Show Number of ListBox Items

  end;

end;

procedure TForm1.Image3Click(Sender: TObject);  //Delete Single ListBox Item
begin

  if ListBox1.ItemIndex >= 0 then begin  //Check for Item Index

    ListBox1.Items.Delete(ListBox1.ItemIndex);  //Delete Selected Item
    Label3.Caption := IntToStr(ListBox1.Items.Count);  //Show Number of ListBox Items

  end;

end;

procedure TForm1.Image4Click(Sender: TObject);  //Export ListBox Contents
var
  TempBox: TListBox = nil;  //Temporary ListBox for Saving
  i: Integer = 0;  //Temporary Loop Variable
begin

  if SaveDialog1.Execute then begin //Check for Execution

    TempBox := TListBox.Create(Nil);  //Create

    for i := 0 to ListBox1.Items.Count - 1 do begin  //Iterate through Listbox

      if (Length(ListBox1.Items[i]) > 0) AND ( (ListBox1.Items[i][1] = #10) OR (ListBox1.Items[i][1] = #13) ) then begin  //Check  if Item is not empty and has a Status Character

        TempBox.Items.Add(RightStr(ListBox1.Items[i], Length(ListBox1.Items[i]) - 1)); //Save while cutting the first Placeholder Character (used for Process Status)

      end
      else begin

        TempBox.Items.Add(ListBox1.Items[i]); //Just copy from ListBox1

      end;

    end;

    TempBox.Items.SaveToFile(SaveDialog1.FileName);  //Save ListBox Contents

    TempBox.Free;  //Free ListBox

  end;

end;

procedure TForm1.Image5Click(Sender: TObject);  //Clear ListBox Items
begin

  ListBox1.Clear;  //Clear the ListBox
  Label3.Caption := IntToStr(ListBox1.Items.Count);  //Show Number of ListBox Items

end;

procedure TForm1.ListBox1DblClick(Sender: TObject);  //Copy selected Text to ClipBoard
begin

  if ListBox1.ItemIndex >= 0 then begin  //Check for empty ListBox

    ClipBoard.AsText := RightStr(ListBox1.GetSelectedText, Length(ListBox1.GetSelectedText) -1 );  //Set ClipBoard Contents

  end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

  Label3.Caption := IntToStr(ListBox1.Items.Count);  //Show Number of ListBox Items
  Label2.Caption := 'Currently Running Tasks: ' + IntToStr(RunningTasks);  //Display Number of currently running Tasks

  if Clipboard.HasFormat(CF_TEXT) then begin  //Check if ClipBoard Contents are Text

    if NOT (Clipboard.AsText = NewText) AND NOT (Clipboard.AsText = '') then begin  //Check for old or empty String

      NewText := ClipBoard.AsText;  //Set New Text

      if CheckBox4.Checked then ClipBoard.AsText := '';  //Clear Clipboard if Checkbox is Checked

      TimerThreadConnection;  //Connect to Thread Execution

    end;

  end;

end;

procedure TForm1.ToggleBox1Change(Sender: TObject);  //ToggleBox Click
begin

  ClipBoard.AsText := '';  //Reset the Clipboard Contents to prevent accidental Execution
  Timer1.Enabled := ToggleBox1.Checked;  //Start or Stop Timer

  if ToggleBox1.Checked then begin

    ToggleBox1.Caption := 'Stop';

  end
  else begin

    ToggleBox1.Caption := 'Start';
    NewText := '';  //Reset Text Variable

  end;



end;

end.

