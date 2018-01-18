$PBExportHeader$w_incremented_number_sheet.srw
forward
global type w_incremented_number_sheet from w_base_sheet
end type
type st_1 from statictext within w_incremented_number_sheet
end type
type sle_num_type from singlelineedit within w_incremented_number_sheet
end type
type st_2 from statictext within w_incremented_number_sheet
end type
type sle_year from singlelineedit within w_incremented_number_sheet
end type
end forward

global type w_incremented_number_sheet from w_base_sheet
integer x = 88
integer y = 35
integer width = 3690
integer height = 2067
string title = "Incremented Numbers"
toolbaralignment toolbaralignment = alignatleft!
st_1 st_1
sle_num_type sle_num_type
st_2 st_2
sle_year sle_year
end type
global w_incremented_number_sheet w_incremented_number_sheet

type variables
boolean i_bFirstSearch
string i_achSaveSQL
string i_achNumType
integer i_iYear

end variables

event ue_search;call super::ue_search;// script variables
string s_achSQL, s_achDWColor
datawindowchild dwc

SetPointer(HourGlass!)

s_achDWColor = dw_detail.Describe("datawindow.color")

cb_add.enabled = False
m_main.m_general.m_add.enabled = False

// Security - New Incremented Numbers
If w_main.dw_perms.Find("code=34", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_new.enabled = True
	m_main.m_general.m_new.enabled = True
End If

// Security - Update Incremented Numbers
If w_main.dw_perms.Find("code=35", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_update.enabled = True	
	m_main.m_general.m_update.enabled = True
End If

// Security - Delete Incremented Numbers
If w_main.dw_perms.Find("code=36", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_delete.enabled = True	
	m_main.m_general.m_delete.enabled = True
End If

dw_detail.DataObject = "dw_incremented_number_detail"

dw_detail.SetRedraw(False)
dw_detail.Modify("civil_year.background.color = " + s_achDWColor + & 
	" civil_year.tabsequence = 0" + &
	" number_type.background.color = " + s_achDWColor + & 
	" number_type.tabsequence = 0" + &
	" description.background.color = " + s_achDWColor + & 
	" description.tabsequence = 0" + &		
	" max_number.background.color = " + s_achDWColor + & 
	" max_number.tabsequence = 0")			
dw_detail.SetRedraw(True)

i_achNumType = Trim(sle_num_type.text)
i_iYear = Integer(Trim(sle_year.text))

If i_achNumType <> "" Then
   If Len(s_achSQL) = 0 Then
      s_achSQL = &
         " WHERE ut_incremented_number.number_type LIKE ~~~'" + i_achNumType + "%" + "~~~'" 
   Else 
		s_achSQL += &
         " AND ut_incremented_number.number_type LIKE ~~~'" + i_achNumType + "%" + "~~~'" 
   End If
End If

If i_iYear <> 0 Then
   If Len(s_achSQL) = 0 Then
      s_achSQL = &
         " WHERE ut_incremented_number.civil_year = " + String(i_iYear)
   Else 
		s_achSQL += &
         " AND ut_incremented_number.civil_year = " + String(i_iYear) 
   End If
End If

s_achSQL += &
   " ORDER BY ut_incremented_number.civil_year DESC, ut_incremented_number.number_type ASC" 
s_achSQL = i_achSQL + s_achSQL
i_achSaveSQL = s_achSQL

dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")

dw_scan.Reset()
If dw_scan.Retrieve() = 0 Then
	MessageBox("Complete", "No Incremented Number rows found.")
	If sle_num_type.text <> "" Then 
		sle_num_type.text = ""
		sle_year.text = ""
		sle_num_type.SetFocus()
	End If
Else
   dw_scan.SetFocus()
End If
end event

on w_incremented_number_sheet.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_num_type=create sle_num_type
this.st_2=create st_2
this.sle_year=create sle_year
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_num_type
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.sle_year
end on

on w_incremented_number_sheet.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_num_type)
destroy(this.st_2)
destroy(this.sle_year)
end on

event open;datawindowchild	dwc

i_achSQL = dw_scan.GetSQLSelect()
dw_scan.SetTransObject(SQLCA)

this.Visible = False
//this.SetRedraw(False)
PostEvent("ue_move_window")
//this.SetRedraw(True)

gnv_resize = create n_cst_resize
gnv_resize.of_SetOrigSize (this.Width, this.Height )
gnv_resize.of_Register(dw_scan, gnv_resize.SCALE)
gnv_resize.of_Register(dw_detail, gnv_resize.SCALE)
gnv_resize.of_Register(st_1, gnv_resize.SCALE)
gnv_resize.of_Register(st_2, gnv_resize.SCALE)
gnv_resize.of_Register(sle_num_type, gnv_resize.SCALE)
gnv_resize.of_Register(sle_year, gnv_resize.SCALE)

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

sle_num_type.SetFocus()

end event

event ue_back;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_incremented_number_detail"
		
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
	Case "dw_incremented_number_detail"

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

i_achOpType ="Update"

s_achDWColor = dw_scan.Describe("datawindow.color")

i_iRow = dw_detail.GetRow()
Choose Case dw_detail.DataObject
	Case "dw_incremented_number_detail"

		dw_detail.SetRedraw(False)
		dw_detail.Modify("max_number.background.color = " + s_achDWColor + & 
			" max_number.tabsequence = 1")			
		dw_detail.SetColumn("max_number")			
			
End Choose

dw_detail.SetRedraw(True)
dw_detail.SetRow(i_iRow)		
dw_detail.SetFocus()


end event

event ue_clear;call super::ue_clear;
sle_num_type.text = ""
sle_year.text = ""

i_bFirstSearch = True
i_achOpType = ""
i_achNumType = ""
i_iYear = 0

cb_first.enabled = False							
m_main.m_general.m_first.enabled = False		
cb_back.enabled = False									
m_main.m_general.m_back.enabled = False
cb_next.enabled = False									
m_main.m_general.m_next.enabled = False
cb_last.enabled = False									
m_main.m_general.m_last.enabled = False

sle_num_type.SetFocus()



end event

event ue_val_fields;
integer s_iRowCount, s_iCount

dw_detail.SetTransObject(SQLCA)
dw_detail.AcceptText()
Choose Case dw_detail.DataObject
	
	Case "dw_incremented_number_detail"
		
		If IsNull(dw_detail.GetItemNumber(1,"civil_year")) Or (dw_detail.GetItemNumber(1,"civil_year") = 0) Then
			i_ivalflag = 1 
			MessageBox("Error", "Year must be entered!")
			dw_detail.SetColumn("civil_year")
			dw_detail.SetFocus()
			Return
		End If	
		
		If IsNull(dw_detail.GetItemString(1,"number_type")) Or (dw_detail.GetItemString(1,"number_type") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Number type must be entered!")
			dw_detail.SetColumn("number_type")
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

	
Choose Case dw_detail.DataObject
	Case "dw_incremented_number_detail"

End Choose	

end event

event ue_save;call super::ue_save;// script variables
string s_achDWColor, s_achSQL, s_achNumType
integer s_iYear

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_incremented_number_detail"
		
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
			dw_detail.Modify("civil_year.background.color = " + s_achDWColor + & 
				" civil_year.tabsequence = 0" + &
				" number_type.background.color = " + s_achDWColor + & 
				" number_type.tabsequence = 0" + &
				" description.background.color = " + s_achDWColor + & 
				" description.tabsequence = 0" + &		
				" max_number.background.color = " + s_achDWColor + & 
				" max_number.tabsequence = 0")			
			dw_detail.SetRedraw(True)			
			
			// Security - Add Incremented Numbers
			If w_main.dw_perms.Find("code=34", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_new.enabled = True
				m_main.m_general.m_new.enabled = True
			End If
			
			// Security - Update Incremented Numbers
			If w_main.dw_perms.Find("code=35", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_update.enabled = True				
				m_main.m_general.m_update.enabled = True
			End If
			
			// Security - Delete Incremented Numbers
			If w_main.dw_perms.Find("code=36", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_delete.enabled = True				
				m_main.m_general.m_delete.enabled = True
			End If

			cb_save.enabled = False			
			m_main.m_general.m_save.enabled = False
			
			i_bFirstSearch = False
			integer s_iRow
			i_iRow = dw_detail.GetRow()
	
			s_iYear = dw_detail.GetItemNumber(i_iRow,"civil_year")
			s_achNumType = dw_detail.GetItemString(i_iRow,"number_type")
				
			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)
			dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
			dw_scan.Retrieve() 			

			// find the row closest to this one
			s_iRow = dw_scan.Find("civil_year = " + String(s_iYear) + &
				" AND number_type = '" + s_achNumType + "'", 0, dw_scan.RowCount())

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
	Case "dw_incremented_number_detail"

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
	
	Case "dw_incremented_number_detail"

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

// Security - Add Incremented Numbers
If w_main.dw_perms.Find("code=34", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True
	m_main.m_general.m_save.enabled = True
End If

// Security - Update Incremented Numbers
If w_main.dw_perms.Find("code=35", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

// Security - Delete Incremented Numbers
If w_main.dw_perms.Find("code=36", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

Choose Case dw_detail.DataObject
	Case "dw_incremented_number_detail"
		
		cb_first.enabled = False
		m_main.m_general.m_first.enabled = False
		cb_back.enabled = False		
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False		
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False		
		m_main.m_general.m_last.enabled = False

		dw_detail.Tag = "Incremented Number Information"
		dw_detail.Reset()			
		dw_detail.InsertRow(0)
		dw_detail.SetItem(1,"civil_year", 0)							
		dw_detail.SetItem(1,"number_type", "")		
		dw_detail.SetItem(1,"description", "")				
		dw_detail.SetItem(1,"max_number", 0)				
 		
		dw_detail.SetRedraw(False)
		dw_detail.Modify("civil_year.background.color = " + s_achDWColor + & 
			" civil_year.tabsequence = 1" + &
			" number_type.background.color = " + s_achDWColor + & 
			" number_type.tabsequence = 2" + &
			" description.background.color = " + s_achDWColor + & 
			" description.tabsequence = 3" + &		
			" max_number.background.color = " + s_achDWColor + & 
			" max_number.tabsequence = 4")			
		dw_detail.SetRedraw(True)

		i_iRow = 1
		dw_detail.SetRow(i_iRow)								
		
End Choose	
		
dw_detail.SetFocus()

end event

event resize;gnv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
end event

type cb_escape from w_base_sheet`cb_escape within w_incremented_number_sheet
integer taborder = 180
end type

type cb_exit from w_base_sheet`cb_exit within w_incremented_number_sheet
integer taborder = 190
end type

type cb_last from w_base_sheet`cb_last within w_incremented_number_sheet
integer taborder = 170
end type

type cb_next from w_base_sheet`cb_next within w_incremented_number_sheet
integer taborder = 160
end type

type cb_back from w_base_sheet`cb_back within w_incremented_number_sheet
integer taborder = 150
end type

type cb_first from w_base_sheet`cb_first within w_incremented_number_sheet
integer taborder = 140
end type

type cb_save from w_base_sheet`cb_save within w_incremented_number_sheet
integer taborder = 110
end type

type cb_delete from w_base_sheet`cb_delete within w_incremented_number_sheet
integer taborder = 100
end type

type cb_update from w_base_sheet`cb_update within w_incremented_number_sheet
integer taborder = 90
end type

type cb_add from w_base_sheet`cb_add within w_incremented_number_sheet
integer taborder = 70
end type

type cb_new from w_base_sheet`cb_new within w_incremented_number_sheet
integer taborder = 50
end type

type cb_clear from w_base_sheet`cb_clear within w_incremented_number_sheet
integer taborder = 40
end type

type cb_search from w_base_sheet`cb_search within w_incremented_number_sheet
integer taborder = 30
end type

type dw_detail from w_base_sheet`dw_detail within w_incremented_number_sheet
event ue_dwnkey pbm_dwnkey
integer y = 1290
integer width = 3072
integer height = 576
integer taborder = 80
string dataobject = "dw_incremented_number_detail"
end type

event dw_detail::ue_dwnkey;string s_achDWColor
integer s_iRow

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_incremented_number_detail"
		
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "max_number"
				If KeyDown(KeyEnter!) Or KeyDown(KeyTab!) Then		
					parent.TriggerEvent("ue_save")
					Return
				End If
	
		End Choose 
End Choose 
end event

type dw_scan from w_base_sheet`dw_scan within w_incremented_number_sheet
integer y = 128
integer width = 3072
integer height = 1136
integer taborder = 60
string dataobject = "dw_incremented_number_scan"
end type

event dw_scan::rowfocuschanged;dw_detail.SetTransObject(SQLCA)

i_irow = dw_scan.GetRow()
If i_irow > 0 Then
	Choose Case dw_detail.DataObject
		Case "dw_incremented_number_detail"
			dw_detail.Tag = "Incremented Number Information"

			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(currentrow, True)				
			
			dw_detail.Retrieve(dw_scan.GetItemNumber(i_irow, "civil_year"), &
				dw_scan.GetItemString(i_irow, "number_type"))			

	End Choose
	
End If	
end event

type gb_5 from w_base_sheet`gb_5 within w_incremented_number_sheet
end type

type gb_4 from w_base_sheet`gb_4 within w_incremented_number_sheet
end type

type gb_1 from w_base_sheet`gb_1 within w_incremented_number_sheet
end type

type gb_2 from w_base_sheet`gb_2 within w_incremented_number_sheet
end type

type cb_list from w_base_sheet`cb_list within w_incremented_number_sheet
integer taborder = 120
end type

type cb_detail from w_base_sheet`cb_detail within w_incremented_number_sheet
integer taborder = 130
end type

type gb_3 from w_base_sheet`gb_3 within w_incremented_number_sheet
end type

type st_1 from statictext within w_incremented_number_sheet
integer x = 66
integer y = 29
integer width = 373
integer height = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Number Type:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_num_type from singlelineedit within w_incremented_number_sheet
integer x = 453
integer y = 19
integer width = 603
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

type st_2 from statictext within w_incremented_number_sheet
integer x = 1156
integer y = 29
integer width = 208
integer height = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Year:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_year from singlelineedit within w_incremented_number_sheet
integer x = 1375
integer y = 19
integer width = 285
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

