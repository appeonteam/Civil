$PBExportHeader$w_access_sheet.srw
forward
global type w_access_sheet from w_base_sheet
end type
type ddlb_permission from dropdownlistbox within w_access_sheet
end type
type st_2 from statictext within w_access_sheet
end type
type ddlb_personnel from dropdownlistbox within w_access_sheet
end type
type st_1 from statictext within w_access_sheet
end type
type cb_copy from commandbutton within w_access_sheet
end type
type cb_assign from commandbutton within w_access_sheet
end type
type gb_6 from groupbox within w_access_sheet
end type
end forward

global type w_access_sheet from w_base_sheet
integer width = 3726
integer height = 2068
string title = "Access"
ddlb_permission ddlb_permission
st_2 st_2
ddlb_personnel ddlb_personnel
st_1 st_1
cb_copy cb_copy
cb_assign cb_assign
gb_6 gb_6
end type
global w_access_sheet w_access_sheet

type variables
string i_achSaveSQL, i_achLName, i_achFName, i_achEmpNum
integer i_iCode
boolean i_bFirstSearch
end variables

on w_access_sheet.create
int iCurrent
call super::create
this.ddlb_permission=create ddlb_permission
this.st_2=create st_2
this.ddlb_personnel=create ddlb_personnel
this.st_1=create st_1
this.cb_copy=create cb_copy
this.cb_assign=create cb_assign
this.gb_6=create gb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_permission
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.ddlb_personnel
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_copy
this.Control[iCurrent+6]=this.cb_assign
this.Control[iCurrent+7]=this.gb_6
end on

on w_access_sheet.destroy
call super::destroy
destroy(this.ddlb_permission)
destroy(this.st_2)
destroy(this.ddlb_personnel)
destroy(this.st_1)
destroy(this.cb_copy)
destroy(this.cb_assign)
destroy(this.gb_6)
end on

event open;
string	achtemp1, achTemp2, achTemp3
datawindowchild	dwc

//dw_scan.SetTransObject(SQLCA)

i_achSQL = dw_scan.GetSQLSelect()
dw_scan.SetTransObject(SQLCA)

f_load_personnelddlb3(ddlb_personnel)

achTemp1 = "code"
achTemp2 = "description"
achTemp3 = "ut_permissions"

//f_load_ddlb(ddlb_permission, achTemp1, achTemp2, achTemp3, SQLCA)
f_load_perms_ddlb(ddlb_permission, achTemp1, achTemp2, achTemp3, SQLCA)

//this.height = this.height + 700
//this.Width = dw_detail.width + 720

gnv_resize = create n_cst_resize
gnv_resize.of_SetOrigSize (this.Width, this.Height )
gnv_resize.of_Register(dw_scan, gnv_resize.SCALE)
gnv_resize.of_Register(dw_detail, gnv_resize.SCALE)
gnv_resize.of_Register(st_1, gnv_resize.SCALE)
gnv_resize.of_Register(ddlb_personnel, gnv_resize.SCALE)
gnv_resize.of_Register(st_2, gnv_resize.SCALE)
gnv_resize.of_Register(ddlb_permission, gnv_resize.SCALE)

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
gnv_resize.of_Register(gb_6, gnv_resize.SCALE)

gnv_resize.of_Register(cb_copy, gnv_resize.SCALE)
gnv_resize.of_Register(cb_assign, gnv_resize.SCALE)


i_bFirstSearch = True

// Security - Add Assigned Permissions (Enables COPY and ASSIGN buttons)
If w_main.dw_perms.Find("code=10", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_copy.enabled = True
	cb_assign.enabled = True
End If

ddlb_personnel.SetFocus()
end event

event ue_new;call super::ue_new;string s_achDWColor

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

// Security - Add Assigned Permissions
If w_main.dw_perms.Find("code=10", 1, w_main.dw_perms.RowCount()) > 0 Then
	m_main.m_general.m_save.enabled = True
	cb_save.enabled = True
End If

// Security - Update Assigned Permissions
If w_main.dw_perms.Find("code=11", 1, w_main.dw_perms.RowCount()) > 0 Then
	m_main.m_general.m_save.enabled = True
	cb_save.enabled = True
End If

// Security - Delete Assigned Permissions
If w_main.dw_perms.Find("code=12", 1, w_main.dw_perms.RowCount()) > 0 Then
	m_main.m_general.m_save.enabled = True
	cb_save.enabled = True
End If
		
Choose Case dw_detail.DataObject
	Case "dw_assigned_detail"

		dw_detail.Tag = "Assigned Permission Information"
		dw_detail.Reset()
		i_iRow = dw_detail.InsertRow(0)
		
		If i_achEmpNum <> "" Then
			dw_detail.SetItem(i_iRow,"ssan", i_achEmpNum)							
		Else	
			dw_detail.SetItem(i_iRow,"ssan", "")							
		End If
		If i_iCode <> 0 Then		
			dw_detail.SetItem(i_iRow,"code", i_iCode)					
		Else	
			dw_detail.SetItem(i_iRow,"code", 0)								
		End If	
		
		dw_detail.SetRedraw(False)
		dw_detail.Modify("ssan.background.color = " + s_achDWColor + & 
			" ssan.tabsequence = 2" + &
			" code.background.color = " + s_achDWColor + & 
			" code.tabsequence = 3")			
		dw_detail.SetRedraw(True)
		i_iRow = 1
		dw_detail.SetRow(i_iRow)
		
End Choose	
		
dw_detail.SetFocus()

end event

event ue_update;call super::ue_update;string s_achDWColor
integer s_iRow

i_achOpType ="Update"

s_achDWColor = dw_scan.Describe("datawindow.color")

s_iRow = dw_detail.GetRow()
Choose Case dw_detail.DataObject
	Case "dw_assigned_detail"
		
		dw_detail.SetRedraw(False)
		dw_detail.Modify("ssan.background.color = " + s_achDWColor + & 
			" ssan.tabsequence = 2" + &
			" code.background.color = " + s_achDWColor + & 
			" code.tabsequence = 3")
		dw_detail.SetColumn("ssan")						
		dw_detail.SetRedraw(True)

End Choose
dw_detail.SetRow(s_iRow)		
dw_detail.SetFocus()


end event

event ue_search;call super::ue_search;// script variables
string	s_achSQL
integer  s_iNumRows
string s_achDWColor

SetPointer(HourGlass!)

// Security - Add Assigned Permissions
If w_main.dw_perms.Find("code=10", 1, w_main.dw_perms.RowCount()) > 0 Then
	m_main.m_general.m_new.enabled = True
	// Decided permissions only added through ASSIGN button 3/22/2001
//	m_main.m_general.m_new.enabled = False
	cb_new.enabled = True
End If

// Security - Update Assigned Permissions
If w_main.dw_perms.Find("code=11", 1, w_main.dw_perms.RowCount()) > 0 Then
	m_main.m_general.m_update.enabled = True
	// Decided permissions only updated through ASSIGN button 3/22/2001
	//m_main.m_general.m_update.enabled = False
	cb_update.enabled = True
End If

// Security - Delete Assigned Permissions
If w_main.dw_perms.Find("code=12", 1, w_main.dw_perms.RowCount()) > 0 Then
	m_main.m_general.m_delete.enabled = True
	cb_delete.enabled = True
End If

// All Offices
dw_detail.DataObject = "dw_assigned_detail"
dw_detail.SetTransObject(SQLCA)

s_achDWColor = dw_detail.Describe("datawindow.color")

dw_detail.SetRedraw(False)
dw_detail.Modify("emp_no.background.color = " + s_achDWColor + & 
	" emp_no.tabsequence = 0" + &		
	" code.background.color = " + s_achDWColor + & 
	" code.tabsequence = 0")
dw_detail.SetRedraw(True)

i_achEmpNum = Trim(Left(ddlb_personnel.text, Pos(ddlb_personnel.text, " ")))
i_iCode = Integer(Trim(Left(ddlb_permission.text, Pos(ddlb_permission.text, " "))))

If i_achEmpNum = "" Then
	// didn't pick a person
	If i_iCode <> 0 Then
		// but did pick a permission
		s_achSQL = &
			" AND ut_assigned_permissions.code = " + String(i_iCode)
	End If
Else
	// picked a person
	If i_iCode = 0 Then
		// but didn't pick a perm
		s_achSQL = &
			" AND ut_assigned_permissions.ssan = ~~~'" + i_achEmpNum + "~~~'" 
	Else
		// picked a perm for a person
		s_achSQL = &
			" AND ut_assigned_permissions.ssan = ~~~'" + i_achEmpNum + "~~~'"
		s_achSQL += &			
			" AND ut_assigned_permissions.code = " + String(i_iCode) 
	End If
End If

s_achSQL += &
	" ORDER BY ut_personnel.last_name ASC, ut_personnel.first_name ASC, description ASC" 
s_achSQL = i_achSQL + s_achSQL
i_achSaveSQL = s_achSQL

dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")

dw_scan.Reset()
this.SetMicroHelp("Search In Progress...")
s_iNumRows = dw_scan.Retrieve() 

this.SetMicroHelp("Search Complete. " + String(s_iNumRows) + " Rows Retrieved.")
If dw_scan.Retrieve() = 0 Then
	MessageBox("Complete", "No Assigned Permission rows found.")

	ddlb_personnel.SetFocus()
Else
	
	dw_scan.SelectRow(0,False)
	dw_scan.SelectRow(1, True)
	
	dw_scan.SetFocus()
End If

end event

event ue_clear;call super::ue_clear;ddlb_personnel.SelectItem(1)
ddlb_permission.SelectItem(1)

i_bFirstSearch = True
i_achOpType = ""
i_achLName = ""
i_achFName = ""
i_achEmpNum = ""
i_iCode = 0

cb_first.enabled = False
m_main.m_general.m_first.enabled = False

cb_back.enabled = False
m_main.m_general.m_back.enabled = False

cb_next.enabled = False
m_main.m_general.m_next.enabled = False

cb_last.enabled = False
m_main.m_general.m_last.enabled = False

ddlb_personnel.SetFocus()



end event

event ue_save;call super::ue_save;
string s_achDWColor

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_assigned_detail"

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
			dw_detail.Modify("ssan.background.color = " + s_achDWColor + & 
				" ssan.tabsequence = 0" + &
				" code.background.color = " + s_achDWColor + & 
				" code.tabsequence = 0")
			dw_detail.SetRedraw(True)
			i_bFirstSearch = False
			integer s_iRow, s_iCode
			string s_achEmpNum

			i_iRow = dw_detail.GetRow()

			s_achEmpNum = dw_detail.GetItemString(i_iRow,"ssan")
			s_iCode = dw_detail.GetItemNumber(i_iRow,"code")
				
			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)
			dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
			dw_scan.Retrieve() 			

			// find the row closest to this one
			s_iRow = dw_scan.Find("ssan = '" + s_achEmpNum + &
				"' AND code = " + String(s_iCode), 0, dw_scan.RowCount())

			If s_iRow = 0 Then s_iRow = 1

			// highlight only the closest row
			dw_scan.ScrollToRow(s_iRow)				
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(s_iRow, True)								

			dw_scan.SetRedraw(True)
			dw_scan.enabled = True

			// Security - Add Assigned Permissions
			If w_main.dw_perms.Find("code=10", 1, w_main.dw_perms.RowCount()) > 0 Then
				m_main.m_general.m_new.enabled = True
				// Decided permissions only added through ASSIGN button 3/22/2001
				//m_main.m_general.m_new.enabled = False
				cb_new.enabled = True
			End If
			
			// Security - Update Assigned Permissions
			If w_main.dw_perms.Find("code=11", 1, w_main.dw_perms.RowCount()) > 0 Then
				m_main.m_general.m_update.enabled = True
				// Decided permissions only updated through ASSIGN button 3/22/2001
				//m_main.m_general.m_update.enabled = False
				cb_update.enabled = True
			End If
			
			// Security - Delete Assigned Permissions
			If w_main.dw_perms.Find("code=12", 1, w_main.dw_perms.RowCount()) > 0 Then
				m_main.m_general.m_delete.enabled = True
				cb_delete.enabled = True
			End If

			cb_escape.enabled = False
			m_main.m_general.m_escape.enabled = False
			cb_save.enabled = False
			m_main.m_general.m_save.enabled = False
			
		End If			
		
End Choose

dw_detail.SetFocus()
end event

event ue_val_fields;
integer s_iRowCount, s_iCount

dw_detail.SetTransObject(SQLCA)
dw_detail.AcceptText()
Choose Case dw_detail.DataObject
	
	Case "dw_assigned_detail"
		
		If IsNull(dw_detail.GetItemString(1,"ssan")) Or (dw_detail.GetItemString(1,"ssan") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Employee SSAN must be entered!")
			dw_detail.SetColumn("ssan")
			dw_detail.SetFocus()
			Return
		End If	
		
		If IsNull(dw_detail.GetItemNumber(1,"code")) Or (dw_detail.GetItemNumber(1,"code") = 0) Then
			i_ivalflag = 1 
			MessageBox("Error", "Permission must be entered!")
			dw_detail.SetColumn("code")
			dw_detail.SetFocus()
			Return
		End If	

End Choose		

Choose Case dw_detail.DataObject
	Case "dw_assigned_detail"
			
End Choose	

end event

event ue_delete;string s_achErrText, s_achEmpNum
integer s_iRow, s_iCode

i_achOpType = "Delete"

cb_new.enabled = False
m_main.m_general.m_new.enabled = False
cb_add.enabled = False
m_main.m_general.m_add.enabled = False
cb_update.enabled = False
m_main.m_general.m_update.enabled = False
cb_delete.enabled = False
m_main.m_general.m_delete.enabled = False

If dw_detail.RowCount() = 0 Then
   MessageBox("Error","Select Row to Delete",StopSign!)
Else
   If 2 = MessageBox("Delete","Delete This Assigned Permission?",Question!,OkCancel!,2) Then
      MessageBox("Delete","Entry NOT Deleted",None!)
   Else
		
		SetPointer(Hourglass!) 
		
		dw_detail.DeleteRow(1) 
		If dw_detail.Update(False, False) = -1 Then
			
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
				i_iRow = dw_scan.GetRow()
		
				s_achEmpNum = dw_scan.GetItemString(i_iRow,"ssan")
				s_iCode = dw_scan.GetItemNumber(i_iRow,"code")
				
				dw_scan.SetTransObject(SQLCA)
				dw_scan.SetRedraw(False)
				dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
				dw_scan.Retrieve() 			
		
				// find the row closest to this one
				s_iRow = dw_scan.Find("ssan = '" + s_achEmpNum + &
					"' AND code = " + String(s_iCode), 0, dw_scan.RowCount())
		
				If s_iRow = 0 Then s_iRow = 1
		
				// highlight only the closest row
				dw_scan.ScrollToRow(s_iRow)				
				dw_scan.SelectRow(0,False)
				dw_scan.SelectRow(s_iRow, True)								
		
				dw_scan.SetRedraw(True)
				dw_scan.enabled = True
				
				dw_scan.DeleteRow(dw_scan.GetRow())
				
				// reset the update flags
				dw_scan.ResetUpdate()
				dw_detail.ResetUpdate()
				TriggerEvent("ue_search")				
			End If
		End If
	End If
End If
	

end event

event resize;gnv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
end event

type cb_escape from w_base_sheet`cb_escape within w_access_sheet
end type

type cb_exit from w_base_sheet`cb_exit within w_access_sheet
integer taborder = 120
end type

type cb_last from w_base_sheet`cb_last within w_access_sheet
integer taborder = 110
end type

type cb_next from w_base_sheet`cb_next within w_access_sheet
integer taborder = 100
end type

type cb_back from w_base_sheet`cb_back within w_access_sheet
integer taborder = 90
end type

type cb_first from w_base_sheet`cb_first within w_access_sheet
integer taborder = 80
end type

type cb_save from w_base_sheet`cb_save within w_access_sheet
integer taborder = 0
end type

type cb_delete from w_base_sheet`cb_delete within w_access_sheet
integer taborder = 50
end type

type cb_update from w_base_sheet`cb_update within w_access_sheet
integer taborder = 0
end type

type cb_add from w_base_sheet`cb_add within w_access_sheet
boolean visible = false
integer taborder = 0
end type

type cb_new from w_base_sheet`cb_new within w_access_sheet
integer taborder = 0
end type

type cb_clear from w_base_sheet`cb_clear within w_access_sheet
integer taborder = 40
end type

type cb_search from w_base_sheet`cb_search within w_access_sheet
integer taborder = 30
end type

type dw_detail from w_base_sheet`dw_detail within w_access_sheet
event ue_dwnkey pbm_dwnkey
integer x = 23
integer y = 1340
integer width = 3022
integer height = 468
string dataobject = "dw_assigned_detail"
end type

event dw_detail::ue_dwnkey;string s_achDWColor
integer s_iRow

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_assigned_detail"
		
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "code"
				If KeyDown(KeyEnter!) Or KeyDown(KeyTab!) Then		
					parent.TriggerEvent("ue_save")
					Return
				End If
	
		End Choose 
End Choose 
end event

type dw_scan from w_base_sheet`dw_scan within w_access_sheet
integer x = 23
integer y = 248
integer width = 3022
integer height = 1068
integer taborder = 150
string dataobject = "dw_assigned_scan"
end type

event dw_scan::rowfocuschanged;integer s_iRow

dw_detail.SetTransObject(SQLCA)

s_iRow = dw_scan.GetRow()
If s_iRow > 0 Then
	
	Choose Case dw_detail.DataObject
		Case "dw_assigned_detail"

			dw_detail.Tag = "Assigned Permission Information"
			
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(currentrow, True)			
			
			dw_detail.Retrieve(dw_scan.GetItemString(s_iRow, "ssan"), &
				dw_scan.GetItemNumber(s_iRow, "code"))
	
	End Choose		

End If	
end event

type gb_5 from w_base_sheet`gb_5 within w_access_sheet
end type

type gb_4 from w_base_sheet`gb_4 within w_access_sheet
end type

type gb_1 from w_base_sheet`gb_1 within w_access_sheet
end type

type gb_2 from w_base_sheet`gb_2 within w_access_sheet
end type

type cb_list from w_base_sheet`cb_list within w_access_sheet
integer taborder = 60
end type

type cb_detail from w_base_sheet`cb_detail within w_access_sheet
integer taborder = 70
end type

type gb_3 from w_base_sheet`gb_3 within w_access_sheet
end type

type ddlb_permission from dropdownlistbox within w_access_sheet
integer x = 430
integer y = 136
integer width = 1765
integer height = 464
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_access_sheet
integer x = 55
integer y = 152
integer width = 357
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Permission:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_personnel from dropdownlistbox within w_access_sheet
integer x = 430
integer y = 28
integer width = 1367
integer height = 432
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_access_sheet
integer x = 82
integer y = 48
integer width = 325
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Personnel:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_copy from commandbutton within w_access_sheet
integer x = 3163
integer y = 736
integer width = 201
integer height = 68
integer taborder = 130
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Copy"
end type

event clicked;open(w_assign_copy)
end event

type cb_assign from commandbutton within w_access_sheet
integer x = 3163
integer y = 804
integer width = 201
integer height = 68
integer taborder = 140
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "A&ssign"
end type

event clicked;open(w_assign_new)
end event

type gb_6 from groupbox within w_access_sheet
integer x = 3136
integer y = 688
integer width = 247
integer height = 208
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

