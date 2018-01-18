$PBExportHeader$w_check_book_reconciliation_sheet.srw
forward
global type w_check_book_reconciliation_sheet from w_base_sheet
end type
type em_year from editmask within w_check_book_reconciliation_sheet
end type
type st_4 from statictext within w_check_book_reconciliation_sheet
end type
type st_cb from statictext within w_check_book_reconciliation_sheet
end type
type ddlb_period from dropdownlistbox within w_check_book_reconciliation_sheet
end type
type cb_process from commandbutton within w_check_book_reconciliation_sheet
end type
type cb_process_once from commandbutton within w_check_book_reconciliation_sheet
end type
type dw_recon_rpt from datawindow within w_check_book_reconciliation_sheet
end type
type st_interest from statictext within w_check_book_reconciliation_sheet
end type
type sle_interest from singlelineedit within w_check_book_reconciliation_sheet
end type
type cb_balance_rpt from commandbutton within w_check_book_reconciliation_sheet
end type
type dw_recon_detail from datawindow within w_check_book_reconciliation_sheet
end type
end forward

global type w_check_book_reconciliation_sheet from w_base_sheet
integer x = 40
integer y = 29
integer width = 3767
integer height = 2115
string title = "Check Book Reconciliation Information"
toolbaralignment toolbaralignment = alignatleft!
em_year em_year
st_4 st_4
st_cb st_cb
ddlb_period ddlb_period
cb_process cb_process
cb_process_once cb_process_once
dw_recon_rpt dw_recon_rpt
st_interest st_interest
sle_interest sle_interest
cb_balance_rpt cb_balance_rpt
dw_recon_detail dw_recon_detail
end type
global w_check_book_reconciliation_sheet w_check_book_reconciliation_sheet

type variables
string i_achSaveSQL, i_achMode, i_achNewSQL
integer i_iFY, i_iTreYear
boolean i_bFirstSearch, i_bExit, i_bContinueItem, i_bName
boolean i_bNew, i_bButtonOnly



end variables

on w_check_book_reconciliation_sheet.create
int iCurrent
call super::create
this.em_year=create em_year
this.st_4=create st_4
this.st_cb=create st_cb
this.ddlb_period=create ddlb_period
this.cb_process=create cb_process
this.cb_process_once=create cb_process_once
this.dw_recon_rpt=create dw_recon_rpt
this.st_interest=create st_interest
this.sle_interest=create sle_interest
this.cb_balance_rpt=create cb_balance_rpt
this.dw_recon_detail=create dw_recon_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_year
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_cb
this.Control[iCurrent+4]=this.ddlb_period
this.Control[iCurrent+5]=this.cb_process
this.Control[iCurrent+6]=this.cb_process_once
this.Control[iCurrent+7]=this.dw_recon_rpt
this.Control[iCurrent+8]=this.st_interest
this.Control[iCurrent+9]=this.sle_interest
this.Control[iCurrent+10]=this.cb_balance_rpt
this.Control[iCurrent+11]=this.dw_recon_detail
end on

on w_check_book_reconciliation_sheet.destroy
call super::destroy
destroy(this.em_year)
destroy(this.st_4)
destroy(this.st_cb)
destroy(this.ddlb_period)
destroy(this.cb_process)
destroy(this.cb_process_once)
destroy(this.dw_recon_rpt)
destroy(this.st_interest)
destroy(this.sle_interest)
destroy(this.cb_balance_rpt)
destroy(this.dw_recon_detail)
end on

event ue_search;call super::ue_search;// script variables
string s_achSQL, s_achDWColor
string s_achNewSQL, s_achPeriodNum, s_achCBType, s_achFeeType
integer s_iNumRows, s_iPosition, s_iPeriodNum

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

dw_detail.DataObject = "dw_docket_reconcile_detail"

dw_detail.SetRedraw(False)
dw_detail.Modify("dock_year.background.color = " + s_achDWColor + & 
	" dock_year.tabsequence = 0" + &				
	" cb_type.background.color = " + s_achDWColor + & 
	" cb_type.tabsequence = 0" + &					
	" beg_balance.background.color = " + s_achDWColor + & 
	" beg_balance.tabsequence = 0")
dw_detail.SetRedraw(True)

i_iTREYear = Integer(em_year.text)

s_iPeriodNum = 0
If Trim(ddlb_period.text) <> "" Then
//	s_achPeriodNum = Trim(Left(ddlb_period.text, Pos(ddlb_period.text, " ")))
	s_achPeriodNum = Left(ddlb_period.text, 2)
	If Left(s_achPeriodNum,1) = "0" Then
		s_achPeriodNum = Right(s_achPeriodNum,1)
	End If
	s_iPeriodNum = Integer(s_achPeriodNum)

End If

// Docket Year
If i_iTreYear <> 0 Then
	If Len(s_achSQL) = 0 Then
		s_achSQL = &
			 " WHERE sh_docket_reconcile.docket_year = " + String(i_iTreYear)
	Else
		s_achSQL += &
			 " AND sh_docket_reconcile.docket_year = " + String(i_iTreYear)
	End If	
End If

// Period
If s_iPeriodNum <> 0 Then
	If Len(s_achSQL) = 0 Then
		s_achSQL = &
			 " WHERE sh_docket_reconcile.period = " + String(s_iPeriodNum)
	Else
		s_achSQL += &
			 " AND sh_docket_reconcile.period = " + String(s_iPeriodNum)
	End If	
End If

s_achSQL += &
   " ORDER BY sh_docket_reconcile.period DESC" 
s_achSQL = i_achSQL + s_achSQL
i_achSaveSQL = s_achSQL

// NEW Entry
s_achNewSQL += &
   " ORDER BY sh_docket_reconcile.period DESC" 
i_achNewSQL = i_achSQL + s_achNewSQL

dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")

dw_scan.Reset()
If dw_scan.Retrieve() = 0 Then
	MessageBox("Complete", "No Check Book Reconciliation rows found.")

	em_year.text = String(i_iTreYear)

	em_year.SetFocus()
Else
	
   dw_scan.SetFocus()
	
	// RowFocusChanged Trigger for Title Refreshment
	dw_detail.TriggerEvent(RowFocusChanged!)	
		
End If

end event

event open;string s_achPeriod
datawindowchild	dwc

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
gnv_resize.of_Register(dw_recon_detail, gnv_resize.SCALE)
gnv_resize.of_Register(dw_recon_rpt, gnv_resize.SCALE)
gnv_resize.of_Register(st_4, gnv_resize.SCALE)
gnv_resize.of_Register(st_cb, gnv_resize.SCALE)
gnv_resize.of_Register(st_interest, gnv_resize.SCALE)
gnv_resize.of_Register(em_year, gnv_resize.SCALE)
gnv_resize.of_Register(ddlb_period, gnv_resize.SCALE)
gnv_resize.of_Register(sle_interest, gnv_resize.SCALE)

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

gnv_resize.of_Register(cb_balance_rpt, gnv_resize.SCALE)
gnv_resize.of_Register(cb_process, gnv_resize.SCALE)
gnv_resize.of_Register(cb_process_once, gnv_resize.SCALE)

i_bFirstSearch = True

i_iTreYear = g_iCurrYear

em_year.text = String(i_iTreYear)
em_year.SetFocus()


s_achPeriod = String(Month(g_dtToday), "00")

sle_interest.text = "0"

ddlb_period.text = String(s_achPeriod)

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

		If IsNull(dw_detail.GetItemString(1,"cb_type")) Or (dw_detail.GetItemString(1,"cb_type") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "CB Type MUST be entered!")
			dw_detail.SetColumn("cb_type")
			dw_detail.SetFocus()
			Return
		End If	

		If IsNull(dw_detail.GetItemString(1,"fee_type")) Or (dw_detail.GetItemString(1,"fee_type") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Fee Type MUST be entered!")
			dw_detail.SetColumn("fee_type")
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

sle_interest.text = "0"

em_year.SetFocus()

dw_detail.Tag = "Ledger Information"
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
		dw_detail.Modify("cb_type.background.color = " + s_achDWColor + & 
			" cb_type.tabsequence = 2" + &				
			" beg_balance.background.color = " + s_achDWColor + & 
			" beg_balance.tabsequence = 3")		
		dw_detail.SetColumn("cb_type")						
		
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
				" cb_type.background.color = " + s_achDWColor + & 
				" cb_type.tabsequence = 0" + &					
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
			s_achCBType = Trim(dw_detail.GetItemString(s_iRow,"cb_type"))
			
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
					lds_CollectionItem.SetItem(s_iItemRow,"cb_type", s_achCBType)
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

dw_detail.Tag = "Ledger Information"
dw_detail.DataObject = "dw_ledger_detail"
dw_detail.SetTransObject(SQLCA)

Choose Case dw_detail.DataObject
	Case "dw_ledger_detail"

		// get Fee Type
		dw_detail.GetChild("fee_type", dwc)
		dwc.SetTransObject(SQLCA)
		dwc.Reset()
		dwc.Retrieve("FEE")

		dw_detail.Tag = "Ledger Information"		
		dw_detail.Reset()		
		dw_detail.InsertRow(0)
		
		dw_detail.SetItem(1,"dock_year", g_iCurrYear)																			
		dw_detail.SetItem(1,"cb_type", "")																	
		dw_detail.SetItem(1,"fee_type", "")															
		dw_detail.SetItem(1,"beg_balance", 0)																	
		dw_detail.SetItem(1,"last_chg_login", "")					
		dw_detail.SetItem(1,"last_chg_datetime", "")							
										
		dw_detail.SetRedraw(False)
		dw_detail.Modify("dock_year.background.color = " + s_achDWColor + & 
			" dock_year.tabsequence = 1" + &						
		   " cb_type.background.color = " + s_achDWColor + & 
			" cb_type.tabsequence = 2" + &				
			" fee_type.background.color = " + s_achDWColor + & 
			" fee_type.tabsequence = 3" + &					
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
		   If 2 = MessageBox("Delete","Delete This Ledger?",Question!,OkCancel!,2) Then
		      MessageBox("Delete","Ledger NOT Deleted",None!)
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

event ue_print_detail;
string s_achReport, s_achDocNum
long s_lYear, s_lPeriod
integer s_iRow
decimal {2} s_dInterest

cb_process_once.TriggerEvent("clicked")

s_iRow = dw_scan.GetRow()

s_lYear = dw_scan.GetItemNumber(s_iRow, "docket_year")
s_lPeriod = dw_scan.GetItemNumber(s_iRow, "period")

// Retrieve Information
dw_recon_detail.SetTransObject(SQLCA)
dw_recon_detail.Reset()

dw_recon_detail.Retrieve(s_lYear, s_lPeriod)	

// Printer Setup and Printout depending on current detail window
OpenWithParm(w_datawindow_print_dialog,dw_recon_detail)

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

type cb_escape from w_base_sheet`cb_escape within w_check_book_reconciliation_sheet
integer x = 3237
integer taborder = 130
end type

type cb_exit from w_base_sheet`cb_exit within w_check_book_reconciliation_sheet
integer x = 3485
integer taborder = 170
end type

type cb_last from w_base_sheet`cb_last within w_check_book_reconciliation_sheet
integer x = 3485
integer taborder = 160
end type

type cb_next from w_base_sheet`cb_next within w_check_book_reconciliation_sheet
integer x = 3485
integer taborder = 150
end type

type cb_back from w_base_sheet`cb_back within w_check_book_reconciliation_sheet
integer x = 3485
integer taborder = 140
end type

type cb_first from w_base_sheet`cb_first within w_check_book_reconciliation_sheet
integer x = 3485
integer taborder = 120
end type

type cb_save from w_base_sheet`cb_save within w_check_book_reconciliation_sheet
integer x = 3237
integer taborder = 90
end type

type cb_delete from w_base_sheet`cb_delete within w_check_book_reconciliation_sheet
integer x = 3237
integer taborder = 80
end type

type cb_update from w_base_sheet`cb_update within w_check_book_reconciliation_sheet
integer x = 3237
integer taborder = 70
end type

event cb_update::clicked;call super::clicked;i_achMode = ""
end event

type cb_add from w_base_sheet`cb_add within w_check_book_reconciliation_sheet
integer x = 3237
integer taborder = 60
end type

type cb_new from w_base_sheet`cb_new within w_check_book_reconciliation_sheet
integer x = 3237
integer taborder = 50
end type

type cb_clear from w_base_sheet`cb_clear within w_check_book_reconciliation_sheet
integer x = 3237
integer taborder = 40
end type

type cb_search from w_base_sheet`cb_search within w_check_book_reconciliation_sheet
integer x = 3237
integer taborder = 30
end type

type dw_detail from w_base_sheet`dw_detail within w_check_book_reconciliation_sheet
event ue_dwnkey pbm_dwnkey
event ue_continue_add pbm_custom13
integer y = 822
integer width = 3163
integer height = 1088
integer taborder = 220
string dataobject = "dw_docket_reconcile_detail"
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

type dw_scan from w_base_sheet`dw_scan within w_check_book_reconciliation_sheet
integer y = 122
integer width = 3163
integer height = 682
integer taborder = 210
string dataobject = "dw_docket_reconcile_scan"
end type

event dw_scan::rowfocuschanged;datawindowchild	dwc
long s_lCount, s_lRowCount, s_lCurrentRow, s_lRow
integer s_iAudYear, s_iRow
			
dw_detail.SetTransObject(SQLCA)

s_iRow = dw_scan.GetRow()

If s_iRow > 0 Then
	
	Choose Case dw_detail.DataObject
		Case "dw_docket_reconcile_detail"

			dw_detail.Tag = "Ledger Information"

			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(currentrow, True)
			
			dw_detail.Retrieve(dw_scan.GetItemNumber(s_iRow, "docket_year"), &
				dw_scan.GetItemNumber(s_iRow, "period"))

			// RowFocusChanged Trigger for Title Refreshment
			dw_detail.TriggerEvent(RowFocusChanged!)				
			cb_process_once.TriggerEvent("clicked")			
			
	End Choose		

End If	
end event

type gb_5 from w_base_sheet`gb_5 within w_check_book_reconciliation_sheet
integer x = 3460
end type

type gb_4 from w_base_sheet`gb_4 within w_check_book_reconciliation_sheet
integer x = 3460
end type

type gb_1 from w_base_sheet`gb_1 within w_check_book_reconciliation_sheet
integer x = 3211
integer textsize = -9
end type

type gb_2 from w_base_sheet`gb_2 within w_check_book_reconciliation_sheet
integer x = 3211
end type

type cb_list from w_base_sheet`cb_list within w_check_book_reconciliation_sheet
integer x = 3485
integer taborder = 100
end type

type cb_detail from w_base_sheet`cb_detail within w_check_book_reconciliation_sheet
integer x = 3485
integer taborder = 110
end type

type gb_3 from w_base_sheet`gb_3 within w_check_book_reconciliation_sheet
integer x = 3460
end type

type em_year from editmask within w_check_book_reconciliation_sheet
integer x = 479
integer y = 19
integer width = 282
integer height = 80
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

type st_4 from statictext within w_check_book_reconciliation_sheet
integer x = 95
integer y = 29
integer width = 369
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

type st_cb from statictext within w_check_book_reconciliation_sheet
integer x = 801
integer y = 29
integer width = 274
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
string text = "Period:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_period from dropdownlistbox within w_check_book_reconciliation_sheet
integer x = 1090
integer y = 16
integer width = 739
integer height = 515
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"01 -- January","02 -- February","03 -- March","04 -- April","05 -- May","06 -- June","07 -- July","08 -- August","09 -- September","10 -- October","11 -- November","12 -- December"}
borderstyle borderstyle = stylelowered!
end type

type cb_process from commandbutton within w_check_book_reconciliation_sheet
integer x = 3237
integer y = 912
integer width = 464
integer height = 67
integer taborder = 180
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Process Balances"
end type

event clicked;datawindowchild dwc
integer s_iRow, s_iDockYear, s_iYear, s_iCBRecYear, s_iPeriodNum, s_iPriorPeriod
integer s_iNextYear, s_iNextPeriod, s_iLedgerYear, s_iLedgerPeriod, s_iCount
long s_lCount, s_lDisbursementRows, s_lTransNum, s_lDockNum, s_iPeriod, s_lCBRecNum
long s_lRows, s_lReceiptNum, s_lCheckNum
string s_achDisburseType, s_achWhomDue, s_achFeeType, s_achDoc, s_achCaseNum, s_achStatus
decimal {2} s_dBegBalance, s_dMonthReceipts, s_dMonthClearedWarrants, s_dEndBalance
decimal {2} s_dPriorPeriodBal, s_dOutstandingWarrants, s_dUnwarranted, s_dSheriffBalance
decimal {2} s_dTotalBalance, s_dPeriodBal, s_dCurrentWarrants, s_dBankInterest
decimal {2} s_dFutureReceipts, s_dFutureCleared, s_dFutureOutstanding
datetime s_dtRecDateTime
date s_dtRecDate, s_dtBegDate, s_dtEndDate

datastore lds_LedgerItem

lds_LedgerItem = Create DataStore
			
lds_LedgerItem.DataObject = 'dw_get_ledger_items_ds'
lds_LedgerItem.SetTransObject(SQLCA)

s_iRow = dw_scan.GetRow()

s_iYear = dw_scan.GetItemNumber(s_iRow, "docket_year")
s_iNextYear = s_iYear
s_iLedgerYear = s_iYear

s_iPeriod = dw_scan.GetItemNumber(s_iRow, "period")
//s_iPriorPeriod = s_iPeriod - 1
s_iLedgerPeriod = s_iPeriod - 1

s_dtBegDate = Date(s_iYear, s_iPeriod, 1)

s_iNextPeriod = s_iPeriod + 1
If s_iNextPeriod = 13 Then
	s_iNextPeriod = 1
	s_iNextYear ++
End If

s_dtEndDate = Date(s_iNextYear, s_iNextPeriod, 1)
s_dtEndDate = RelativeDate(s_dtEndDate, -1)

/*
If s_iPriorPeriod = 1 Then
	s_iLedgerPeriod = 12
	s_iLedgerYear --
End If
*/

// Beginning Bank Balance
s_dBegBalance = 0
SELECT beg_balance INTO :s_dBegBalance
	FROM ut_ledger
	WHERE ut_ledger.dock_year = :s_iLedgerYear;
If IsNull(s_dBegBalance) Then s_dBegBalance = 0

If s_iPeriod = 1 Then
	s_dTotalBalance = 0
Else
	s_dTotalBalance = 0
	// Retrieve ledger items
	s_lRows = lds_LedgerItem.Retrieve(s_iLedgerYear)
	//messagebox("s_lRows",s_lRows)
	For s_iCount = 1 To s_iLedgerPeriod
	
		s_dPeriodBal = lds_LedgerItem.GetItemNumber(s_iCount,"period_bal")
		s_dTotalBalance = s_dTotalBalance + s_dPeriodBal
	
	Next
End If

s_dTotalBalance = s_dBegBalance + s_dTotalBalance
If IsNull(s_dTotalBalance) Then s_dTotalBalance = 0

dw_detail.SetItem(s_iRow,"beg_bank_balance",s_dTotalBalance)
dw_detail.Update()
COMMIT;

// Posted Monthly Receipts
s_dMonthReceipts = 0
SELECT SUM(total_received) INTO :s_dMonthReceipts
	FROM sh_docket_receipt
	WHERE sh_docket_receipt.post_date >= :s_dtBegDate
	AND sh_docket_receipt.post_date <= :s_dtEndDate
	AND sh_docket_receipt.post_date IS NOT NULL;
If IsNull(s_dMonthReceipts) Then s_dMonthReceipts = 0

dw_detail.SetItem(s_iRow,"receipts",s_dMonthReceipts)
dw_detail.Update()
COMMIT;

/*
s_dBankInterest = 0
SELECT SUM(amount) INTO :s_dBankInterest
	FROM ut_interest_ledger_item
	WHERE ut_interest_ledger_item.post_date >= :s_dtBegDate
	AND ut_interest_ledger_item.post_date <= :s_dtEndDate;
If IsNull(s_dBankInterest) Then s_dBankInterest = 0

dw_detail.SetItem(s_iRow,"bank_interest",s_dBankInterest)
dw_detail.Update()
COMMIT;
*/

// Cleared Warrants
s_dMonthClearedWarrants = 0
SELECT SUM(amount_paid) INTO :s_dMonthClearedWarrants
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.clear_date >= :s_dtBegDate
	AND sh_docket_disbursement.clear_date <= :s_dtEndDate
	AND sh_docket_disbursement.disburse_status = 'C';	

If IsNull(s_dMonthClearedWarrants) Then s_dMonthClearedWarrants = 0

dw_detail.SetItem(s_iRow,"cleared_warrants",s_dMonthClearedWarrants)
dw_detail.Update()
COMMIT;

// Ending Bank Balance
s_dEndBalance = 0
s_dEndBalance = s_dTotalBalance + s_dMonthReceipts - s_dMonthClearedWarrants
If IsNull(s_dEndBalance) Then s_dEndBalance = 0

dw_detail.SetItem(s_iRow,"end_bank_balance",s_dEndBalance)
dw_detail.Update()
COMMIT;

// Prior Outstanding Warrants
s_dOutstandingWarrants = 0
SELECT SUM(amount_paid) INTO :s_dOutstandingWarrants
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.date_paid < :s_dtBegDate
	AND sh_docket_disbursement.disburse_status = 'W';	

If IsNull(s_dOutstandingWarrants) Then s_dOutstandingWarrants = 0
dw_detail.SetItem(s_iRow,"outstanding_warrants",s_dOutstandingWarrants)
dw_detail.Update()
COMMIT;

// Current Outstanding Warrants
s_dCurrentWarrants = 0
SELECT SUM(amount_paid) INTO :s_dCurrentWarrants
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.date_paid >= :s_dtBegDate
	AND sh_docket_disbursement.date_paid <= :s_dtEndDate	
	AND sh_docket_disbursement.disburse_status = 'W';	

If IsNull(s_dCurrentWarrants) Then s_dCurrentWarrants = 0
dw_detail.SetItem(s_iRow,"current_warrants",s_dCurrentWarrants)
dw_detail.Update()
COMMIT;

// Unwarranted Items
s_dUnwarranted = 0
SELECT SUM(amount_paid) INTO :s_dUnwarranted
	FROM sh_docket_disbursement
	WHERE ( sh_docket_disbursement.disburse_status = 'O');	

If IsNull(s_dUnwarranted) Then s_dUnwarranted = 0
dw_detail.SetItem(s_iRow,"unwarranted",s_dUnwarranted)
dw_detail.Update()
COMMIT;

// Future Posted Receipts
s_dFutureReceipts = 0
SELECT SUM(total_received) INTO :s_dFutureReceipts
	FROM sh_docket_receipt
	WHERE sh_docket_receipt.post_date > :s_dtEndDate
	AND sh_docket_receipt.post_date IS NOT NULL;
If IsNull(s_dFutureReceipts) Then s_dFutureReceipts = 0

dw_detail.SetItem(s_iRow,"future_receipts",s_dFutureReceipts)
dw_detail.Update()
COMMIT;

// Future Cleared Warrants
s_dFutureCleared = 0
SELECT SUM(amount_paid) INTO :s_dFutureCleared
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.clear_date > :s_dtEndDate
	AND sh_docket_disbursement.disburse_status = 'C';	

If IsNull(s_dFutureCleared) Then s_dFutureCleared = 0

dw_detail.SetItem(s_iRow,"future_cleared",s_dFutureCleared)
dw_detail.Update()
COMMIT;

// Future Outstanding Warrants
s_dFutureOutstanding = 0
SELECT SUM(amount_paid) INTO :s_dFutureOutstanding
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.date_paid > :s_dtEndDate
	AND sh_docket_disbursement.disburse_status = 'W';	

If IsNull(s_dFutureOutstanding) Then s_dFutureOutstanding = 0
dw_detail.SetItem(s_iRow,"future_outstanding",s_dFutureOutstanding)
dw_detail.Update()
COMMIT;

// Sheriff Balance
s_dSheriffBalance = 0
s_dSheriffBalance = s_dEndBalance - s_dOutstandingWarrants - s_dCurrentWarrants - s_dUnwarranted + s_dFutureReceipts - s_dFutureCleared - s_dFutureOutstanding

dw_detail.SetItem(s_iRow,"sheriff_balance",s_dSheriffBalance)
dw_detail.Update()
COMMIT;

cb_search.TriggerEvent("clicked")
end event

type cb_process_once from commandbutton within w_check_book_reconciliation_sheet
boolean visible = false
integer x = 3237
integer y = 1059
integer width = 464
integer height = 67
integer taborder = 230
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Process Once"
end type

event clicked;datawindowchild dwc
integer s_iRow, s_iDockYear, s_iYear, s_iCBRecYear, s_iPeriodNum, s_iPriorPeriod
integer s_iNextYear, s_iNextPeriod, s_iLedgerYear, s_iLedgerPeriod, s_iCount
long s_lCount, s_lDisbursementRows, s_lTransNum, s_lDockNum, s_iPeriod, s_lCBRecNum
long s_lRows, s_lReceiptNum, s_lCheckNum
string s_achDisburseType, s_achWhomDue, s_achFeeType, s_achDoc, s_achCaseNum, s_achStatus
decimal {2} s_dBegBalance, s_dMonthReceipts, s_dMonthClearedWarrants, s_dEndBalance
decimal {2} s_dPriorPeriodBal, s_dOutstandingWarrants, s_dUnwarranted, s_dSheriffBalance
decimal {2} s_dTotalBalance, s_dPeriodBal, s_dCurrentWarrants, s_dBankInterest
decimal {2} s_dFutureReceipts, s_dFutureCleared, s_dFutureOutstanding
datetime s_dtRecDateTime
date s_dtRecDate, s_dtBegDate, s_dtEndDate

datastore lds_LedgerItem

lds_LedgerItem = Create DataStore
			
lds_LedgerItem.DataObject = 'dw_get_ledger_items_ds'
lds_LedgerItem.SetTransObject(SQLCA)

s_iRow = dw_scan.GetRow()

s_iYear = dw_scan.GetItemNumber(s_iRow, "docket_year")
s_iNextYear = s_iYear
s_iLedgerYear = s_iYear

s_iPeriod = dw_scan.GetItemNumber(s_iRow, "period")
//s_iPriorPeriod = s_iPeriod - 1
s_iLedgerPeriod = s_iPeriod - 1

s_dtBegDate = Date(s_iYear, s_iPeriod, 1)

s_iNextPeriod = s_iPeriod + 1
If s_iNextPeriod = 13 Then
	s_iNextPeriod = 1
	s_iNextYear ++
End If

s_dtEndDate = Date(s_iNextYear, s_iNextPeriod, 1)
s_dtEndDate = RelativeDate(s_dtEndDate, -1)

/*
If s_iPriorPeriod = 1 Then
	s_iLedgerPeriod = 12
	s_iLedgerYear --
End If
*/

// Beginning Bank Balance
s_dBegBalance = 0
SELECT beg_balance INTO :s_dBegBalance
	FROM ut_ledger
	WHERE ut_ledger.dock_year = :s_iLedgerYear;
If IsNull(s_dBegBalance) Then s_dBegBalance = 0

If s_iPeriod = 1 Then
	s_dTotalBalance = 0
Else
	s_dTotalBalance = 0
	// Retrieve ledger items
	s_lRows = lds_LedgerItem.Retrieve(s_iLedgerYear)
	//messagebox("s_lRows",s_lRows)
	For s_iCount = 1 To s_iLedgerPeriod
	
		s_dPeriodBal = lds_LedgerItem.GetItemNumber(s_iCount,"period_bal")
		s_dTotalBalance = s_dTotalBalance + s_dPeriodBal
	
	Next
End If

s_dTotalBalance = s_dBegBalance + s_dTotalBalance
If IsNull(s_dTotalBalance) Then s_dTotalBalance = 0

dw_detail.SetItem(s_iRow,"beg_bank_balance",s_dTotalBalance)
dw_detail.Update()
COMMIT;

// Posted Monthly Receipts
s_dMonthReceipts = 0
SELECT SUM(total_received) INTO :s_dMonthReceipts
	FROM sh_docket_receipt
	WHERE sh_docket_receipt.post_date >= :s_dtBegDate
	AND sh_docket_receipt.post_date <= :s_dtEndDate
	AND sh_docket_receipt.post_date IS NOT NULL;
If IsNull(s_dMonthReceipts) Then s_dMonthReceipts = 0

dw_detail.SetItem(s_iRow,"receipts",s_dMonthReceipts)
dw_detail.Update()
COMMIT;

/*
s_dBankInterest = 0
SELECT SUM(amount) INTO :s_dBankInterest
	FROM ut_interest_ledger_item
	WHERE ut_interest_ledger_item.post_date >= :s_dtBegDate
	AND ut_interest_ledger_item.post_date <= :s_dtEndDate;
If IsNull(s_dBankInterest) Then s_dBankInterest = 0

dw_detail.SetItem(s_iRow,"bank_interest",s_dBankInterest)
dw_detail.Update()
COMMIT;
*/

// Cleared Warrants
s_dMonthClearedWarrants = 0
SELECT SUM(amount_paid) INTO :s_dMonthClearedWarrants
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.clear_date >= :s_dtBegDate
	AND sh_docket_disbursement.clear_date <= :s_dtEndDate
	AND sh_docket_disbursement.disburse_status = 'C';	

If IsNull(s_dMonthClearedWarrants) Then s_dMonthClearedWarrants = 0

dw_detail.SetItem(s_iRow,"cleared_warrants",s_dMonthClearedWarrants)
dw_detail.Update()
COMMIT;

// Ending Bank Balance
s_dEndBalance = 0
s_dEndBalance = s_dTotalBalance + s_dMonthReceipts - s_dMonthClearedWarrants
If IsNull(s_dEndBalance) Then s_dEndBalance = 0

dw_detail.SetItem(s_iRow,"end_bank_balance",s_dEndBalance)
dw_detail.Update()
COMMIT;

// Prior Outstanding Warrants
s_dOutstandingWarrants = 0
SELECT SUM(amount_paid) INTO :s_dOutstandingWarrants
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.date_paid < :s_dtBegDate
	AND sh_docket_disbursement.disburse_status = 'W';	

If IsNull(s_dOutstandingWarrants) Then s_dOutstandingWarrants = 0
dw_detail.SetItem(s_iRow,"outstanding_warrants",s_dOutstandingWarrants)
dw_detail.Update()
COMMIT;

// Current Outstanding Warrants
s_dCurrentWarrants = 0
SELECT SUM(amount_paid) INTO :s_dCurrentWarrants
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.date_paid >= :s_dtBegDate
	AND sh_docket_disbursement.date_paid <= :s_dtEndDate	
	AND sh_docket_disbursement.disburse_status = 'W';	

If IsNull(s_dCurrentWarrants) Then s_dCurrentWarrants = 0
dw_detail.SetItem(s_iRow,"current_warrants",s_dCurrentWarrants)
dw_detail.Update()
COMMIT;

// Unwarranted Items
s_dUnwarranted = 0
SELECT SUM(amount_paid) INTO :s_dUnwarranted
	FROM sh_docket_disbursement
	WHERE ( sh_docket_disbursement.disburse_status = 'O');	

If IsNull(s_dUnwarranted) Then s_dUnwarranted = 0
dw_detail.SetItem(s_iRow,"unwarranted",s_dUnwarranted)
dw_detail.Update()
COMMIT;

// Future Posted Receipts
s_dFutureReceipts = 0
SELECT SUM(total_received) INTO :s_dFutureReceipts
	FROM sh_docket_receipt
	WHERE sh_docket_receipt.post_date > :s_dtEndDate
	AND sh_docket_receipt.post_date IS NOT NULL;
If IsNull(s_dFutureReceipts) Then s_dFutureReceipts = 0

dw_detail.SetItem(s_iRow,"future_receipts",s_dFutureReceipts)
dw_detail.Update()
COMMIT;

// Future Cleared Warrants
s_dFutureCleared = 0
SELECT SUM(amount_paid) INTO :s_dFutureCleared
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.clear_date > :s_dtEndDate
	AND sh_docket_disbursement.disburse_status = 'C';	

If IsNull(s_dFutureCleared) Then s_dFutureCleared = 0

dw_detail.SetItem(s_iRow,"future_cleared",s_dFutureCleared)
dw_detail.Update()
COMMIT;

// Future Outstanding Warrants
s_dFutureOutstanding = 0
SELECT SUM(amount_paid) INTO :s_dFutureOutstanding
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.date_paid > :s_dtEndDate
	AND sh_docket_disbursement.disburse_status = 'W';	

If IsNull(s_dFutureOutstanding) Then s_dFutureOutstanding = 0
dw_detail.SetItem(s_iRow,"future_outstanding",s_dFutureOutstanding)
dw_detail.Update()
COMMIT;

// Sheriff Balance
s_dSheriffBalance = 0
s_dSheriffBalance = s_dEndBalance - s_dOutstandingWarrants - s_dCurrentWarrants - s_dUnwarranted + s_dFutureReceipts - s_dFutureCleared - s_dFutureOutstanding

dw_detail.SetItem(s_iRow,"sheriff_balance",s_dSheriffBalance)
dw_detail.Update()
COMMIT;

end event

type dw_recon_rpt from datawindow within w_check_book_reconciliation_sheet
boolean visible = false
integer x = 783
integer y = 240
integer width = 1968
integer height = 518
integer taborder = 250
boolean bringtotop = true
string dataobject = "dw_docket_reconcile_rpt"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_interest from statictext within w_check_book_reconciliation_sheet
integer x = 3237
integer y = 1446
integer width = 464
integer height = 77
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Month~'s Interest"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_interest from singlelineedit within w_check_book_reconciliation_sheet
integer x = 3237
integer y = 1510
integer width = 464
integer height = 80
integer taborder = 190
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_balance_rpt from commandbutton within w_check_book_reconciliation_sheet
integer x = 3237
integer y = 1606
integer width = 464
integer height = 67
integer taborder = 200
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Balance Rpt"
end type

event clicked;
string s_achReport, s_achDocNum
long s_lYear, s_lPeriod
integer s_iRow
decimal {2} s_dInterest

s_iRow = dw_scan.GetRow()

s_lYear = dw_scan.GetItemNumber(s_iRow, "docket_year")
s_lPeriod = dw_scan.GetItemNumber(s_iRow, "period")

s_dInterest = Dec(sle_interest.text)

// Retrieve Information
dw_recon_rpt.SetTransObject(SQLCA)
dw_recon_rpt.Reset()

dw_recon_rpt.Retrieve(s_lYear, s_lPeriod, s_dInterest)	

// Printer Setup and Printout depending on current detail window
OpenWithParm(w_datawindow_print_dialog,dw_recon_rpt)

end event

type dw_recon_detail from datawindow within w_check_book_reconciliation_sheet
boolean visible = false
integer x = 783
integer y = 848
integer width = 1968
integer height = 518
integer taborder = 240
boolean bringtotop = true
string dataobject = "dw_single_docket_reconcile"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

