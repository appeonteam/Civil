$PBExportHeader$w_ledger_sheet.srw
forward
global type w_ledger_sheet from w_base_sheet
end type
type dw_single_doc from datawindow within w_ledger_sheet
end type
type em_year from editmask within w_ledger_sheet
end type
type st_4 from statictext within w_ledger_sheet
end type
end forward

global type w_ledger_sheet from w_base_sheet
integer x = 40
integer y = 29
integer width = 3771
integer height = 2112
string title = "Check Book Ledger Information"
toolbaralignment toolbaralignment = alignatleft!
dw_single_doc dw_single_doc
em_year em_year
st_4 st_4
end type
global w_ledger_sheet w_ledger_sheet

type variables
string i_achSaveSQL, i_achMode, i_achNewSQL
integer i_iFY, i_iTreYear
boolean i_bFirstSearch, i_bExit, i_bContinueItem, i_bName
boolean i_bNew, i_bButtonOnly



end variables

on w_ledger_sheet.create
int iCurrent
call super::create
this.dw_single_doc=create dw_single_doc
this.em_year=create em_year
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_single_doc
this.Control[iCurrent+2]=this.em_year
this.Control[iCurrent+3]=this.st_4
end on

on w_ledger_sheet.destroy
call super::destroy
destroy(this.dw_single_doc)
destroy(this.em_year)
destroy(this.st_4)
end on

event ue_search;call super::ue_search;// script variables
string s_achSQL, s_achDWColor
string s_achNewSQL
integer s_iNumRows, s_iPosition, s_iTaxYear

SetPointer(HourGlass!)

i_bButtonOnly = False

cb_add.enabled = False
m_main.m_general.m_add.enabled = False

// Security - Add Ledger Information
If w_main.dw_perms.Find("code=58", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_new.enabled = True
	m_main.m_general.m_new.enabled = True
End If

// Security - Update Ledger Information
If w_main.dw_perms.Find("code=59", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_update.enabled = True
	m_main.m_general.m_update.enabled = True
End If

// Security - Delete Ledger Information
If w_main.dw_perms.Find("code=60", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_delete.enabled = True	
	m_main.m_general.m_delete.enabled = True
End If

s_achDWColor = dw_detail.Describe("datawindow.color")

dw_detail.DataObject = "dw_ledger_detail"

dw_detail.SetRedraw(False)
dw_detail.Modify("dock_year.background.color = " + s_achDWColor + & 
	" dock_year.tabsequence = 0" + &				
	" beg_balance.background.color = " + s_achDWColor + & 
	" beg_balance.tabsequence = 0")
dw_detail.SetRedraw(True)

i_iTREYear = Integer(em_year.text)

// Dock Year
If i_iTreYear <> 0 Then
	If Len(s_achSQL) = 0 Then
		s_achSQL = &
			 " AND ut_ledger.dock_year = " + String(i_iTreYear)
	Else
		s_achSQL += &
			 " AND ut_ledger.dock_year = " + String(i_iTreYear)
	End If	
End If

s_achSQL += &
   " ORDER BY ut_ledger.dock_year DESC" 
s_achSQL = i_achSQL + s_achSQL
i_achSaveSQL = s_achSQL

// NEW Entry
s_achNewSQL += &
   " ORDER BY ut_ledger.dock_year DESC" 
i_achNewSQL = i_achSQL + s_achNewSQL

dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")

dw_scan.Reset()
If dw_scan.Retrieve() = 0 Then
	MessageBox("Complete", "No Check Book Ledger rows found.")

	em_year.text = String(i_iTreYear)

	em_year.SetFocus()
Else
	
   dw_scan.SetFocus()
	
	// RowFocusChanged Trigger for Title Refreshment
	dw_detail.TriggerEvent(RowFocusChanged!)			
End If

end event

event open;datawindowchild	dwc

SetPointer(HourGlass!)

//this.Width = dw_scan.width + dw_scan.x + 1100  
i_achSQL = dw_scan.GetSQLSelect()
dw_scan.SetTransObject(SQLCA)

this.Visible = False
PostEvent("ue_move_window")

//this.Height = dw_detail.Height + 2000
//this.Width = dw_detail.Width + 700

gnv_resize = create n_cst_resize
gnv_resize.of_SetOrigSize (this.Width, this.Height )
gnv_resize.of_Register(dw_scan, gnv_resize.SCALE)
gnv_resize.of_Register(dw_detail, gnv_resize.SCALE)
gnv_resize.of_Register(st_4, gnv_resize.SCALE)
gnv_resize.of_Register(em_year, gnv_resize.SCALE)

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

i_iTreYear = g_iCurrYear
em_year.text = String(i_iTreYear)
em_year.SetFocus()

// Ancestor Controls
cb_add.pointer="arrow!"
cb_back.pointer="arrow!"
cb_clear.pointer="arrow!"
cb_delete.pointer="arrow!"
cb_detail.pointer="arrow!"
cb_escape.pointer="arrow!"
cb_exit.pointer="arrow!"
cb_first.pointer="arrow!"
cb_last.pointer="arrow!"
cb_list.pointer="arrow!"
cb_new.pointer="arrow!"
cb_next.pointer="arrow!"
cb_save.pointer="arrow!"
cb_search.pointer="arrow!"
cb_update.pointer="arrow!"
gb_1.pointer="arrow!"
gb_2.pointer="arrow!"
gb_3.pointer="arrow!"
gb_4.pointer="arrow!"
gb_5.pointer="arrow!"

end event

event ue_next;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_ledger_detail"
		
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

event ue_back;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_ledger_detail"

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

event ue_val_fields;integer s_iRowCount, s_iRow, s_iParcelYear
string s_achLevyCode, s_achLevyAuthorityCode, s_achTaxDistrict
long s_lLineNum, s_lLevyAuthorityLevyRows, s_lTDLevyAuthorityRows, s_lCount, s_lCount2
decimal {5} s_dLevyRate, s_dOldLevyRate, s_dTotalLevyRate, s_dTotalLevyAuthorityLevyRate
decimal {5} s_dTotalLevyAuthorityRate, s_dTotalTDLevyAuthorityRate

datastore lds_LevyAuthorityLevy, lds_TDLevyAuthority

dw_detail.SetTransObject(SQLCA)
dw_detail.AcceptText()
Choose Case dw_detail.DataObject
	
	Case "dw_ledger_detail"

		If IsNull(dw_detail.GetItemNumber(1,"dock_year")) Or (dw_detail.GetItemNumber(1,"dock_year") = 0) Then
			i_ivalflag = 1 
			MessageBox("Error", "Dock year MUST be entered!")
			dw_detail.SetColumn("dock_year")
			dw_detail.SetFocus()
			Return
		End If	
End Choose		

Choose Case dw_detail.DataObject

	Case "dw_ledger_detail"

		If i_achOpType = "Add" Or i_achOpType = "Update" Then		
			dw_detail.SetItem(s_iRow, "last_chg_login", g_achUserID)					
			dw_detail.SetItem(s_iRow, "last_chg_datetime", g_dtToday)					
			dw_detail.Update()
		End If
		
End Choose   

end event

event ue_clear;call super::ue_clear;
em_year.text = String(i_iTreYear)

i_achOpType = ""
i_bFirstSearch = True

cb_first.enabled = False
m_main.m_general.m_first.enabled = False
cb_back.enabled = False
m_main.m_general.m_back.enabled = False
cb_next.enabled = False
m_main.m_general.m_next.enabled = False
cb_last.enabled = False
m_main.m_general.m_last.enabled = False

em_year.SetFocus()

dw_detail.Tag = "Check Book Ledger Information"
dw_detail.DataObject = "dw_ledger_detail"
dw_detail.SetTransObject(SQLCA)
end event

event ue_first;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_ledger_detail"
		
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

event ue_update;call super::ue_update;string s_achDWColor, s_achDDWColor
integer s_iRow, s_iScanRow

i_achOpType ="Update"

s_achDWColor = dw_scan.Describe("datawindow.color")
s_achDDWColor = dw_detail.Describe("datawindow.color")

s_iScanRow = dw_scan.GetRow()
s_iRow = dw_detail.GetRow()
Choose Case dw_detail.DataObject
			 
	Case "dw_ledger_detail"

		dw_detail.SetRedraw(False)
		dw_detail.Modify("beg_balance.background.color = " + s_achDWColor + & 
			" beg_balance.tabsequence = 3")		
		dw_detail.SetColumn("beg_balance")						
		
End Choose 
dw_detail.SetRedraw(True)
dw_detail.SetRow(s_iRow)		
dw_detail.SetFocus()

end event

event ue_save;// script variables
string s_achDWColor, s_achErrText
integer s_iCount, s_iRowCount, s_iRow, s_iDockYear, s_iItemRow
string s_achCBType
long s_lLineNum, s_lCount, s_lCount2
long s_lLevyRows, s_lLCount, s_lRow, s_lItemCount, s_lItemRow

datastore lds_CollectionItem

SetPointer(HourGlass!)

// validate the fields
i_iValFlag = 0 
TriggerEvent("ue_val_fields")
If i_iValFlag <> 0 Then Return

dw_detail.AcceptText()
If dw_detail.Update(False) = -1 Then
	ROLLBACK;
Else
	COMMIT;
	If SQLCA.SQLCode = -1 Then
		s_achErrText = SQLCA.SQLErrText
		ROLLBACK USING SQLCA;
		MessageBox("Error", "Update Failed - " + s_achErrText)
	End If
End If

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_ledger_detail"

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
			dw_detail.Modify("dock_year.background.color = " + s_achDWColor + & 
				" dock_year.tabsequence = 0" + &				
				" beg_balance.background.color = " + s_achDWColor + & 
				" beg_balance.tabsequence = 0")
			dw_detail.SetRedraw(True)		

			// Security - Add RE Collection Ledger Information
			If w_main.dw_perms.Find("code=58", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_new.enabled = True
				m_main.m_general.m_new.enabled = True
			End If
			
			// Security - Update RE Collection Ledger Information
			If w_main.dw_perms.Find("code=59", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_update.enabled = True				
				m_main.m_general.m_update.enabled = True
			End If
			
			// Security - Delete RE Collection Ledger Information
			If w_main.dw_perms.Find("code=60", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_delete.enabled = True				
				m_main.m_general.m_delete.enabled = True
			End If

			cb_escape.enabled = False
			m_main.m_general.m_escape.enabled = False
			cb_save.enabled = False
			m_main.m_general.m_save.enabled = False
			
			s_iRow = dw_detail.GetRow()
			
			s_iDockYear = dw_detail.GetItemNumber(s_iRow,"dock_year")							
			
			If i_achOpType = "Add" Then
				
				// get ledger item records
				// allocate the resources for the datastores
				lds_CollectionItem = Create DataStore
					
				lds_CollectionItem.DataObject = 'dw_create_collection_items_ds'
				lds_CollectionItem.SetTransObject(SQLCA)
	
				For s_iItemRow = 1 To 12
		
					// Create new tax collection item record
					s_iItemRow = lds_CollectionItem.InsertRow(0)
					lds_CollectionItem.SetItem(s_iItemRow,"dock_year", s_iDockYear)					
					lds_CollectionItem.SetItem(s_iItemRow,"period", s_iItemRow)						
					lds_CollectionItem.SetItem(s_iItemRow,"period_bal", 0)				
	
				Next
				lds_CollectionItem.Update()
			End If

			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)			

//			If i_achOpType = "Add" Then			
//				dw_scan.Modify("datawindow.table.select='" + i_achNewSQL + "'")			
//			Else	
				dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
//			End If
			dw_scan.Retrieve() 			

			integer s_sRow
			s_sRow = dw_scan.Find("dock_year = " + String(s_iDockYear) + &
				" AND cb_type = '" + s_achCBType + "'", 0, dw_scan.RowCount())								

			If s_sRow = 0 Then s_sRow = 1
	
			// highlight only the closest row
			dw_scan.ScrollToRow(s_sRow)				
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(s_sRow, True)										
	
			dw_scan.SetRedraw(True)
			dw_scan.enabled = True			
		
			If i_achMode = "Continue" And i_bNew = True Then
				If i_achOpType = "Add" Then
					m_main.m_general.m_new.PostEvent("clicked")
				End If	
			End If							
			
		End If

End Choose

dw_scan.SetFocus()

end event

event ue_last;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_ledger_detail"
		
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

event ue_new;call super::ue_new;datawindowchild dwc
string s_achDWColor, s_achType
integer s_iAudYear

s_achDWColor = dw_scan.Describe("datawindow.color")

SetPointer(Hourglass!)

i_bButtonOnly = False
i_bNew = True
i_achOpType = "Add"
i_achMode = "Continue"
i_bExit = False

cb_new.enabled = False
m_main.m_general.m_new.enabled = False
cb_add.enabled = False
m_main.m_general.m_add.enabled = False
cb_delete.enabled = False
m_main.m_general.m_delete.enabled = False
cb_update.enabled = False
m_main.m_general.m_update.enabled = False

// Security - Add RE Collection Ledger Information
If w_main.dw_perms.Find("code=58", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_escape.enabled = True
	m_main.m_general.m_escape.enabled = True	
	cb_save.enabled = True
	m_main.m_general.m_save.enabled = True
End If

// Security - Update RE Collection Ledger Information
If w_main.dw_perms.Find("code=59", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_escape.enabled = True
	m_main.m_general.m_escape.enabled = True		
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

// Security - Delete RE Collection Ledger Information
If w_main.dw_perms.Find("code=60", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_escape.enabled = True
	m_main.m_general.m_escape.enabled = True		
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

dw_detail.Tag = "Check Book Ledger Information"
dw_detail.DataObject = "dw_ledger_detail"
dw_detail.SetTransObject(SQLCA)

Choose Case dw_detail.DataObject
	Case "dw_ledger_detail"

		// get Fee Type
		dw_detail.GetChild("fee_type", dwc)
		dwc.SetTransObject(SQLCA)
		dwc.Reset()
		dwc.Retrieve("FEE")

		dw_detail.Tag = "Check Book Ledger Information"		
		dw_detail.Reset()		
		dw_detail.InsertRow(0)
		
		dw_detail.SetItem(1,"dock_year", g_iCurrYear)																			
		dw_detail.SetItem(1,"beg_balance", 0)																	
		dw_detail.SetItem(1,"last_chg_login", "")					
		dw_detail.SetItem(1,"last_chg_datetime", "")							
										
		dw_detail.SetRedraw(False)
		dw_detail.Modify("dock_year.background.color = " + s_achDWColor + & 
			" dock_year.tabsequence = 1" + &						
			" beg_balance.background.color = " + s_achDWColor + & 
			" beg_balance.tabsequence = 4")
		dw_detail.SetRedraw(True)		
		
		i_iRow = 1
		dw_detail.SetRow(i_iRow)		
		dw_detail.ScrollToRow(i_iRow)								

End Choose	

dw_detail.SetFocus()

end event

event ue_delete;// script variables
string s_achErrText
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

dw_scan.enabled = False			
Choose Case dw_detail.DataObject
	Case "dw_ledger_detail"
		
		cb_first.enabled = False
		m_main.m_general.m_first.enabled = False					
		cb_back.enabled = False		
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False		
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False		
		m_main.m_general.m_last.enabled = False

		If dw_detail.RowCount() = 0 Then
		   MessageBox("Error","Select Row to Delete",StopSign!)
		Else
		   If 2 = MessageBox("Delete","Delete This Check Book Ledger?",Question!,OkCancel!,2) Then
		      MessageBox("Delete","Check Book Ledger NOT Deleted",None!)
		   Else
		
				SetPointer(Hourglass!) 

				i_iRow = dw_detail.GetRow()				

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
						TriggerEvent("ue_search")				
						
					End If
				End If
			End If
		End If

End Choose
dw_scan.enabled = True			
end event

event ue_print_detail;datawindowchild dwc
string s_achReport, s_achDocNum

s_achReport = "Single Document Indexing Document"

s_achDocNum = dw_scan.GetItemString(i_iRow, "document_number")

// Retrieve Information
dw_single_doc.SetTransObject(SQLCA)
dw_single_doc.Reset()

// get Group Number
dw_single_doc.GetChild("group_number", dwc)
dwc.SetTransObject(SQLCA)
dwc.Reset()
dwc.Retrieve("GROUP")

// get Doc Type
dw_single_doc.GetChild("doc_type", dwc)
dwc.SetTransObject(SQLCA)
dwc.Reset()
dwc.Retrieve("DOC")

// get Payment Type
dw_single_doc.GetChild("payment_type", dwc)
dwc.SetTransObject(SQLCA)
dwc.Reset()
dwc.Retrieve("PAY")

// get Document Exemption Type
dw_single_doc.GetChild("exemption_number", dwc)
dwc.SetTransObject(SQLCA)
dwc.Reset()
dwc.Retrieve("DEXEM")

dw_single_doc.Retrieve(s_achDocNum)	

// Printer Setup and Printout depending on current detail window
PrintSetup()

dw_single_doc.Print()

end event

event ue_escape;call super::ue_escape;//string s_achDWColor, s_achDocNum
//integer s_iRow
//datawindowchild dwc
//
//s_achDWColor = dw_detail.Describe("datawindow.color")
//
//Choose Case dw_detail.DataObject
//
//	Case "dw_document_index_detail"
//
//		s_iRow = dw_scan.GetRow()
//
//		cb_first.enabled = False
//		m_main.m_general.m_first.enabled = False
//		cb_back.enabled = False		
//		m_main.m_general.m_back.enabled = False
//		cb_next.enabled = False				
//		m_main.m_general.m_next.enabled = False
//		cb_last.enabled = False		
//		m_main.m_general.m_last.enabled = False
//
//		// Security - Add Document Indexing Information
//		If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
//			cb_new.enabled = True
//			m_main.m_general.m_new.enabled = True
//		End If
//		
//		// Security - Update Document Indexing Information
//		If w_main.dw_perms.Find("code=51", 1, w_main.dw_perms.RowCount()) > 0 Then
//			cb_update.enabled = True				
//			m_main.m_general.m_update.enabled = True
//		End If
//		
//		// Security - Delete Document Indexing Information
//		If w_main.dw_perms.Find("code=52", 1, w_main.dw_perms.RowCount()) > 0 Then
//			cb_delete.enabled = True				
//			m_main.m_general.m_delete.enabled = True
//		End If
//
//		cb_escape.enabled = False
//		m_main.m_general.m_escape.enabled = False
//		
//		cb_save.enabled = False
//		m_main.m_general.m_save.enabled = False
//		
//		cb_main.enabled = False
//		cb_legal.enabled = True			
//		cb_parcel.enabled = True		
//		cb_memo.enabled = True			
//		
//		dw_scan.enabled = True
//		
//		If s_iRow > 0 Then
//			s_achDocNum = Trim(dw_scan.GetItemString(s_iRow, "document_number"))
//			
//			dw_detail.SetRedraw(False)		
//			dw_detail.Modify("book.background.color = " + s_achDWColor + & 
//				" book.tabsequence = 0" + &				
//				" page.background.color = " + s_achDWColor + & 
//				" page.tabsequence = 0" + &					
//				" group_number.background.color = " + s_achDWColor + & 
//				" group_number.tabsequence = 0" + &		
//				" payment_type.background.color = " + s_achDWColor + & 
//				" payment_type.tabsequence = 0" + &									
//				" doc_type.background.color = " + s_achDWColor + & 
//				" doc_type.tabsequence = 0" + &						
//				" recording_fee.background.color = " + s_achDWColor + & 
//				" recording_fee.tabsequence = 0" + &									
//				" consideration.background.color = " + s_achDWColor + & 
//				" consideration.tabsequence = 0" + &									
//				" number_of_pages.background.color = " + s_achDWColor + & 
//				" number_of_pages.tabsequence = 0" + &									
//				" number_of_legals.background.color = " + s_achDWColor + & 
//				" number_of_legals.tabsequence = 0" + &												
//				" transfer_fee.background.color = " + s_achDWColor + & 
//				" transfer_fee.tabsequence = 0" + &			
//				" revenue_stamp.background.color = " + s_achDWColor + & 
//				" revenue_stamp.tabsequence = 0" + &						
//				" filing_date.background.color = " + s_achDWColor + & 
//				" filing_date.tabsequence = 0" + &				
//				" filing_time.background.color = " + s_achDWColor + & 
//				" filing_time.tabsequence = 0" + &							
//				" management_fee.background.color = " + s_achDWColor + & 
//				" management_fee.tabsequence = 0" + &						
//				" instrument_date.background.color = " + s_achDWColor + & 
//				" instrument_date.tabsequence = 0" + &
//				" dov_audit_number.background.color = " + s_achDWColor + & 
//				" dov_audit_number.tabsequence = 0" + &		
//				" ground_water_exemption.background.color = " + s_achDWColor + & 
//				" ground_water_exemption.tabsequence = 0" + &		
//				" exemption_number.background.color = " + s_achDWColor + & 
//				" exemption_number.tabsequence = 0" + &
//				" st_mail_to.visible = 0" + &									
//				" mail1.background.color = " + s_achDWColor + & 
//				" mail1.tabsequence = 0" + &					
//				" condominium.background.color = " + s_achDWColor + & 
//				" condominium.tabsequence = 0")				
//			dw_detail.SetRedraw(True)
//
//			// get Group Number
//			dw_detail.GetChild("group_number", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("GROUP")
//
//			// get Document Type
//			dw_detail.GetChild("doc_type", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("DOC")
//
//			// get Payment Type
//			dw_detail.GetChild("payment_type", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("PAY")
//			
//			// get Document Exemption Type
//			dw_detail.GetChild("exemption_number", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("DEXEM")
//
//			dw_detail.Retrieve(s_achDocNum)														
//
//		Else
//			dw_scan.Reset()
//			dw_detail.Reset()
//		End If
//		
//	Case "dw_document_index_grantor_grantee_detail"
//
//		s_iRow = dw_scan.GetRow()
//
//		cb_first.enabled = False
//		m_main.m_general.m_first.enabled = False
//		cb_back.enabled = False		
//		m_main.m_general.m_back.enabled = False
//		cb_next.enabled = False				
//		m_main.m_general.m_next.enabled = False
//		cb_last.enabled = False		
//		m_main.m_general.m_last.enabled = False
//
//		// Security - Add Document Indexing Information
//		If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
//			cb_new.enabled = True
//			m_main.m_general.m_new.enabled = True
//		End If
//		
//		// Security - Update Document Indexing Information
//		If w_main.dw_perms.Find("code=51", 1, w_main.dw_perms.RowCount()) > 0 Then
//			cb_update.enabled = True				
//			m_main.m_general.m_update.enabled = True
//		End If
//		
//		// Security - Delete Document Indexing Information
//		If w_main.dw_perms.Find("code=52", 1, w_main.dw_perms.RowCount()) > 0 Then
//			cb_delete.enabled = True				
//			m_main.m_general.m_delete.enabled = True
//		End If
//
//		cb_escape.enabled = False
//		m_main.m_general.m_escape.enabled = False
//		
//		cb_save.enabled = False
//		m_main.m_general.m_save.enabled = False
//		
//		cb_main.enabled = False
//		cb_legal.enabled = True			
//		cb_parcel.enabled = True		
//		cb_memo.enabled = True			
//		
//		dw_scan.enabled = True
//		
//		If s_iRow > 0 Then
//			s_achDocNum = Trim(dw_scan.GetItemString(s_iRow, "document_number"))
//
//			dw_detail.DataObject = "dw_document_index_detail"		
//			dw_detail.SetTransObject(SQLCA)
//			dw_detail.Tag = "Document Indexing Information"		
//
//			// get Group Number
//			dw_detail.GetChild("group_number", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("GROUP")
//
//			// get Document Type
//			dw_detail.GetChild("doc_type", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("DOC")
//
//			// get Payment Type
//			dw_detail.GetChild("payment_type", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("PAY")
//			
//			// get Document Exemption Type
//			dw_detail.GetChild("exemption_number", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("DEXEM")
//
//			dw_detail.Retrieve(s_achDocNum)														
//			
//			dw_detail.SetRedraw(False)		
//			dw_detail.Modify("book.background.color = " + s_achDWColor + & 
//				" book.tabsequence = 0" + &				
//				" page.background.color = " + s_achDWColor + & 
//				" page.tabsequence = 0" + &					
//				" group_number.background.color = " + s_achDWColor + & 
//				" group_number.tabsequence = 0" + &		
//				" payment_type.background.color = " + s_achDWColor + & 
//				" payment_type.tabsequence = 0" + &									
//				" doc_type.background.color = " + s_achDWColor + & 
//				" doc_type.tabsequence = 0" + &						
//				" recording_fee.background.color = " + s_achDWColor + & 
//				" recording_fee.tabsequence = 0" + &									
//				" consideration.background.color = " + s_achDWColor + & 
//				" consideration.tabsequence = 0" + &									
//				" number_of_pages.background.color = " + s_achDWColor + & 
//				" number_of_pages.tabsequence = 0" + &									
//				" number_of_legals.background.color = " + s_achDWColor + & 
//				" number_of_legals.tabsequence = 0" + &												
//				" transfer_fee.background.color = " + s_achDWColor + & 
//				" transfer_fee.tabsequence = 0" + &			
//				" revenue_stamp.background.color = " + s_achDWColor + & 
//				" revenue_stamp.tabsequence = 0" + &						
//				" filing_date.background.color = " + s_achDWColor + & 
//				" filing_date.tabsequence = 0" + &				
//				" filing_time.background.color = " + s_achDWColor + & 
//				" filing_time.tabsequence = 0" + &							
//				" management_fee.background.color = " + s_achDWColor + & 
//				" management_fee.tabsequence = 0" + &						
//				" instrument_date.background.color = " + s_achDWColor + & 
//				" instrument_date.tabsequence = 0" + &
//				" dov_audit_number.background.color = " + s_achDWColor + & 
//				" dov_audit_number.tabsequence = 0" + &		
//				" ground_water_exemption.background.color = " + s_achDWColor + & 
//				" ground_water_exemption.tabsequence = 0" + &		
//				" exemption_number.background.color = " + s_achDWColor + & 
//				" exemption_number.tabsequence = 0" + &
//				" st_mail_to.visible = 0" + &									
//				" mail1.background.color = " + s_achDWColor + & 
//				" mail1.tabsequence = 0" + &					
//				" condominium.background.color = " + s_achDWColor + & 
//				" condominium.tabsequence = 0")				
//			dw_detail.SetRedraw(True)
//
//		Else
//			dw_scan.Reset()
//			dw_detail.Reset()
//		End If		
//		
//	Case "dw_document_index_legal_detail"
//
//		s_iRow = dw_scan.GetRow()
//
//		cb_first.enabled = False
//		m_main.m_general.m_first.enabled = False
//		cb_back.enabled = False		
//		m_main.m_general.m_back.enabled = False
//		cb_next.enabled = False				
//		m_main.m_general.m_next.enabled = False
//		cb_last.enabled = False		
//		m_main.m_general.m_last.enabled = False
//
//		// Security - Add Document Indexing Information
//		If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
//			cb_new.enabled = True
//			m_main.m_general.m_new.enabled = True
//		End If
//		
//		// Security - Update Document Indexing Information
//		If w_main.dw_perms.Find("code=51", 1, w_main.dw_perms.RowCount()) > 0 Then
//			cb_update.enabled = True				
//			m_main.m_general.m_update.enabled = True
//		End If
//		
//		// Security - Delete Document Indexing Information
//		If w_main.dw_perms.Find("code=52", 1, w_main.dw_perms.RowCount()) > 0 Then
//			cb_delete.enabled = True				
//			m_main.m_general.m_delete.enabled = True
//		End If
//
//		cb_escape.enabled = False
//		m_main.m_general.m_escape.enabled = False
//		
//		cb_save.enabled = False
//		m_main.m_general.m_save.enabled = False
//		
//		cb_main.enabled = False
//		cb_legal.enabled = True			
//		cb_parcel.enabled = True		
//		cb_memo.enabled = True			
//		
//		dw_scan.enabled = True
//		
//		If s_iRow > 0 Then
//			s_achDocNum = Trim(dw_scan.GetItemString(s_iRow, "document_number"))
//
//			dw_detail.DataObject = "dw_document_index_detail"		
//			dw_detail.SetTransObject(SQLCA)
//			dw_detail.Tag = "Document Indexing Information"		
//
//			// get Group Number
//			dw_detail.GetChild("group_number", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("GROUP")
//
//			// get Document Type
//			dw_detail.GetChild("doc_type", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("DOC")
//
//			// get Payment Type
//			dw_detail.GetChild("payment_type", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("PAY")
//			
//			// get Document Exemption Type
//			dw_detail.GetChild("exemption_number", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("DEXEM")
//
//			dw_detail.Retrieve(s_achDocNum)														
//			
//			
//			dw_detail.SetRedraw(False)		
//			dw_detail.Modify("book.background.color = " + s_achDWColor + & 
//				" book.tabsequence = 0" + &				
//				" page.background.color = " + s_achDWColor + & 
//				" page.tabsequence = 0" + &					
//				" group_number.background.color = " + s_achDWColor + & 
//				" group_number.tabsequence = 0" + &		
//				" payment_type.background.color = " + s_achDWColor + & 
//				" payment_type.tabsequence = 0" + &									
//				" doc_type.background.color = " + s_achDWColor + & 
//				" doc_type.tabsequence = 0" + &						
//				" recording_fee.background.color = " + s_achDWColor + & 
//				" recording_fee.tabsequence = 0" + &									
//				" consideration.background.color = " + s_achDWColor + & 
//				" consideration.tabsequence = 0" + &									
//				" number_of_pages.background.color = " + s_achDWColor + & 
//				" number_of_pages.tabsequence = 0" + &									
//				" number_of_legals.background.color = " + s_achDWColor + & 
//				" number_of_legals.tabsequence = 0" + &												
//				" transfer_fee.background.color = " + s_achDWColor + & 
//				" transfer_fee.tabsequence = 0" + &			
//				" revenue_stamp.background.color = " + s_achDWColor + & 
//				" revenue_stamp.tabsequence = 0" + &						
//				" filing_date.background.color = " + s_achDWColor + & 
//				" filing_date.tabsequence = 0" + &				
//				" filing_time.background.color = " + s_achDWColor + & 
//				" filing_time.tabsequence = 0" + &							
//				" management_fee.background.color = " + s_achDWColor + & 
//				" management_fee.tabsequence = 0" + &						
//				" instrument_date.background.color = " + s_achDWColor + & 
//				" instrument_date.tabsequence = 0" + &
//				" dov_audit_number.background.color = " + s_achDWColor + & 
//				" dov_audit_number.tabsequence = 0" + &		
//				" ground_water_exemption.background.color = " + s_achDWColor + & 
//				" ground_water_exemption.tabsequence = 0" + &		
//				" exemption_number.background.color = " + s_achDWColor + & 
//				" exemption_number.tabsequence = 0" + &
//				" st_mail_to.visible = 0" + &									
//				" mail1.background.color = " + s_achDWColor + & 
//				" mail1.tabsequence = 0" + &					
//				" condominium.background.color = " + s_achDWColor + & 
//				" condominium.tabsequence = 0")				
//			dw_detail.SetRedraw(True)
//
//		Else
//			dw_scan.Reset()
//			dw_detail.Reset()
//		End If		
//
//	Case "dw_document_index_parcel_detail"
//
//		s_iRow = dw_scan.GetRow()
//
//		cb_first.enabled = False
//		m_main.m_general.m_first.enabled = False
//		cb_back.enabled = False		
//		m_main.m_general.m_back.enabled = False
//		cb_next.enabled = False				
//		m_main.m_general.m_next.enabled = False
//		cb_last.enabled = False		
//		m_main.m_general.m_last.enabled = False
//
//		// Security - Add Document Indexing Information
//		If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
//			cb_new.enabled = True
//			m_main.m_general.m_new.enabled = True
//		End If
//		
//		// Security - Update Document Indexing Information
//		If w_main.dw_perms.Find("code=51", 1, w_main.dw_perms.RowCount()) > 0 Then
//			cb_update.enabled = True				
//			m_main.m_general.m_update.enabled = True
//		End If
//		
//		// Security - Delete Document Indexing Information
//		If w_main.dw_perms.Find("code=52", 1, w_main.dw_perms.RowCount()) > 0 Then
//			cb_delete.enabled = True				
//			m_main.m_general.m_delete.enabled = True
//		End If
//
//		cb_escape.enabled = False
//		m_main.m_general.m_escape.enabled = False
//		
//		cb_save.enabled = False
//		m_main.m_general.m_save.enabled = False
//		
//		cb_main.enabled = False
//		cb_legal.enabled = True			
//		cb_parcel.enabled = True		
//		cb_memo.enabled = True			
//		
//		dw_scan.enabled = True
//		
//		If s_iRow > 0 Then
//			s_achDocNum = Trim(dw_scan.GetItemString(s_iRow, "document_number"))
//
//			dw_detail.DataObject = "dw_document_index_detail"		
//			dw_detail.SetTransObject(SQLCA)
//			dw_detail.Tag = "Document Indexing Information"		
//
//			// get Group Number
//			dw_detail.GetChild("group_number", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("GROUP")
//
//			// get Document Type
//			dw_detail.GetChild("doc_type", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("DOC")
//
//			// get Payment Type
//			dw_detail.GetChild("payment_type", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("PAY")
//			
//			// get Document Exemption Type
//			dw_detail.GetChild("exemption_number", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("DEXEM")
//
//			dw_detail.Retrieve(s_achDocNum)														
//			
//			dw_detail.SetRedraw(False)		
//			dw_detail.Modify("book.background.color = " + s_achDWColor + & 
//				" book.tabsequence = 0" + &				
//				" page.background.color = " + s_achDWColor + & 
//				" page.tabsequence = 0" + &					
//				" group_number.background.color = " + s_achDWColor + & 
//				" group_number.tabsequence = 0" + &		
//				" payment_type.background.color = " + s_achDWColor + & 
//				" payment_type.tabsequence = 0" + &									
//				" doc_type.background.color = " + s_achDWColor + & 
//				" doc_type.tabsequence = 0" + &						
//				" recording_fee.background.color = " + s_achDWColor + & 
//				" recording_fee.tabsequence = 0" + &									
//				" consideration.background.color = " + s_achDWColor + & 
//				" consideration.tabsequence = 0" + &									
//				" number_of_pages.background.color = " + s_achDWColor + & 
//				" number_of_pages.tabsequence = 0" + &									
//				" number_of_legals.background.color = " + s_achDWColor + & 
//				" number_of_legals.tabsequence = 0" + &												
//				" transfer_fee.background.color = " + s_achDWColor + & 
//				" transfer_fee.tabsequence = 0" + &			
//				" revenue_stamp.background.color = " + s_achDWColor + & 
//				" revenue_stamp.tabsequence = 0" + &						
//				" filing_date.background.color = " + s_achDWColor + & 
//				" filing_date.tabsequence = 0" + &				
//				" filing_time.background.color = " + s_achDWColor + & 
//				" filing_time.tabsequence = 0" + &							
//				" management_fee.background.color = " + s_achDWColor + & 
//				" management_fee.tabsequence = 0" + &						
//				" instrument_date.background.color = " + s_achDWColor + & 
//				" instrument_date.tabsequence = 0" + &
//				" dov_audit_number.background.color = " + s_achDWColor + & 
//				" dov_audit_number.tabsequence = 0" + &		
//				" ground_water_exemption.background.color = " + s_achDWColor + & 
//				" ground_water_exemption.tabsequence = 0" + &		
//				" exemption_number.background.color = " + s_achDWColor + & 
//				" exemption_number.tabsequence = 0" + &
//				" st_mail_to.visible = 0" + &									
//				" mail1.background.color = " + s_achDWColor + & 
//				" mail1.tabsequence = 0" + &					
//				" condominium.background.color = " + s_achDWColor + & 
//				" condominium.tabsequence = 0")				
//			dw_detail.SetRedraw(True)
//
//		Else
//			dw_scan.Reset()
//			dw_detail.Reset()
//		End If		
//
//	Case "dw_document_index_note_detail"
//
//		s_iRow = dw_scan.GetRow()
//
//		cb_first.enabled = False
//		m_main.m_general.m_first.enabled = False
//		cb_back.enabled = False		
//		m_main.m_general.m_back.enabled = False
//		cb_next.enabled = False				
//		m_main.m_general.m_next.enabled = False
//		cb_last.enabled = False		
//		m_main.m_general.m_last.enabled = False
//
//		// Security - Add Document Indexing Information
//		If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
//			cb_new.enabled = True
//			m_main.m_general.m_new.enabled = True
//		End If
//		
//		// Security - Update Document Indexing Information
//		If w_main.dw_perms.Find("code=51", 1, w_main.dw_perms.RowCount()) > 0 Then
//			cb_update.enabled = True				
//			m_main.m_general.m_update.enabled = True
//		End If
//		
//		// Security - Delete Document Indexing Information
//		If w_main.dw_perms.Find("code=52", 1, w_main.dw_perms.RowCount()) > 0 Then
//			cb_delete.enabled = True				
//			m_main.m_general.m_delete.enabled = True
//		End If
//
//		cb_escape.enabled = False
//		m_main.m_general.m_escape.enabled = False
//		
//		cb_save.enabled = False
//		m_main.m_general.m_save.enabled = False
//		
//		cb_main.enabled = False
//		cb_legal.enabled = True			
//		cb_parcel.enabled = True		
//		cb_memo.enabled = True			
//		
//		dw_scan.enabled = True
//		
//		If s_iRow > 0 Then
//			s_achDocNum = Trim(dw_scan.GetItemString(s_iRow, "document_number"))
//
//			dw_detail.DataObject = "dw_document_index_detail"		
//			dw_detail.SetTransObject(SQLCA)
//			dw_detail.Tag = "Document Indexing Information"		
//	
//			// get Group Number
//			dw_detail.GetChild("group_number", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("GROUP")
//
//			// get Document Type
//			dw_detail.GetChild("doc_type", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("DOC")
//
//			// get Payment Type
//			dw_detail.GetChild("payment_type", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("PAY")
//			
//			// get Document Exemption Type
//			dw_detail.GetChild("exemption_number", dwc)
//			dwc.SetTransObject(SQLCA)
//			dwc.Reset()
//			dwc.Retrieve("DEXEM")
//
//			dw_detail.Retrieve(s_achDocNum)														
//	
//			dw_detail.SetRedraw(False)		
//			dw_detail.Modify("book.background.color = " + s_achDWColor + & 
//				" book.tabsequence = 0" + &				
//				" page.background.color = " + s_achDWColor + & 
//				" page.tabsequence = 0" + &					
//				" group_number.background.color = " + s_achDWColor + & 
//				" group_number.tabsequence = 0" + &		
//				" payment_type.background.color = " + s_achDWColor + & 
//				" payment_type.tabsequence = 0" + &									
//				" doc_type.background.color = " + s_achDWColor + & 
//				" doc_type.tabsequence = 0" + &						
//				" recording_fee.background.color = " + s_achDWColor + & 
//				" recording_fee.tabsequence = 0" + &									
//				" consideration.background.color = " + s_achDWColor + & 
//				" consideration.tabsequence = 0" + &									
//				" number_of_pages.background.color = " + s_achDWColor + & 
//				" number_of_pages.tabsequence = 0" + &									
//				" number_of_legals.background.color = " + s_achDWColor + & 
//				" number_of_legals.tabsequence = 0" + &												
//				" transfer_fee.background.color = " + s_achDWColor + & 
//				" transfer_fee.tabsequence = 0" + &			
//				" revenue_stamp.background.color = " + s_achDWColor + & 
//				" revenue_stamp.tabsequence = 0" + &						
//				" filing_date.background.color = " + s_achDWColor + & 
//				" filing_date.tabsequence = 0" + &				
//				" filing_time.background.color = " + s_achDWColor + & 
//				" filing_time.tabsequence = 0" + &							
//				" management_fee.background.color = " + s_achDWColor + & 
//				" management_fee.tabsequence = 0" + &						
//				" instrument_date.background.color = " + s_achDWColor + & 
//				" instrument_date.tabsequence = 0" + &
//				" dov_audit_number.background.color = " + s_achDWColor + & 
//				" dov_audit_number.tabsequence = 0" + &		
//				" ground_water_exemption.background.color = " + s_achDWColor + & 
//				" ground_water_exemption.tabsequence = 0" + &		
//				" exemption_number.background.color = " + s_achDWColor + & 
//				" exemption_number.tabsequence = 0" + &
//				" st_mail_to.visible = 0" + &									
//				" mail1.background.color = " + s_achDWColor + & 
//				" mail1.tabsequence = 0" + &					
//				" condominium.background.color = " + s_achDWColor + & 
//				" condominium.tabsequence = 0")				
//			dw_detail.SetRedraw(True)
//
//		Else
//			dw_scan.Reset()
//			dw_detail.Reset()
//		End If		
//
//End Choose
end event

event resize;gnv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
end event

type cb_escape from w_base_sheet`cb_escape within w_ledger_sheet
integer x = 3237
integer taborder = 120
end type

type cb_exit from w_base_sheet`cb_exit within w_ledger_sheet
integer x = 3485
integer taborder = 160
end type

type cb_last from w_base_sheet`cb_last within w_ledger_sheet
integer x = 3485
integer taborder = 150
end type

type cb_next from w_base_sheet`cb_next within w_ledger_sheet
integer x = 3485
integer taborder = 140
end type

type cb_back from w_base_sheet`cb_back within w_ledger_sheet
integer x = 3485
integer taborder = 130
end type

type cb_first from w_base_sheet`cb_first within w_ledger_sheet
integer x = 3485
integer taborder = 110
end type

type cb_save from w_base_sheet`cb_save within w_ledger_sheet
integer x = 3237
integer taborder = 80
end type

type cb_delete from w_base_sheet`cb_delete within w_ledger_sheet
integer x = 3237
integer taborder = 70
end type

type cb_update from w_base_sheet`cb_update within w_ledger_sheet
integer x = 3237
integer taborder = 60
end type

event cb_update::clicked;call super::clicked;i_achMode = ""
end event

type cb_add from w_base_sheet`cb_add within w_ledger_sheet
integer x = 3237
integer taborder = 50
end type

type cb_new from w_base_sheet`cb_new within w_ledger_sheet
integer x = 3237
integer taborder = 40
end type

type cb_clear from w_base_sheet`cb_clear within w_ledger_sheet
integer x = 3237
integer taborder = 30
end type

type cb_search from w_base_sheet`cb_search within w_ledger_sheet
integer x = 3237
integer taborder = 20
end type

type dw_detail from w_base_sheet`dw_detail within w_ledger_sheet
event ue_dwnkey pbm_dwnkey
event ue_continue_add pbm_custom13
integer y = 1104
integer width = 3163
integer height = 800
integer taborder = 180
string dataobject = "dw_ledger_detail"
end type

event dw_detail::ue_dwnkey;string s_achDWColor, s_achCBType, s_achFeeType
integer s_iRow, s_lCount, s_iDockYear

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_ledger_detail"
		
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "beg_balance"
				If KeyDown(KeyEnter!) Or KeyDown(KeyTab!) Then		
					parent.TriggerEvent("ue_save")
					Return
				End If
	
		End Choose 

		If i_achMode = "Continue" Then
			If KeyDown(KeyF4!) Then
				i_achMode = ""
				i_bExit = True								
				i_bNew = False

				cb_first.enabled = False
				m_main.m_general.m_first.enabled = False
				cb_back.enabled = False				
				m_main.m_general.m_back.enabled = False
				cb_next.enabled = False				
				m_main.m_general.m_next.enabled = False
				cb_last.enabled = False				
				m_main.m_general.m_last.enabled = False
	
				dw_detail.SetRedraw(False)				
				dw_detail.Modify("dock_year.background.color = " + s_achDWColor + & 
					" dock_year.tabsequence = 0" + &				
					" cb_type.background.color = " + s_achDWColor + & 
					" cb_type.tabsequence = 0" + &					
					" fee_type.background.color = " + s_achDWColor + & 
					" fee_type.tabsequence = 0" + &						
					" beg_balance.background.color = " + s_achDWColor + & 
					" beg_balance.tabsequence = 0")				
				dw_detail.SetRedraw(True)			

				s_iRow = dw_scan.GetRow()
	
				s_iDockYear = dw_scan.GetItemNumber(s_iRow,"dock_year")						
				s_achCBType = Trim(dw_scan.GetItemString(s_iRow,"cb_type"))
				s_achFeeType = Trim(dw_scan.GetItemString(s_iRow,"fee_type"))		

				dw_detail.Retrieve(s_iDockYear, s_achCBType, s_achFeeType)			
			
				dw_scan.enabled = True

				// Security - Add RE Collection Ledger Information
				If w_main.dw_perms.Find("code=58", 1, w_main.dw_perms.RowCount()) > 0 Then
					cb_new.enabled = True
					m_main.m_general.m_new.enabled = True
				End If
				
				// Security - Update RE Collection Ledger Information
				If w_main.dw_perms.Find("code=59", 1, w_main.dw_perms.RowCount()) > 0 Then
					cb_update.enabled = True					
					m_main.m_general.m_update.enabled = True
				End If

				// Security - Delete RE Collection Ledger Information
				If w_main.dw_perms.Find("code=60", 1, w_main.dw_perms.RowCount()) > 0 Then
					cb_delete.enabled = True					
					m_main.m_general.m_delete.enabled = True
				End If
	
				cb_escape.enabled = False
				m_main.m_general.m_escape.enabled = False
				cb_save.enabled = False
				m_main.m_general.m_save.enabled = False
				i_bContinueItem = True
				
				dw_scan.SetFocus()
			End If
		End If		

End Choose 


end event

event dw_detail::ue_continue_add;integer s_iRow

dw_detail.DataObject = "dw_ledger_detail"
dw_detail.SetTransObject(SQLCA)								
	
If i_achMode = "Continue" And i_bNew = True Then 
	m_main.m_general.m_new.TriggerEvent("clicked")
End If


end event

type dw_scan from w_base_sheet`dw_scan within w_ledger_sheet
integer y = 125
integer width = 3163
integer height = 963
integer taborder = 170
string dataobject = "dw_ledger_scan"
end type

event dw_scan::rowfocuschanged;datawindowchild	dwc
long s_lCount, s_lRowCount, s_lCurrentRow, s_lRow
integer s_iAudYear, s_iRow
			
dw_detail.SetTransObject(SQLCA)

s_iRow = dw_scan.GetRow()

If s_iRow > 0 Then
	
	Choose Case dw_detail.DataObject
		Case "dw_ledger_detail"

			dw_detail.Tag = "Check Book Ledger Information"

			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(currentrow, True)
			
			dw_detail.Retrieve(dw_scan.GetItemNumber(s_iRow, "dock_year"))

			// RowFocusChanged Trigger for Title Refreshment
			dw_detail.TriggerEvent(RowFocusChanged!)				
			
	End Choose		

End If	
end event

type gb_5 from w_base_sheet`gb_5 within w_ledger_sheet
integer x = 3460
end type

type gb_4 from w_base_sheet`gb_4 within w_ledger_sheet
integer x = 3460
end type

type gb_1 from w_base_sheet`gb_1 within w_ledger_sheet
integer x = 3211
integer textsize = -9
end type

type gb_2 from w_base_sheet`gb_2 within w_ledger_sheet
integer x = 3211
end type

type cb_list from w_base_sheet`cb_list within w_ledger_sheet
integer x = 3485
integer taborder = 90
end type

type cb_detail from w_base_sheet`cb_detail within w_ledger_sheet
integer x = 3485
integer taborder = 100
end type

type gb_3 from w_base_sheet`gb_3 within w_ledger_sheet
integer x = 3460
end type

type dw_single_doc from datawindow within w_ledger_sheet
boolean visible = false
integer x = 794
integer y = 688
integer width = 505
integer height = 368
boolean bringtotop = true
string dataobject = "dw_hold_ledger_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_year from editmask within w_ledger_sheet
integer x = 512
integer y = 19
integer width = 282
integer height = 83
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean spin = true
end type

type st_4 from statictext within w_ledger_sheet
integer x = 102
integer y = 29
integer width = 399
integer height = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Docket Year:"
alignment alignment = right!
boolean focusrectangle = false
end type

