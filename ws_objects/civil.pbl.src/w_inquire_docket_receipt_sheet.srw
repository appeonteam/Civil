$PBExportHeader$w_inquire_docket_receipt_sheet.srw
forward
global type w_inquire_docket_receipt_sheet from w_base_sheet
end type
type gb_m from groupbox within w_inquire_docket_receipt_sheet
end type
type cb_main from commandbutton within w_inquire_docket_receipt_sheet
end type
type cb_close from commandbutton within w_inquire_docket_receipt_sheet
end type
type cb_disburse from commandbutton within w_inquire_docket_receipt_sheet
end type
type cb_apply from commandbutton within w_inquire_docket_receipt_sheet
end type
type st_receipt_total from statictext within w_inquire_docket_receipt_sheet
end type
type st_receipt_balance from statictext within w_inquire_docket_receipt_sheet
end type
type st_receipt_total_text from statictext within w_inquire_docket_receipt_sheet
end type
type st_receipt_balance_text from statictext within w_inquire_docket_receipt_sheet
end type
type st_reminder from statictext within w_inquire_docket_receipt_sheet
end type
end forward

global type w_inquire_docket_receipt_sheet from w_base_sheet
integer x = 41
integer y = 28
integer width = 3771
integer height = 2068
string title = "Docket Receipt Information - (READ-ONLY)"
toolbaralignment toolbaralignment = alignatleft!
gb_m gb_m
cb_main cb_main
cb_close cb_close
cb_disburse cb_disburse
cb_apply cb_apply
st_receipt_total st_receipt_total
st_receipt_balance st_receipt_balance
st_receipt_total_text st_receipt_total_text
st_receipt_balance_text st_receipt_balance_text
st_reminder st_reminder
end type
global w_inquire_docket_receipt_sheet w_inquire_docket_receipt_sheet

type variables
string i_achSaveSQL, i_achMode, i_achNewSQL
integer i_iCBRecYear, i_iDockYear
long i_lCBRecNum, i_lDockNum
boolean i_bFirstSearch, i_bExit, i_bContinueItem
boolean i_bNew
boolean i_bMemo, i_bButtonOnly
date i_dtRecDate
decimal {2} i_dTotRcvd
st_receiptparms i_stparms



end variables

on w_inquire_docket_receipt_sheet.create
int iCurrent
call super::create
this.gb_m=create gb_m
this.cb_main=create cb_main
this.cb_close=create cb_close
this.cb_disburse=create cb_disburse
this.cb_apply=create cb_apply
this.st_receipt_total=create st_receipt_total
this.st_receipt_balance=create st_receipt_balance
this.st_receipt_total_text=create st_receipt_total_text
this.st_receipt_balance_text=create st_receipt_balance_text
this.st_reminder=create st_reminder
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_m
this.Control[iCurrent+2]=this.cb_main
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_disburse
this.Control[iCurrent+5]=this.cb_apply
this.Control[iCurrent+6]=this.st_receipt_total
this.Control[iCurrent+7]=this.st_receipt_balance
this.Control[iCurrent+8]=this.st_receipt_total_text
this.Control[iCurrent+9]=this.st_receipt_balance_text
this.Control[iCurrent+10]=this.st_reminder
end on

on w_inquire_docket_receipt_sheet.destroy
call super::destroy
destroy(this.gb_m)
destroy(this.cb_main)
destroy(this.cb_close)
destroy(this.cb_disburse)
destroy(this.cb_apply)
destroy(this.st_receipt_total)
destroy(this.st_receipt_balance)
destroy(this.st_receipt_total_text)
destroy(this.st_receipt_balance_text)
destroy(this.st_reminder)
end on

event ue_search;call super::ue_search;// script variables	
datawindowchild dwc
string s_achSQL, s_achDWColor
string s_achNewSQL
integer s_iNumRows, s_iPosition

SetPointer(HourGlass!)

i_bButtonOnly = False

cb_add.enabled = False
m_main.m_general.m_add.enabled = False

// Security - Add Docket Receipt Information
If w_main.dw_perms.Find("code=46", 1, w_main.dw_perms.RowCount()) > 0 Then
//	cb_new.enabled = True
//	m_main.m_general.m_new.enabled = True
End If

// Security - Update Docket Receipt Information
If w_main.dw_perms.Find("code=47", 1, w_main.dw_perms.RowCount()) > 0 Then
//	cb_update.enabled = True
//	m_main.m_general.m_update.enabled = True
End If

// Security - Delete Docket Receipt Information
If w_main.dw_perms.Find("code=48", 1, w_main.dw_perms.RowCount()) > 0 Then
//	cb_delete.enabled = True	
//	m_main.m_general.m_delete.enabled = True
End If

s_achDWColor = dw_detail.Describe("datawindow.color")

dw_detail.DataObject = "dw_docket_receipt_detail"

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

//s_achSQL += &
//   " ORDER BY asr_parcel_sales.sales_number DESC" 
s_achSQL = i_achSQL + s_achSQL
i_achSaveSQL = s_achSQL

// NEW Entry
//s_achNewSQL += &
//   " ORDER BY asr_parcel_sales.sales_number DESC" 
i_achNewSQL = i_achSQL + s_achNewSQL

dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")

dw_scan.Reset()

If dw_scan.Retrieve(i_stparms.achCBType, i_stparms.iDockYear, i_stparms.lDockNum) = 0 Then
	MessageBox("Complete", "No Docket Receipt rows found.")

	dw_scan.SetFocus()
Else
	
	cb_main.enabled = False
	cb_disburse.enabled = True
	
   dw_scan.SetFocus()

	// RowFocusChanged Trigger for Title Refreshment
	dw_detail.TriggerEvent(RowFocusChanged!)			
End If

end event

event open;datawindowchild	dwc

SetPointer(HourGlass!)

//this.Width = dw_scan.width + dw_scan.x + 1100  
i_stparms = Message.PowerObjectParm

cb_apply.visible = False

SetPointer(Hourglass!)

w_inquire_docket_receipt_sheet.Title = "Docket Receipt Information - (READ-ONLY) " + &
	String(i_stparms.iDockYear) + "  " + 	String(i_stparms.lDockNum)
dw_detail.Tag = "Docket Receipt Information"
dw_detail.DataObject = "dw_docket_receipt_detail"
dw_detail.SetTransObject(SQLCA)

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
gnv_resize.of_Register(gb_m, gnv_resize.SCALE)

gnv_resize.of_Register(cb_close, gnv_resize.SCALE)
gnv_resize.of_Register(cb_disburse, gnv_resize.SCALE)
gnv_resize.of_Register(cb_main, gnv_resize.SCALE)

i_bFirstSearch = True

cb_search.PostEvent(clicked!)
dw_detail.SetFocus()

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

gb_m.pointer="arrow!"
cb_main.pointer="arrow!"
cb_disburse.pointer="arrow!"
cb_close.pointer="arrow!"
end event

event ue_next;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_docket_receipt_detail"
		
		cb_first.enabled = False					
		m_main.m_general.m_first.enabled = False					
		cb_back.enabled = False
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False		
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False		
		m_main.m_general.m_last.enabled = False

		Return
		
	Case "dw_drainage_district_assmt_parcel_detail"	
		
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

event ue_back;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_docket_receipt_detail"

		cb_first.enabled = False							
		m_main.m_general.m_first.enabled = False		
		cb_back.enabled = False									
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False									
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False									
		m_main.m_general.m_last.enabled = False

		Return

	Case "dw_drainage_district_assmt_parcel_detail"
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

event ue_val_fields;integer s_iRowCount, s_iRow, s_iCount, s_iCBRecYear
long s_lLineNum, s_lMaxNum, s_lCBRecNum

dw_detail.SetTransObject(SQLCA)
dw_detail.AcceptText()
Choose Case dw_detail.DataObject
	
	Case "dw_docket_receipt_detail"

		If IsNull(dw_detail.GetItemString(1,"last_name")) Or (dw_detail.GetItemString(1,"last_name") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Last name MUST be entered!")
			dw_detail.SetColumn("last_name")
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
		
	Case "dw_drainage_district_assmt_parcel_detail"
		
		s_iRowCount = dw_detail.RowCount()
						
		For s_iCount = 1 to s_iRowCount
			Choose Case dw_detail.GetItemStatus(s_iCount,0, Primary!)
				Case NotModified!, New!
					Continue
			End Choose
		
/*			If IsNull(dw_detail.GetItemNumber(s_iCount, "complete_parcel_number")) Or (dw_detail.GetItemNumber(s_iCount, "page_number") = 0) Then
				i_ivalflag = 1 
				MessageBox("Error", "Page MUST be entered!")
				dw_detail.SetColumn("page_number")
				dw_detail.SetRow(s_iCount)
				dw_detail.SetFocus()
				Return
			End If	
*/
			If IsNull(dw_detail.GetItemNumber(s_iCount, "benefit_pct")) Or (dw_detail.GetItemNumber(s_iCount, "benefit_pct") = 0) Then
				i_ivalflag = 1 
				MessageBox("Error", "% of benefit MUST be entered!")
				dw_detail.SetColumn("benefit_pct")
				dw_detail.SetRow(s_iCount)
				dw_detail.SetFocus()
				Return
			End If	

		Next

End Choose		

Choose Case dw_detail.DataObject

	Case "dw_docket_receipt_detail"

		s_iRow = dw_detail.GetRow()
		s_iCBRecYear = dw_detail.GetItemNumber(s_iRow,"cbrec_year")		

		If i_achOpType = "Add" Then		

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

End Choose   

end event

event ue_clear;call super::ue_clear;
i_achOpType = ""
i_bFirstSearch = True

cb_main.enabled = False
cb_disburse.enabled = False

cb_first.enabled = False
m_main.m_general.m_first.enabled = False
cb_back.enabled = False
m_main.m_general.m_back.enabled = False
cb_next.enabled = False
m_main.m_general.m_next.enabled = False
cb_last.enabled = False
m_main.m_general.m_last.enabled = False

dw_detail.SetFocus()

dw_detail.Tag = "Docket Receipt Information"
dw_detail.DataObject = "dw_docket_receipt_detail"
dw_detail.SetTransObject(SQLCA)

end event

event ue_first;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_docket_receipt_detail"
		
		cb_first.enabled = False							
		m_main.m_general.m_first.enabled = False		
		cb_back.enabled = False									
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False									
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False									
		m_main.m_general.m_last.enabled = False
		
		Return

	Case "dw_drainage_district_assmt_parcel_detail"
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

event ue_update;call super::ue_update;/*
string s_achDWColor, s_achDDWColor
integer s_iRow, s_iScanRow

i_achOpType ="Update"

s_achDWColor = dw_scan.Describe("datawindow.color")
s_achDDWColor = dw_detail.Describe("datawindow.color")

cb_main.enabled = False
cb_disburse.enabled = False

s_iScanRow = dw_scan.GetRow()
s_iRow = dw_detail.GetRow()
Choose Case dw_detail.DataObject
			 
	Case "dw_docket_receipt_detail"

		dw_detail.SetRedraw(False)
		dw_detail.Modify("receipt_number.background.color = " + s_achDWColor + & 
			" receipt_number.tabsequence = 2" + &			
			" date_received.background.color = " + s_achDWColor + & 
			" date_received.tabsequence = 3" + &						
			" last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 4" + &						
			" first_name.background.color = " + s_achDWColor + & 
			" first_name.tabsequence = 5" + &						
			" middle_name.background.color = " + s_achDWColor + & 
			" middle_name.tabsequence = 6" + &									
			" suffix.background.color = " + s_achDWColor + & 
			" suffix.tabsequence = 7" + &									
			" note.background.color = " + s_achDWColor + & 
			" note.tabsequence = 8" + &			
			" total_received.background.color = " + s_achDWColor + & 
			" total_received.tabsequence = 9")		
		dw_detail.SetColumn("receipt_number")						
		
	Case "dw_drainage_district_assmt_parcel_detail"
		
		dw_detail.SetRedraw(False)
		dw_detail.Modify("complete_parcel_number.background.color = " + s_achDWColor + & 
			" complete_parcel_number.tabsequence = 1" + &
			" benefit_pct.background.color = " + s_achDWColor + & 			
			" benefit_pct.tabsequence = 2" + &
			" comments.background.color = " + s_achDWColor + & 			
			" comments.tabsequence = 3")		
		dw_detail.SetColumn("complete_parcel_number")			
		If i_achMode = "Continue" And i_bNew Then
			i_achOpType = "Add"
		End If				

End Choose 
dw_detail.SetRedraw(True)
dw_detail.SetRow(s_iRow)		
dw_detail.SetFocus()
*/
end event

event ue_save;/*
// script variables
string s_achDWColor, s_achErrText, s_achCBType
integer s_iRow, s_iCount, s_iDockYear, s_iCBRecYear
long s_lDockNum, s_lCBRecNum

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
	Case "dw_docket_receipt_detail"

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
			
			cb_main.enabled = False
			cb_disburse.enabled = True
			
			s_iRow = dw_detail.GetRow()
			s_achCBType = Trim(dw_detail.GetItemString(s_iRow,"cb_type"))
			s_iDockYear = dw_detail.GetItemNumber(s_iRow,"docket_year")
			s_lDockNum = dw_detail.GetItemNumber(s_iRow,"docket_number")			
			i_iCBRecYear = dw_detail.GetItemNumber(s_iRow,"cbrec_year")
			i_lCBRecNum = dw_detail.GetItemNumber(s_iRow,"cbrec_number")			
			i_dTotRcvd = dw_detail.GetItemNumber(s_iRow,"total_received")						
			i_dtRecDate = Date(dw_detail.GetItemDateTime(s_iRow,"date_received"))									

			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)			
			If i_achOpType = "Add" Then			
				dw_scan.Modify("datawindow.table.select='" + i_achNewSQL + "'")			
			Else	
				dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
			End If

			dw_scan.Retrieve(s_achCBType, s_iDockYear, s_lDockNum)

			integer s_sRow
			s_sRow = dw_scan.Find("cb_type = '" + s_achCBType + &
				"' AND docket_year = " + String(s_iDockYear) + &
				" AND docket_number = " + String(s_lDockNum), 0, dw_scan.RowCount())				

			If s_sRow = 0 Then s_sRow = 1
	
			// highlight only the closest row
			dw_scan.ScrollToRow(s_sRow)				
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(s_sRow, True)										
	
			dw_scan.SetRedraw(True)
			dw_scan.enabled = True			

			cb_disburse.PostEvent("clicked")

		End If

End Choose

dw_scan.SetFocus()
*/
end event

event ue_last;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_docket_receipt_detail"
		
		cb_first.enabled = False					
		m_main.m_general.m_first.enabled = False					
		cb_back.enabled = False		
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False		
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False
		m_main.m_general.m_last.enabled = False
		
		Return
		
	Case "dw_drainage_district_assmt_parcel_detail"		
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

event ue_new;call super::ue_new;/*
datawindowchild dwc
string s_achDWColor, s_achName
integer s_iItemNum, s_iFY

s_achDWColor = dw_scan.Describe("datawindow.color")

SetPointer(Hourglass!)

i_bButtonOnly = False
i_bNew = True
i_achOpType = "Add"
i_achMode = "Continue"
i_bExit = False

cb_main.enabled = False
cb_disburse.enabled = True

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
dw_detail.DataObject = "dw_docket_receipt_detail"
dw_detail.SetTransObject(SQLCA)

Choose Case dw_detail.DataObject
	Case "dw_docket_receipt_detail"

		dw_detail.Tag = "Docket Receipt Information"		
		dw_detail.Reset()		
		dw_detail.InsertRow(0)

		dw_detail.SetItem(1,"cb_type", i_stparms.achCBType)																	
		dw_detail.SetItem(1,"docket_year", i_stparms.iDockYear)																	
		dw_detail.SetItem(1,"docket_number", i_stparms.lDockNum)																			
		dw_detail.SetItem(1,"cbrec_year", Year(Today()))
		dw_detail.SetItem(1,"cbrec_number", 0)
		dw_detail.SetItem(1,"receipt_number", 0)		
		dw_detail.SetItem(1,"date_received", "")		
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
			" date_received.background.color = " + s_achDWColor + & 
			" date_received.tabsequence = 3" + &						
			" last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 4" + &						
			" first_name.background.color = " + s_achDWColor + & 
			" first_name.tabsequence = 5" + &						
			" middle_name.background.color = " + s_achDWColor + & 
			" middle_name.tabsequence = 6" + &									
			" suffix.background.color = " + s_achDWColor + & 
			" suffix.tabsequence = 7" + &									
			" note.background.color = " + s_achDWColor + & 
			" note.tabsequence = 8" + &			
			" total_received.background.color = " + s_achDWColor + & 
			" total_received.tabsequence = 9")
		dw_detail.SetRedraw(True)		
		
		i_iRow = 1
		dw_detail.SetRow(i_iRow)		
		dw_detail.ScrollToRow(i_iRow)								

End Choose	

dw_detail.SetFocus()
*/
end event

event ue_delete;/*
// script variables
string s_achErrText, s_achDistrict
integer s_iCount, s_iRow, s_iDrainYear
long s_lDrainNum

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
	Case "dw_drainage_district_assessment_detail"
		
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
		   If 2 = MessageBox("Delete","Delete This ENTIRE Drainage District Assessment?",Question!,YesNo!,2) Then
		      MessageBox("Delete","Drainage District Assessment NOT Deleted",None!)
		   Else
		
				SetPointer(Hourglass!) 
				
				i_iRow = dw_detail.GetRow()				
				s_achDistrict = Trim(dw_detail.getItemString(i_iRow,"drain_district"))
				s_iDrainYear = dw_detail.getItemNumber(i_iRow,"drain_year")				
				s_lDrainNum = dw_detail.getItemNumber(i_iRow,"drain_number")								

				DELETE FROM aud_drain_district_assess_parcel
					WHERE aud_drain_district_assess_parcel.drain_district = :s_achDistrict
					AND aud_drain_district_assess_parcel.drain_year = :s_iDrainYear
					AND aud_drain_district_assess_parcel.drain_number = :s_lDrainNum;															
				If SQLCA.SQLCode = -1 Then
					s_achErrText = SQLCA.SQLErrText
					ROLLBACK;
					MessageBox("Error", "Drainage District Assessment Parcel Delete Failed - " + s_achErrText)
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

	Case "dw_drainage_district_assess_parcel_detail"	
		If dw_detail.RowCount() = 0 Then
		   MessageBox("Error","Select Row to Delete",StopSign!)
		Else
		   If 2 = MessageBox("Delete","Delete This Drainage District Assessment Parcel?",Question!,YesNo!,2) Then
		      MessageBox("Delete","Drainage District Assessment Parcel NOT Deleted",None!)
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
						TriggerEvent("ue_save")									
					End If
				End If

			End If
		End If

End Choose
dw_scan.enabled = True	
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

event ue_add;/*
datawindowchild dwc
string s_achDWColor, s_achDistrict, s_achLateral, s_achTownshipNum, s_achSectionNum
string s_achParcelBlkNum, s_achParcelNum, s_achBldgNum
integer s_iItemNum, s_iCount, s_iRow, s_iDrainYear, s_iAssessNum
long s_lDrainNum

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
i_bNew = True
i_achMode = "Continue"

Choose Case dw_detail.DataObject

	Case "dw_drainage_district_assmt_parcel_detail"

		// get Lateral Number
		dw_detail.GetChild("assessable_district", dwc)
		dwc.SetTransObject(SQLCA)
		dwc.Reset()
		dwc.Retrieve("LAT")

		cb_escape.enabled = True
		m_main.m_general.m_escape.enabled = True
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
		If s_iRow > 0 Then
			s_iDrainYear = dw_scan.GetItemNumber(s_iRow, "drain_year")			
			s_lDrainNum = dw_scan.GetItemNumber(s_iRow, "drain_number")						
			s_achDistrict = Trim(dw_scan.GetItemString(s_iRow, "drain_district"))
			s_achLateral = Trim(dw_scan.GetItemString(s_iRow, "assessable_district"))			
		End If
		
		s_iRow = dw_detail.InsertRow(0)

		SELECT MAX(line_number) INTO :s_iItemNum
			FROM aud_drain_district_assess_parcel
			WHERE aud_drain_district_assess_parcel.drain_year = :s_iDrainYear		
			AND aud_drain_district_assess_parcel.drain_number = :s_lDrainNum;
			
		If IsNull(s_iItemNum) Then s_iItemNum = 0			
		s_iItemNum ++
		dw_detail.SetItem(s_iRow, "line_number", s_iItemNum)

		dw_detail.SetItem(s_iRow,"drain_year", s_iDrainYear)															
		dw_detail.SetItem(s_iRow,"drain_number", s_lDrainNum)															
		dw_detail.SetItem(s_iRow,"drain_district", s_achDistrict)															
		dw_detail.SetItem(s_iRow,"assessable_district", s_achLateral)																	
		
		dw_detail.SetItem(s_iRow,"complete_parcel_number", "")
		dw_detail.SetItem(s_iRow,"benefit_pct", 0)					
		dw_detail.SetItem(s_iRow,"comments", "")							
		dw_detail.SetItem(s_iRow,"township_number", "")							
		dw_detail.SetItem(s_iRow,"section_number", "")									
		dw_detail.SetItem(s_iRow,"parcel_blk_number", "")									
		dw_detail.SetItem(s_iRow,"parcel_number", "")									
		dw_detail.SetItem(s_iRow,"bldg_number", "")											
		dw_detail.SetItem(s_iRow,"total_assessment", 0)
		dw_detail.SetItem(s_iRow,"unpaid_principal", 0)		
		dw_detail.SetItem(s_iRow,"last_chg_login", "")						
		dw_detail.SetItem(s_iRow,"last_chg_datetime", "")								
		
		dw_detail.SetRedraw(False)
		dw_detail.Modify("complete_parcel_number.background.color = " + s_achDWColor + & 
			" complete_parcel_number.tabsequence = 1" + &
			" benefit_pct.background.color = " + s_achDWColor + & 			
			" benefit_pct.tabsequence = 2" + &
			" comments.background.color = " + s_achDWColor + & 			
			" comments.tabsequence = 3")
		dw_detail.SetRedraw(True)			
		dw_detail.ScrollToRow(s_iRow)						

End Choose	
		
dw_detail.SetFocus()
*/
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

type cb_escape from w_base_sheet`cb_escape within w_inquire_docket_receipt_sheet
integer x = 3237
integer taborder = 70
end type

type cb_exit from w_base_sheet`cb_exit within w_inquire_docket_receipt_sheet
boolean visible = false
integer x = 3483
end type

type cb_last from w_base_sheet`cb_last within w_inquire_docket_receipt_sheet
integer x = 3483
end type

type cb_next from w_base_sheet`cb_next within w_inquire_docket_receipt_sheet
integer x = 3483
end type

type cb_back from w_base_sheet`cb_back within w_inquire_docket_receipt_sheet
integer x = 3483
end type

type cb_first from w_base_sheet`cb_first within w_inquire_docket_receipt_sheet
integer x = 3483
integer taborder = 110
end type

type cb_save from w_base_sheet`cb_save within w_inquire_docket_receipt_sheet
integer x = 3237
integer taborder = 80
end type

type cb_delete from w_base_sheet`cb_delete within w_inquire_docket_receipt_sheet
integer x = 3237
end type

type cb_update from w_base_sheet`cb_update within w_inquire_docket_receipt_sheet
integer x = 3237
end type

event cb_update::clicked;call super::clicked;i_achMode = ""
end event

type cb_add from w_base_sheet`cb_add within w_inquire_docket_receipt_sheet
integer x = 3237
end type

type cb_new from w_base_sheet`cb_new within w_inquire_docket_receipt_sheet
integer x = 3237
end type

type cb_clear from w_base_sheet`cb_clear within w_inquire_docket_receipt_sheet
integer x = 3237
end type

type cb_search from w_base_sheet`cb_search within w_inquire_docket_receipt_sheet
integer x = 3237
end type

type dw_detail from w_base_sheet`dw_detail within w_inquire_docket_receipt_sheet
event ue_dwnkey pbm_dwnkey
event ue_continue_add pbm_custom13
event ue_rowfocus pbm_custom14
integer x = 27
integer y = 800
integer width = 3159
integer height = 1096
integer taborder = 210
string dataobject = "dw_docket_receipt_detail"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_detail::ue_dwnkey;string s_achDWColor, s_achCBType
integer s_iRow, s_iCount, s_lCount, s_iDockYear
long s_lDockNum

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_docket_receipt_detail"
		
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

				s_iRow = dw_scan.GetRow()
	
				s_achCBType = Trim(dw_scan.GetItemString(s_iRow,"cb_type"))	
				s_iDockYear = dw_scan.GetItemNumber(s_iRow,"docket_year")
				s_lDockNum = dw_scan.GetItemNumber(s_iRow,"docket_number")
				
				dw_detail.Retrieve(s_achCBType, s_iDockYear, s_lDockNum)
			
				dw_scan.enabled = True
			
				// Security - Add Docket Receipt Information
				If w_main.dw_perms.Find("code=46", 1, w_main.dw_perms.RowCount()) > 0 Then
					cb_new.enabled = False
					m_main.m_general.m_new.enabled = False
				End If
				
				// Security - Update Docket Receipt Information
				If w_main.dw_perms.Find("code=47", 1, w_main.dw_perms.RowCount()) > 0 Then
					cb_update.enabled = False					
					m_main.m_general.m_update.enabled = False
				End If

				// Security - Delete Docket Receipt Information
				If w_main.dw_perms.Find("code=48", 1, w_main.dw_perms.RowCount()) > 0 Then
					cb_delete.enabled = False					
					m_main.m_general.m_delete.enabled = False
				End If
	
				cb_main.enabled = False
				cb_disburse.enabled = True
	
				cb_escape.enabled = False
				m_main.m_general.m_escape.enabled = False
				cb_save.enabled = False
				m_main.m_general.m_save.enabled = False
				i_bContinueItem = True
				
				dw_scan.SetFocus()
			End If
		End If		

	Case "dw_drainage_district_assmt_parcel_detail"

		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "comments"
				If KeyDown(KeyEnter!) Then		
					parent.TriggerEvent("ue_save")
					Return
				End If
	
		End Choose 

		If i_achMode = "Continue" Then
			If KeyDown(KeyEscape!) Or KeyDown(KeyTab!) Then
				i_bContinueItem = False
				i_bExit = True
				
				dw_detail.SetRedraw(False)		
				dw_detail.Modify("complete_parcel_number.background.color = " + s_achDWColor + & 
					" complete_parcel_number.tabsequence = 0" + &
					" benefit_pct.background.color = " + s_achDWColor + & 			
					" benefit_pct.tabsequence = 0" + &
					" comments.background.color = " + s_achDWColor + & 			
					" comments.tabsequence = 0")			
				dw_detail.SetRedraw(True)			
				
				If i_achOpType = "Add" Then
					dw_detail.PostEvent("ue_continue_add")
				End If
			End If
		End If		

End Choose
end event

event dw_detail::ue_continue_add;//integer s_iRow
//
//If i_bContinueItem = True Then
//	
//	If i_achMode = "Continue" And i_bRecon And i_bNew = True Then	
//		dw_detail.DataObject = "dw_drainage_district_assmt_parcel_detail"
//		dw_detail.SetTransObject(SQLCA)								
//	
//		m_main.m_general.m_add.TriggerEvent("clicked")
//	End If
//
//Else
//	
//	If i_achMode = "Continue" And i_bNew = True Then
//		If i_achOpType = "Add" Then
//			dw_detail.DataObject = "dw_drainage_district_assessment_detail"
//			dw_detail.SetTransObject(SQLCA)								
//			cb_main.PostEvent("clicked")
//			i_bNew = False
//			Return
//		End If	
//	End If				
//	
//	
//End If
//
end event

event dw_detail::itemchanged;/*
// script variables
integer s_iRow, s_iFeeNum, s_iFeePaidCount, s_iFeeCount
integer s_iFeePaidCount2
decimal {2} s_dAmountRec, s_dFeePaidAmtRec, s_dFeeBalanceDue, s_dOrigAmountRec, s_dOverpayment
decimal {2} s_dTotalReceived, s_dAmountDue
date s_dtRecDate
string s_achFeeType
Decimal {2} s_dtotrec, s_damtrec, s_dcurrbal

s_iRow = dw_detail.GetRow()
//i_iDockYear = dw_detail.GetItemNumber(s_iRow, "docket_year")
//i_lDockNum = dw_detail.GetItemNumber(s_iRow, "docket_number")
//i_iCBRecYear = dw_detail.GetItemNumber(s_iRow, "cbrec_year")
//i_lCBRecNum = dw_detail.GetItemNumber(s_iRow, "cbrec_number")


dw_detail.SetTransObject(SQLCA)
dw_detail.AcceptText()
Choose Case dw_detail.DataObject
	Case "dw_cash_disburse_fees_detail"

		s_iFeeNum = dw_detail.GetItemNumber(s_iRow, "fee_number")
		//s_dOrigAmountRec = dw_detail.GetItemNumber(s_iRow, "amount_received")
		s_dOrigAmountRec = dw_detail.GetItemNumber(s_iRow, "amount_received", Primary!, True)
		If IsNull(s_dOrigAmountRec) Then s_dOrigAmountRec = 0

		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters
			
			Case "amount_received"
				s_dAmountRec = Dec(data)
				
				SELECT COUNT(*) INTO :s_iFeePaidCount
					FROM sh_docket_fee_paid
					WHERE sh_docket_fee_paid.cb_type = 'D'
					AND sh_docket_fee_paid.docket_year = :i_iDockYear
					AND sh_docket_fee_paid.docket_number = :i_lDockNum					
					AND sh_docket_fee_paid.fee_number = :s_iFeeNum
					AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
					AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum;
				If s_iFeePaidCount = 0 Then
					// Not Found
					INSERT INTO sh_docket_fee_paid 
						(cb_type, docket_number, docket_year, fee_number, cbrec_year, 
						cbrec_number, amount_received, date_received, new_balance_disbursed,
						new_amount_disbursed)
						VALUES 
						('D', :i_lDockNum, :i_iDockYear, :s_iFeeNum, :i_iCBRecYear, 
						:i_lCBRecNum, :s_dAmountRec, :i_dtRecDate, :s_dAmountRec, 0);
					// error check
					If SQLCA.SQLCode = -1 Then
						MessageBox("System Error","Fee Paid Insert Error - " + SQLCA.SQLErrText)
						ROLLBACK;
					Else
						COMMIT;
					End If	
					
					s_dFeeBalanceDue = dw_detail.GetItemNumber(s_iRow, "balance_due")
					s_dFeeBalanceDue = s_dFeeBalanceDue - s_dAmountRec
					dw_detail.SetItem(s_iRow,"balance_due", s_dFeeBalanceDue)						
					
					If s_dFeeBalanceDue < 0 Then
						s_dOverpayment = - s_dFeeBalanceDue
						If 1 = MessageBox("Overpayment","The fee has been overpaid by " + String(s_dOverpayment) + ".  Record the overpayment as fee type OP(Overpayment)?", Question!, YesNo!, 1) Then
							s_dFeeBalanceDue = s_dFeeBalanceDue + s_dOverpayment
							dw_detail.SetItem(s_iRow,"balance_due", s_dFeeBalanceDue)														
							s_dAmountRec = s_dAmountRec - s_dOverpayment
							
							UPDATE sh_docket_fee_paid
								SET sh_docket_fee_paid.amount_received =
									sh_docket_fee_paid.amount_received - s_dOverpayment,
									sh_docket_fee_paid.new_balance_disbursed = :s_dAmountRec,
									sh_docket_fee_paid.new_amount_disbursed = 0
								WHERE sh_docket_fee_paid.cb_type = 'D'
								AND sh_docket_fee_paid.docket_year = :i_iDockYear
								AND sh_docket_fee_paid.docket_number = :i_lDockNum					
								AND sh_docket_fee_paid.fee_number = :s_iFeeNum
								AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
								AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum;							
							// error check
							If SQLCA.SQLCode = -1 Then
								MessageBox("System Error","Fee Paid 2 Update Error - " + SQLCA.SQLErrText)
								ROLLBACK;
							Else
								COMMIT;
							End If								
							dw_detail.SetItem(s_iRow,"amount_received", s_dAmountRec)														
							
							SELECT COUNT(*) INTO :s_iFeeCount
								FROM sh_docket_fee
								WHERE sh_docket_fee.cb_type = 'D'
								AND sh_docket_fee.docket_year = :i_iDockYear
								AND sh_docket_fee.docket_number = :i_lDockNum					
								AND sh_docket_fee.fee_number = 99;
							If s_iFeeCount = 0 Then	
								INSERT INTO sh_docket_fee 
									(cb_type, docket_number, docket_year, fee_number, 
									fee_type, fee_amount, amount_received, balance_due )
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
									new_balance_disbursed, new_amount_disbursed )
									VALUES 
									('D', :i_lDockNum, :i_iDockYear, 99, 
									:i_iCBRecYear, :i_lCBRecNum, :s_dOverpayment, :i_dtRecDate,
									:s_dOverpayment, 0);
								// error check
								If SQLCA.SQLCode = -1 Then
									MessageBox("System Error","Fee Paid Overpayment Insert Error - " + SQLCA.SQLErrText)
									ROLLBACK;
								Else
									COMMIT;
								End If	

							Else

								s_dAmountDue = Dec(data)										
								s_dAmountDue = s_dAmountDue + s_dOverpayment
								dw_detail.SetItem(i_iRow, "amount_due", s_dAmountDue)

								SELECT COUNT(*) INTO :s_iFeePaidCount2
									FROM sh_docket_fee_paid
									WHERE sh_docket_fee_paid.cb_type = 'D'
									AND sh_docket_fee_paid.docket_year = :i_iDockYear
									AND sh_docket_fee_paid.docket_number = :i_lDockNum					
									AND sh_docket_fee_paid.fee_number = 99
									AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
									AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum																	
									AND sh_docket_fee_paid.date_received = :s_dtRecDate;																	
								If s_iFeePaidCount2 = 0 Then 											
									
									INSERT INTO sh_docket_fee_paid 
										(cb_type, docket_number, docket_year, fee_number, 
										cbrec_year, cbrec_number, amount_received, date_received,
										new_balance_disbursed, new_amount_disbursed )
										VALUES 
										('D', :i_lDockNum, :i_iDockYear, 99, 
										:i_iCBRecYear, :i_lCBRecNum, :s_dOverpayment, :i_dtRecDate,
										:s_dOverpayment, 0);
									// error check
									If SQLCA.SQLCode = -1 Then
										MessageBox("System Error","Fee Paid Overpayment 2 Insert Error - " + SQLCA.SQLErrText)
										ROLLBACK;
									Else
										COMMIT;
									End If	

								Else

									s_dAmountRec = s_dAmountRec + s_dOverpayment
									UPDATE sh_docket_fee_paid
										SET sh_docket_fee_paid.date_received = :s_dtRecDate,
											sh_docket_fee_paid.amount_received = :s_dAmountRec,
											sh_docket_fee_paid.new_balance_disbursed = :s_dAmountRec,
											sh_docket_fee_paid.new_amount_disbursed = 0
										WHERE sh_docket_fee_paid.cb_type = 'D'
										AND sh_docket_fee_paid.docket_year = :i_iDockYear
										AND sh_docket_fee_paid.docket_number = :i_lDockNum					
										AND sh_docket_fee_paid.fee_number = :s_iFeeNum
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
			
				Else	
					
					// Found Fee Paid Record
					s_dAmountRec = Dec(data)
					s_dtRecDate = i_dtRecDate
					s_dFeeBalanceDue = dw_detail.GetItemNumber(s_iRow, "balance_due")
					s_dFeeBalanceDue = s_dFeeBalanceDue + (s_dOrigAmountRec - s_dAmountRec)
					dw_detail.SetItem(s_iRow,"balance_due", s_dFeeBalanceDue)
				
					UPDATE sh_docket_fee_paid
						SET sh_docket_fee_paid.date_received = :s_dtRecDate,
							 sh_docket_fee_paid.amount_received = :s_dAmountRec,
							 sh_docket_fee_paid.new_balance_disbursed = :s_dAmountRec
						WHERE sh_docket_fee_paid.cb_type = 'D'
						AND sh_docket_fee_paid.docket_year = :i_iDockYear
						AND sh_docket_fee_paid.docket_number = :i_lDockNum					
						AND sh_docket_fee_paid.fee_number = :s_iFeeNum
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
							s_dFeeBalanceDue = s_dFeeBalanceDue + s_dOverpayment
							dw_detail.SetItem(s_iRow,"balance_due", s_dFeeBalanceDue)														
							s_dAmountRec = s_dAmountRec - s_dOverpayment
							UPDATE sh_docket_fee_paid
								SET sh_docket_fee_paid.amount_received = :s_dAmountRec,
									sh_docket_fee_paid.new_balance_disbursed = :s_dAmountRec
								WHERE sh_docket_fee_paid.cb_type = 'D'
								AND sh_docket_fee_paid.docket_year = :i_iDockYear
								AND sh_docket_fee_paid.docket_number = :i_lDockNum					
								AND sh_docket_fee_paid.fee_number = :s_iFeeNum
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
									fee_type, fee_amount, amount_received, balance_due )
									VALUES 
									('D', :i_lDockNum, :i_iDockYear, 0, 99, 
									'OP', :s_dOverpayment, :s_dOverpayment, 0 );
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
									new_balance_disbursed, new_amount_disbursed )
									VALUES 
									('D', :i_lDockNum, :i_iDockYear, 99, 
									:i_iCBRecYear, :i_lCBRecNum, :s_dOverpayment, :i_dtRecDate,
									:s_dOverpayment, 0);
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
								dw_detail.SetItem(i_iRow, "amount_due", s_dAmountDue)
								SELECT COUNT(*) INTO :s_iFeePaidCount2
									FROM sh_docket_fee_paid
									WHERE sh_docket_fee_paid.cb_type = 'D'
									AND sh_docket_fee_paid.docket_year = :i_iDockYear
									AND sh_docket_fee_paid.docket_number = :i_lDockNum					
									AND sh_docket_fee_paid.fee_number = 99
									AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
									AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum																	
									AND sh_docket_fee_paid.date_received = :s_dtRecDate;																	
								If s_iFeePaidCount2 = 0 Then											
									 // Fee Paid Not Found											
									INSERT INTO sh_docket_fee_paid 
										(cb_type, docket_number, docket_year, fee_number, 
										cbrec_year, cbrec_number, amount_received, date_received,
										new_balance_disbursed, new_amount_disbursed)
										VALUES 
										('D', :i_lDockNum, :i_iDockYear, 99, 
										:i_iCBRecYear, :i_lCBRecNum, :s_dOverpayment, :i_dtRecDate,
										:s_dOverpayment, 0 );
									// error check
									If SQLCA.SQLCode = -1 Then
										MessageBox("System Error","Fee Paid Overpayment 2 Insert Error - " + SQLCA.SQLErrText)
										ROLLBACK;
									Else
										COMMIT;
									End If	
									
								Else  // Fee Paid Found																					
									s_dAmountRec = s_dAmountRec + s_dOverpayment
									UPDATE sh_docket_fee_paid
										SET sh_docket_fee_paid.date_received = :s_dtRecDate,
											sh_docket_fee_paid.amount_received = :s_dAmountRec,
											sh_docket_fee_paid.new_balance_disbursed = :s_dAmountRec
										WHERE sh_docket_fee_paid.cb_type = 'D'
										AND sh_docket_fee_paid.docket_year = :i_iDockYear
										AND sh_docket_fee_paid.docket_number = :i_lDockNum					
										AND sh_docket_fee_paid.fee_number = :s_iFeeNum
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
				INTO :s_dtotrec
				FROM sh_docket_receipt
				WHERE cb_type = 'D'
					AND cbrec_year = :i_iCBRecYear
					AND cbrec_number = :i_lCBRecNum;
			If IsNull(s_dtotrec) Then s_dtotrec = 0
			
			st_receipt_total.text = string(s_dtotrec,'#,##0.00')
			
			SELECT sum(amount_received)
				INTO :s_damtrec
				FROM sh_docket_fee_paid
				WHERE cb_type = 'D'
					AND cbrec_year = :i_iCBRecYear
					AND cbrec_number = :i_lCBRecNum;
			If IsNull(s_damtrec) Then s_damtrec = 0
			
			s_dcurrbal = s_dtotrec - s_damtrec
			
			st_receipt_balance.text = string(s_dcurrbal,'#,##0.00')			
			
	End Choose  // field "amount_received"

End Choose  // datawindow object
*/
end event

event dw_detail::ue_tabenter;
Choose Case dw_detail.DataObject
		
	Case "dw_docket_receipt_detail"
		
		Send(Handle(this),256,9,Long(0,0))
		RETURN 1

	Case "dw_drainage_district_assmt_parcel_detail"
		
		Send(Handle(this),256,9,Long(0,0))
		RETURN 1

End Choose		

end event

event dw_detail::rowfocuschanged;call super::rowfocuschanged;/*
integer s_iCount, s_iRow, s_iProcNum, s_iFeeNum
decimal {2} s_dAmountRcvd, s_dBalanceDue, s_dBalDisbursed
datawindowchild dwc

If i_stparms.achOpType = "Delete" Then
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

event dw_detail::losefocus;call super::losefocus;//g_bDisbursed = True
dw_detail.Update()
COMMIT;
end event

type dw_scan from w_base_sheet`dw_scan within w_inquire_docket_receipt_sheet
integer y = 28
integer width = 3159
integer height = 748
integer taborder = 190
string dataobject = "dw_docket_receipt_scan"
end type

event dw_scan::rowfocuschanged;datawindowchild	dwc
string s_achDistrict
long s_lCount, s_lRowCount, s_lCurrentRow, s_lRow
			
dw_detail.SetTransObject(SQLCA)

i_irow = dw_scan.GetRow()

If i_iRow > 0 Then
	
	Choose Case dw_detail.DataObject
		Case "dw_docket_receipt_detail"

			dw_detail.Tag = "Docket Receipt Information"

			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(currentrow, True)
			
			dw_detail.Retrieve(dw_scan.GetItemString(i_irow, "cb_type"), &
				dw_scan.GetItemNumber(i_irow, "docket_year"), &
				dw_scan.GetItemNumber(i_irow, "docket_number"), &	
				dw_scan.GetItemNumber(i_irow, "cbrec_year"), &
				dw_scan.GetItemNumber(i_irow, "cbrec_number"))								
				
			// RowFocusChanged Trigger for Title Refreshment
			dw_detail.TriggerEvent(RowFocusChanged!)				
			
			i_dTotRcvd = dw_detail.GetItemNumber(1,"total_received")						
			i_dtRecDate = Date(dw_detail.GetItemDateTime(1,"date_received"))												
			
	End Choose		

End If	
end event

type gb_5 from w_base_sheet`gb_5 within w_inquire_docket_receipt_sheet
integer x = 3461
end type

type gb_4 from w_base_sheet`gb_4 within w_inquire_docket_receipt_sheet
integer x = 3461
end type

type gb_1 from w_base_sheet`gb_1 within w_inquire_docket_receipt_sheet
integer x = 3209
integer textsize = -9
end type

type gb_2 from w_base_sheet`gb_2 within w_inquire_docket_receipt_sheet
integer x = 3209
end type

type cb_list from w_base_sheet`cb_list within w_inquire_docket_receipt_sheet
integer x = 3483
integer taborder = 90
end type

type cb_detail from w_base_sheet`cb_detail within w_inquire_docket_receipt_sheet
integer x = 3483
integer taborder = 100
end type

type gb_3 from w_base_sheet`gb_3 within w_inquire_docket_receipt_sheet
integer x = 3461
end type

type gb_m from groupbox within w_inquire_docket_receipt_sheet
integer x = 3209
integer y = 684
integer width = 498
integer height = 316
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_main from commandbutton within w_inquire_docket_receipt_sheet
integer x = 3237
integer y = 732
integer width = 448
integer height = 68
integer taborder = 160
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
cb_disburse.enabled = True
cb_apply.visible = False

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

st_receipt_total_text.visible = False
st_receipt_total.visible = False
st_receipt_balance_text.visible = False
st_receipt_balance.visible = False
st_reminder.visible = False

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
//		cb_new.enabled = True		
//		m_main.m_general.m_new.enabled = True
	End If

	dw_detail.DataObject = "dw_docket_receipt_detail"
	dw_detail.SetTransObject(SQLCA)

	// Security - Add Docket Receipt Information
	If w_main.dw_perms.Find("code=46", 1, w_main.dw_perms.RowCount()) > 0 Then
//		m_main.m_general.m_add.TriggerEvent("clicked")
	End If	
Else				
	// Found, Retrieve Docket Receipt Information
	// Security - New Docket Receipt Information
	If w_main.dw_perms.Find("code=46", 1, w_main.dw_perms.RowCount()) > 0 Then
//		cb_new.enabled = True		
//		m_main.m_general.m_new.enabled = True
	End If
	
	// Security - Update Docket Receipt Information
	If w_main.dw_perms.Find("code=47", 1, w_main.dw_perms.RowCount()) > 0 Then
//		cb_update.enabled = True					
//		m_main.m_general.m_update.enabled = True
	End If
	
	// Security - Delete Docket Receipt Information
	If w_main.dw_perms.Find("code=48", 1, w_main.dw_perms.RowCount()) > 0 Then
//		cb_delete.enabled = True								
//		m_main.m_general.m_delete.enabled = True
	End If

	dw_detail.DataObject = "dw_docket_receipt_detail"		
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

type cb_close from commandbutton within w_inquire_docket_receipt_sheet
integer x = 3237
integer y = 900
integer width = 448
integer height = 68
integer taborder = 180
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close Rcpt"
end type

event clicked;close(parent)
end event

type cb_disburse from commandbutton within w_inquire_docket_receipt_sheet
integer x = 3237
integer y = 808
integer width = 448
integer height = 68
integer taborder = 170
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
cb_disburse.enabled = False
//cb_apply.visible = True
cb_apply.visible = False
			
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

st_receipt_total_text.visible = True
st_receipt_total.visible = True
//st_receipt_balance_text.visible = True
//st_receipt_balance.visible = True
//st_reminder.visible = True
st_receipt_balance_text.visible = False
st_receipt_balance.visible = False
st_reminder.visible = False

s_iRow = dw_scan.GetRow()

s_achcbtyped = "D"

i_iDockYear = dw_scan.GetItemNumber(s_iRow, "docket_year")
i_lDockNum = dw_scan.GetItemNumber(s_iRow, "docket_number")
i_iCBRecYear = dw_scan.GetItemNumber(s_iRow, "cbrec_year")
i_lCBRecNum = dw_scan.GetItemNumber(s_iRow, "cbrec_number")

SELECT total_received 
	INTO :s_dtotrec
	FROM sh_docket_receipt
	WHERE cb_type = 'D'
		AND cbrec_year = :i_iCBRecYear
		AND cbrec_number = :i_lCBRecNum;
If IsNull(s_dtotrec) Then s_dtotrec = 0

st_receipt_total.text = string(s_dtotrec,'#,##0.00')

SELECT sum(amount_received)
	INTO :s_damtrec
	FROM sh_docket_fee_paid
	WHERE cb_type = 'D'
		AND cbrec_year = :i_iCBRecYear
		AND cbrec_number = :i_lCBRecNum;
If IsNull(s_damtrec) Then s_damtrec = 0

s_dcurrbal = s_dtotrec - s_damtrec

st_receipt_balance.text = string(s_dcurrbal,'#,##0.00')

dw_detail.DataObject = "dw_cash_disburse_fees_detail"
dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Receipt Fee Disbursement Information"

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

/*	OLD - works in ALIAS, not in County Civil
	UPDATE sh_docket_fee
		SET sh_docket_fee.amount_received = 
			(SELECT sh_docket_fee_paid.amount_received
				FROM sh_docket_fee_paid
				WHERE sh_docket_fee_paid.cb_type = 'D'		
				AND sh_docket_fee_paid.docket_year = :i_iDockYear
				AND sh_docket_fee_paid.docket_number = :i_lDockNum		
				AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum
				AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
				AND sh_docket_fee.fee_number = sh_docket_fee_paid.fee_number)
		WHERE sh_docket_fee.cb_type = 'D'
		AND sh_docket_fee.docket_year = :i_iDockYear
		AND sh_docket_fee.docket_number = :i_lDockNum;
*/
	lds_Fees = Create DataStore
	
	lds_Fees.DataObject = 'dw_docket_fee_numbers_ds'
	lds_Fees.SetTransObject(SQLCA)

	// Retrieve Names on a document
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
	
// get fee types
dw_detail.GetChild("fee_type", dwc)
dwc.SetTransObject(SQLCA)
dwc.Reset()
dwc.Retrieve("FEE")

dw_detail.SetTransObject(SQLCA)
dw_detail.Retrieve('D', i_iDockYear, i_lDockNum)
dw_detail.SetRowFocusIndicator(Hand!)
dw_detail.SetFocus()

dw_detail.SetRedraw(False)

/*
If i_achOpType <> "Delete" Then
	dw_detail.Modify("amount_received.background.color = " + s_achDWColor + & 
		" amount_received.tabsequence = 1")
Else
	dw_detail.Modify("amount_received.tabsequence = 0")	
End If	
*/

dw_detail.Modify("amount_received.tabsequence = 0")	

dw_detail.SetRedraw(True)

DESTROY lds_Fees
			
end event

type cb_apply from commandbutton within w_inquire_docket_receipt_sheet
integer x = 2610
integer y = 1756
integer width = 375
integer height = 92
integer taborder = 200
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "A&pply"
end type

event clicked;dec {2} s_dTotalReceived, s_dOverpayment, s_dAmountRec, s_dFeePaidAmtRec
date s_dtRecDate

SELECT SUM(sh_docket_fee_paid.amount_received) INTO :s_dTotalReceived
	FROM sh_docket_fee_paid
	WHERE sh_docket_fee_paid.cb_type = 'D'
	AND sh_docket_fee_paid.docket_year = :i_iDockYear
	AND sh_docket_fee_paid.docket_number = :i_lDockNum
	AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
	AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum;												
Choose Case SQLCA.SQLCODE
	Case 100  // Fee Paid Not Found											


	Case 0  // Fee Paid Found											
		UPDATE sh_docket_receipt
			SET sh_docket_receipt.total_received = :s_dTotalReceived,
				 sh_docket_receipt.balance_disbursed = :s_dTotalReceived
			WHERE sh_docket_receipt.cb_type = 'D'
			AND sh_docket_receipt.docket_year = :i_iDockYear
			AND sh_docket_receipt.docket_number = :i_lDockNum
			AND sh_docket_receipt.cbrec_year = :i_iCBRecYear
			AND sh_docket_receipt.cbrec_number = :i_lCBRecNum;	

		If s_dTotalReceived < i_dTotRcvd Then
			s_dOverpayment = i_dTotRcvd - s_dTotalReceived
			If 1 = MessageBox("Overpayment","The total amount received was entered as " + String(i_dTotRcvd) + ".  Record the difference of " + String(s_dOverpayment) + " as fee type OP (Overpayment)?", Question!, YesNo!, 1) Then
				UPDATE sh_docket_receipt
					SET sh_docket_receipt.total_received = :i_dTotRcvd,
						 sh_docket_receipt.balance_disbursed = :i_dTotRcvd
					WHERE sh_docket_receipt.cb_type = 'D'
					AND sh_docket_receipt.docket_year = :i_iDockYear
					AND sh_docket_receipt.docket_number = :i_lDockNum
					AND sh_docket_receipt.cbrec_year = :i_iCBRecYear
					AND sh_docket_receipt.cbrec_number = :i_lCBRecNum;																
				COMMIT;					
				
				SELECT sh_docket_fee.amount_received INTO :s_dAmountRec
					FROM sh_docket_fee
					WHERE sh_docket_fee.cb_type = 'D'
					AND sh_docket_fee.docket_year = :i_iDockYear
					AND sh_docket_fee.docket_number = :i_lDockNum					
					AND sh_docket_fee.fee_number = 99;
				Choose Case SQLCA.SQLCODE
					Case 100  // Fee Not Found											
						INSERT INTO sh_docket_fee 
						   (cb_type, docket_number, docket_year, fee_number, 
							fee_type, fee_amount, amount_received, balance_due )
							VALUES 
							('D', :i_lDockNum, :i_iDockYear, 99, 
							'OP', :s_dOverpayment, :s_dOverpayment, 0);
						// error check
						If SQLCA.SQLCode = -1 Then
							MessageBox("System Error","Fee Overpayment 2 Insert Error - " + SQLCA.SQLErrText)
							ROLLBACK;
						Else
							COMMIT;
						End If										

						INSERT INTO sh_docket_fee_paid 
						   (cb_type, docket_number, docket_year, fee_number, cbrec_year, 
							cbrec_number, amount_received, date_received, new_balance_disbursed,
							new_amount_disbursed )
							VALUES 
							('D', :i_lDockNum, :i_iDockYear, 99, :i_iCBRecYear, 
							:i_lCBRecNum, :s_dOverpayment, :i_dtRecDate, :s_dOverpayment, 0);
						// error check
						If SQLCA.SQLCode = -1 Then
							MessageBox("System Error","Fee Paid Insert Error - " + SQLCA.SQLErrText)
							ROLLBACK;
						Else
							COMMIT;
						End If	

					Case 0  // Fee Found																				
						s_dAmountRec = s_dAmountRec + s_dOverpayment
						UPDATE sh_docket_fee
							SET sh_docket_fee.amount_received = :s_dAmountRec										
							WHERE sh_docket_fee.cb_type = 'D'
							AND sh_docket_fee.docket_year = :i_iDockYear
							AND sh_docket_fee.docket_number = :i_lDockNum					
							AND sh_docket_fee.fee_number = 99;
						COMMIT;	
						
						SELECT amount_received INTO :s_dFeePaidAmtRec
							FROM sh_docket_fee_paid
							WHERE sh_docket_fee_paid.cb_type = 'D'
							AND sh_docket_fee_paid.docket_year = :i_iDockYear
							AND sh_docket_fee_paid.docket_number = :i_lDockNum					
							AND sh_docket_fee_paid.fee_number = 99
							AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
							AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum
							AND sh_docket_fee_paid.date_received = :i_dtRecDate;
						Choose Case SQLCA.SQLCODE
							Case 100  // Fee Paid Not Found																					
								INSERT INTO sh_docket_fee_paid 
								   (cb_type, docket_number, docket_year, fee_number, 
									cbrec_year, cbrec_number, amount_received, date_received )
									VALUES 
									('D', :i_lDockNum, :i_iDockYear, 99, 
									:i_iCBRecYear, :i_lCBRecNum, :s_dOverpayment, :i_dtRecDate);
								// error check
								If SQLCA.SQLCode = -1 Then
									MessageBox("System Error","Fee Paid Insert Error - " + SQLCA.SQLErrText)
									ROLLBACK;
								Else
									COMMIT;
								End If	

							Case 0  // Fee Paid Found																																	
								s_dAmountRec = s_dAmountRec + s_dOverpayment
								UPDATE sh_docket_fee_paid
									SET sh_docket_fee_paid.date_received = :s_dtRecDate,
										sh_docket_fee_paid.amount_received = :s_dAmountRec
										sh_docket_fee_paid.new_balance_disbursed = :s_dAmountRec
									WHERE sh_docket_fee_paid.cb_type = 'D'
									AND sh_docket_fee_paid.docket_year = :i_iDockYear
									AND sh_docket_fee_paid.docket_number = :i_lDockNum					
									AND sh_docket_fee_paid.fee_number = 99
									AND sh_docket_fee_paid.cbrec_year = :i_iCBRecYear
									AND sh_docket_fee_paid.cbrec_number = :i_lCBRecNum;							
								// error check
								If SQLCA.SQLCode = -1 Then
									MessageBox("System Error","Fee Paid 4 Insert Error - " + SQLCA.SQLErrText)
									ROLLBACK;
								Else
									COMMIT;
								End If								

						End Choose
						
				End Choose	
			End If	
		ElseIf s_dTotalReceived > i_dTotRcvd Then
			MessageBox("Overpayment","The amount entered for individual fees is greater than the total amount entered.  The amount will be recorded as " + String(s_dTotalReceived) + ".  The docket cash receipt record may need to be updated.", Information!, Ok!)
		End If
End Choose		
cb_main.TriggerEvent("clicked")
i_achOpType = ""
i_iCBRecYear = 0
i_lCBRecNum = 0
end event

type st_receipt_total from statictext within w_inquire_docket_receipt_sheet
boolean visible = false
integer x = 2025
integer y = 800
integer width = 352
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 16711680
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_receipt_balance from statictext within w_inquire_docket_receipt_sheet
boolean visible = false
integer x = 2807
integer y = 800
integer width = 352
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 16711680
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_receipt_total_text from statictext within w_inquire_docket_receipt_sheet
boolean visible = false
integer x = 1719
integer y = 808
integer width = 297
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Rec. Total:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_receipt_balance_text from statictext within w_inquire_docket_receipt_sheet
boolean visible = false
integer x = 2427
integer y = 808
integer width = 370
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Rec. Balance:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_reminder from statictext within w_inquire_docket_receipt_sheet
boolean visible = false
integer x = 2551
integer y = 1536
integer width = 498
integer height = 212
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 255
boolean enabled = false
string text = "** REMINDER:  Press <Tab> AFTER each amount entered! **"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

