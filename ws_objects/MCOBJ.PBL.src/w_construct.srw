$PBExportHeader$w_construct.srw
forward
global type w_construct from Window
end type
type st_1 from statictext within w_construct
end type
type cb_1 from commandbutton within w_construct
end type
type p_1 from picture within w_construct
end type
end forward

global type w_construct from Window
int X=505
int Y=349
int Width=1924
int Height=490
boolean TitleBar=true
string Title="ALIAS LAW ENFORCEMENT - Under Development"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
st_1 st_1
cb_1 cb_1
p_1 p_1
end type
global w_construct w_construct

event open;If Message.StringParm <> "" Then
	st_1.Text = "The '" + message.StringParm + "' section is currently under development."
Else
	st_1.Text = "This section is currently under development."
End If

SetPointer(HourGlass!)

//this.x = (PixelsToUnits(genv_settings.ScreenWidth, XPixelsToUnits!)/2) - (this.width/2)
//this.y = (PixelsToUnits(genv_settings.ScreenHeight, YPixelsToUnits!)/2) - (this.height/2)
//
//w_terminal.enabled = False
cb_1.SetFocus()
end event

on w_construct.create
this.st_1=create st_1
this.cb_1=create cb_1
this.p_1=create p_1
this.Control[]={this.st_1,&
this.cb_1,&
this.p_1}
end on

on w_construct.destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.p_1)
end on

type st_1 from statictext within w_construct
int X=33
int Y=26
int Width=1126
int Height=362
boolean Enabled=false
string Text="This section is currently under development."
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_construct
int X=1236
int Y=278
int Width=651
int Height=93
int TabOrder=1
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// script variables
window	lw_active

SetPointer(HourGlass!)

//w_terminal.enabled = True
//lw_active = w_terminal.GetActiveSheet()
//If IsValid(lw_active) Then
//	lw_active.SetFocus()
//Else
//	w_terminal.SetFocus()
//End If

Close(Parent)

end event

type p_1 from picture within w_construct
int X=1229
int Y=29
int Width=658
int Height=202
boolean FocusRectangle=false
boolean OriginalSize=true
end type

