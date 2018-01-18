$PBExportHeader$w_company_sheet.srw
forward
global type w_company_sheet from w_base_sheet
end type
type st_1 from statictext within w_company_sheet
end type
type sle_company from singlelineedit within w_company_sheet
end type
end forward

global type w_company_sheet from w_base_sheet
integer x = 88
integer y = 35
integer width = 3690
integer height = 2250
string title = "Company Information"
toolbaralignment toolbaralignment = alignatleft!
st_1 st_1
sle_company sle_company
end type
global w_company_sheet w_company_sheet

type variables
boolean i_bFirstSearch
string i_achSaveSQL
string i_achCompany

end variables

event ue_search;call super::ue_search;// script variables
string s_achSQL, s_achDWColor
datawindowchild dwc

SetPointer(HourGlass!)

s_achDWColor = dw_detail.Describe("datawindow.color")

cb_add.enabled = False
m_main.m_general.m_add.enabled = False

// Security - New Company
If w_main.dw_perms.Find("code=54", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_new.enabled = True
	m_main.m_general.m_new.enabled = True
End If

// Security - Update Company
If w_main.dw_perms.Find("code=55", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_update.enabled = True	
	m_main.m_general.m_update.enabled = True
End If

// Security - Delete Company
If w_main.dw_perms.Find("code=56", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_delete.enabled = True	
	m_main.m_general.m_delete.enabled = True
End If

dw_detail.DataObject = "dw_company_detail"

dw_detail.SetRedraw(False)
dw_detail.Modify("company_code.background.color = " + s_achDWColor + & 
	" company_code.tabsequence = 0" + &
	" company_name.background.color = " + s_achDWColor + & 
	" company_name.tabsequence = 0" + &
	" address1.background.color = " + s_achDWColor + & 
	" address1.tabsequence = 0" + &	
	" address2.background.color = " + s_achDWColor + & 
	" address2.tabsequence = 0" + &		
	" city.background.color = " + s_achDWColor + & 
	" city.tabsequence = 0" + &		
	" state.background.color = " + s_achDWColor + & 
	" state.tabsequence = 0" + &		
	" zip_code.background.color = " + s_achDWColor + & 
	" zip_code.tabsequence = 0" + &		
	" work_phone.background.color = " + s_achDWColor + & 
	" work_phone.tabsequence = 0")
dw_detail.SetRedraw(True)

i_achCompany = Trim(sle_company.text)

// Company Name
If trim(sle_company.text) <> "" Then
	If Len(s_achSQL) = 0 Then
		s_achSQL = &
			 " WHERE ut_company.company_name LIKE ~~~'" + trim(sle_company.text) + "%" + "~~~'" 
	Else
		s_achSQL += &
			 " AND ut_company.company_name LIKE ~~~'" + trim(sle_company.text) + "%" + "~~~'" 
	End If	
End If

s_achSQL += &
   " ORDER BY ut_company.company_name ASC"
s_achSQL = i_achSQL + s_achSQL
i_achSaveSQL = s_achSQL

dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")

dw_scan.Reset()
If dw_scan.Retrieve() = 0 Then
	MessageBox("Complete", "No Company rows found.")
	If sle_company.text <> "" Then 
		sle_company.text = ""
		sle_company.SetFocus()
	End If
Else
   dw_scan.SetFocus()
End If
end event

on w_company_sheet.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_company=create sle_company
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_company
end on

on w_company_sheet.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_company)
end on

event open;call super::open;datawindowchild	dwc

this.Height = dw_detail.Height + 1500
this.Width = dw_detail.Width + 650

i_bFirstSearch = True

sle_company.SetFocus()

end event

event ue_back;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_company_detail"
		
		cb_first.enabled = False							
		m_main.m_general.m_first.enabled = False		
		cb_back.enabled = False									
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False									
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False									
		m_main.m_general.m_last.enabled = False

		Return

End Choose
end event

event ue_next;datawindowchild	dwc

Choose Case dw_detail.DataObject
	Case "dw_master_name_detail"

		cb_first.enabled = False							
		m_main.m_general.m_first.enabled = False		
		cb_back.enabled = False									
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False									
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False									
		m_main.m_general.m_last.enabled = False

		Return

End Choose

end event

event ue_update;call super::ue_update;string s_achDWColor
integer s_iRow

i_achOpType ="Update"

s_achDWColor = dw_scan.Describe("datawindow.color")

s_iRow = dw_detail.GetRow()
Choose Case dw_detail.DataObject
	Case "dw_company_detail"

		dw_detail.SetRedraw(False)
		dw_detail.Modify("company_name.background.color = " + s_achDWColor + & 
			" company_name.tabsequence = 2" + &
			" address1.background.color = " + s_achDWColor + & 
			" address1.tabsequence = 3" + &	
			" address2.background.color = " + s_achDWColor + & 
			" address2.tabsequence = 4" + &		
			" city.background.color = " + s_achDWColor + & 
			" city.tabsequence = 5" + &		
			" state.background.color = " + s_achDWColor + & 
			" state.tabsequence = 6" + &		
			" zip_code.background.color = " + s_achDWColor + & 
			" zip_code.tabsequence = 7" + &		
			" work_phone.background.color = " + s_achDWColor + & 
			" work_phone.tabsequence = 8")		
		dw_detail.SetColumn("company_name")			
			
End Choose

dw_detail.SetRedraw(True)
dw_detail.SetRow(s_iRow)		
dw_detail.SetFocus()

end event

event ue_clear;call super::ue_clear;
sle_company.text = ""

i_bFirstSearch = True
i_achOpType = ""
i_achCompany = ""

cb_first.enabled = False							
m_main.m_general.m_first.enabled = False		
cb_back.enabled = False									
m_main.m_general.m_back.enabled = False
cb_next.enabled = False									
m_main.m_general.m_next.enabled = False
cb_last.enabled = False									
m_main.m_general.m_last.enabled = False

sle_company.SetFocus()



end event

event ue_val_fields;
integer s_iRowCount, s_iCount

dw_detail.SetTransObject(SQLCA)
dw_detail.AcceptText()
Choose Case dw_detail.DataObject
	
	Case "dw_company_detail"
		
		If IsNull(dw_detail.GetItemString(1,"company_code")) Or (dw_detail.GetItemString(1,"company_code") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Company code MUST be entered!")
			dw_detail.SetColumn("company_code")
			dw_detail.SetFocus()
			Return
		End If	
		
		If IsNull(dw_detail.GetItemString(1,"company_name")) Or (dw_detail.GetItemString(1,"company_name") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Company name MUST be entered!")
			dw_detail.SetColumn("company_name")
			dw_detail.SetFocus()
			Return
		End If	

End Choose		

integer s_iLineNum
	
Choose Case dw_detail.DataObject
	Case "dw_personnel_detail"
		i_iRow = dw_detail.GetRow()

		If i_achOpType = "Add" Then
//			SELECT MAX("emp_num") INTO :s_iEmpNum
//				FROM "dba"."personnel"
//				WHERE "dba"."personnel"."user_type" = :s_achUserType;
				
//			If IsNull(s_iEmpNum) Then s_iEmpNum = 0			
//			s_iEmpNum ++
//			dw_detail.SetItem(i_iRow, "emp_num", s_iEmpNum)
	
		End If

End Choose	

end event

event ue_save;call super::ue_save;// script variables
string s_achDWColor, s_achErrText, s_achSQL, s_achCompanyCode

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_company_detail"
		
		cb_first.enabled = False
		m_main.m_general.m_first.enabled = False
		cb_back.enabled = False		
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False		
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False		
		m_main.m_general.m_last.enabled = False
	
		If i_iValFlag = 0 Then
			dw_detail.SetRedraw(False)
			dw_detail.Modify("company_code.background.color = " + s_achDWColor + & 
				" company_code.tabsequence = 0" + &
				" company_name.background.color = " + s_achDWColor + & 
				" company_name.tabsequence = 0" + &
				" address1.background.color = " + s_achDWColor + & 
				" address1.tabsequence = 0" + &	
				" address2.background.color = " + s_achDWColor + & 
				" address2.tabsequence = 0" + &		
				" city.background.color = " + s_achDWColor + & 
				" city.tabsequence = 0" + &		
				" state.background.color = " + s_achDWColor + & 
				" state.tabsequence = 0" + &		
				" zip_code.background.color = " + s_achDWColor + & 
				" zip_code.tabsequence = 0" + &		
				" work_phone.background.color = " + s_achDWColor + & 
				" work_phone.tabsequence = 0")			
			dw_detail.SetRedraw(True)			
			
			// Add Company
			If w_main.dw_perms.Find("code=54", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_new.enabled = True
				m_main.m_general.m_new.enabled = True
			End If
			
			// Security - Update Company
			If w_main.dw_perms.Find("code=55", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_update.enabled = True				
				m_main.m_general.m_update.enabled = True
			End If
			
			// Security - Delete Company
			If w_main.dw_perms.Find("code=56", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_delete.enabled = True				
				m_main.m_general.m_delete.enabled = True
			End If
			
			cb_save.enabled = False
			m_main.m_general.m_save.enabled = False
			
			i_bFirstSearch = False
			integer s_iRow
			i_iRow = dw_detail.GetRow()
	
			s_achCompanyCode = Trim(dw_detail.GetItemString(i_iRow,"company_code"))
				
			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)
			dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
			dw_scan.Retrieve() 			
	
			// find the row closest to this one
			s_iRow = dw_scan.Find("company_code = '" + s_achCompanyCode + "'", 0, dw_scan.RowCount())

			If s_iRow = 0 Then s_iRow = 1

			// highlight only the closest row
			dw_scan.ScrollToRow(s_iRow)				
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(s_iRow, True)								

			dw_scan.SetRedraw(True)
			dw_scan.enabled = True
										
		End If
		
End Choose

dw_detail.SetFocus()

end event

event ue_first;		
Choose Case dw_detail.DataObject
	Case "dw_company_detail"

		cb_first.enabled = False							
		m_main.m_general.m_first.enabled = False		
		cb_back.enabled = False									
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False									
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False									
		m_main.m_general.m_last.enabled = False
					
		Return

End Choose
	
dw_detail.SetFocus()	

end event

event ue_last;datawindowchild	dwc

Choose Case dw_detail.DataObject
	
	Case "dw_company_detail"

		cb_first.enabled = False							
		m_main.m_general.m_first.enabled = False		
		cb_back.enabled = False									
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False									
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False									
		m_main.m_general.m_last.enabled = False

		Return

End Choose
end event

event ue_new;call super::ue_new;string s_achDWColor
datawindowchild dwc

s_achDWColor = dw_scan.Describe("datawindow.color")

SetPointer(Hourglass!)

i_achOpType = "Add"

cb_new.enabled = False
m_main.m_general.m_new.enabled = False
cb_add.enabled = False
m_main.m_general.m_add.enabled = False
cb_delete.enabled = False
m_main.m_general.m_delete.enabled = False
cb_update.enabled = False
m_main.m_general.m_update.enabled = False

i_achOpType = "Add"

// Security - Add Company
If w_main.dw_perms.Find("code=54", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True
	m_main.m_general.m_save.enabled = True
End If

// Security - Update Company
If w_main.dw_perms.Find("code=55", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

// Security - Delete Company
If w_main.dw_perms.Find("code=56", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

Choose Case dw_detail.DataObject
	Case "dw_company_detail"
		
		cb_first.enabled = False		
		m_main.m_general.m_first.enabled = False
		cb_back.enabled = False				
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False				
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False				
		m_main.m_general.m_last.enabled = False

		dw_detail.Tag = "Master Name Information"
		dw_detail.Reset()			
		dw_detail.InsertRow(0)
		dw_detail.SetItem(1,"company_code", "")							
		dw_detail.SetItem(1,"company_name", "")		
		dw_detail.SetItem(1,"address1", "")			
		dw_detail.SetItem(1,"address2", "")					
		dw_detail.SetItem(1,"city", "")					
		dw_detail.SetItem(1,"state", "")					
		dw_detail.SetItem(1,"zip_code", "")					
		dw_detail.SetItem(1,"work_phone", "")					
 		
		dw_detail.SetRedraw(False)
		dw_detail.Modify("company_code.background.color = " + s_achDWColor + & 
			" company_code.tabsequence = 1" + &
			" company_name.background.color = " + s_achDWColor + & 
			" company_name.tabsequence = 2" + &
			" address1.background.color = " + s_achDWColor + & 
			" address1.tabsequence = 3" + &	
			" address2.background.color = " + s_achDWColor + & 
			" address2.tabsequence = 4" + &		
			" city.background.color = " + s_achDWColor + & 
			" city.tabsequence = 5" + &		
			" state.background.color = " + s_achDWColor + & 
			" state.tabsequence = 6" + &		
			" zip_code.background.color = " + s_achDWColor + & 
			" zip_code.tabsequence = 7" + &		
			" work_phone.background.color = " + s_achDWColor + & 
			" work_phone.tabsequence = 8")
		dw_detail.SetRedraw(True)

		i_iRow = 1
		dw_detail.SetRow(i_iRow)								
		
End Choose	
		
dw_detail.SetFocus()

end event

type cb_escape from w_base_sheet`cb_escape within w_company_sheet
integer taborder = 130
end type

type cb_exit from w_base_sheet`cb_exit within w_company_sheet
end type

type cb_last from w_base_sheet`cb_last within w_company_sheet
end type

type cb_next from w_base_sheet`cb_next within w_company_sheet
integer taborder = 120
end type

type cb_back from w_base_sheet`cb_back within w_company_sheet
integer taborder = 110
end type

type cb_first from w_base_sheet`cb_first within w_company_sheet
end type

type cb_save from w_base_sheet`cb_save within w_company_sheet
end type

type cb_delete from w_base_sheet`cb_delete within w_company_sheet
end type

type cb_update from w_base_sheet`cb_update within w_company_sheet
end type

type cb_add from w_base_sheet`cb_add within w_company_sheet
end type

type cb_new from w_base_sheet`cb_new within w_company_sheet
end type

type cb_clear from w_base_sheet`cb_clear within w_company_sheet
end type

type cb_search from w_base_sheet`cb_search within w_company_sheet
end type

type dw_detail from w_base_sheet`dw_detail within w_company_sheet
event ue_dwnkey pbm_dwnkey
integer x = 0
integer y = 819
integer width = 3101
integer height = 1126
integer taborder = 170
string dataobject = "dw_company_detail"
end type

event dw_detail::ue_dwnkey;string s_achDWColor
integer s_iRow

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_master_name_detail"
		
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "work_phone"
				If KeyDown(KeyEnter!) Or KeyDown(KeyTab!) Or KeyDown(KeySpaceBar!) Then		
					parent.TriggerEvent("ue_save")
					Return
				End If
	
		End Choose 
End Choose 
end event

type dw_scan from w_base_sheet`dw_scan within w_company_sheet
integer x = 0
integer y = 128
integer width = 3101
integer height = 666
integer taborder = 160
string dataobject = "dw_company_scan"
end type

event dw_scan::rowfocuschanged;dw_detail.SetTransObject(SQLCA)

i_irow = dw_scan.GetRow()
If i_irow > 0 Then
	Choose Case dw_detail.DataObject
		Case "dw_company_detail"
			dw_detail.Tag = "Company Information"
			
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(currentrow, True)				
			
			dw_detail.Retrieve(dw_scan.GetItemString(i_irow, "company_code"))

	End Choose
	
End If	
end event

type gb_5 from w_base_sheet`gb_5 within w_company_sheet
end type

type gb_4 from w_base_sheet`gb_4 within w_company_sheet
end type

type gb_1 from w_base_sheet`gb_1 within w_company_sheet
end type

type gb_2 from w_base_sheet`gb_2 within w_company_sheet
end type

type cb_list from w_base_sheet`cb_list within w_company_sheet
end type

type cb_detail from w_base_sheet`cb_detail within w_company_sheet
end type

type gb_3 from w_base_sheet`gb_3 within w_company_sheet
end type

type st_1 from statictext within w_company_sheet
integer x = 22
integer y = 29
integer width = 384
integer height = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Company:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_company from singlelineedit within w_company_sheet
integer x = 424
integer y = 19
integer width = 1167
integer height = 86
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

