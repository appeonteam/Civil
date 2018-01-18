$PBExportHeader$w_civil_general_rpt.srw
forward
global type w_civil_general_rpt from w_base_no_criteria_scan
end type
type cb_generate from commandbutton within w_civil_general_rpt
end type
type em_start from editmask within w_civil_general_rpt
end type
type em_end from editmask within w_civil_general_rpt
end type
type st_end from statictext within w_civil_general_rpt
end type
type st_start from statictext within w_civil_general_rpt
end type
type gb_1 from groupbox within w_civil_general_rpt
end type
type rb_name_summary from radiobutton within w_civil_general_rpt
end type
type rb_involve from radiobutton within w_civil_general_rpt
end type
type rb_rec_date from radiobutton within w_civil_general_rpt
end type
type rb_memo from radiobutton within w_civil_general_rpt
end type
type rb_billable from radiobutton within w_civil_general_rpt
end type
type rb_state_county from radiobutton within w_civil_general_rpt
end type
type rb_state_county_summary from radiobutton within w_civil_general_rpt
end type
type sle_state from singlelineedit within w_civil_general_rpt
end type
type st_state from statictext within w_civil_general_rpt
end type
type rb_process from radiobutton within w_civil_general_rpt
end type
type rb_serv_slip_addr from radiobutton within w_civil_general_rpt
end type
type rb_serv_slip_employ from radiobutton within w_civil_general_rpt
end type
type ddlb_criteria from dropdownlistbox within w_civil_general_rpt
end type
type st_criteria from statictext within w_civil_general_rpt
end type
type sle_county from singlelineedit within w_civil_general_rpt
end type
type sle_criteria from singlelineedit within w_civil_general_rpt
end type
type st_county from statictext within w_civil_general_rpt
end type
end forward

global type w_civil_general_rpt from w_base_no_criteria_scan
int Width=3591
int Height=2074
boolean TitleBar=true
string Title="Civil General Reports"
cb_generate cb_generate
em_start em_start
em_end em_end
st_end st_end
st_start st_start
gb_1 gb_1
rb_name_summary rb_name_summary
rb_involve rb_involve
rb_rec_date rb_rec_date
rb_memo rb_memo
rb_billable rb_billable
rb_state_county rb_state_county
rb_state_county_summary rb_state_county_summary
sle_state sle_state
st_state st_state
rb_process rb_process
rb_serv_slip_addr rb_serv_slip_addr
rb_serv_slip_employ rb_serv_slip_employ
ddlb_criteria ddlb_criteria
st_criteria st_criteria
sle_county sle_county
sle_criteria sle_criteria
st_county st_county
end type
global w_civil_general_rpt w_civil_general_rpt

type variables
string i_achreport, i_achSQL
string i_achFundNum, i_achSrcNum, i_achDeptNum
string i_achActNum, i_achProjNum, i_achObjNum
string i_achALENum

datastore ids_WfFundPercent, ids_WfFundGross
end variables

on w_civil_general_rpt.create
int iCurrent
call super::create
this.cb_generate=create cb_generate
this.em_start=create em_start
this.em_end=create em_end
this.st_end=create st_end
this.st_start=create st_start
this.gb_1=create gb_1
this.rb_name_summary=create rb_name_summary
this.rb_involve=create rb_involve
this.rb_rec_date=create rb_rec_date
this.rb_memo=create rb_memo
this.rb_billable=create rb_billable
this.rb_state_county=create rb_state_county
this.rb_state_county_summary=create rb_state_county_summary
this.sle_state=create sle_state
this.st_state=create st_state
this.rb_process=create rb_process
this.rb_serv_slip_addr=create rb_serv_slip_addr
this.rb_serv_slip_employ=create rb_serv_slip_employ
this.ddlb_criteria=create ddlb_criteria
this.st_criteria=create st_criteria
this.sle_county=create sle_county
this.sle_criteria=create sle_criteria
this.st_county=create st_county
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_generate
this.Control[iCurrent+2]=this.em_start
this.Control[iCurrent+3]=this.em_end
this.Control[iCurrent+4]=this.st_end
this.Control[iCurrent+5]=this.st_start
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.rb_name_summary
this.Control[iCurrent+8]=this.rb_involve
this.Control[iCurrent+9]=this.rb_rec_date
this.Control[iCurrent+10]=this.rb_memo
this.Control[iCurrent+11]=this.rb_billable
this.Control[iCurrent+12]=this.rb_state_county
this.Control[iCurrent+13]=this.rb_state_county_summary
this.Control[iCurrent+14]=this.sle_state
this.Control[iCurrent+15]=this.st_state
this.Control[iCurrent+16]=this.rb_process
this.Control[iCurrent+17]=this.rb_serv_slip_addr
this.Control[iCurrent+18]=this.rb_serv_slip_employ
this.Control[iCurrent+19]=this.ddlb_criteria
this.Control[iCurrent+20]=this.st_criteria
this.Control[iCurrent+21]=this.sle_county
this.Control[iCurrent+22]=this.sle_criteria
this.Control[iCurrent+23]=this.st_county
end on

on w_civil_general_rpt.destroy
call super::destroy
destroy(this.cb_generate)
destroy(this.em_start)
destroy(this.em_end)
destroy(this.st_end)
destroy(this.st_start)
destroy(this.gb_1)
destroy(this.rb_name_summary)
destroy(this.rb_involve)
destroy(this.rb_rec_date)
destroy(this.rb_memo)
destroy(this.rb_billable)
destroy(this.rb_state_county)
destroy(this.rb_state_county_summary)
destroy(this.sle_state)
destroy(this.st_state)
destroy(this.rb_process)
destroy(this.rb_serv_slip_addr)
destroy(this.rb_serv_slip_employ)
destroy(this.ddlb_criteria)
destroy(this.st_criteria)
destroy(this.sle_county)
destroy(this.sle_criteria)
destroy(this.st_county)
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
gnv_resize.of_Register(rb_involve, gnv_resize.SCALE)
gnv_resize.of_Register(rb_memo, gnv_resize.SCALE)
gnv_resize.of_Register(rb_name_summary, gnv_resize.SCALE)
gnv_resize.of_Register(rb_process, gnv_resize.SCALE)
gnv_resize.of_Register(rb_rec_date, gnv_resize.SCALE)
gnv_resize.of_Register(rb_serv_slip_addr, gnv_resize.SCALE)
gnv_resize.of_Register(rb_serv_slip_employ, gnv_resize.SCALE)
gnv_resize.of_Register(rb_state_county, gnv_resize.SCALE)
gnv_resize.of_Register(rb_state_county_summary, gnv_resize.SCALE)

gnv_resize.of_Register(st_start, gnv_resize.SCALE)
gnv_resize.of_Register(em_start, gnv_resize.SCALE)
gnv_resize.of_Register(st_end, gnv_resize.SCALE)
gnv_resize.of_Register(em_end, gnv_resize.SCALE)

gnv_resize.of_Register(st_county, gnv_resize.SCALE)
gnv_resize.of_Register(st_criteria, gnv_resize.SCALE)
gnv_resize.of_Register(st_state, gnv_resize.SCALE)
gnv_resize.of_Register(sle_county, gnv_resize.SCALE)
gnv_resize.of_Register(sle_criteria, gnv_resize.SCALE)
gnv_resize.of_Register(sle_state, gnv_resize.SCALE)
gnv_resize.of_Register(ddlb_criteria, gnv_resize.SCALE)

gnv_resize.of_Register(gb_1, gnv_resize.SCALE)

gnv_resize.of_Register(cb_generate, gnv_resize.SCALE)
gnv_resize.of_Register(cb_print, gnv_resize.SCALE)
gnv_resize.of_Register(cb_exit, gnv_resize.SCALE)

st_start.visible = True
em_start.visible = True
st_end.visible = True
em_end.visible = True

st_start.text = "Date Rec'd - Start:"

st_criteria.visible = True
st_criteria.text = "Name:"
sle_criteria.visible = True
ddlb_criteria.visible = False

rb_billable.checked = True

//ddlb_criteria.Reset()
//f_load_utcodesddlb(ddlb_criteria, "INV")

SetFocus(em_start)

rb_billable.pointer="arrow!"
rb_involve.pointer="arrow!"
rb_memo.pointer="arrow!"
rb_name_summary.pointer="arrow!"
rb_process.pointer="arrow!"
rb_rec_date.pointer="arrow!"
rb_serv_slip_addr.pointer="arrow!"
rb_serv_slip_employ.pointer="arrow!"
rb_state_county.pointer="arrow!"
rb_state_county_summary.pointer="arrow!"
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

type cb_view from w_base_no_criteria_scan`cb_view within w_civil_general_rpt
int TabOrder=0
boolean Visible=false
end type

type cb_print from w_base_no_criteria_scan`cb_print within w_civil_general_rpt
int X=3215
int Y=144
int Width=315
int Height=96
int TabOrder=80
int TextSize=-9
end type

event cb_print::clicked;
OpenWithParm(w_datawindow_print_dialog,dw_scan)


end event

type cb_update from w_base_no_criteria_scan`cb_update within w_civil_general_rpt
int TabOrder=0
boolean Visible=false
end type

type dw_scan from w_base_no_criteria_scan`dw_scan within w_civil_general_rpt
int X=29
int Y=432
int Width=3500
int Height=1430
int TabOrder=0
string DataObject="dw_billable_name_rpt"
boolean HScrollBar=true
end type

event dw_scan::doubleclicked;// Override
end event

type cb_exit from w_base_no_criteria_scan`cb_exit within w_civil_general_rpt
int X=3215
int Y=262
int Width=315
int Height=96
int TabOrder=90
int TextSize=-9
end type

type cb_delete from w_base_no_criteria_scan`cb_delete within w_civil_general_rpt
int TabOrder=0
boolean Visible=false
end type

type cb_add from w_base_no_criteria_scan`cb_add within w_civil_general_rpt
int TabOrder=0
boolean Visible=false
end type

type cb_generate from commandbutton within w_civil_general_rpt
int X=3215
int Y=26
int Width=315
int Height=96
int TabOrder=70
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

If rb_involve.checked = True Then
	s_iPosition = Pos(ddlb_criteria.text," ",1)
	s_achInvolve = String(Mid(ddlb_criteria.text,1,s_iPosition - 1))
	s_achInvolveType = Trim(String(Mid(ddlb_criteria.text,s_iPosition + 1 )))

	i_achSQL = ""

	dw_scan.DataObject = "dw_involve_type_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd, s_achInvolve, s_achInvolveType) = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_name_summary.checked = True Then
	s_achName = "%" + trim(sle_criteria.text) + "%"
	s_achNameDesc = trim(sle_criteria.text)
	
	i_achSQL = ""

	dw_scan.DataObject = "dw_name_summary_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd, s_achName, s_achNameDesc) = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_rec_date.checked = True Then

	i_achSQL = ""

	dw_scan.DataObject = "dw_received_date_rpt"
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

If rb_memo.checked = True Then

	i_achSQL = ""

	dw_scan.DataObject = "dw_memo_rpt"
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

If rb_billable.checked = True Then
	s_achName = "%" + trim(sle_criteria.text) + "%"
	s_achNameDesc = trim(sle_criteria.text)
	
	i_achSQL = ""

	dw_scan.DataObject = "dw_billable_name_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd, s_achName, s_achNameDesc) = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_state_county.checked = True Then

	s_achState = Trim(sle_state.text)
	s_achCounty = Trim(sle_county.text)
	
	If IsNull(s_achState) Then s_achState = ""
	If IsNull(s_achCounty) Then s_achCounty = ""

	s_achStateDesc = "%" + trim(s_achState) + "%"
	s_achCountyDesc = "%" + trim(s_achCounty) + "%"

	i_achSQL = ""

	dw_scan.DataObject = "dw_state_county_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd, s_achStateDesc, s_achState, s_achCountyDesc, s_achCounty) = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_state_county_summary.checked = True Then

	i_achSQL = ""

	dw_scan.DataObject = "dw_state_county_summary_rpt"
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

If rb_process.checked = True Then
	s_achProcess = "%" + trim(sle_criteria.text) + "%"
	s_achProcessDesc = trim(sle_criteria.text)
	
	i_achSQL = ""

	dw_scan.DataObject = "dw_process_desc_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd, s_achProcessDesc, s_achProcess) = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_serv_slip_addr.checked = True Then
	s_achAddress = "%" + trim(sle_criteria.text) + "%"
	s_achAddressDesc = trim(sle_criteria.text)
	
	i_achSQL = ""

	dw_scan.DataObject = "dw_service_slip_address_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_achAddress, s_achAddressDesc) = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_serv_slip_employ.checked = True Then
	s_achEmploy = "%" + trim(sle_criteria.text) + "%"
	s_achEmployDesc = trim(sle_criteria.text)
	
	i_achSQL = ""

	dw_scan.DataObject = "dw_service_slip_employed_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_achEmploy, s_achEmployDesc) = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If



end event

type em_start from editmask within w_civil_general_rpt
int X=1883
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

type em_end from editmask within w_civil_general_rpt
int X=1883
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

type st_end from statictext within w_civil_general_rpt
int X=1368
int Y=128
int Width=505
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

type st_start from statictext within w_civil_general_rpt
int X=1368
int Y=32
int Width=505
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

type gb_1 from groupbox within w_civil_general_rpt
int X=29
int Width=1324
int Height=397
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

type rb_name_summary from radiobutton within w_civil_general_rpt
int X=59
int Y=230
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

st_start.text = "Date Rec'd - Start:"

st_criteria.visible = True
st_criteria.text = "Bus./Last Name:"
sle_criteria.visible = True
ddlb_criteria.visible = False

sle_criteria.text = ""

st_state.visible = False
sle_state.visible = False
st_county.visible = False
sle_county.visible = False

SetFocus(em_start)
end event

type rb_involve from radiobutton within w_civil_general_rpt
int X=59
int Y=109
int Width=552
int Height=74
boolean BringToTop=true
string Text="Involvement Type"
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

st_start.text = "Date Rec'd - Start:"

st_criteria.visible = True
st_criteria.text = "Involvement:"
sle_criteria.visible = False
ddlb_criteria.visible = True

ddlb_criteria.Reset()
f_load_utcodesddlb(ddlb_criteria, "INV")

st_state.visible = False
sle_state.visible = False
st_county.visible = False
sle_county.visible = False

SetFocus(em_start)
end event

type rb_rec_date from radiobutton within w_civil_general_rpt
int X=622
int Y=48
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

st_start.text = "Date Rec'd - Start:"

st_criteria.visible = False
st_criteria.text = "Received Date:"
sle_criteria.visible = False
ddlb_criteria.visible = False

st_state.visible = False
sle_state.visible = False
st_county.visible = False
sle_county.visible = False

SetFocus(em_start)
end event

type rb_memo from radiobutton within w_civil_general_rpt
int X=59
int Y=170
int Width=552
int Height=74
boolean BringToTop=true
string Text="Memo"
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

st_start.text = "Memo Date - Start:"

st_criteria.visible = False
st_criteria.text = "Memo Desc:"
sle_criteria.visible = False
ddlb_criteria.visible = False

st_state.visible = False
sle_state.visible = False
st_county.visible = False
sle_county.visible = False

SetFocus(em_start)
end event

type rb_billable from radiobutton within w_civil_general_rpt
int X=59
int Y=48
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

st_start.text = "Date Rec'd - Start:"

st_criteria.visible = True
st_criteria.text = "Name:"
sle_criteria.visible = True
ddlb_criteria.visible = False

sle_criteria.text = ""

st_state.visible = False
sle_state.visible = False
st_county.visible = False
sle_county.visible = False

SetFocus(em_start)
end event

type rb_state_county from radiobutton within w_civil_general_rpt
int X=622
int Y=109
int Width=706
int Height=74
boolean BringToTop=true
string Text="State / County"
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

st_start.text = "Date Rec'd - Start:"

st_criteria.visible = False
st_criteria.text = "Received Date:"
sle_criteria.visible = False
ddlb_criteria.visible = False

st_state.visible = True
sle_state.visible = True
st_county.visible = True
sle_county.visible = True

sle_state.text = ""
sle_county.text = ""

SetFocus(em_start)
end event

type rb_state_county_summary from radiobutton within w_civil_general_rpt
int X=622
int Y=170
int Width=706
int Height=74
boolean BringToTop=true
string Text="State / County Summary"
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

st_start.text = "Date Rec'd - Start:"

st_criteria.visible = False
st_criteria.text = "Received Date:"
sle_criteria.visible = False
ddlb_criteria.visible = False

st_state.visible = False
sle_state.visible = False
st_county.visible = False
sle_county.visible = False

SetFocus(em_start)
end event

type sle_state from singlelineedit within w_civil_general_rpt
int X=1883
int Y=218
int Width=622
int Height=80
int TabOrder=50
boolean Visible=false
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_state from statictext within w_civil_general_rpt
int X=1368
int Y=230
int Width=505
int Height=61
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="State:"
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

type rb_process from radiobutton within w_civil_general_rpt
int X=59
int Y=291
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

st_start.text = "Date Rec'd - Start:"

st_criteria.visible = True
st_criteria.text = "Process Desc.:"
sle_criteria.visible = True
ddlb_criteria.visible = False

sle_criteria.text = ""

st_state.visible = False
sle_state.visible = False
st_county.visible = False
sle_county.visible = False

SetFocus(em_start)
end event

type rb_serv_slip_addr from radiobutton within w_civil_general_rpt
int X=622
int Y=230
int Width=706
int Height=74
boolean BringToTop=true
string Text="Service Slip - Address"
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

st_criteria.visible = True
st_criteria.text = "Address:"
sle_criteria.visible = True
ddlb_criteria.visible = False

sle_criteria.text = ""

st_state.visible = False
sle_state.visible = False
st_county.visible = False
sle_county.visible = False

SetFocus(sle_criteria)
end event

type rb_serv_slip_employ from radiobutton within w_civil_general_rpt
int X=622
int Y=291
int Width=706
int Height=74
boolean BringToTop=true
string Text="Service Slip - Employed"
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

st_criteria.visible = True
st_criteria.text = "Employed:"
sle_criteria.visible = True
ddlb_criteria.visible = False

sle_criteria.text = ""

st_state.visible = False
sle_state.visible = False
st_county.visible = False
sle_county.visible = False

SetFocus(sle_criteria)
end event

type ddlb_criteria from dropdownlistbox within w_civil_general_rpt
int X=1883
int Y=218
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

type st_criteria from statictext within w_civil_general_rpt
int X=1368
int Y=230
int Width=505
int Height=61
boolean Enabled=false
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

type sle_county from singlelineedit within w_civil_general_rpt
int X=1883
int Y=317
int Width=1097
int Height=80
int TabOrder=60
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_criteria from singlelineedit within w_civil_general_rpt
int X=1883
int Y=218
int Width=1276
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

type st_county from statictext within w_civil_general_rpt
int X=1368
int Y=330
int Width=505
int Height=61
boolean Visible=false
boolean Enabled=false
string Text="County:"
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

