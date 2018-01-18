$PBExportHeader$w_personnel_sheet.srw
forward
global type w_personnel_sheet from w_base_sheet
end type
type st_1 from statictext within w_personnel_sheet
end type
type sle_lname from singlelineedit within w_personnel_sheet
end type
type st_2 from statictext within w_personnel_sheet
end type
type sle_fname from singlelineedit within w_personnel_sheet
end type
end forward

global type w_personnel_sheet from w_base_sheet
integer x = 88
integer y = 35
integer width = 3690
integer height = 2106
string title = "Personnel"
windowstate windowstate = normal!
toolbaralignment toolbaralignment = alignatleft!
st_1 st_1
sle_lname sle_lname
st_2 st_2
sle_fname sle_fname
end type
global w_personnel_sheet w_personnel_sheet

type variables
boolean i_bFirstSearch
string i_achSaveSQL
string i_achLName, i_achFName, i_achEmpNum

end variables

event ue_search;call super::ue_search;// script variables
string s_achSQL, s_achDWColor
datawindowchild dwc

SetPointer(HourGlass!)

s_achDWColor = dw_detail.Describe("datawindow.color")

cb_add.enabled = False
m_main.m_general.m_add.enabled = False

// Security - New Personnel
If w_main.dw_perms.Find("code=2", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_new.enabled = True
	m_main.m_general.m_new.enabled = True
End If

// Security - Update Personnel
If w_main.dw_perms.Find("code=3", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_update.enabled = True	
	m_main.m_general.m_update.enabled = True
End If

// Security - Delete Personnel
If w_main.dw_perms.Find("code=4", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_delete.enabled = True	
	m_main.m_general.m_delete.enabled = True
End If

dw_detail.DataObject = "dw_personnel_detail"

dw_detail.SetRedraw(False)
dw_detail.Modify("ssan.background.color = " + s_achDWColor + & 
	" ssan.tabsequence = 0" + &
	" last_name.background.color = " + s_achDWColor + & 
	" last_name.tabsequence = 0" + &
	" first_name.background.color = " + s_achDWColor + & 
	" first_name.tabsequence = 0" + &
	" user_id.background.color = " + s_achDWColor + & 
	" user_id.tabsequence = 0")
dw_detail.SetRedraw(True)

i_achLName = Trim(sle_lname.text)
i_achFName = Trim(sle_fname.text)

// didn't pick a last name

If i_achLName = "" Then
	// didn't pick a first name
   If sle_fname.text <> "" Then
	   // picked a first name
      s_achSQL = &
         " WHERE first_name LIKE ~~~'" + i_achFName + "%" + "~~~'" 
	End If
Else
	// picked a last name
	s_achSQL = &
         " WHERE ut_personnel.last_name LIKE ~~~'" + i_achLName + "%" + "~~~'" 
	If sle_fname.text <> "" Then
		// picked a last and a first name
		s_achSQL += &
        " AND ut_personnel.first_name LIKE ~~~'" + i_achFName + "%" + "~~~'" 
   End If
End If

s_achSQL += &
   " ORDER BY ut_personnel.last_name ASC, ut_personnel.first_name ASC" 
s_achSQL = i_achSQL + s_achSQL
i_achSaveSQL = s_achSQL

dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")

dw_scan.Reset()
If dw_scan.Retrieve() = 0 Then
	MessageBox("Complete", "No Personnel rows found.")
	If sle_lname.text <> "" Then 
		sle_lname.text = ""
		sle_fname.text = ""
		sle_lname.SetFocus()
	End If
Else
   dw_scan.SetFocus()
End If
end event

on w_personnel_sheet.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_lname=create sle_lname
this.st_2=create st_2
this.sle_fname=create sle_fname
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_lname
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.sle_fname
end on

on w_personnel_sheet.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_lname)
destroy(this.st_2)
destroy(this.sle_fname)
end on

event open;datawindowchild	dwc

i_achSQL = dw_scan.GetSQLSelect()
dw_scan.SetTransObject(SQLCA)

//this.Height = dw_detail.Height + 1500
//this.Width = dw_detail.Width + 650

gnv_resize = create n_cst_resize
gnv_resize.of_SetOrigSize (this.Width, this.Height )
gnv_resize.of_Register(dw_scan, gnv_resize.SCALE)
gnv_resize.of_Register(dw_detail, gnv_resize.SCALE)
gnv_resize.of_Register(st_1, gnv_resize.SCALE)
gnv_resize.of_Register(st_2, gnv_resize.SCALE)
gnv_resize.of_Register(sle_lname, gnv_resize.SCALE)
gnv_resize.of_Register(sle_fname, gnv_resize.SCALE)

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

i_bFirstSearch = True

sle_lname.SetFocus()

end event

event ue_back;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_personnel_detail"
		
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
	Case "dw_personnel_detail"

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
	Case "dw_personnel_detail"

		dw_detail.SetRedraw(False)
		dw_detail.Modify("last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 2" + &
			" first_name.background.color = " + s_achDWColor + & 
			" first_name.tabsequence = 3" + &
			" user_id.background.color = " + s_achDWColor + & 
			" user_id.tabsequence = 4")				
		dw_detail.SetColumn("last_name")			
			
End Choose

dw_detail.SetRedraw(True)
dw_detail.SetRow(s_iRow)		
dw_detail.SetFocus()

end event

event ue_clear;call super::ue_clear;
sle_lname.text = ""
sle_fname.text = ""

i_bFirstSearch = True
i_achOpType = ""
i_achEmpNum = ""
i_achLName = ""
i_achFName = ""

cb_first.enabled = False							
m_main.m_general.m_first.enabled = False		
cb_back.enabled = False									
m_main.m_general.m_back.enabled = False
cb_next.enabled = False									
m_main.m_general.m_next.enabled = False
cb_last.enabled = False									
m_main.m_general.m_last.enabled = False

sle_lname.SetFocus()



end event

event ue_val_fields;string s_achEmpNum
integer s_iRowCount, s_iCount

dw_detail.SetTransObject(SQLCA)
dw_detail.AcceptText()
Choose Case dw_detail.DataObject
	
	Case "dw_personnel_detail"
		
		If IsNull(dw_detail.GetItemString(1,"ssan")) Or (dw_detail.GetItemString(1,"ssan") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Personnel SSAN must be entered!")
			dw_detail.SetColumn("ssan")
			dw_detail.SetFocus()
			Return
		End If	
		
		If IsNull(dw_detail.GetItemString(1,"last_name")) Or (dw_detail.GetItemString(1,"last_name") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Last name must be entered!")
			dw_detail.SetColumn("last_name")
			dw_detail.SetFocus()
			Return
		End If	

		If i_achOpType = "Add" Then
			s_achEmpNum = dw_detail.GetItemString(1,"ssan")
			SELECT COUNT(*) INTO :s_iCount
				FROM ut_personnel
				WHERE ut_personnel.ssan = :s_achEmpNum;
			If s_iCount > 0 Then
				i_ivalflag = 1 
				MessageBox("Error", "Unique employee number must be entered!")
				dw_detail.SetColumn("ssan")
				dw_detail.SetFocus()
				Return
			End If	
		End If

		If IsNull(dw_detail.GetItemString(1,"user_id")) Or (dw_detail.GetItemString(1,"user_id") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "User ID must be entered!")
			dw_detail.SetColumn("user_id")
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
string s_achDWColor, s_achErrText, s_achSQL, s_achSSAN, s_achUserID

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_personnel_detail"
		
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
				" last_name.background.color = " + s_achDWColor + & 
				" last_name.tabsequence = 0" + &
				" first_name.background.color = " + s_achDWColor + & 
				" first_name.tabsequence = 0" + &
				" user_id.background.color = " + s_achDWColor + & 
				" user_id.tabsequence = 0")
			dw_detail.SetRedraw(True)			
			
			// Security - Add Personnel
			If w_main.dw_perms.Find("code=2", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_new.enabled = True
				m_main.m_general.m_new.enabled = True
			End If
			
			// Security - Update Personnel
			If w_main.dw_perms.Find("code=3", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_update.enabled = True				
				m_main.m_general.m_update.enabled = True
			End If
			
			// Security - Delete Personnel
			If w_main.dw_perms.Find("code=4", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_delete.enabled = True				
				m_main.m_general.m_delete.enabled = True
			End If
			
			cb_save.enabled = False
			m_main.m_general.m_save.enabled = False
			
			If i_achOpType = "Add" Then
				i_iRow = dw_detail.GetRow()
	
				s_achUserID = Trim(dw_detail.GetItemString(i_iRow,"user_id"))
				dw_detail.SetItem(i_iRow, "user_password", s_achUserID)
								
				If dw_detail.Update(True) = -1 Then
					s_achErrText = SQLCA.SQLErrText
					ROLLBACK;
					MessageBox("Error", "Update Failed - " + s_achErrText)
				Else
					COMMIT;
					If SQLCA.SQLCode = -1 Then
						s_achErrText = SQLCA.SQLErrText
						ROLLBACK;
						MessageBox("Error", "Update Failed - " + s_achErrText)
					End If					
				End If											
			End If
			
			i_bFirstSearch = False
			integer s_iRow
			i_iRow = dw_detail.GetRow()
	
			s_achSSAN = dw_detail.GetItemString(i_iRow,"ssan")
				
			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)
			dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
			dw_scan.Retrieve() 			
	
			// find the row closest to this one
			s_iRow = dw_scan.Find("ssan = '" + s_achSSAN + "'", 0, dw_scan.RowCount())

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
	Case "dw_personnel_detail"

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
	
	Case "dw_personnel_detail"

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

event ue_new;call super::ue_new;string s_achDWColor, s_achNotes
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

// Security - Add Personel
If w_main.dw_perms.Find("code=2", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True
	m_main.m_general.m_save.enabled = True
End If

// Security - Update Personnel
If w_main.dw_perms.Find("code=3", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

// Security - Delete Personnel
If w_main.dw_perms.Find("code=4", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

Choose Case dw_detail.DataObject
	Case "dw_personnel_detail"
		
		cb_first.enabled = False		
		m_main.m_general.m_first.enabled = False
		cb_back.enabled = False				
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False				
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False				
		m_main.m_general.m_last.enabled = False

		dw_detail.Tag = "Personnel Information"
		dw_detail.Reset()			
		dw_detail.InsertRow(0)
		dw_detail.SetItem(1,"ssan", "")							
		dw_detail.SetItem(1,"last_name", "")		
		dw_detail.SetItem(1,"first_name", "")		
		dw_detail.SetItem(1,"system_type", "CIV")		
		dw_detail.SetItem(1,"user_id", "")		
		dw_detail.SetItem(1,"user_password", "")				
 		
		dw_detail.SetRedraw(False)
		dw_detail.Modify("ssan.background.color = " + s_achDWColor + & 
			" ssan.tabsequence = 1" + &
			" last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 2" + &
			" first_name.background.color = " + s_achDWColor + & 
			" first_name.tabsequence = 3" + &
			" user_id.background.color = " + s_achDWColor + & 
			" user_id.tabsequence = 4")		
		dw_detail.SetRedraw(True)

		i_iRow = 1
		dw_detail.SetRow(i_iRow)								
		
End Choose	
		
dw_detail.SetFocus()

end event

event resize;gnv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
end event

type cb_escape from w_base_sheet`cb_escape within w_personnel_sheet
end type

type cb_exit from w_base_sheet`cb_exit within w_personnel_sheet
integer taborder = 160
end type

type cb_last from w_base_sheet`cb_last within w_personnel_sheet
integer taborder = 150
end type

type cb_next from w_base_sheet`cb_next within w_personnel_sheet
integer taborder = 140
end type

type cb_back from w_base_sheet`cb_back within w_personnel_sheet
integer taborder = 130
end type

type cb_first from w_base_sheet`cb_first within w_personnel_sheet
integer taborder = 120
end type

type cb_save from w_base_sheet`cb_save within w_personnel_sheet
integer taborder = 90
end type

type cb_delete from w_base_sheet`cb_delete within w_personnel_sheet
integer taborder = 80
end type

type cb_update from w_base_sheet`cb_update within w_personnel_sheet
integer taborder = 70
end type

type cb_add from w_base_sheet`cb_add within w_personnel_sheet
integer taborder = 60
end type

type cb_new from w_base_sheet`cb_new within w_personnel_sheet
integer taborder = 50
end type

type cb_clear from w_base_sheet`cb_clear within w_personnel_sheet
integer taborder = 40
end type

type cb_search from w_base_sheet`cb_search within w_personnel_sheet
integer taborder = 30
end type

type dw_detail from w_base_sheet`dw_detail within w_personnel_sheet
event ue_dwnkey pbm_dwnkey
integer y = 1306
integer width = 3101
integer height = 598
integer taborder = 180
string dataobject = "dw_personnel_detail"
end type

event dw_detail::ue_dwnkey;string s_achDWColor
integer s_iRow

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_personnel_detail"
		
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "user_id"
				If KeyDown(KeyEnter!) Or KeyDown(KeyTab!) Or KeyDown(KeySpaceBar!) Then		
					parent.TriggerEvent("ue_save")
					Return
				End If
	
		End Choose 
End Choose 
end event

type dw_scan from w_base_sheet`dw_scan within w_personnel_sheet
integer y = 128
integer width = 3101
integer height = 1152
integer taborder = 170
string dataobject = "dw_personnel_scan"
end type

event dw_scan::rowfocuschanged;dw_detail.SetTransObject(SQLCA)

i_irow = dw_scan.GetRow()
If i_irow > 0 Then
	Choose Case dw_detail.DataObject
		Case "dw_personnel_detail"
			dw_detail.Tag = "Personnel Information"
			
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(currentrow, True)				
			
			dw_detail.Retrieve(dw_scan.GetItemString(i_irow, "ssan"))

	End Choose
	
End If	
end event

type gb_5 from w_base_sheet`gb_5 within w_personnel_sheet
end type

type gb_4 from w_base_sheet`gb_4 within w_personnel_sheet
end type

type gb_1 from w_base_sheet`gb_1 within w_personnel_sheet
end type

type gb_2 from w_base_sheet`gb_2 within w_personnel_sheet
end type

type cb_list from w_base_sheet`cb_list within w_personnel_sheet
integer taborder = 100
end type

type cb_detail from w_base_sheet`cb_detail within w_personnel_sheet
integer taborder = 110
end type

type gb_3 from w_base_sheet`gb_3 within w_personnel_sheet
end type

type st_1 from statictext within w_personnel_sheet
integer x = 40
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
string text = "Last Name:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_lname from singlelineedit within w_personnel_sheet
integer x = 443
integer y = 19
integer width = 600
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

type st_2 from statictext within w_personnel_sheet
integer x = 1262
integer y = 29
integer width = 168
integer height = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "First:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_fname from singlelineedit within w_personnel_sheet
integer x = 1437
integer y = 19
integer width = 592
integer height = 86
integer taborder = 20
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

