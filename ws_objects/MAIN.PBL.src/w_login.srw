$PBExportHeader$w_login.srw
forward
global type w_login from window
end type
type p_1 from picture within w_login
end type
type sle_userid from singlelineedit within w_login
end type
type st_6 from statictext within w_login
end type
type st_5 from statictext within w_login
end type
type st_3 from statictext within w_login
end type
type cb_cancel from commandbutton within w_login
end type
type cb_ok from commandbutton within w_login
end type
type st_2 from statictext within w_login
end type
type st_1 from statictext within w_login
end type
type sle_pass from singlelineedit within w_login
end type
type ln_1 from line within w_login
end type
end forward

global type w_login from window
integer x = 1010
integer y = 780
integer width = 1728
integer height = 912
boolean titlebar = true
string title = "Cerro Gordo County Civil System Login"
long backcolor = 12632256
p_1 p_1
sle_userid sle_userid
st_6 st_6
st_5 st_5
st_3 st_3
cb_cancel cb_cancel
cb_ok cb_ok
st_2 st_2
st_1 st_1
sle_pass sle_pass
ln_1 ln_1
end type
global w_login w_login

type variables

end variables

event open;
st_3.text = "Version " + g_achVersion
sle_userid.SetFocus()
end event

on w_login.create
this.p_1=create p_1
this.sle_userid=create sle_userid
this.st_6=create st_6
this.st_5=create st_5
this.st_3=create st_3
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_2=create st_2
this.st_1=create st_1
this.sle_pass=create sle_pass
this.ln_1=create ln_1
this.Control[]={this.p_1,&
this.sle_userid,&
this.st_6,&
this.st_5,&
this.st_3,&
this.cb_cancel,&
this.cb_ok,&
this.st_2,&
this.st_1,&
this.sle_pass,&
this.ln_1}
end on

on w_login.destroy
destroy(this.p_1)
destroy(this.sle_userid)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_3)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_pass)
destroy(this.ln_1)
end on

type p_1 from picture within w_login
integer x = 91
integer y = 48
integer width = 320
integer height = 276
string picturename = "c:\pwrs\artgal\bmps\fldropn2.bmp"
boolean focusrectangle = false
end type

type sle_userid from singlelineedit within w_login
integer x = 562
integer y = 540
integer width = 466
integer height = 104
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "mimlay"
boolean autohscroll = false
textcase textcase = lower!
borderstyle borderstyle = stylelowered!
end type

on getfocus;parent.SetMicroHelp("Enter User ID.")

this.SelectText(1, Len(this.text))
end on

type st_6 from statictext within w_login
integer x = 434
integer y = 172
integer width = 1239
integer height = 124
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Civil System"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_login
integer x = 434
integer y = 48
integer width = 1239
integer height = 124
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cerro Gordo County"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_login
integer x = 27
integer y = 364
integer width = 1659
integer height = 84
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "text"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_login
event mousemove pbm_mousemove
integer x = 1088
integer y = 656
integer width = 357
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancel"
boolean cancel = true
end type

on clicked;Close(Parent)
end on

type cb_ok from commandbutton within w_login
event mousemove pbm_mousemove
integer x = 1088
integer y = 540
integer width = 357
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&OK"
boolean default = true
end type

on mousemove;//parent.SetMicroHelp("Accept ID and Password.")
end on

event clicked;string s_achUserID, s_achPassword
string s_achExtra

SetPointer(HourGlass!)

//s_achUserID = Trim(sle_userid.text)
s_achUserID = Trim(sle_userid.text)
s_achPassword = Trim(sle_pass.text)

s_achExtra = ""

If IsNull(sle_userid.text) Or sle_userid.text = "" Then
	MessageBox("Error","User ID Must Be Entered!",Stopsign!)
	sle_userid.SetFocus()
	Return
End If

If IsNull(sle_pass.text) Or sle_pass.text = "" Then
	MessageBox("Error","Password Must Be Entered!",Stopsign!)
	sle_pass.SetFocus()
	Return
End If

//SQLCA.DBMS       = ProfileString ("nsvas.ini", "NETWORK DATABASE", "dbms",       "")
//SQLCA.database   = ProfileString ("nsvas.ini", "NETWORK DATABASE", "database",   "")
//SQLCA.userid     = ProfileString ("nsvas.ini", "NETWORK DATABASE", "userid",     "")
//SQLCA.dbpass     = ProfileString ("nsvas.ini", "NETWORK DATABASE", "dbpass",     "")
//SQLCA.logid      = ProfileString ("nsvas.ini", "NETWORK DATABASE", "logid",      "")
//SQLCA.logpass    = ProfileString ("nsvas.ini", "NETWORK DATABASE", "LogPassWord", "")
//SQLCA.servername = ProfileString ("nsvas.ini", "NETWORK DATABASE", "servername", "")
//SQLCA.dbparm     = ProfileString ("nsvas.ini", "NETWORK DATABASE", "dbparm",     "")

// PUT username on SQL Enterprise Manager
//SQLCA.dbparm     = "Connectstring='DSN=civil.sql;UID=sa;PWD=" + s_achExtra + ";APP=County Civil;WSID=" + s_achuserid + ";DATABASE=civil'"
//SQLCA.DBMS="ODBC"
//CONNECT Using SQLCA;
// Profile 192.0.3.122
SQLCA.DBMS = "OLE DB"
SQLCA.LogId = "sa"
SQLCA.AutoCommit = False
SQLCA.DBParm = "PROVIDER='SQLOLEDB',DATASOURCE='192.0.1.35',PROVIDERSTRING='database=Civil'"
CONNECT Using SQLCA;

If SQLCA.SQLCODE = -1 Then
	If SQLCA.SQLDBCode = -103 Then
	   MessageBox("Error","Cannot Connect to Database - Invalid UserID or Password.")
	Else
	   MessageBox("Error","Cannot Connect to Database " + SQLCA.SQLERRTEXT)
	End If
	sle_userid.SetFocus()
	Return
End If

// make sure this is a valid user
SELECT ut_personnel.ssan, ut_personnel.user_id, ut_personnel.user_password
	INTO :g_achuserempnum, :g_achuserid, :s_achPassword
   FROM ut_personnel
   WHERE ut_personnel.user_id = :s_achUserID;

If Not SQLCA.SQLCode = 0 Then
	MessageBox("Invalid Login","The login name or password you are using is not valid.", &
		Exclamation!,OK!)
	sle_userid.SetFocus()		
	Disconnect;
	Return
End If
g_achUserID = Trim(g_achUserID)

If Not sle_pass.text = Trim(s_achPassword) Then
	Messagebox("Invalid Login","The login name or password you are using is not valid.", &
		Exclamation!,OK!)
	sle_userid.SetFocus()		
	Disconnect;
	Return
End If

If SQLCA.SQLCode = 0 Then
	Parent.enabled = False	
	Open(w_banner)
	Close(Parent)
End If	

open(w_appeon)
end event

type st_2 from statictext within w_login
integer x = 137
integer y = 672
integer width = 407
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Password:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_login
integer x = 215
integer y = 556
integer width = 329
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "User ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_pass from singlelineedit within w_login
integer x = 562
integer y = 656
integer width = 466
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "mimlay"
boolean autohscroll = false
boolean password = true
textcase textcase = lower!
borderstyle borderstyle = stylelowered!
end type

on getfocus;parent.SetMicroHelp("Enter Password.")

this.SelectText(1, Len(this.text))
end on

type ln_1 from line within w_login
long linecolor = 33554432
integer linethickness = 16
integer beginx = 5
integer beginy = 492
integer endx = 3003
integer endy = 492
end type

