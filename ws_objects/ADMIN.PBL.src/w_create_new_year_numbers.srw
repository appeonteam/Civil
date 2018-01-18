$PBExportHeader$w_create_new_year_numbers.srw
forward
global type w_create_new_year_numbers from Window
end type
type em_year from editmask within w_create_new_year_numbers
end type
type st_3 from statictext within w_create_new_year_numbers
end type
type cb_cancel from commandbutton within w_create_new_year_numbers
end type
type cb_ok from commandbutton within w_create_new_year_numbers
end type
type gb_2 from groupbox within w_create_new_year_numbers
end type
type gb_1 from groupbox within w_create_new_year_numbers
end type
end forward

global type w_create_new_year_numbers from Window
int X=955
int Y=925
int Width=1843
int Height=621
boolean TitleBar=true
string Title="Create New Year Civil Numbers"
long BackColor=12632256
em_year em_year
st_3 st_3
cb_cancel cb_cancel
cb_ok cb_ok
gb_2 gb_2
gb_1 gb_1
end type
global w_create_new_year_numbers w_create_new_year_numbers

type variables
w_timer_bar w_timer
end variables

event open;SetPointer(HourGlass!)

w_main.enabled = False

em_year.SetFocus()

// Window Controls
cb_cancel.pointer="arrow!"
cb_ok.pointer="arrow!"
end event

on w_create_new_year_numbers.create
this.em_year=create em_year
this.st_3=create st_3
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.em_year,&
this.st_3,&
this.cb_cancel,&
this.cb_ok,&
this.gb_2,&
this.gb_1}
end on

on w_create_new_year_numbers.destroy
destroy(this.em_year)
destroy(this.st_3)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type em_year from editmask within w_create_new_year_numbers
int X=965
int Y=211
int Width=285
int Height=90
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_create_new_year_numbers
int X=110
int Y=224
int Width=845
int Height=74
boolean Enabled=false
string Text="Docket Year To Be Created:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_create_new_year_numbers
int X=1353
int Y=259
int Width=406
int Height=109
int TabOrder=30
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

type cb_ok from commandbutton within w_create_new_year_numbers
int X=1353
int Y=138
int Width=406
int Height=109
int TabOrder=10
string Text="OK"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// script variables
integer s_iYear, s_iLastYear, s_iCount, s_iMaxNum

SetPointer(HourGlass!)

If em_year.text = "" OR Len(em_year.text) < 4 Then
	MessageBox("Error", "Year must be four digits.")
	em_year.SetFocus()
	Return
End If

s_iYear = Integer(em_year.text)
s_iLastYear = s_iYear - 1

SELECT COUNT(*) INTO :s_iCount
	FROM ut_incremented_number
	WHERE ut_incremented_number.civil_year = :s_iYear;
If s_iCount > 0 Then
	MessageBox("Create New Year Docket Incremented Number Information", &
		"Incremented Numbers have already been created for this year -- CANNOT Process Twice!!",&
		StopSign!)
	em_year.SetFocus()
	Return
End If

INSERT INTO ut_incremented_number
		( civil_year, number_type, max_number, description )
	VALUES	
		(:s_iYear, 'CBDIS-MAX', 0, 'Last Docket Disbursement # Used');
If SQLCA.SQLCODE = -1 Then
	MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
	ROLLBACK;
   Return
End If	

INSERT INTO ut_incremented_number
		( civil_year, number_type, max_number, description )
	VALUES	
		(:s_iYear, 'CBREC-MAX', 0, 'Last Docket Receipt # Used');
If SQLCA.SQLCODE = -1 Then
	MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
	ROLLBACK;
   Return
End If	

INSERT INTO ut_incremented_number
		( civil_year, number_type, max_number, description )
	VALUES	
		(:s_iYear, 'DOCK-MAX', 0, 'Last Docket # Used');
If SQLCA.SQLCODE = -1 Then
	MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
	ROLLBACK;
   Return
End If	

COMMIT;
// error check
If SQLCA.SQLCode = -1 Then
	MessageBox("System Error","Civil Docket Incremented Number Insert Error - " + SQLCA.SQLErrText)
	ROLLBACK;
	Return
End If 

MessageBox("Create New Year Docket Numbers", &
	"New Docket Incremented Numbers have been created for " + String(s_iYear))
	
w_main.enabled = True
w_main.SetFocus()
Close(Parent)

end event

type gb_2 from groupbox within w_create_new_year_numbers
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

type gb_1 from groupbox within w_create_new_year_numbers
int X=73
int Y=109
int Width=1232
int Height=262
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

