$PBExportHeader$w_permissions_sheet.srw
forward
global type w_permissions_sheet from w_base_sheet
end type
end forward

global type w_permissions_sheet from w_base_sheet
int X=4
int Y=208
int Width=3716
int Height=1984
boolean TitleBar=true
string Title="Permissions"
end type
global w_permissions_sheet w_permissions_sheet

type variables
string i_achSaveSQL
end variables

on w_permissions_sheet.create
call super::create
end on

on w_permissions_sheet.destroy
call super::destroy
end on

event open;i_achSQL = dw_scan.GetSQLSelect()
dw_scan.SetTransObject(SQLCA)

this.Visible = False
//this.SetRedraw(False)
PostEvent("ue_move_window")
//this.SetRedraw(True)

gnv_resize = create n_cst_resize
gnv_resize.of_SetOrigSize (this.Width, this.Height )
gnv_resize.of_Register(dw_scan, gnv_resize.SCALE)
gnv_resize.of_Register(dw_detail, gnv_resize.SCALE)

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

end event

event ue_search;call super::ue_search;// script variables
string	s_achBusiness, s_achSQL
integer  s_iNumRows
string s_achDWColor

SetPointer(HourGlass!)

// Security - Add Permissions
If w_main.dw_perms.Find("code=6", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_new.enabled = True	
	m_main.m_general.m_new.enabled = True
End If

// Security - Update Permissions
If w_main.dw_perms.Find("code=7", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_update.enabled = True	
	m_main.m_general.m_update.enabled = True
End If

// Security - Delete Permissions
If w_main.dw_perms.Find("code=8", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_delete.enabled = True	
	m_main.m_general.m_delete.enabled = True
End If

s_achDWColor = dw_detail.Describe("datawindow.color")

dw_detail.SetRedraw(False)
dw_detail.Modify("description.background.color = " + s_achDWColor + & 
	" description.tabsequence = 0")
dw_detail.SetRedraw(True)

s_achSQL = i_achSQL + s_achSQL
i_achSaveSQL = s_achSQL

dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")

dw_scan.Reset()
this.SetMicroHelp("Search In Progress...")
s_iNumRows = dw_scan.Retrieve() 

this.SetMicroHelp("Search Complete. " + String(s_iNumRows) + " Rows Retrieved.")
If s_iNumRows = 0 Then
	MessageBox("Complete", "No Permission rows found.")
Else
   dw_scan.SetFocus()
End If

end event

event ue_new;call super::ue_new;string s_achDWColor, s_achNotes, s_achUserType
integer s_iEntryNum, s_iCallNum, s_iCallYear, s_iLineNum

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

// Security - Add Permissions
If w_main.dw_perms.Find("code=6", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True
	m_main.m_general.m_save.enabled = True
End If

// Security - Update Permissions
If w_main.dw_perms.Find("code=7", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

// Security - Delete Permissions
If w_main.dw_perms.Find("code=8", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If
		
Choose Case dw_detail.DataObject
	Case "dw_permissions_detail"

		dw_detail.Tag = "Permission Information"
		dw_detail.Reset()
		dw_detail.InsertRow(0)
		dw_detail.SetItem(1,"code", 0)							
		dw_detail.SetItem(1,"description", "")					
		
		dw_detail.SetRedraw(False)
		dw_detail.Modify("description.background.color = " + s_achDWColor + & 
			" description.tabsequence = 1")
		dw_detail.SetRedraw(True)
		i_iRow = 1
		dw_detail.SetRow(i_iRow)
		
End Choose	
		
dw_detail.SetFocus()

end event

event ue_update;call super::ue_update;string s_achDWColor

i_achOpType ="Update"

s_achDWColor = dw_scan.Describe("datawindow.color")

dw_detail.SetRedraw(False)
dw_detail.Modify("description.background.color = " + s_achDWColor + & 
	" description.tabsequence = 1")
dw_detail.SetColumn("description")									
dw_detail.SetRedraw(True)
dw_detail.SetFocus()
end event

event ue_save;call super::ue_save;string s_achDWColor

s_achDWColor = dw_detail.Describe("datawindow.color")

If i_iValFlag = 0 Then		
	dw_detail.SetRedraw(False)
	dw_detail.Modify("description.background.color = " + s_achDWColor + & 
		" description.tabsequence = 0")
	dw_detail.SetRedraw(True)
	integer s_iRow
	integer s_iCodeNum

	i_iRow = dw_detail.GetRow()
	s_iCodeNum = dw_detail.GetItemNumber(i_iRow,"code")		

	dw_scan.SetTransObject(SQLCA)
	dw_scan.SetRedraw(False)		
	dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
	dw_scan.Retrieve() 			

	// find the row closest to this one
	s_iRow = dw_scan.Find("code = " + String(s_iCodeNum), 0, dw_scan.RowCount())

	If s_iRow = 0 Then s_iRow = 1

	// highlight only the closest row
	dw_scan.ScrollToRow(s_iRow)				
	dw_scan.SelectRow(0,False)
	dw_scan.SelectRow(s_iRow, True)			
			
	dw_scan.SetRedraw(True)				
					
	// Security - Add Permissions
	If w_main.dw_perms.Find("code=6", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_new.enabled = True		
		m_main.m_general.m_new.enabled = True
	End If
			
	// Security - Update Permissions
	If w_main.dw_perms.Find("code=7", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_update.enabled = True		
		m_main.m_general.m_update.enabled = True
	End If
			
	// Security - Delete Permissions
	If w_main.dw_perms.Find("code=8", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_delete.enabled = True	
		m_main.m_general.m_delete.enabled = True
	End If
			
	cb_save.enabled = False			
	m_main.m_general.m_save.enabled = False

End If
dw_scan.enabled = TRUE
dw_detail.SetFocus()
end event

event ue_val_fields;call super::ue_val_fields;
integer s_iRowCount, s_iCount

dw_detail.SetTransObject(SQLCA)
dw_detail.AcceptText()
Choose Case dw_detail.DataObject
	
	Case "dw_permissions_detail"
		
		If IsNull(dw_detail.GetItemString(1,"description")) Or (dw_detail.GetItemString(1,"description") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Permission description must be entered!")
			dw_detail.SetColumn("description")
			dw_detail.SetFocus()
			Return
		End If	
		
End Choose		

integer s_iCodeNum
	
Choose Case dw_detail.DataObject
	Case "dw_permissions_detail"
		i_iRow = dw_detail.GetRow()

		If i_achOpType = "Add" Then		
			SELECT MAX("code") INTO :s_iCodeNum
				FROM "dba"."ut_permissions";
			
			If IsNull(s_iCodeNum) Then s_iCodeNum = 0			
			s_iCodeNum ++
			dw_detail.SetItem(i_iRow, "code", s_iCodeNum)
		End If
		
End Choose	


end event

event ue_add;// nothing
end event

event resize;gnv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
end event

type cb_exit from w_base_sheet`cb_exit within w_permissions_sheet
int TabOrder=160
end type

type dw_detail from w_base_sheet`dw_detail within w_permissions_sheet
event ue_dwnkey pbm_dwnkey
int Y=1280
int Width=3076
int Height=445
int TabOrder=170
string DataObject="dw_permissions_detail"
end type

event dw_detail::ue_dwnkey;string s_achDWColor
integer s_iRow

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_permissions_detail"
		
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "description"
				If KeyDown(KeyEnter!) Or KeyDown(KeyTab!) Then		
					parent.TriggerEvent("ue_save")
					Return
				End If
	
		End Choose 
End Choose 
end event

type dw_scan from w_base_sheet`dw_scan within w_permissions_sheet
int Y=35
int Width=3076
int Height=1213
string DataObject="dw_permissions_scan"
end type

event rowfocuschanged;i_iRow = dw_scan.GetRow()
dw_detail.SetTransObject(SQLCA)
dw_detail.Reset()
If dw_scan.GetRow() > 0 Then
	dw_detail.Tag = "Permission Information"
	
	dw_scan.SelectRow(0,False)
	dw_scan.SelectRow(currentrow, True)					
	
	dw_detail.Retrieve(dw_scan.GetItemNumber(i_iRow, "code"))
End If	
end event

type cb_list from w_base_sheet`cb_list within w_permissions_sheet
boolean BringToTop=true
end type

type cb_detail from w_base_sheet`cb_detail within w_permissions_sheet
boolean BringToTop=true
end type

