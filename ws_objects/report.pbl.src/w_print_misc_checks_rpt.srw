$PBExportHeader$w_print_misc_checks_rpt.srw
forward
global type w_print_misc_checks_rpt from w_base_no_criteria_scan
end type
type cb_generate from commandbutton within w_print_misc_checks_rpt
end type
type em_start from editmask within w_print_misc_checks_rpt
end type
type em_end from editmask within w_print_misc_checks_rpt
end type
type st_end from statictext within w_print_misc_checks_rpt
end type
type st_start from statictext within w_print_misc_checks_rpt
end type
type sle_beg_check from singlelineedit within w_print_misc_checks_rpt
end type
type sle_end_check from singlelineedit within w_print_misc_checks_rpt
end type
type st_dash from statictext within w_print_misc_checks_rpt
end type
type st_range from statictext within w_print_misc_checks_rpt
end type
type ddlb_fee_type from dropdownlistbox within w_print_misc_checks_rpt
end type
type st_1 from statictext within w_print_misc_checks_rpt
end type
end forward

global type w_print_misc_checks_rpt from w_base_no_criteria_scan
int Width=3591
int Height=2074
boolean TitleBar=true
string Title="Print Misc. Checks"
cb_generate cb_generate
em_start em_start
em_end em_end
st_end st_end
st_start st_start
sle_beg_check sle_beg_check
sle_end_check sle_end_check
st_dash st_dash
st_range st_range
ddlb_fee_type ddlb_fee_type
st_1 st_1
end type
global w_print_misc_checks_rpt w_print_misc_checks_rpt

type variables
string i_achreport, i_achSQL
string i_achFundNum, i_achSrcNum, i_achDeptNum
string i_achActNum, i_achProjNum, i_achObjNum
string i_achALENum

datastore ids_WfFundPercent, ids_WfFundGross
end variables

on w_print_misc_checks_rpt.create
int iCurrent
call super::create
this.cb_generate=create cb_generate
this.em_start=create em_start
this.em_end=create em_end
this.st_end=create st_end
this.st_start=create st_start
this.sle_beg_check=create sle_beg_check
this.sle_end_check=create sle_end_check
this.st_dash=create st_dash
this.st_range=create st_range
this.ddlb_fee_type=create ddlb_fee_type
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_generate
this.Control[iCurrent+2]=this.em_start
this.Control[iCurrent+3]=this.em_end
this.Control[iCurrent+4]=this.st_end
this.Control[iCurrent+5]=this.st_start
this.Control[iCurrent+6]=this.sle_beg_check
this.Control[iCurrent+7]=this.sle_end_check
this.Control[iCurrent+8]=this.st_dash
this.Control[iCurrent+9]=this.st_range
this.Control[iCurrent+10]=this.ddlb_fee_type
this.Control[iCurrent+11]=this.st_1
end on

on w_print_misc_checks_rpt.destroy
call super::destroy
destroy(this.cb_generate)
destroy(this.em_start)
destroy(this.em_end)
destroy(this.st_end)
destroy(this.st_start)
destroy(this.sle_beg_check)
destroy(this.sle_end_check)
destroy(this.st_dash)
destroy(this.st_range)
destroy(this.ddlb_fee_type)
destroy(this.st_1)
end on

event open;
long s_lMinCheck, s_lMaxCheck

datawindowchild dwc

SetPointer(HourGlass!)

this.x = 10
this.y = 10

//this.Width = dw_scan.width + dw_scan.x + 200
//this.Height = dw_scan.Height + 1100

gnv_resize = create n_cst_resize
gnv_resize.of_SetOrigSize (this.Width, this.Height )
gnv_resize.of_Register(dw_scan, gnv_resize.SCALE)

gnv_resize.of_Register(st_start, gnv_resize.SCALE)
gnv_resize.of_Register(em_start, gnv_resize.SCALE)
gnv_resize.of_Register(st_end, gnv_resize.SCALE)
gnv_resize.of_Register(em_end, gnv_resize.SCALE)

gnv_resize.of_Register(st_1, gnv_resize.SCALE)
gnv_resize.of_Register(st_dash, gnv_resize.SCALE)
gnv_resize.of_Register(st_range, gnv_resize.SCALE)
gnv_resize.of_Register(sle_beg_check, gnv_resize.SCALE)
gnv_resize.of_Register(sle_end_check, gnv_resize.SCALE)
gnv_resize.of_Register(ddlb_fee_type, gnv_resize.SCALE)

gnv_resize.of_Register(cb_generate, gnv_resize.SCALE)
gnv_resize.of_Register(cb_print, gnv_resize.SCALE)
gnv_resize.of_Register(cb_exit, gnv_resize.SCALE)

f_load_utcodesddlb(ddlb_fee_type, "FEE")

s_lMinCheck = 0
SELECT min(check_number)
	INTO :s_lMinCheck
	FROM sh_docket_disbursement
	WHERE cb_type = 'M'
	AND check_number > 0
	AND disburse_status = 'W';
If IsNull(s_lMinCheck) Then s_lMinCheck = 0

s_lMaxCheck = 0
SELECT max(check_number)
	INTO :s_lMaxCheck
	FROM sh_docket_disbursement
	WHERE cb_type = 'M'
	AND check_number > 0
	AND disburse_status = 'W';
If IsNull(s_lMaxCheck) Then s_lMaxCheck = 0

sle_beg_check.text = string(s_lMinCheck)
sle_end_check.text = string(s_lMaxCheck)

ddlb_fee_type.SetFocus()

st_start.visible = False
em_start.visible = False
st_end.visible = False
em_end.visible = False

cb_generate.pointer="arrow!"
cb_print.pointer="arrow!"
cb_exit.pointer="arrow!"


end event

event addclicked;// Override ancestor script
end event

event deleteclicked;// Override ancestor script
end event

event opentimer;// Override ancestor script
end event

event updateclicked;// Override ancestor script
end event

event viewclicked;// Override ancestor script
end event

event resize;call super::resize;gnv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
end event

type cb_view from w_base_no_criteria_scan`cb_view within w_print_misc_checks_rpt
int TabOrder=0
boolean Visible=false
end type

type cb_print from w_base_no_criteria_scan`cb_print within w_print_misc_checks_rpt
int X=2878
int Y=51
int Width=315
int Height=96
int TabOrder=40
int TextSize=-9
end type

event cb_print::clicked;
OpenWithParm(w_datawindow_print_dialog,dw_scan)


end event

type cb_update from w_base_no_criteria_scan`cb_update within w_print_misc_checks_rpt
int TabOrder=0
boolean Visible=false
end type

type dw_scan from w_base_no_criteria_scan`dw_scan within w_print_misc_checks_rpt
int X=29
int Y=182
int Width=3500
int Height=1680
int TabOrder=0
string DataObject="dw_civil_misc_check_rpt"
boolean HScrollBar=true
end type

event dw_scan::doubleclicked;// Override
end event

type cb_exit from w_base_no_criteria_scan`cb_exit within w_print_misc_checks_rpt
int X=3215
int Y=51
int Width=315
int Height=96
int TabOrder=50
int TextSize=-9
end type

type cb_delete from w_base_no_criteria_scan`cb_delete within w_print_misc_checks_rpt
int TabOrder=0
boolean Visible=false
end type

type cb_add from w_base_no_criteria_scan`cb_add within w_print_misc_checks_rpt
int TabOrder=0
boolean Visible=false
end type

type cb_generate from commandbutton within w_print_misc_checks_rpt
int X=2542
int Y=51
int Width=315
int Height=96
int TabOrder=30
boolean BringToTop=true
string Text="&Generate"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
// script variables
string s_achSQL, s_achFeeType, s_achDisburseType
integer s_iposition, s_iLoop, s_iCount, s_iCBDisYear

string s_achStart, s_achStartYear, s_achStartMonth, s_achStartDay
integer s_iStartYear, s_iStartMonth, s_iStartDay
string s_achEnd, s_achEndYear, s_achEndMonth, s_achEndDay
integer s_iEndYear, s_iEndMonth, s_iEndDay
date s_dtStart, s_dtEnd

datastore lds_Disbursement

long s_ltaxyear, s_lBegReceipt, s_lEndReceipt, s_lCBDISNum, s_lCheckNum
long s_lDisbursementRows, s_lCount
long s_lBegCheck, s_lEndCheck

SetPointer(HourGlass!)

s_achFeeType = Trim(Left(ddlb_fee_type.text, Pos(ddlb_fee_type.text, " ")))

s_achStart = String(em_start.text)
s_achStartYear = Mid(s_achStart,7,4)
s_achStartMonth = Mid(s_achStart,1,2)
s_achStartDay = Mid(s_achStart,4,2)
s_iStartYear = Integer(s_achStartYear)
s_iStartMonth = Integer(s_achStartMonth)
s_iStartDay = Integer(s_achStartDay)
s_dtStart = Date(s_iStartYear, s_iStartMonth, s_iStartDay)

s_achEnd = String(em_end.text)
s_achEndYear = Mid(s_achEnd,7,4)
s_achEndMonth = Mid(s_achEnd,1,2)
s_achEndDay = Mid(s_achEnd,4,2)
s_iEndYear = Integer(s_achEndYear)
s_iEndMonth = Integer(s_achEndMonth)
s_iEndDay = Integer(s_achEndDay)
s_dtEnd = Date(s_iEndYear, s_iEndMonth, s_iEndDay)

s_lBegCheck = Long(sle_beg_check.text)
s_lEndCheck = Long(sle_end_check.text)

SetPointer(HourGlass!)

i_achSQL = ""

i_achSQL = dw_scan.GetSQLSelect()
s_achSQL = i_achSQL + s_achSQL

dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
	
dw_scan.SetTransObject(SQLCA)
dw_scan.Reset()
If dw_scan.Retrieve('W', 'M', 'FEE', s_lBegCheck, s_lEndCheck) = 0 Then
	MessageBox("Complete", "No Rows Found.")
	dw_scan.SetFocus()
Else
	dw_scan.SetFocus()
End If		



end event

type em_start from editmask within w_print_misc_checks_rpt
int X=2384
int Y=182
int Width=388
int Height=80
int TabOrder=70
boolean Visible=false
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
string Mask="mm/dd/yyyy"
MaskDataType MaskDataType=DateMask!
boolean Spin=true
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_end from editmask within w_print_misc_checks_rpt
int X=2384
int Y=275
int Width=388
int Height=80
int TabOrder=80
boolean Visible=false
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
string Mask="mm/dd/yyyy"
MaskDataType MaskDataType=DateMask!
boolean Spin=true
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_end from statictext within w_print_misc_checks_rpt
int X=1975
int Y=285
int Width=395
int Height=61
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="End Date:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_start from statictext within w_print_misc_checks_rpt
int X=1975
int Y=189
int Width=395
int Height=61
boolean Visible=false
boolean Enabled=false
string Text="Start Date:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_beg_check from singlelineedit within w_print_misc_checks_rpt
int X=1485
int Y=51
int Width=333
int Height=83
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_end_check from singlelineedit within w_print_misc_checks_rpt
int X=1887
int Y=51
int Width=333
int Height=83
int TabOrder=20
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_dash from statictext within w_print_misc_checks_rpt
int X=1825
int Y=64
int Width=59
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text="-"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_range from statictext within w_print_misc_checks_rpt
int X=494
int Y=64
int Width=973
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text="Misc. Receipt - Check Range:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_fee_type from dropdownlistbox within w_print_misc_checks_rpt
int X=369
int Y=51
int Width=1269
int Height=330
int TabOrder=60
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_print_misc_checks_rpt
int X=44
int Y=58
int Width=311
int Height=74
boolean Visible=false
boolean Enabled=false
string Text="Fee Type:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

