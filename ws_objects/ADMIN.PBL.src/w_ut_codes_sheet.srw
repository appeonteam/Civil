$PBExportHeader$w_ut_codes_sheet.srw
forward
global type w_ut_codes_sheet from w_base_sheet
end type
type cb_code from commandbutton within w_ut_codes_sheet
end type
type st_1 from statictext within w_ut_codes_sheet
end type
type sle_type from singlelineedit within w_ut_codes_sheet
end type
type dw_code_list from datawindow within w_ut_codes_sheet
end type
end forward

global type w_ut_codes_sheet from w_base_sheet
int Width=3690
int Height=2067
boolean TitleBar=true
string Title="General Codes"
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowState WindowState=normal!
cb_code cb_code
st_1 st_1
sle_type sle_type
dw_code_list dw_code_list
end type
global w_ut_codes_sheet w_ut_codes_sheet

type variables
string i_achSaveSQL
end variables

on w_ut_codes_sheet.create
int iCurrent
call super::create
this.cb_code=create cb_code
this.st_1=create st_1
this.sle_type=create sle_type
this.dw_code_list=create dw_code_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_code
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_type
this.Control[iCurrent+4]=this.dw_code_list
end on

on w_ut_codes_sheet.destroy
call super::destroy
destroy(this.cb_code)
destroy(this.st_1)
destroy(this.sle_type)
destroy(this.dw_code_list)
end on

event open;//this.Height = dw_detail.Height + 1700

i_achSQL = dw_scan.GetSQLSelect()
dw_scan.SetTransObject(SQLCA)

gnv_resize = create n_cst_resize
gnv_resize.of_SetOrigSize (this.Width, this.Height )
gnv_resize.of_Register(dw_scan, gnv_resize.SCALE)
gnv_resize.of_Register(dw_detail, gnv_resize.SCALE)
gnv_resize.of_Register(dw_code_list, gnv_resize.SCALE)
gnv_resize.of_Register(st_1, gnv_resize.SCALE)
gnv_resize.of_Register(sle_type, gnv_resize.SCALE)

gnv_resize.of_Register(cb_add, gnv_resize.SCALE)
gnv_resize.of_Register(cb_back, gnv_resize.SCALE)
gnv_resize.of_Register(cb_clear, gnv_resize.SCALE)
gnv_resize.of_Register(cb_delete, gnv_resize.SCALE)
gnv_resize.of_Register(cb_detail, gnv_resize.SCALE)
gnv_resize.of_Register(cb_escape, gnv_resize.SCALE)
gnv_resize.of_Register(cb_exit, gnv_resize.SCALE)
gnv_resize.of_Register(cb_first, gnv_resize.SCALE)
gnv_resize.of_Register(cb_last, gnv_resize.SCALE)
gnv_resize.of_Register(cb_list, gnv_resize.SCALE)
gnv_resize.of_Register(cb_new, gnv_resize.SCALE)
gnv_resize.of_Register(cb_next, gnv_resize.SCALE)
gnv_resize.of_Register(cb_save, gnv_resize.SCALE)
gnv_resize.of_Register(cb_search, gnv_resize.SCALE)
gnv_resize.of_Register(cb_update, gnv_resize.SCALE)

gnv_resize.of_Register(gb_1, gnv_resize.SCALE)
gnv_resize.of_Register(gb_2, gnv_resize.SCALE)
gnv_resize.of_Register(gb_3, gnv_resize.SCALE)
gnv_resize.of_Register(gb_4, gnv_resize.SCALE)
gnv_resize.of_Register(gb_5, gnv_resize.SCALE)

SetPointer(HourGlass!)

dw_code_list.SetTransObject(SQLCA)
dw_code_list.Reset()
dw_code_list.SetRowFocusIndicator(Hand!)
dw_code_list.Retrieve()

dw_scan.SetTransObject(SQLCA)
dw_scan.Reset()
dw_scan.SetRowFocusIndicator(Hand!)

sle_type.SetFocus()
end event

event ue_search;call super::ue_search;string s_achDWColor
integer s_sRow

s_achDWColor = dw_detail.Describe("datawindow.color")

m_main.m_general.m_add.enabled = False

// Security - New General Codes
If w_main.dw_perms.Find("code=14", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_new.enabled = True
	m_main.m_general.m_new.enabled = True
End If

// Security - Update General Codes
If w_main.dw_perms.Find("code=15", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_update.enabled = True	
	m_main.m_general.m_update.enabled = True
End If

// Security - Delete General Codes
If w_main.dw_perms.Find("code=16", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_delete.enabled = True	
	m_main.m_general.m_delete.enabled = True
End If

dw_detail.SetRedraw(False)
dw_detail.Modify("code.background.color = " + s_achDWColor + & 
	" code.tabsequence = 0" + &		
	" description.background.color = " + s_achDWColor + & 
	" description.tabsequence = 0" + &
	" disbursed_type.background.color = " + s_achDWColor + & 
	" disbursed_type.tabsequence = 0")			
dw_detail.SetRedraw(True)

SetPointer(HourGlass!)

dw_code_list.SetTransObject(SQLCA)
dw_code_list.Reset()
dw_code_list.SetRowFocusIndicator(Hand!)
dw_code_list.Retrieve()

dw_scan.SetTransObject(SQLCA)
dw_scan.Reset()
dw_scan.SetRowFocusIndicator(Hand!)

// find the row closest to this one
s_sRow = dw_code_list.Find("description >= '" + Trim(sle_type.text) + "'", 0, dw_code_list.RowCount())

If s_sRow = 0 Then s_sRow = 1

// highlight only the closest row
dw_code_list.SetRow(s_sRow)
dw_code_list.ScrollToRow(s_sRow)

dw_scan.Reset()
If 0 = dw_scan.Retrieve(Trim(dw_code_list.GetItemString(dw_code_list.GetRow(), "code"))) Then
	sle_type.SetFocus()
Else
	dw_scan.SetFocus()
End If

i_achSaveSQL = i_achSQL
end event

event ue_clear;call super::ue_clear;sle_type.text = ""

cb_first.enabled = False
m_main.m_general.m_first.enabled = False
cb_back.enabled = False
m_main.m_general.m_back.enabled = False
cb_next.enabled = False
m_main.m_general.m_next.enabled = False
cb_last.enabled = False
m_main.m_general.m_last.enabled = False

sle_type.SetFocus()
end event

event ue_save;call super::ue_save;
string s_achDWColor

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_ut_code_detail"

		m_main.m_general.m_first.enabled = False
		m_main.m_general.m_back.enabled = False
		m_main.m_general.m_next.enabled = False
		m_main.m_general.m_last.enabled = False

		If i_iValFlag = 0 Then
			dw_detail.SetRedraw(False)
			dw_detail.Modify("code.background.color = " + s_achDWColor + & 
				" code.tabsequence = 0" + &		
				" description.background.color = " + s_achDWColor + & 
				" description.tabsequence = 0" + &
				" disbursed_type.background.color = " + s_achDWColor + & 
				" disbursed_type.tabsequence = 0")			
			dw_detail.SetRedraw(True)
			dw_scan.enabled = True			
			integer s_iRow
			If i_achOpType = "Add" Then
				string s_achCode, s_achCodeType

				i_iRow = dw_detail.GetRow()

				s_achCodeType = Trim(dw_detail.GetItemString(i_iRow,"code_type"))
				s_achCode = Trim(dw_detail.GetItemString(i_iRow,"code"))
				
				dw_scan.SetTransObject(SQLCA)
				dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
				dw_scan.Retrieve(s_achCodeType) 			

				// find the row closest to this one
				s_iRow = dw_scan.Find("code_type = '" + s_achCodeType + &
					"' AND code ='" + s_achCode + "'", 0, dw_scan.RowCount())

				If s_iRow = 0 Then s_iRow = 1

				// highlight only the closest row
				dw_scan.ScrollToRow(s_iRow)				
				dw_scan.SetRowFocusIndicator(Hand!)				
				
			End If				
			dw_scan.enabled = True
			
			// Security - Add General Codes
			If w_main.dw_perms.Find("code=14", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_new.enabled = True				
				m_main.m_general.m_new.enabled = True
			End If
			
			// Security - Update General Codes
			If w_main.dw_perms.Find("code=15", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_update.enabled = True				
				m_main.m_general.m_update.enabled = True
			End If
			
			// Security - Delete General Codes
			If w_main.dw_perms.Find("code=16", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_delete.enabled = True				
				m_main.m_general.m_delete.enabled = True
			End If
			
			cb_save.enabled = False
			m_main.m_general.m_save.enabled = False
			
		End If			
		
End Choose

dw_detail.SetFocus()

end event

event ue_update;call super::ue_update;
string s_achDWColor

s_achDWColor = dw_scan.Describe("datawindow.color")

dw_detail.SetRedraw(False)
dw_detail.Modify("description.background.color = " + s_achDWColor + & 
	" description.tabsequence = 2" + &
	" disbursed_type.background.color = " + s_achDWColor + & 
	" disbursed_type.tabsequence = 3")					
	
dw_detail.SetColumn("code")
dw_detail.SetRedraw(True)
dw_detail.SetFocus()


end event

event ue_add;// nothing
end event

event ue_new;call super::ue_new;
string s_achDWColor

s_achDWColor = dw_scan.Describe("datawindow.color")

SetPointer(Hourglass!)

cb_new.enabled = False
m_main.m_general.m_new.enabled = False
cb_add.enabled = False
m_main.m_general.m_add.enabled = False
cb_delete.enabled = False
m_main.m_general.m_delete.enabled = False
cb_update.enabled = False
m_main.m_general.m_update.enabled = False

i_achOpType = "Add"

// Security - New General Codes
If w_main.dw_perms.Find("code=14", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

// Security - Update General Codes
If w_main.dw_perms.Find("code=15", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

// Security - Delete General Codes
If w_main.dw_perms.Find("code=16", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

Choose Case dw_detail.DataObject
	Case "dw_ut_code_detail"

		i_iRow = dw_scan.GetRow()

		dw_detail.Tag = "General Code Information"		
		dw_detail.Reset()
		dw_detail.InsertRow(0)
		dw_detail.SetItem(1,"code_type", dw_scan.GetItemString(i_iRow, "code_type"))	
		dw_detail.SetItem(1,"code_year", 2004)	
		dw_detail.SetItem(1,"code", "")	
		dw_detail.SetItem(1,"description", "")	
		dw_detail.SetItem(1,"disbursed_type", "")	
		dw_detail.SetItem(1,"code_no",0)
		dw_detail.SetRedraw(False)	
		dw_detail.Modify("code.background.color = " + s_achDWColor + & 
			" code.tabsequence = 1" + &		
			" description.background.color = " + s_achDWColor + & 
			" description.tabsequence = 2" + &
			" disbursed_type.background.color = " + s_achDWColor + & 
			" disbursed_type.tabsequence = 3")			
		dw_detail.SetRedraw(True)
		
		dw_detail.SetFocus()				
End Choose	
end event

event ue_val_fields;
integer s_iRowCount, s_iCount

dw_detail.SetTransObject(SQLCA)
dw_detail.AcceptText()
Choose Case dw_detail.DataObject
	
	Case "dw_ut_code_detail"
		
		If IsNull(dw_detail.GetItemString(1,"code")) Or (dw_detail.GetItemString(1,"code") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "General code must be entered!")
			dw_detail.SetColumn("code")
			dw_detail.SetFocus()
			Return
		End If	
		
		If IsNull(dw_detail.GetItemString(1,"description")) Or (dw_detail.GetItemString(1,"description") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Description must be entered!")
			dw_detail.SetColumn("description")
			dw_detail.SetFocus()
			Return
		End If	

End Choose		

integer s_iCodeNum
string s_achOldCode, s_achCode, s_achCodeType, s_achErrText
	
Choose Case dw_detail.DataObject
	Case "dw_ut_code_detail"
		i_iRow = dw_detail.GetRow()

		s_achOldCode = dw_detail.GetItemString(i_iRow, "code", Primary!, True)
		s_achCode = dw_detail.GetItemString(i_iRow, "code")
		s_achCodeType = dw_detail.GetItemString(i_iRow, "code_type")		
		dw_detail.SetItem(i_iRow, "code", Upper(s_achCode))		
		
		If i_achOpType = "Add" Then		
			SELECT MAX("code_no") INTO :s_iCodeNum
				FROM ut_codes;
			
			If IsNull(s_iCodeNum) Then s_iCodeNum = 0			
			s_iCodeNum ++
			dw_detail.SetItem(i_iRow, "code_no", s_iCodeNum)			
		End If

End Choose	

end event

event ue_delete;// script variables
string s_achErrText, s_achCode, s_achCodeType
integer s_iCount

i_achOpType = "Delete"
i_iValFlag = 0

cb_new.enabled = False
m_main.m_general.m_new.enabled = False
cb_add.enabled = False
m_main.m_general.m_add.enabled = False
cb_update.enabled = False
m_main.m_general.m_update.enabled = False
cb_delete.enabled = False
m_main.m_general.m_delete.enabled = False

Choose Case dw_detail.DataObject
	Case "dw_ut_code_detail"
		
		m_main.m_general.m_first.enabled = False					
		m_main.m_general.m_back.enabled = False
		m_main.m_general.m_next.enabled = False
		m_main.m_general.m_last.enabled = False

		If dw_detail.RowCount() = 0 Then
		   MessageBox("Error","Select Row to Delete",StopSign!)
		Else
		   If 2 = MessageBox("Delete","Delete This Code?",Question!,OkCancel!,2) Then
		      MessageBox("Delete","Code NOT Deleted",None!)
		   Else
		
				SetPointer(Hourglass!) 
				
				i_iRow = dw_detail.GetRow()				
				s_achCode = Trim(dw_detail.getItemString(i_iRow,"code"))
				s_achCodeType = Trim(dw_detail.getItemString(i_iRow,"code_type"))
		
				If s_achCodeType = 'EYE' Then
					SELECT COUNT(*) INTO :s_iCount
						FROM lic_inventory
						WHERE lic_inventory.eye_color = :s_achCode;
					If s_iCount > 0 Then
						i_ivalflag = 1 												
						MessageBox("General Codes Information", "Eye Color Type Delete Failed", Information!)
						ROLLBACK;						
					End If					
				End If		
		
				If s_achCodeType = 'STATE' Then
					SELECT COUNT(*) INTO :s_iCount
						FROM lic_inventory
						WHERE lic_inventory.state = :s_achCode;
					If s_iCount > 0 Then
						i_iValFlag = 1						
						MessageBox("General Codes Information", "State Code Type Delete Failed", Information!)
						ROLLBACK;						
					End If					
				End If					

				dw_detail.DeleteRow(i_iRow) 
				If i_iValFlag = 1 Or dw_detail.Update(False, False) = -1 Then
					
					ROLLBACK;
					
					// make the scan think the row changed so it will fill
					// the detail back in
					dw_scan.PostEvent(RowFocusChanged!)
					
				Else
					COMMIT;
					If SQLCA.SQLCode = -1 Then
						s_achErrText = SQLCA.SQLErrText
						ROLLBACK;
						MessageBox("Error", "Delete Failed - " + s_achErrText)
						
						// take this row off the list
						dw_scan.DeleteRow(dw_scan.GetRow())
						
						// reset the update flags
						dw_scan.ResetUpdate()
						dw_detail.ResetUpdate()
						
					Else
						// take this row off the list
						dw_scan.DeleteRow(dw_scan.GetRow())
		
						// reset the update flags
						dw_scan.ResetUpdate()
						dw_detail.ResetUpdate()
						dw_detail.Title = dw_detail.Tag + " " + "Record " + String(dw_detail.GetRow()) + " of " + String(dw_detail.RowCount()) + "."												
					End If
				End If
			End If
		End If

End Choose

end event

event resize;gnv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
end event

type cb_first from w_base_sheet`cb_first within w_ut_codes_sheet
int TabOrder=110
end type

type cb_save from w_base_sheet`cb_save within w_ut_codes_sheet
int TabOrder=80
end type

type cb_delete from w_base_sheet`cb_delete within w_ut_codes_sheet
int TabOrder=70
end type

type cb_update from w_base_sheet`cb_update within w_ut_codes_sheet
int TabOrder=60
end type

type cb_add from w_base_sheet`cb_add within w_ut_codes_sheet
int TabOrder=50
end type

type cb_new from w_base_sheet`cb_new within w_ut_codes_sheet
int TabOrder=40
end type

type cb_clear from w_base_sheet`cb_clear within w_ut_codes_sheet
int TabOrder=30
end type

type cb_search from w_base_sheet`cb_search within w_ut_codes_sheet
int TabOrder=20
end type

type dw_detail from w_base_sheet`dw_detail within w_ut_codes_sheet
event ue_dwnkey pbm_dwnkey
int Y=1197
int Width=2604
int Height=602
int TabOrder=180
string DataObject="dw_ut_code_detail"
end type

event dw_detail::ue_dwnkey;string s_achDWColor
integer s_iRow

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_ut_code_detail"
		
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "disbursed_type"
				If KeyDown(KeyEnter!) Or KeyDown(KeyTab!) Then		
					parent.TriggerEvent("ue_save")
					Return
				End If
	
		End Choose 
End Choose 
end event

event dw_detail::getfocus;call super::getfocus;///dw_detail.SetSort("code A")
//dw_detail.Sort()
end event

event dw_detail::doubleclicked;call super::doubleclicked;//i_irow = dw_detail.GetRow()
//
//dw_detail.SetTransObject(SQLCA)
//dw_detail.Reset()
//If i_irow > 0 Then
//	dw_detail.Retrieve(dw_detail.GetItemString(i_iRow, "code_type"), & 
//		dw_detail.GetItemString(i_iRow, "code"), & 
//		dw_detail.GetItemNumber(i_iRow, "code_num") )
//End If	

end event

type dw_scan from w_base_sheet`dw_scan within w_ut_codes_sheet
int Y=653
int Width=2604
int Height=528
int TabOrder=170
string DataObject="dw_ut_code_scan"
end type

event dw_scan::clicked;call super::clicked;/*
If row > 0 Then 
	sle_type.text = this.GetItemString(row, "description")
End If

dw_detail.Reset()
*/
end event

event dw_scan::doubleclicked;call super::doubleclicked;//cb_code.PostEvent(Clicked!)
end event

event dw_scan::rowfocuschanged;call super::rowfocuschanged;i_irow = dw_scan.GetRow()

dw_detail.SetTransObject(SQLCA)
dw_detail.Reset()
If i_irow > 0 Then
	dw_detail.Tag = "General Code Information"
	dw_detail.Retrieve(dw_scan.GetItemString(i_iRow, "code_type"), & 
		dw_scan.GetItemString(i_iRow, "code") )
End If	
end event

type cb_list from w_base_sheet`cb_list within w_ut_codes_sheet
int TabOrder=90
boolean BringToTop=true
end type

type cb_detail from w_base_sheet`cb_detail within w_ut_codes_sheet
int TabOrder=100
boolean BringToTop=true
end type

type cb_code from commandbutton within w_ut_codes_sheet
event clicked pbm_bnclicked
event mousemove pbm_mousemove
int X=1763
int Y=45
int Width=578
int Height=86
int TabOrder=190
boolean Visible=false
string Text="&Codes"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer(HourGlass!)

dw_detail.Reset()
If 0 = dw_detail.Retrieve( &
			dw_scan.GetItemString(dw_scan.GetRow(), "code")) Then
	sle_type.SetFocus()
Else
	dw_detail.SetFocus()
End If

end event

event mousemove;w_main.SetMicroHelp("Search For Rows Matching Selected Type.")
end event

type st_1 from statictext within w_ut_codes_sheet
int X=143
int Y=19
int Width=307
int Height=70
boolean Enabled=false
string Text="Code Type:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_type from singlelineedit within w_ut_codes_sheet
event keyup pbm_keyup
int X=457
int Y=10
int Width=1229
int Height=86
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event keyup;// script variables
integer	s_sChars, s_sRow

s_sChars = Len(this.text)
If s_sChars = 0 Then Return

// find the row closest to this one
s_sRow = dw_code_list.Find("description >= '" + this.text + "'", 0, dw_code_list.RowCount())

If s_sRow = 0 Then s_sRow = 1

// highlight only the closest row
dw_code_list.SetRow(s_sRow)
dw_code_list.ScrollToRow(s_sRow)
end event

type dw_code_list from datawindow within w_ut_codes_sheet
event clicked pbm_dwnlbuttonclk
event doubleclicked pbm_dwnlbuttondblclk
int X=18
int Y=106
int Width=2604
int Height=528
int TabOrder=160
string DataObject="dw_ut_code_list"
boolean TitleBar=true
string Title="General Codes Categories"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;sle_type.text = Trim(dw_code_list.GetItemString(row, "description"))
end event

event doubleclicked;sle_type.text = Trim(dw_code_list.GetItemString(row, "description"))
Parent.TriggerEvent("ue_search")
end event

