$PBExportHeader$w_civil_posting_rpt.srw
forward
global type w_civil_posting_rpt from w_base_no_criteria_scan
end type
type cb_generate from commandbutton within w_civil_posting_rpt
end type
type em_start from editmask within w_civil_posting_rpt
end type
type em_end from editmask within w_civil_posting_rpt
end type
type st_end from statictext within w_civil_posting_rpt
end type
type st_start from statictext within w_civil_posting_rpt
end type
type gb_1 from groupbox within w_civil_posting_rpt
end type
type st_criteria from statictext within w_civil_posting_rpt
end type
type st_criteria2 from statictext within w_civil_posting_rpt
end type
type sle_criteria from singlelineedit within w_civil_posting_rpt
end type
type sle_criteria2 from singlelineedit within w_civil_posting_rpt
end type
type rb_posting_recnum from radiobutton within w_civil_posting_rpt
end type
type rb_posting_feetype from radiobutton within w_civil_posting_rpt
end type
type rb_rec_post from radiobutton within w_civil_posting_rpt
end type
type rb_rec_unposted from radiobutton within w_civil_posting_rpt
end type
type rb_posting_total_feetype from radiobutton within w_civil_posting_rpt
end type
type ddlb_criteria from dropdownlistbox within w_civil_posting_rpt
end type
type rb_rec_post_summary from radiobutton within w_civil_posting_rpt
end type
end forward

global type w_civil_posting_rpt from w_base_no_criteria_scan
int Width=3591
int Height=2074
boolean TitleBar=true
string Title="Civil Posting Reports"
cb_generate cb_generate
em_start em_start
em_end em_end
st_end st_end
st_start st_start
gb_1 gb_1
st_criteria st_criteria
st_criteria2 st_criteria2
sle_criteria sle_criteria
sle_criteria2 sle_criteria2
rb_posting_recnum rb_posting_recnum
rb_posting_feetype rb_posting_feetype
rb_rec_post rb_rec_post
rb_rec_unposted rb_rec_unposted
rb_posting_total_feetype rb_posting_total_feetype
ddlb_criteria ddlb_criteria
rb_rec_post_summary rb_rec_post_summary
end type
global w_civil_posting_rpt w_civil_posting_rpt

type variables
string i_achreport, i_achSQL
string i_achFundNum, i_achSrcNum, i_achDeptNum
string i_achActNum, i_achProjNum, i_achObjNum
string i_achALENum

datastore ids_WfFundPercent, ids_WfFundGross
end variables

on w_civil_posting_rpt.create
int iCurrent
call super::create
this.cb_generate=create cb_generate
this.em_start=create em_start
this.em_end=create em_end
this.st_end=create st_end
this.st_start=create st_start
this.gb_1=create gb_1
this.st_criteria=create st_criteria
this.st_criteria2=create st_criteria2
this.sle_criteria=create sle_criteria
this.sle_criteria2=create sle_criteria2
this.rb_posting_recnum=create rb_posting_recnum
this.rb_posting_feetype=create rb_posting_feetype
this.rb_rec_post=create rb_rec_post
this.rb_rec_unposted=create rb_rec_unposted
this.rb_posting_total_feetype=create rb_posting_total_feetype
this.ddlb_criteria=create ddlb_criteria
this.rb_rec_post_summary=create rb_rec_post_summary
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_generate
this.Control[iCurrent+2]=this.em_start
this.Control[iCurrent+3]=this.em_end
this.Control[iCurrent+4]=this.st_end
this.Control[iCurrent+5]=this.st_start
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.st_criteria
this.Control[iCurrent+8]=this.st_criteria2
this.Control[iCurrent+9]=this.sle_criteria
this.Control[iCurrent+10]=this.sle_criteria2
this.Control[iCurrent+11]=this.rb_posting_recnum
this.Control[iCurrent+12]=this.rb_posting_feetype
this.Control[iCurrent+13]=this.rb_rec_post
this.Control[iCurrent+14]=this.rb_rec_unposted
this.Control[iCurrent+15]=this.rb_posting_total_feetype
this.Control[iCurrent+16]=this.ddlb_criteria
this.Control[iCurrent+17]=this.rb_rec_post_summary
end on

on w_civil_posting_rpt.destroy
call super::destroy
destroy(this.cb_generate)
destroy(this.em_start)
destroy(this.em_end)
destroy(this.st_end)
destroy(this.st_start)
destroy(this.gb_1)
destroy(this.st_criteria)
destroy(this.st_criteria2)
destroy(this.sle_criteria)
destroy(this.sle_criteria2)
destroy(this.rb_posting_recnum)
destroy(this.rb_posting_feetype)
destroy(this.rb_rec_post)
destroy(this.rb_rec_unposted)
destroy(this.rb_posting_total_feetype)
destroy(this.ddlb_criteria)
destroy(this.rb_rec_post_summary)
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
gnv_resize.of_Register(rb_posting_feetype, gnv_resize.SCALE)
gnv_resize.of_Register(rb_posting_recnum, gnv_resize.SCALE)
gnv_resize.of_Register(rb_posting_total_feetype, gnv_resize.SCALE)
gnv_resize.of_Register(rb_rec_post, gnv_resize.SCALE)
gnv_resize.of_Register(rb_rec_post_summary, gnv_resize.SCALE)
gnv_resize.of_Register(rb_rec_unposted, gnv_resize.SCALE)

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

st_start.text = "Date Rec'd - Start:"

st_criteria.visible = False
st_criteria.text = ""
st_criteria2.visible = False
st_criteria2.text = ""
sle_criteria.visible = False
sle_criteria2.visible = False
ddlb_criteria.visible = False

rb_rec_unposted.checked = True

//ddlb_criteria.Reset()
//f_load_utcodesddlb(ddlb_criteria, "INV")

SetFocus(em_start)

rb_posting_feetype.pointer="arrow!"
rb_posting_recnum.pointer="arrow!"
rb_posting_total_feetype.pointer="arrow!"
rb_rec_post.pointer="arrow!"
rb_rec_post_summary.pointer="arrow!"
rb_rec_unposted.pointer="arrow!"
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

type cb_view from w_base_no_criteria_scan`cb_view within w_civil_posting_rpt
int TabOrder=0
boolean Visible=false
end type

type cb_print from w_base_no_criteria_scan`cb_print within w_civil_posting_rpt
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

type cb_update from w_base_no_criteria_scan`cb_update within w_civil_posting_rpt
int TabOrder=0
boolean Visible=false
end type

type dw_scan from w_base_no_criteria_scan`dw_scan within w_civil_posting_rpt
int X=29
int Y=384
int Width=3500
int Height=1469
int TabOrder=0
string DataObject="dw_receipt_date_rpt"
boolean HScrollBar=true
end type

event dw_scan::doubleclicked;// Override
end event

type cb_exit from w_base_no_criteria_scan`cb_exit within w_civil_posting_rpt
int X=3215
int Y=262
int Width=315
int Height=96
int TabOrder=80
int TextSize=-9
end type

type cb_delete from w_base_no_criteria_scan`cb_delete within w_civil_posting_rpt
int TabOrder=0
boolean Visible=false
end type

type cb_add from w_base_no_criteria_scan`cb_add within w_civil_posting_rpt
int TabOrder=0
boolean Visible=false
end type

type cb_generate from commandbutton within w_civil_posting_rpt
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
datetime s_dtStartDateTime, s_dtEndDateTime
integer s_iDocketYear
string s_achLastName, s_achFirstName, s_achFeeType, s_achRecType
long s_lBegReceipt, s_lEndReceipt

SetPointer(HourGlass!)

s_achStart = String(em_start.text)
s_achStartYear = Mid(s_achStart,7,4)
s_achStartMonth = Mid(s_achStart,1,2)
s_achStartDay = Mid(s_achStart,4,2)
s_iStartYear = Integer(s_achStartYear)
s_iStartMonth = Integer(s_achStartMonth)
s_iStartDay = Integer(s_achStartDay)
s_dtStart = Date(s_iStartYear, s_iStartMonth, s_iStartDay)
s_dtStartDateTime = DateTime(s_dtStart)

s_achEnd = String(em_end.text)
s_achEndYear = Mid(s_achEnd,7,4)
s_achEndMonth = Mid(s_achEnd,1,2)
s_achEndDay = Mid(s_achEnd,4,2)
s_iEndYear = Integer(s_achEndYear)
s_iEndMonth = Integer(s_achEndMonth)
s_iEndDay = Integer(s_achEndDay)
s_dtEnd = Date(s_iEndYear, s_iEndMonth, s_iEndDay)
s_dtEndDateTime = DateTime(s_dtEnd)

SetPointer(HourGlass!)

/*
If rb_rec_fee_post.checked = True Then
	i_achSQL = ""

	dw_scan.DataObject = "dw_receipt_feetype_posting_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd, s_dtStartDateTime, s_dtEndDateTime, 'FEE') = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If
*/

If rb_posting_recnum.checked = True Then
	s_lBegReceipt = long(sle_criteria.text) 
	s_lEndReceipt = long(sle_criteria2.text)
	
	i_achSQL = ""

	dw_scan.DataObject = "dw_receipt_posting_recnum_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_lBegReceipt, s_lEndReceipt) = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_posting_feetype.checked = True Then
	s_lBegReceipt = long(sle_criteria.text) 
	s_lEndReceipt = long(sle_criteria2.text)
	
	i_achSQL = ""

	dw_scan.DataObject = "dw_receipt_posting_feetype_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_lBegReceipt, s_lEndReceipt, 'FEE') = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_posting_total_feetype.checked = True Then
	s_lBegReceipt = long(sle_criteria.text) 
	s_lEndReceipt = long(sle_criteria2.text)
	
	i_achSQL = ""

	dw_scan.DataObject = "dw_receipt_posting_feetypetotal_rpt"
	i_achSQL = dw_scan.GetSQLSelect()
	s_achSQL = i_achSQL + s_achSQL
	
	dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
		
	dw_scan.SetTransObject(SQLCA)
	dw_scan.Reset()
	If dw_scan.Retrieve(s_dtStart, s_dtEnd, 'FEE') = 0 Then
		MessageBox("Complete", "No Rows Found.")
		dw_scan.SetFocus()
	Else
		dw_scan.SetFocus()
	End If
End If

If rb_rec_post.checked = True Then
	i_achSQL = ""

	dw_scan.DataObject = "dw_receipt_post_date_rpt"
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

If rb_rec_post_summary.checked = True Then
	i_achSQL = ""

	dw_scan.DataObject = "dw_receipt_post_date_summary_rpt"
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

If rb_rec_unposted.checked = True Then
	i_achSQL = ""

	dw_scan.DataObject = "dw_receipt_unposted_rpt"
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

type em_start from editmask within w_civil_posting_rpt
int X=2187
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

type em_end from editmask within w_civil_posting_rpt
int X=2187
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

type st_end from statictext within w_civil_posting_rpt
int X=1646
int Y=128
int Width=530
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

type st_start from statictext within w_civil_posting_rpt
int X=1646
int Y=32
int Width=530
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

type gb_1 from groupbox within w_civil_posting_rpt
int X=29
int Width=1507
int Height=250
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

type st_criteria from statictext within w_civil_posting_rpt
int X=1646
int Y=227
int Width=530
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

type st_criteria2 from statictext within w_civil_posting_rpt
int X=2582
int Y=227
int Width=44
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text="Criteria2"
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

type sle_criteria from singlelineedit within w_civil_posting_rpt
int X=2187
int Y=214
int Width=388
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

type sle_criteria2 from singlelineedit within w_civil_posting_rpt
int X=2637
int Y=214
int Width=388
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

type rb_posting_recnum from radiobutton within w_civil_posting_rpt
int X=746
int Y=38
int Width=772
int Height=74
boolean BringToTop=true
string Text="Posting Report By Rec #"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
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
st_criteria.text = "Receipt Range:"
st_criteria2.visible = True
st_criteria2.text = "-"
sle_criteria.visible = True
//sle_criteria.text = ""
sle_criteria2.visible = True
//sle_criteria2.text = ""

ddlb_criteria.visible = False

SetFocus(sle_criteria)

end event

type rb_posting_feetype from radiobutton within w_civil_posting_rpt
int X=746
int Y=99
int Width=772
int Height=74
boolean BringToTop=true
string Text="Posting Report By Fee"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
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
st_criteria.text = "Receipt Range:"
st_criteria2.visible = True
st_criteria2.text = "-"
sle_criteria.visible = True
//sle_criteria.text = ""
sle_criteria2.visible = True
//sle_criteria2.text = ""

ddlb_criteria.visible = False

SetFocus(sle_criteria)

end event

type rb_rec_post from radiobutton within w_civil_posting_rpt
int X=55
int Y=99
int Width=669
int Height=74
boolean BringToTop=true
string Text="Post Date - Detail"
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

st_start.text = "Date Posted - Start:"

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

type rb_rec_unposted from radiobutton within w_civil_posting_rpt
int X=55
int Y=38
int Width=669
int Height=74
boolean BringToTop=true
string Text="Unposted Receipts"
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

type rb_posting_total_feetype from radiobutton within w_civil_posting_rpt
int X=746
int Y=160
int Width=772
int Height=74
boolean BringToTop=true
string Text="Post Rpt Totals By Fee"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
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

st_start.text = "Date Posted - Start:"

st_criteria.visible = False
st_criteria.text = "Beg. Receipt #:"
st_criteria2.visible = False
st_criteria2.text = "End Receipt #:"
sle_criteria.visible = False
sle_criteria.text = ""
sle_criteria2.visible = False
sle_criteria2.text = ""

ddlb_criteria.visible = False

SetFocus(em_start)

end event

type ddlb_criteria from dropdownlistbox within w_civil_posting_rpt
int X=2187
int Y=214
int Width=516
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

type rb_rec_post_summary from radiobutton within w_civil_posting_rpt
int X=55
int Y=160
int Width=669
int Height=74
boolean BringToTop=true
string Text="Post Date - Summary"
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

st_start.text = "Date Posted - Start:"

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

