$PBExportHeader$w_new_about.srw
forward
global type w_new_about from Window
end type
type p_1 from picture within w_new_about
end type
type st_appname2 from statictext within w_new_about
end type
type mle_about from multilineedit within w_new_about
end type
type cb_ok from commandbutton within w_new_about
end type
type st_version from statictext within w_new_about
end type
type st_appname from statictext within w_new_about
end type
end forward

global type w_new_about from Window
int X=1075
int Y=800
int Width=1605
int Height=858
boolean TitleBar=true
string Title="About"
long BackColor=12632256
WindowType WindowType=response!
p_1 p_1
st_appname2 st_appname2
mle_about mle_about
cb_ok cb_ok
st_version st_version
st_appname st_appname
end type
global w_new_about w_new_about

type prototypes

end prototypes

event close;//w_terminal.enabled = True
//w_terminal.SetFocus()
end event

event open;SetPointer(HourGlass!)

//st_appname.text = g_achAppName
st_version.text = "Version " + g_achVersion

w_main.enabled = False



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Purpose:
//	This window expects to receive a string parameter that will contain
//	an @ sign to use as a delimiter to provide a window title and a message
//	to place in the window MLE control.
//
//	This script uses the 
//		Message Object String Parm to pass the title and contents of the 
//			About Window
//		POS function to find the Position of the @ sign 
//		MID Funciton to disect the string into 
//			THe window title = everything infront of the @ sign
//			The about Message = Everything after the @ sign
//
// Log:
//
//   DATE       WHO      WHAT
//   ----       ---      -------------------------------
//   4/14/94    CRM      Initial Version
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
SetPointer(HourGlass!)

//w_terminal.enabled = False

string 	ls_message, ls_windowtitle, ls_Version
int 		li_position, li_position2
*/

// center the window regardless of resolution
//this.x = (PixelsToUnits(genv_settings.ScreenWidth, XPixelsToUnits!)/2) - (this.width/2)
//this.y = (PixelsToUnits(genv_settings.ScreenHeight, YPixelsToUnits!)/2) - (this.height/2)

//************************************************************************
//		find the postion of the @ signs
//************************************************************************
/*
li_position = pos(message.stringparm, "@")
li_position2 = Pos(Mid(message.stringparm, li_position + 1), "@") + li_position
*/

//************************************************************************
//		If There is an @ sign (lPosition > 0) then take the title and 
//		message out of the Message object StringParm
//		If there is no @ sign Assume that there is no title and use the 
//		String as the message
//************************************************************************
/*
If li_position > 0 then 
	ls_windowtitle = mid(Message.StringParm, 1, li_position - 1)
	If li_position < li_position2 Then 
		ls_version = Mid(message.StringParm, li_Position + 1, li_position2 - li_position - 1)
		ls_message = mid (Message.StringParm, li_position2 + 1, Len(Message.StringParm))
	Else
		ls_message = mid (Message.StringParm, li_position + 1, Len(Message.StringParm))
	End If
else
	ls_windowtitle = Message.StringParm
	ls_message = ""
End if
*/

//************************************************************************
//		Set up the window
//************************************************************************
/*
//Move Title to appropriate spots
this.title = "About: " + ls_windowtitle
st_app_title.text = ls_windowtitle
st_1.text = "Version " + ls_version

//Display message if any 
//If no message is available, remove comment box
if ls_message = "" then
	mle_about.visible = false
else
	mle_about.text = ls_message
End if
*/
end event

on w_new_about.create
this.p_1=create p_1
this.st_appname2=create st_appname2
this.mle_about=create mle_about
this.cb_ok=create cb_ok
this.st_version=create st_version
this.st_appname=create st_appname
this.Control[]={this.p_1,&
this.st_appname2,&
this.mle_about,&
this.cb_ok,&
this.st_version,&
this.st_appname}
end on

on w_new_about.destroy
destroy(this.p_1)
destroy(this.st_appname2)
destroy(this.mle_about)
destroy(this.cb_ok)
destroy(this.st_version)
destroy(this.st_appname)
end on

type p_1 from picture within w_new_about
int X=59
int Y=29
int Width=227
int Height=198
string PictureName="c:\pwrs\artgal\bmps\fldropn2.bmp"
boolean FocusRectangle=false
end type

type st_appname2 from statictext within w_new_about
int X=304
int Y=122
int Width=1006
int Height=77
boolean Enabled=false
string Text="Civil System"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_about from multilineedit within w_new_about
int X=55
int Y=310
int Width=1467
int Height=406
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean AutoVScroll=true
boolean DisplayOnly=true
string Text="This product was developed by:                   MIS Department, Cerro Gordo County"
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ok from commandbutton within w_new_about
int X=1331
int Y=45
int Width=194
int Height=93
int TabOrder=10
string Text="OK"
boolean Default=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer(HourGlass!)

w_main.enabled = True
w_main.SetFocus()
close(parent)
end event

type st_version from statictext within w_new_about
int X=304
int Y=224
int Width=1006
int Height=77
boolean Enabled=false
string Text="version"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_appname from statictext within w_new_about
int X=304
int Y=45
int Width=1006
int Height=77
boolean Enabled=false
string Text="Cerro Gordo County"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

