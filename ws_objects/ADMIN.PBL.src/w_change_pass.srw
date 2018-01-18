$PBExportHeader$w_change_pass.srw
forward
global type w_change_pass from Window
end type
type st_3 from statictext within w_change_pass
end type
type sle_verify from singlelineedit within w_change_pass
end type
type sle_old from singlelineedit within w_change_pass
end type
type st_2 from statictext within w_change_pass
end type
type st_1 from statictext within w_change_pass
end type
type cb_cancel from commandbutton within w_change_pass
end type
type cb_ok from commandbutton within w_change_pass
end type
type sle_new from singlelineedit within w_change_pass
end type
type gb_2 from groupbox within w_change_pass
end type
type gb_1 from groupbox within w_change_pass
end type
end forward

global type w_change_pass from Window
int X=955
int Y=883
int Width=1843
int Height=701
boolean TitleBar=true
string Title="Change Password"
long BackColor=12632256
st_3 st_3
sle_verify sle_verify
sle_old sle_old
st_2 st_2
st_1 st_1
cb_cancel cb_cancel
cb_ok cb_ok
sle_new sle_new
gb_2 gb_2
gb_1 gb_1
end type
global w_change_pass w_change_pass

type variables
w_timer_bar w_timer
end variables

event open;SetPointer(HourGlass!)

w_main.enabled = False

gb_1.text = SQLCA.LogID
sle_old.SetFocus()

// Window Controls
cb_cancel.pointer="arrow!"
cb_ok.pointer="arrow!"

end event

on w_change_pass.create
this.st_3=create st_3
this.sle_verify=create sle_verify
this.sle_old=create sle_old
this.st_2=create st_2
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.sle_new=create sle_new
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.st_3,&
this.sle_verify,&
this.sle_old,&
this.st_2,&
this.st_1,&
this.cb_cancel,&
this.cb_ok,&
this.sle_new,&
this.gb_2,&
this.gb_1}
end on

on w_change_pass.destroy
destroy(this.st_3)
destroy(this.sle_verify)
destroy(this.sle_old)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.sle_new)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type st_3 from statictext within w_change_pass
int X=106
int Y=128
int Width=249
int Height=74
boolean Enabled=false
string Text="Old:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_verify from singlelineedit within w_change_pass
int X=369
int Y=342
int Width=640
int Height=90
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on getfocus;parent.SetMicroHelp("Retype New Password.")

If sle_old.text <> "" And sle_new.text <> "" Then
   cb_ok.enabled = True
End If
end on

on modified;If Len(sle_verify.text) = 0 Then
//	sle_new.enabled = False
//	sle_verify.enabled = True
	MessageBox("Verification", "Retype the password for verification.")
	sle_verify.SetFocus()
End If
end on

type sle_old from singlelineedit within w_change_pass
int X=369
int Y=118
int Width=640
int Height=90
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;// script variables
integer	s_iStart, s_iEnd
string	s_achOldPass

SELECT user_password INTO :s_achOldPass
	FROM ut_personnel
	WHERE ut_personnel.user_id = :g_achUserID;
If SQLCA.SQLCode = -1 Then
	MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
	ROLLBACK;
	Return
End If

s_achOldPass = Trim(s_achOldPass)

If sle_old.text <> s_achOldPass Then
   Messagebox("Error","Incorrect Password!")
   sle_old.text = ""
   SetFocus(sle_old)
//   Return
End If
end event

on getfocus;parent.SetMicroHelp("Enter Current Password.")

cb_ok.enabled = False
end on

type st_2 from statictext within w_change_pass
int X=106
int Y=349
int Width=249
int Height=74
boolean Enabled=false
string Text="Verify:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_change_pass
int X=102
int Y=240
int Width=249
int Height=74
boolean Enabled=false
string Text="New:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_change_pass
int X=1353
int Y=192
int Width=406
int Height=109
int TabOrder=50
string Text="&Cancel"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;SetPointer(HourGlass!)

w_main.enabled = True
w_main.SetFocus()
Close(Parent)
end on

type cb_ok from commandbutton within w_change_pass
int X=1353
int Y=70
int Width=406
int Height=109
int TabOrder=40
string Text="OK"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// script variables
integer	s_iStart, s_iEnd
string	s_achSQL, s_achOldPass, s_achUserID, s_achNewPassword

SetPointer(HourGlass!)

//If (sle_new.text = "" OR Len(sle_new.text) < 6) And sle_old.text <> "" Then
//	MessageBox("Error", "Password must be at least six characters.")
//	sle_new.SetFocus()
//	Return
// Else
//	If Len(sle_verify.text) = 0 Then
//		sle_new.enabled = False
//		sle_verify.enabled = True
//		MessageBox("Verification", "Retype the password for verification.")
//		sle_verify.SetFocus()
//	Else


   If sle_old.text <> "" And sle_new.text <> "" And sle_verify.text <> "" Then

		If sle_verify.text <> sle_new.text Then
			MessageBox("Error", "Passwords do not match!")
			sle_new.text = ""
			sle_verify.text = ""
//			sle_verify.enabled = False
			sle_new.SetFocus()
		Else
			s_achNewPassword = Trim(sle_new.text)
			UPDATE ut_personnel
					SET user_password = :s_achNewPassword
				WHERE ut_personnel.user_id = :g_achUserID;
			If SQLCA.SQLCode = -1 Then
				MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
				ROLLBACK;
				Return
			End If
			COMMIT;
			MessageBox("Password Changed", "Password has been successfully changed.")
			cb_cancel.PostEvent(Clicked!)
		End If
	End If


//End If
		
end event

type sle_new from singlelineedit within w_change_pass
int X=369
int Y=230
int Width=640
int Height=90
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on getfocus;parent.SetMicroHelp("Enter New Password.")

cb_ok.enabled = False

//If (sle_new.text <> "" OR Len(sle_new.text) >= 6) And sle_old.text <> "" Then
//   sle_verify.enabled = TRUE
//End If
end on

on modified;If (sle_new.text = "" OR Len(sle_new.text) < 6) And sle_old.text <> "" Then
	MessageBox("Error", "Password must be at least six characters.")
   sle_new.text = ""
	sle_new.SetFocus()
//	Return
//Else 
//   sle_verify.enabled = TRUE
End If
end on

type gb_2 from groupbox within w_change_pass
int X=51
int Y=554
int Width=1123
int Height=490
boolean Visible=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_change_pass
int X=73
int Y=32
int Width=1123
int Height=448
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

