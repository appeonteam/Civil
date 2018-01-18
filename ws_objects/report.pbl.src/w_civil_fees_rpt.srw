$PBExportHeader$w_civil_fees_rpt.srw
forward
global type w_civil_fees_rpt from w_base_no_criteria_scan
end type
type cb_generate from commandbutton within w_civil_fees_rpt
end type
type em_start from editmask within w_civil_fees_rpt
end type
type em_end from editmask within w_civil_fees_rpt
end type
type st_end from statictext within w_civil_fees_rpt
end type
type st_start from statictext within w_civil_fees_rpt
end type
type gb_1 from groupbox within w_civil_fees_rpt
end type
type rb_name_summary from radiobutton within w_civil_fees_rpt
end type
type st_criteria from statictext within w_civil_fees_rpt
end type
type rb_rec_date from radiobutton within w_civil_fees_rpt
end type
type rb_billable from radiobutton within w_civil_fees_rpt
end type
type rb_process from radiobutton within w_civil_fees_rpt
end type
type ddlb_criteria from dropdownlistbox within w_civil_fees_rpt
end type
type sle_criteria from singlelineedit within w_civil_fees_rpt
end type
end forward

global type w_civil_fees_rpt from w_base_no_criteria_scan
int Width=3591
int Height=2074
boolean TitleBar=true
string Title="Civil Fees Reports"
cb_generate cb_generate
em_start em_start
em_end em_end
st_end st_end
st_start st_start
gb_1 gb_1
rb_name_summary rb_name_summary
st_criteria st_criteria
rb_rec_date rb_rec_date
rb_billable rb_billable
rb_process rb_process
ddlb_criteria ddlb_criteria
sle_criteria sle_criteria
end type
global w_civil_fees_rpt w_civil_fees_rpt

type variables
string i_achreport, i_achSQL
string i_achFundNum, i_achSrcNum, i_achDeptNum
string i_achActNum, i_achProjNum, i_achObjNum
string i_achALENum

datastore ids_WfFundPercent, ids_WfFundGross
end variables

on w_civil_fees_rpt.create
int iCurrent
call super::create
this.cb_generate=create cb_generate
this.em_start=create em_start
this.em_end=create em_end
this.st_end=create st_end
this.st_start=create st_start
this.gb_1=create gb_1
this.rb_name_summary=create rb_name_summary
this.st_criteria=create st_criteria
this.rb_rec_date=create rb_rec_date
this.rb_billable=create rb_billable
this.rb_process=create rb_process
this.ddlb_criteria=create ddlb_criteria
this.sle_criteria=create sle_criteria
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_generate
this.Control[iCurrent+2]=this.em_start
this.Control[iCurrent+3]=this.em_end
this.Control[iCurrent+4]=this.st_end
this.Control[iCurrent+5]=this.st_start
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.rb_name_summary
this.Control[iCurrent+8]=this.st_criteria
this.Control[iCurrent+9]=this.rb_rec_date
this.Control[iCurrent+10]=this.rb_billable
this.Control[iCurrent+11]=this.rb_process
this.Control[iCurrent+12]=this.ddlb_criteria
this.Control[iCurrent+13]=this.sle_criteria
end on

on w_civil_fees_rpt.destroy
call super::destroy
destroy(this.cb_generate)
destroy(this.em_start)
destroy(this.em_end)
destroy(this.st_end)
destroy(this.st_start)
destroy(this.gb_1)
destroy(this.rb_name_summary)
destroy(this.st_criteria)
destroy(this.rb_rec_date)
destroy(this.rb_billable)
destroy(this.rb_process)
destroy(this.ddlb_criteria)
destroy(this.sle_criteria)
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
gnv_resize.of_Register(rb_billable, gnv_resize.SCALE)
gnv_resize.of_Register(rb_name_summary, gnv_resize.SCALE)
gnv_resize.of_Register(rb_process, gnv_resize.SCALE)
gnv_resize.of_Register(rb_rec_date, gnv_resize.SCALE)

gnv_resize.of_Register(st_start, gnv_resize.SCALE)
gnv_resize.of_Register(em_start, gnv_resize.SCALE)
gnv_resize.of_Register(st_end, gnv_resize.SCALE)
gnv_resize.of_Register(em_end, gnv_resize.SCALE)

gnv_resize.of_Register(st_criteria, gnv_resize.SCALE)
gnv_resize.of_Register(sle_criteria, gnv_resize.SCALE)
gnv_resize.of_Register(ddlb_criteria, gnv_resize.SCALE)

gnv_resize.of_Register(gb_1, gnv_resize.SCALE)

gnv_resize.of_Register(cb_generate, gnv_resize.SCALE)
gnv_resize.of_Register(cb_print, gnv_resize.SCALE)
gnv_resize.of_Register(cb_exit, gnv_resize.SCALE)

st_start.visible = True
em_start.visible = True
st_end.visible = True
em_end.visible = True

st_criteria.visible = True
st_criteria.text = "Name:"
sle_criteria.visible = True
ddlb_criteria.visible = False

rb_billable.checked = True

//ddlb_criteria.Reset()
//f_load_utcodesddlb(ddlb_criteria, "INV")

SetFocus(em_start)

rb_billable.pointer="arrow!"
rb_name_summary.pointer="arrow!"
rb_process.pointer="arrow!"
rb_rec_date.pointer="arrow!"
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

type cb_view from w_base_no_criteria_scan`cb_view within w_civil_fees_rpt
int TabOrder=0
boolean Visible=false
end type

type cb_print from w_base_no_criteria_scan`cb_print within w_civil_fees_rpt
int X=3215
int Y=144
int Width=315
int Height=96
int TextSize=-9
end type

event cb_print::clicked;
OpenWithParm(w_datawindow_print_dialog,dw_scan)


end event

type cb_update from w_base_no_criteria_scan`cb_update within w_civil_fees_rpt
int TabOrder=0
boolean Visible=false
end type

type dw_scan from w_base_no_criteria_scan`dw_scan within w_civil_fees_rpt
int X=29
int Y=400
int Width=3500
int Height=1462
int TabOrder=0
string DataObject="dw_billable_name_rpt"
boolean HScrollBar=true
end type

event dw_scan::doubleclicked;// Override
end event

type cb_exit from w_base_no_criteria_scan`cb_exit within w_civil_fees_rpt
int X=3215
int Y=262
int Width=315
int Height=96
int TextSize=-9
end type

type cb_delete from w_base_no_criteria_scan`cb_delete within w_civil_fees_rpt
int TabOrder=0
boolean Visible=false
end type

type cb_add from w_base_no_criteria_scan`cb_add within w_civil_fees_rpt
int TabOrder=0
boolean Visible=false
end type

type cb_generate from commandbutton within w_civil_fees_rpt
int X=3215
int Y=26
int Width=315
int Height=96
int TabOrder=50
boolean BringToTop=true
string Text="&Generate"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// script variables
string s_achSQL
integer s_iposition

string s_achStart, s_achStartYear, s_achStartMonth, s_achStartDay
integer s_iStartYear, s_iStartMonth, s_iStartDay
string s_achEnd, s_achEndYear, s_achEndMonth, s_achEndDay
integer s_iEndYear, s_iEndMonth, s_iEndDay
date s_dtStart, s_dtEnd
string s_achInvolve, s_achInvolveType
string s_achName, s_achNameDesc
string s_achOfficer, s_achDiligent, s_achOther
integer s_iDocketYear
string s_achCounty, s_achCountyDesc, s_achState, s_achStateDesc
string s_achProcess, s_achProcessDesc, s_achDocket, s_achDocketDesc
string s_achMemo, s_achMemoDesc, s_achAddress, s_achAddressDesc
string s_achEmploy, s_achEmployDesc


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

If rb_name_summary.checked = True Then
	s_achName = "%" + trim(sle_criteria.text) + "%"
	s_achNameDesc = trim(sle_criteria.text)
	
	i_achSQL = ""

	dw_scan.DataObject = "dw_fee_name_summary_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd, s_achName, s_achNameDesc, 'D') = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_rec_date.checked = True Then

	i_achSQL = ""

	dw_scan.DataObject = "dw_fee_received_date_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd, 'D') = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_billable.checked = True Then
	s_achName = "%" + trim(sle_criteria.text) + "%"
	s_achNameDesc = trim(sle_criteria.text)
	
	i_achSQL = ""

	dw_scan.DataObject = "dw_fee_billable_name_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd, s_achName, s_achNameDesc, 'D') = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_process.checked = True Then
	s_achProcess = "%" + trim(sle_criteria.text) + "%"
	s_achProcessDesc = trim(sle_criteria.text)
	
	i_achSQL = ""

	dw_scan.DataObject = "dw_fee_process_desc_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd, s_achProcessDesc, s_achProcess, 'D') = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If


end event

type em_start from editmask within w_civil_fees_rpt
int X=1847
int Y=51
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

type em_end from editmask within w_civil_fees_rpt
int X=1847
int Y=144
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

type st_end from statictext within w_civil_fees_rpt
int X=1200
int Y=154
int Width=636
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

type st_start from statictext within w_civil_fees_rpt
int X=1200
int Y=58
int Width=636
int Height=61
boolean Enabled=false
string Text="Date Rec'd - Start:"
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

type gb_1 from groupbox within w_civil_fees_rpt
int X=29
int Width=746
int Height=333
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

type rb_name_summary from radiobutton within w_civil_fees_rpt
int X=59
int Y=102
int Width=552
int Height=74
boolean BringToTop=true
string Text="Party Involved"
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

st_criteria.visible = True
st_criteria.text = "Bus./Last Name:"
sle_criteria.visible = True
ddlb_criteria.visible = False

sle_criteria.text = ""

SetFocus(em_start)
end event

type st_criteria from statictext within w_civil_fees_rpt
int X=1331
int Y=256
int Width=505
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text="Tax Year:"
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

type rb_rec_date from radiobutton within w_civil_fees_rpt
int X=59
int Y=224
int Width=706
int Height=74
boolean BringToTop=true
string Text="Received Date Range"
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

st_criteria.visible = False
st_criteria.text = "Received Date:"
sle_criteria.visible = False
ddlb_criteria.visible = False

SetFocus(em_start)
end event

type rb_billable from radiobutton within w_civil_fees_rpt
int X=59
int Y=42
int Width=552
int Height=74
boolean BringToTop=true
string Text="Billable Party"
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

st_criteria.visible = True
st_criteria.text = "Name:"
sle_criteria.visible = True
ddlb_criteria.visible = False

sle_criteria.text = ""

SetFocus(em_start)
end event

type rb_process from radiobutton within w_civil_fees_rpt
int X=59
int Y=163
int Width=552
int Height=74
boolean BringToTop=true
string Text="Process Desc."
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

st_criteria.visible = True
st_criteria.text = "Process Desc.:"
sle_criteria.visible = True
ddlb_criteria.visible = False

sle_criteria.text = ""

SetFocus(em_start)
end event

type ddlb_criteria from dropdownlistbox within w_civil_fees_rpt
int X=1847
int Y=243
int Width=951
int Height=374
int TabOrder=40
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

type sle_criteria from singlelineedit within w_civil_fees_rpt
int X=1847
int Y=243
int Width=1302
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

