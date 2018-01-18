$PBExportHeader$w_civil_disbursement_rpt.srw
forward
global type w_civil_disbursement_rpt from w_base_no_criteria_scan
end type
type cb_generate from commandbutton within w_civil_disbursement_rpt
end type
type em_start from editmask within w_civil_disbursement_rpt
end type
type em_end from editmask within w_civil_disbursement_rpt
end type
type st_end from statictext within w_civil_disbursement_rpt
end type
type st_start from statictext within w_civil_disbursement_rpt
end type
type rb_disb_disbtype from radiobutton within w_civil_disbursement_rpt
end type
type rb_disb_name from radiobutton within w_civil_disbursement_rpt
end type
type ddlb_criteria from dropdownlistbox within w_civil_disbursement_rpt
end type
type rb_disb_daterange from radiobutton within w_civil_disbursement_rpt
end type
type rb_disb_singlename from radiobutton within w_civil_disbursement_rpt
end type
type rb_disb_checknum from radiobutton within w_civil_disbursement_rpt
end type
type st_criteria from statictext within w_civil_disbursement_rpt
end type
type st_criteria2 from statictext within w_civil_disbursement_rpt
end type
type sle_criteria2 from singlelineedit within w_civil_disbursement_rpt
end type
type rb_disb_compdisbnum from radiobutton within w_civil_disbursement_rpt
end type
type gb_1 from groupbox within w_civil_disbursement_rpt
end type
type rb_disb_singledisbtype from radiobutton within w_civil_disbursement_rpt
end type
type rb_outstand_check from radiobutton within w_civil_disbursement_rpt
end type
type sle_criteria from singlelineedit within w_civil_disbursement_rpt
end type
type rb_unwarranted from radiobutton within w_civil_disbursement_rpt
end type
type rb_cleared_check from radiobutton within w_civil_disbursement_rpt
end type
type rb_outstand_check_date from radiobutton within w_civil_disbursement_rpt
end type
type rb_paid_check_date from radiobutton within w_civil_disbursement_rpt
end type
type rb_voided_check from radiobutton within w_civil_disbursement_rpt
end type
end forward

global type w_civil_disbursement_rpt from w_base_no_criteria_scan
int Width=3591
int Height=2074
boolean TitleBar=true
string Title="Civil Disbursement Reports"
cb_generate cb_generate
em_start em_start
em_end em_end
st_end st_end
st_start st_start
rb_disb_disbtype rb_disb_disbtype
rb_disb_name rb_disb_name
ddlb_criteria ddlb_criteria
rb_disb_daterange rb_disb_daterange
rb_disb_singlename rb_disb_singlename
rb_disb_checknum rb_disb_checknum
st_criteria st_criteria
st_criteria2 st_criteria2
sle_criteria2 sle_criteria2
rb_disb_compdisbnum rb_disb_compdisbnum
gb_1 gb_1
rb_disb_singledisbtype rb_disb_singledisbtype
rb_outstand_check rb_outstand_check
sle_criteria sle_criteria
rb_unwarranted rb_unwarranted
rb_cleared_check rb_cleared_check
rb_outstand_check_date rb_outstand_check_date
rb_paid_check_date rb_paid_check_date
rb_voided_check rb_voided_check
end type
global w_civil_disbursement_rpt w_civil_disbursement_rpt

type variables
string i_achreport, i_achSQL
string i_achFundNum, i_achSrcNum, i_achDeptNum
string i_achActNum, i_achProjNum, i_achObjNum
string i_achALENum

datastore ids_WfFundPercent, ids_WfFundGross
end variables

on w_civil_disbursement_rpt.create
int iCurrent
call super::create
this.cb_generate=create cb_generate
this.em_start=create em_start
this.em_end=create em_end
this.st_end=create st_end
this.st_start=create st_start
this.rb_disb_disbtype=create rb_disb_disbtype
this.rb_disb_name=create rb_disb_name
this.ddlb_criteria=create ddlb_criteria
this.rb_disb_daterange=create rb_disb_daterange
this.rb_disb_singlename=create rb_disb_singlename
this.rb_disb_checknum=create rb_disb_checknum
this.st_criteria=create st_criteria
this.st_criteria2=create st_criteria2
this.sle_criteria2=create sle_criteria2
this.rb_disb_compdisbnum=create rb_disb_compdisbnum
this.gb_1=create gb_1
this.rb_disb_singledisbtype=create rb_disb_singledisbtype
this.rb_outstand_check=create rb_outstand_check
this.sle_criteria=create sle_criteria
this.rb_unwarranted=create rb_unwarranted
this.rb_cleared_check=create rb_cleared_check
this.rb_outstand_check_date=create rb_outstand_check_date
this.rb_paid_check_date=create rb_paid_check_date
this.rb_voided_check=create rb_voided_check
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_generate
this.Control[iCurrent+2]=this.em_start
this.Control[iCurrent+3]=this.em_end
this.Control[iCurrent+4]=this.st_end
this.Control[iCurrent+5]=this.st_start
this.Control[iCurrent+6]=this.rb_disb_disbtype
this.Control[iCurrent+7]=this.rb_disb_name
this.Control[iCurrent+8]=this.ddlb_criteria
this.Control[iCurrent+9]=this.rb_disb_daterange
this.Control[iCurrent+10]=this.rb_disb_singlename
this.Control[iCurrent+11]=this.rb_disb_checknum
this.Control[iCurrent+12]=this.st_criteria
this.Control[iCurrent+13]=this.st_criteria2
this.Control[iCurrent+14]=this.sle_criteria2
this.Control[iCurrent+15]=this.rb_disb_compdisbnum
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.rb_disb_singledisbtype
this.Control[iCurrent+18]=this.rb_outstand_check
this.Control[iCurrent+19]=this.sle_criteria
this.Control[iCurrent+20]=this.rb_unwarranted
this.Control[iCurrent+21]=this.rb_cleared_check
this.Control[iCurrent+22]=this.rb_outstand_check_date
this.Control[iCurrent+23]=this.rb_paid_check_date
this.Control[iCurrent+24]=this.rb_voided_check
end on

on w_civil_disbursement_rpt.destroy
call super::destroy
destroy(this.cb_generate)
destroy(this.em_start)
destroy(this.em_end)
destroy(this.st_end)
destroy(this.st_start)
destroy(this.rb_disb_disbtype)
destroy(this.rb_disb_name)
destroy(this.ddlb_criteria)
destroy(this.rb_disb_daterange)
destroy(this.rb_disb_singlename)
destroy(this.rb_disb_checknum)
destroy(this.st_criteria)
destroy(this.st_criteria2)
destroy(this.sle_criteria2)
destroy(this.rb_disb_compdisbnum)
destroy(this.gb_1)
destroy(this.rb_disb_singledisbtype)
destroy(this.rb_outstand_check)
destroy(this.sle_criteria)
destroy(this.rb_unwarranted)
destroy(this.rb_cleared_check)
destroy(this.rb_outstand_check_date)
destroy(this.rb_paid_check_date)
destroy(this.rb_voided_check)
end on

event open;datawindowchild dwc

SetPointer(HourGlass!)

//this.x = 10
//this.y = 10

//this.Width = dw_scan.width + dw_scan.x + 200
//this.Height = dw_scan.Height + 1100

gnv_resize = create n_cst_resize
gnv_resize.of_SetOrigSize (this.Width, this.Height )
gnv_resize.of_Register(dw_scan, gnv_resize.SCALE)
gnv_resize.of_Register(rb_cleared_check, gnv_resize.SCALE)
gnv_resize.of_Register(rb_disb_checknum, gnv_resize.SCALE)
gnv_resize.of_Register(rb_disb_compdisbnum, gnv_resize.SCALE)
gnv_resize.of_Register(rb_disb_daterange, gnv_resize.SCALE)
gnv_resize.of_Register(rb_disb_disbtype, gnv_resize.SCALE)
gnv_resize.of_Register(rb_disb_name, gnv_resize.SCALE)
gnv_resize.of_Register(rb_disb_singledisbtype, gnv_resize.SCALE)
gnv_resize.of_Register(rb_disb_singlename, gnv_resize.SCALE)
gnv_resize.of_Register(rb_outstand_check, gnv_resize.SCALE)
gnv_resize.of_Register(rb_outstand_check_date, gnv_resize.SCALE)
gnv_resize.of_Register(rb_paid_check_date, gnv_resize.SCALE)
gnv_resize.of_Register(rb_unwarranted, gnv_resize.SCALE)
gnv_resize.of_Register(rb_voided_check, gnv_resize.SCALE)

gnv_resize.of_Register(st_start, gnv_resize.SCALE)
gnv_resize.of_Register(em_start, gnv_resize.SCALE)
gnv_resize.of_Register(st_end, gnv_resize.SCALE)
gnv_resize.of_Register(em_end, gnv_resize.SCALE)

gnv_resize.of_Register(st_criteria, gnv_resize.SCALE)
gnv_resize.of_Register(st_criteria2, gnv_resize.SCALE)
gnv_resize.of_Register(sle_criteria, gnv_resize.SCALE)
gnv_resize.of_Register(sle_criteria2, gnv_resize.SCALE)
gnv_resize.of_Register(ddlb_criteria, gnv_resize.SCALE)

gnv_resize.of_Register(gb_1, gnv_resize.SCALE)

gnv_resize.of_Register(cb_generate, gnv_resize.SCALE)
gnv_resize.of_Register(cb_print, gnv_resize.SCALE)
gnv_resize.of_Register(cb_exit, gnv_resize.SCALE)

st_start.visible = True
em_start.visible = True
st_end.visible = True
em_end.visible = True

st_start.text = "Date Paid - Start:"

st_criteria.visible = False
st_criteria.text = ""
st_criteria2.visible = False
st_criteria2.text = ""
sle_criteria.visible = False
sle_criteria2.visible = False
ddlb_criteria.visible = False

rb_disb_checknum.checked = True

//ddlb_criteria.Reset()
//f_load_utcodesddlb(ddlb_criteria, "INV")

SetFocus(em_start)

rb_cleared_check.pointer="arrow!"
rb_disb_checknum.pointer="arrow!"
rb_disb_compdisbnum.pointer="arrow!"
rb_disb_daterange.pointer="arrow!"
rb_disb_disbtype.pointer="arrow!"
rb_disb_name.pointer="arrow!"
rb_disb_singledisbtype.pointer="arrow!"
rb_disb_singlename.pointer="arrow!"
rb_outstand_check.pointer="arrow!"
rb_outstand_check_date.pointer="arrow!"
rb_paid_check_date.pointer="arrow!"
rb_unwarranted.pointer="arrow!"
rb_voided_check.pointer="arrow!"
cb_generate.pointer="arrow!"
cb_print.pointer="arrow!"
cb_exit.pointer="arrow!"
gb_1.pointer="arrow!"

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

type cb_view from w_base_no_criteria_scan`cb_view within w_civil_disbursement_rpt
int TabOrder=0
boolean Visible=false
end type

type cb_print from w_base_no_criteria_scan`cb_print within w_civil_disbursement_rpt
int X=3215
int Y=144
int Width=315
int Height=96
int TabOrder=70
int TextSize=-9
end type

event cb_print::clicked;
OpenWithParm(w_datawindow_print_dialog,dw_scan)


end event

type cb_update from w_base_no_criteria_scan`cb_update within w_civil_disbursement_rpt
int TabOrder=0
boolean Visible=false
end type

type dw_scan from w_base_no_criteria_scan`dw_scan within w_civil_disbursement_rpt
int X=29
int Y=470
int Width=3500
int Height=1382
int TabOrder=0
string DataObject="dw_disb_date_rpt"
boolean HScrollBar=true
end type

event dw_scan::doubleclicked;// Override
end event

type cb_exit from w_base_no_criteria_scan`cb_exit within w_civil_disbursement_rpt
int X=3215
int Y=262
int Width=315
int Height=96
int TabOrder=80
int TextSize=-9
end type

type cb_delete from w_base_no_criteria_scan`cb_delete within w_civil_disbursement_rpt
int TabOrder=0
boolean Visible=false
end type

type cb_add from w_base_no_criteria_scan`cb_add within w_civil_disbursement_rpt
int TabOrder=0
boolean Visible=false
end type

type cb_generate from commandbutton within w_civil_disbursement_rpt
int X=3215
int Y=26
int Width=315
int Height=96
int TabOrder=60
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
string s_achSQL
integer s_iposition

string s_achStart, s_achStartYear, s_achStartMonth, s_achStartDay
integer s_iStartYear, s_iStartMonth, s_iStartDay
string s_achEnd, s_achEndYear, s_achEndMonth, s_achEndDay
integer s_iEndYear, s_iEndMonth, s_iEndDay
date s_dtStart, s_dtEnd
integer s_iDocketYear
string s_achLastName, s_achFirstName, s_achFeeType, s_achDisbType


SetPointer(HourGlass!)

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

SetPointer(HourGlass!)

If rb_disb_compdisbnum.checked = True Then
	i_achSQL = ""

	dw_scan.DataObject = "dw_disb_compdisbnum_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd) = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_disb_daterange.checked = True Then
	i_achSQL = ""

	dw_scan.DataObject = "dw_disb_date_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd) = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_disb_name.checked = True Then
	i_achSQL = ""

	dw_scan.DataObject = "dw_disb_name_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd) = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_disb_checknum.checked = True Then
	i_achSQL = ""

	dw_scan.DataObject = "dw_disb_checknum_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd) = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_disb_disbtype.checked = True Then
	i_achSQL = ""

	dw_scan.DataObject = "dw_disb_type_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd) = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_disb_singlename.checked = True Then
	s_achLastName = trim(sle_criteria.text) + "%"
	s_achFirstName = trim(sle_criteria2.text) + "%"
	
	i_achSQL = ""

	dw_scan.DataObject = "dw_disb_single_name_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd, s_achLastName, s_achFirstName) = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_disb_singledisbtype.checked = True Then
	s_iPosition = Pos(ddlb_criteria.text," ",1)
	s_achDisbType = String(Mid(ddlb_criteria.text,1,s_iPosition - 1))

	i_achSQL = ""

	dw_scan.DataObject = "dw_disb_single_type_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd, 'RECT', s_achDisbType) = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_unwarranted.checked = True Then
	i_achSQL = ""

	dw_scan.DataObject = "dw_disb_outstanding_unwarranted_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve('O') = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_outstand_check.checked = True Then
	i_achSQL = ""

	dw_scan.DataObject = "dw_disb_outstanding_check_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve('W') = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_outstand_check_date.checked = True Then
	i_achSQL = ""

	dw_scan.DataObject = "dw_disb_outstanding_check_date_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd, 'W') = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_paid_check_date.checked = True Then
	i_achSQL = ""

	dw_scan.DataObject = "dw_disb_paid_check_date_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd) = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_cleared_check.checked = True Then
	i_achSQL = ""

	dw_scan.DataObject = "dw_disb_cleared_check_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd, 'C') = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_voided_check.checked = True Then
	i_achSQL = ""

	dw_scan.DataObject = "dw_disb_voided_check_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd) = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If


end event

type em_start from editmask within w_civil_disbursement_rpt
int X=2264
int Y=26
int Width=388
int Height=80
int TabOrder=10
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

type em_end from editmask within w_civil_disbursement_rpt
int X=2264
int Y=118
int Width=388
int Height=80
int TabOrder=20
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

type st_end from statictext within w_civil_disbursement_rpt
int X=1671
int Y=128
int Width=581
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text="End:"
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

type st_start from statictext within w_civil_disbursement_rpt
int X=1671
int Y=32
int Width=581
int Height=61
boolean Enabled=false
string Text="Start:"
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

type rb_disb_disbtype from radiobutton within w_civil_disbursement_rpt
int X=55
int Y=234
int Width=512
int Height=74
boolean BringToTop=true
string Text="By Disb Type"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
st_start.visible = True
em_start.visible = True
st_end.visible = True
em_end.visible = True

st_start.text = "Date Paid - Start:"

st_criteria.visible = False
st_criteria.text = ""
st_criteria2.visible = False
st_criteria2.text = ""
sle_criteria.visible = False
sle_criteria.text = ""
sle_criteria2.visible = False
sle_criteria2.text = ""

ddlb_criteria.visible = False

SetFocus(em_start)
end event

type rb_disb_name from radiobutton within w_civil_disbursement_rpt
int X=55
int Y=298
int Width=512
int Height=74
boolean BringToTop=true
string Text="By Name"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
st_start.visible = True
em_start.visible = True
st_end.visible = True
em_end.visible = True

st_start.text = "Date Paid - Start:"

st_criteria.visible = False
st_criteria.text = ""
st_criteria2.visible = False
st_criteria2.text = ""
sle_criteria.visible = False
sle_criteria.text = ""
sle_criteria2.visible = False
sle_criteria2.text = ""

ddlb_criteria.visible = False

SetFocus(em_start)
end event

type ddlb_criteria from dropdownlistbox within w_civil_disbursement_rpt
int X=2264
int Y=266
int Width=534
int Height=374
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_disb_daterange from radiobutton within w_civil_disbursement_rpt
int X=55
int Y=170
int Width=512
int Height=74
boolean BringToTop=true
string Text="By Date Range"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
st_start.visible = True
em_start.visible = True
st_end.visible = True
em_end.visible = True

st_start.text = "Date Paid - Start:"

st_criteria.visible = False
st_criteria.text = ""
st_criteria2.visible = False
st_criteria2.text = ""
sle_criteria.visible = False
sle_criteria.text = ""
sle_criteria2.visible = False
sle_criteria2.text = ""

ddlb_criteria.visible = False

SetFocus(em_start)
end event

type rb_disb_singlename from radiobutton within w_civil_disbursement_rpt
int X=571
int Y=106
int Width=428
int Height=74
boolean BringToTop=true
string Text="Name"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
st_start.visible = True
em_start.visible = True
st_end.visible = True
em_end.visible = True

st_start.text = "Date Paid - Start:"

st_criteria.visible = True
st_criteria.text = "Last Name:"
st_criteria2.visible = True
st_criteria2.text = "First Name:"
sle_criteria.visible = True
sle_criteria.text = ""
sle_criteria2.visible = True
sle_criteria2.text = ""

ddlb_criteria.visible = False

SetFocus(em_start)
end event

type rb_disb_checknum from radiobutton within w_civil_disbursement_rpt
int X=55
int Y=42
int Width=512
int Height=74
boolean BringToTop=true
string Text="By Check Num"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
st_start.visible = True
em_start.visible = True
st_end.visible = True
em_end.visible = True

st_start.text = "Date Paid - Start:"

st_criteria.visible = False
st_criteria.text = ""
st_criteria2.visible = False
st_criteria2.text = ""
sle_criteria.visible = False
sle_criteria.text = ""
sle_criteria2.visible = False
sle_criteria2.text = ""

ddlb_criteria.visible = False

SetFocus(em_start)
end event

type st_criteria from statictext within w_civil_disbursement_rpt
int X=1671
int Y=278
int Width=581
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text="Criteria"
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

type st_criteria2 from statictext within w_civil_disbursement_rpt
int X=1671
int Y=374
int Width=581
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text="Criteria2"
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

type sle_criteria2 from singlelineedit within w_civil_disbursement_rpt
int X=2264
int Y=362
int Width=889
int Height=80
int TabOrder=40
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

type rb_disb_compdisbnum from radiobutton within w_civil_disbursement_rpt
int X=55
int Y=106
int Width=512
int Height=74
string Text="By Comp Disb #"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
st_start.visible = True
em_start.visible = True
st_end.visible = True
em_end.visible = True

st_start.text = "Date Paid - Start:"

st_criteria.visible = False
st_criteria.text = ""
st_criteria2.visible = False
st_criteria2.text = ""
sle_criteria.visible = False
sle_criteria.text = ""
sle_criteria2.visible = False
sle_criteria2.text = ""

ddlb_criteria.visible = False

SetFocus(em_start)
end event

type gb_1 from groupbox within w_civil_disbursement_rpt
int X=29
int Width=1631
int Height=454
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_disb_singledisbtype from radiobutton within w_civil_disbursement_rpt
int X=571
int Y=42
int Width=428
int Height=74
boolean BringToTop=true
string Text="Disb. Type"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
st_start.visible = True
em_start.visible = True
st_end.visible = True
em_end.visible = True

st_start.text = "Date Paid - Start:"

st_criteria.visible = True
st_criteria.text = "Disb Type:"
st_criteria2.visible = False
st_criteria2.text = ""
sle_criteria.visible = False
sle_criteria.text = ""
sle_criteria2.visible = False
sle_criteria2.text = ""

ddlb_criteria.visible = True
ddlb_criteria.Reset()
f_load_utcodesddlb(ddlb_criteria, "RECT")

SetFocus(em_start)
end event

type rb_outstand_check from radiobutton within w_civil_disbursement_rpt
int X=1024
int Y=106
int Width=611
int Height=74
boolean BringToTop=true
string Text="Outstanding Checks"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
st_start.visible = False
em_start.visible = False
st_end.visible = False
em_end.visible = False

st_start.text = ""

st_criteria.visible = False
st_criteria.text = ""
st_criteria2.visible = False
st_criteria2.text = ""
sle_criteria.visible = False
sle_criteria.text = ""
sle_criteria2.visible = False
sle_criteria2.text = ""

ddlb_criteria.visible = False

SetFocus(em_start)
end event

type sle_criteria from singlelineedit within w_civil_disbursement_rpt
int X=2264
int Y=266
int Width=889
int Height=80
int TabOrder=30
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

type rb_unwarranted from radiobutton within w_civil_disbursement_rpt
int X=1024
int Y=42
int Width=611
int Height=74
boolean BringToTop=true
string Text="Unwarranted Items"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
st_start.visible = False
em_start.visible = False
st_end.visible = False
em_end.visible = False

st_start.text = ""

st_criteria.visible = False
st_criteria.text = ""
st_criteria2.visible = False
st_criteria2.text = ""
sle_criteria.visible = False
sle_criteria.text = ""
sle_criteria2.visible = False
sle_criteria2.text = ""

ddlb_criteria.visible = False

SetFocus(em_start)
end event

type rb_cleared_check from radiobutton within w_civil_disbursement_rpt
int X=1024
int Y=298
int Width=611
int Height=74
boolean BringToTop=true
string Text="Cleared Checks"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
st_start.visible = True
em_start.visible = True
st_end.visible = True
em_end.visible = True

st_start.text = "Date Cleared - Start:"

st_criteria.visible = False
st_criteria.text = ""
st_criteria2.visible = False
st_criteria2.text = ""
sle_criteria.visible = False
sle_criteria.text = ""
sle_criteria2.visible = False
sle_criteria2.text = ""

ddlb_criteria.visible = False

SetFocus(em_start)
end event

type rb_outstand_check_date from radiobutton within w_civil_disbursement_rpt
int X=1024
int Y=170
int Width=611
int Height=74
boolean BringToTop=true
string Text="O/S Cks - Date Rng"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
st_start.visible = True
em_start.visible = True
st_end.visible = True
em_end.visible = True

st_start.text = "Date Paid - Start:"

st_criteria.visible = False
st_criteria.text = ""
st_criteria2.visible = False
st_criteria2.text = ""
sle_criteria.visible = False
sle_criteria.text = ""
sle_criteria2.visible = False
sle_criteria2.text = ""

ddlb_criteria.visible = False

SetFocus(em_start)
end event

type rb_paid_check_date from radiobutton within w_civil_disbursement_rpt
int X=1024
int Y=234
int Width=611
int Height=74
boolean BringToTop=true
string Text="Written Checks"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
st_start.visible = True
em_start.visible = True
st_end.visible = True
em_end.visible = True

st_start.text = "Date Paid - Start:"

st_criteria.visible = False
st_criteria.text = ""
st_criteria2.visible = False
st_criteria2.text = ""
sle_criteria.visible = False
sle_criteria.text = ""
sle_criteria2.visible = False
sle_criteria2.text = ""

ddlb_criteria.visible = False

SetFocus(em_start)
end event

type rb_voided_check from radiobutton within w_civil_disbursement_rpt
int X=1024
int Y=362
int Width=611
int Height=74
boolean BringToTop=true
string Text="Voided Checks"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
st_start.visible = True
em_start.visible = True
st_end.visible = True
em_end.visible = True

st_start.text = "Date Voided - Start:"

st_criteria.visible = False
st_criteria.text = ""
st_criteria2.visible = False
st_criteria2.text = ""
sle_criteria.visible = False
sle_criteria.text = ""
sle_criteria2.visible = False
sle_criteria2.text = ""

ddlb_criteria.visible = False

SetFocus(em_start)
end event

