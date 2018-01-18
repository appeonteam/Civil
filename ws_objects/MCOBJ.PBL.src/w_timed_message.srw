$PBExportHeader$w_timed_message.srw
forward
global type w_timed_message from Window
end type
type st_message from statictext within w_timed_message
end type
end forward

global type w_timed_message from Window
int X=1038
int Y=853
int Width=1564
int Height=521
boolean TitleBar=true
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
WindowType WindowType=popup!
st_message st_message
end type
global w_timed_message w_timed_message

event open;st_message.text = Message.StringParm
Timer(5)
end event

event timer;Timer(0)
Close(this)
end event

on w_timed_message.create
this.st_message=create st_message
this.Control[]={ this.st_message}
end on

on w_timed_message.destroy
destroy(this.st_message)
end on

type st_message from statictext within w_timed_message
int X=106
int Y=65
int Width=1308
int Height=305
boolean Enabled=false
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

