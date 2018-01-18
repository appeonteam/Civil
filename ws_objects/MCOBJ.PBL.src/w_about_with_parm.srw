$PBExportHeader$w_about_with_parm.srw
$PBExportComments$A Generic About window that is opened using the OpenSheetWithParm feature. This window then takes a string passed to it and formats it for the about window.
forward
global type w_about_with_parm from Window
end type
type cb_ok from commandbutton within w_about_with_parm
end type
type st_1 from statictext within w_about_with_parm
end type
type st_app_title from statictext within w_about_with_parm
end type
type p_logo from picture within w_about_with_parm
end type
type mle_about from multilineedit within w_about_with_parm
end type
end forward

global type w_about_with_parm from Window
int X=665
int Y=269
int Width=1572
int Height=817
boolean TitleBar=true
string Title="About:"
long BackColor=12632256
WindowType WindowType=response!
cb_ok cb_ok
st_1 st_1
st_app_title st_app_title
p_logo p_logo
mle_about mle_about
end type
global w_about_with_parm w_about_with_parm

type prototypes

end prototypes

event close;//w_terminal.enabled = True
//w_terminal.SetFocus()
end event

event open;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
SetPointer(HourGlass!)

//w_terminal.enabled = False

string 	ls_message, ls_windowtitle, ls_Version
int 		li_position, li_position2

// center the window regardless of resolution
//this.x = (PixelsToUnits(genv_settings.ScreenWidth, XPixelsToUnits!)/2) - (this.width/2)
//this.y = (PixelsToUnits(genv_settings.ScreenHeight, YPixelsToUnits!)/2) - (this.height/2)

//************************************************************************
//		find the postion of the @ signs
//************************************************************************
li_position = pos(message.stringparm, "@")
li_position2 = Pos(Mid(message.stringparm, li_position + 1), "@") + li_position

//************************************************************************
//		If There is an @ sign (lPosition > 0) then take the title and 
//		message out of the Message object StringParm
//		If there is no @ sign Assume that there is no title and use the 
//		String as the message
//************************************************************************

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


//************************************************************************
//		Set up the window
//************************************************************************

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


end event

on w_about_with_parm.create
this.cb_ok=create cb_ok
this.st_1=create st_1
this.st_app_title=create st_app_title
this.p_logo=create p_logo
this.mle_about=create mle_about
this.Control[]={ this.cb_ok,&
this.st_1,&
this.st_app_title,&
this.p_logo,&
this.mle_about}
end on

on w_about_with_parm.destroy
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.st_app_title)
destroy(this.p_logo)
destroy(this.mle_about)
end on

type cb_ok from commandbutton within w_about_with_parm
int X=1177
int Y=17
int Width=331
int Height=100
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close(parent)
end on

type st_1 from statictext within w_about_with_parm
int X=274
int Y=132
int Width=889
int Height=77
boolean Enabled=false
string Text="PowerBuilder Examples "
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type st_app_title from statictext within w_about_with_parm
int X=274
int Y=36
int Width=886
int Height=77
boolean Enabled=false
string Text="App Title Here"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type p_logo from picture within w_about_with_parm
int X=33
int Y=20
int Width=225
int Height=189
string PictureName="logo_col.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

event rbuttondown;//If KeyDown(KeyShift!) AND KeyDown(KeyAlt!) Then
//	If KeyDown(Keys!) OR KeyDown(KeyS!) Then
//		Open(w_secret_defaults)
//		
//	ElseIf KeyDown(Keym!) OR KeyDown(KeyM!) Then
//		Open(w_modem)
//	End If
//End If
end event

type mle_about from multilineedit within w_about_with_parm
int X=43
int Y=241
int Width=1465
int Height=449
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean AutoVScroll=true
boolean DisplayOnly=true
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

