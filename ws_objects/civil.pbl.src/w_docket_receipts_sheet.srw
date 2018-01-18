$PBExportHeader$w_docket_receipts_sheet.srw
forward
global type w_docket_receipts_sheet from w_base_sheet
end type
type em_dock_num from editmask within w_docket_receipts_sheet
end type
type em_dock_year from editmask within w_docket_receipts_sheet
end type
type st_1 from statictext within w_docket_receipts_sheet
end type
type st_2 from statictext within w_docket_receipts_sheet
end type
type st_3 from statictext within w_docket_receipts_sheet
end type
type gb_m from groupbox within w_docket_receipts_sheet
end type
type cb_main from commandbutton within w_docket_receipts_sheet
end type
type cb_disburse from commandbutton within w_docket_receipts_sheet
end type
type em_case_num from editmask within w_docket_receipts_sheet
end type
type st_case_num from statictext within w_docket_receipts_sheet
end type
type st_message from statictext within w_docket_receipts_sheet
end type
type em_date from editmask within w_docket_receipts_sheet
end type
type cb_disbursement from commandbutton within w_docket_receipts_sheet
end type
type cb_disburse_info from commandbutton within w_docket_receipts_sheet
end type
end forward

global type w_docket_receipts_sheet from w_base_sheet
integer width = 3690
integer height = 2067
string title = "Docket Receipts"
em_dock_num em_dock_num
em_dock_year em_dock_year
st_1 st_1
st_2 st_2
st_3 st_3
gb_m gb_m
cb_main cb_main
cb_disburse cb_disburse
em_case_num em_case_num
st_case_num st_case_num
st_message st_message
em_date em_date
cb_disbursement cb_disbursement
cb_disburse_info cb_disburse_info
end type
global w_docket_receipts_sheet w_docket_receipts_sheet

type variables
boolean i_bFirstSearch, i_bButtonOnly, i_bNew, i_bExit
boolean i_bContinueItem, i_bUpdateDisbButton
integer i_iFeeLineCount
date i_dtRcvdDate, i_dtRecDate
decimal {2} i_dTotRcvd, i_dTotRec, i_dFeeAmtRcvd
integer i_iDockYear, i_iCBRecYear, i_iFeeNum
long i_lCBRecNum, i_lDockNum, i_lReceiptNum
string i_achSaveSQL, i_achCBType, i_achMode
string i_achCaseNum, i_achFeeType
string i_achFirstDisb
boolean i_bUpdateFee
end variables

on w_docket_receipts_sheet.create
int iCurrent
call super::create
this.em_dock_num=create em_dock_num
this.em_dock_year=create em_dock_year
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.gb_m=create gb_m
this.cb_main=create cb_main
this.cb_disburse=create cb_disburse
this.em_case_num=create em_case_num
this.st_case_num=create st_case_num
this.st_message=create st_message
this.em_date=create em_date
this.cb_disbursement=create cb_disbursement
this.cb_disburse_info=create cb_disburse_info
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_dock_num
this.Control[iCurrent+2]=this.em_dock_year
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.gb_m
this.Control[iCurrent+7]=this.cb_main
this.Control[iCurrent+8]=this.cb_disburse
this.Control[iCurrent+9]=this.em_case_num
this.Control[iCurrent+10]=this.st_case_num
this.Control[iCurrent+11]=this.st_message
this.Control[iCurrent+12]=this.em_date
this.Control[iCurrent+13]=this.cb_disbursement
this.Control[iCurrent+14]=this.cb_disburse_info
end on

on w_docket_receipts_sheet.destroy
call super::destroy
destroy(this.em_dock_num)
destroy(this.em_dock_year)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.gb_m)
destroy(this.cb_main)
destroy(this.cb_disburse)
destroy(this.em_case_num)
destroy(this.st_case_num)
destroy(this.st_message)
destroy(this.em_date)
destroy(this.cb_disbursement)
destroy(this.cb_disburse_info)
end on

event open;SetPointer(HourGlass!)

i_achSQL = dw_scan.GetSQLSelect()
dw_scan.SetTransObject(SQLCA)

gnv_resize = create n_cst_resize
gnv_resize.of_SetOrigSize (this.Width, this.Height )
gnv_resize.of_Register(dw_scan, gnv_resize.SCALE)
gnv_resize.of_Register(dw_detail, gnv_resize.SCALE)
gnv_resize.of_Register(st_1, gnv_resize.SCALE)
gnv_resize.of_Register(em_case_num, gnv_resize.SCALE)
gnv_resize.of_Register(em_date, gnv_resize.SCALE)
gnv_resize.of_Register(em_dock_num, gnv_resize.SCALE)
gnv_resize.of_Register(em_dock_year, gnv_resize.SCALE)
gnv_resize.of_Register(st_2, gnv_resize.SCALE)
gnv_resize.of_Register(cb_add, gnv_resize.SCALE)
gnv_resize.of_Register(cb_back, gnv_resize.SCALE)
gnv_resize.of_Register(cb_clear, gnv_resize.SCALE)
gnv_resize.of_Register(cb_delete, gnv_resize.SCALE)
gnv_resize.of_Register(cb_detail, gnv_resize.SCALE)
gnv_resize.of_Register(cb_disburse, gnv_resize.SCALE)
gnv_resize.of_Register(cb_disburse_info, gnv_resize.SCALE)
gnv_resize.of_Register(cb_escape, gnv_resize.SCALE)
gnv_resize.of_Register(cb_exit, gnv_resize.SCALE)
gnv_resize.of_Register(cb_first, gnv_resize.SCALE)
gnv_resize.of_Register(cb_last, gnv_resize.SCALE)
gnv_resize.of_Register(cb_list, gnv_resize.SCALE)
gnv_resize.of_Register(cb_main, gnv_resize.SCALE)
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
gnv_resize.of_Register(gb_m, gnv_resize.SCALE)
gnv_resize.of_Register(st_case_num, gnv_resize.SCALE)
gnv_resize.of_Register(st_message, gnv_resize.SCALE)
gnv_resize.of_Register(st_1, gnv_resize.SCALE)
gnv_resize.of_Register(st_2, gnv_resize.SCALE)
gnv_resize.of_Register(st_3, gnv_resize.SCALE)

//this.Height = dw_detail.Height + 1100
//this.Width = dw_detail.Width + 1050

i_bFirstSearch = True
i_achCbType = "D"
g_bDisbursed = False


em_dock_year.SetFocus()

end event

event ue_search;call super::ue_search;// script variables
integer s_iRcvdYear, s_iRcvdMonth, s_iRcvdDay, s_iNumRows, s_iDockYear, s_iDockNum
string s_achSQL, s_achRcvd, s_achRcvdYear, s_achRcvdMonth, s_achRcvdDay, s_achDWColor
date s_dtRcvdDate

SetPointer(HourGlass!)

cb_add.enabled = False
m_main.m_general.m_add.enabled = False

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

s_achDWColor = dw_detail.Describe("datawindow.color")

dw_detail.DataObject = "dw_docket_receipts_detail"

dw_detail.SetRedraw(False)
dw_detail.Modify("docket_year.background.color = " + s_achDWColor + & 
	" docket_year.tabsequence = 0" + &							
	" docket_number.background.color = " + s_achDWColor + & 
	" docket_number.tabsequence = 0" + &					
	" receipt_number.background.color = " + s_achDWColor + & 
	" receipt_number.tabsequence = 0" + &				
	" date_received.background.color = " + s_achDWColor + & 
	" date_received.tabsequence = 0" + &						
	" judgment_receipt.background.color = " + s_achDWColor + & 
	" judgment_receipt.tabsequence = 0" + &							
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
dw_scan.enabled = True

SetNull(i_dtRcvdDate)

s_achRcvd = Trim(String(em_date.text))
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

If s_achRcvd <> "" And Not IsNull(s_achRcvd) Then
   If Len(s_achSQL) = 0 Then
      s_achSQL = &
         " WHERE sh_docket_receipt.date_received = ~~~'" + String(i_dtRcvdDate, "yyyy-mm-dd") + "~~~'" 
   Else 
		s_achSQL += &
         " AND sh_docket_receipt.date_received = ~~~'" + String(i_dtRcvdDate, "yyyy-mm-dd") + "~~~'" 
   End If
End If

i_lDockNum = Integer(Trim(em_dock_num.text))
i_iDockYear = Integer(Trim(em_dock_year.text))

If i_iDockYear <> 0 Then
   If Len(s_achSQL) = 0 Then
      s_achSQL = &
         " WHERE sh_docket_receipt.docket_year = ~~~'" + String(i_iDockYear) + "~~~'" 
   Else 
		s_achSQL += &
         " AND sh_docket_receipt.docket_year = ~~~'" + String(i_iDockYear) + "~~~'" 
   End If
End If

If i_lDockNum <> 0 Then
   If Len(s_achSQL) = 0 Then
      s_achSQL = &
         " WHERE sh_docket_receipt.docket_number = ~~~'" + String(i_lDockNum) + "~~~'" 
   Else 
		s_achSQL += &
         " AND sh_docket_receipt.docket_number = ~~~'" + String(i_lDockNum) + "~~~'" 
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

dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")

dw_scan.Reset()
If dw_scan.Retrieve() = 0 Then
	MessageBox("Complete", "No Docket Receipt rows found.")
	em_dock_year.SetFocus()
Else
	
	cb_main.enabled = False
	cb_disburse_info.enabled = True	
	cb_disburse.enabled = True
	
   dw_scan.SetFocus()
End If
end event

event ue_new;call super::ue_new;datawindowchild dwc
string s_achDWColor, s_achName
integer s_iItemNum, s_iFY
decimal {2} s_dAmtRec

s_achDWColor = dw_scan.Describe("datawindow.color")

SetPointer(Hourglass!)

i_bButtonOnly = False
i_bNew = True
i_achOpType = "Add"
i_achMode = "Continue"
i_bExit = False

cb_main.enabled = False
cb_disburse_info.enabled = False
cb_disburse.enabled = False

cb_new.enabled = False
m_main.m_general.m_new.enabled = False
cb_add.enabled = False
m_main.m_general.m_add.enabled = False
cb_delete.enabled = False
m_main.m_general.m_delete.enabled = False
cb_update.enabled = False
m_main.m_general.m_update.enabled = False

// Security - Add Docket Receipt Information
If w_main.dw_perms.Find("code=46", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_escape.enabled = True
	m_main.m_general.m_escape.enabled = True	
	cb_save.enabled = True
	m_main.m_general.m_save.enabled = True
End If

// Security - Update Docket Receipt Information
If w_main.dw_perms.Find("code=47", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_escape.enabled = True
	m_main.m_general.m_escape.enabled = True		
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

// Security - Delete Docket Receipt Information
If w_main.dw_perms.Find("code=48", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_escape.enabled = True
	m_main.m_general.m_escape.enabled = True		
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

dw_detail.Tag = "Docket Receipt Information"
dw_detail.DataObject = "dw_docket_receipts_detail"
dw_detail.SetTransObject(SQLCA)

Choose Case dw_detail.DataObject
	Case "dw_docket_receipts_detail"

		dw_detail.Tag = "Docket Receipt Information"		
		dw_detail.Reset()		
		dw_detail.InsertRow(0)
		
		i_dTotRec = 0
		s_dAmtRec = 0

		dw_detail.SetItem(1,"cb_type", "D")																	
		
		st_message.text = "Receipt Total:" + string(i_dTotRec,'#,##0.00') + &
			"                        " + &
			"Receipt Balance:" + string(s_dAmtRec,'#,##0.00')

		dw_detail.SetItem(1,"docket_year", 0)							
		dw_detail.SetItem(1,"docket_number", 0)					
		dw_detail.SetItem(1,"cbrec_year", Year(Today()))
		dw_detail.SetItem(1,"cbrec_number", 0)
		dw_detail.SetItem(1,"case_number", "")				
		dw_detail.SetItem(1,"receipt_number", 0)		
		dw_detail.SetItem(1,"date_received", g_dtToday)		
		dw_detail.SetItem(1,"judgment_receipt", 0)				
		dw_detail.SetItem(1,"last_name", "")																		
		dw_detail.SetItem(1,"first_name", "")																				
		dw_detail.SetItem(1,"middle_name", "")																				
		dw_detail.SetItem(1,"suffix", "")																				
		dw_detail.SetItem(1,"total_received", 0)																			
		dw_detail.SetItem(1,"note", "")																	
		dw_detail.SetItem(1,"from_whom", "")																			
		dw_detail.SetItem(1,"amount_disbursed", 0)					
		dw_detail.SetItem(1,"balance_disbursed", 0)							
		dw_detail.SetItem(1,"receipt_status", "O")							
											
		dw_detail.SetRedraw(False)
		dw_detail.Modify("docket_year.background.color = " + s_achDWColor + & 
			" docket_year.tabsequence = 1" + &							
		   " docket_number.background.color = " + s_achDWColor + & 
			" docket_number.tabsequence = 2" + &					
		   " receipt_number.background.color = " + s_achDWColor + & 
			" receipt_number.tabsequence = 3" + &			
			" judgment_receipt.background.color = " + s_achDWColor + & 
			" judgment_receipt.tabsequence = 5" + &										
			" last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 6" + &						
			" first_name.background.color = " + s_achDWColor + & 
			" first_name.tabsequence = 7" + &						
			" middle_name.background.color = " + s_achDWColor + & 
			" middle_name.tabsequence = 8" + &									
			" suffix.background.color = " + s_achDWColor + & 
			" suffix.tabsequence = 9" + &									
			" note.background.color = " + s_achDWColor + & 
			" note.tabsequence = 10" + &			
			" total_received.background.color = " + s_achDWColor + & 
			" total_received.tabsequence = 11")
		dw_detail.SetRedraw(True)		
		
		i_iRow = 1
		dw_detail.SetRow(i_iRow)		
		dw_detail.ScrollToRow(i_iRow)								

End Choose	

dw_detail.SetFocus()

end event

event ue_update;call super::ue_update;string s_achDWColor, s_achDDWColor, s_achFeeType
integer s_iRow, s_iScanRow, s_iCBDisYear
long s_lCBDisNum

i_achOpType ="Update"

s_achDWColor = dw_scan.Describe("datawindow.color")
s_achDDWColor = dw_detail.Describe("datawindow.color")

cb_main.enabled = True
cb_disburse_info.enabled = True
cb_disburse.enabled = True

s_iScanRow = dw_scan.GetRow()
s_iRow = dw_detail.GetRow()
Choose Case dw_detail.DataObject
			 
	Case "dw_docket_receipts_detail"

		dw_detail.SetRedraw(False)
		dw_detail.Modify("receipt_number.background.color = " + s_achDWColor + & 
			" receipt_number.tabsequence = 2" + &			
			" judgment_receipt.background.color = " + s_achDWColor + & 
			" judgment_receipt.tabsequence = 4" + &										
			" last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 6" + &						
			" first_name.background.color = " + s_achDWColor + & 
			" first_name.tabsequence = 7" + &						
			" middle_name.background.color = " + s_achDWColor + & 
			" middle_name.tabsequence = 8" + &									
			" suffix.background.color = " + s_achDWColor + & 
			" suffix.tabsequence = 9" + &									
			" note.background.color = " + s_achDWColor + & 
			" note.tabsequence = 10" + &			
			" total_received.background.color = " + s_achDWColor + & 
			" total_received.tabsequence = 11")			
		dw_detail.SetColumn("receipt_number")						
		
	Case "dw_docket_receipt_fee_paid_update_scan"

		dw_detail.SetRedraw(False)
		dw_detail.Modify("amount_received.background.color = " + s_achDWColor + & 
			" amount_received.tabsequence = 2")
		dw_detail.SetColumn("amount_received")						

	Case "dw_docket_receipt_fees_scan"

		dw_detail.SetRedraw(False)
		dw_detail.Modify("amount_received.background.color = " + s_achDWColor + & 
			" amount_received.tabsequence = 1" + &
		   " fee_end.background.color = " + s_achDWColor + & 
			" fee_end.tabsequence = 2")							
		dw_detail.SetColumn("amount_received")						

	Case "dw_docket_disburse_other_lookup_detail"
	
		s_iCBDisYear = dw_detail.GetItemNumber(s_iRow, "cbdis_year")
		s_lCBDisNum = dw_detail.GetItemNumber(s_iRow, "cbdis_number")		
		s_achFeeType = Trim(dw_detail.GetItemString(s_iRow, "fee_type"))
	
		dw_detail.DataObject = "dw_docket_disburse_other_detail"		
		dw_detail.SetTransObject(SQLCA)
		dw_detail.Tag = "Docket Disbursement Information"
			
		dw_detail.Retrieve("D", i_iDockYear, i_lDockNum, s_iCBDisYear, s_lCBDisNum, s_achFeeType)		
		dw_detail.SetRow(s_iRow)
		dw_detail.ScrollToRow(s_iRow)	
										
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

event ue_save;call super::ue_save;string s_achDWColor, s_achCBType, s_achDoc, s_achCaseNum, s_achDisbursedType
string s_achWhomDue, s_achLName
integer s_iDockYear, s_iCount, s_iRow, s_iFeeNum, s_iPeriodNum
integer s_iCBDisYear, s_iDCount, s_iFeeCount
long s_lDockNum, s_lTransNum, s_lReceiptNum, s_lCBDisNum, s_lCheckNum
decimal {2} s_dTotRcvd, s_dBalanceDue, s_dTotFeePaid, s_dTotFees
decimal {2} s_dcurrbal, s_dtotrec, s_damtrec
date s_dtRecDate, s_dtDatePaid
datawindowchild dwc

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject

	Case "dw_docket_receipts_detail"

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
			dw_detail.Modify("docket_year.background.color = " + s_achDWColor + & 
				" docket_year.tabsequence = 0" + &							
				" docket_number.background.color = " + s_achDWColor + & 
				" docket_number.tabsequence = 0" + &								
			   " receipt_number.background.color = " + s_achDWColor + & 
				" receipt_number.tabsequence = 0" + &			
				" date_received.background.color = " + s_achDWColor + & 
				" date_received.tabsequence = 0" + &						
				" judgment_receipt.background.color = " + s_achDWColor + & 
				" judgment_receipt.tabsequence = 0" + &											
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
			i_lReceiptNum = dw_detail.GetItemNumber(s_iRow, "receipt_number")									
			s_iDockYear = dw_detail.GetItemNumber(s_iRow,"docket_year")
			s_lDockNum = dw_detail.GetItemNumber(s_iRow,"docket_number")			
			i_iCBRecYear = dw_detail.GetItemNumber(s_iRow,"cbrec_year")
			i_lCBRecNum = dw_detail.GetItemNumber(s_iRow,"cbrec_number")			
			i_dTotRcvd = dw_detail.GetItemNumber(s_iRow,"total_received")						
			i_dtRecDate = Date(dw_detail.GetItemDateTime(s_iRow,"date_received"))									

			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)							
			dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
			dw_scan.Retrieve() 			
			
			i_achCBType = "D"
			// find the row closest to this one
			s_iRow = dw_scan.Find("cb_type = '" + i_achCBType + &
				"' AND docket_year = " + String(s_iDockYear) + &
				" AND docket_number = " + String(s_lDockNum) + &
				" AND cbrec_year = " + String(i_iCBRecYear) + &				
				" AND cbrec_number = " + String(i_lCBRecNum), 0, dw_scan.RowCount())

			If s_iRow = 0 Then s_iRow = 1

			// highlight only the closest row
			dw_scan.ScrollToRow(s_iRow)				
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(s_iRow, True)										
			
			dw_scan.SetRedraw(True)				
			dw_scan.enabled = True

			SELECT COUNT(*) INTO :s_iCount
				FROM sh_docket_fee
				WHERE sh_docket_fee.cb_type = 'D'
				AND sh_docket_fee.docket_year = :s_iDockYear
				AND sh_docket_fee.docket_number = :s_lDockNum;
			If s_iCount = 0 Then
				// Not found, No Fees
				MessageBox("Fees", "No fees exist for this docket!")
				Return
			Else		
				// Fees found
				st_receiptparms 	s_stparms
				
				SetPointer(Hourglass!)
				
				i_iRow = dw_detail.GetRow()
				i_dtRecDate = Date(dw_detail.GetItemDateTime(i_iRow, "date_received"))
				i_lCBRecNum = dw_detail.GetItemNumber(i_iRow, "cbrec_number")
				i_iCBRecYear = dw_detail.GetItemNumber(i_iRow, "cbrec_year")
				i_dTotRcvd = dw_detail.GetItemNumber(i_iRow, "total_received")
							
				s_stparms.achCBType = 'D'
				s_stparms.iDockYear = s_iDockYear					
				s_stparms.lDockNum = s_lDockNum					
				s_stparms.iRecYear = i_iCBRecYear										
				s_stparms.lRecNum = i_lCBRecNum										
				s_stparms.dtRecDate = i_dtRecDate
				s_stparms.wPrev = This
				s_stparms.achOpType = i_achOpType
				s_stparms.dTotRcvd = s_dTotRcvd
						
				If i_achMode = "Continue" Then //And i_bNew = True Then
					If i_achOpType = "Add" Then
						cb_disburse.PostEvent("clicked")
					End If	
	 			End If				

			End If
					
		End If

	Case "dw_docket_receipt_fees_scan"
		
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
			dw_detail.Modify("amount_received.background.color = " + s_achDWColor + & 
				" amount_received.tabsequence = 0" + &
			   " fee_end.background.color = " + s_achDWColor + & 
				" fee_end.tabsequence = 0")				
			dw_detail.SetRedraw(True)			

			// Security - Add Docket Fees
			If w_main.dw_perms.Find("code=42", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_add.enabled = True
				m_main.m_general.m_add.enabled = True
			End If

			// Security - Update Docket Fees
			If w_main.dw_perms.Find("code=43", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_update.enabled = True				
				m_main.m_general.m_update.enabled = True
			End If
			
			// Security - Delete Docket Fees
			If w_main.dw_perms.Find("code=44", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_delete.enabled = True
				m_main.m_general.m_delete.enabled = True
			End If
			
			cb_save.enabled = False
			m_main.m_general.m_save.enabled = False
			
			cb_main.enabled = True
			cb_disburse.enabled = True

			s_iRow = dw_detail.GetRow()

			s_iDockYear = dw_detail.GetItemNumber(s_iRow,"docket_year")
			s_lDockNum = dw_detail.GetItemNumber(s_iRow,"docket_number")	
			s_iFeeNum = dw_detail.GetItemNumber(s_iRow, "fee_number")						
			i_achFeeType = Trim(dw_detail.GetItemString(s_iRow, "fee_type"))
			i_dFeeAmtRcvd = dw_detail.GetItemNumber(s_iRow, "amount_received")						
			s_dBalanceDue = dw_detail.GetItemNumber(s_iRow, "balance_due")	
			
			SELECT disbursed_type INTO :s_achDisbursedType
				FROM ut_codes
				WHERE ut_codes.code_type = 'FEE'
				AND ut_codes.code = :i_achFeeType;
			If IsNull(s_achDisbursedType) Then s_achDisbursedType = ""
			
			i_achFirstDisb = "N"

			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)							
			dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
			i_achCBType = "D"			
			dw_scan.Retrieve(i_achCBType, s_iDockYear, s_lDockNum)			

			// find the row closest to this one
			s_iRow = dw_scan.Find("cb_type = '" + i_achCBType + &
				"' AND docket_year = " + String(s_iDockYear) + &
				" AND docket_number = " + String(s_lDockNum) + &
				" AND cbrec_year = " + String(i_iCBRecYear) + &				
				" AND cbrec_number = " + String(i_lCBRecNum), 0, dw_scan.RowCount())

			If s_iRow = 0 Then s_iRow = 1

			// highlight only the closest row
			dw_scan.ScrollToRow(s_iRow)				
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(s_iRow, True)				

			dw_scan.SetRedraw(True)

			SELECT last_name, cbdis_year, cbdis_number 
				INTO :s_achLName, :s_iCBDisYear, :s_lCBDisNum
				FROM sh_docket_disbursement
				WHERE sh_docket_disbursement.fee_type = :i_achFeeType				
				AND sh_docket_disbursement.disburse_type = 'O'
				AND sh_docket_disbursement.disburse_status = 'O'
				AND sh_docket_disbursement.cb_type = 'D'
				AND sh_docket_disbursement.docket_year = :i_iDockYear																									
				AND sh_docket_disbursement.docket_number = :i_lDockNum;																																	
			If IsNull(s_achLName) Then s_achLName = ""
		
			i_iFeeLineCount = dw_detail.GetRow()

//			If ((i_achFeeType = "DE" Or i_achFeeType = "PB") And s_achLName = "") and i_dFeeAmtRcvd > 0 Then
			If ((s_achDisbursedType = "O") And s_achLName = "") and i_dFeeAmtRcvd > 0 Then
				i_achFirstDisb = "Y"
				cb_disbursement.TriggerEvent("clicked")
			End If

//			If (i_achFeeType <> "DE" AND i_achFeeType <> "PB") and i_dFeeAmtRcvd > 0 Then
			If (s_achDisbursedType <> "O") and i_dFeeAmtRcvd > 0 Then
				i_iFeeLineCount = dw_detail.GetRow()
				i_iFeeLineCount ++
//messagebox("1",i_iFeeLineCount)	
				If i_iFeeLineCount > dw_detail.RowCount() Then
							
					SELECT total_received 
						INTO :i_dTotRec
						FROM sh_docket_receipt
						WHERE cb_type = 'D'
							AND cbrec_year = :i_iCBRecYear
							AND cbrec_number = :i_lCBRecNum;
					If IsNull(i_dTotRec) Then i_dTotRec = 0
				
					SELECT SUM(amount_received)
						INTO :s_dAmtRec
						FROM sh_docket_fee_paid
						WHERE cb_type = 'D'
							AND cbrec_year = :i_iCBRecYear
							AND cbrec_number = :i_lCBRecNum;
					If IsNull(s_dAmtRec) Then s_dAmtRec = 0
	
					If i_dTotRec <> s_dAmtRec Then
						If 2 = MessageBox("Receipt Fee Information", &
							"Receipt Amount NOT Equal To Fees Allocated--Exit Fees?",Question!,YesNo!,2) Then
		
							cb_update.TriggerEvent("clicked")					
							dw_detail.SetRow(i_iFeeLineCount)
							dw_detail.ScrollToRow(i_iFeeLineCount)	
							dw_detail.SetRowFocusIndicator(Hand!)							
							
						Else	
							
							dw_detail.DataObject = "dw_docket_receipts_detail"
							dw_detail.SetTransObject(SQLCA)
							dw_detail.Retrieve("D", i_iDockYear, i_lDockNum, i_iCBRecYear, i_lCBRecNum)		
							cb_update.TriggerEvent("clicked")					
							Return	
						End If								
					Else
						dw_detail.DataObject = "dw_docket_receipts_detail"
						dw_detail.SetTransObject(SQLCA)
						cb_new.TriggerEvent("clicked")							
						Return											
					End If
				Else 
//					messagebox("here","")
					dw_detail.Retrieve("D", i_iDockYear, i_lDockNum)		
					cb_update.TriggerEvent("clicked")					
					dw_detail.SetRow(i_iFeeLineCount)
					dw_detail.ScrollToRow(i_iFeeLineCount)	
					dw_detail.SetRowFocusIndicator(Hand!)	
				End If
			ElseIf i_iFeeLineCount < dw_detail.RowCount() Then
//			messagebox("here2","")				
				i_iFeeLineCount = dw_detail.GetRow()
				i_iFeeLineCount ++
												
				cb_update.TriggerEvent("clicked")					
				dw_detail.SetRow(i_iFeeLineCount)
				dw_detail.ScrollToRow(i_iFeeLineCount)	
				dw_detail.SetRowFocusIndicator(Hand!)	
			ElseIf i_achFirstDisb = "N" Then				

				dw_detail.DataObject = "dw_docket_receipts_detail"
				dw_detail.SetTransObject(SQLCA)
				cb_new.TriggerEvent("clicked")							
				Return					
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
			dw_detail.Modify("last_name.background.color = " + s_achDWColor + & 
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
			s_iDockYear = dw_detail.GetItemNumber(s_iRow,"docket_year")
			s_lDockNum = dw_detail.GetItemNumber(s_iRow,"docket_number")			
			s_iCBDisYear = dw_detail.GetItemNumber(s_iRow,"cbdis_year")
			s_lCBDisNum = dw_detail.GetItemNumber(s_iRow,"cbdis_number")			

			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)							
			dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
			i_achCBType = "D"			
			dw_scan.Retrieve(i_achCBType, s_iDockYear, s_lDockNum)			

			// find the row closest to this one
			s_iRow = dw_scan.Find("cb_type = '" + i_achCBType + &
				"' AND docket_year = " + String(s_iDockYear) + &
				" AND docket_number = " + String(s_lDockNum) + &
				" AND cbrec_year = " + String(i_iCBRecYear) + &				
				" AND cbrec_number = " + String(i_lCBRecNum), 0, dw_scan.RowCount())

			If s_iRow = 0 Then s_iRow = 1

			// highlight only the closest row
			dw_scan.ScrollToRow(s_iRow)				
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(s_iRow, True)										
			
			dw_scan.SetRedraw(True)				
			dw_scan.enabled = True
			
			i_achMode = "Continue"

			If i_achMode = "Continue" And Not i_bUpdateDisbButton Then
				If i_achOpType = "Update" Then
					dw_detail.DataObject = "dw_docket_receipt_fees_scan"
					dw_detail.SetTransObject(SQLCA)

					SELECT disbursed_type INTO :s_achDisbursedType
						FROM ut_codes
						WHERE ut_codes.code_type = 'FEE'
						AND ut_codes.code = :i_achFeeType;
					If IsNull(s_achDisbursedType) Then s_achDisbursedType = ""

					SELECT total_received 
						INTO :i_dTotRec
						FROM sh_docket_receipt
						WHERE cb_type = 'D'
							AND cbrec_year = :i_iCBRecYear
							AND cbrec_number = :i_lCBRecNum;
					If IsNull(i_dTotRec) Then i_dTotRec = 0
				
					SELECT SUM(amount_received)
						INTO :s_dAmtRec
						FROM sh_docket_fee_paid
						WHERE cb_type = 'D'
							AND cbrec_year = :i_iCBRecYear
							AND cbrec_number = :i_lCBRecNum;
					If IsNull(s_dAmtRec) Then s_dAmtRec = 0
													
					st_message.text = "Receipt Total:" + string(i_dTotRec,'#,##0.00') + &
						"                        " + &
						"Receipt Balance:" + string(s_dAmtRec,'#,##0.00')
				
					// get Fee Type
					dw_detail.GetChild("fee_type", dwc)
					dwc.SetTransObject(SQLCA)
					dwc.Reset()
					dwc.Retrieve("FEE")

					dw_detail.Retrieve("D", i_iDockYear, i_lDockNum)		

//					If (i_achFeeType = "DE" or i_achFeeType = "PB") and i_dFeeAmtRcvd > 0 Then
					If (s_achDisbursedType = "O") and i_dFeeAmtRcvd > 0 Then
						i_iFeeLineCount ++
			
						If i_iFeeLineCount > dw_detail.RowCount() Then
							
							SELECT total_received 
								INTO :i_dTotRec
								FROM sh_docket_receipt
								WHERE cb_type = 'D'
									AND cbrec_year = :i_iCBRecYear
									AND cbrec_number = :i_lCBRecNum;
							If IsNull(i_dTotRec) Then i_dTotRec = 0
						
							SELECT SUM(amount_received)
								INTO :s_dAmtRec
								FROM sh_docket_fee_paid
								WHERE cb_type = 'D'
									AND cbrec_year = :i_iCBRecYear
									AND cbrec_number = :i_lCBRecNum;
							If IsNull(s_dAmtRec) Then s_dAmtRec = 0

							If i_dTotRec <> s_dAmtRec Then
								If 2 = MessageBox("Receipt Fee Information", &
									"Receipt Amount NOT Equal To Fees Allocated--Exit Fees?",Question!,YesNo!,2) Then
				
									cb_update.TriggerEvent("clicked")					
									dw_detail.SetRow(i_iFeeLineCount)
									dw_detail.ScrollToRow(i_iFeeLineCount)	
									dw_detail.SetRowFocusIndicator(Hand!)							
									
								Else	
								
									dw_detail.DataObject = "dw_docket_receipts_detail"
									dw_detail.SetTransObject(SQLCA)
									dw_detail.Retrieve("D", i_iDockYear, i_lDockNum, i_iCBRecYear, i_lCBRecNum)		
									cb_update.TriggerEvent("clicked")					
									Return	
								End If						
							Else	
								dw_detail.DataObject = "dw_docket_receipts_detail"
								dw_detail.SetTransObject(SQLCA)
								cb_new.TriggerEvent("clicked")					
								Return
							End If							
						
						Else
							cb_update.TriggerEvent("clicked")					
							dw_detail.SetRow(i_iFeeLineCount)
							dw_detail.ScrollToRow(i_iFeeLineCount)	
							dw_detail.SetRowFocusIndicator(Hand!)				
						End If
					End If
				End If	
			End If																	
		End If

End Choose

dw_detail.SetFocus()

end event

event ue_clear;call super::ue_clear;
em_date.text = ""
SetNull(em_date.text)
em_dock_num.text = ""
em_dock_year.text = ""

i_achOpType = ""
SetNull(i_dtRcvdDate)
i_lDockNum = 0
i_iDockYear = 0

cb_main.enabled = False
cb_disburse_info.enabled = False
cb_disburse.enabled = False

cb_first.enabled = False
m_main.m_general.m_first.enabled = False
cb_back.enabled = False
m_main.m_general.m_back.enabled = False
cb_next.enabled = False
m_main.m_general.m_next.enabled = False
cb_last.enabled = False
m_main.m_general.m_last.enabled = False

em_dock_year.SetFocus()


end event

event ue_val_fields;integer s_iRowCount, s_iRow, s_iCount, s_iCBRecYear, s_iCBDisYear, s_iDockYear, s_iFeeNum
long s_lLineNum, s_lMaxNum, s_lCBRecNum, s_lCBDisNum, s_lDockNum, s_lDocketFeePaidRows
long s_lCount, s_lCheckNum
date s_dtOrigRecDate, s_dtRecDate
string s_achCBType, s_achFeeType, s_achOrigFeeType, s_achDisbursedType, s_achOrigDisbursedType
decimal {2} s_dAmtRcvd, s_dFeeAmount, s_dOrigFeeAmount

datastore lds_DocketFeePaid

// allocate the resources for the datastores
lds_DocketFeePaid = Create DataStore
			
lds_DocketFeePaid.DataObject = 'dw_update_receipt_date_fees_ds'
lds_DocketFeePaid.SetTransObject(SQLCA)

dw_detail.SetTransObject(SQLCA)
dw_detail.AcceptText()
Choose Case dw_detail.DataObject
	
	Case "dw_docket_receipts_detail"

		If IsNull(dw_detail.GetItemString(1,"last_name")) Or (dw_detail.GetItemString(1,"last_name") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Last name MUST be entered!")
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

	Case "dw_docket_receipt_fee_paid_scan"	
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

Choose Case dw_detail.DataObject

	Case "dw_docket_receipts_detail"

		s_iRow = dw_detail.GetRow()
		
		s_achCBType = Trim(dw_detail.GetItemString(s_iRow,"cb_type"))						
		s_lDockNum = dw_detail.GetItemNumber(s_iRow,"docket_number")				
		s_iDockYear = dw_detail.GetItemNumber(s_iRow,"docket_year")				
		s_iCBRecYear = dw_detail.GetItemNumber(s_iRow,"cbrec_year")		
		s_dtRecDate = Date(dw_detail.GetItemDateTime(s_iRow,"date_received"))									
		s_dtOrigRecDate = Date(dw_detail.GetItemDateTime(s_iRow,"date_received",Primary!, True))											

		If i_achOpType = "Add" Then		
//messagebox("val flds",s_iRow)
			SELECT max_number INTO :s_lCBRecNum
				FROM ut_incremented_number
				WHERE ut_incremented_number.number_type = 'CBREC-MAX'
				AND ut_incremented_number.civil_year = :s_iCBRecYear;								
			If SQLCA.SQLCODE = -1 Then
				MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
				Return
			End If						
			If IsNull(s_lCBRecNum) Then s_lCBRecNum = 0						
			s_lCBRecNum ++

			dw_detail.SetItem(s_iRow, "cbrec_number", s_lCBRecNum)
//messagebox("rec",s_lCBRecNum)			
			UPDATE ut_incremented_number
				SET max_number = :s_lCBRecNum
				WHERE ut_incremented_number.number_type = 'CBREC-MAX'
				AND ut_incremented_number.civil_year = :s_iCBRecYear;												
			If SQLCA.SQLCODE = -1 Then
				MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
				Return
			Else
				COMMIT;
			End If									
		End If		
		
		s_lCBRecNum = dw_detail.GetItemNumber(s_iRow,"cbrec_number")				
		
		If i_achOpType = "Update" &
			And dw_detail.GetItemStatus(s_iRow, "date_received", Primary!) = DataModified! Then		
/*			
			s_iPeriodNum = Month(s_dtOrigRecDate)			
					
			// Retrieve fees paid for a specified receipt for the original date
			s_lDocketFeePaidRows = lds_DocketFeePaid.Retrieve("D", s_iDockYear, s_lDockNum, &
				s_iCBRecYear, s_lCBRecNum)
			messagebox("rows",s_lDocketFeePaidRows)
			For s_lCount = 1 To s_lDocketFeePaidRows
	
				s_achFeeType = Trim(lds_DocketFeePaid.GetItemString(s_lCount,"fee_type"))
				If IsNull(s_achFeeType) Then s_achFeeType = ""
			
				s_dAmtRcvd = lds_DocketFeePaid.GetItemNumber(s_lCount,"amount_received")
				If IsNull(s_dAmtRcvd) Then s_dAmtRcvd = 0

				If s_achFeeType = "DE" Or s_achFeeType = "BD" Or s_achFeeType = "OP" Then
					// Process Receipt
					// Debit Fee Ledger - "-"
					UPDATE ut_hold_ledger_item
							SET ut_hold_ledger_item.period_bal = ut_hold_ledger_item.period_bal - :s_dAmtRcvd 
						WHERE ut_hold_ledger_item.dock_year = :s_iCBRecYear
						AND ut_hold_ledger_item.cb_type = 'D'
						AND ut_hold_ledger_item.fee_type = :s_achFeeType
						AND ut_hold_ledger_item.period = :s_iPeriodNum;								
					If SQLCA.SQLCODE = -1 Then
						MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
						ROLLBACK;
						Return
					Else
						COMMIT;
					End If				
				Else		
					// Process Receipt
					// Debit Fee Ledger - "-"
					UPDATE ut_ledger_item
							SET ut_ledger_item.period_bal = ut_ledger_item.period_bal - :s_dAmtRcvd 
						WHERE ut_ledger_item.dock_year = :s_iCBRecYear
						AND ut_ledger_item.cb_type = 'D'
						AND ut_ledger_item.fee_type = :s_achFeeType
						AND ut_ledger_item.period = :s_iPeriodNum;								
					If SQLCA.SQLCODE = -1 Then
						MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
						ROLLBACK;
						Return
					Else
						COMMIT;
					End If				
				End If
		
			Next			

			// Updated date
			s_iPeriodNum = Month(s_dtRecDate)			
					
			// Retrieve fees paid for a specified receipt for updated date
			s_lDocketFeePaidRows = lds_DocketFeePaid.Retrieve("D", s_iDockYear, s_lDockNum, &
				s_iCBRecYear, s_lCBRecNum)
			messagebox("rows",s_lDocketFeePaidRows)
			For s_lCount = 1 To s_lDocketFeePaidRows
	
				s_achFeeType = Trim(lds_DocketFeePaid.GetItemString(s_lCount,"fee_type"))
				If IsNull(s_achFeeType) Then s_achFeeType = ""
			
				s_dAmtRcvd = lds_DocketFeePaid.GetItemNumber(s_lCount,"amount_received")
				If IsNull(s_dAmtRcvd) Then s_dAmtRcvd = 0

				If s_achFeeType = "DE" Or s_achFeeType = "BD" Or s_achFeeType = "OP" Then
					// Process Receipt
					// Debit Fee Ledger - "+"
					UPDATE ut_hold_ledger_item
							SET ut_hold_ledger_item.period_bal = ut_hold_ledger_item.period_bal + :s_dAmtRcvd 
						WHERE ut_hold_ledger_item.dock_year = :s_iCBRecYear
						AND ut_hold_ledger_item.cb_type = 'D'
						AND ut_hold_ledger_item.fee_type = :s_achFeeType
						AND ut_hold_ledger_item.period = :s_iPeriodNum;								
					If SQLCA.SQLCODE = -1 Then
						MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
						ROLLBACK;
						Return
					Else
						COMMIT;
					End If				
				Else		
					// Process Receipt
					// Debit Fee Ledger - "+"
					UPDATE ut_ledger_item
							SET ut_ledger_item.period_bal = ut_ledger_item.period_bal + :s_dAmtRcvd 
						WHERE ut_ledger_item.dock_year = :s_iCBRecYear
						AND ut_ledger_item.cb_type = 'D'
						AND ut_ledger_item.fee_type = :s_achFeeType
						AND ut_ledger_item.period = :s_iPeriodNum;								
					If SQLCA.SQLCODE = -1 Then
						MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
						ROLLBACK;
						Return
					Else
						COMMIT;
					End If				
				End If
		
			Next			
*/
			UPDATE sh_docket_fee_paid
				SET date_received = :s_dtRecDate
				WHERE sh_docket_fee_paid.cb_type = :s_achCBType 
				AND sh_docket_fee_paid.docket_year = :s_iDockYear
				AND sh_docket_fee_paid.docket_number = :s_lDockNum
				AND sh_docket_fee_paid.cbrec_year = :s_iCBRecYear
				AND sh_docket_fee_paid.cbrec_number = :s_lCBRecNum;
			If SQLCA.SQLCODE = -1 Then
				MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
				ROLLBACK;
				Return
			Else
				COMMIT;
			End If											
				
		End If

	Case "dw_docket_receipt_fees_scan"
		
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
				WHERE sh_docket_fee.cb_type = 'D'
				AND sh_docket_fee.docket_year = :s_iCBRecYear
				AND sh_docket_fee.docket_number = :s_lCBRecNum;
	
			If IsNull(s_iFeeNum) Then s_iFeeNum = 0						
			s_iFeeNum ++
			dw_detail.SetItem(i_iRow, "fee_number", s_iFeeNum)
		End If
/*		
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
				AND sh_docket_disbursement.cb_type = 'D';
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
				AND sh_docket_disbursement.cb_type = 'D';																			
			If SQLCA.SQLCODE = -1 Then
				MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
				ROLLBACK;
				Return
			Else
				COMMIT;
			End If				

		End If
*/

	Case "dw_docket_disburse_other_detail"

		s_iRow = dw_detail.GetRow()

End Choose   

end event

event ue_add;datawindowchild dwc
string s_achDWColor, s_achFeeType
integer s_iFeeNum, s_iCount, s_iDockYear, s_iRow, s_iCBRecYear, s_iCBDisYear, s_iFeePaidNum
long s_lDockNum, s_lCBRecNum, s_lCBDisNum, s_lDockFeesRows, s_lCount
decimal {2} s_dBalanceDue
date s_dtDateReceived
long s_lCheckNum

datastore lds_DockFees

// allocate the resources for the datastores
lds_DockFees = Create DataStore
			
lds_DockFees.DataObject = 'dw_docket_fee_balance_ds'
lds_DockFees.SetTransObject(SQLCA)

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

dw_scan.enabled = False			

i_achOpType = "Add"
If i_bNew = True Then
	i_achMode = "Continue"
Else 
	i_achMode = ""
End If	

Choose Case dw_detail.DataObject
		
	Case "dw_docket_receipt_fee_paid_scan"

		// get Fee Type
		dw_detail.GetChild("fee_type", dwc)
		dwc.SetTransObject(SQLCA)
		dwc.Reset()
		dwc.Retrieve("FEE")

		If i_achMode = "Continue" Then
			cb_main.enabled = False
			cb_disburse.enabled = False
		Else
			cb_main.enabled = True
			cb_disburse.enabled = False
		End If

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

		s_iDockYear = dw_scan.GetItemNumber(s_iRow, "docket_year")
		s_lDockNum = dw_scan.GetItemNumber(s_iRow, "docket_number")		
		s_iCBRecYear = dw_scan.GetItemNumber(s_iRow, "cbrec_year")		
		s_lCBRecNum = dw_scan.GetItemNumber(s_iRow, "cbrec_number")				
		s_dtDateReceived = Date(dw_scan.GetItemDateTime(s_iRow, "date_received"))

		s_iRow = dw_detail.InsertRow(0)
		
		dw_detail.SetItem(s_iRow,"cb_type", "D")															
		dw_detail.SetItem(s_iRow,"docket_year", s_iDockYear)															
		dw_detail.SetItem(s_iRow,"docket_number", s_lDockNum)																	
		dw_detail.SetItem(s_iRow,"cbrec_year", s_iCBRecYear)															
		dw_detail.SetItem(s_iRow,"cbrec_number", s_lCBRecNum)																	
		dw_detail.SetItem(s_iRow,"new_balance_disbursed", 0)																			
		dw_detail.SetItem(s_iRow,"new_amount_disbursed", 0)																					

		// Retrieve fees for a specified docket
		s_lDockFeesRows = lds_DockFees.Retrieve("D", s_iDockYear, s_lDockNum)
//		messagebox("rows",s_lDockFeesRows)
		For s_lCount = 1 To s_lDockFeesRows
		
			s_iFeeNum = lds_DockFees.GetItemNumber(s_lCount,"fee_number")
			If IsNull(s_iFeeNum) Then s_iFeeNum = 0
		
			SELECT COUNT(*) INTO :s_iFeePaidNum
				FROM sh_docket_fee_paid
				WHERE sh_docket_fee_paid.cb_type = 'D'			
				AND sh_docket_fee_paid.cbrec_year = :s_iCBRecYear
				AND sh_docket_fee_paid.cbrec_number = :s_lCBRecNum
				AND sh_docket_fee_paid.docket_year = :s_iDockYear
				AND sh_docket_fee_paid.docket_number = :s_lDockNum
				AND sh_docket_fee_paid.fee_number = :s_iFeeNum;			
			If IsNull(s_iFeePaidNum) Then s_iFeePaidNum = 0			
			If s_iFeePaidNum = 0 Then GOTO FeeFound
						
		Next			
		FeeFound:
		
		If s_iFeeNum > 0 Then
			SELECT balance_due, fee_type INTO :s_dBalanceDue, :s_achFeeType
				FROM sh_docket_fee
				WHERE sh_docket_fee.cb_type = 'D'			
				AND sh_docket_fee.docket_year = :s_iDockYear
				AND sh_docket_fee.docket_number = :s_lDockNum
				AND sh_docket_fee.fee_number = :s_iFeeNum;						
				
			If IsNull(s_dBalanceDue) Then s_dBalanceDue = 0					
		End If
	
		dw_detail.SetItem(s_iRow, "fee_number", s_iFeeNum)

		dw_detail.SetItem(s_iRow,"fee_type", s_achFeeType)		
		dw_detail.SetItem(s_iRow,"date_received", s_dtDateReceived)	
		dw_detail.SetItem(s_iRow,"amount_received", 0)	
		dw_detail.SetItem(s_iRow,"sh_docket_fee_fee_amount", s_dBalanceDue)					
		dw_detail.SetItem(s_iRow,"sh_docket_fee_balance_due", s_dBalanceDue)			

		dw_detail.SetRedraw(False)
		dw_detail.Modify("amount_received.background.color = " + s_achDWColor + & 
			" amount_received.tabsequence = 1")
		dw_detail.SetRedraw(True)			
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

		s_iDockYear = dw_scan.GetItemNumber(s_iRow, "docket_year")
		s_lDockNum = dw_scan.GetItemNumber(s_iRow, "docket_number")		

		s_iRow = dw_detail.InsertRow(0)

		s_iCBDisYear = Year(g_dtToday)
		dw_detail.SetItem(s_iRow,"cb_type", "D")															
		dw_detail.SetItem(s_iRow,"disburse_type", "O")																	
		dw_detail.SetItem(s_iRow,"disburse_status", "O")																			
		dw_detail.SetItem(s_iRow,"docket_year", s_iDockYear)															
		dw_detail.SetItem(s_iRow,"docket_number", s_lDockNum)																	
		dw_detail.SetItem(s_iRow,"cbdis_year", s_iCBDisYear)															
		dw_detail.SetItem(s_iRow,"cbdis_number", 0)																	
		dw_detail.SetItem(s_iRow,"case_number", i_achCaseNum)																	

		SELECT MAX(cbdis_number) INTO :s_lCBDisNum
			FROM sh_docket_disbursement
			WHERE sh_docket_disbursement.cbdis_year = :s_iCBDisYear
			AND sh_docket_disbursement.cb_type = 'D';				

		If IsNull(s_lCBDisNum) Then s_lCBDisNum = 0			
		s_lCBDisNum ++
		dw_detail.SetItem(s_iRow, "cbdis_number", s_lCBDisNum)

//messagebox("new O disb",s_lCBDisNum)		
   	dw_detail.SetItem(s_iRow,"date_paid", g_dtToday)		
		dw_detail.SetItem(s_iRow,"last_name", "")																		
		dw_detail.SetItem(s_iRow,"first_name", "")																				
		dw_detail.SetItem(s_iRow,"middle_name", "")																				
		dw_detail.SetItem(s_iRow,"suffix", "")																				
		
		SELECT max_number INTO :s_lCheckNum
			FROM ut_incremented_number
			WHERE ut_incremented_number.number_type = 'CHECK-MAX';
		If SQLCA.SQLCODE = -1 Then
			MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
			Return
		End If						
		If IsNull(s_lCheckNum) Then s_lCheckNum = 0						
		s_lCheckNum ++

		dw_detail.SetItem(s_iRow,"check_number", 0)		
		dw_detail.SetItem(s_iRow,"amount_paid", i_dFeeAmtRcvd)																			
//		dw_detail.SetItem(s_iRow,"disbursement_note", "")																			
		dw_detail.SetItem(s_iRow,"balance_disbursed", 0)							
										
		dw_detail.SetRedraw(False)
		dw_detail.Modify("date_paid.background.color = " + s_achDWColor + & 
			" date_paid.tabsequence = 2" + &						
			" last_name.background.color = " + s_achDWColor + & 
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

event ue_delete;// script variables
string s_achErrText, s_achCBType, s_achFeeType, s_achDisbursedType
integer s_iCount, s_iRow, s_iDockYear, s_iCBRecYear, s_iCBDisYear, s_iFeeNum
long s_lDockNum, s_lCBRecNum, s_lCBDisNum, s_lDisbursementRows, s_lCount, s_lDisbCount
decimal {2} s_dAmtRcvd

datastore lds_DisburseFeePaid

// allocate the resources for the datastores
lds_DisburseFeePaid = Create DataStore
			
lds_DisburseFeePaid.DataObject = 'dw_del_docket_disburse_fee_paid_ds'
lds_DisburseFeePaid.SetTransObject(SQLCA)

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

dw_scan.enabled = False			
Choose Case dw_detail.DataObject
	Case "dw_docket_receipts_detail"
		
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
		   If 2 = MessageBox("Delete","Delete This ENTIRE Docket Receipt?",Question!,YesNo!,2) Then
		      MessageBox("Delete","Docket Receipt NOT Deleted",None!)
		   Else
		
				SetPointer(Hourglass!) 
				
				i_iRow = dw_detail.GetRow()				
				s_achCBType = Trim(dw_detail.getItemString(i_iRow,"cb_type"))
				s_iDockYear = dw_detail.GetItemNumber(i_iRow,"docket_year")				
				s_lDockNum = dw_detail.GetItemNumber(i_iRow,"docket_number")								
				s_iCBRecYear = dw_detail.GetItemNumber(i_iRow,"cbrec_year")				
				s_lCBRecNum = dw_detail.GetItemNumber(i_iRow,"cbrec_number")								

				// Retrieve fee paid items attached to the receipt
				s_lDisbursementRows = lds_DisburseFeePaid.Retrieve("D", s_iCBRecYear, s_lCBRecNum, "O")
				//messagebox("rows",s_lDisbursementRows)
				For s_lCount = 1 To s_lDisbursementRows

					s_iFeeNum = lds_DisburseFeePaid.GetItemNumber(s_lCount,"fee_number")
					If IsNull(s_iFeeNum) Then s_iFeeNum = 0
							
					s_achFeeType = Trim(lds_DisburseFeePaid.GetItemString(s_lCount,"fee_type"))
					If IsNull(s_achFeeType) Then s_achFeeType = ""

					SELECT disbursed_type INTO :s_achDisbursedType
						FROM ut_codes
						WHERE ut_codes.code_type = 'FEE'
						AND ut_codes.code = :s_achFeeType;
					If IsNull(s_achDisbursedType) Then s_achDisbursedType = ""
							
					s_dAmtRcvd = lds_DisburseFeePaid.GetItemNumber(s_lCount,"amount_received")
					If IsNull(s_dAmtRcvd) Then s_dAmtRcvd = 0

					s_iCBDisYear = lds_DisburseFeePaid.GetItemNumber(s_lCount,"cbdis_year")
					If IsNull(s_iCBDisYear) Then s_iCBDisYear = 0

					s_lCBDisNum = lds_DisburseFeePaid.GetItemNumber(s_lCount,"cbdis_number")
					If IsNull(s_lCBDisNum) Then s_lCBDisNum = 0

					If s_achDisbursedType = "O" Then
						
						// Check Number of Receipts on Disbursement
						s_lDisbCount = 0
						SELECT Count(*) 
							INTO :s_lDisbCount
							FROM sh_docket_fee_paid
							WHERE sh_docket_fee_paid.cb_type = 'D'
								AND sh_docket_fee_paid.docket_year = :s_iDockYear
								AND sh_docket_fee_paid.docket_number = :s_lDockNum					
								AND sh_docket_fee_paid.cbdis_year = :s_iCBDisYear
								AND sh_docket_fee_paid.cbdis_number = :s_lCBDisNum;
						If IsNull(s_lDisbCount) Then s_lDisbCount = 0
						
						// Delete if only one receipt on disb, else update disb
						If s_lDisbCount <= 1 Then
							DELETE sh_docket_disbursement
								WHERE sh_docket_disbursement.cb_type = 'D'
								AND sh_docket_disbursement.docket_year = :s_iDockYear
								AND sh_docket_disbursement.docket_number = :s_lDockNum					
								AND sh_docket_disbursement.cbdis_year = :s_iCBDisYear
								AND sh_docket_disbursement.cbdis_number = :s_lCBDisNum;							
							// error check
							If SQLCA.SQLCode = -1 Then
								MessageBox("System Error","Disbursement Delete Error - " + SQLCA.SQLErrText)
								ROLLBACK;
							Else
								COMMIT;
							End If	
						Else
							UPDATE sh_docket_disbursement
								SET sh_docket_disbursement.amount_paid =
									sh_docket_disbursement.amount_paid - :s_dAmtRcvd
								WHERE sh_docket_disbursement.cb_type = 'D'
								AND sh_docket_disbursement.docket_year = :s_iDockYear
								AND sh_docket_disbursement.docket_number = :s_lDockNum					
								AND sh_docket_disbursement.cbdis_year = :s_iCBDisYear
								AND sh_docket_disbursement.cbdis_number = :s_lCBDisNum;							
							// error check
							If SQLCA.SQLCode = -1 Then
								MessageBox("System Error","Disbursement Update Error - " + SQLCA.SQLErrText)
								ROLLBACK;
							Else
								COMMIT;
							End If									
						End If	
				
					Else
						
						UPDATE sh_docket_disbursement
							SET sh_docket_disbursement.amount_paid =
								sh_docket_disbursement.amount_paid - :s_dAmtRcvd
							WHERE sh_docket_disbursement.cb_type = 'D'
							AND sh_docket_disbursement.cbdis_year = :s_iCBDisYear
							AND sh_docket_disbursement.cbdis_number = :s_lCBDisNum;							
						// error check
						If SQLCA.SQLCode = -1 Then
							MessageBox("System Error","Disbursement Update Error - " + SQLCA.SQLErrText)
							ROLLBACK;
						Else
							COMMIT;
						End If								
					End If

					UPDATE sh_docket_fee
						SET sh_docket_fee.balance_due =
							sh_docket_fee.balance_due + :s_dAmtRcvd,
							sh_docket_fee.amount_received = 
							sh_docket_fee.amount_received - :s_dAmtRcvd							
						WHERE sh_docket_fee.cb_type = 'D'
						AND sh_docket_fee.docket_year = :s_iDockYear
						AND sh_docket_fee.docket_number = :s_lDockNum
						AND sh_docket_fee.fee_number = :s_iFeeNum;
					// error check
					If SQLCA.SQLCode = -1 Then
						MessageBox("System Error","Docket Fee Update Error - " + SQLCA.SQLErrText)
						ROLLBACK;
					Else
						COMMIT;
					End If								
				Next


				DELETE FROM sh_docket_fee_paid
					WHERE sh_docket_fee_paid.cb_type = :s_achCBType
					AND sh_docket_fee_paid.docket_year = :s_iDockYear
					AND sh_docket_fee_paid.docket_number = :s_lDockNum					
					AND sh_docket_fee_paid.cbrec_year = :s_iCBRecYear
					AND sh_docket_fee_paid.cbrec_number = :s_lCBRecNum;																				
				If SQLCA.SQLCode = -1 Then
					s_achErrText = SQLCA.SQLErrText
					ROLLBACK;
					MessageBox("Error", "Docket Receipt Fee Paid Delete Failed - " + s_achErrText)
				Else
					COMMIT;
				End If					

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

event ue_back;call super::ue_back;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_docket_receipts_detail"

		cb_first.enabled = False							
		m_main.m_general.m_first.enabled = False		
		cb_back.enabled = False									
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False									
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False									
		m_main.m_general.m_last.enabled = False

		Return

	Case "dw_docket_receipt_fee_paid_scan"
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

dw_detail.SetFocus()
end event

event ue_first;call super::ue_first;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_docket_receipts_detail"
		
		cb_first.enabled = False							
		m_main.m_general.m_first.enabled = False		
		cb_back.enabled = False									
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False									
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False									
		m_main.m_general.m_last.enabled = False
		
		Return

	Case "dw_docket_receipt_fee_paid_scan"

		Choose Case dw_detail.GetRow()
			Case 0, 1 // not on a row. set it to the first row
				If dw_detail.RowCount() = 0 Then
					cb_first.enabled = True
					m_main.m_general.m_first.enabled = True
					cb_back.enabled = True
					m_main.m_general.m_back.enabled = True
					cb_next.enabled = True					
					m_main.m_general.m_next.enabled = True
					cb_last.enabled = True
					m_main.m_general.m_last.enabled = True
					
					Beep(1)
					Return
						
				Else
					cb_first.enabled = True
					m_main.m_general.m_first.enabled = True
					cb_back.enabled = True
					m_main.m_general.m_back.enabled = True
					cb_next.enabled = True					
					m_main.m_general.m_next.enabled = True
					cb_last.enabled = True
					m_main.m_general.m_last.enabled = True

					dw_detail.SetRow(1)
					dw_detail.SetColumn(1)
					dw_detail.ScrollToRow(1)
				End If			
		
			Case Else // not on the first row, so first goes to the first row
				cb_first.enabled = True
				m_main.m_general.m_first.enabled = True
				cb_back.enabled = True
				m_main.m_general.m_back.enabled = True
				cb_next.enabled = True					
				m_main.m_general.m_next.enabled = True
				cb_last.enabled = True
				m_main.m_general.m_last.enabled = True
				
				dw_detail.SetRow(1)
				dw_detail.SetColumn(1)
				dw_detail.ScrollToRow(1)		
		End Choose

End Choose
	
dw_detail.SetFocus()	




end event

event ue_last;call super::ue_last;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_docket_receipts_detail"
		
		cb_first.enabled = False					
		m_main.m_general.m_first.enabled = False					
		cb_back.enabled = False		
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False		
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False
		m_main.m_general.m_last.enabled = False
		
		Return
		
	Case "dw_docket_receipt_fee_paid_scan"		

		Choose Case dw_detail.GetRow()
		
			Case 0 // not on a row. set it to the first row
				If dw_detail.RowCount() = 0 Then
					
					cb_first.enabled = False					
					m_main.m_general.m_first.enabled = False					
					cb_back.enabled = False		
					m_main.m_general.m_back.enabled = False
					cb_next.enabled = False		
					m_main.m_general.m_next.enabled = False
					cb_last.enabled = False
					m_main.m_general.m_last.enabled = False
					
					Return
				
				Else
					cb_first.enabled = True										
					m_main.m_general.m_first.enabled = True					
					cb_back.enabled = True					
					m_main.m_general.m_back.enabled = True
					cb_next.enabled = True					
					m_main.m_general.m_next.enabled = True
					cb_last.enabled = True
					m_main.m_general.m_last.enabled = True

					dw_detail.SetRow(1)
					dw_detail.SetColumn(1)
					dw_detail.ScrollToRow(1)
				End If
				
			Case dw_detail.RowCount() // last item row
				cb_first.enabled = True										
				m_main.m_general.m_first.enabled = True					
				cb_back.enabled = True					
				m_main.m_general.m_back.enabled = True
				cb_next.enabled = True					
				m_main.m_general.m_next.enabled = True
				cb_last.enabled = True
				m_main.m_general.m_last.enabled = True
				
				Beep(1)
				Return
				
			Case Else // not on the last row, so next goes to the next row
				cb_first.enabled = True										
				m_main.m_general.m_first.enabled = True					
				cb_back.enabled = True					
				m_main.m_general.m_back.enabled = True
				cb_next.enabled = True					
				m_main.m_general.m_next.enabled = True
				cb_last.enabled = True
				m_main.m_general.m_last.enabled = True
				
				dw_detail.SetRow(dw_detail.RowCount())
				dw_detail.SetColumn(1)
				dw_detail.ScrollToRow(dw_detail.GetRow())
	
		End Choose
				
End Choose
	
dw_detail.SetFocus()	


end event

event ue_next;call super::ue_next;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_docket_receipts_detail"
		
		cb_first.enabled = False					
		m_main.m_general.m_first.enabled = False					
		cb_back.enabled = False
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False		
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False		
		m_main.m_general.m_last.enabled = False

		Return
		
	Case "dw_docket_receipt_fee_paid_scan"				
		
		Choose Case dw_detail.GetRow()
			Case 0 // not on a row. set it to the first row
				
				If dw_detail.RowCount() = 0 Then

					cb_first.enabled = False					
					m_main.m_general.m_first.enabled = False					
					cb_back.enabled = False
					m_main.m_general.m_back.enabled = False
					cb_next.enabled = False		
					m_main.m_general.m_next.enabled = False
					cb_last.enabled = False		
					m_main.m_general.m_last.enabled = False
			
					Return
				
				Else
					cb_first.enabled = True					
					m_main.m_general.m_first.enabled = True					
					cb_back.enabled = True
					m_main.m_general.m_back.enabled = True
					cb_next.enabled = True					
					m_main.m_general.m_next.enabled = True
					cb_last.enabled = True					
					m_main.m_general.m_last.enabled = True

					dw_detail.SetRow(1)
					dw_detail.SetColumn(1)
					dw_detail.ScrollToRow(1)
				End If
				
			Case dw_detail.RowCount() // last row
				cb_first.enabled = True					
				m_main.m_general.m_first.enabled = True					
				cb_back.enabled = True
				m_main.m_general.m_back.enabled = True
				cb_next.enabled = True					
				m_main.m_general.m_next.enabled = True
				cb_last.enabled = True					
				m_main.m_general.m_last.enabled = True
				
				Beep(1)
				Return
				
			Case Else // not on the last row, so next goes to the next row
				cb_first.enabled = True					
				m_main.m_general.m_first.enabled = True					
				cb_back.enabled = True
				m_main.m_general.m_back.enabled = True
				cb_next.enabled = True					
				m_main.m_general.m_next.enabled = True
				cb_last.enabled = True					
				m_main.m_general.m_last.enabled = True
				
				dw_detail.SetRow(dw_detail.GetRow() + 1)
				dw_detail.SetColumn(1)
				dw_detail.ScrollToRow(dw_detail.GetRow())
	
		End Choose
		
End Choose
	
dw_detail.SetFocus()	

end event

event resize;gnv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
end event

type cb_escape from w_base_sheet`cb_escape within w_docket_receipts_sheet
integer taborder = 250
end type

type cb_exit from w_base_sheet`cb_exit within w_docket_receipts_sheet
integer taborder = 260
end type

type cb_last from w_base_sheet`cb_last within w_docket_receipts_sheet
integer taborder = 240
end type

type cb_next from w_base_sheet`cb_next within w_docket_receipts_sheet
integer taborder = 230
end type

type cb_back from w_base_sheet`cb_back within w_docket_receipts_sheet
integer taborder = 220
end type

type cb_first from w_base_sheet`cb_first within w_docket_receipts_sheet
integer taborder = 210
end type

type cb_save from w_base_sheet`cb_save within w_docket_receipts_sheet
integer taborder = 180
end type

type cb_delete from w_base_sheet`cb_delete within w_docket_receipts_sheet
integer taborder = 170
end type

type cb_update from w_base_sheet`cb_update within w_docket_receipts_sheet
integer taborder = 150
end type

type cb_add from w_base_sheet`cb_add within w_docket_receipts_sheet
integer taborder = 120
end type

type cb_new from w_base_sheet`cb_new within w_docket_receipts_sheet
integer taborder = 70
end type

type cb_clear from w_base_sheet`cb_clear within w_docket_receipts_sheet
integer taborder = 60
end type

type cb_search from w_base_sheet`cb_search within w_docket_receipts_sheet
integer taborder = 50
end type

type dw_detail from w_base_sheet`dw_detail within w_docket_receipts_sheet
event ue_dwnkey pbm_dwnkey
event ue_continue_add pbm_custom13
event ue_rowfocus pbm_custom14
integer y = 800
integer width = 3090
integer height = 1021
string dataobject = "dw_docket_receipts_detail"
end type

event dw_detail::ue_dwnkey;
string s_achDWColor, s_achCBType, s_achDisbursedType, s_achFeeType
integer s_iRow, s_iCount, s_lCount, s_iDockYear, s_iCBRecYear, s_iFeeNum, s_iMaxFeeNum
long s_lDockNum, s_lCBRecNum
decimal {2} s_dAmtRec

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_docket_receipts_detail"
		
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "total_received"
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
				dw_detail.Modify("docket_year.background.color = " + s_achDWColor + & 
					" docket_year.tabsequence = 0" + &							
					" docket_number.background.color = " + s_achDWColor + & 
					" docket_number.tabsequence = 0" + &									
				   " receipt_number.background.color = " + s_achDWColor + & 
					" receipt_number.tabsequence = 0" + &			
					" date_received.background.color = " + s_achDWColor + & 
					" date_received.tabsequence = 0" + &						
					" judgment_receipt.background.color = " + s_achDWColor + & 
					" judgment_receipt.tabsequence = 0" + &											
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

				s_iRow = dw_scan.GetRow()
	
				s_achCBType = Trim(dw_scan.GetItemString(s_iRow,"cb_type"))	
				s_iDockYear = dw_scan.GetItemNumber(s_iRow,"docket_year")
				s_lDockNum = dw_scan.GetItemNumber(s_iRow,"docket_number")
				i_iCBRecYear = dw_scan.GetItemNumber(s_iRow,"cbrec_year")
				i_lCBRecNum = dw_scan.GetItemNumber(s_iRow,"cbrec_number")
	
				SELECT total_received 
					INTO :i_dTotRec
					FROM sh_docket_receipt
					WHERE cb_type = 'D'
						AND cbrec_year = :i_iCBRecYear
						AND cbrec_number = :i_lCBRecNum;
				If IsNull(i_dTotRec) Then i_dTotRec = 0
			
				SELECT SUM(amount_received)
					INTO :s_dAmtRec
					FROM sh_docket_fee_paid
					WHERE cb_type = 'D'
						AND cbrec_year = :i_iCBRecYear
						AND cbrec_number = :i_lCBRecNum;
				If IsNull(s_dAmtRec) Then s_dAmtRec = 0
				
				st_message.text = "Receipt Total:" + string(i_dTotRec,'#,##0.00') + &
					"                        " + &
					"Receipt Balance:" + string(s_dAmtRec,'#,##0.00')
	
				dw_detail.Retrieve(s_achCBType, s_iDockYear, s_lDockNum, i_iCBRecYear, i_lCBRecNum)
			
				dw_scan.enabled = True
			
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
	
				cb_main.enabled = False
				cb_disburse_info.enabled = True				
				cb_disburse.enabled = True
	
				cb_escape.enabled = False
				m_main.m_general.m_escape.enabled = False
				cb_save.enabled = False
				m_main.m_general.m_save.enabled = False
				i_bContinueItem = True
				
				dw_scan.SetFocus()
			End If
		End If		

	Case "dw_docket_receipt_fees_scan"

		s_iRow = dw_detail.GetRow()
		s_iFeeNum = dw_detail.GetItemNumber(s_iRow,"fee_number")
		s_achFeeType = Trim(dw_detail.GetItemString(s_iRow,"fee_type"))			
		s_achCBType = Trim(dw_detail.GetItemString(s_iRow,"cb_type"))	
		s_iDockYear = dw_detail.GetItemNumber(s_iRow,"docket_year")
		s_lDockNum = dw_detail.GetItemNumber(s_iRow,"docket_number")				

		SELECT disbursed_type INTO :s_achDisbursedType
			FROM ut_codes
			WHERE ut_codes.code_type = 'FEE'
			AND ut_codes.code = :i_achFeeType;
		If IsNull(s_achDisbursedType) Then s_achDisbursedType = ""
				
		SELECT MAX(fee_number) INTO :s_iMaxFeeNum
			FROM sh_docket_fee
			WHERE cb_type = :s_achCBType
			AND docket_year = :s_iDockYear			
			AND docket_number = :s_lDockNum;			
				
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "fee_end" 

				If s_iFeeNum = s_iMaxFeeNum Or &
					(s_achDisbursedType = "O") Then
					i_bNew = False
					If KeyDown(KeyEnter!) Or KeyDown(KeyTab!) Then		
						parent.TriggerEvent("ue_save")
						Return
					End If
				End If
	
		End Choose 

		If i_achMode = "Continue" Then
			If KeyDown(KeyEscape!) Then
				i_bContinueItem = False
				i_bNew = False				
				
				dw_detail.SetRedraw(False)		
				dw_detail.Modify("amount_received.background.color = " + s_achDWColor + & 
					" amount_received.tabsequence = 0" + &
    			   " fee_end.background.color = " + s_achDWColor + & 
					" fee_end.tabsequence = 0")									
				dw_detail.SetRedraw(True)			
				
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

				If i_achOpType = "Add" Then
					dw_detail.PostEvent("ue_continue_add")
				End If
				
			End If
		End If		

End Choose

end event

event dw_detail::ue_continue_add;integer s_iRow

If i_bContinueItem = True Then
	
	If i_achMode = "Continue" And i_bNew = True Then	
		dw_detail.DataObject = "dw_docket_receipt_fee_paid_scan"
		dw_detail.SetTransObject(SQLCA)								
	
		m_main.m_general.m_add.TriggerEvent("clicked")
	End If

Else
/*
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
*/
	If i_achMode = "Continue" And i_bButtonOnly And i_bNew = True Then
		If i_achOpType = "Add" Then
			dw_detail.DataObject = "dw_docket_receipts_detail"
			dw_detail.SetTransObject(SQLCA)								
			cb_main.PostEvent("clicked")
			i_bNew = False
			Return
		End If	
	End If				
	
	If i_achMode = "Continue" Then
		If i_achOpType = "Add" Then
			dw_detail.DataObject = "dw_docket_receipts_detail"
			dw_detail.SetTransObject(SQLCA)
					
			m_main.m_general.m_new.PostEvent("clicked")
		End If	
	End If									

End If

end event

event dw_detail::itemchanged;// script variables
datawindowchild dwc
integer s_iRow, s_iFeePaidCount, s_iFeeCount, s_iCount
integer s_iFeePaidCount2, s_iDCount, s_iPeriodNum, s_iCBDisYear
long s_lTransNum, s_lCBDisNum
decimal {2} s_dFeePaidAmtRec, s_dFeeBalanceDue, s_dOrigAmountRec, s_dOverpayment
decimal {2} s_dTotalReceived, s_dAmountDue
integer s_iYear, s_iMonth, s_iDay
string s_achRcvdDate
date s_dtRecDate, s_dtRcvdDate
datetime s_dtRecDateTime
string s_achFeeType, s_achCaseNum, s_achDoc, s_achDisbursedType, s_achWhomDue
decimal {2} s_dtotrec, s_damtrec, s_dcurrbal, s_dFeeTot

s_iRow = dw_detail.GetRow()
//i_iDockYear = dw_detail.GetItemNumber(s_iRow, "docket_year")
//i_lDockNum = dw_detail.GetItemNumber(s_iRow, "docket_number")
//i_iCBRecYear = dw_detail.GetItemNumber(s_iRow, "cbrec_year")
//i_lCBRecNum = dw_detail.GetItemNumber(s_iRow, "cbrec_number")

dw_detail.SetTransObject(SQLCA)
dw_detail.AcceptText()
Choose Case dw_detail.DataObject
		
	Case "dw_docket_receipts_detail"

		Choose Case this.GetColumnName()

			// getcolumnname always returns lower case letters
			
			Case "docket_number"
				
				If i_achOpType = "Add" Then
				
					i_lDockNum = Long(data)
					i_iDockYear = dw_detail.GetItemNumber(s_iRow,"docket_year")															
					
					SELECT COUNT(*) INTO :s_iDCount
						FROM sh_docket
						WHERE sh_docket.docket_year = :i_iDockYear
						AND sh_docket.docket_number = :i_lDockNum;
					If s_iDCount = 0 Then
						MessageBox("Docket Receipt Error", "Docket " + String(i_iDockYear) + &
							"-" + String(i_lDockNum) + " NOT FOUND!--Re-Enter")						
						Return
					End If
					
	//				messagebox("case",s_achCaseNum)
					SELECT case_number INTO :i_achCaseNum
						FROM sh_docket
						WHERE sh_docket.docket_year = :i_iDockYear						
						AND sh_docket.docket_number = :i_lDockNum;
					dw_detail.SetItem(s_iRow,"case_number", i_achCaseNum)											
	
					SELECT SUM(balance_due) INTO :s_dFeeTot
						FROM sh_docket_fee
						WHERE cb_type = 'D'
						AND docket_year = :i_iDockYear
						AND docket_number = :i_lDockNum
						AND balance_due > 0;						
					If IsNull(s_dFeeTot) Then s_dFeeTot = 0
					dw_detail.SetItem(s_iRow,"total_received", s_dFeeTot)															
//					dw_detail.Update()					
				End If		
		
			Case "date_received"
				
				s_achRcvdDate = Trim(data)
				s_achRcvdDate = Left((data),10)

				s_iYear = Integer(Mid(s_achRcvdDate,1,4))
				s_iMonth = Integer(Mid(s_achRcvdDate,6,2))
				s_iDay = Integer(Mid(s_achRcvdDate,9,2))
				s_dtRcvdDate = Date(s_iYear,s_iMonth,s_iDay)			
				
				If s_dtRcvdDate > g_dtToday Then
					MessageBox("Date Received Information","Date Received CANNOT be Future Date!")
					dw_detail.SetItem(s_iRow,"date_received", "")														
					dw_detail.Update()
					COMMIT;		
					
					Return
				End If
		
		End Choose  // field "case number"
	
	Case "dw_docket_receipt_fees_scan"

		s_iRow = dw_detail.GetRow()
		
		i_achFeeType = Trim(dw_detail.GetItemString(s_iRow, "fee_type"))
		i_iFeeNum = dw_detail.GetItemNumber(s_iRow, "fee_number")		
		s_dOrigAmountRec = dw_detail.GetItemNumber(s_iRow, "amount_received", Primary!, True)
		If IsNull(s_dOrigAmountRec) Then s_dOrigAmountRec = 0
//		messagebox("row", s_irow)				
		Choose Case this.GetColumnName()

			// getcolumnname always returns lower case letters
			
			Case "amount_received"

				i_dFeeAmtRcvd = Dec(data)
				i_bUpdateFee = False

				// Added to get the docket received date--02/11/2008
				SELECT date_received INTO :s_dtRecDateTime
					FROM sh_docket_receipt
					WHERE sh_docket_receipt.cb_type = 'D'
					AND sh_docket_receipt.docket_year = :i_iDockYear
					AND sh_docket_receipt.docket_number = :i_lDockNum					
					AND sh_docket_receipt.cbrec_year = :i_iCBRecYear
					AND sh_docket_receipt.cbrec_number = :i_lCBRecNum;
				i_dtRecDate = Date(s_dtRecDateTime)
				
				SELECT COUNT(*) INTO :s_iFeePaidCount
					FROM sh_docket_fee_paid
					WHERE sh_docket_fee_paid.cb_type = 'D'
					AND sh_docket_fee_paid.docket_year = :i_iDockYear
					AND sh_docket_fee_paid.docket_number = :i_lDockNum					
					AND sh_docket_fee_paid.fee_number = :i_iFeeNum
					AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
					AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum;
				If s_iFeePaidCount = 0 Then
//				messagebox("not found chg", s_damountrec)									
					// Not Found
					INSERT INTO sh_docket_fee_paid 
						(cb_type, docket_number, docket_year, fee_number, cbrec_year, 
						cbrec_number, amount_received, date_received, new_balance_disbursed,
						new_amount_disbursed, receipt_status)
						VALUES 
						('D', :i_lDockNum, :i_iDockYear, :i_iFeeNum, :i_iCBRecYear, 
						:i_lCBRecNum, :i_dFeeAmtRcvd, :i_dtRecDate, :i_dFeeAmtRcvd,
						0, 'O');
					// error check
					If SQLCA.SQLCode = -1 Then
						MessageBox("System Error","here Fee Paid Insert Error - " + SQLCA.SQLErrText)
						ROLLBACK;
					Else
						COMMIT;
					End If	
//messagebox("1st amt",i_dFeeAmtRcvd)											
					s_dFeeBalanceDue = dw_detail.GetItemNumber(s_iRow, "balance_due")
		    		i_dFeeAmtRcvd = Dec(data)					
					s_dFeeBalanceDue = s_dFeeBalanceDue - i_dFeeAmtRcvd
					dw_detail.SetItem(s_iRow,"balance_due", s_dFeeBalanceDue)						
					dw_detail.Update()
					COMMIT;
										
//messagebox("fee bal",s_dFeeBalanceDue)					
//messagebox("amt",i_dFeeAmtRcvd)							
					If s_dFeeBalanceDue < 0 Then
						s_dOverpayment = - s_dFeeBalanceDue
						If 1 = MessageBox("Overpayment 1","The fee has been overpaid by " + String(s_dOverpayment) + ".  Record the overpayment as fee type OP(Overpayment)?", Question!, YesNo!, 1) Then
							i_dFeeAmtRcvd = Dec(data)												
							s_dFeeBalanceDue = s_dFeeBalanceDue + s_dOverpayment
							dw_detail.SetItem(s_iRow,"balance_due", s_dFeeBalanceDue)														
							dw_detail.Update()							
							COMMIT;							
//messagebox("b4 fee - op",i_dFeeAmtRcvd)							
							i_dFeeAmtRcvd = i_dFeeAmtRcvd - s_dOverpayment
//messagebox("fee",i_dFeeAmtRcvd)
							UPDATE sh_docket_fee_paid
								SET sh_docket_fee_paid.amount_received =
									sh_docket_fee_paid.amount_received - :s_dOverpayment,
									sh_docket_fee_paid.new_balance_disbursed = :i_dFeeAmtRcvd,
									sh_docket_fee_paid.new_amount_disbursed = 0
								WHERE sh_docket_fee_paid.cb_type = 'D'
								AND sh_docket_fee_paid.docket_year = :i_iDockYear
								AND sh_docket_fee_paid.docket_number = :i_lDockNum					
								AND sh_docket_fee_paid.fee_number = :i_iFeeNum
								AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
								AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum;							
							// error check
							If SQLCA.SQLCode = -1 Then
								MessageBox("System Error","Fee Paid 2 Update Error - " + SQLCA.SQLErrText)
								ROLLBACK;
							Else
								COMMIT;
							End If								
							dw_detail.SetItem(s_iRow,"amount_received", i_dFeeAmtRcvd)														
							dw_detail.Update()
							COMMIT;		
		
							SELECT COUNT(*) INTO :s_iFeeCount
								FROM sh_docket_fee
								WHERE sh_docket_fee.cb_type = 'D'
								AND sh_docket_fee.docket_year = :i_iDockYear
								AND sh_docket_fee.docket_number = :i_lDockNum					
								AND sh_docket_fee.fee_number = 99;
							If s_iFeeCount = 0 Then	
								INSERT INTO sh_docket_fee 
									(cb_type, docket_number, docket_year, fee_number, 
									fee_type, fee_amount, balance_due,  amount_received)
									VALUES 
									('D', :i_lDockNum, :i_iDockYear, 99, 
									'OP', :s_dOverpayment, :s_dOverpayment, 0);
								// error check
								If SQLCA.SQLCode = -1 Then
									MessageBox("System Error","Fee Overpayment Insert Error - " + SQLCA.SQLErrText)
									ROLLBACK;
								Else
									COMMIT;
								End If										

								INSERT INTO sh_docket_fee_paid 
									(cb_type, docket_number, docket_year, fee_number, 
									cbrec_year, cbrec_number, amount_received, date_received, 
									new_balance_disbursed, new_amount_disbursed, receipt_status )
									VALUES 
									('D', :i_lDockNum, :i_iDockYear, 99, 
									:i_iCBRecYear, :i_lCBRecNum, :s_dOverpayment, :i_dtRecDate,
									:s_dOverpayment, 0, 'O');
								// error check
								If SQLCA.SQLCode = -1 Then
									MessageBox("System Error","Fee Paid Overpayment Insert Error - " + SQLCA.SQLErrText)
									ROLLBACK;
								Else
									COMMIT;
								End If	

								// get Fee Type
								dw_detail.GetChild("fee_type", dwc)
								dwc.SetTransObject(SQLCA)
								dwc.Reset()
								dwc.Retrieve("FEE")
							
								dw_detail.Retrieve("D", i_iDockYear, i_lDockNum)		
								dw_detail.SetRowFocusIndicator(Hand!)
							
							Else // no overpaymnt

								s_dAmountDue = Dec(data)										
								s_dAmountDue = s_dAmountDue + s_dOverpayment
								dw_detail.SetItem(i_iRow, "fee_amount", s_dAmountDue)
								dw_detail.Update()
								COMMIT;
										
											
								SELECT COUNT(*) INTO :s_iFeePaidCount2
									FROM sh_docket_fee_paid
									WHERE sh_docket_fee_paid.cb_type = 'D'
									AND sh_docket_fee_paid.docket_year = :i_iDockYear
									AND sh_docket_fee_paid.docket_number = :i_lDockNum					
									AND sh_docket_fee_paid.fee_number = 99
									AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
									AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum																	
									AND sh_docket_fee_paid.date_received = :i_dtRecDate;																	
								If s_iFeePaidCount2 = 0 Then 											
									
									INSERT INTO sh_docket_fee_paid 
										(cb_type, docket_number, docket_year, fee_number, 
										cbrec_year, cbrec_number, amount_received, date_received,
										new_balance_disbursed, new_amount_disbursed, receipt_status)
										VALUES 
										('D', :i_lDockNum, :i_iDockYear, 99, 
										:i_iCBRecYear, :i_lCBRecNum, :s_dOverpayment, :i_dtRecDate,
										:s_dOverpayment, 0, 'O');
									// error check
									If SQLCA.SQLCode = -1 Then
										MessageBox("System Error","Fee Paid Overpayment 2 Insert Error - " + SQLCA.SQLErrText)
										ROLLBACK;
									Else
										COMMIT;
									End If	

								Else

									i_dFeeAmtRcvd = i_dFeeAmtRcvd + s_dOverpayment
									UPDATE sh_docket_fee_paid
										SET sh_docket_fee_paid.date_received = :i_dtRecDate,
											sh_docket_fee_paid.amount_received = :i_dFeeAmtRcvd,
											sh_docket_fee_paid.new_balance_disbursed = :i_dFeeAmtRcvd,
											sh_docket_fee_paid.new_amount_disbursed = 0
										WHERE sh_docket_fee_paid.cb_type = 'D'
										AND sh_docket_fee_paid.docket_year = :i_iDockYear
										AND sh_docket_fee_paid.docket_number = :i_lDockNum					
										AND sh_docket_fee_paid.fee_number = :i_iFeeNum
										AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
										AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum;							
									// error check
									If SQLCA.SQLCode = -1 Then
										MessageBox("System Error","Fee Paid Overpayment Update Error - " + SQLCA.SQLErrText)
										ROLLBACK;
									Else
										COMMIT;
									End If								
										
								End If // fee paid
							End If
						End If // 
					End If // Overpayment				
//messagebox("fee end",i_dFeeAmtRcvd)			
				Else	
					
					// Found Fee Paid Record
					i_dFeeAmtRcvd = Dec(data)
					i_bUpdateFee = True					
					SELECT date_received INTO :s_dtRecDateTime
						FROM sh_docket_receipt
						WHERE sh_docket_receipt.cb_type = 'D'
						AND sh_docket_receipt.docket_year = :i_iDockYear
						AND sh_docket_receipt.docket_number = :i_lDockNum					
						AND sh_docket_receipt.cbrec_year = :i_iCBRecYear
						AND sh_docket_receipt.cbrec_number = :i_lCBRecNum;					
//				messagebox("found chg", s_damountrec)														
					s_dtRecDate = i_dtRecDate
					
					s_dFeeBalanceDue = dw_detail.GetItemNumber(s_iRow, "balance_due")
					s_dFeeBalanceDue = s_dFeeBalanceDue + (s_dOrigAmountRec - i_dFeeAmtRcvd)
					dw_detail.SetItem(s_iRow,"balance_due", s_dFeeBalanceDue)
					dw_detail.Update()
					COMMIT;
					
//			messagebox("",	string(s_dFeeBalanceDue) + " " + string(s_dOrigAmountRec) + " " + string(i_dFeeAmtRcvd))
					UPDATE sh_docket_fee_paid
						SET sh_docket_fee_paid.date_received = :i_dtRecDate,
							 sh_docket_fee_paid.amount_received = :i_dFeeAmtRcvd,
							 sh_docket_fee_paid.new_balance_disbursed = :i_dFeeAmtRcvd
						WHERE sh_docket_fee_paid.cb_type = 'D'
						AND sh_docket_fee_paid.docket_year = :i_iDockYear
						AND sh_docket_fee_paid.docket_number = :i_lDockNum					
						AND sh_docket_fee_paid.fee_number = :i_iFeeNum
						AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
						AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum;							
					// error check
					If SQLCA.SQLCode = -1 Then
						MessageBox("System Error","Fee Paid Update Error - " + SQLCA.SQLErrText)
						ROLLBACK;
					Else
						COMMIT;
					End If	
					If s_dFeeBalanceDue < 0 Then
						s_dOverpayment = - s_dFeeBalanceDue
						If 1 = MessageBox("Overpayment","The fee has been overpaid by " + String(s_dOverpayment) + ".  Record the overpayment as fee type OP(Overpayment)?", Question!, YesNo!, 1) Then
							i_dFeeAmtRcvd = Dec(data)																			
							s_dFeeBalanceDue = s_dFeeBalanceDue + s_dOverpayment
							dw_detail.SetItem(s_iRow,"balance_due", s_dFeeBalanceDue)														
							dw_detail.Update()
							COMMIT;
					
							i_dFeeAmtRcvd = i_dFeeAmtRcvd - s_dOverpayment
							UPDATE sh_docket_fee_paid
								SET sh_docket_fee_paid.amount_received = :i_dFeeAmtRcvd,
									sh_docket_fee_paid.new_balance_disbursed = :i_dFeeAmtRcvd
								WHERE sh_docket_fee_paid.cb_type = 'D'
								AND sh_docket_fee_paid.docket_year = :i_iDockYear
								AND sh_docket_fee_paid.docket_number = :i_lDockNum					
								AND sh_docket_fee_paid.fee_number = :i_iFeeNum
								AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
								AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum;							
							// error check
							If SQLCA.SQLCode = -1 Then
								MessageBox("System Error","Fee Paid 2 Update Error - " + SQLCA.SQLErrText)
								ROLLBACK;
							Else
								COMMIT;
							End If								
							
							SELECT COUNT(*) INTO :s_iFeeCount
								FROM sh_docket_fee
								WHERE sh_docket_fee.cb_type = 'D'
								AND sh_docket_fee.docket_year = :i_iDockYear
								AND sh_docket_fee.docket_number = :i_lDockNum					
								AND sh_docket_fee.fee_number = 99;
							If s_iFeeCount = 0 Then

								INSERT INTO sh_docket_fee 
									(cb_type, docket_number, docket_year, fee_number, 
									fee_type, fee_amount, balance_due, amount_received )
									VALUES 
									('D', :i_lDockNum, :i_iDockYear, 0, 99, 
									'OP', :s_dOverpayment, :s_dOverpayment, 0);
								// error check
								If SQLCA.SQLCode = -1 Then
									MessageBox("System Error","Fee Overpayment Insert Error - " + SQLCA.SQLErrText)
									ROLLBACK;
								Else
									COMMIT;
								End If										

								INSERT INTO sh_docket_fee_paid 
									(cb_type, docket_number, docket_year, fee_number, 
									cbrec_year, cbrec_number, amount_received, date_received,
									receipt_status)
									VALUES 
									('D', :i_lDockNum, :i_iDockYear, 99, 
									:i_iCBRecYear, :i_lCBRecNum, :s_dOverpayment, :i_dtRecDate,
									'O');
								// error check
								If SQLCA.SQLCode = -1 Then
									MessageBox("System Error","Fee Paid Overpayment Insert Error - " + SQLCA.SQLErrText)
									ROLLBACK;
								Else
									COMMIT;
								End If	

							Else
								// Fee Found
								s_dAmountDue = dw_detail.GetItemNumber(s_iRow, "amount_due")										
								s_dAmountDue = s_dAmountDue + s_dOverpayment
								dw_detail.SetItem(i_iRow, "fee_amount", s_dAmountDue)
								dw_detail.Update()
								COMMIT;
												
								SELECT COUNT(*) INTO :s_iFeePaidCount2
									FROM sh_docket_fee_paid
									WHERE sh_docket_fee_paid.cb_type = 'D'
									AND sh_docket_fee_paid.docket_year = :i_iDockYear
									AND sh_docket_fee_paid.docket_number = :i_lDockNum					
									AND sh_docket_fee_paid.fee_number = 99
									AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
									AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum																	
									AND sh_docket_fee_paid.date_received = :i_dtRecDate;																	
								If s_iFeePaidCount2 = 0 Then											
									 // Fee Paid Not Found											
									INSERT INTO sh_docket_fee_paid 
										(cb_type, docket_number, docket_year, fee_number, 
										cbrec_year, cbrec_number, amount_received, date_received,
										receipt_status)
										VALUES 
										('D', :i_lDockNum, :i_iDockYear, 99, 
										:i_iCBRecYear, :i_lCBRecNum, :s_dOverpayment, :i_dtRecDate,
										'O');
									// error check
									If SQLCA.SQLCode = -1 Then
										MessageBox("System Error","Fee Paid Overpayment 2 Insert Error - " + SQLCA.SQLErrText)
										ROLLBACK;
									Else
										COMMIT;
									End If	

								Else  // Fee Paid Found																					
									i_dFeeAmtRcvd = i_dFeeAmtRcvd + s_dOverpayment
									UPDATE sh_docket_fee_paid
										SET sh_docket_fee_paid.date_received = :i_dtRecDate,
											sh_docket_fee_paid.amount_received = :i_dFeeAmtRcvd,
											sh_docket_fee_paid.new_balance_disbursed = :i_dFeeAmtRcvd
										WHERE sh_docket_fee_paid.cb_type = 'D'
										AND sh_docket_fee_paid.docket_year = :i_iDockYear
										AND sh_docket_fee_paid.docket_number = :i_lDockNum					
										AND sh_docket_fee_paid.fee_number = :i_iFeeNum
										AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
										AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum;							
									// error check
									If SQLCA.SQLCode = -1 Then
										MessageBox("System Error","Fee Paid Overpayment Update Error - " + SQLCA.SQLErrText)
										ROLLBACK;
									Else
										COMMIT;
									End If								
										
								End If // select fee_paid
									
							End If	// select fee
						End If // 
					End If // Overpayment				
				
				End If	// select fee_paid

				SELECT total_received 
					INTO :s_dTotRec
					FROM sh_docket_receipt
					WHERE cb_type = 'D'
						AND cbrec_year = :i_iCBRecYear
						AND cbrec_number = :i_lCBRecNum;
				If IsNull(s_dTotRec) Then s_dTotRec = 0
			
				SELECT SUM(amount_received)
					INTO :s_dAmtRec
					FROM sh_docket_fee_paid
					WHERE cb_type = 'D'
						AND cbrec_year = :i_iCBRecYear
						AND cbrec_number = :i_lCBRecNum;
				If IsNull(s_dAmtRec) Then s_dAmtRec = 0
				
				st_message.text = "Receipt Total:" + string(s_dTotRec,'#,##0.00') + &
					"                        " + &
					"Receipt Balance:" + string(s_dAmtRec,'#,##0.00')	
								
				// Process Disbursement			
				SELECT disbursed_type INTO :s_achDisbursedType
					FROM ut_codes
					WHERE ut_codes.code_type = 'FEE'
					AND ut_codes.code = :i_achFeeType;
				If IsNull(s_achDisbursedType) Then s_achDisbursedType = ""
					
				Choose Case s_achDisbursedType
						
					Case 'O'

						s_achWhomDue = ""
						
						SELECT COUNT(*) INTO :s_iCount
							FROM sh_docket_disbursement
							WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
							AND sh_docket_disbursement.disburse_status = 'O'
							AND sh_docket_disbursement.cb_type = 'D'
							AND sh_docket_disbursement.docket_year = :i_iDockYear																									
							AND sh_docket_disbursement.docket_number = :i_lDockNum
							AND sh_docket_disbursement.fee_type = :i_achFeeType;																																							
						If s_iCount = 0 Then
							
							s_iCBDisYear = Year(g_dtToday)
							SELECT MAX(cbdis_number) INTO :s_lCBDisNum
								FROM sh_docket_disbursement
								WHERE sh_docket_disbursement.cbdis_year = :s_iCBDisYear
								AND sh_docket_disbursement.cb_type = 'D';
							If IsNull(s_lCBDisNum) Then s_lCBDisNum = 0
							s_lCBDisNum ++
//messagebox("cbdis",s_lCBDisNum)		
							INSERT INTO sh_docket_disbursement
								(cb_type, docket_number, docket_year, cbdis_number, cbdis_year,
								 date_paid, amount_paid, check_number, last_name,
								 first_name, middle_name, suffix, whom_due, balance_disbursed,
								 case_number, disburse_status, disburse_date, 
								 disburse_type, fee_type)
							 VALUES ('D', :i_lDockNum, :i_iDockYear, :s_lCBDisNum, :s_iCBDisYear,
								 NULL, :i_dFeeAmtRcvd, 0, :s_achWhomDue,
								 '', '', '', '', :i_dFeeAmtRcvd, 
								 :i_achCaseNum, 'O', :g_dtToday, 
								 :s_achDisbursedType, :i_achFeeType);
							If SQLCA.SQLCODE = -1 Then
								MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
								ROLLBACK;
								Return
							Else
								COMMIT;
							End If				
//messagebox("cbdis",s_lCBDisNum)																			
						Else
							If i_bUpdateFee Then			
// messagebox("",	string(s_dFeeBalanceDue) + " " + string(s_dOrigAmountRec) + " " + string(i_dFeeAmtRcvd))								
								UPDATE sh_docket_disbursement						
									SET balance_disbursed = balance_disbursed - (:s_dOrigAmountRec - :i_dFeeAmtRcvd),							
										 amount_paid = amount_paid - (:s_dOrigAmountRec - :i_dFeeAmtRcvd)
									FROM sh_docket_disbursement
									WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
									AND sh_docket_disbursement.disburse_status = 'O'
									AND sh_docket_disbursement.cb_type = 'D'
									AND sh_docket_disbursement.docket_year = :i_iDockYear																									
									AND sh_docket_disbursement.docket_number = :i_lDockNum	
									AND sh_docket_disbursement.fee_type = :i_achFeeType;																																								
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
									AND sh_docket_disbursement.cb_type = 'D'
									AND sh_docket_disbursement.docket_year = :i_iDockYear																									
									AND sh_docket_disbursement.docket_number = :i_lDockNum
									AND sh_docket_disbursement.fee_type = :i_achFeeType;																																								
								If SQLCA.SQLCODE = -1 Then
									MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
									ROLLBACK;
									Return
								Else
									COMMIT;
								End If				
							End If
							
							SELECT cbdis_year, cbdis_number 
								INTO :s_iCBDisYear, :s_lCBDisNum
								FROM sh_docket_disbursement
								WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
								AND sh_docket_disbursement.disburse_status = 'O'
								AND sh_docket_disbursement.cb_type = 'D'																
								AND sh_docket_disbursement.docket_year = :i_iDockYear																									
								AND sh_docket_disbursement.docket_number = :i_lDockNum
								AND sh_docket_disbursement.fee_type = :i_achFeeType;																																								
							If IsNull(s_iCBDisYear) Then s_iCBDisYear = 0							
							If IsNull(s_lCBDisNum) Then s_lCBDisNum = 0							
	
						End If

						UPDATE sh_docket_fee_paid
							SET cbdis_year = :s_iCBDisYear,
								 cbdis_number = :s_lCBDisNum,
								 fee_type = :i_achFeeType
							WHERE sh_docket_fee_paid.cb_type = 'D'
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
	
					Case 'S'
						
						s_achWhomDue = "State of Iowa"
						
						SELECT COUNT(*) INTO :s_iCount
							FROM sh_docket_disbursement
							WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
							AND sh_docket_disbursement.disburse_status = 'O'
							AND sh_docket_disbursement.cb_type = 'D';																		
						If s_iCount = 0 Then
							
							s_iCBDisYear = Year(g_dtToday)
							SELECT MAX(cbdis_number) INTO :s_lCBDisNum
								FROM sh_docket_disbursement
								WHERE sh_docket_disbursement.cbdis_year = :s_iCBDisYear
								AND sh_docket_disbursement.cb_type = 'D';																			
							If IsNull(s_lCBDisNum) Then s_lCBDisNum = 0
							s_lCBDisNum ++
							
							INSERT INTO sh_docket_disbursement
								(cb_type, docket_number, docket_year, cbdis_number, cbdis_year,
								 date_paid, amount_paid, check_number, last_name,
								 first_name, middle_name, suffix, whom_due, balance_disbursed,
								 case_number, disburse_status, disburse_date, 
								 disburse_type, fee_type)
							 VALUES ('D', :i_lDockNum, :i_iDockYear, :s_lCBDisNum, :s_iCBDisYear,
								 NULL, :i_dFeeAmtRcvd, 0, :s_achWhomDue,
								 '', '', '', '', :i_dFeeAmtRcvd, 
								 '', 'O', :g_dtToday, 
								 :s_achDisbursedType, :i_achFeeType);
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
									SET balance_disbursed = balance_disbursed - (:s_dOrigAmountRec - :i_dFeeAmtRcvd),							
										 amount_paid = amount_paid - (:s_dOrigAmountRec - :i_dFeeAmtRcvd)													
									FROM sh_docket_disbursement
									WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
									AND sh_docket_disbursement.disburse_status = 'O'
									AND sh_docket_disbursement.cb_type = 'D';																			
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
									AND sh_docket_disbursement.cb_type = 'D';																			
								If SQLCA.SQLCODE = -1 Then
									MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
									ROLLBACK;
									Return
								Else
									COMMIT;
								End If				
							End If
	
							SELECT cbdis_year, cbdis_number 
								INTO :s_iCBDisYear, :s_lCBDisNum
								FROM sh_docket_disbursement
								WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
								AND sh_docket_disbursement.disburse_status = 'O'
								AND sh_docket_disbursement.cb_type = 'D';
							If IsNull(s_iCBDisYear) Then s_iCBDisYear = 0							
							If IsNull(s_lCBDisNum) Then s_lCBDisNum = 0							
								
						End If

						UPDATE sh_docket_fee_paid
							SET cbdis_year = :s_iCBDisYear,
								 cbdis_number = :s_lCBDisNum,
								 fee_type = :i_achFeeType
							WHERE sh_docket_fee_paid.cb_type = 'D'
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
		
					Case 'T'
	
						s_achWhomDue = "Cerro Gordo County Treasurer"					
						SELECT COUNT(*) INTO :s_iCount
							FROM sh_docket_disbursement
							WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
							AND sh_docket_disbursement.disburse_status = 'O'
							AND sh_docket_disbursement.cb_type = 'D';																		
						If s_iCount = 0 Then
							
							s_iCBDisYear = Year(g_dtToday)
							SELECT MAX(cbdis_number) INTO :s_lCBDisNum
								FROM sh_docket_disbursement
								WHERE sh_docket_disbursement.cbdis_year = :s_iCBDisYear
								AND sh_docket_disbursement.cb_type = 'D';																			
							If IsNull(s_lCBDisNum) Then s_lCBDisNum = 0
							s_lCBDisNum ++
	//messagebox("new T disb",s_lCBDisNum)		
							INSERT INTO sh_docket_disbursement
								(cb_type, docket_number, docket_year, cbdis_number, cbdis_year,
								 date_paid, amount_paid, check_number, last_name,
								 first_name, middle_name, suffix, whom_due, balance_disbursed,
								 case_number, disburse_status, disburse_date, 
								 disburse_type, fee_type)
							 VALUES ('D', :i_lDockNum, :i_iDockYear, :s_lCBDisNum, :s_iCBDisYear,
								 NULL, :i_dFeeAmtRcvd, 0, :s_achWhomDue,
								 '', '', '', '', :i_dFeeAmtRcvd, 
								 '', 'O', :g_dtToday, 
								 :s_achDisbursedType, :i_achFeeType);
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
									SET balance_disbursed = balance_disbursed - (:s_dOrigAmountRec - :i_dFeeAmtRcvd),							
										 amount_paid = amount_paid - (:s_dOrigAmountRec - :i_dFeeAmtRcvd)													
									FROM sh_docket_disbursement
									WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
									AND sh_docket_disbursement.disburse_status = 'O'
									AND sh_docket_disbursement.cb_type = 'D';																			
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
									AND sh_docket_disbursement.cb_type = 'D';																			
								If SQLCA.SQLCODE = -1 Then
									MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
									ROLLBACK;
									Return
								Else
									COMMIT;
								End If				
							End If
	
							SELECT cbdis_year, cbdis_number 
								INTO :s_iCBDisYear, :s_lCBDisNum
								FROM sh_docket_disbursement
								WHERE sh_docket_disbursement.disburse_type = :s_achDisbursedType
								AND sh_docket_disbursement.disburse_status = 'O'
								AND sh_docket_disbursement.cb_type = 'D';																			
							If IsNull(s_iCBDisYear) Then s_iCBDisYear = 0							
							If IsNull(s_lCBDisNum) Then s_lCBDisNum = 0							
								
						End If
	
						UPDATE sh_docket_fee_paid
							SET cbdis_year = :s_iCBDisYear,
								 cbdis_number = :s_lCBDisNum,
								 fee_type = :i_achFeeType								 
							WHERE sh_docket_fee_paid.cb_type = 'D'
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
	
	
				End Choose										

		End Choose  // field "amount_received"

End Choose  // datawindow object
end event

event dw_detail::rowfocuschanged;call super::rowfocuschanged;/*
integer s_iCount, s_iRow, s_iFeeNum
decimal {2} s_dAmountRcvd, s_dBalanceDue, s_dBalDisbursed
datawindowchild dwc

If i_achOpType = "Delete" Then
	SELECT COUNT(*) INTO :s_iCount
		FROM sh_docket_fee_paid
		WHERE sh_docket_fee_paid.cb_type = 'D'
		AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear		
		AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum;
	If s_iCount > 0 Then
	
		If 1 = MessageBox("Delete This Fee Information", &
			"Delete THIS Fee?",Question!, YesNo!, 2) Then

			s_iRow = dw_detail.GetRow()
			s_dAmountRcvd = dw_detail.GetItemNumber(s_iRow,"amount_received")
			s_dBalanceDue = dw_detail.GetItemNumber(s_iRow,"balance_due")				
			s_iFeeNum = dw_detail.GetItemNumber(s_iRow,"fee_number")												
			
			SELECT balance_disbursed INTO :s_dBalDisbursed
				FROM sh_docket_receipt
				WHERE sh_docket_receipt.cb_type = 'D'
				AND sh_docket_receipt.cbrec_year = :i_iCBRecYear		
				AND sh_docket_receipt.cbrec_number = :i_lCBRecNum;
			If s_dAmountRcvd <= s_dBalDisbursed Then
				
				UPDATE sh_docket_receipt
						SET sh_docket_receipt.total_received = 
							 sh_docket_receipt.total_received - :s_dAmountRcvd,
							 sh_docket_receipt.balance_disbursed = 
							 sh_docket_receipt.balance_disbursed - :s_dAmountRcvd
					WHERE sh_docket_receipt.cb_type = 'D'
					AND sh_docket_receipt.cbrec_year = :i_iCBRecYear		
					AND sh_docket_receipt.cbrec_number = :i_lCBRecNum;
				COMMIT;
				
				s_dBalanceDue = s_dBalanceDue + s_dAmountRcvd	
				dw_detail.SetItem(s_iRow,	"balance_due", s_dBalanceDue)
				dw_detail.SetItem(s_iRow,	"amount_received", 0)					
				dw_detail.Update()
				
				DELETE FROM sh_docket_fee_paid
					WHERE sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
					AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum				
					AND sh_docket_fee_paid.cb_type = 'D'
					AND sh_docket_fee_paid.fee_number = :s_iFeeNum;										
				COMMIT;

			End If
		End If
	End If			
End If	
*/
end event

event dw_detail::ue_tabenter;
Choose Case dw_detail.DataObject
		
	Case "dw_docket_receipts_detail"
		
		Send(Handle(this),256,9,Long(0,0))
		RETURN 1

	Case "dw_docket_receipt_fees_scan"
		
		Send(Handle(this),256,9,Long(0,0))
		RETURN 1

	Case "dw_docket_disburse_other_detail"
		
		Send(Handle(this),256,9,Long(0,0))
		RETURN 1

End Choose		

end event

event dw_detail::clicked;call super::clicked;Choose Case dw_detail.DataObject

	Case "dw_docket_receipt_fees_scan"
		
		this.SetRow(row)
		this.ScrollToRow(row)
		
End Choose
end event

type dw_scan from w_base_sheet`dw_scan within w_docket_receipts_sheet
integer y = 186
integer width = 3090
integer height = 502
integer taborder = 140
string dataobject = "dw_docket_receipt2_scan"
end type

event dw_scan::rowfocuschanged;datawindowchild dwc
integer s_iDockYear, s_iCBRecYear
long  s_lDockNum, s_lCBRecNum
decimal {2} s_dcurrbal, s_dtotrec, s_damtrec, s_dtotfees

i_irow = dw_scan.GetRow()

dw_detail.SetTransObject(SQLCA)

If i_irow > 0 Then

	Choose Case dw_detail.DataObject

		Case "dw_docket_receipts_detail"
			
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(currentrow, True)

			s_iDockYear = dw_scan.GetItemNumber(i_iRow,"docket_year")									
			s_lDockNum = dw_scan.GetItemNumber(i_iRow,"docket_number")									
			s_iCBRecYear = dw_scan.GetItemNumber(i_iRow,"cbrec_year")									
			s_lCBRecNum = dw_scan.GetItemNumber(i_iRow,"cbrec_number")									
			
			dw_detail.Tag = "Docket - Receipt Information"
			dw_detail.Retrieve('D', dw_scan.GetItemNumber(i_irow, "docket_year"), &
				dw_scan.GetItemNumber(i_irow, "docket_number"), &
				dw_scan.GetItemNumber(i_irow, "cbrec_year"), &
				dw_scan.GetItemNumber(i_irow, "cbrec_number"))
				
			// RowFocusChanged Trigger for Title Refreshment
			dw_detail.TriggerEvent(RowFocusChanged!)				
			
			i_dTotRcvd = dw_detail.GetItemNumber(1,"total_received")						
			i_dtRecDate = Date(dw_detail.GetItemDateTime(1,"date_received"))			

			SELECT total_received 
				INTO :i_dTotRec
				FROM sh_docket_receipt
				WHERE cb_type = 'D'
					AND cbrec_year = :s_iCBRecYear
					AND cbrec_number = :s_lCBRecNum;
			If IsNull(i_dTotRec) Then i_dTotRec = 0
		
			SELECT SUM(amount_received)
				INTO :s_dAmtRec
				FROM sh_docket_fee_paid
				WHERE cb_type = 'D'
					AND cbrec_year = :s_iCBRecYear
					AND cbrec_number = :s_lCBRecNum;
			If IsNull(s_dAmtRec) Then s_dAmtRec = 0
			
			st_message.text = "Receipt Total:" + string(i_dTotRec,'#,##0.00') + &
				"                        " + &
			   "Receipt Balance:" + string(s_dAmtRec,'#,##0.00')

	End Choose
	
End If	

end event

type gb_5 from w_base_sheet`gb_5 within w_docket_receipts_sheet
end type

type gb_4 from w_base_sheet`gb_4 within w_docket_receipts_sheet
end type

type gb_1 from w_base_sheet`gb_1 within w_docket_receipts_sheet
end type

type gb_2 from w_base_sheet`gb_2 within w_docket_receipts_sheet
end type

type cb_list from w_base_sheet`cb_list within w_docket_receipts_sheet
integer taborder = 190
end type

type cb_detail from w_base_sheet`cb_detail within w_docket_receipts_sheet
integer taborder = 200
end type

type gb_3 from w_base_sheet`gb_3 within w_docket_receipts_sheet
end type

type em_dock_num from editmask within w_docket_receipts_sheet
integer x = 914
integer y = 42
integer width = 340
integer height = 86
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
string mask = "######"
end type

type em_dock_year from editmask within w_docket_receipts_sheet
integer x = 340
integer y = 42
integer width = 260
integer height = 86
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

type st_1 from statictext within w_docket_receipts_sheet
integer x = 614
integer y = 54
integer width = 289
integer height = 61
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
string text = "Docket #:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_docket_receipts_sheet
integer x = 11
integer y = 54
integer width = 318
integer height = 61
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
string text = "Docket Yr:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_docket_receipts_sheet
integer x = 2319
integer y = 54
integer width = 344
integer height = 61
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
string text = "Date Rcv~'d:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_m from groupbox within w_docket_receipts_sheet
integer x = 3138
integer y = 778
integer width = 497
integer height = 307
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_main from commandbutton within w_docket_receipts_sheet
integer x = 3163
integer y = 829
integer width = 450
integer height = 67
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Main"
end type

event clicked;datawindowchild	dwc
string s_achCBType
integer s_iItemNum, s_iDockYear, s_iCBRecYear
long s_lCount, s_lDockNum, s_lCBRecNum

dw_scan.enabled = True

cb_main.enabled = False
cb_disburse_info.enabled = True
cb_disburse.enabled = True


cb_add.enabled = False		
m_main.m_general.m_add.enabled = False
cb_update.enabled = False		
m_main.m_general.m_update.enabled = False
cb_delete.enabled = False		
m_main.m_general.m_delete.enabled = False
cb_escape.enabled = False		
m_main.m_general.m_escape.enabled = False
cb_save.enabled = False		
m_main.m_general.m_save.enabled = False

cb_first.enabled = False		
m_main.m_general.m_first.enabled = False
cb_back.enabled = False		
m_main.m_general.m_back.enabled = False
cb_next.enabled = False		
m_main.m_general.m_next.enabled = False
cb_last.enabled = False		
m_main.m_general.m_last.enabled = False

i_irow = dw_scan.GetRow()

s_achCBType = Trim(dw_scan.GetItemString(i_iRow, "cb_type"))
s_iDockYear = dw_scan.GetItemNumber(i_iRow, "docket_year")
s_lDockNum = dw_scan.GetItemNumber(i_iRow, "docket_number")
s_iCBRecYear = dw_scan.GetItemNumber(i_iRow, "cbrec_year")
s_lCBRecNum = dw_scan.GetItemNumber(i_iRow, "cbrec_number")

dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Receipt Information"

SELECT COUNT(*) INTO :s_iItemNum
	FROM sh_docket_receipt
	WHERE sh_docket_receipt.cb_type = :s_achCBType
	AND sh_docket_receipt.docket_year = :s_iDockYear
	AND sh_docket_receipt.docket_number = :s_lDockNum;	
If s_iItemNum = 0 Then
	// Not found, Okay to insert Docket Receipt Information
	// Security - Add Docket Receipt Information
	If w_main.dw_perms.Find("code=46", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_new.enabled = True		
		m_main.m_general.m_new.enabled = True
	End If

	dw_detail.DataObject = "dw_docket_receipts_detail"
	dw_detail.SetTransObject(SQLCA)

	// Security - Add Docket Receipt Information
	If w_main.dw_perms.Find("code=46", 1, w_main.dw_perms.RowCount()) > 0 Then
		m_main.m_general.m_add.TriggerEvent("clicked")
	End If	
Else				
	// Found, Retrieve Docket Receipt Information
	// Security - New Docket Receipt Information
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

	dw_detail.DataObject = "dw_docket_receipts_detail"		
	dw_detail.SetTransObject(SQLCA)
	dw_detail.Tag = "Docket Receipt Information"		

	dw_detail.Retrieve(s_achCBType, s_iDockYear, s_lDockNum, s_iCBRecYear, s_lCBRecNum)		
/*		
	Case -1  // Serious problems
		MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
*/
End If
			
dw_scan.SetFocus()			
end event

type cb_disburse from commandbutton within w_docket_receipts_sheet
integer x = 3163
integer y = 902
integer width = 450
integer height = 67
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Receipt Fees"
end type

event clicked;datawindowchild	dwc
string s_achDWColor, s_achErrText
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
cb_disburse_info.enabled = True
cb_disburse.enabled = False
			
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

s_achcbtyped = "D"

i_iDockYear = dw_scan.GetItemNumber(s_iRow, "docket_year")
i_lDockNum = dw_scan.GetItemNumber(s_iRow, "docket_number")
i_iCBRecYear = dw_scan.GetItemNumber(s_iRow, "cbrec_year")
i_lCBRecNum = dw_scan.GetItemNumber(s_iRow, "cbrec_number")

SELECT total_received 
	INTO :i_dTotRec
	FROM sh_docket_receipt
	WHERE cb_type = 'D'
		AND cbrec_year = :i_iCBRecYear
		AND cbrec_number = :i_lCBRecNum;
If IsNull(i_dTotRec) Then i_dTotRec = 0

SELECT SUM(amount_received)
	INTO :s_dAmtRec
	FROM sh_docket_fee_paid
	WHERE cb_type = 'D'
		AND cbrec_year = :i_iCBRecYear
		AND cbrec_number = :i_lCBRecNum;
If IsNull(s_dAmtRec) Then s_dAmtRec = 0

st_message.text = "Receipt Total: " + string(i_dTotRec,'#,##0.00') + &
	"                        " + &
	"Receipt Balance: " + string(s_dAmtRec,'#,##0.00')

dw_detail.DataObject = "dw_docket_receipt_fees_scan"
dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Receipt Fee Paid Information"

i_achMode = "Continue"

dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Receipt Fee Paid Information"

SELECT COUNT(*) INTO :s_iItemNum
	FROM sh_docket_fee
	WHERE sh_docket_fee.cb_type = 'D'	
	AND sh_docket_fee.docket_year = :i_iDockYear
	AND sh_docket_fee.docket_number = :i_lDockNum;
/*
If s_iItemNum = 0 and i_bNew = True Then
	// Not found, Okay to insert Docket Memos
	// Security - Add Docket Memos
	If w_main.dw_perms.Find("code=26", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True
		m_main.m_general.m_add.enabled = True
	End If

	// get Fee Type
	dw_detail.GetChild("fee_type", dwc)
	dwc.SetTransObject(SQLCA)
	dwc.Reset()
	dwc.Retrieve("FEE")

	dw_detail.DataObject = "dw_docket_receipt_fee_paid_scan"
	dw_detail.SetTransObject(SQLCA)
	
	// Security - Add Docket Memos
	If w_main.dw_perms.Find("code=26", 1, w_main.dw_perms.RowCount()) > 0 Then
		m_main.m_general.m_add.TriggerEvent("clicked")
	End If
	
Else
	*/
	// Found, Retrieve Docket Memos
	// Security - Add Docket Memos
	If w_main.dw_perms.Find("code=26", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True
		m_main.m_general.m_add.enabled = True
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
// Added on 12/3/2007
	If i_achOpType = "Add" Then
		UPDATE sh_docket_fee
			SET amount_received = 0
			WHERE cb_type = 'D'
			AND docket_year = :i_iDockYear
			AND docket_number = :i_lDockNum;
		If SQLCA.SQLCode = -1 Then
			s_achErrText = SQLCA.SQLErrText
			ROLLBACK USING SQLCA;
			MessageBox("Error", "Update Failed - " + s_achErrText)
		End If
		COMMIT;	
		If SQLCA.SQLCode = -1 Then
			s_achErrText = SQLCA.SQLErrText
			ROLLBACK USING SQLCA;
			MessageBox("Error", "Update Failed - " + s_achErrText)
		End If	
	Else
	
		lds_Fees = Create DataStore
		
		lds_Fees.DataObject = 'dw_docket_fee_numbers_ds'
		lds_Fees.SetTransObject(SQLCA)
	
		// Retrieve Fees on a Receipt
		s_lFeeRows = lds_Fees.Retrieve(s_achcbtyped, i_iDockYear, i_lDockNum)
		For s_iFeeCount = 1 To s_lFeeRows
	
			s_lFeeNum = lds_Fees.GetItemNumber(s_iFeeCount,"fee_number")	
			s_dRecAmtReceived = 0
			
			SELECT sh_docket_fee_paid.amount_received
				INTO :s_dRecAmtReceived
				FROM sh_docket_fee_paid
				WHERE sh_docket_fee_paid.cb_type = 'D'		
				AND sh_docket_fee_paid.docket_year = :i_iDockYear
				AND sh_docket_fee_paid.docket_number = :i_lDockNum		
				AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum
				AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
				AND sh_docket_fee_paid.fee_number = :s_lFeeNum;
			If IsNull(s_dRecAmtReceived) Then s_dRecAmtReceived = 0
	
			UPDATE sh_docket_fee
				SET sh_docket_fee.amount_received = :s_dRecAmtReceived
				WHERE sh_docket_fee.cb_type = 'D'
				AND sh_docket_fee.docket_year = :i_iDockYear
				AND sh_docket_fee.docket_number = :i_lDockNum
				AND sh_docket_fee.fee_number = :s_lFeeNum;
		
			If SQLCA.SQLCode = -1 Then
				s_achErrText = SQLCA.SQLErrText
				ROLLBACK USING SQLCA;
				MessageBox("Error1", "Update Failed - " + s_achErrText)
			End If
			COMMIT;	
			If SQLCA.SQLCode = -1 Then
				s_achErrText = SQLCA.SQLErrText
				ROLLBACK USING SQLCA;
				MessageBox("Error2", "Update Failed - " + s_achErrText)
			End If	
	
		Next	
	End If
// End Add on 12/3/2007	
	dw_detail.DataObject = "dw_docket_receipt_fees_scan"		
	dw_detail.SetTransObject(SQLCA)
	dw_detail.Tag = "Docket Receipt Fee Paid Information"

	// get Fee Type
	dw_detail.GetChild("fee_type", dwc)
	dwc.SetTransObject(SQLCA)
	dwc.Reset()
	dwc.Retrieve("FEE")

	dw_detail.Retrieve("D", i_iDockYear, i_lDockNum)		
	dw_detail.SetRowFocusIndicator(Hand!)
	
//	If i_achMode = "Continue" Then
	If i_achMode = "Continue" And i_bNew Then
		// Security - Add Docket Memos
		If w_main.dw_perms.Find("code=26", 1, w_main.dw_perms.RowCount()) > 0 Then
			m_main.m_general.m_update.TriggerEvent("clicked")
		End If
	End If

//End If

//	Case -1  // Serious problems
//		MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)

dw_detail.SetFocus()			

end event

type em_case_num from editmask within w_docket_receipts_sheet
integer x = 1616
integer y = 42
integer width = 691
integer height = 86
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
string mask = "######"
end type

type st_case_num from statictext within w_docket_receipts_sheet
integer x = 1265
integer y = 54
integer width = 340
integer height = 61
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
string text = "Case Num:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_message from statictext within w_docket_receipts_sheet
integer x = 18
integer y = 701
integer width = 3090
integer height = 86
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

type em_date from editmask within w_docket_receipts_sheet
integer x = 2670
integer y = 42
integer width = 424
integer height = 86
integer taborder = 40
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

type cb_disbursement from commandbutton within w_docket_receipts_sheet
boolean visible = false
integer x = 3163
integer y = 1248
integer width = 450
integer height = 67
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Disburse &Info"
end type

event clicked;datawindowchild	dwc
string s_achDWColor, s_achErrText
long s_lCount, s_lCBDisNum
integer s_iItemNum, s_iRow, s_iCBDisYear
decimal {2} s_dtotrec, s_damtrec, s_dcurrbal

datastore lds_Fees
long s_lFeeRows, s_iFeeCount, s_lFeeNum
string s_achcbtyped
decimal {2} s_dRecAmtReceived

s_achDWColor = dw_scan.Describe("datawindow.color")
dw_scan.enabled = False

//cb_main.enabled = True
//cb_disbursement.enabled = False
//cb_disburse.enabled = True
//cb_apply.visible = True
			
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

i_bupdatedisbbutton = False
s_achcbtyped = "D"

i_iDockYear = dw_scan.GetItemNumber(s_iRow, "docket_year")
i_lDockNum = dw_scan.GetItemNumber(s_iRow, "docket_number")

SELECT cbdis_year, cbdis_number INTO :s_iCBDisYear, :s_lCBDisNum
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.cb_type = 'D'	
	AND sh_docket_disbursement.docket_year = :i_iDockYear
	AND sh_docket_disbursement.docket_number = :i_lDockNum
	AND sh_docket_disbursement.disburse_type = 'O'
	AND sh_docket_disbursement.fee_type = :i_achFeeType;		
//messagebox("year",s_iCBDisYear)
//messagebox("num",s_lCBDisNum)

dw_detail.DataObject = "dw_docket_disburse_other_detail"
dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Disbursement Information"

i_achMode = "Continue"

dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Disbursement Information"

SELECT COUNT(*) INTO :s_iItemNum
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.cb_type = 'D'	
	AND sh_docket_disbursement.docket_year = :i_iDockYear
	AND sh_docket_disbursement.docket_number = :i_lDockNum
	AND sh_docket_disbursement.disburse_type = 'O'
	AND sh_docket_disbursement.fee_type = :i_achFeeType;	

//messagebox("items",s_iItemNum)		
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
		cb_add.enabled = True
		m_main.m_general.m_add.enabled = True
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
//messagebox("update area","")	
	dw_detail.Retrieve("D", i_iDockYear, i_lDockNum, s_iCBDisYear, s_lCBDisNum, i_achFeeType)		
//	dw_detail.SetRowFocusIndicator(Hand!)
	
	If i_achMode = "Continue" Then
		// Security - Add Docket Memos
		If w_main.dw_perms.Find("code=26", 1, w_main.dw_perms.RowCount()) > 0 Then
			m_main.m_general.m_update.TriggerEvent("clicked")
		End If
	End If

End If

//	Case -1  // Serious problems
//		MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)

dw_detail.SetFocus()			

end event

type cb_disburse_info from commandbutton within w_docket_receipts_sheet
integer x = 3163
integer y = 989
integer width = 450
integer height = 67
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Disburse &Info"
end type

event clicked;datawindowchild	dwc
string s_achDWColor, s_achErrText
long s_lCount, s_lCBDisNum
integer s_iItemNum, s_iRow, s_iCBDisYear
decimal {2} s_dtotrec, s_damtrec, s_dcurrbal

datastore lds_Fees
long s_lFeeRows, s_iFeeCount, s_lFeeNum
string s_achcbtyped
decimal {2} s_dRecAmtReceived

i_bUpdateDisbButton = True

s_achDWColor = dw_scan.Describe("datawindow.color")
dw_scan.enabled = False

cb_main.enabled = True
cb_disburse_info.enabled = False
cb_disburse.enabled = True
//cb_apply.visible = True
			
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

s_achcbtyped = "D"

i_iDockYear = dw_scan.GetItemNumber(s_iRow, "docket_year")
i_lDockNum = dw_scan.GetItemNumber(s_iRow, "docket_number")

dw_detail.DataObject = "dw_docket_disburse_other_lookup_detail"
dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Disbursement Information"

i_achMode = "Continue"

dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Disbursement Information"

SELECT COUNT(*) INTO :s_iItemNum
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.cb_type = 'D'	
	AND sh_docket_disbursement.docket_year = :i_iDockYear
	AND sh_docket_disbursement.docket_number = :i_lDockNum
	AND sh_docket_disbursement.disburse_type = 'O';

//messagebox("items",s_iItemNum)		
If s_iItemNum = 0 Then
	// Not found, Okay to insert Docket Memos
	// Security - Add Docket Memos
	If w_main.dw_perms.Find("code=26", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True
		m_main.m_general.m_add.enabled = True
	End If

	dw_detail.DataObject = "dw_docket_disburse_other_lookup_detail"
	dw_detail.SetTransObject(SQLCA)
//messagebox("not found area","")	
	// Security - Add Docket Memos
	If w_main.dw_perms.Find("code=26", 1, w_main.dw_perms.RowCount()) > 0 Then
		m_main.m_general.m_add.TriggerEvent("clicked")
	End If
	
Else  // Found, Retrieve Docket Memos
	// Security - Add Docket Memos
	If w_main.dw_perms.Find("code=26", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True
		m_main.m_general.m_add.enabled = True
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

	dw_detail.DataObject = "dw_docket_disburse_other_lookup_detail"		
	dw_detail.SetTransObject(SQLCA)
	dw_detail.Tag = "Docket Disbursement Information"
//messagebox("update area","")	
	dw_detail.Retrieve("D", i_iDockYear, i_lDockNum)		

End If

//	Case -1  // Serious problems
//		MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)

dw_detail.SetFocus()			

end event

