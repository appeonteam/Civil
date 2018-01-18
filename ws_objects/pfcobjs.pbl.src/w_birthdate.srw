$PBExportHeader$w_birthdate.srw
forward
global type w_birthdate from Window
end type
type dw_1 from datawindow within w_birthdate
end type
type cb_1 from commandbutton within w_birthdate
end type
type uo_1 from u_progressbar within w_birthdate
end type
end forward

global type w_birthdate from Window
int X=1057
int Y=483
int Width=1130
int Height=986
boolean TitleBar=true
string Title="Birthdate Teller"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_1 dw_1
cb_1 cb_1
uo_1 uo_1
end type
global w_birthdate w_birthdate

type variables
n_cst_resize inv_resize

u_calendar iuo_calendar
u_calculator iuo_calculator
n_cst_dwsrv_resize inv_dwresize
end variables

on w_birthdate.create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.uo_1=create uo_1
this.Control[]={this.dw_1,&
this.cb_1,&
this.uo_1}
end on

on w_birthdate.destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.uo_1)
end on

event open;inv_resize = create n_cst_resize
inv_resize.of_SetOrigSize (this.Width, this.Height)
//inv_resize.of_SetOrigSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())
//inv_resize.of_SetMinSize(800, 500)
//inv_resize.of_Register(dw_1, 0, 0, 100, 100)
//inv_resize.of_Register(dw_1, inv_resize.FIXEDBOTTOM_SCALERIGHT)
inv_resize.of_Register(dw_1, inv_resize.SCALE)
//inv_resize.of_Register(uo_1, inv_resize.FIXEDBOTTOM_SCALERIGHT)
inv_resize.of_Register(uo_1, inv_resize.SCALE)
//inv_resize.of_Register(cb_1, inv_resize.FIXEDBOTTOM_SCALERIGHT)
inv_resize.of_Register(cb_1, inv_resize.SCALE)

//messagebox("origw",this.WorkSpaceWidth())
//messagebox("origh",this.WorkSpaceHeight())
end event

event resize;inv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
//messagebox("resize","")
end event

event close;destroy inv_resize
end event

type dw_1 from datawindow within w_birthdate
event dropdown pbm_dwndropdown
event lbuttondown pbm_lbuttondown
int X=66
int Y=51
int Width=984
int Height=416
string DataObject="d_pregnancy"
boolean Border=false
end type

event dropdown;// Check if this column has an associated calendar
If iuo_calendar.Event pfc_dropdown() = 1 Then
	// Prevent listbox from appearing.
	Return 1
End If

//Check if this column has an associated calculator
If iuo_calculator.Event pfc_dropdown() = 1 Then
	// Prevent listbox from appearing.
	Return 1
End If


end event

event lbuttondown;//This line is required

end event

event constructor;n_cst_calculatorattrib lnv_calculatorattrib
n_cst_calendarattrib lnv_calendarattrib

// Tell the object to behave as a dropdown object.
lnv_calendarattrib.ib_dropdown = True
OpenUserObjectWithParm(iuo_Calendar, lnv_calendarattrib)
iuo_Calendar.of_SetRequestor (this)
iuo_calendar.of_Register('conception_date', iuo_calendar.DDLB_WITHARROW)

// Tell the object to behave as a dropdown object.
lnv_calculatorattrib.ib_dropdown = True
OpenUserObjectWithParm(iuo_Calculator, lnv_calculatorattrib)
iuo_Calculator.of_SetRequestor (this)
iuo_calculator.of_Register('pregnancy_days', iuo_calculator.DDLB_WITHARROW)



inv_dwresize = Create n_cst_dwsrv_resize
inv_dwresize.of_SetRequestor ( this )
inv_dwresize.of_SetOrigSize (this.Width, this.Height)

// Args - PercentageX, PercentageY, PercentageWidth, PercentageHeight
inv_dwresize.of_Register('conception_date_t', 0, 0, 50, 50)
inv_dwresize.of_Register('conception_date', 50, 0, 70, 50)
inv_dwresize.of_Register('pregnancy_days_t', 0, 40, 50, 50)
inv_dwresize.of_Register('pregnancy_days', 50, 40, 70, 50)
inv_dwresize.of_Register('due_date_t', 0, 60, 50, 50)
inv_dwresize.of_Register('due_date', 50, 60, 70, 50)	
	
this.insertrow(0)

end event

event destructor;CloseUserObject(iuo_Calendar)
CloseUserObject(iuo_Calculator)
Destroy inv_dwresize

end event

event resize;inv_dwresize.Event pfc_Resize (sizetype, This.Width, This.Height)
end event

type cb_1 from commandbutton within w_birthdate
int X=384
int Y=733
int Width=362
int Height=90
int TabOrder=20
string Text="&Predict"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer	li_pregdays, li_days
long		ll_complete1, ll_count
string 	ls_array[], ls_format = "mmm dd, yyyy"
Date		ld_condate, ld_reldate
n_cst_string 	lnv_string

dw_1.AcceptText()
ld_condate = dw_1.getitemdate(1, 1)
li_pregdays = dw_1.getitemnumber(1, 2)
SetNull(ld_reldate)
dw_1.SetItem (1, 3, ld_reldate)

ls_array[1] = "Conception Date: " + String(ld_condate, ls_format)

For ll_count = 1 To 10
	li_days = ll_count * 28 + 1
	If li_days > li_pregdays Then Exit
	ld_reldate = Relativedate (ld_condate, li_days)
	ls_array[ll_count + 1] = "Week " + string (ll_count * 4 + 1) + ": " + String (ld_Reldate, ls_format)	
Next

ld_reldate = Relativedate (ld_condate, li_pregdays)
ls_array[ll_count + 1] = "Due Date: " + String (ld_Reldate, ls_format)

// Initialize the Progress Bars
uo_1.of_SetMessageText(ls_array)
uo_1.of_SetPosition(0)

// Start the algorithm.
Do 
	ll_count ++
	Yield()
	
	If Mod(ll_count, 9000) = 0 Then
		If ll_complete1 < 100 Then
			ll_complete1 = uo_1.of_Increment()
		End If
		
	End If
Loop Until ll_complete1 = 100

dw_1.SetItem (1, 3, ld_reldate)

lnv_string.of_arraytostring (ls_array, "~r~n", ls_format)
MessageBox ("Appointment Schedule", ls_format)


end event

type uo_1 from u_progressbar within w_birthdate
int X=66
int Y=576
int Width=984
int Height=90
int TabOrder=10
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
end type

on uo_1.destroy
call u_progressbar::destroy
end on

event constructor;call super::constructor;of_SetFillStyle(LEFTRIGHT)
of_SetDisplayStyle(MSGTEXT)
of_SetFontSize(10)
of_SetTextcolor(RGB(255,255,0))
of_SetFillColor(RGB(0,0,128))
of_SetAutoReset(false)

end event

