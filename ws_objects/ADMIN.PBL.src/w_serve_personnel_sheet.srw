$PBExportHeader$w_serve_personnel_sheet.srw
forward
global type w_serve_personnel_sheet from w_base_sheet
end type
type st_1 from statictext within w_serve_personnel_sheet
end type
type sle_lname from singlelineedit within w_serve_personnel_sheet
end type
end forward

global type w_serve_personnel_sheet from w_base_sheet
integer x = 88
integer y = 35
integer width = 3690
integer height = 2067
string title = "Serving Personnel"
windowstate windowstate = normal!
toolbaralignment toolbaralignment = alignatleft!
st_1 st_1
sle_lname sle_lname
end type
global w_serve_personnel_sheet w_serve_personnel_sheet

type variables
boolean i_bFirstSearch
string i_achSaveSQL
string i_achLName, i_achFName, i_achEmpNum

end variables

event ue_search;call super::ue_search;
// script variables
string s_achSQL, s_achDWColor
datawindowchild dwc

SetPointer(HourGlass!)

s_achDWColor = dw_detail.Describe("datawindow.color")

cb_add.enabled = False
m_main.m_general.m_add.enabled = False

// Security - New Serving Personel
If w_main.dw_perms.Find("code=72", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_new.enabled = True
	m_main.m_general.m_new.enabled = True
End If

// Security - Update Serving Personel
If w_main.dw_perms.Find("code=73", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_update.enabled = True	
	m_main.m_general.m_update.enabled = True
End If

// Security - Delete Serving Personel
If w_main.dw_perms.Find("code=74", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_delete.enabled = True	
	m_main.m_general.m_delete.enabled = True
End If

dw_detail.DataObject = "dw_serve_personnel_detail"

dw_detail.SetRedraw(False)
dw_detail.Modify("officer_name.background.color = " + s_achDWColor + & 
	" officer_name.tabsequence = 0")
dw_detail.SetRedraw(True)

i_achLName = Trim(sle_lname.text)

// didn't pick a last name

If i_achLName = "" Then
	s_achSQL = ""
Else
	// picked a last name
	s_achSQL = &
         " WHERE sh_serve_personnel.officer_name LIKE ~~~'" + i_achLName + "%" + "~~~'" 
End If

s_achSQL += &
   " ORDER BY sh_serve_personnel.officer_name ASC" 
s_achSQL = i_achSQL + s_achSQL
i_achSaveSQL = s_achSQL

dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")

dw_scan.Reset()
If dw_scan.Retrieve() = 0 Then
	MessageBox("Complete", "No Serving Personnel Information rows found.")
	If sle_lname.text <> "" Then 
		sle_lname.text = ""
		sle_lname.SetFocus()
	End If
Else
   dw_scan.SetFocus()
End If

end event

on w_serve_personnel_sheet.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_lname=create sle_lname
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_lname
end on

on w_serve_personnel_sheet.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_lname)
end on

event open;datawindowchild	dwc

//this.Height = dw_detail.Height + 2000
//this.Width = dw_detail.Width + 650

i_achSQL = dw_scan.GetSQLSelect()
dw_scan.SetTransObject(SQLCA)

gnv_resize = create n_cst_resize
gnv_resize.of_SetOrigSize (this.Width, this.Height )
gnv_resize.of_Register(dw_scan, gnv_resize.SCALE)
gnv_resize.of_Register(dw_detail, gnv_resize.SCALE)
gnv_resize.of_Register(st_1, gnv_resize.SCALE)
gnv_resize.of_Register(sle_lname, gnv_resize.SCALE)

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
	Case "dw_serve_personnel_detail"
		
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
	Case "dw_serve_personnel_detail"

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
	Case "dw_serve_personnel_detail"

		dw_detail.SetRedraw(False)
		dw_detail.Modify("officer_name.background.color = " + s_achDWColor + & 
			" officer_name.tabsequence = 2")				
		dw_detail.SetColumn("officer_name")			
			
End Choose

dw_detail.SetRedraw(True)
dw_detail.SetRow(s_iRow)		
dw_detail.SetFocus()

end event

event ue_clear;call super::ue_clear;
sle_lname.text = ""

i_bFirstSearch = True
i_achOpType = ""
i_achEmpNum = ""
i_achLName = ""

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
	
	Case "dw_serve_personnel_detail"
		
		If IsNull(dw_detail.GetItemString(1,"officer_name")) Or (dw_detail.GetItemString(1,"officer_name") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Serving Officer Name must be entered!")
			dw_detail.SetColumn("officer_name")
			dw_detail.SetFocus()
			Return
		End If	

End Choose		

integer s_iLineNum
	
Choose Case dw_detail.DataObject
	Case "dw_serve_personnel_detail"
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

event ue_save;call super::ue_save;
// script variables
string s_achDWColor, s_achErrText, s_achSQL, s_achName

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_serve_personnel_detail"
		
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
			dw_detail.Modify("officer_name.background.color = " + s_achDWColor + & 
				" officer_name.tabsequence = 0")
			dw_detail.SetRedraw(True)			
			
			// Security - Add Serving Personel
			If w_main.dw_perms.Find("code=72", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_new.enabled = True
				m_main.m_general.m_new.enabled = True
			End If
			
			// Security - Update Serving Personel
			If w_main.dw_perms.Find("code=73", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_update.enabled = True				
				m_main.m_general.m_update.enabled = True
			End If
			
			// Security - Delete Serving Personel
			If w_main.dw_perms.Find("code=74", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_delete.enabled = True				
				m_main.m_general.m_delete.enabled = True
			End If
			
			cb_save.enabled = False
			m_main.m_general.m_save.enabled = False
			
			i_bFirstSearch = False
			integer s_iRow
			i_iRow = dw_detail.GetRow()
	
			s_achName = dw_detail.GetItemString(i_iRow,"officer_name")
				
			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)
			dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
			dw_scan.Retrieve() 			
	
			// find the row closest to this one
			s_iRow = dw_scan.Find("officer_name = '" + s_achName + "'", 0, dw_scan.RowCount())

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
	Case "dw_serve_personnel_detail"

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
	
	Case "dw_serve_personnel_detail"

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

// Security - Add Serving Personel
If w_main.dw_perms.Find("code=72", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True
	m_main.m_general.m_save.enabled = True
End If

// Security - Update Serving Personel
If w_main.dw_perms.Find("code=73", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

// Security - Delete Serving Personel
If w_main.dw_perms.Find("code=74", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

Choose Case dw_detail.DataObject
	Case "dw_serve_personnel_detail"
		
		cb_first.enabled = False		
		m_main.m_general.m_first.enabled = False
		cb_back.enabled = False				
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False				
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False				
		m_main.m_general.m_last.enabled = False

		dw_detail.Tag = "Serving Personnel Information"
		dw_detail.Reset()			
		dw_detail.InsertRow(0)
		dw_detail.SetItem(1,"officer_name", "")							
 		
		dw_detail.SetRedraw(False)
		dw_detail.Modify("officer_name.background.color = " + s_achDWColor + & 
			" officer_name.tabsequence = 1")		
		dw_detail.SetRedraw(True)

		i_iRow = 1
		dw_detail.SetRow(i_iRow)								
		
End Choose	
		
dw_detail.SetFocus()

end event

event resize;gnv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
end event

type cb_escape from w_base_sheet`cb_escape within w_serve_personnel_sheet
integer taborder = 140
end type

type cb_exit from w_base_sheet`cb_exit within w_serve_personnel_sheet
integer taborder = 160
end type

type cb_last from w_base_sheet`cb_last within w_serve_personnel_sheet
integer taborder = 150
end type

type cb_next from w_base_sheet`cb_next within w_serve_personnel_sheet
end type

type cb_back from w_base_sheet`cb_back within w_serve_personnel_sheet
end type

type cb_first from w_base_sheet`cb_first within w_serve_personnel_sheet
integer taborder = 110
end type

type cb_save from w_base_sheet`cb_save within w_serve_personnel_sheet
integer taborder = 80
end type

type cb_delete from w_base_sheet`cb_delete within w_serve_personnel_sheet
integer taborder = 70
end type

type cb_update from w_base_sheet`cb_update within w_serve_personnel_sheet
integer taborder = 60
end type

type cb_add from w_base_sheet`cb_add within w_serve_personnel_sheet
integer taborder = 50
end type

type cb_new from w_base_sheet`cb_new within w_serve_personnel_sheet
integer taborder = 40
end type

type cb_clear from w_base_sheet`cb_clear within w_serve_personnel_sheet
integer taborder = 30
end type

type cb_search from w_base_sheet`cb_search within w_serve_personnel_sheet
integer taborder = 20
end type

type dw_detail from w_base_sheet`dw_detail within w_serve_personnel_sheet
event ue_dwnkey pbm_dwnkey
integer y = 1453
integer width = 3101
integer height = 346
integer taborder = 180
string dataobject = "dw_serve_personnel_detail"
end type

event dw_detail::ue_dwnkey;string s_achDWColor
integer s_iRow

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_personnel_detail"
		
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "officer_name"
				If KeyDown(KeyEnter!) Or KeyDown(KeyTab!) Then		
					parent.TriggerEvent("ue_save")
					Return
				End If
	
		End Choose 
End Choose 
end event

type dw_scan from w_base_sheet`dw_scan within w_serve_personnel_sheet
integer y = 128
integer width = 3101
integer height = 1302
integer taborder = 170
string dataobject = "dw_serve_personnel_scan"
end type

event dw_scan::rowfocuschanged;dw_detail.SetTransObject(SQLCA)

i_irow = dw_scan.GetRow()
If i_irow > 0 Then
	Choose Case dw_detail.DataObject
		Case "dw_serve_personnel_detail"
			dw_detail.Tag = "Serving Personnel Information"
			
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(currentrow, True)				
			
			dw_detail.Retrieve(dw_scan.GetItemString(i_irow, "officer_name"))

	End Choose
	
End If	
end event

type gb_5 from w_base_sheet`gb_5 within w_serve_personnel_sheet
end type

type gb_4 from w_base_sheet`gb_4 within w_serve_personnel_sheet
end type

type gb_1 from w_base_sheet`gb_1 within w_serve_personnel_sheet
end type

type gb_2 from w_base_sheet`gb_2 within w_serve_personnel_sheet
end type

type cb_list from w_base_sheet`cb_list within w_serve_personnel_sheet
integer taborder = 90
end type

type cb_detail from w_base_sheet`cb_detail within w_serve_personnel_sheet
integer taborder = 100
end type

type gb_3 from w_base_sheet`gb_3 within w_serve_personnel_sheet
end type

type st_1 from statictext within w_serve_personnel_sheet
integer x = 219
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
string text = "Name:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_lname from singlelineedit within w_serve_personnel_sheet
integer x = 640
integer y = 19
integer width = 1335
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

