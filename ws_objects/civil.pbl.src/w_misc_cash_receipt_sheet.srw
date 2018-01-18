$PBExportHeader$w_misc_cash_receipt_sheet.srw
forward
global type w_misc_cash_receipt_sheet from w_base_sheet
end type
type sle_lname from singlelineedit within w_misc_cash_receipt_sheet
end type
type sle_fname from singlelineedit within w_misc_cash_receipt_sheet
end type
type em_receipt from editmask within w_misc_cash_receipt_sheet
end type
type st_1 from statictext within w_misc_cash_receipt_sheet
end type
type st_2 from statictext within w_misc_cash_receipt_sheet
end type
type st_3 from statictext within w_misc_cash_receipt_sheet
end type
type st_6 from statictext within w_misc_cash_receipt_sheet
end type
type em_date from editmask within w_misc_cash_receipt_sheet
end type
type cb_fee from commandbutton within w_misc_cash_receipt_sheet
end type
type gb_8 from groupbox within w_misc_cash_receipt_sheet
end type
type cb_main from commandbutton within w_misc_cash_receipt_sheet
end type
type st_message from statictext within w_misc_cash_receipt_sheet
end type
type cb_disburse from commandbutton within w_misc_cash_receipt_sheet
end type
type cb_disbursement from commandbutton within w_misc_cash_receipt_sheet
end type
type dw_check from datawindow within w_misc_cash_receipt_sheet
end type
type cb_print_check from commandbutton within w_misc_cash_receipt_sheet
end type
end forward

global type w_misc_cash_receipt_sheet from w_base_sheet
integer x = 66
integer y = 16
integer width = 3690
integer height = 1965
string title = "Miscellaneous Cash Receipts"
windowstate windowstate = normal!
toolbaralignment toolbaralignment = alignatleft!
event ue_totals pbm_custom18
sle_lname sle_lname
sle_fname sle_fname
em_receipt em_receipt
st_1 st_1
st_2 st_2
st_3 st_3
st_6 st_6
em_date em_date
cb_fee cb_fee
gb_8 gb_8
cb_main cb_main
st_message st_message
cb_disburse cb_disburse
cb_disbursement cb_disbursement
dw_check dw_check
cb_print_check cb_print_check
end type
global w_misc_cash_receipt_sheet w_misc_cash_receipt_sheet

type variables
boolean i_bFirstSearch, i_bNew, i_bExit, i_bContinueItem
boolean i_bFees, i_bDisbursement, i_bUpdateFee
string i_achCBType, i_achMode, i_achFeeType
string i_achSaveSQL, i_achNewSQL
string i_achLName, i_achFName, i_achCaseNum
integer i_iCBRecYear, i_iDockYear, i_iCBDisYear
long i_lCBRecNum, i_lReceiptNum, i_lDockNum
long i_iFeeNum, i_lCBDisNum
date i_dtRcvdDate, i_dtRecDate
decimal {2} i_dFeeAmtRcvd, i_dTotRec
decimal {2} i_dOrigAmountRec
string i_achOrigFeeType
end variables

event ue_totals;string s_achCBType, s_achFeeType, s_achDoc
integer s_iCBRecYear, s_iCount, s_iFeeNum, s_iRow, s_iPeriodNum
long s_lCBRecNum, s_lTransNum, s_lReceiptNum
datetime s_dtDateTimeRcvd
date s_dtDateRcvd
decimal {2} s_dAmountDue, s_dAmountDisb

i_iRow = dw_detail.GetRow()

s_achCBType = dw_detail.GetItemString(i_iRow, "cb_type")
s_iCBRecYear = dw_detail.GetItemNumber(i_iRow, "docket_year")
s_lCBRecNum = dw_detail.GetItemNumber(i_iRow, "docket_number")		
s_iFeeNum = dw_detail.GetItemNumber(i_iRow, "fee_number")		

SELECT fee_amount, fee_type INTO :s_dAmountDue, :s_achFeeType
	FROM sh_docket_fee
	WHERE sh_docket_fee.cb_type = 'M'
	AND sh_docket_fee.docket_year = :s_iCBRecYear
	AND sh_docket_fee.docket_number = :s_lCBRecNum
	AND sh_docket_fee.fee_number = :s_iFeeNum;

SELECT date_received, receipt_number INTO :s_dtDateTimeRcvd, :s_lReceiptNum
	FROM sh_docket_receipt
	WHERE sh_docket_receipt.cb_type = 'M'
	AND sh_docket_receipt.cbrec_year = :s_iCBRecYear
	AND sh_docket_receipt.cbrec_number = :s_lCBRecNum;
s_dtDateRcvd = Date(s_dtDateTimeRcvd)

SELECT COUNT(*) INTO :s_iCount
	FROM sh_docket_fee_paid
	WHERE sh_docket_fee_paid.cb_type = 'M'
	AND sh_docket_fee_paid.docket_year = :s_iCBRecYear
	AND sh_docket_fee_paid.docket_number = :s_lCBRecNum
	AND sh_docket_fee_paid.fee_number = :s_iFeeNum;				
If s_iCount = 0 Then
	INSERT INTO sh_docket_fee_paid
			(cb_type, docket_number, docket_year, fee_number, cbrec_year, cbrec_number, 
			amount_received, date_received, new_balance_disbursed, 
			new_amount_disbursed, receipt_status )
		VALUES ('M', :s_lCBRecNum, :s_iCBRecYear, :s_iFeeNum, :s_iCBRecYear, :s_lCBRecNum, 
			:s_dAmountDue, :s_dtDateRcvd, :s_dAmountDue, 
			0, 'O');
	// error check
	If SQLCA.SQLCode = -1 Then
		MessageBox("System Error","Fee Paid Insert Error - " + SQLCA.SQLErrText)
		ROLLBACK;
	Else
		COMMIT;
	End If				
Else
	UPDATE sh_docket_fee_paid
		SET amount_received = :s_dAmountDue,
			 date_received = :s_dtDateRcvd,
			 new_balance_disbursed = :s_dAmountDue
		WHERE sh_docket_fee_paid.cb_type = 'M'
		AND sh_docket_fee_paid.docket_year = :s_iCBRecYear
		AND sh_docket_fee_paid.docket_number = :s_lCBRecNum
		AND sh_docket_fee_paid.fee_number = :s_iFeeNum;				
	// error check
	If SQLCA.SQLCode = -1 Then
		MessageBox("System Error","Fee Paid Update Error - " + SQLCA.SQLErrText)
		ROLLBACK;
	Else
		COMMIT;
	End If								
End If

SELECT SUM(fee_amount) INTO :s_dAmountDue
	FROM sh_docket_fee
	WHERE sh_docket_fee.cb_type = 'M'
	AND sh_docket_fee.docket_year = :s_iCBRecYear
	AND sh_docket_fee.docket_number = :s_lCBRecNum;
If IsNull(s_dAmountDue) Then s_dAmountDue = 0	
//messagebox("fee",string(s_damountdue))
If i_achOpType = "Add" Then

	UPDATE sh_docket_receipt
		SET total_received = :s_dAmountDue,
			 balance_disbursed = :s_dAmountDue
		WHERE sh_docket_receipt.cb_type = 'M'
		AND sh_docket_receipt.cbrec_year = :s_iCBRecYear
		AND sh_docket_receipt.cbrec_number = :s_lCBRecNum;
	// error check
	If SQLCA.SQLCode = -1 Then
		MessageBox("System Error","CB Rec Update Error - " + SQLCA.SQLErrText)
		ROLLBACK;
	Else
		COMMIT;
	End If								

	s_iPeriodNum = Month(s_dtDateRcvd)			
			
	// Process Receipt
	// Credit Fee Ledger - "+"
	UPDATE ut_ledger_item
			SET ut_ledger_item.period_bal = ut_ledger_item.period_bal + :s_dAmountDue
		WHERE ut_ledger_item.dock_year = :s_iCBRecYear
		AND ut_ledger_item.cb_type = 'M'
		AND ut_ledger_item.period = :s_iPeriodNum;								
	If SQLCA.SQLCODE = -1 Then
		MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
		ROLLBACK;
		Return
	Else
		COMMIT;
	End If				
/*
	s_lTransNum = 0
	SELECT MAX(trans_number) INTO :s_lTransNum
		FROM ut_audit_trail;
	If IsNull(s_lTransNum) Then s_lTransNum = 0									
	s_lTransNum ++

	s_achDoc = "Misc Receipt " + String(s_lReceiptNum)
	INSERT INTO ut_audit_trail
		(trans_number, docket_number, docket_year, cbrec_number, cbrec_year,
		 cbdis_number, cbdis_year, receipt_number, debit_credit,
		 cb_type, fee_type, post_date, amount, case_number,
		 documentation)
	 VALUES (:s_lTransNum, 0, 0, :s_lCBRecNum, :s_iCBRecYear,
		 0, 0, :s_lReceiptNum, 'CR',
		 'M', :s_achFeeType, :s_dtDateRcvd, :s_dAmountDue, '', 
		 :s_achDoc);
	If SQLCA.SQLCODE = -1 Then
		MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
		ROLLBACK;
		Return
	Else
		COMMIT;
	End If				
	*/
End If	

end event

on w_misc_cash_receipt_sheet.create
int iCurrent
call super::create
this.sle_lname=create sle_lname
this.sle_fname=create sle_fname
this.em_receipt=create em_receipt
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_6=create st_6
this.em_date=create em_date
this.cb_fee=create cb_fee
this.gb_8=create gb_8
this.cb_main=create cb_main
this.st_message=create st_message
this.cb_disburse=create cb_disburse
this.cb_disbursement=create cb_disbursement
this.dw_check=create dw_check
this.cb_print_check=create cb_print_check
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_lname
this.Control[iCurrent+2]=this.sle_fname
this.Control[iCurrent+3]=this.em_receipt
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_6
this.Control[iCurrent+8]=this.em_date
this.Control[iCurrent+9]=this.cb_fee
this.Control[iCurrent+10]=this.gb_8
this.Control[iCurrent+11]=this.cb_main
this.Control[iCurrent+12]=this.st_message
this.Control[iCurrent+13]=this.cb_disburse
this.Control[iCurrent+14]=this.cb_disbursement
this.Control[iCurrent+15]=this.dw_check
this.Control[iCurrent+16]=this.cb_print_check
end on

on w_misc_cash_receipt_sheet.destroy
call super::destroy
destroy(this.sle_lname)
destroy(this.sle_fname)
destroy(this.em_receipt)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_6)
destroy(this.em_date)
destroy(this.cb_fee)
destroy(this.gb_8)
destroy(this.cb_main)
destroy(this.st_message)
destroy(this.cb_disburse)
destroy(this.cb_disbursement)
destroy(this.dw_check)
destroy(this.cb_print_check)
end on

event ue_search;call super::ue_search;// script variables
integer s_iRcvdYear, s_iRcvdMonth, s_iRcvdDay, s_iNumRows, s_iDockYear, s_iDockNum
string s_achSQL, s_achRcvd, s_achRcvdYear, s_achRcvdMonth, s_achRcvdDay, s_achDWColor
date s_dtRcvdDate
long s_lReceiptNum

SetPointer(HourGlass!)

cb_add.enabled = False
m_main.m_general.m_add.enabled = False

// Security - Add Miscellaneous Cash Receipt Information
If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_new.enabled = True
	m_main.m_general.m_new.enabled = True
End If

// Security - Update Miscellaneous Cash Receipt Information
If w_main.dw_perms.Find("code=51", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_update.enabled = True
	m_main.m_general.m_update.enabled = True
End If

// Security - Delete Miscellaneous Cash Receipt Information
If w_main.dw_perms.Find("code=52", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_delete.enabled = True	
	m_main.m_general.m_delete.enabled = True
End If

s_achDWColor = dw_detail.Describe("datawindow.color")

dw_detail.SetRedraw(False)
dw_detail.Modify("cbrec_number.background.color = " + s_achDWColor + & 
	" cbrec_number.tabsequence = 0" + &
	" cbrec_year.background.color = " + s_achDWColor + & 
	" cbrec_year.tabsequence = 0" + &
   " receipt_number.background.color = " + s_achDWColor + & 
	" receipt_number.tabsequence = 0" + &			
	" date_received.background.color = " + s_achDWColor + & 
	" date_received.tabsequence = 0" + &						
	" last_name.background.color = " + s_achDWColor + & 
	" last_name.tabsequence = 0" + &						
	" first_name.background.color = " + s_achDWColor + & 
	" first_name.tabsequence = 0" + &						
	" middle_name.background.color = " + s_achDWColor + & 
	" middle_name.tabsequence = 0" + &									
	" suffix.background.color = " + s_achDWColor + & 
	" suffix.tabsequence = 0" + &									
	" note.background.color = " + s_achDWColor + & 
	" note.tabsequence = 0" + &			
	" total_received.background.color = " + s_achDWColor + & 
	" total_received.tabsequence = 0")
dw_detail.SetRedraw(True)

i_achLName = Trim(sle_lname.text)
i_achFName = Trim(sle_fname.text)

s_lReceiptNum = Long(em_receipt.text)
//i_iCBRecYear = Integer(Trim(em_ref_year.text))

SetNull(i_dtRcvdDate)

s_achRcvd = Trim(String(em_date.text))
//messagebox("date",s_achRcvd)
s_achRcvdYear = Mid(s_achRcvd,7,4)
s_achRcvdMonth = Mid(s_achRcvd,1,2)
s_achRcvdDay = Mid(s_achRcvd,4,2)
s_iRcvdYear = Integer(s_achRcvdYear)
s_iRcvdMonth = Integer(s_achRcvdMonth)
s_iRcvdDay = Integer(s_achRcvdDay)
s_dtRcvdDate = Date(s_iRcvdYear, s_iRcvdMonth, s_iRcvdDay)
If s_achRcvd <> "" Then
	i_dtRcvdDate = s_dtRcvdDate
End If	

If s_achRcvd <> "" And Not IsNull(s_achRcvd) And s_dtRcvdDate <> Date('1900-01-01') Then
   If Len(s_achSQL) = 0 Then
      s_achSQL = &
         " WHERE sh_docket_receipt.date_received = ~~~'" + String(i_dtRcvdDate, "yyyy-mm-dd") + "~~~'" 
   Else 
		s_achSQL += &
         " AND sh_docket_receipt.date_received = ~~~'" + String(i_dtRcvdDate, "yyyy-mm-dd") + "~~~'" 
   End If
End If

// didn't pick a last name

If i_achLName = "" Then
	// didn't pick a first name
   If sle_fname.text <> "" Then
	   // picked a first name
      s_achSQL = &
         " WHERE sh_docket_receipt.first_name LIKE ~~~'" + i_achFName + "%" + "~~~'" 
	End If
Else
	// picked a last name
	s_achSQL = &
         " WHERE sh_docket_receipt.last_name LIKE ~~~'" + i_achLName + "%" + "~~~'" 
	If sle_fname.text <> "" Then
		// picked a last and a first name
		s_achSQL += &
        " AND sh_docket_receipt.first_name LIKE ~~~'" + i_achFName + "%" + "~~~'" 
   End If
End If

If s_lReceiptNum <> 0 Then
   If Len(s_achSQL) = 0 Then
      s_achSQL = &
         " WHERE sh_docket_receipt.receipt_number = ~~~'" + String(s_lReceiptNum) + "~~~'" 
   Else 
		s_achSQL += &
         " AND sh_docket_receipt.receipt_number = ~~~'" + String(s_lReceiptNum) + "~~~'" 
   End If
End If

If Len(s_achSQL) = 0 Then
	s_achSQL = &	
   	" WHERE sh_docket_receipt.cb_type = ~~~'" + i_achCBType + "~~~'" 	
Else
	s_achSQL += &	
   	" AND sh_docket_receipt.cb_type = ~~~'" + i_achCBType + "~~~'" 	
End If 

s_achSQL += &
   " ORDER BY sh_docket_receipt.cbrec_year DESC, sh_docket_receipt.cbrec_number DESC" 

dw_scan.enabled = True

s_achSQL = i_achSQL + s_achSQL
i_achSaveSQL = s_achSQL

//i_achNewSQL = i_achSQL + s_achNewSQL
//messagebox("sql",s_achsql)
dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")

dw_scan.Reset()

If dw_scan.Retrieve() = 0 Then
	MessageBox("Complete", "No Miscellaneous Cash Receipt rows found.")

	sle_lname.text = ""
	sle_fname.text = ""
//	em_ref_year.text = ""
	em_receipt.text = ""
	sle_lname.SetFocus()
Else
	cb_main.enabled = False
	
	// Security - Maintain Miscellaneous Cash Receipt Fees
	If w_main.dw_perms.Find("code=49", 1, w_main.dw_perms.RowCount()) > 0 Then	
		cb_fee.enabled = True
	End If	
	
   dw_scan.SetFocus()
End If

end event

event open;//  Used with Misc Cash Receipt Section - Overrides Ancestor Script
SetPointer(HourGlass!)

//this.Width = dw_scan.width + dw_scan.x + 1100  
i_achSQL = dw_scan.GetSQLSelect()
dw_scan.SetTransObject(SQLCA)

//this.Height = dw_detail.Height + 1100
//this.Width = dw_detail.Width + 960

gnv_resize = create n_cst_resize
gnv_resize.of_SetOrigSize (this.Width, this.Height )
gnv_resize.of_Register(dw_scan, gnv_resize.SCALE)
gnv_resize.of_Register(dw_detail, gnv_resize.SCALE)
gnv_resize.of_Register(em_date, gnv_resize.SCALE)
gnv_resize.of_Register(em_receipt, gnv_resize.SCALE)
gnv_resize.of_Register(cb_add, gnv_resize.SCALE)
gnv_resize.of_Register(cb_back, gnv_resize.SCALE)
gnv_resize.of_Register(cb_clear, gnv_resize.SCALE)
gnv_resize.of_Register(cb_delete, gnv_resize.SCALE)
gnv_resize.of_Register(cb_detail, gnv_resize.SCALE)
gnv_resize.of_Register(cb_disburse, gnv_resize.SCALE)
gnv_resize.of_Register(cb_disbursement, gnv_resize.SCALE)
gnv_resize.of_Register(cb_escape, gnv_resize.SCALE)
gnv_resize.of_Register(cb_exit, gnv_resize.SCALE)
gnv_resize.of_Register(cb_fee, gnv_resize.SCALE)
gnv_resize.of_Register(cb_first, gnv_resize.SCALE)
gnv_resize.of_Register(cb_last, gnv_resize.SCALE)
gnv_resize.of_Register(cb_list, gnv_resize.SCALE)
gnv_resize.of_Register(cb_main, gnv_resize.SCALE)
gnv_resize.of_Register(cb_new, gnv_resize.SCALE)
gnv_resize.of_Register(cb_next, gnv_resize.SCALE)
gnv_resize.of_Register(cb_print_check, gnv_resize.SCALE)
gnv_resize.of_Register(cb_save, gnv_resize.SCALE)
gnv_resize.of_Register(cb_search, gnv_resize.SCALE)
gnv_resize.of_Register(cb_update, gnv_resize.SCALE)
gnv_resize.of_Register(gb_1, gnv_resize.SCALE)
gnv_resize.of_Register(gb_2, gnv_resize.SCALE)
gnv_resize.of_Register(gb_3, gnv_resize.SCALE)
gnv_resize.of_Register(gb_4, gnv_resize.SCALE)
gnv_resize.of_Register(gb_5, gnv_resize.SCALE)
gnv_resize.of_Register(gb_8, gnv_resize.SCALE)
gnv_resize.of_Register(sle_fname, gnv_resize.SCALE)
gnv_resize.of_Register(sle_lname, gnv_resize.SCALE)
gnv_resize.of_Register(st_message, gnv_resize.SCALE)
gnv_resize.of_Register(st_1, gnv_resize.SCALE)
gnv_resize.of_Register(st_2, gnv_resize.SCALE)
gnv_resize.of_Register(st_3, gnv_resize.SCALE)
gnv_resize.of_Register(st_6, gnv_resize.SCALE)

sle_lname.SetFocus()

i_achCBType = "M"
i_bFirstSearch = True

cb_print_check.pointer="arrow!"
end event

event ue_next;datawindowchild	dwc

Choose Case dw_detail.DataObject
	Case "dw_misc_cash_receipt_detail"
		
		cb_first.enabled = False							
		m_main.m_general.m_first.enabled = False		
		cb_back.enabled = False									
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False									
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False									
		m_main.m_general.m_last.enabled = False

		Return
		
	Case "dw_misc_cash_receipt_fee_detail"	
		Choose Case dw_detail.GetRow()
			Case 0 // not on a row. set it to the first row
				If dw_detail.RowCount() = 0 Then
					m_main.m_general.m_first.enabled = False					
					m_main.m_general.m_back.enabled = False
					m_main.m_general.m_next.enabled = False
					m_main.m_general.m_last.enabled = False

					Return
				
				Else
					m_main.m_general.m_first.enabled = True					
					m_main.m_general.m_back.enabled = True
					m_main.m_general.m_next.enabled = True
					m_main.m_general.m_last.enabled = True

					dw_detail.SetRow(1)
					dw_detail.SetColumn(1)
					dw_detail.ScrollToRow(1)
				End If
				
			Case dw_detail.RowCount() // last row
				m_main.m_general.m_first.enabled = True					
				m_main.m_general.m_back.enabled = True
				m_main.m_general.m_next.enabled = True
				m_main.m_general.m_last.enabled = True
				
				Beep(1)
				Return
				
			Case Else // not on the last row, so next goes to the next row
				m_main.m_general.m_first.enabled = True					
				m_main.m_general.m_back.enabled = True
				m_main.m_general.m_next.enabled = True
				m_main.m_general.m_last.enabled = True
				
				dw_detail.SetRow(dw_detail.GetRow() + 1)
				dw_detail.SetColumn(1)
				dw_detail.ScrollToRow(dw_detail.GetRow())
	
		End Choose
					
End Choose

end event

event ue_back;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_misc_cash_receipt_detail"
		
		cb_first.enabled = False							
		m_main.m_general.m_first.enabled = False		
		cb_back.enabled = False									
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False									
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False									
		m_main.m_general.m_last.enabled = False

		Return

	Case "dw_misc_cash_receipt_fee_detail"
		Choose Case dw_detail.GetRow()
			Case 0, 1 // not on a row. set it to the first row
				If dw_detail.RowCount() = 0 Then
					Beep(1)
					Return
						
				Else

					dw_detail.SetRow(1)
					dw_detail.SetColumn(1)
					dw_detail.ScrollToRow(1)
				End If			
		
			Case Else // not on the last row, so next goes to the previous row
				dw_detail.SetRow(dw_detail.GetRow() - 1)
				dw_detail.SetColumn(1)
				dw_detail.ScrollToRow(dw_detail.GetRow())

		End Choose

End Choose
end event

event ue_add;string s_achDWColor, s_achNotes, s_achLName, s_achFName, s_achMName, s_achCBType
string s_achFeeType
integer s_iCBRecYear, s_iRow, s_iCBDisYear 
long s_lCBRecNum, s_lCBDisNum
decimal {2} s_dFeeAmount
datawindowchild dwc

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
If i_bNew = True Then
	i_achMode = "Continue"
Else 
	i_achMode = ""
End If	

Choose Case dw_detail.DataObject

	Case "dw_misc_cash_receipt_fee_detail"

		// get Fee Type
		dw_detail.GetChild("fee_type", dwc)
		dwc.SetTransObject(SQLCA)
		dwc.Reset()
		dwc.Retrieve("FEE")

		i_achMode = "Continue"
		
		cb_main.enabled = True
		cb_fee.enabled = False
		
		cb_save.enabled = True
		m_main.m_general.m_save.enabled = True

		cb_first.enabled = False
		m_main.m_general.m_first.enabled = False
		cb_back.enabled = False		
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False		

		m_main.m_general.m_last.enabled = False
		
		s_iRow = dw_scan.GetRow()

		s_achCBType = dw_scan.GetItemString(s_iRow, "cb_type")
		s_lCBRecNum = dw_scan.GetItemNumber(s_iRow, "cbrec_number")
		s_iCBRecYear = dw_scan.GetItemNumber(s_iRow, "cbrec_year")

		s_iRow = dw_detail.InsertRow(0)
		
		dw_detail.SetItem(s_iRow,"cb_type", "M")			
		dw_detail.SetItem(s_iRow,"docket_number", s_lCBRecNum)			
		dw_detail.SetItem(s_iRow,"docket_year", s_iCBRecYear)					
		dw_detail.SetItem(s_iRow,"fee_number", 0)							
		dw_detail.SetItem(s_iRow,"balance_due", 0)											
		dw_detail.SetItem(s_iRow,"fee_type", "")	
		dw_detail.SetItem(s_iRow,"fee_amount", 0)													
		dw_detail.SetItem(s_iRow,"fee_note", "")													

		dw_detail.SetRedraw(False)
		dw_detail.Modify("fee_type.background.color = " + s_achDWColor + & 
			" fee_type.tabsequence = 1" + &
			" fee_amount.background.color = " + s_achDWColor + & 
			" fee_amount.tabsequence = 2" + &
			" fee_note.background.color = " + s_achDWColor + & 
			" fee_note.tabsequence = 3")
		dw_detail.SetRedraw(True)
		dw_detail.SetColumn("fee_type")												
		dw_detail.ScrollToRow(s_iRow)								
		
	Case "dw_docket_disburse_other_detail"

		i_achMode = "Continue"		
		
		cb_save.enabled = True
		m_main.m_general.m_save.enabled = True

		cb_first.enabled = False
		m_main.m_general.m_first.enabled = False
		cb_back.enabled = False		
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False		
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False		
		m_main.m_general.m_last.enabled = False

		s_iRow = dw_scan.GetRow()

		s_iCBRecYear = dw_scan.GetItemNumber(s_iRow, "cbrec_year")
		s_lCBRecNum = dw_scan.GetItemNumber(s_iRow, "cbrec_number")		

		s_iRow = dw_detail.InsertRow(0)

		SELECT fee_type, fee_amount INTO :s_achFeeType, :s_dFeeAmount
			FROM sh_docket_fee
			WHERE cb_type = 'M'
			AND docket_year = :s_iCBRecYear
			AND docket_number = :s_lCBRecNum
			AND fee_number = :i_iFeeNum;

		s_iCBDisYear = Year(g_dtToday)
		dw_detail.SetItem(s_iRow,"cb_type", "M")															
		dw_detail.SetItem(s_iRow,"disburse_type", "O")																	
		dw_detail.SetItem(s_iRow,"disburse_status", "O")																			
		dw_detail.SetItem(s_iRow,"docket_year", s_iCBRecYear)															
		dw_detail.SetItem(s_iRow,"docket_number", s_lCBRecNum)																	
		dw_detail.SetItem(s_iRow,"cbdis_year", s_iCBDisYear)															
		dw_detail.SetItem(s_iRow,"cbdis_number", 0)																	
		dw_detail.SetItem(s_iRow,"case_number", "")																	

//messagebox("new O disb",s_lCBDisNum)		
   	dw_detail.SetItem(s_iRow,"date_paid", i_dtRecDate)		
		dw_detail.SetItem(s_iRow,"last_name", "")																		
		dw_detail.SetItem(s_iRow,"first_name", "")																				
		dw_detail.SetItem(s_iRow,"middle_name", "")																				
		dw_detail.SetItem(s_iRow,"suffix", "")																				
		dw_detail.SetItem(s_iRow,"check_number", 0)		
		dw_detail.SetItem(s_iRow,"fee_type", s_achFeeType)																					
		dw_detail.SetItem(s_iRow,"amount_paid", s_dFeeAmount)																			
//		dw_detail.SetItem(s_iRow,"disbursement_note", "")																			
		dw_detail.SetItem(s_iRow,"balance_disbursed", s_dFeeAmount)							
										
		dw_detail.SetRedraw(False)
		dw_detail.Modify("last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 3" + &						
			" first_name.background.color = " + s_achDWColor + & 
			" first_name.tabsequence = 4" + &						
			" middle_name.background.color = " + s_achDWColor + & 
			" middle_name.tabsequence = 5" + &									
			" suffix.background.color = " + s_achDWColor + & 
			" suffix.tabsequence = 6")
		dw_detail.SetRedraw(True)		
		dw_detail.ScrollToRow(s_iRow)						

End Choose	
		
dw_detail.SetFocus()

end event

event ue_clear;call super::ue_clear;
sle_lname.text = ""
sle_fname.text = ""
//em_ref_year.text = ""
em_receipt.text = ""

i_bFirstSearch = True
i_achOpType = ""
i_achCBType = "M"
i_iCBRecYear = 0
i_lCBRecNum = 0
i_achLName = ""
i_achFName = ""

cb_fee.enabled = False

cb_first.enabled = False							
m_main.m_general.m_first.enabled = False		
cb_back.enabled = False									
m_main.m_general.m_back.enabled = False
cb_next.enabled = False									
m_main.m_general.m_next.enabled = False
cb_last.enabled = False									
m_main.m_general.m_last.enabled = False

sle_lname.SetFocus()

dw_scan.enabled = True

dw_detail.Reset()
dw_detail.Tag = ""
dw_detail.DataObject = "dw_misc_cash_receipt_detail"
dw_detail.SetTransObject(SQLCA)


end event

event ue_update;call super::ue_update;string s_achDWColor
integer s_iRow

i_achOpType ="Update"

s_achDWColor = dw_scan.Describe("datawindow.color")

s_iRow = dw_detail.GetRow()
			
Choose Case dw_detail.DataObject
	Case "dw_misc_cash_receipt_detail"

		dw_detail.SetRedraw(False)
		dw_detail.Modify("receipt_number.background.color = " + s_achDWColor + & 
			" receipt_number.tabsequence = 2" + &			
			" last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 4" + &						
			" first_name.background.color = " + s_achDWColor + & 
			" first_name.tabsequence = 5" + &						
			" middle_name.background.color = " + s_achDWColor + & 
			" middle_name.tabsequence = 6" + &									
			" suffix.background.color = " + s_achDWColor + & 
			" suffix.tabsequence = 7" + &									
			" note.background.color = " + s_achDWColor + & 
			" note.tabsequence = 8")
		dw_detail.SetColumn("receipt_number")			
			
	Case "dw_misc_cash_receipt_fee_detail"	
		
		i_dOrigAmountRec = dw_detail.GetItemNumber(s_iRow, "fee_amount", Primary!, True)		
		dw_detail.SetRedraw(False)
		dw_detail.Modify("fee_type.background.color = " + s_achDWColor + & 
			" fee_type.tabsequence = 1" + &
			" fee_amount.background.color = " + s_achDWColor + & 
			" fee_amount.tabsequence = 2" + &
			" fee_note.background.color = " + s_achDWColor + & 
			" fee_note.tabsequence = 3")		
		dw_detail.SetColumn("fee_type")						

	Case "dw_docket_disburse_other_detail"
										
		dw_detail.SetRedraw(False)
		dw_detail.Modify("last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 3" + &						
			" first_name.background.color = " + s_achDWColor + & 
			" first_name.tabsequence = 4" + &						
			" middle_name.background.color = " + s_achDWColor + & 
			" middle_name.tabsequence = 5" + &									
			" suffix.background.color = " + s_achDWColor + & 
			" suffix.tabsequence = 6")
		dw_detail.SetColumn("last_name")									

End Choose

dw_detail.SetRedraw(True)
dw_detail.SetRow(s_iRow)		
dw_detail.SetFocus()


end event

event ue_val_fields;integer s_iRowCount, s_iCount, s_iRow, s_iCBDisYear
long s_lCBDisNum
string s_achFeeType, s_achOrigFeeType, s_achDisbursedType, s_achOrigDisbursedType
decimal {2} s_dFeeAmount, s_dOrigFeeAmount

dw_detail.SetTransObject(SQLCA)
dw_detail.AcceptText()
Choose Case dw_detail.DataObject
	
	Case "dw_misc_cash_receipt_detail"
		
		If (IsNull(dw_detail.GetItemString(1, "last_name")) Or (dw_detail.GetItemString(1, "last_name") = "")) Then
			i_ivalflag = 1 
			MessageBox("Error", "Last Name/Business must be entered!")
			dw_detail.SetColumn("last_name")
			dw_detail.SetFocus()
			Return
		End If	

		If IsNull(dw_detail.GetItemNumber(1,"receipt_number")) Or (dw_detail.GetItemNumber(1,"receipt_number") = 0) Then
			i_ivalflag = 1 
			MessageBox("Error", "Receipt number MUST be entered!")
			dw_detail.SetColumn("receipt_number")
			dw_detail.SetFocus()
			Return
		End If	

		If IsNull(dw_detail.GetItemDateTime(1, "date_received")) Or (String(dw_detail.GetItemDateTime(1, "date_received")) = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Date received must be entered!")
			dw_detail.SetColumn("date_received")
			dw_detail.SetFocus()
			Return
		End If	

		If Date(dw_detail.GetItemDateTime(1,"date_received")) > Today() Then
			i_ivalflag = 1 
			MessageBox("Error", "Date received MUST be today or before!")
			dw_detail.SetColumn("date_received")
			dw_detail.SetFocus()
			Return
		End If	
		
	Case "dw_misc_cash_receipt_fee_detail"	
		s_iRowCount = dw_detail.RowCount()
		For s_iCount = 1 to s_iRowCount
			Choose Case dw_detail.GetItemStatus(s_iCount,0, Primary!)
				Case NotModified!, New!
					Continue
			End Choose
			
			If IsNull(dw_detail.GetItemString(s_iCount, "fee_type")) Or (dw_detail.GetItemString(s_iCount, "fee_type") = "") Then
				i_ivalflag = 1 
				MessageBox("Error", "Fee type must be entered!")
				dw_detail.SetColumn("fee_type")
				dw_detail.SetRow(s_iCount)
				dw_detail.SetFocus()
				Return
			End If	

		Next
		
End Choose		

string s_achCBType
integer s_iFeeNum, s_iCBRecYear
long s_lCBRecNum

Choose Case dw_detail.DataObject
	Case "dw_misc_cash_receipt_detail"
		i_iRow = dw_detail.GetRow()

		s_iCBRecYear = Year(Today())
/*		
		If s_achSSAN <> "" Then
			s_achFromWhom = dw_detail.GetItemString(i_iRow, "master_names_last_name") + ", " + &
				dw_detail.GetItemString(i_iRow, "master_names_first_name")
		Else		
			s_achFromWhom = dw_detail.GetItemString(i_iRow, "business_card_bus_name")
		End If
		dw_detail.SetItem(i_iRow, "from_whom", s_achFromWhom)
*/
		If i_achOpType = "Add" Then
			SELECT max_number INTO :s_lCBRecNum
				FROM ut_incremented_number
				WHERE ut_incremented_number.number_type = 'CBREC-MAX'
				AND ut_incremented_number.civil_year = :s_iCBRecYear;
				
			If IsNull(s_lCBRecNum) Then s_lCBRecNum = 0			
			s_lCBRecNum ++
			dw_detail.SetItem(i_iRow, "cbrec_number", s_lCBRecNum)
			dw_detail.SetItem(i_iRow, "cbrec_year", s_iCBRecYear)						
			
			UPDATE ut_incremented_number
				SET max_number = :s_lCBRecNum
				WHERE ut_incremented_number.number_type = 'CBREC-MAX'
				AND ut_incremented_number.civil_year = :s_iCBRecYear;
		End If

	Case "dw_misc_cash_receipt_fee_detail"
		
		i_bUpdateFee = False
		i_iRow = dw_detail.GetRow()

		s_achCBType = dw_detail.GetItemString(i_iRow, "cb_type")
		s_iCBRecYear = dw_detail.GetItemNumber(i_iRow, "docket_year")
		s_lCBRecNum = dw_detail.GetItemNumber(i_iRow, "docket_number")		
		s_achFeeType = Trim(dw_detail.GetItemString(i_iRow, "fee_type"))
		s_achOrigFeeType = Trim(dw_detail.GetItemString(i_iRow, "fee_type", Primary!, True))
		s_dFeeAmount = dw_detail.GetItemNumber(i_iRow, "fee_amount")				
		s_dOrigFeeAmount = dw_detail.GetItemNumber(i_iRow, "fee_amount", Primary!, True)		

		If i_achOpType = "Add" Then
			
			SELECT MAX(fee_number) INTO :s_iFeeNum
				FROM sh_docket_fee
				WHERE sh_docket_fee.cb_type = 'M'
				AND sh_docket_fee.docket_year = :s_iCBRecYear
				AND sh_docket_fee.docket_number = :s_lCBRecNum;
	
			If IsNull(s_iFeeNum) Then s_iFeeNum = 0						
			s_iFeeNum ++
			dw_detail.SetItem(i_iRow, "fee_number", s_iFeeNum)
		End If
		
		If i_achOpType = "Update" And s_achFeeType <> s_achOrigFeeType Then
			i_bUpdateFee = True
//			messagebox("update",string(i_bupdatefee))

			SELECT disbursed_type 
				INTO :s_achDisbursedType
				FROM ut_codes
				WHERE ut_codes.code_type ='FEE'
				AND ut_codes.code = :s_achFeeType;
//messagebox("s_achDisbursedType", s_achDisbursedType)

			SELECT disbursed_type 
				INTO :s_achOrigDisbursedType
				FROM ut_codes
				WHERE ut_codes.code_type ='FEE'
				AND ut_codes.code = :s_achOrigFeeType;
//messagebox("s_achOrigDisbursedType", s_achOrigDisbursedType)

			UPDATE sh_docket_disbursement						
				SET balance_disbursed = balance_disbursed - :s_dFeeAmount,							
					 amount_paid = amount_paid - :s_dFeeAmount
				FROM sh_docket_disbursement
				WHERE sh_docket_disbursement.disburse_type = :s_achOrigDisbursedType
				AND sh_docket_disbursement.disburse_status = 'O'
				AND sh_docket_disbursement.cb_type = 'M';
			If SQLCA.SQLCODE = -1 Then
				MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
				ROLLBACK;
				Return
			Else
				COMMIT;
			End If				

		
			UPDATE sh_docket_disbursement						
				SET balance_disbursed = balance_disbursed + :s_dFeeAmount,							
					 amount_paid = amount_paid + :s_dFeeAmount
				FROM sh_docket_disbursement
				WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
				AND sh_docket_disbursement.disburse_status = 'O'
				AND sh_docket_disbursement.cb_type = 'M';																			
			If SQLCA.SQLCODE = -1 Then
				MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
				ROLLBACK;
				Return
			Else
				COMMIT;
			End If				

		End If
			
			
	Case "dw_docket_disburse_other_detail"

		s_iRow = dw_detail.GetRow()

		If i_achOpType = "Add" Then		

			i_iCBDisYear = Year(g_dtToday)
			SELECT MAX(cbdis_number) INTO :i_lCBDisNum
				FROM sh_docket_disbursement
				WHERE sh_docket_disbursement.cbdis_year = :i_iCBDisYear;
			If IsNull(i_lCBDisNum) Then i_lCBDisNum = 0
			i_lCBDisNum ++

			dw_detail.SetItem(s_iRow, "cbdis_number", i_lCBDisNum)

		End If			
		
		UPDATE sh_docket_fee_paid
			SET new_balance_disbursed = :i_dFeeAmtRcvd,
				 cbdis_year = :i_iCBDisYear,
				 cbdis_number = :i_lCBDisNum
			WHERE sh_docket_fee_paid.cb_type = 'M'
			AND sh_docket_fee_paid.fee_type = :i_achFeeType			
			AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
			AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum;					
		If SQLCA.SQLCODE = -1 Then
			MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
			ROLLBACK;
			Return
		Else
			COMMIT;
		End If							

End Choose	

end event

event ue_save;call super::ue_save;string s_achDWColor, s_achCBType, s_achUserType, s_achFromWhom, s_achWhomDue
string s_achDoc, s_achDisbursedType
integer s_iRow, s_iPeriodNum, s_iDCount, s_iCount
long s_lTransNum, s_lCheckNum, s_lReceiptNum
decimal {2} s_dBalanceDue, s_dFeeAmount, s_dTotAmt, s_dAmtRec, s_dTotRec, s_dOrigAmountRec
datetime s_dtDateTimePaid, s_dtRecDateTime
date s_dtDatePaid
datawindowchild dwc

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_misc_cash_receipt_detail"
		
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
			dw_detail.Modify("receipt_number.background.color = " + s_achDWColor + & 
				" receipt_number.tabsequence = 0" + &			
				" date_received.background.color = " + s_achDWColor + & 
				" date_received.tabsequence = 0" + &						
				" last_name.background.color = " + s_achDWColor + & 
				" last_name.tabsequence = 0" + &						
				" first_name.background.color = " + s_achDWColor + & 
				" first_name.tabsequence = 0" + &						
				" middle_name.background.color = " + s_achDWColor + & 
				" middle_name.tabsequence = 0" + &									
				" suffix.background.color = " + s_achDWColor + & 
				" suffix.tabsequence = 0" + &									
				" note.background.color = " + s_achDWColor + & 
				" note.tabsequence = 0" + &			
				" total_received.background.color = " + s_achDWColor + & 
				" total_received.tabsequence = 0")					
			dw_detail.SetRedraw(True)			

			// Security - Maintain Miscellaneous Cash Receipt Fees
			If w_main.dw_perms.Find("code=49", 1, w_main.dw_perms.RowCount()) > 0 Then	
				cb_fee.enabled = True
			End If	
			
			// Security - Add Miscellaneous Cash Receipt Information
			If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
				m_main.m_general.m_new.enabled = True
				cb_new.enabled = True
			End If
			
			// Security - Update Miscellaneous Cash Receipt Information
			If w_main.dw_perms.Find("code=51", 1, w_main.dw_perms.RowCount()) > 0 Then
				m_main.m_general.m_update.enabled = True
				cb_update.enabled = True
			End If
			
			// Security - Delete Miscellaneous Cash Receipt Information
			If w_main.dw_perms.Find("code=52", 1, w_main.dw_perms.RowCount()) > 0 Then
				m_main.m_general.m_delete.enabled = True
				cb_delete.enabled = True
			End If
			
			m_main.m_general.m_save.enabled = False
			cb_save.enabled = False
		
			cb_main.enabled = False
			cb_fee.enabled = True

			s_iRow = dw_detail.GetRow()

			s_achCBType = dw_detail.GetItemString(s_iRow,"cb_type")
			i_iCBRecYear = dw_detail.GetItemNumber(s_iRow,"cbrec_year")
			i_lCBRecNum = dw_detail.GetItemNumber(s_iRow,"cbrec_number")				
			i_dtRecDate = Date(dw_detail.GetItemDateTime(s_iRow,"date_received"))							
			i_iDockYear = i_iCBRecYear
			i_lDockNum = i_lCBRecNum
						
			dw_scan.SetTransObject(SQLCA)
			dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
			dw_scan.Retrieve() 			

			// find the row closest to this one
			s_iRow = dw_scan.Find("cb_type = '" + s_achCBType + &
				"' AND cbrec_year = " + String(i_iCBRecYear) + &
				" AND cbrec_number = " + String(i_lCBRecNum), 0, dw_scan.RowCount())

			If s_iRow = 0 Then s_iRow = 1

			// highlight only the closest row
			dw_scan.ScrollToRow(s_iRow)				
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(s_iRow, True)										
	
			dw_scan.SetRedraw(True)
			dw_scan.enabled = True			

			If i_achMode = "Continue" And i_bNew = True Then
				If i_achOpType = "Add" Then
					cb_fee.PostEvent("clicked")					
				End If	
			End If				
			
		End If			

	Case "dw_misc_cash_receipt_fee_detail"

		cb_first.enabled = True
		m_main.m_general.m_first.enabled = True
		cb_back.enabled = True
		m_main.m_general.m_back.enabled = True
		cb_next.enabled = True
		m_main.m_general.m_next.enabled = True
		cb_last.enabled = True
		m_main.m_general.m_last.enabled = True

		If i_iValFlag = 0 Then
			dw_detail.SetRedraw(False)
			dw_detail.Modify("fee_type.background.color = " + s_achDWColor + & 
				" fee_type.tabsequence = 0" + &
				" fee_amount.background.color = " + s_achDWColor + & 
				" fee_amount.tabsequence = 0" + &
				" fee_note.background.color = " + s_achDWColor + & 
				" fee_note.tabsequence = 0")
			dw_detail.SetRedraw(True)
			dw_scan.enabled = True
			
			// Security - Add Miscellaneous Cash Receipts
			If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
				m_main.m_general.m_new.enabled = True
				cb_new.enabled = True				
			End If
			
			// Security - Add Miscellaneous Cash Receipt Fees
			If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
				m_main.m_general.m_add.enabled = True
				cb_add.enabled = True				
			End If
			
			// Security - Update Miscellaneous Cash Receipt Fees
			If w_main.dw_perms.Find("code=51", 1, w_main.dw_perms.RowCount()) > 0 Then
				m_main.m_general.m_update.enabled = True
				cb_update.enabled = True				
			End If
			
			// Security - Delete Miscellaneous Cash Receipt Fees
			If w_main.dw_perms.Find("code=52", 1, w_main.dw_perms.RowCount()) > 0 Then
				m_main.m_general.m_delete.enabled = True
				cb_delete.enabled = True				
			End If
			
			m_main.m_general.m_save.enabled = False
			cb_save.enabled = False			

			cb_main.enabled = True
			cb_fee.enabled = False						

			s_iRow = dw_detail.GetRow()

			i_lCBRecNum = dw_detail.GetItemNumber(s_iRow, "docket_number")
			i_iCBRecYear = dw_detail.GetItemNumber(s_iRow, "docket_year")			
			i_iFeeNum = dw_detail.GetItemNumber(s_iRow, "fee_number")						
			i_achFeeType = Trim(dw_detail.GetItemString(s_iRow, "fee_type"))
			i_achOrigFeeType = Trim(dw_detail.GetItemString(s_iRow, "fee_type", Primary!, True))
			i_dFeeAmtRcvd = dw_detail.GetItemNumber(s_iRow, "fee_amount")						

			s_dOrigAmountRec = dw_detail.GetItemNumber(s_iRow, "fee_amount", Primary!, True)
		
			SELECT date_received, receipt_number INTO :s_dtDateTimePaid, :s_lReceiptNum
				FROM sh_docket_receipt
				WHERE sh_docket_receipt.cb_type = 'M'
				AND sh_docket_receipt.cbrec_year = :i_iCBRecYear
				AND sh_docket_receipt.cbrec_number = :i_lCBRecNum;
			s_dtDatePaid = Date(s_dtDateTimePaid)

			SELECT date_received, receipt_number INTO :s_dtRecDateTime, :s_lReceiptNum
				FROM sh_docket_receipt
				WHERE sh_docket_receipt.cb_type = 'M'
				AND sh_docket_receipt.cbrec_year = :i_iCBRecYear
				AND sh_docket_receipt.cbrec_number = :i_lCBRecNum;
			i_dtRecDate = Date(s_dtRecDateTime)
			
			SELECT COUNT(*) INTO :s_iCount
				FROM sh_docket_fee_paid
				WHERE sh_docket_fee_paid.cb_type = 'M'
				AND sh_docket_fee_paid.docket_year = :i_iCBRecYear
				AND sh_docket_fee_paid.docket_number = :i_lCBRecNum
				AND sh_docket_fee_paid.fee_number = :i_iFeeNum;				
			If s_iCount = 0 Then
				INSERT INTO sh_docket_fee_paid
						(cb_type, docket_number, docket_year, fee_number, cbrec_year, 
						cbrec_number, amount_received, date_received, new_balance_disbursed, 
						new_amount_disbursed, fee_type, check_number, receipt_status )
					VALUES ('M', :i_lCBRecNum, :i_iCBRecYear, :i_iFeeNum, :i_iCBRecYear, 
					   :i_lCBRecNum, :i_dFeeAmtRcvd, :i_dtRecDate, 
						:i_dFeeAmtRcvd, 0, :i_achFeeType, 0, 'O');
				// error check
				If SQLCA.SQLCode = -1 Then
					MessageBox("System Error","Fee Paid Insert Error - " + SQLCA.SQLErrText)
					ROLLBACK;
				Else
					COMMIT;
				End If				
			Else
				i_bUpdateFee = True									
				
//messagebox("update in save",	i_bUpdateFee)		
					
				UPDATE sh_docket_fee_paid
					SET amount_received = :i_dFeeAmtRcvd,
						 date_received = :i_dtRecDate,
						 new_balance_disbursed = :i_dFeeAmtRcvd,
						 fee_type = :i_achFeeType
					WHERE sh_docket_fee_paid.cb_type = 'M'
					AND sh_docket_fee_paid.docket_year = :i_iCBRecYear
					AND sh_docket_fee_paid.docket_number = :i_lCBRecNum
					AND sh_docket_fee_paid.fee_number = :i_iFeeNum;				
				// error check
				If SQLCA.SQLCode = -1 Then
					MessageBox("System Error","Fee Paid Update Error - " + SQLCA.SQLErrText)
					ROLLBACK;
				Else
					COMMIT;
				End If								
			End If

			// Process Disbursement			
			SELECT disbursed_type INTO :s_achDisbursedType
				FROM ut_codes
				WHERE ut_codes.code_type = 'FEE'
				AND ut_codes.code = :i_achFeeType;
			If IsNull(s_achDisbursedType) Then s_achDisbursedType = ""
//messagebox("type",s_achDisbursedType)
			Choose Case s_achDisbursedType
					
				Case 'O'
						
					SELECT COUNT(*) INTO :s_iDCount
						FROM sh_docket_disbursement
						WHERE sh_docket_disbursement.disburse_type = 'O'
						AND sh_docket_disbursement.disburse_status = 'O'
						AND sh_docket_disbursement.docket_year = :i_iCBRecYear
						AND sh_docket_disbursement.docket_number = :i_lCBRecNum
						AND sh_docket_disbursement.fee_type = :i_achFeeType										
						AND sh_docket_disbursement.cb_type = 'M';												
					If IsNull(s_iDCount) Then s_iDCount = 0						
					If s_iDCount = 0 Then
//			messagebox("disb oth",s_iDCount)	
						cb_disbursement.PostEvent("clicked")							
						Return
					End If

				Case 'S'
					
					s_achWhomDue = "Iowa Dept of Public Safety"
					
					SELECT COUNT(*) INTO :s_iCount
						FROM sh_docket_disbursement
						WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
						AND sh_docket_disbursement.disburse_status = 'O'
						AND sh_docket_disbursement.cb_type = 'M';																		
					If s_iCount = 0 Then
						
						i_iCBDisYear = Year(g_dtToday)
						SELECT MAX(cbdis_number) INTO :i_lCBDisNum
							FROM sh_docket_disbursement
							WHERE sh_docket_disbursement.cbdis_year = :i_iCBDisYear
							AND sh_docket_disbursement.cb_type = 'M';																			
						If IsNull(i_lCBDisNum) Then i_lCBDisNum = 0
						i_lCBDisNum ++
						
						INSERT INTO sh_docket_disbursement
							(cb_type, docket_number, docket_year, cbdis_number, cbdis_year,
							 date_paid, amount_paid, check_number, last_name,
							 first_name, middle_name, suffix, whom_due, balance_disbursed,
							 case_number, disburse_status, disburse_date, disburse_type, fee_type)
						 VALUES ('M', :i_lCBRecNum, :i_iCBRecYear, :i_lCBDisNum, :i_iCBDisYear,
							 NULL, :i_dFeeAmtRcvd, 0, :s_achWhomDue,
							 '', '', '', '', :i_dFeeAmtRcvd, 
							 '', 'O', NULL, :s_achDisbursedType, :i_achFeeType);
						If SQLCA.SQLCODE = -1 Then
							MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
							ROLLBACK;
							Return
						Else
							COMMIT;
						End If				
							 									
					Else

						If i_bUpdateFee Then			
//messagebox("orig",s_dOrigAmountRec)
//messagebox("fee",i_dFeeAmtRcvd)
							UPDATE sh_docket_disbursement						
								SET balance_disbursed = balance_disbursed - (:i_dOrigAmountRec - :i_dFeeAmtRcvd),							
									 amount_paid = amount_paid - (:i_dOrigAmountRec - :i_dFeeAmtRcvd)
								FROM sh_docket_disbursement
								WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
								AND sh_docket_disbursement.disburse_status = 'O'
								AND sh_docket_disbursement.cb_type = 'M';
							If SQLCA.SQLCODE = -1 Then
								MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
								ROLLBACK;
								Return
							Else
								COMMIT;
							End If				
						Else
						
							UPDATE sh_docket_disbursement						
								SET balance_disbursed = balance_disbursed + :i_dFeeAmtRcvd,							
									 amount_paid = amount_paid + :i_dFeeAmtRcvd														
								FROM sh_docket_disbursement
								WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
								AND sh_docket_disbursement.disburse_status = 'O'
								AND sh_docket_disbursement.cb_type = 'M';																			
							If SQLCA.SQLCODE = -1 Then
								MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
								ROLLBACK;
								Return
							Else
								COMMIT;
							End If				
						End If

						SELECT cbdis_year, cbdis_number 
							INTO :i_iCBDisYear, :i_lCBDisNum
							FROM sh_docket_disbursement
							WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
							AND sh_docket_disbursement.disburse_status = 'O'
							AND sh_docket_disbursement.cb_type = 'M';		
						If IsNull(i_iCBDisYear) Then i_iCBDisYear = 0							
						If IsNull(i_lCBDisNum) Then i_lCBDisNum = 0							

					End If

					UPDATE sh_docket_fee_paid
						SET cbdis_year = :i_iCBDisYear,
 							 cbdis_number = :i_lCBDisNum
						WHERE sh_docket_fee_paid.cb_type = 'M'
						AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
						AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum
						AND sh_docket_fee_paid.fee_number = :i_iFeeNum;	
					If SQLCA.SQLCODE = -1 Then
						MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
						ROLLBACK;
						Return
					Else
						COMMIT;
					End If							
	
				Case 'D'

					s_achWhomDue = "Iowa Dept of Transportation"					
					SELECT COUNT(*) INTO :s_iCount
						FROM sh_docket_disbursement
						WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
						AND sh_docket_disbursement.disburse_status = 'O'
						AND sh_docket_disbursement.cb_type = 'M';																		
					If s_iCount = 0 Then
						
						i_iCBDisYear = Year(g_dtToday)
						SELECT MAX(cbdis_number) INTO :i_lCBDisNum
							FROM sh_docket_disbursement
							WHERE sh_docket_disbursement.cbdis_year = :i_iCBDisYear
							AND sh_docket_disbursement.cb_type = 'M';																			
						If IsNull(i_lCBDisNum) Then i_lCBDisNum = 0
						i_lCBDisNum ++
//messagebox("new T disb",i_lCBDisNum)		
						INSERT INTO sh_docket_disbursement
							(cb_type, docket_number, docket_year, cbdis_number, cbdis_year,
							 date_paid, amount_paid, check_number, last_name,
							 first_name, middle_name, suffix, whom_due, balance_disbursed,
							 case_number, disburse_status, disburse_date, disburse_type, fee_type)
						 VALUES ('M', :i_lCBRecNum, :i_iCBRecYear, :i_lCBDisNum, :i_iCBDisYear,
							 NULL, :i_dFeeAmtRcvd, 0, :s_achWhomDue,
							 '', '', '', '', :i_dFeeAmtRcvd, 
							 '', 'O', NULL, :s_achDisbursedType, :i_achFeeType);
						If SQLCA.SQLCODE = -1 Then
							MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
							ROLLBACK;
							Return
						Else
							COMMIT;
						End If				
							 									
					Else
						
						If i_bUpdateFee Then			

							UPDATE sh_docket_disbursement						
								SET balance_disbursed = balance_disbursed - (:i_dOrigAmountRec - :i_dFeeAmtRcvd),							
									 amount_paid = amount_paid - (:i_dOrigAmountRec - :i_dFeeAmtRcvd)
								FROM sh_docket_disbursement
								WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
								AND sh_docket_disbursement.disburse_status = 'O'
								AND sh_docket_disbursement.cb_type = 'M';
							If SQLCA.SQLCODE = -1 Then
								MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
								ROLLBACK;
								Return
							Else
								COMMIT;
							End If				
						Else
						
							UPDATE sh_docket_disbursement						
								SET balance_disbursed = balance_disbursed + :i_dFeeAmtRcvd,							
									 amount_paid = amount_paid + :i_dFeeAmtRcvd														
								FROM sh_docket_disbursement
								WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
								AND sh_docket_disbursement.disburse_status = 'O'
								AND sh_docket_disbursement.cb_type = 'M';																			
							If SQLCA.SQLCODE = -1 Then
								MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
								ROLLBACK;
								Return
							Else
								COMMIT;
							End If				
						End If

						SELECT cbdis_year, cbdis_number 
							INTO :i_iCBDisYear, :i_lCBDisNum
							FROM sh_docket_disbursement
							WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
							AND sh_docket_disbursement.disburse_status = 'O'
							AND sh_docket_disbursement.cb_type = 'M';																			
						If IsNull(i_iCBDisYear) Then i_iCBDisYear = 0							
						If IsNull(i_lCBDisNum) Then i_lCBDisNum = 0							
							
					End If

//messagebox("dis num", i_lCBDisNum)	
					UPDATE sh_docket_fee_paid
						SET cbdis_year = :i_iCBDisYear,
					       cbdis_number = :i_lCBDisNum
						 WHERE cb_type = 'M'
							AND cbrec_year = :i_iCBRecYear
							AND cbrec_number = :i_lCBRecNum
							AND sh_docket_fee_paid.fee_number = :i_iFeeNum;	
					If SQLCA.SQLCODE = -1 Then
						MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
						ROLLBACK;
						Return
					Else
						COMMIT;
					End If				

				Case 'T'

					s_achWhomDue = "Cerro Gordo County Treasurer"					
					SELECT COUNT(*) INTO :s_iCount
						FROM sh_docket_disbursement
						WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
						AND sh_docket_disbursement.disburse_status = 'O'
						AND sh_docket_disbursement.cb_type = 'M';																		
					If s_iCount = 0 Then
						
						i_iCBDisYear = Year(g_dtToday)
						SELECT MAX(cbdis_number) INTO :i_lCBDisNum
							FROM sh_docket_disbursement
							WHERE sh_docket_disbursement.cbdis_year = :i_iCBDisYear
							AND sh_docket_disbursement.cb_type = 'M';																			
						If IsNull(i_lCBDisNum) Then i_lCBDisNum = 0
						i_lCBDisNum ++
//messagebox("new T disb",i_lCBDisNum)		
						INSERT INTO sh_docket_disbursement
							(cb_type, docket_number, docket_year, cbdis_number, cbdis_year,
							 date_paid, amount_paid, check_number, last_name,
							 first_name, middle_name, suffix, whom_due, balance_disbursed,
							 case_number, disburse_status, disburse_date, disburse_type, fee_type)
						 VALUES ('M', :i_lCBRecNum, :i_iCBRecYear, :i_lCBDisNum, :i_iCBDisYear,
							 NULL, :i_dFeeAmtRcvd, 0, :s_achWhomDue,
							 '', '', '', '', :i_dFeeAmtRcvd, 
							 '', 'O', NULL, :s_achDisbursedType, :i_achFeeType);
						If SQLCA.SQLCODE = -1 Then
							MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
							ROLLBACK;
							Return
						Else
							COMMIT;
						End If				
							 									
					Else
						
						If i_bUpdateFee Then			

							UPDATE sh_docket_disbursement						
								SET balance_disbursed = balance_disbursed - (:i_dOrigAmountRec - :i_dFeeAmtRcvd),							
									 amount_paid = amount_paid - (:i_dOrigAmountRec - :i_dFeeAmtRcvd)
								FROM sh_docket_disbursement
								WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
								AND sh_docket_disbursement.disburse_status = 'O'
								AND sh_docket_disbursement.cb_type = 'M';
							If SQLCA.SQLCODE = -1 Then
								MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
								ROLLBACK;
								Return
							Else
								COMMIT;
							End If				
						Else
						
							UPDATE sh_docket_disbursement						
								SET balance_disbursed = balance_disbursed + :i_dFeeAmtRcvd,							
									 amount_paid = amount_paid + :i_dFeeAmtRcvd														
								FROM sh_docket_disbursement
								WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
								AND sh_docket_disbursement.disburse_status = 'O'
								AND sh_docket_disbursement.cb_type = 'M';																			
							If SQLCA.SQLCODE = -1 Then
								MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
								ROLLBACK;
								Return
							Else
								COMMIT;
							End If				
						End If

						SELECT cbdis_year, cbdis_number 
							INTO :i_iCBDisYear, :i_lCBDisNum
							FROM sh_docket_disbursement
							WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
							AND sh_docket_disbursement.disburse_status = 'O'
							AND sh_docket_disbursement.cb_type = 'M';																			
						If IsNull(i_iCBDisYear) Then i_iCBDisYear = 0							
						If IsNull(i_lCBDisNum) Then i_lCBDisNum = 0							
							
					End If

//messagebox("dis num", i_lCBDisNum)	
					UPDATE sh_docket_fee_paid
						SET cbdis_year = :i_iCBDisYear,
					       cbdis_number = :i_lCBDisNum
						 WHERE cb_type = 'M'
							AND cbrec_year = :i_iCBRecYear
							AND cbrec_number = :i_lCBRecNum
							AND sh_docket_fee_paid.fee_number = :i_iFeeNum;	
					If SQLCA.SQLCODE = -1 Then
						MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
						ROLLBACK;
						Return
					Else
						COMMIT;
					End If	

			End Choose										
			
			SELECT SUM(amount_received)
				INTO :s_dAmtRec
				FROM sh_docket_fee_paid
				WHERE cb_type = 'M'
					AND cbrec_year = :i_iCBRecYear
					AND cbrec_number = :i_lCBRecNum;
			If IsNull(s_dAmtRec) Then s_dAmtRec = 0

			UPDATE  sh_docket_receipt
				SET total_received = :s_dAmtRec 
				WHERE cb_type = 'M'
					AND cbrec_year = :i_iCBRecYear
					AND cbrec_number = :i_lCBRecNum;
			If SQLCA.SQLCODE = -1 Then
				MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
				ROLLBACK;
				Return
			Else
				COMMIT;
			End If							

			st_message.text = "Receipt Total:" + string(s_dAmtRec,'#,##0.00') //+ &
//				"                        " + &
//				"Receipt Balance:" + string(s_dAmtRec,'#,##0.00')
			
			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)							
			dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
			dw_scan.Retrieve() 			
			
			i_achCBType = "M"
			// find the row closest to this one
			s_iRow = dw_scan.Find("cb_type = '" + i_achCBType + &
				"' AND cbrec_year = " + String(i_iCBRecYear) + &				
				" AND cbrec_number = " + String(i_lCBRecNum), 0, dw_scan.RowCount())

			If s_iRow = 0 Then s_iRow = 1

			// highlight only the closest row
			dw_scan.ScrollToRow(s_iRow)				
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(s_iRow, True)				

			dw_scan.SetRedraw(True)

			If i_achMode = "Continue" Then
				If i_achOpType = "Add" Then
					m_main.m_general.m_add.PostEvent("clicked")
				End If	
			End If							

		End If

	Case "dw_docket_disburse_other_detail"

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
			dw_detail.Modify("date_paid.background.color = " + s_achDWColor + & 
				" date_paid.tabsequence = 0" + &						
				" last_name.background.color = " + s_achDWColor + & 
				" last_name.tabsequence = 0" + &						
				" first_name.background.color = " + s_achDWColor + & 
				" first_name.tabsequence = 0" + &						
				" middle_name.background.color = " + s_achDWColor + & 
				" middle_name.tabsequence = 0" + &									
				" suffix.background.color = " + s_achDWColor + & 
				" suffix.tabsequence = 0")
			dw_detail.SetRedraw(True)

			// Security - Add Docket Receipt Information
			If w_main.dw_perms.Find("code=46", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_new.enabled = True
				m_main.m_general.m_new.enabled = True
			End If
			
			// Security - Update Docket Receipt Information
			If w_main.dw_perms.Find("code=47", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_update.enabled = True				
				m_main.m_general.m_update.enabled = True
			End If
			
			// Security - Delete Docket Receipt Information
			If w_main.dw_perms.Find("code=48", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_delete.enabled = True				
				m_main.m_general.m_delete.enabled = True
			End If

			cb_escape.enabled = False
			m_main.m_general.m_escape.enabled = False
			cb_save.enabled = False
			m_main.m_general.m_save.enabled = False

			s_iRow = dw_detail.GetRow()
			s_achCBType = Trim(dw_detail.GetItemString(s_iRow,"cb_type"))
			i_achCaseNum = Trim(dw_detail.GetItemString(s_iRow,"case_number"))
			s_lCheckNum = dw_detail.GetItemNumber(s_iRow, "check_number")									
//			s_iDockYear = dw_detail.GetItemNumber(s_iRow,"docket_year")
//			s_lDockNum = dw_detail.GetItemNumber(s_iRow,"docket_number")			
			i_iCBDisYear = dw_detail.GetItemNumber(s_iRow,"cbdis_year")
			i_lCBDisNum = dw_detail.GetItemNumber(s_iRow,"cbdis_number")			
//			s_dTotRcvd = dw_detail.GetItemNumber(s_iRow,"total_received")						
			s_dtDatePaid = Date(dw_detail.GetItemDateTime(s_iRow,"date_paid"))									

			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)							
			dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
			dw_scan.Retrieve() 			
			
			i_achCBType = "M"
			// find the row closest to this one
			s_iRow = dw_scan.Find("cb_type = '" + i_achCBType + &
				"' AND cbrec_year = " + String(i_iCBRecYear) + &				
				" AND cbrec_number = " + String(i_lCBRecNum), 0, dw_scan.RowCount())

			If s_iRow = 0 Then s_iRow = 1

			// highlight only the closest row
			dw_scan.ScrollToRow(s_iRow)				
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(s_iRow, True)										
			
			dw_scan.SetRedraw(True)				
			dw_scan.enabled = True
	
			SELECT SUM(amount_received)
				INTO :s_dAmtRec
				FROM sh_docket_fee_paid
				WHERE cb_type = 'M'
					AND cbrec_year = :i_iCBRecYear
					AND cbrec_number = :i_lCBRecNum;
			If IsNull(s_dAmtRec) Then s_dAmtRec = 0

			UPDATE  sh_docket_receipt
				SET total_received = :s_dAmtRec 
				WHERE cb_type = 'M'
					AND cbrec_year = :i_iCBRecYear
					AND cbrec_number = :i_lCBRecNum;
			If SQLCA.SQLCODE = -1 Then
				MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
				ROLLBACK;
				Return
			Else
				COMMIT;
			End If										

			st_message.text = "Receipt Total:" + string(s_dAmtRec,'#,##0.00') //+ &
//				"                        " + &
//				"Receipt Balance:" + string(s_dAmtRec,'#,##0.00')
			
			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)							
			dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
			dw_scan.Retrieve() 			
			
			i_achCBType = "M"
			// find the row closest to this one
			s_iRow = dw_scan.Find("cb_type = '" + i_achCBType + &
				"' AND cbrec_year = " + String(i_iCBRecYear) + &				
				" AND cbrec_number = " + String(i_lCBRecNum), 0, dw_scan.RowCount())

			If s_iRow = 0 Then s_iRow = 1

			// highlight only the closest row
			dw_scan.ScrollToRow(s_iRow)				
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(s_iRow, True)				

			dw_scan.SetRedraw(True)
								
			If i_achMode = "Continue" Then
				If i_achOpType = "Add" Then
					
//					cb_disburse.TriggerEvent("clicked")					
					
					dw_detail.DataObject = "dw_docket_receipt_fee_paid_scan"
					dw_detail.SetTransObject(SQLCA)
							
					SELECT total_received 
						INTO :i_dTotRec
						FROM sh_docket_receipt
						WHERE cb_type = 'M'						
						AND cbrec_year = :i_iCBRecYear
							AND cbrec_number = :i_lCBRecNum;
					If IsNull(i_dTotRec) Then i_dTotRec = 0
				
					SELECT SUM(amount_received)
						INTO :s_dAmtRec
						FROM sh_docket_fee_paid
						WHERE cb_type = 'M'
							AND cbrec_year = :i_iCBRecYear
							AND cbrec_number = :i_lCBRecNum;
					If IsNull(s_dAmtRec) Then s_dAmtRec = 0
		
/*					If i_achMode = "Continue" And (i_dTotRec <> s_dAmtRec) Then
						If i_achOpType = "Add" Then
							m_main.m_general.m_add.PostEvent("clicked")
						End If	
					Else
						*/
						If i_achOpType = "Add" Then
							m_main.m_general.m_new.PostEvent("clicked")
						End If					

//					End If														
/*
			If i_achMode = "Continue" Then
				If i_achOpType = "Add" Then
					m_main.m_general.m_add.PostEvent("clicked")
				End If	
			End If							
	*/						
				End If	
			End If // Continue
					
		End If

End Choose

dw_detail.SetFocus()


end event

event ue_first;		
Choose Case dw_detail.DataObject
	Case "dw_misc_cash_receipt_detail"
		
		cb_first.enabled = False							
		m_main.m_general.m_first.enabled = False		
		cb_back.enabled = False									
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False									
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False									
		m_main.m_general.m_last.enabled = False

		Return

	Case "dw_misc_cash_receipt_fee_detail"
		Choose Case dw_detail.GetRow()
			Case 0, 1 // not on a row. set it to the first row
				If dw_detail.RowCount() = 0 Then
					m_main.m_general.m_first.enabled = True
					m_main.m_general.m_back.enabled = True
					m_main.m_general.m_next.enabled = True
					m_main.m_general.m_last.enabled = True
					
					Beep(1)
					Return
						
				Else
					m_main.m_general.m_first.enabled = True
					m_main.m_general.m_back.enabled = True
					m_main.m_general.m_next.enabled = True
					m_main.m_general.m_last.enabled = True

					dw_detail.SetRow(1)
					dw_detail.SetColumn(1)
					dw_detail.ScrollToRow(1)
				End If			
		
			Case Else // not on the first row, so first goes to the first row
				m_main.m_general.m_first.enabled = True
				m_main.m_general.m_back.enabled = True
				m_main.m_general.m_next.enabled = True
				m_main.m_general.m_last.enabled = True
				
				dw_detail.SetRow(1)
				dw_detail.SetColumn(1)
				dw_detail.ScrollToRow(1)		
		End Choose

End Choose
	
dw_detail.SetFocus()	

end event

event ue_last;datawindowchild	dwc

Choose Case dw_detail.DataObject
	
	Case "dw_misc_cash_receipt_detail"
		
		cb_first.enabled = False							
		m_main.m_general.m_first.enabled = False		
		cb_back.enabled = False									
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False									
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False									
		m_main.m_general.m_last.enabled = False

		Return

	Case "dw_misc_cash_receipt_fee_detail"		
		Choose Case dw_detail.GetRow()
			Case 0 // not on a row. set it to the first row
				If dw_detail.RowCount() = 0 Then
					m_main.m_general.m_first.enabled = False					
					m_main.m_general.m_back.enabled = False
					m_main.m_general.m_next.enabled = False
					m_main.m_general.m_last.enabled = False

					Return
				
				Else
					m_main.m_general.m_first.enabled = True					
					m_main.m_general.m_back.enabled = True
					m_main.m_general.m_next.enabled = True
					m_main.m_general.m_last.enabled = True

					dw_detail.SetRow(1)
					dw_detail.SetColumn(1)
					dw_detail.ScrollToRow(1)
				End If
				
			Case dw_detail.RowCount() // last row
				m_main.m_general.m_first.enabled = True					
				m_main.m_general.m_back.enabled = True
				m_main.m_general.m_next.enabled = True
				m_main.m_general.m_last.enabled = True
				
				Beep(1)
				Return
				
			Case Else // not on the last row, so next goes to the next row
				m_main.m_general.m_first.enabled = True					
				m_main.m_general.m_back.enabled = True
				m_main.m_general.m_next.enabled = True
				m_main.m_general.m_last.enabled = True
				
				dw_detail.SetRow(dw_detail.RowCount())
				dw_detail.SetColumn(1)
				dw_detail.ScrollToRow(dw_detail.GetRow())
	
		End Choose
				
End Choose
end event

event ue_new;call super::ue_new;string s_achDWColor, s_achNotes, s_achLName, s_achFName, s_achMName, s_achBusName

s_achDWColor = dw_scan.Describe("datawindow.color")

SetPointer(Hourglass!)

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

// Security - Add Miscellaneous Cash Receipt Information
If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_escape.enabled = True
	m_main.m_general.m_escape.enabled = True	
	cb_save.enabled = True
	m_main.m_general.m_save.enabled = True
End If

// Security - Update Miscellaneous Cash Receipt Information
If w_main.dw_perms.Find("code=51", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_escape.enabled = True
	m_main.m_general.m_escape.enabled = True		
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

// Security - Delete Miscellaneous Cash Receipt Information
If w_main.dw_perms.Find("code=52", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_escape.enabled = True
	m_main.m_general.m_escape.enabled = True		
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

dw_detail.DataObject = "dw_misc_cash_receipt_detail"
dw_detail.SetTransObject(SQLCA)

Choose Case dw_detail.DataObject
	Case "dw_misc_cash_receipt_detail"

		dw_detail.Tag = "Miscellaneous Cash Receipt Information"
		dw_detail.Reset()			
		dw_detail.InsertRow(0)
		dw_detail.SetItem(1,"cb_type", "M")			
		dw_detail.SetItem(1,"docket_year", 0)			
		dw_detail.SetItem(1,"docket_number", 0)			

		dw_detail.SetItem(1,"cbrec_year", Year(Today()))
		dw_detail.SetItem(1,"cbrec_number", 0)
		dw_detail.SetItem(1,"receipt_number", 0)		
		dw_detail.SetItem(1,"date_received", g_dtToday)		
		dw_detail.SetItem(1,"last_name", "")																		
		dw_detail.SetItem(1,"first_name", "")																				
		dw_detail.SetItem(1,"middle_name", "")																				
		dw_detail.SetItem(1,"suffix", "")																				
		dw_detail.SetItem(1,"total_received", 0)																			
		dw_detail.SetItem(1,"note", "")																	
		dw_detail.SetItem(1,"from_whom", "")																			
		dw_detail.SetItem(1,"amount_disbursed", 0)					
		dw_detail.SetItem(1,"balance_disbursed", 0)							
										
		dw_detail.SetRedraw(False)
		dw_detail.Modify("receipt_number.background.color = " + s_achDWColor + & 
			" receipt_number.tabsequence = 2" + &			
			" last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 4" + &						
			" first_name.background.color = " + s_achDWColor + & 
			" first_name.tabsequence = 5" + &						
			" middle_name.background.color = " + s_achDWColor + & 
			" middle_name.tabsequence = 6" + &									
			" suffix.background.color = " + s_achDWColor + & 
			" suffix.tabsequence = 7" + &									
			" note.background.color = " + s_achDWColor + & 
			" note.tabsequence = 8")
		dw_detail.SetRedraw(True)		

		i_iRow = 1
		dw_detail.SetRow(i_iRow)		
		dw_detail.ScrollToRow(i_iRow)								

End Choose	
		
dw_detail.SetFocus()

end event

event ue_delete;/*
string s_achErrText, s_achUserType
integer s_iCBRecYear, s_iCount
long s_lCBRecNum
date s_dtSubmitDate

i_achOpType = "Delete"

m_main.m_general.m_new.enabled = False
m_main.m_general.m_add.enabled = False
m_main.m_general.m_update.enabled = False
m_main.m_general.m_delete.enabled = False

Choose Case dw_detail.DataObject
	Case "dw_misc_cash_receipt_detail"
		
		m_main.m_general.m_first.enabled = False					
		m_main.m_general.m_back.enabled = False
		m_main.m_general.m_next.enabled = False
		m_main.m_general.m_last.enabled = False

		If dw_detail.RowCount() = 0 Then
		   MessageBox("Error","Select Row to Delete",StopSign!)
		Else
		   If 2 = MessageBox("Delete","Delete This ENTIRE Miscellaneous Cash Receipt?",Question!,OkCancel!,2) Then
		      MessageBox("Delete","Miscellaneous Cash Receipt NOT Deleted",None!)
		   Else
		
				SetPointer(Hourglass!) 
				
				i_iRow = dw_detail.GetRow()
				
				s_achUserType = dw_detail.GetItemString(i_iRow,"user_type")
				s_iCBRecYear = dw_detail.GetItemNumber(i_iRow,"cbrec_year")
				s_lCBRecNum = dw_detail.GetItemNumber(i_iRow,"cbrec_num")

				SELECT COUNT(*) INTO :s_iCount 
					FROM "dba"."cash_ref"
					WHERE "dba"."cash_ref"."user_type" = :s_achUserType
					AND "dba"."cash_ref"."cbrec_year" = :s_iCBRecYear
					AND "dba"."cash_ref"."cbrec_num" = :s_lCBRecNum;
				If s_iCount = 0 Then
					DELETE FROM "dba"."fee_paid"
						WHERE "dba"."fee_paid"."cb_type" = 'M'
						AND "dba"."fee_paid"."user_type" = :s_achUserType
						AND "dba"."fee_paid"."cbrec_year" = :s_iCBRecYear
						AND "dba"."fee_paid"."cbrec_num" = :s_lCBRecNum;					
					If SQLCA.SQLCode = -1 Then
						s_achErrText = SQLCA.SQLErrText
						ROLLBACK;
						MessageBox("Error", "Fee Paid Delete Failed - " + s_achErrText)
					End If										
				Else
					MessageBox("Delete Information", "Not deleted.  A disbursement has been made on this receipt.", Information!)					
				End If	

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
						dw_scan.DeleteRow(dw_scan.GetRow())
		
						// reset the update flags
						dw_scan.ResetUpdate()
						dw_detail.ResetUpdate()
						dw_detail.Title = dw_detail.Tag + " " + "Record " + String(dw_detail.GetRow()) + " of " + String(dw_detail.RowCount()) + "."																		
					End If
				End If
			End If
		End If

	Case "dw_misc_cash_receipt_fee_detail"	
		If dw_detail.RowCount() = 0 Then
		   MessageBox("Error","Select Row to Delete",StopSign!)
		Else
		   If 2 = MessageBox("Delete","Delete This Miscellaneous Cash Receipt Fee?",Question!,OkCancel!,2) Then
		      MessageBox("Delete","Miscellaneous Cash Receipt Fee NOT Deleted",None!)
		   Else
		
				SetPointer(Hourglass!) 

				i_iRow = dw_detail.GetRow()
				dw_detail.DeleteRow(i_iRow) 
				If dw_detail.Update(False, False) = -1 Then
					
					ROLLBACK;
					
				Else
					COMMIT;
					If SQLCA.SQLCode = -1 Then
						s_achErrText = SQLCA.SQLErrText
						ROLLBACK;
						MessageBox("Error", "Delete Failed - " + s_achErrText)
						
						// reset the update flags
						dw_detail.ResetUpdate()
					Else
						// reset the update flags
						dw_detail.ResetUpdate()
						dw_detail.Title = dw_detail.Tag + " " + "Record " + String(dw_detail.GetRow()) + " of " + String(dw_detail.RowCount()) + "."																		
					End If
				End If
			End If
		End If

End Choose
*/
end event

event resize;gnv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
end event

type cb_escape from w_base_sheet`cb_escape within w_misc_cash_receipt_sheet
integer taborder = 110
end type

type cb_exit from w_base_sheet`cb_exit within w_misc_cash_receipt_sheet
integer taborder = 190
end type

type cb_last from w_base_sheet`cb_last within w_misc_cash_receipt_sheet
integer taborder = 180
end type

type cb_next from w_base_sheet`cb_next within w_misc_cash_receipt_sheet
integer taborder = 170
end type

type cb_back from w_base_sheet`cb_back within w_misc_cash_receipt_sheet
integer taborder = 160
end type

type cb_first from w_base_sheet`cb_first within w_misc_cash_receipt_sheet
integer taborder = 150
end type

type cb_save from w_base_sheet`cb_save within w_misc_cash_receipt_sheet
integer taborder = 120
end type

type cb_delete from w_base_sheet`cb_delete within w_misc_cash_receipt_sheet
integer taborder = 100
end type

type cb_update from w_base_sheet`cb_update within w_misc_cash_receipt_sheet
integer taborder = 90
end type

type cb_add from w_base_sheet`cb_add within w_misc_cash_receipt_sheet
integer taborder = 80
end type

type cb_new from w_base_sheet`cb_new within w_misc_cash_receipt_sheet
integer taborder = 70
end type

type cb_clear from w_base_sheet`cb_clear within w_misc_cash_receipt_sheet
integer taborder = 60
end type

type cb_search from w_base_sheet`cb_search within w_misc_cash_receipt_sheet
integer taborder = 50
end type

type dw_detail from w_base_sheet`dw_detail within w_misc_cash_receipt_sheet
event ue_dwnkey pbm_dwnkey
event ue_continue_add pbm_custom14
integer x = 15
integer y = 816
integer width = 3098
integer height = 1043
integer taborder = 230
string dataobject = "dw_misc_cash_receipt_detail"
end type

event dw_detail::ue_dwnkey;string s_achDWColor, s_achCBType
integer s_iRow, s_iCBYear, s_iCBNum

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
		
	Case "dw_misc_cash_receipt_detail"
		
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "note"
				If KeyDown(KeyEnter!) Or KeyDown(KeyTab!) Then		
					parent.TriggerEvent("ue_save")
					Return
				End If
	
		End Choose 

		If i_achMode = "Continue" Then
			If KeyDown(KeyEscape!) Then
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
				dw_detail.Modify("receipt_number.background.color = " + s_achDWColor + & 
					" receipt_number.tabsequence = 0" + &			
					" date_received.background.color = " + s_achDWColor + & 
					" date_received.tabsequence = 0" + &						
					" last_name.background.color = " + s_achDWColor + & 
					" last_name.tabsequence = 0" + &						
					" first_name.background.color = " + s_achDWColor + & 
					" first_name.tabsequence = 0" + &						
					" middle_name.background.color = " + s_achDWColor + & 
					" middle_name.tabsequence = 0" + &									
					" suffix.background.color = " + s_achDWColor + & 
					" suffix.tabsequence = 0" + &									
					" note.background.color = " + s_achDWColor + & 
					" note.tabsequence = 0")
				dw_detail.SetRedraw(True)			

				s_iRow = dw_scan.GetRow()

				s_achCBType = dw_scan.GetItemString(s_iRow,"cb_type")
				s_iCBYear = dw_scan.GetItemNumber(s_iRow,"cbrec_year")
				s_iCBNum = dw_scan.GetItemNumber(s_iRow,"cbrec_number")				

				dw_detail.Retrieve(s_achCBType, s_iCBYear, s_iCBNum)			
			
				dw_scan.enabled = True

				// Security - Add Miscellaneous Cash Receipts
				If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
					cb_new.enabled = True
					m_main.m_general.m_new.enabled = True
				End If
				
				// Security - Update Miscellaneous Cash Receipts
				If w_main.dw_perms.Find("code=51", 1, w_main.dw_perms.RowCount()) > 0 Then
					cb_update.enabled = True
					m_main.m_general.m_update.enabled = True
				End If

				// Security - Delete Miscellaneous Cash Receipts
				If w_main.dw_perms.Find("code=52", 1, w_main.dw_perms.RowCount()) > 0 Then
					cb_delete.enabled = True
					m_main.m_general.m_delete.enabled = True
				End If

				m_main.m_general.m_escape.enabled = False
				cb_escape.enabled = False				
				cb_save.enabled = False
				m_main.m_general.m_save.enabled = False
				
//				i_bContinueItem = True
				cb_main.enabled = False
				cb_fee.enabled = True				
				
				dw_scan.SetFocus()
			End If
		End If		

	Case "dw_misc_cash_receipt_fee_detail"

		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "fee_note"
				If KeyDown(KeyEnter!) Or KeyDown(KeyTab!) Then		
					parent.TriggerEvent("ue_save")
					Return
				End If
	
		End Choose 

		If i_achMode = "Continue" Then
			If KeyDown(KeyEscape!) Then
				i_bContinueItem = False
				
				dw_detail.SetRedraw(False)		
				dw_detail.Modify("fee_type.background.color = " + s_achDWColor + & 
					" fee_type.tabsequence = 0" + &
					" fee_amount.background.color = " + s_achDWColor + & 
					" fee_amount.tabsequence = 0" + &				
					" fee_note.background.color = " + s_achDWColor + & 
					" fee_note.tabsequence = 0")
				dw_detail.SetRedraw(True)			
				
				If i_achOpType = "Add" Then
					dw_detail.PostEvent("ue_continue_add")
				End If
			End If
		End If		

	Case "dw_docket_disburse_other_detail"

		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "suffix"
				If KeyDown(KeyEnter!) Or KeyDown(KeyTab!) Then		
					parent.TriggerEvent("ue_save")
					Return
				End If
	
		End Choose 

		If i_achMode = "Continue" Then
			If KeyDown(KeyEscape!) Then
				i_bContinueItem = False
				
				dw_detail.SetRedraw(False)		
				dw_detail.Modify("last_name.background.color = " + s_achDWColor + & 
					" last_name.tabsequence = 0" + &						
					" first_name.background.color = " + s_achDWColor + & 
					" first_name.tabsequence = 0" + &						
					" middle_name.background.color = " + s_achDWColor + & 
					" middle_name.tabsequence = 0" + &									
					" suffix.background.color = " + s_achDWColor + & 
					" suffix.tabsequence = 0")
				dw_detail.SetRedraw(True)			

				If i_achOpType = "Add" Then
//					dw_detail.DataObject = "dw_misc_cash_receipt_fee_detail"
//					dw_detail.SetTransObject(SQLCA)
					
					dw_detail.PostEvent("ue_continue_add")
				End If
				
			End If
		End If		

End Choose
end event

event dw_detail::ue_continue_add;integer s_iRow

If i_bContinueItem = True Then
	dw_detail.DataObject = "dw_misc_cash_receipt_fee_detail"
	dw_detail.SetTransObject(SQLCA)								

	If i_achMode = "Continue" Then 
		m_main.m_general.m_add.TriggerEvent("clicked")
	End If	
/*	
	dw_detail.DataObject = "dw_docket_disbursement_other_detail"
	dw_detail.SetTransObject(SQLCA)								

	If i_achMode = "Continue" Then 
		m_main.m_general.m_add.TriggerEvent("clicked")
	End If		
	*/
Else
	
	If i_achMode = "Continue" And i_bDisbursement And i_bNew = True Then
		If i_achOpType = "Add" Then
			If 1 = MessageBox("Docket Disbursement Information","Add Docket Disbursement Information?",Question!,YesNo!,1) Then
				dw_detail.DataObject = "dw_docket_disbursement_other_detail"
				dw_detail.SetTransObject(SQLCA)								
				cb_disbursement.PostEvent("clicked")
				Return
			End If
		End If	
	End If				
	
	dw_detail.DataObject = "dw_misc_cash_receipt_detail"
	dw_detail.SetTransObject(SQLCA)								

	If i_achMode = "Continue" And i_bNew = True Then 
		m_main.m_general.m_new.TriggerEvent("clicked")
	End If	
	
End If
end event

event dw_detail::itemchanged;// script variables
string	s_achFeeType, s_achOrigFeeType
string	s_achErrText, s_achText
integer s_iCount, s_iRow

s_iRow = dw_detail.GetRow()					
Choose Case dw_detail.DataObject
		
	Case "dw_misc_cash_receipt_fee_detail"
		
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters
			Case "fee_type"			
	
				s_achFeeType = Upper(Trim(data))
				s_achOrigFeeType = Trim(dw_detail.GetItemString(s_iRow, "fee_type", Primary!, True))
				
				this.SetText(data)					
						
				If s_achFeeType <> "" Then				
					SELECT COUNT(*) INTO :s_iCount
						FROM ut_codes
						WHERE ut_codes.code = :s_achFeeType
						AND ut_codes.code_type = 'FEE';
					If s_iCount = 0 Then
						MessageBox("Error","Invalid Fee Type!")
						dw_detail.SetItem(s_iRow,"fee_type",s_achFeeType)																		
						data = ""
						this.SetText(data)					
						RETURN 1
					Else
						dw_detail.SetItem(s_iRow,"fee_type",s_achFeeType)													
						this.SetText(data)
						Return 2						
					End If
				End If				
				
		End Choose

End Choose
end event

event dw_detail::ue_tabenter;
Choose Case dw_detail.DataObject
		
	Case "dw_misc_cash_receipt_detail"
		
		Send(Handle(this),256,9,Long(0,0))
		RETURN 1

	Case "dw_misc_cash_receipt_fee_detail"
		
		Send(Handle(this),256,9,Long(0,0))
		RETURN 1
		
	Case "dw_docket_disburse_other_detail"
		
		Send(Handle(this),256,9,Long(0,0))
		RETURN 1		

End Choose		

end event

type dw_scan from w_base_sheet`dw_scan within w_misc_cash_receipt_sheet
integer x = 15
integer y = 221
integer width = 3098
integer height = 502
integer taborder = 270
string dataobject = "dw_misc_cash_receipt_scan"
end type

event dw_scan::rowfocuschanged;datawindowchild dwc

dw_detail.SetTransObject(SQLCA)

i_irow = dw_scan.GetRow()
If i_irow > 0 Then
	Choose Case dw_detail.DataObject
		Case "dw_misc_cash_receipt_detail"
			
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(currentrow, True)
			
			dw_detail.Tag = "Miscellaneous Cash Receipt Information"
			dw_detail.Retrieve(dw_scan.GetItemString(i_irow, "cb_type"), &
				dw_scan.GetItemNumber(i_irow, "cbrec_year"), &
				dw_scan.GetItemNumber(i_irow, "cbrec_number"))

	
	End Choose

End If	
end event

type gb_5 from w_base_sheet`gb_5 within w_misc_cash_receipt_sheet
end type

type gb_4 from w_base_sheet`gb_4 within w_misc_cash_receipt_sheet
end type

type gb_1 from w_base_sheet`gb_1 within w_misc_cash_receipt_sheet
integer textsize = -9
end type

type gb_2 from w_base_sheet`gb_2 within w_misc_cash_receipt_sheet
end type

type cb_list from w_base_sheet`cb_list within w_misc_cash_receipt_sheet
integer taborder = 130
end type

type cb_detail from w_base_sheet`cb_detail within w_misc_cash_receipt_sheet
integer taborder = 140
end type

type gb_3 from w_base_sheet`gb_3 within w_misc_cash_receipt_sheet
end type

type sle_lname from singlelineedit within w_misc_cash_receipt_sheet
integer x = 490
integer y = 16
integer width = 965
integer height = 80
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

type sle_fname from singlelineedit within w_misc_cash_receipt_sheet
integer x = 1843
integer y = 16
integer width = 516
integer height = 80
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

type em_receipt from editmask within w_misc_cash_receipt_sheet
integer x = 490
integer y = 112
integer width = 410
integer height = 83
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
string mask = "######"
string displaydata = ""
end type

type st_1 from statictext within w_misc_cash_receipt_sheet
integer x = 55
integer y = 26
integer width = 417
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

type st_2 from statictext within w_misc_cash_receipt_sheet
integer x = 1481
integer y = 26
integer width = 347
integer height = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "First Name:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_misc_cash_receipt_sheet
integer x = 37
integer y = 125
integer width = 439
integer height = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Receipt Num:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within w_misc_cash_receipt_sheet
integer x = 1295
integer y = 125
integer width = 530
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Date Received:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_date from editmask within w_misc_cash_receipt_sheet
integer x = 1843
integer y = 112
integer width = 443
integer height = 83
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
boolean spin = true
string displaydata = ""
end type

type cb_fee from commandbutton within w_misc_cash_receipt_sheet
integer x = 3163
integer y = 995
integer width = 450
integer height = 67
integer taborder = 220
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Receipt F&ee"
end type

event clicked;string s_achCBType
integer	s_iItemNum, s_iCBYear
long s_lCBNum
datawindowchild	dwc

i_bFees = True

dw_scan.enabled = False

cb_main.enabled = True
cb_disbursement.enabled = True
cb_fee.enabled = False		

cb_print_check.enabled = False

cb_new.enabled = False
m_main.m_general.m_new.enabled = False
cb_add.enabled = False
m_main.m_general.m_add.enabled = False
cb_update.enabled = False
m_main.m_general.m_update.enabled = False
cb_delete.enabled = False
m_main.m_general.m_delete.enabled = False

cb_first.enabled = True
m_main.m_general.m_first.enabled = True
cb_back.enabled = True
m_main.m_general.m_back.enabled = True
cb_next.enabled = True
m_main.m_general.m_next.enabled = True
cb_last.enabled = True
m_main.m_general.m_last.enabled = True

i_irow = dw_scan.GetRow()

s_achCBType = dw_scan.GetItemString(i_iRow, "cb_type")
s_lCBNum = dw_scan.GetItemNumber(i_iRow, "cbrec_number")
s_iCBYear = dw_scan.GetItemNumber(i_iRow, "cbrec_year")

dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Miscellaneous Cash Receipt Fee Information "

SELECT COUNT(*) INTO :s_iItemNum
	FROM sh_docket_fee
	WHERE sh_docket_fee.cb_type = :s_achCBType	
	AND sh_docket_fee.docket_year = :s_iCBYear
	AND sh_docket_fee.docket_number = :s_lCBNum;

If s_iItemNum = 0 Then

	// Security - Add Miscellaneous Cash Receipt Fees
	If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True			
		m_main.m_general.m_add.enabled = True
	End If	

	dw_detail.DataObject = "dw_misc_cash_receipt_fee_detail"
	dw_detail.SetTransObject(SQLCA)
	dw_detail.SetRowFocusIndicator(Hand!)		

	// get Fee Type
	dw_detail.GetChild("fee_type", dwc)
	dwc.SetTransObject(SQLCA)
	dwc.Reset()
	dwc.Retrieve("FEE")
	
	// Security - Add Miscellaneous Cash Receipt Fees
	If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True						
		m_main.m_general.m_add.TriggerEvent("clicked")
	End If	

Else  // Found, Retrieve Miscellaneous Cash Receipt Fee Information
	
	// Security - Add Miscellaneous Cash Receipt Fees
	If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True						
		m_main.m_general.m_add.enabled = True
	End If	
	// Security - Update Miscellaneous Cash Receipt Fees
	If w_main.dw_perms.Find("code=51", 1, w_main.dw_perms.RowCount()) > 0 Then		
		cb_update.enabled = True						
		m_main.m_general.m_update.enabled = True
	End If	
	// Security - Delete Miscellaneous Cash Receipt Fees
	If w_main.dw_perms.Find("code=52", 1, w_main.dw_perms.RowCount()) > 0 Then		
		cb_delete.enabled = True						
		m_main.m_general.m_delete.enabled = True
	End If	

	dw_detail.DataObject = "dw_misc_cash_receipt_fee_detail"
	dw_detail.SetTransObject(SQLCA)
	dw_detail.SetRowFocusIndicator(Hand!)
	dw_detail.Tag = "Miscellaneous Cash Receipt Fee Information"		

	// get Fee Type
	dw_detail.GetChild("fee_type", dwc)
	dwc.SetTransObject(SQLCA)
	dwc.Reset()
	dwc.Retrieve("FEE")
	
	dw_detail.Retrieve(s_achCBType, s_iCBYear, s_lCBNum)		
	
End If
			
dw_detail.SetFocus()		
end event

type gb_8 from groupbox within w_misc_cash_receipt_sheet
integer x = 3138
integer y = 790
integer width = 497
integer height = 301
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_main from commandbutton within w_misc_cash_receipt_sheet
integer x = 3163
integer y = 848
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
string text = "&Main"
end type

event clicked;string s_achNote
long s_lCBNum
integer s_iRow, s_iCBYear
datawindowchild dwc

i_bFees = False

dw_scan.enabled = True

cb_main.enabled = False
cb_fee.enabled = True
cb_disbursement.enabled = True

cb_print_check.enabled = False

cb_add.enabled = False
m_main.m_general.m_add.enabled = False
cb_update.enabled = False
m_main.m_general.m_update.enabled = False
cb_delete.enabled = False
m_main.m_general.m_delete.enabled = False

cb_first.enabled = False
m_main.m_general.m_first.enabled = False
cb_back.enabled = False
m_main.m_general.m_back.enabled = False
cb_next.enabled = False
m_main.m_general.m_next.enabled = False
cb_last.enabled = False
m_main.m_general.m_last.enabled = False

s_irow = dw_scan.GetRow()

s_lCBNum = dw_scan.GetItemNumber(s_iRow, "cbrec_number")
s_iCBYear = dw_scan.GetItemNumber(s_iRow, "cbrec_year")

dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Miscellaneous Cash Receipt Information"

SELECT sh_docket_receipt.note INTO :s_achNote
	FROM sh_docket_receipt
	WHERE sh_docket_receipt.cb_type = 'M'
	AND sh_docket_receipt.cbrec_year = :s_iCBYear
	AND sh_docket_receipt.cbrec_number = :s_lCBNum;
Choose Case SQLCA.SQLCODE
	Case 100 // Not found, Okay to insert Miscellaneous Cash Receipt Information
		// Security - Add Miscellaneous Cash Receipts
		If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
			cb_add.enabled = True						
			m_main.m_general.m_add.enabled = True
		End If	

		dw_detail.DataObject = "dw_misc_cash_receipt_detail"		
		dw_detail.SetTransObject(SQLCA)
		
		// Security - Add Miscellaneous Cash Receipts
		If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then		
			cb_add.enabled = True						
			m_main.m_general.m_add.TriggerEvent("clicked")
		End If
	
	Case 0   // Found, Retrieve Miscellaneous Cash Receipts
		// Security - Update Miscellaneous Cash Receipts
		If w_main.dw_perms.Find("code=51", 1, w_main.dw_perms.RowCount()) > 0 Then		
			cb_update.enabled = True			
			m_main.m_general.m_update.enabled = True
		End If	
		// Security - Delete Miscellaneous Cash Receipts
		If w_main.dw_perms.Find("code=52", 1, w_main.dw_perms.RowCount()) > 0 Then		
			cb_delete.enabled = True						
			m_main.m_general.m_delete.enabled = True
		End If	

		dw_detail.DataObject = "dw_misc_cash_receipt_detail"		
		dw_detail.SetTransObject(SQLCA)
		dw_detail.Tag = "Miscellaneous Cash Receipt Information"		

		dw_detail.Retrieve('M', s_iCBYear, s_lCBNum)		
	
	Case -1  // Serious problems
		MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)

End Choose
			
dw_scan.SetFocus()				
end event

type st_message from statictext within w_misc_cash_receipt_sheet
integer x = 15
integer y = 733
integer width = 3098
integer height = 77
boolean bringtotop = true
integer textsize = -10
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

type cb_disburse from commandbutton within w_misc_cash_receipt_sheet
boolean visible = false
integer x = 3167
integer y = 1280
integer width = 453
integer height = 67
integer taborder = 250
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Disburse &One"
end type

event clicked;datawindowchild dwc
integer s_iRow, s_iDockYear, s_iCBRecYear, s_iPeriodNum
long s_lCount, s_lDisbursementRows, s_lTransNum, s_lDockNum, s_lCBRecNum
long s_lReceiptNum, s_lCheckNum
string s_achDisburseType, s_achWhomDue, s_achFeeType, s_achDoc, s_achCaseNum, s_achStatus
decimal {2} s_dAmtRcvd, s_dBalDisp, s_dTotAmtRcvd
datetime s_dtRecDateTime
date s_dtRecDate

s_iRow = dw_scan.GetRow()

//i_iCBDisYear = dw_scan.GetItemNumber(s_iRow, "cbdis_year")
//i_lCBDisNum = dw_scan.GetItemNumber(s_iRow, "cbdis_number")

datastore lds_Disbursement

// allocate the resources for the datastores
lds_Disbursement = Create DataStore
			
lds_Disbursement.DataObject = 'dw_docket_disburse_fee_paid_ds'
lds_Disbursement.SetTransObject(SQLCA)

SELECT disburse_status INTO :s_achStatus
	FROM sh_docket_disbursement
	WHERE cb_type = 'M'
	AND sh_docket_disbursement.cbdis_year = :i_iCBDisYear
	AND sh_docket_disbursement.cbdis_number = :i_lCBDisNum;
If s_achStatus = 'W' Then
	MessageBox("Disbursement Information","Disbursement ALREADY Warranted--CANNOT Process Again!")
	Return
End If

SELECT max_number INTO :s_lCheckNum
	FROM ut_incremented_number
	WHERE ut_incremented_number.number_type = 'CHECK-MAX';
If SQLCA.SQLCODE = -1 Then
	MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
	Return
End If						
If IsNull(s_lCheckNum) Then s_lCheckNum = 0						
s_lCheckNum ++

UPDATE ut_incremented_number
	SET max_number = :s_lCheckNum
	WHERE ut_incremented_number.number_type = 'CHECK-MAX';
If SQLCA.SQLCODE = -1 Then
	MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
	Return
Else
	COMMIT;
End If									

s_dTotAmtRcvd = 0
// Retrieve ledgers for a specified year
s_lDisbursementRows = lds_Disbursement.Retrieve("M", i_iCBDisYear, i_lCBDisNum, "O")
//messagebox("rows",s_lDisbursementRows)
For s_lCount = 1 To s_lDisbursementRows

	s_achDisburseType = Trim(lds_Disbursement.GetItemString(s_lCount,"sh_docket_disbursement_disburse_type"))
	If IsNull(s_achDisburseType) Then s_achDisburseType = ""

	s_achFeeType = Trim(lds_Disbursement.GetItemString(s_lCount,"fee_type"))
	If IsNull(s_achFeeType) Then s_achFeeType = ""

	s_iDockYear = lds_Disbursement.GetItemNumber(s_lCount,"docket_year")
	s_lDockNum = lds_Disbursement.GetItemNumber(s_lCount,"docket_number")	
	s_lCBRecNum = lds_Disbursement.GetItemNumber(s_lCount, "cbrec_number")
	s_iCBRecYear = lds_Disbursement.GetItemNumber(s_lCount, "cbrec_year")			

	s_dBalDisp = lds_Disbursement.GetItemNumber(s_lCount, "new_balance_disbursed")							
	s_dAmtRcvd = lds_Disbursement.GetItemNumber(s_lCount, "amount_received")							

	s_dTotAmtRcvd = s_dTotAmtRcvd + s_dAmtRcvd
	
	lds_Disbursement.SetItem(s_lCount, "check_number", s_lCheckNum)
	lds_Disbursement.SetItem(s_lCount, "write_date", g_dttoday)
	lds_Disbursement.SetItem(s_lCount, "receipt_status", "W")
	lds_Disbursement.Update()
	COMMIT;

	SELECT receipt_number, date_received, case_number 
		INTO :s_lReceiptNum, :s_dtRecDateTime, :s_achCaseNum
		FROM sh_docket_receipt
		WHERE sh_docket_receipt.cb_type = 'M'
		AND sh_docket_receipt.cbrec_year = :s_iCBRecYear
		AND sh_docket_receipt.cbrec_number = :s_lCBRecNum;
	If IsNull(s_lReceiptNum) Then s_lReceiptNum = 0
	If IsNull(s_achCaseNum) Then s_achCaseNum = ""			
		
	s_dtRecDate = Date(s_dtRecDateTime)
	s_iPeriodNum = Month(s_dtRecDate)					

	Choose Case s_achDisburseType
									
		Case 'O'
			// Process Other Disbursement	
			s_achDoc = "Other Disbursement " + String(s_lReceiptNum)

	      lds_Disbursement.SetItem(s_lCount, "new_amount_disbursed", s_dAmtRcvd)			
	      lds_Disbursement.SetItem(s_lCount, "new_balance_disbursed", s_dBalDisp - s_dAmtRcvd)						
	      lds_Disbursement.SetItem(s_lCount, "receipt_status", "W")																		
			lds_Disbursement.Update()
			COMMIT;
									
		Case 'S'
			// Process State Disbursement					
			s_achDoc = "State Disbursement " + String(s_lReceiptNum)

	      lds_Disbursement.SetItem(s_lCount, "new_amount_disbursed", s_dAmtRcvd)			
	      lds_Disbursement.SetItem(s_lCount, "new_balance_disbursed", s_dBalDisp - s_dAmtRcvd)
	      lds_Disbursement.SetItem(s_lCount, "receipt_status", "W")												
			lds_Disbursement.Update()
			COMMIT;

		Case 'T'

			// Process Treasurer Disbursement	
			s_achDoc = "Treasurer Disbursement " + String(s_lReceiptNum)

	      lds_Disbursement.SetItem(s_lCount, "new_amount_disbursed", s_dAmtRcvd)			
	      lds_Disbursement.SetItem(s_lCount, "new_balance_disbursed", s_dBalDisp - s_dAmtRcvd)						
	      lds_Disbursement.SetItem(s_lCount, "receipt_status", "W")									
			lds_Disbursement.Update()
			COMMIT;
			
	End Choose					
		
Next

// Debit Fee Ledger - "+"
UPDATE ut_ledger_item
		SET ut_ledger_item.period_bal = ut_ledger_item.period_bal + :s_dTotAmtRcvd 
	WHERE ut_ledger_item.dock_year = :s_iDockYear
	AND ut_ledger_item.period = :s_iPeriodNum;								
If SQLCA.SQLCODE = -1 Then
	MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
	ROLLBACK;
	Return
Else
	COMMIT;
End If				
/*
s_lTransNum = 0
SELECT MAX(trans_number) INTO :s_lTransNum
	FROM ut_audit_trail;
If IsNull(s_lTransNum) Then s_lTransNum = 0									
s_lTransNum ++

INSERT INTO ut_audit_trail
	(trans_number, docket_number, docket_year, cbrec_number, cbrec_year,
	 cbdis_number, cbdis_year, receipt_number, debit_credit,
	 cb_type, post_date, amount, case_number,
	 documentation, trans_type)
 VALUES (:s_lTransNum, :s_lDockNum, :s_iDockYear, :s_lCBRecNum, :s_iCBRecYear,
	 :i_lCBDisNum, :i_iCBDisYear, :s_lReceiptNum, 'DR',
	 'M', :s_dtRecDate, :s_dAmtRcvd, :s_achCaseNum, 
	 :s_achDoc, 'CB');
If SQLCA.SQLCODE = -1 Then
	MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
	ROLLBACK;
	Return
Else
	COMMIT;
End If				
*/
UPDATE sh_docket_disbursement
	SET check_number = :s_lCheckNum,
		 disburse_status = 'W',
		 date_paid = :g_dttoday,
		 reconcile = 'N'
	WHERE sh_docket_disbursement.cb_type = 'M'
	AND sh_docket_disbursement.cbdis_year = :i_iCBDisYear
	AND sh_docket_disbursement.cbdis_number = :i_lCBDisNum;							
// error check
If SQLCA.SQLCode = -1 Then
	MessageBox("System Error","Disbursement Update Error - " + SQLCA.SQLErrText)
	ROLLBACK;
Else
	COMMIT;
End If								
/*
dw_detail.DataObject = "dw_docket_disburse_fee_paid_scan"		
dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Miscellaneous Disbursement Fee Paid Information"

// get Fee Type
dw_detail.GetChild("fee_type", dwc)
dwc.SetTransObject(SQLCA)
dwc.Reset()
dwc.Retrieve("FEE")

dw_detail.Retrieve("M", i_iCBDisYear, i_lCBDisNum)		
dw_detail.SetRowFocusIndicator(Hand!)

cb_main.enabled = True
cb_disburse.enabled = False
*/
end event

type cb_disbursement from commandbutton within w_misc_cash_receipt_sheet
integer x = 3163
integer y = 922
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
string text = "Disburse &Info"
end type

event clicked;datawindowchild	dwc
string s_achDWColor, s_achErrText, s_achFeeType
long s_lCount
integer s_iItemNum, s_iRow
decimal {2} s_dtotrec, s_damtrec, s_dcurrbal

datastore lds_Fees
long s_lFeeRows, s_iFeeCount, s_lFeeNum
string s_achcbtyped
decimal {2} s_dRecAmtReceived

s_achDWColor = dw_scan.Describe("datawindow.color")
dw_scan.enabled = False

cb_main.enabled = True
cb_disbursement.enabled = False
cb_fee.enabled = False
//cb_apply.visible = True

cb_print_check.enabled = True
			
cb_new.enabled = False
m_main.m_general.m_new.enabled = False
cb_add.enabled = False
m_main.m_general.m_add.enabled = False
cb_update.enabled = False
m_main.m_general.m_update.enabled = False
cb_delete.enabled = False
m_main.m_general.m_delete.enabled = False

cb_first.enabled = True
m_main.m_general.m_first.enabled = True
cb_back.enabled = True
m_main.m_general.m_back.enabled = True
cb_next.enabled = True
m_main.m_general.m_next.enabled = True
cb_last.enabled = True
m_main.m_general.m_last.enabled = True

s_iRow = dw_scan.GetRow()

s_achcbtyped = "M"

i_iDockYear = dw_scan.GetItemNumber(s_iRow, "cbrec_year")
i_lDockNum = dw_scan.GetItemNumber(s_iRow, "cbrec_number")

SELECT cbdis_year, cbdis_number, fee_type
	INTO :i_iCBDisYear, :i_lCBDisNum, :s_achFeeType
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.docket_year = :i_iDockYear
	AND sh_docket_disbursement.docket_number = :i_lDockNum
	AND sh_docket_disbursement.cb_type = 'M';						
If IsNull(i_iCBDisYear) Then i_iCBDisYear = 0							
If IsNull(i_lCBDisNum) Then i_lCBDisNum = 0							

dw_detail.DataObject = "dw_docket_disburse_other_detail"
dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Disbursement Information"

i_achMode = "Continue"

dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Disbursement Information"

SELECT COUNT(*) INTO :s_iItemNum
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.cb_type = 'M'	
	AND sh_docket_disbursement.docket_year = :i_iDockYear
	AND sh_docket_disbursement.docket_number = :i_lDockNum
	AND sh_docket_disbursement.disburse_type = 'O';
If s_iItemNum = 0 Then
	// Not found, Okay to insert Docket Memos
	// Security - Add Docket Memos
	If w_main.dw_perms.Find("code=26", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True
		m_main.m_general.m_add.enabled = True
	End If

	dw_detail.DataObject = "dw_docket_disburse_other_detail"
	dw_detail.SetTransObject(SQLCA)
//messagebox("not found area","")	
	// Security - Add Docket Memos
	If w_main.dw_perms.Find("code=26", 1, w_main.dw_perms.RowCount()) > 0 Then
		m_main.m_general.m_add.TriggerEvent("clicked")
	End If
	
Else  // Found, Retrieve Docket Memos
	// Security - Add Docket Memos
	If w_main.dw_perms.Find("code=26", 1, w_main.dw_perms.RowCount()) > 0 Then
// 	cb_add.enabled = True
//		m_main.m_general.m_add.enabled = True
	End If

	// Security - Update Docket Memos
	If w_main.dw_perms.Find("code=27", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_update.enabled = True
		m_main.m_general.m_update.enabled = True
	End If

	// Security - Delete Docket Memos
	If w_main.dw_perms.Find("code=28", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_delete.enabled = True
		m_main.m_general.m_delete.enabled = True
	End If

	cb_save.enabled = False
	m_main.m_general.m_save.enabled = False	
	
	dw_detail.DataObject = "dw_docket_disburse_other_detail"		
	dw_detail.SetTransObject(SQLCA)
	dw_detail.Tag = "Docket Disbursement Information"
/*
messagebox("found area","")	
messagebox("i_iDockYear",i_iDockYear)	
messagebox("i_lDockNum",i_lDockNum)	
messagebox("i_iCBDisYear",i_iCBDisYear)	
messagebox("i_lCBDisNum",i_lCBDisNum)	
*/
	dw_detail.Retrieve("M", i_iDockYear, i_lDockNum, i_iCBDisYear, i_lCBDisNum, s_achFeeType)		

/*	
	If i_achMode = "Continue" Then
		// Security - Add Docket Memos
		If w_main.dw_perms.Find("code=26", 1, w_main.dw_perms.RowCount()) > 0 Then
			m_main.m_general.m_update.TriggerEvent("clicked")
		End If
	End If
	*/
End If

//	Case -1  // Serious problems
//		MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)

dw_detail.SetFocus()			


end event

type dw_check from datawindow within w_misc_cash_receipt_sheet
boolean visible = false
integer x = 1580
integer y = 1059
integer width = 947
integer height = 368
integer taborder = 240
boolean bringtotop = true
string dataobject = "dw_civil_misc_check_rpt"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_print_check from commandbutton within w_misc_cash_receipt_sheet
boolean visible = false
integer x = 3163
integer y = 1635
integer width = 450
integer height = 67
integer taborder = 260
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Print Check"
end type

event clicked;
long s_lCheckNum
integer s_iRow

s_iRow = dw_detail.GetRow()

s_lCheckNum = 0
s_lCheckNum = dw_detail.GetItemNumber(s_iRow, "check_number")

If IsNull(s_lCheckNum) Then s_lCheckNum = 0

If s_lCheckNum = 0 Then
	MessageBox("Check Error", "Disbursement DOES NOT Have a Check Number!", StopSign!)
	Return
End If

// Retrieve Information
dw_check.SetTransObject(SQLCA)
dw_check.Reset()
dw_check.Retrieve('W', 'M', 'FEE', s_lCheckNum, s_lCheckNum)	

MessageBox("Check in Printer", "Put Check Number " + string(s_lCheckNum) + " in the Printer!", Information!)

// Printer Setup and Printout depending on current detail window
OpenWithParm(w_datawindow_print_dialog,dw_check)


end event

