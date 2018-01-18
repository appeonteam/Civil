$PBExportHeader$w_docket_disbursement_sheet.srw
forward
global type w_docket_disbursement_sheet from w_base_sheet
end type
type gb_d from groupbox within w_docket_disbursement_sheet
end type
type gb_m from groupbox within w_docket_disbursement_sheet
end type
type cb_main from commandbutton within w_docket_disbursement_sheet
end type
type cb_disburse from commandbutton within w_docket_disbursement_sheet
end type
type cb_disburse_one from commandbutton within w_docket_disbursement_sheet
end type
type cb_close from commandbutton within w_docket_disbursement_sheet
end type
type dw_check from datawindow within w_docket_disbursement_sheet
end type
type cb_print_check from commandbutton within w_docket_disbursement_sheet
end type
end forward

global type w_docket_disbursement_sheet from w_base_sheet
integer x = 40
integer y = 29
integer width = 3756
integer height = 2118
string title = "Docket Disbursement Information"
windowstate windowstate = normal!
toolbaralignment toolbaralignment = alignatleft!
gb_d gb_d
gb_m gb_m
cb_main cb_main
cb_disburse cb_disburse
cb_disburse_one cb_disburse_one
cb_close cb_close
dw_check dw_check
cb_print_check cb_print_check
end type
global w_docket_disbursement_sheet w_docket_disbursement_sheet

type variables
string i_achSaveSQL, i_achMode, i_achNewSQL
integer i_iDockYear, i_iCBDisYear
long i_lDockNum, i_lCBDisNum
boolean i_bFirstSearch, i_bExit, i_bContinueItem, i_bName
boolean i_bRecon, i_bNew, i_bReceived
boolean i_bMemo, i_bButtonOnly
st_disburseparms i_stparms



end variables

on w_docket_disbursement_sheet.create
int iCurrent
call super::create
this.gb_d=create gb_d
this.gb_m=create gb_m
this.cb_main=create cb_main
this.cb_disburse=create cb_disburse
this.cb_disburse_one=create cb_disburse_one
this.cb_close=create cb_close
this.dw_check=create dw_check
this.cb_print_check=create cb_print_check
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_d
this.Control[iCurrent+2]=this.gb_m
this.Control[iCurrent+3]=this.cb_main
this.Control[iCurrent+4]=this.cb_disburse
this.Control[iCurrent+5]=this.cb_disburse_one
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.dw_check
this.Control[iCurrent+8]=this.cb_print_check
end on

on w_docket_disbursement_sheet.destroy
call super::destroy
destroy(this.gb_d)
destroy(this.gb_m)
destroy(this.cb_main)
destroy(this.cb_disburse)
destroy(this.cb_disburse_one)
destroy(this.cb_close)
destroy(this.dw_check)
destroy(this.cb_print_check)
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

dw_detail.DataObject = "dw_docket_disburse_detail"

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
	" suffix.tabsequence = 0" + &									
	" check_number.background.color = " + s_achDWColor + & 
	" check_number.tabsequence = 0" + &
	" amount_paid.background.color = " + s_achDWColor + & 
	" amount_paid.tabsequence = 0")								
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

If dw_scan.Retrieve(i_stparms.achCBType, i_stparms.iDockYear, i_stparms.lDockNum, "O") = 0 Then
	MessageBox("Complete", "No Docket Disbursement rows found.")

	dw_scan.SetFocus()
Else
	
   dw_scan.SetFocus()

	// RowFocusChanged Trigger for Title Refreshment
	dw_detail.TriggerEvent(RowFocusChanged!)			
End If

end event

event open;datawindowchild	dwc

SetPointer(HourGlass!)

//this.Width = dw_scan.width + dw_scan.x + 1100  
i_stparms = Message.PowerObjectParm

SetPointer(Hourglass!)

w_docket_disbursement_sheet.Title = "Docket Disbursement Information - " + &
	String(i_stparms.iDockYear) + "  " + 	String(i_stparms.lDockNum)
dw_detail.Tag = "Docket Disbursement Information"
dw_detail.DataObject = "dw_docket_disburse_detail"
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
gnv_resize.of_Register(gb_d, gnv_resize.SCALE)
gnv_resize.of_Register(gb_m, gnv_resize.SCALE)

gnv_resize.of_Register(cb_close, gnv_resize.SCALE)
gnv_resize.of_Register(cb_disburse, gnv_resize.SCALE)
gnv_resize.of_Register(cb_disburse_one, gnv_resize.SCALE)
gnv_resize.of_Register(cb_main, gnv_resize.SCALE)
gnv_resize.of_Register(cb_print_check, gnv_resize.SCALE)

i_bFirstSearch = True

cb_search.PostEvent(clicked!)
dw_detail.SetFocus()

g_bReceived = False

cb_main.enabled = False
cb_disburse.enabled = True

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
gb_d.pointer="arrow!"
gb_m.pointer="arrow!"
end event

event ue_next;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_docket_disburse_detail"
		
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
	Case "dw_docket_disburse_detail"

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

event ue_val_fields;integer s_iRowCount, s_iRow, s_iCount, s_iDockYear, s_iCBDisYear
long s_lLineNum, s_lMaxNum, s_lCBDisNum

dw_detail.SetTransObject(SQLCA)
dw_detail.AcceptText()
Choose Case dw_detail.DataObject
	
	Case "dw_docket_disburse_detail"

		If IsNull(dw_detail.GetItemString(1,"last_name")) Or (trim(dw_detail.GetItemString(1,"last_name")) = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Last name MUST be entered!")
			dw_detail.SetColumn("last_name")
			dw_detail.SetFocus()
			Return
		End If	

End Choose		

Choose Case dw_detail.DataObject

	Case "dw_docket_disburse_detail"

		s_iRow = dw_detail.GetRow()
		s_iDockYear = dw_detail.GetItemNumber(s_iRow,"docket_year")		

		If i_achOpType = "Add" Then		

			s_iCBDisYear = Year(g_dtToday)
			SELECT MAX(cbdis_number) INTO :s_lCBDisNum
				FROM sh_docket_disbursement
				WHERE sh_docket_disbursement.cbdis_year = :s_iCBDisYear;
			If IsNull(s_lCBDisNum) Then s_lCBDisNum = 0
			s_lCBDisNum ++

			dw_detail.SetItem(s_iRow, "cbdis_number", s_lCBDisNum)

		End If			
		
End Choose   

end event

event ue_clear;call super::ue_clear;
i_achOpType = ""
i_bFirstSearch = True
g_bReceived = False
	
cb_first.enabled = False
m_main.m_general.m_first.enabled = False
cb_back.enabled = False
m_main.m_general.m_back.enabled = False
cb_next.enabled = False
m_main.m_general.m_next.enabled = False
cb_last.enabled = False
m_main.m_general.m_last.enabled = False

dw_detail.SetFocus()

dw_detail.Tag = "Docket Disbursement Information"
dw_detail.DataObject = "dw_docket_disburse_detail"
dw_detail.SetTransObject(SQLCA)

end event

event ue_first;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_docket_disburse_detail"
		
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

event ue_update;call super::ue_update;string s_achDWColor, s_achDDWColor
integer s_iRow, s_iScanRow

i_achOpType ="Update"

s_achDWColor = dw_scan.Describe("datawindow.color")
s_achDDWColor = dw_detail.Describe("datawindow.color")

s_iScanRow = dw_scan.GetRow()
s_iRow = dw_detail.GetRow()
Choose Case dw_detail.DataObject
			 
	Case "dw_docket_disburse_detail"

		dw_detail.SetRedraw(False)
		dw_detail.Modify("last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 3" + &						
			" first_name.background.color = " + s_achDWColor + & 
			" first_name.tabsequence = 4" + &						
			" middle_name.background.color = " + s_achDWColor + & 
			" middle_name.tabsequence = 5" + &									
			" suffix.background.color = " + s_achDWColor + & 
			" suffix.tabsequence = 6" + &									
			" check_number.background.color = " + s_achDWColor + & 
			" check_number.tabsequence = 8")
		dw_detail.SetColumn("last_name")						
		
End Choose 
dw_detail.SetRedraw(True)
dw_detail.SetRow(s_iRow)		
dw_detail.SetFocus()

end event

event ue_save;// script variables
string s_achDWColor, s_achErrText, s_achCBType
integer s_iRow, s_iCount, s_iDockYear, s_iCBDisYear
long s_lDockNum, s_lCBDisNum
decimal {2} s_dTotPaid

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
	Case "dw_docket_disburse_detail"

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
				" suffix.tabsequence = 0" + &									
				" disbursement_note.background.color = " + s_achDWColor + & 
				" disbursement_note.tabsequence = 0" + &														
				" check_number.background.color = " + s_achDWColor + & 
				" check_number.tabsequence = 0" + &
				" amount_paid.background.color = " + s_achDWColor + & 
				" amount_paid.tabsequence = 0")							
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
			s_iDockYear = dw_detail.GetItemNumber(s_iRow,"docket_year")
			s_lDockNum = dw_detail.GetItemNumber(s_iRow,"docket_number")			
			s_iCBDisYear = dw_detail.GetItemNumber(s_iRow,"cbdis_year")
			s_lCBDisNum = dw_detail.GetItemNumber(s_iRow,"cbdis_number")			
			s_dTotPaid = dw_detail.GetItemNumber(s_iRow,"amount_paid")						

			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)			
			If i_achOpType = "Add" Then			
				dw_scan.Modify("datawindow.table.select='" + i_achNewSQL + "'")			
			Else	
				dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
			End If

			dw_scan.Retrieve(s_achCBType, s_iDockYear, s_lDockNum, "O")

			integer s_sRow
			s_sRow = dw_scan.Find("cb_type = '" + s_achCBType + &
				"' AND docket_year = " + String(s_iDockYear) + &
				" AND docket_number = " + String(s_lDockNum) + &
				" AND cbdis_year = " + String(s_iCBDisYear) + &
				" AND cbdis_number = " + String(s_lCBDisNum), 0, dw_scan.RowCount())				

			If s_sRow = 0 Then s_sRow = 1
	
			// highlight only the closest row
			dw_scan.ScrollToRow(s_sRow)				
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(s_sRow, True)										
	
			dw_scan.SetRedraw(True)
			dw_scan.enabled = True			
/*
			st_disburseparms 	s_stparms			
			
			s_stparms.achCBType = s_achCBType
			s_stparms.iDockYear = s_iDockYear					
			s_stparms.lDockNum = s_lDockNum					
			s_stparms.iDisYear = s_iCBDisYear										
			s_stparms.iDisNum = s_lCBDisNum										
//			s_stparms.dtRecDate = s_dtRecDate
			s_stparms.wPrev = This
//			s_stparms.achOpType = i_achOpType
			s_stparms.dBalDisb = s_dTotPaid
			i_bReceived = True
			g_bReceived = False			
			
			OpenWithParm(w_docket_cash_receipts_detail,s_stparms)			
*/
	
		End If

End Choose

dw_scan.SetFocus()

end event

event ue_last;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_docket_disburse_detail"
		
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

event ue_new;call super::ue_new;datawindowchild dwc
string s_achDWColor, s_achName
integer s_iItemNum, s_iFY

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

dw_detail.Tag = "Docket Disbursement Information"
dw_detail.DataObject = "dw_docket_disburse_detail"
dw_detail.SetTransObject(SQLCA)

Choose Case dw_detail.DataObject
	Case "dw_docket_disburse_detail"

		dw_detail.Tag = "Docket Disbursement Information"		
		dw_detail.Reset()		
		dw_detail.InsertRow(0)

		dw_detail.SetItem(1,"cb_type", i_stparms.achCBType)																	
		dw_detail.SetItem(1,"docket_year", i_stparms.iDockYear)																	
		dw_detail.SetItem(1,"docket_number", i_stparms.lDockNum)																			
		dw_detail.SetItem(1,"cbdis_year", Year(Today()))
		dw_detail.SetItem(1,"cbdis_number", 0)
		dw_detail.SetItem(1,"date_paid", "")		
		dw_detail.SetItem(1,"last_name", "")																		
		dw_detail.SetItem(1,"first_name", "")																				
		dw_detail.SetItem(1,"middle_name", "")																				
		dw_detail.SetItem(1,"suffix", "")																				
		dw_detail.SetItem(1,"check_number", 0)		
		dw_detail.SetItem(1,"amount_paid", 0)																			
		dw_detail.SetItem(1,"balance_disbursed", 0)							
										
		dw_detail.SetRedraw(False)
		dw_detail.Modify("last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 3" + &						
			" first_name.background.color = " + s_achDWColor + & 
			" first_name.tabsequence = 4" + &						
			" middle_name.background.color = " + s_achDWColor + & 
			" middle_name.tabsequence = 5" + &									
			" suffix.background.color = " + s_achDWColor + & 
			" suffix.tabsequence = 6" + &			
			" check_number.background.color = " + s_achDWColor + & 
			" check_number.tabsequence = 8")
		dw_detail.SetRedraw(True)		
		
		i_iRow = 1
		dw_detail.SetRow(i_iRow)		
		dw_detail.ScrollToRow(i_iRow)								

End Choose	

dw_detail.SetFocus()

end event

event ue_delete;// script variables
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

event ue_add;// do nothing
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

type cb_escape from w_base_sheet`cb_escape within w_docket_disbursement_sheet
integer x = 3237
integer taborder = 70
end type

type cb_exit from w_base_sheet`cb_exit within w_docket_disbursement_sheet
boolean visible = false
integer x = 3485
end type

event cb_exit::clicked;close(parent)
end event

type cb_last from w_base_sheet`cb_last within w_docket_disbursement_sheet
integer x = 3485
end type

type cb_next from w_base_sheet`cb_next within w_docket_disbursement_sheet
integer x = 3485
end type

type cb_back from w_base_sheet`cb_back within w_docket_disbursement_sheet
integer x = 3485
end type

type cb_first from w_base_sheet`cb_first within w_docket_disbursement_sheet
integer x = 3485
integer taborder = 110
end type

type cb_save from w_base_sheet`cb_save within w_docket_disbursement_sheet
integer x = 3237
integer taborder = 80
end type

type cb_delete from w_base_sheet`cb_delete within w_docket_disbursement_sheet
integer x = 3237
end type

type cb_update from w_base_sheet`cb_update within w_docket_disbursement_sheet
integer x = 3237
end type

event cb_update::clicked;call super::clicked;i_achMode = ""
end event

type cb_add from w_base_sheet`cb_add within w_docket_disbursement_sheet
integer x = 3237
end type

type cb_new from w_base_sheet`cb_new within w_docket_disbursement_sheet
integer x = 3237
end type

type cb_clear from w_base_sheet`cb_clear within w_docket_disbursement_sheet
integer x = 3237
end type

type cb_search from w_base_sheet`cb_search within w_docket_disbursement_sheet
integer x = 3237
end type

type dw_detail from w_base_sheet`dw_detail within w_docket_disbursement_sheet
event ue_dwnkey pbm_dwnkey
event ue_continue_add pbm_custom13
integer x = 22
integer y = 886
integer width = 3160
integer height = 1046
integer taborder = 220
string dataobject = "dw_docket_disburse_detail"
end type

event dw_detail::ue_dwnkey;string s_achDWColor, s_achCBType
integer s_iRow, s_iCount, s_lCount, s_iDockYear
long s_lDockNum

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_docket_disburse_detail"
		
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
				dw_detail.Modify("last_name.background.color = " + s_achDWColor + & 
					" last_name.tabsequence = 0" + &						
					" first_name.background.color = " + s_achDWColor + & 
					" first_name.tabsequence = 0" + &						
					" middle_name.background.color = " + s_achDWColor + & 
					" middle_name.tabsequence = 0" + &									
					" suffix.background.color = " + s_achDWColor + & 
					" suffix.tabsequence = 0")
				dw_detail.SetRedraw(True)			

				s_iRow = dw_scan.GetRow()
	
				s_achCBType = Trim(dw_scan.GetItemString(s_iRow,"cb_type"))	
				s_iDockYear = dw_scan.GetItemNumber(s_iRow,"docket_year")
				s_lDockNum = dw_scan.GetItemNumber(s_iRow,"docket_number")
				
				dw_detail.Retrieve(s_achCBType, s_iDockYear, s_lDockNum)
			
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

event dw_detail::ue_tabenter;
Choose Case dw_detail.DataObject
		
	Case "dw_docket_disburse_detail"
		
		Send(Handle(this),256,9,Long(0,0))
		RETURN 1

	Case "dw_drainage_district_assmt_parcel_detail"
		
		Send(Handle(this),256,9,Long(0,0))
		RETURN 1

End Choose		

end event

event dw_detail::losefocus;call super::losefocus;g_bReceived = True
dw_detail.Update()
COMMIT;
end event

type dw_scan from w_base_sheet`dw_scan within w_docket_disbursement_sheet
integer x = 22
integer y = 26
integer width = 3160
integer height = 838
integer taborder = 160
string dataobject = "dw_docket_disburse_scan"
end type

event dw_scan::rowfocuschanged;datawindowchild	dwc
string s_achDistrict
long s_lCount, s_lRowCount, s_lCurrentRow, s_lRow
			
dw_detail.SetTransObject(SQLCA)

i_irow = dw_scan.GetRow()

If i_iRow > 0 Then
	
	Choose Case dw_detail.DataObject
		Case "dw_docket_disburse_detail"

			dw_detail.Tag = "Docket Disbursement Information"

			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(currentrow, True)
			
			dw_detail.Retrieve(dw_scan.GetItemString(i_irow, "cb_type"), &
				dw_scan.GetItemNumber(i_irow, "docket_year"), &
				dw_scan.GetItemNumber(i_irow, "docket_number"), &
				dw_scan.GetItemNumber(i_irow, "cbdis_year"), &
				dw_scan.GetItemNumber(i_irow, "cbdis_number"))				
				
			// RowFocusChanged Trigger for Title Refreshment
			dw_detail.TriggerEvent(RowFocusChanged!)				
			
	End Choose		

End If	
end event

type gb_5 from w_base_sheet`gb_5 within w_docket_disbursement_sheet
integer x = 3460
end type

type gb_4 from w_base_sheet`gb_4 within w_docket_disbursement_sheet
integer x = 3460
end type

type gb_1 from w_base_sheet`gb_1 within w_docket_disbursement_sheet
integer x = 3211
integer textsize = -9
end type

type gb_2 from w_base_sheet`gb_2 within w_docket_disbursement_sheet
integer x = 3211
end type

type cb_list from w_base_sheet`cb_list within w_docket_disbursement_sheet
integer x = 3485
integer taborder = 90
end type

type cb_detail from w_base_sheet`cb_detail within w_docket_disbursement_sheet
integer x = 3485
integer taborder = 100
end type

type gb_3 from w_base_sheet`gb_3 within w_docket_disbursement_sheet
integer x = 3460
end type

type gb_d from groupbox within w_docket_disbursement_sheet
integer x = 3211
integer y = 1459
integer width = 497
integer height = 272
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_m from groupbox within w_docket_disbursement_sheet
integer x = 3211
integer y = 861
integer width = 497
integer height = 323
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_main from commandbutton within w_docket_disbursement_sheet
integer x = 3237
integer y = 912
integer width = 450
integer height = 67
integer taborder = 170
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
integer s_iItemNum, s_iDockYear, s_iCBDisYear
long s_lCount, s_lDockNum, s_lCBDisNum

dw_scan.enabled = True

cb_main.enabled = False
cb_disburse.enabled = True
//cb_apply.visible = False

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
s_iCBDisYear = dw_scan.GetItemNumber(i_iRow, "cbdis_year")
s_lCBDisNum = dw_scan.GetItemNumber(i_iRow, "cbdis_number")

dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Disbursement Information"

SELECT COUNT(*) INTO :s_iItemNum
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.cb_type = :s_achCBType
	AND sh_docket_disbursement.cbdis_year = :s_iCBDisYear
	AND sh_docket_disbursement.cbdis_number = :s_lCBDisNum;	
If s_iItemNum = 0 Then
	// Not found, Okay to insert Docket Disbursement Information
	// Security - Add Docket Disbursement Information
	If w_main.dw_perms.Find("code=46", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_new.enabled = True		
		m_main.m_general.m_new.enabled = True
	End If

	dw_detail.DataObject = "dw_cash_disburse_detail"
	dw_detail.SetTransObject(SQLCA)

	// Security - Add Docket Disbursement Information
	If w_main.dw_perms.Find("code=46", 1, w_main.dw_perms.RowCount()) > 0 Then
		m_main.m_general.m_add.TriggerEvent("clicked")
	End If	
Else				
	// Found, Retrieve Docket Disbursement Information
	// Security - New Docket Disbursement Information
	If w_main.dw_perms.Find("code=46", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_new.enabled = True		
		m_main.m_general.m_new.enabled = True
	End If
	
	// Security - Update Docket Disbursement Information
	If w_main.dw_perms.Find("code=47", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_update.enabled = True					
		m_main.m_general.m_update.enabled = True
	End If
	
	// Security - Delete Docket Disbursement Information
	If w_main.dw_perms.Find("code=48", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_delete.enabled = True								
		m_main.m_general.m_delete.enabled = True
	End If

	dw_detail.DataObject = "dw_cash_disburse_detail"		
	dw_detail.SetTransObject(SQLCA)
	dw_detail.Tag = "Docket Disbursement Information"		

	dw_detail.Retrieve(s_achCBType, s_iCBDisYear, s_lCBDisNum)		
/*		
	Case -1  // Serious problems
		MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
*/
End If
			
dw_scan.SetFocus()			
end event

type cb_disburse from commandbutton within w_docket_disbursement_sheet
integer x = 3237
integer y = 986
integer width = 450
integer height = 67
integer taborder = 180
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

i_iCBDisYear = dw_scan.GetItemNumber(s_iRow, "cbdis_year")
i_lCBDisNum = dw_scan.GetItemNumber(s_iRow, "cbdis_number")

dw_detail.DataObject = "dw_docket_disburse_fee_paid_scan"
dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Disbursement Fee Paid Information"

i_achMode = "Continue"

dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Disbursement Fee Paid Information"

SELECT COUNT(*) INTO :s_iItemNum
	FROM sh_docket_fee_paid
	WHERE sh_docket_fee_paid.cb_type = 'D'	
	AND sh_docket_fee_paid.cbdis_year = :i_iCBDisYear
	AND sh_docket_fee_paid.cbdis_number = :i_lCBDisNum;
If s_iItemNum = 0 Then
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

	dw_detail.DataObject = "dw_docket_disburse_fee_paid_scan"
	dw_detail.SetTransObject(SQLCA)
	
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
	
	dw_detail.DataObject = "dw_docket_disburse_fee_paid_scan"		
	dw_detail.SetTransObject(SQLCA)
	dw_detail.Tag = "Docket Disbursement Fee Paid Information"

	// get Fee Type
	dw_detail.GetChild("fee_type", dwc)
	dwc.SetTransObject(SQLCA)
	dwc.Reset()
	dwc.Retrieve("FEE")

	dw_detail.Retrieve("D", i_iCBDisYear, i_lCBDisNum)		
	dw_detail.SetRowFocusIndicator(Hand!)
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

type cb_disburse_one from commandbutton within w_docket_disbursement_sheet
integer x = 3237
integer y = 1514
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
string text = "Disburse &One"
end type

event clicked;datawindowchild dwc
integer s_iRow, s_iDockYear, s_iCBDisYear, s_iCBRecYear, s_iPeriodNum
long s_lCount, s_lDisbursementRows, s_lTransNum, s_lDockNum, s_lCBDisNum, s_lCBRecNum
long s_lReceiptNum, s_lCheckNum
string s_achDisburseType, s_achWhomDue, s_achFeeType, s_achDoc, s_achCaseNum, s_achStatus, s_achCBType
decimal {2} s_dAmtRcvd, s_dBalDisp, s_dTotAmtRcvd
datetime s_dtRecDateTime
date s_dtRecDate

s_iRow = dw_scan.GetRow()

s_iCBDisYear = dw_scan.GetItemNumber(s_iRow, "cbdis_year")
s_lCBDisNum = dw_scan.GetItemNumber(s_iRow, "cbdis_number")

datastore lds_Disbursement

// allocate the resources for the datastores
lds_Disbursement = Create DataStore
			
lds_Disbursement.DataObject = 'dw_docket_disburse_fee_paid_ds'
lds_Disbursement.SetTransObject(SQLCA)

SELECT disburse_status INTO :s_achStatus
	FROM sh_docket_disbursement
	WHERE cb_type = 'D'
	AND sh_docket_disbursement.cbdis_year = :s_iCBDisYear
	AND sh_docket_disbursement.cbdis_number = :s_lCBDisNum;
If (s_achStatus = 'W' or s_achStatus = 'C') Then
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
s_lDisbursementRows = lds_Disbursement.Retrieve("D", s_iCBDisYear, s_lCBDisNum, "O")
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
		WHERE sh_docket_receipt.cb_type = 'D'
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

		Case 'D'
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

UPDATE sh_docket_disbursement
	SET check_number = :s_lCheckNum,
		 disburse_status = 'W',
		 date_paid = :g_dttoday,
		 reconcile = 'N'
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

dw_detail.DataObject = "dw_docket_disburse_detail"		
dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Disbursement Information"


cb_search.TriggerEvent("clicked")

cb_main.enabled = False
cb_disburse.enabled = True

MessageBox("Disbursement Information", "Disbursement Complete!")


end event

type cb_close from commandbutton within w_docket_disbursement_sheet
integer x = 3237
integer y = 1082
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
string text = "&Close Disb"
end type

event clicked;close(parent)
end event

type dw_check from datawindow within w_docket_disbursement_sheet
boolean visible = false
integer x = 1496
integer y = 1059
integer width = 1072
integer height = 368
boolean bringtotop = true
string dataobject = "dw_civil_docket_check_rpt"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_print_check from commandbutton within w_docket_disbursement_sheet
integer x = 3237
integer y = 1635
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
dw_check.Retrieve('W', 'D', 'FEE', s_lCheckNum, s_lCheckNum)	

MessageBox("Check in Printer", "Put Check Number " + string(s_lCheckNum) + " in the Printer!", Information!)

// Printer Setup and Printout depending on current detail window
OpenWithParm(w_datawindow_print_dialog,dw_check)


end event

