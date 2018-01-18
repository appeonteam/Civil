$PBExportHeader$w_post_receipts_sheet.srw
forward
global type w_post_receipts_sheet from w_base_sheet
end type
type st_4 from statictext within w_post_receipts_sheet
end type
type em_beg_date from editmask within w_post_receipts_sheet
end type
type st_message from statictext within w_post_receipts_sheet
end type
type st_batch_accept from statictext within w_post_receipts_sheet
end type
type st_6 from statictext within w_post_receipts_sheet
end type
type em_end_date from editmask within w_post_receipts_sheet
end type
type st_1 from statictext within w_post_receipts_sheet
end type
type st_2 from statictext within w_post_receipts_sheet
end type
type cb_post from commandbutton within w_post_receipts_sheet
end type
type cb_unpost from commandbutton within w_post_receipts_sheet
end type
type gb_7 from groupbox within w_post_receipts_sheet
end type
type gb_6 from groupbox within w_post_receipts_sheet
end type
type st_5 from statictext within w_post_receipts_sheet
end type
type st_receipt_total from statictext within w_post_receipts_sheet
end type
type em_post_date from editmask within w_post_receipts_sheet
end type
type cb_post_all from commandbutton within w_post_receipts_sheet
end type
type st_7 from statictext within w_post_receipts_sheet
end type
type st_unposted_total from statictext within w_post_receipts_sheet
end type
end forward

global type w_post_receipts_sheet from w_base_sheet
integer x = 40
integer y = 29
integer width = 3752
integer height = 2106
string title = "Post Receipts Information"
windowstate windowstate = normal!
toolbaralignment toolbaralignment = alignatleft!
st_4 st_4
em_beg_date em_beg_date
st_message st_message
st_batch_accept st_batch_accept
st_6 st_6
em_end_date em_end_date
st_1 st_1
st_2 st_2
cb_post cb_post
cb_unpost cb_unpost
gb_7 gb_7
gb_6 gb_6
st_5 st_5
st_receipt_total st_receipt_total
em_post_date em_post_date
cb_post_all cb_post_all
st_7 st_7
st_unposted_total st_unposted_total
end type
global w_post_receipts_sheet w_post_receipts_sheet

type variables
string i_achSaveSQL, i_achMode, i_achNewSQL
string i_achCondominium, i_achSubdivision
string i_achLName, i_achFName
string i_achParcelNum, i_achCommunity
integer i_iLegalNum, i_iOwnerRow
date i_dtStartDate, i_dtEndDate, i_dtPostDate
decimal {2} i_dPropertyTaxBase
boolean i_bFirstSearch, i_bExit, i_bContinueItem, i_bName
boolean i_bOwner, i_bLegal, i_bNew
boolean i_bMemo, i_bButtonOnly



end variables

on w_post_receipts_sheet.create
int iCurrent
call super::create
this.st_4=create st_4
this.em_beg_date=create em_beg_date
this.st_message=create st_message
this.st_batch_accept=create st_batch_accept
this.st_6=create st_6
this.em_end_date=create em_end_date
this.st_1=create st_1
this.st_2=create st_2
this.cb_post=create cb_post
this.cb_unpost=create cb_unpost
this.gb_7=create gb_7
this.gb_6=create gb_6
this.st_5=create st_5
this.st_receipt_total=create st_receipt_total
this.em_post_date=create em_post_date
this.cb_post_all=create cb_post_all
this.st_7=create st_7
this.st_unposted_total=create st_unposted_total
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.em_beg_date
this.Control[iCurrent+3]=this.st_message
this.Control[iCurrent+4]=this.st_batch_accept
this.Control[iCurrent+5]=this.st_6
this.Control[iCurrent+6]=this.em_end_date
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.cb_post
this.Control[iCurrent+10]=this.cb_unpost
this.Control[iCurrent+11]=this.gb_7
this.Control[iCurrent+12]=this.gb_6
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.st_receipt_total
this.Control[iCurrent+15]=this.em_post_date
this.Control[iCurrent+16]=this.cb_post_all
this.Control[iCurrent+17]=this.st_7
this.Control[iCurrent+18]=this.st_unposted_total
end on

on w_post_receipts_sheet.destroy
call super::destroy
destroy(this.st_4)
destroy(this.em_beg_date)
destroy(this.st_message)
destroy(this.st_batch_accept)
destroy(this.st_6)
destroy(this.em_end_date)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_post)
destroy(this.cb_unpost)
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.st_5)
destroy(this.st_receipt_total)
destroy(this.em_post_date)
destroy(this.cb_post_all)
destroy(this.st_7)
destroy(this.st_unposted_total)
end on

event ue_search;call super::ue_search;// script variables
string s_achSQL, s_achDWColor, s_achLName, s_achFName, s_achParcelNum
string s_achNewSQL, s_achTownship, s_achSection, s_achParcelBlk, s_achParcel, s_achBldg
string s_achStatus
long s_lCheckNum
integer s_iNumRows, s_iPosition, s_iYear
string s_achStart, s_achStartYear, s_achStartMonth, s_achStartDay
integer s_iStartYear, s_iStartMonth, s_iStartDay
string s_achEnd, s_achEndYear, s_achEndMonth, s_achEndDay
integer s_iEndYear, s_iEndMonth, s_iEndDay
string s_achPost, s_achPostYear, s_achPostMonth, s_achPostDay
integer s_iPostYear, s_iPostMonth, s_iPostDay

SetPointer(HourGlass!)

i_bButtonOnly = False

cb_add.enabled = False
m_main.m_general.m_add.enabled = False

// Security - Add Ledger Information
If w_main.dw_perms.Find("code=53", 1, w_main.dw_perms.RowCount()) > 0 Then
//	cb_new.enabled = True
//	m_main.m_general.m_new.enabled = True
End If

// Security - Update Ledger
If w_main.dw_perms.Find("code=54", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_update.enabled = True
	m_main.m_general.m_update.enabled = True
End If

// Security - Delete Ledger Information
If w_main.dw_perms.Find("code=55", 1, w_main.dw_perms.RowCount()) > 0 Then
//	cb_delete.enabled = True	
//	m_main.m_general.m_delete.enabled = True
End If

s_achDWColor = dw_detail.Describe("datawindow.color")

dw_detail.DataObject = "dw_post_receipt_detail"

dw_detail.SetRedraw(False)
dw_detail.Modify("post_date.background.color = " + s_achDWColor + & 
	" post_date.tabsequence = 0")
dw_detail.SetRedraw(True)

SetNull(i_dtStartDate)
SetNull(i_dtEndDate)
SetNull(i_dtPostDate)

s_achStart = Trim(String(em_beg_date.text))
s_achStartYear = Mid(s_achStart,7,4)
s_achStartMonth = Mid(s_achStart,1,2)
s_achStartDay = Mid(s_achStart,4,2)
s_iStartYear = Integer(s_achStartYear)
s_iStartMonth = Integer(s_achStartMonth)
s_iStartDay = Integer(s_achStartDay)
If s_achStart <> "" And s_achStart <> "00/00/0000" Then
	i_dtStartDate = Date(s_iStartYear, s_iStartMonth, s_iStartDay)
Else
	SetNull(i_dtStartDate)
End If	

s_achEnd = Trim(String(em_end_date.text))
s_achEndYear = Mid(s_achEnd,7,4)
s_achEndMonth = Mid(s_achEnd,1,2)
s_achEndDay = Mid(s_achEnd,4,2)
s_iEndYear = Integer(s_achEndYear)
s_iEndMonth = Integer(s_achEndMonth)
s_iEndDay = Integer(s_achEndDay)
If s_achEnd <> "" And s_achEnd <> "00/00/0000" Then
	i_dtEndDate = Date(s_iEndYear, s_iEndMonth, s_iEndDay)
Else
	SetNull(i_dtEndDate)
End If	

s_achPost = Trim(String(em_post_date.text))
s_achPostYear = Mid(s_achPost,7,4)
s_achPostMonth = Mid(s_achPost,1,2)
s_achPostDay = Mid(s_achPost,4,2)
s_iPostYear = Integer(s_achPostYear)
s_iPostMonth = Integer(s_achPostMonth)
s_iPostDay = Integer(s_achPostDay)
If s_achPost <> "" And s_achPost <> "00/00/0000" Then
	i_dtPostDate = Date(s_iPostYear, s_iPostMonth, s_iPostDay)
Else
	SetNull(i_dtPostDate)
End If	


	
If s_achStart <> "" And s_achStart <> "00/00/0000" And Not IsNull(s_achStart) Then
	If Len(s_achSQL) = 0 Then
		s_achSQL = &
			" WHERE sh_docket_receipt.date_received >= ~~~'" + String(i_dtStartDate, "yyyy-mm-dd") + "~~~'" 
	Else 
		s_achSQL += &
			" AND sh_docket_receipt.date_received >= ~~~'" + String(i_dtStartDate, "yyyy-mm-dd") + "~~~'" 
	End If
End If

If s_achEnd <> "" And s_achEnd <> "00/00/0000" And Not IsNull(s_achEnd) Then
	If Len(s_achSQL) = 0 Then
		s_achSQL = &
			" WHERE sh_docket_receipt.date_received <= ~~~'" + String(i_dtEndDate, "yyyy-mm-dd") + "~~~'" 
	Else 
		s_achSQL += &
			" AND sh_docket_receipt.date_received <= ~~~'" + String(i_dtEndDate, "yyyy-mm-dd") + "~~~'" 
	End If
End If

// Status
If s_achStatus <> "" Then
	If Len(s_achSQL) = 0 Then
		s_achSQL = &
			 " AND sh_docket_disbursement.disburse_status = ~~~'" + s_achStatus + "~~~'" 
	Else
		s_achSQL += &
			 " AND sh_docket_disbursement.disburse_status = ~~~'" + s_achStatus + "~~~'" 
	End If	
End If


s_achSQL += &
   " ORDER BY sh_docket_receipt.receipt_number DESC" 
s_achSQL = i_achSQL + s_achSQL
i_achSaveSQL = s_achSQL

// NEW Entry
s_achNewSQL += &
   " ORDER BY sh_docket_receipt.receipt_number DESC" 
i_achNewSQL = i_achSQL + s_achNewSQL
//messagebox("sql",s_achsql)
dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")

dw_scan.Reset()
If dw_scan.Retrieve() = 0 Then
	MessageBox("Complete", "No Check rows found.")
	
	em_beg_date.SetFocus()
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
gnv_resize.of_Register(st_1, gnv_resize.SCALE)
gnv_resize.of_Register(st_2, gnv_resize.SCALE)
gnv_resize.of_Register(st_4, gnv_resize.SCALE)
gnv_resize.of_Register(st_5, gnv_resize.SCALE)
gnv_resize.of_Register(st_6, gnv_resize.SCALE)
gnv_resize.of_Register(st_7, gnv_resize.SCALE)
gnv_resize.of_Register(st_batch_accept, gnv_resize.SCALE)
gnv_resize.of_Register(st_message, gnv_resize.SCALE)
gnv_resize.of_Register(st_receipt_total, gnv_resize.SCALE)
gnv_resize.of_Register(st_unposted_total, gnv_resize.SCALE)
gnv_resize.of_Register(em_beg_date, gnv_resize.SCALE)
gnv_resize.of_Register(em_end_date, gnv_resize.SCALE)
gnv_resize.of_Register(em_post_date, gnv_resize.SCALE)

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
gnv_resize.of_Register(gb_7, gnv_resize.SCALE)

gnv_resize.of_Register(cb_post, gnv_resize.SCALE)
gnv_resize.of_Register(cb_post_all, gnv_resize.SCALE)
gnv_resize.of_Register(cb_unpost, gnv_resize.SCALE)

i_bFirstSearch = True

/*
// get Transaction Type Code
dw_scan.GetChild("transaction_type", dwc)
dwc.SetTransObject(SQLCA)
dwc.Reset()
dwc.Retrieve("TTRAN")
*/
em_beg_date.text = String(Today(), "mm/dd/yyyy")
em_end_date.text = String(Today(), "mm/dd/yyyy")
em_post_date.text = String(Today(), "mm/dd/yyyy")

em_beg_date.SetFocus()

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

cb_post.pointer="arrow!"
cb_unpost.pointer="arrow!"
gb_6.pointer="arrow!"
gb_7.pointer="arrow!"

end event

event ue_next;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_reconcile_check_detail"
		
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
	Case "dw_reconcile_check_detail"

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

event ue_val_fields;integer s_iRowCount, s_iRow, s_iCount, s_iPeriodNum, s_iDockYear
string s_achReconcile
long s_lLineNum
date s_dtDisburseDate
decimal {2} s_dAmountPaid

dw_detail.SetTransObject(SQLCA)
dw_detail.AcceptText()
Choose Case dw_detail.DataObject
	
	Case "dw_reconcile_check_detail"

		If IsNull(dw_detail.GetItemString(1,"reconcile")) Or (dw_detail.GetItemString(1,"reconcile") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Reconcile MUST be entered!")
			dw_detail.SetColumn("reconcile")
			dw_detail.SetFocus()
			Return
		End If	

End Choose		

Choose Case dw_detail.DataObject

	Case "dw_reconcile_check_detail"

		s_iRow = dw_detail.GetRow()
		s_achReconcile = Trim(dw_detail.GetItemString(s_iRow, "reconcile"))
		s_iDockYear = dw_detail.GetItemNumber(s_iRow, "docket_year")				
		s_dAmountPaid = dw_detail.GetItemNumber(s_iRow, "amount_paid")		
		s_dtDisburseDate = Date(dw_detail.GetItemDateTime(s_iRow, "date_paid"))
		s_iPeriodNum = Month(s_dtDisburseDate)					
	
		If i_achOpType = "Update" Then		
			
			If s_achReconcile = "Y" Then
				dw_detail.SetItem(s_iRow, "disburse_status", "C")					
		
				// Debit Ledger - "-"
				UPDATE ut_ledger_item
						SET ut_ledger_item.period_bal = ut_ledger_item.period_bal - :s_dAmountPaid 
					WHERE ut_ledger_item.dock_year = :s_iDockYear
					AND ut_ledger_item.cb_type = 'D'
					AND ut_ledger_item.period = :s_iPeriodNum;								
				If SQLCA.SQLCODE = -1 Then
					MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
					ROLLBACK;
					Return
				Else
					COMMIT;
				End If				
				
				
			Else
				dw_detail.SetItem(s_iRow, "disburse_status", "W")									
				
				// Credit Ledger - "+"
				UPDATE ut_ledger_item
						SET ut_ledger_item.period_bal = ut_ledger_item.period_bal + :s_dAmountPaid 
					WHERE ut_ledger_item.dock_year = :s_iDockYear
					AND ut_ledger_item.cb_type = 'D'
					AND ut_ledger_item.period = :s_iPeriodNum;								
				If SQLCA.SQLCODE = -1 Then
					MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
					ROLLBACK;
					Return
				Else
					COMMIT;
				End If				
				
			End If
			
		End If
			
End Choose   

end event

event ue_clear;call super::ue_clear;
em_beg_date.text = ""
em_end_date.text = ""
em_post_date.text = ""

i_achOpType = ""
SetNull(i_dtStartDate)
SetNull(i_dtEndDate)
SetNull(i_dtPostDate)
i_bFirstSearch = True

cb_first.enabled = False
m_main.m_general.m_first.enabled = False
cb_back.enabled = False
m_main.m_general.m_back.enabled = False
cb_next.enabled = False
m_main.m_general.m_next.enabled = False
cb_last.enabled = False
m_main.m_general.m_last.enabled = False

em_beg_date.SetFocus()

dw_detail.Tag = "Posted Deposit Receipt Information"
dw_detail.DataObject = "dw_post_receipt_detail"
dw_detail.SetTransObject(SQLCA)

end event

event ue_first;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_reconcile_check_detail"
		
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
integer s_iRow, s_iScanRow, s_iRowCount

i_achOpType ="Update"

s_achDWColor = dw_scan.Describe("datawindow.color")
s_achDDWColor = dw_detail.Describe("datawindow.color")

s_iScanRow = dw_scan.GetRow()
s_iRow = dw_detail.GetRow()
Choose Case dw_detail.DataObject
			 
	Case "dw_reconcile_check_detail"

		dw_detail.SetRedraw(False)
		dw_detail.Modify("reconcile.background.color = " + s_achDWColor + & 
			" reconcile.tabsequence = 1")
		dw_detail.SetColumn("reconcile")						
		
End Choose 
dw_detail.SetRedraw(True)
dw_detail.SetRow(s_iRow)		
dw_detail.SetFocus()

end event

event ue_save;// script variables
string s_achDWColor, s_achErrText, s_achCBType
integer s_iRow, s_iCount, s_iLineNum, s_iCBDisYear
long s_lCBDisNum

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
	Case "dw_reconcile_check_detail"

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
			dw_detail.Modify("reconcile.background.color = " + s_achDWColor + & 
				" reconcile.tabsequence = 0")
			dw_detail.SetRedraw(True)

			// Security - Add Ledger Information
			If w_main.dw_perms.Find("code=53", 1, w_main.dw_perms.RowCount()) > 0 Then
//				cb_new.enabled = True
//				m_main.m_general.m_new.enabled = True
			End If
			
			// Security - Update Ledger Information
			If w_main.dw_perms.Find("code=54", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_update.enabled = True				
				m_main.m_general.m_update.enabled = True
			End If
			
			// Security - Delete Ledger Information
			If w_main.dw_perms.Find("code=55", 1, w_main.dw_perms.RowCount()) > 0 Then
//				cb_delete.enabled = True				
//				m_main.m_general.m_delete.enabled = True
			End If

			cb_escape.enabled = False
			m_main.m_general.m_escape.enabled = False
			cb_save.enabled = False
			m_main.m_general.m_save.enabled = False

			s_iRow = dw_detail.GetRow()
			s_achCBType = Trim(dw_detail.GetItemString(s_iRow,"cb_type"))
			s_iCBDisYear = dw_detail.GetItemNumber(s_iRow,"cbdis_year")
			s_lCBDisNum = dw_detail.GetItemNumber(s_iRow,"cbdis_number")									
			
			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)			
	
//			If i_achOpType = "Add" Then
//				dw_scan.Modify("datawindow.table.select='" + i_achNewSQL + "'")	
//			Else
				dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")		
//			End If

			dw_scan.Retrieve("O")		

			integer s_sRow						
			// find the row closest to this one
			s_sRow = dw_scan.Find("cb_type = '" + s_achCBType + &
				"' AND cbdis_year = " + String(s_iCBDisYear) + &
				" AND cbdis_number = " + String(s_lCBDisNum), 0, dw_scan.RowCount())

			If s_sRow = 0 Then s_sRow = 1
	
			// highlight only the closest row
			dw_scan.ScrollToRow(s_sRow)				
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(s_sRow, True)										
	
			dw_scan.SetRedraw(True)
			dw_scan.enabled = True			
			cb_search.PostEvent("clicked")
		End If

End Choose

dw_scan.SetFocus()

end event

event ue_last;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_reconcile_check_detail"
		
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

event ue_new;// OVERRIDE

/*
datawindowchild dwc
string s_achDWColor, s_achName, s_achTaxStatus, s_achTaxDistrict, s_achLandUse
string s_achClassCode, s_achSubclassCode, s_achCityTownship, s_achNeighborhood
long s_lCityNum
st_newparcelyearparms s_stnewparcelyearparms

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

// Security - Add ACH Submission Information
If w_main.dw_perms.Find("code=752", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_escape.enabled = True
	m_main.m_general.m_escape.enabled = True	
	cb_save.enabled = True
	m_main.m_general.m_save.enabled = True
End If

// Security - Update ACH Submission Information
If w_main.dw_perms.Find("code=753", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_escape.enabled = True
	m_main.m_general.m_escape.enabled = True		
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

// Security - Delete ACH Submission Information
If w_main.dw_perms.Find("code=754", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_escape.enabled = True
	m_main.m_general.m_escape.enabled = True		
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

dw_detail.Tag = "ACH Transaction Information"
dw_detail.DataObject = "dw_ach_transaction_detail"
dw_detail.SetTransObject(SQLCA)

Choose Case dw_detail.DataObject
	Case "dw_ach_transaction_detail"

		// get Transaction Type Code
		dw_detail.GetChild("transaction_type", dwc)
		dwc.SetTransObject(SQLCA)
		dwc.Reset()
		dwc.Retrieve("TTRAN")

		dw_detail.Tag = "ACH Transaction Information"		
		dw_detail.Reset()		
		dw_detail.InsertRow(0)

		dw_detail.SetItem(1,"transaction_number", 0)					
		dw_detail.SetItem(1,"ssan", "")																					
		dw_detail.SetItem(1,"transaction_type", "")																			
		dw_detail.SetItem(1,"identifier_number", "")															
		dw_detail.SetItem(1,"transaction_date", i_dtImportDate)																	
		dw_detail.SetItem(1,"amount", 0)																			
		dw_detail.SetItem(1,"submitted", "N")																					
		dw_detail.SetItem(1,"last_chg_login", "")					
		dw_detail.SetItem(1,"last_chg_datetime", "")						
									
		dw_detail.SetRedraw(False)
		dw_detail.Modify("ssan.background.color = " + s_achDWColor + & 
			" ssan.tabsequence = 2" + &					
			" transaction_type.background.color = " + s_achDWColor + & 
			" transaction_type.tabsequence = 3" + &		
			" identifier_number.background.color = " + s_achDWColor + & 
			" identifier_number.tabsequence = 4" + &					
			" transaction_date.background.color = " + s_achDWColor + & 
			" transaction_date.tabsequence = 5" + &
			" amount.background.color = " + s_achDWColor + & 
			" amount.tabsequence = 6")			
		dw_detail.SetRedraw(True)		
		
		i_iRow = 1
		dw_detail.SetRow(i_iRow)		
		dw_detail.ScrollToRow(i_iRow)								

End Choose	

dw_detail.SetFocus()
*/
end event

event ue_delete;// OVERRIDE

/*
// script variables
string s_achErrText
integer s_iCount, s_iRow, s_iParcelYear

i_achMode = ""
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
	Case "dw_ach_transaction_detail"
		
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
		   If 2 = MessageBox("Delete","Delete This ACH Transaction?",Question!,YesNo!,2) Then
		      MessageBox("Delete","ACH Transaction NOT Deleted",None!)
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
*/

end event

event ue_print_detail;//datawindowchild dwc
//string s_achReport, s_achDocNum
//
//s_achReport = "Single Document Indexing Document"
//
//s_achDocNum = dw_scan.GetItemString(i_iRow, "document_number")
//
//// Retrieve Information
//dw_single_doc.SetTransObject(SQLCA)
//dw_single_doc.Reset()
//
//// get Group Number
//dw_single_doc.GetChild("group_number", dwc)
//dwc.SetTransObject(SQLCA)
//dwc.Reset()
//dwc.Retrieve("GROUP")
//
//// get Doc Type
//dw_single_doc.GetChild("doc_type", dwc)
//dwc.SetTransObject(SQLCA)
//dwc.Reset()
//dwc.Retrieve("DOC")
//
//// get Payment Type
//dw_single_doc.GetChild("payment_type", dwc)
//dwc.SetTransObject(SQLCA)
//dwc.Reset()
//dwc.Retrieve("PAY")
//
//// get Document Exemption Type
//dw_single_doc.GetChild("exemption_number", dwc)
//dwc.SetTransObject(SQLCA)
//dwc.Reset()
//dwc.Retrieve("DEXEM")
//
//dw_single_doc.Retrieve(s_achDocNum)	
//
//// Printer Setup and Printout depending on current detail window
//PrintSetup()
//
//dw_single_doc.Print()
//
end event

event ue_add;// OVERRIDE

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

type cb_escape from w_base_sheet`cb_escape within w_post_receipts_sheet
integer x = 3237
integer taborder = 140
end type

type cb_exit from w_base_sheet`cb_exit within w_post_receipts_sheet
integer x = 3485
integer taborder = 180
end type

type cb_last from w_base_sheet`cb_last within w_post_receipts_sheet
integer x = 3485
integer taborder = 170
end type

type cb_next from w_base_sheet`cb_next within w_post_receipts_sheet
integer x = 3485
integer taborder = 160
end type

type cb_back from w_base_sheet`cb_back within w_post_receipts_sheet
integer x = 3485
integer taborder = 150
end type

type cb_first from w_base_sheet`cb_first within w_post_receipts_sheet
integer x = 3485
integer taborder = 130
end type

type cb_save from w_base_sheet`cb_save within w_post_receipts_sheet
integer x = 3237
integer taborder = 100
end type

type cb_delete from w_base_sheet`cb_delete within w_post_receipts_sheet
integer x = 3237
integer taborder = 90
end type

type cb_update from w_base_sheet`cb_update within w_post_receipts_sheet
integer x = 3237
integer taborder = 80
end type

event cb_update::clicked;call super::clicked;i_achMode = ""
end event

type cb_add from w_base_sheet`cb_add within w_post_receipts_sheet
integer x = 3237
integer taborder = 70
end type

type cb_new from w_base_sheet`cb_new within w_post_receipts_sheet
integer x = 3237
integer taborder = 60
end type

type cb_clear from w_base_sheet`cb_clear within w_post_receipts_sheet
integer x = 3237
integer taborder = 50
end type

type cb_search from w_base_sheet`cb_search within w_post_receipts_sheet
integer x = 3237
integer taborder = 40
end type

type dw_detail from w_base_sheet`dw_detail within w_post_receipts_sheet
event ue_dwnkey pbm_dwnkey
event ue_continue_add pbm_custom13
integer x = 29
integer y = 1338
integer width = 3163
integer height = 560
integer taborder = 230
string dataobject = "dw_post_receipt_detail"
end type

event dw_detail::ue_dwnkey;string s_achDWColor
integer s_iRow, s_lCount, s_iCBDisYear
long s_lTransactionNum, s_lCBDisNum

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject

	Case "dw_reconcile_check_detail"
		
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "reconcile"
				If KeyDown(KeyEnter!) Or KeyDown(KeyTab!) Then		
					parent.TriggerEvent("ue_save")
					Return
				End If
	
		End Choose 
			
End Choose 

end event

event dw_detail::ue_tabenter;
Choose Case dw_detail.DataObject
		
	Case "dw_reconcile_check_detail"
		
		Send(Handle(this),256,9,Long(0,0))
		RETURN 1
			
End Choose		

end event

type dw_scan from w_base_sheet`dw_scan within w_post_receipts_sheet
integer x = 29
integer y = 118
integer width = 3163
integer height = 1110
integer taborder = 220
string dataobject = "dw_post_receipt_scan"
end type

event dw_scan::rowfocuschanged;datawindowchild	dwc
string s_achDocNum, s_achBook
long s_lCount, s_lRowCount, s_lCurrentRow, s_lRow
date s_dtImport
decimal {2} s_dTotalReceived, s_dCanceled, s_dTotalUnposted
			
dw_detail.SetTransObject(SQLCA)

i_irow = dw_scan.GetRow()

If i_iRow > 0 Then
	
	Choose Case dw_detail.DataObject
		Case "dw_post_receipt_detail"

			dw_detail.Tag = "Posted Deposit Receipt Information"

			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(currentrow, True)
			
			dw_detail.Retrieve(dw_scan.GetItemString(i_irow, "cb_type"), &
				dw_scan.GetItemNumber(i_irow, "cbrec_year"), &
				dw_scan.GetItemNumber(i_irow, "cbrec_number"))

//			s_dtStart = Date(dw_scan.GetItemDateTime(i_irow, "_date"))		

			// Posted Receipt Total
			s_dTotalReceived = 0
			SELECT SUM(total_received)
				INTO :s_dTotalReceived
				FROM sh_docket_receipt
				WHERE date_received >= :i_dtStartDate				
				AND date_received <= :i_dtEndDate
				AND post_date is not null;
			If IsNull(s_dTotalReceived) Then s_dTotalReceived = 0	

			st_receipt_total.text = string(s_dTotalReceived, '#,##0.00')

			// Unposted Receipt Total
			s_dTotalUnposted = 0
			SELECT SUM(total_received)
				INTO :s_dTotalUnposted
				FROM sh_docket_receipt
				WHERE date_received >= :i_dtStartDate				
				AND date_received <= :i_dtEndDate
				AND post_date is null;
			If IsNull(s_dTotalUnposted) Then s_dTotalUnposted = 0	

			st_unposted_total.text = string(s_dTotalUnposted, '#,##0.00')			
			
			
			// RowFocusChanged Trigger for Title Refreshment
			dw_detail.TriggerEvent(RowFocusChanged!)				
			
	End Choose		

End If	
end event

type gb_5 from w_base_sheet`gb_5 within w_post_receipts_sheet
integer x = 3460
end type

type gb_4 from w_base_sheet`gb_4 within w_post_receipts_sheet
integer x = 3460
end type

type gb_1 from w_base_sheet`gb_1 within w_post_receipts_sheet
integer x = 3211
integer textsize = -9
end type

type gb_2 from w_base_sheet`gb_2 within w_post_receipts_sheet
integer x = 3211
end type

type cb_list from w_base_sheet`cb_list within w_post_receipts_sheet
integer x = 3485
integer taborder = 110
end type

type cb_detail from w_base_sheet`cb_detail within w_post_receipts_sheet
integer x = 3485
integer taborder = 120
end type

type gb_3 from w_base_sheet`gb_3 within w_post_receipts_sheet
integer x = 3460
end type

type st_4 from statictext within w_post_receipts_sheet
integer x = 4
integer y = 35
integer width = 380
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Start Date:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_beg_date from editmask within w_post_receipts_sheet
integer x = 395
integer y = 22
integer width = 446
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
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
boolean spin = true
end type

type st_message from statictext within w_post_receipts_sheet
integer x = 29
integer y = 1245
integer width = 3163
integer height = 83
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388736
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_batch_accept from statictext within w_post_receipts_sheet
boolean visible = false
integer x = 3211
integer y = 1603
integer width = 497
integer height = 83
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_post_receipts_sheet
boolean visible = false
integer x = 3211
integer y = 1536
integer width = 497
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long backcolor = 12632256
boolean enabled = false
string text = "Reconciled Amt"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_end_date from editmask within w_post_receipts_sheet
integer x = 1178
integer y = 19
integer width = 446
integer height = 83
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
boolean spin = true
end type

type st_1 from statictext within w_post_receipts_sheet
integer x = 874
integer y = 29
integer width = 296
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "End Date:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_post_receipts_sheet
integer x = 2450
integer y = 32
integer width = 278
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Post Date:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_post from commandbutton within w_post_receipts_sheet
integer x = 3237
integer y = 819
integer width = 450
integer height = 67
integer taborder = 190
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Post Receipt"
end type

event clicked;
long s_lrow, s_lCBRecNum
integer s_iCBRecYear, s_iPeriodNum
string s_achInstrument, s_achErrText, s_achCBType
string s_achSQL, s_achNewSQL
datetime s_dtPostDateTime
date s_dtPostDate
decimal {2} s_dTotAmtRcvd

s_lrow = dw_scan.GetRow()

s_achCBType = Trim(dw_scan.GetItemString(s_lrow, "cb_type"))
s_iCBRecYear = dw_scan.GetItemNumber(s_lrow, "cbrec_year")
s_lCBRecNum = dw_scan.GetItemNumber(s_lrow, "cbrec_number")
s_dTotAmtRcvd = dw_scan.GetItemNumber(s_lrow, "total_received")

//s_dtPostDate = Date(s_dtPostDateTime)
s_iPeriodNum = Month(i_dtPostDate)					


UPDATE sh_docket_receipt
	SET post_date = :i_dtPostDate
	WHERE cb_type = :s_achCBType
	AND cbrec_year = :s_iCBRecYear
	AND cbrec_number = :s_lCBRecNum;
If SQLCA.SQLCode = -1 Then
	s_achErrText = SQLCA.SQLErrText
	ROLLBACK USING SQLCA;
	MessageBox("Error", "Update Failed - " + s_achErrText)
Else
	MessageBox("Post Deposit Receipt Information", "Receipt Posted")
	
	s_achSQL = dw_scan.GetSQLSelect()
	
	dw_scan.SetTransObject(SQLCA)
	dw_scan.SetRedraw(False)			
	dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
	
	dw_scan.Retrieve() 			
	
	long s_sRow
	// find the row closest to this one
	s_sRow = dw_scan.Find("cb_type = '" + s_achCBType + &
		"' AND cbrec_year = " + String(s_iCBRecYear) + &
		" AND cbrec_number = " + String(s_lCBRecNum), 0, dw_scan.RowCount())
	
	If s_sRow = 0 Then s_sRow = 1
	
	If s_sRow = 1 Then
		dw_scan.TriggerEvent(rowfocuschanged!)
	End If
	
	// highlight only the closest row
	dw_scan.ScrollToRow(s_sRow)				
	dw_scan.SelectRow(0,False)
	dw_scan.SelectRow(s_sRow, True)										
	
	dw_scan.SetRedraw(True)
	dw_scan.enabled = True	
	
	
	// Post to ut_ledger
	
	// Debit Ut_Ledger - "+"
	UPDATE ut_ledger_item
			SET ut_ledger_item.period_bal = ut_ledger_item.period_bal + :s_dTotAmtRcvd 
		WHERE ut_ledger_item.dock_year = :s_iCBRecYear
		AND ut_ledger_item.period = :s_iPeriodNum;								
	If SQLCA.SQLCODE = -1 Then
		MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
		ROLLBACK;
		Return
	Else
		COMMIT;
	End If					

End If
dw_scan.SetFocus()
	



end event

type cb_unpost from commandbutton within w_post_receipts_sheet
integer x = 3237
integer y = 909
integer width = 450
integer height = 67
integer taborder = 200
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Unpost Receipt"
end type

event clicked;
long s_lrow, s_lCBRecNum
integer s_iCBRecYear
string s_achInstrument, s_achErrText, s_achCBType
string s_achSQL, s_achNewSQL

s_lrow = dw_scan.GetRow()

s_achCBType = Trim(dw_scan.GetItemString(s_lrow, "cb_type"))
s_iCBRecYear = dw_scan.GetItemNumber(s_lrow, "cbrec_year")
s_lCBRecNum = dw_scan.GetItemNumber(s_lrow, "cbrec_number")

UPDATE sh_docket_receipt
	SET post_date = NULL                 
	WHERE cb_type = :s_achCBtype
	AND cbrec_year = :s_iCBRecYear
	AND cbrec_number = :s_lCBRecNum;
	
COMMIT;
If SQLCA.SQLCode = -1 Then
	s_achErrText = SQLCA.SQLErrText
	ROLLBACK USING SQLCA;
	MessageBox("Error", "Update Failed - " + s_achErrText)
Else
	MessageBox("Post Deposit Receipt Information", "Receipt Unposted")
	
	s_achSQL = dw_scan.GetSQLSelect()
	
	dw_scan.SetTransObject(SQLCA)
	dw_scan.SetRedraw(False)			
	dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
	
	dw_scan.Retrieve() 			
	
	long s_sRow
	// find the row closest to this one
	s_sRow = dw_scan.Find("cb_type = '" + s_achCBType + &
		"' AND cbrec_year = " + String(s_iCBRecYear) + &
		" AND cbrec_number = " + String(s_lCBRecNum), 0, dw_scan.RowCount())
	
	If s_sRow = 0 Then s_sRow = 1
	
	If s_sRow = 1 Then
		dw_scan.TriggerEvent(rowfocuschanged!)
	End If
	
	// highlight only the closest row
	dw_scan.ScrollToRow(s_sRow)				
	dw_scan.SelectRow(0,False)
	dw_scan.SelectRow(s_sRow, True)										
	
	dw_scan.SetRedraw(True)
	dw_scan.enabled = True		
/*	
	// Debit Ut_Ledger - "+"
	UPDATE ut_ledger_item
			SET ut_ledger_item.period_bal = ut_ledger_item.period_bal + :s_dTotAmtRcvd 
		WHERE ut_ledger_item.dock_year = :s_iCBRecYear
		AND ut_ledger_item.period = :s_iPeriodNum;								
	If SQLCA.SQLCODE = -1 Then
		MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
		ROLLBACK;
		Return
	Else
		COMMIT;
	End If					
	*/
End If
dw_scan.SetFocus()
end event

type gb_7 from groupbox within w_post_receipts_sheet
integer x = 3211
integer y = 1040
integer width = 497
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "All Receipts"
end type

type gb_6 from groupbox within w_post_receipts_sheet
integer x = 3211
integer y = 755
integer width = 497
integer height = 250
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Single Receipt"
end type

type st_5 from statictext within w_post_receipts_sheet
integer x = 3211
integer y = 1277
integer width = 497
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long backcolor = 12632256
boolean enabled = false
string text = "Posted Amt"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_receipt_total from statictext within w_post_receipts_sheet
integer x = 3222
integer y = 1347
integer width = 472
integer height = 83
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_post_date from editmask within w_post_receipts_sheet
integer x = 2743
integer y = 19
integer width = 446
integer height = 83
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
boolean spin = true
end type

type cb_post_all from commandbutton within w_post_receipts_sheet
integer x = 3237
integer y = 1104
integer width = 450
integer height = 67
integer taborder = 210
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Post &All Receipt"
end type

event clicked;
long s_lrow, s_lCBRecNum, s_lReceiptRows, s_lCount, s_lReceiptNum
integer s_iCBRecYear, s_iPeriodNum
string s_achInstrument, s_achErrText, s_achCBType
string s_achSQL, s_achNewSQL
datetime s_dtPostDateTime
date s_dtPostDate
decimal {2} s_dTotAmtRcvd

datastore lds_Receipt

// allocate the resources for the datastores
lds_Receipt = Create DataStore
			
lds_Receipt.DataObject = 'dw_post_deposit_receipts_ds'
lds_Receipt.SetTransObject(SQLCA)

s_iPeriodNum = Month(i_dtPostDate)					

// Retrieve receipts for a specified range
s_lReceiptRows = lds_Receipt.Retrieve(i_dtStartDate, i_dtEndDate)
messagebox("rows",s_lReceiptRows)
For s_lCount = 1 To s_lReceiptRows

	s_achCBType = Trim(lds_Receipt.GetItemString(s_lCount,"cb_type"))
	If IsNull(s_achCBType) Then s_achCBType = ""

	s_lCBRecNum = lds_Receipt.GetItemNumber(s_lCount, "cbrec_number")
	s_iCBRecYear = lds_Receipt.GetItemNumber(s_lCount, "cbrec_year")			
	s_lReceiptNum = lds_Receipt.GetItemNumber(s_lCount, "receipt_number")			

	s_dTotAmtRcvd = lds_Receipt.GetItemNumber(s_lCount, "total_received")							

	st_message.Text = "Receipt " + String(s_lReceiptNum) + " Posted"

	UPDATE sh_docket_receipt
		SET post_date = :i_dtPostDate
		WHERE cb_type = :s_achCBType
		AND cbrec_year = :s_iCBRecYear
		AND cbrec_number = :s_lCBRecNum;
	If SQLCA.SQLCode = -1 Then
		s_achErrText = SQLCA.SQLErrText
		ROLLBACK USING SQLCA;
		MessageBox("Error", "Update Failed - " + s_achErrText)
	Else
		COMMIT;		
	End If
	
	// Debit Ut_Ledger - "+"
	UPDATE ut_ledger_item
			SET ut_ledger_item.period_bal = ut_ledger_item.period_bal + :s_dTotAmtRcvd 
		WHERE ut_ledger_item.dock_year = :s_iCBRecYear
		AND ut_ledger_item.period = :s_iPeriodNum;								
	If SQLCA.SQLCODE = -1 Then
		MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
		ROLLBACK;
		Return
	Else
		COMMIT;
	End If						

Next

MessageBox("Post Deposit Receipt Information", "All Receipts Posted")

s_achSQL = dw_scan.GetSQLSelect()

dw_scan.SetTransObject(SQLCA)
dw_scan.SetRedraw(False)			
dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			

dw_scan.Retrieve() 			

long s_sRow
// find the row closest to this one
s_sRow = dw_scan.Find("cb_type = '" + s_achCBType + &
	"' AND cbrec_year = " + String(s_iCBRecYear) + &
	" AND cbrec_number = " + String(s_lCBRecNum), 0, dw_scan.RowCount())

If s_sRow = 0 Then s_sRow = 1

If s_sRow = 1 Then
	dw_scan.TriggerEvent(rowfocuschanged!)
End If

// highlight only the closest row
dw_scan.ScrollToRow(s_sRow)				
dw_scan.SelectRow(0,False)
dw_scan.SelectRow(s_sRow, True)										

dw_scan.SetRedraw(True)
dw_scan.enabled = True	

dw_scan.SetFocus()
	
end event

type st_7 from statictext within w_post_receipts_sheet
integer x = 3211
integer y = 1498
integer width = 497
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long backcolor = 12632256
boolean enabled = false
string text = "Unposted Amt"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_unposted_total from statictext within w_post_receipts_sheet
integer x = 3222
integer y = 1568
integer width = 472
integer height = 83
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 255
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

