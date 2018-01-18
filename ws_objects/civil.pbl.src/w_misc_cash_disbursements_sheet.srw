$PBExportHeader$w_misc_cash_disbursements_sheet.srw
forward
global type w_misc_cash_disbursements_sheet from w_base_sheet
end type
type sle_lname from singlelineedit within w_misc_cash_disbursements_sheet
end type
type sle_fname from singlelineedit within w_misc_cash_disbursements_sheet
end type
type st_1 from statictext within w_misc_cash_disbursements_sheet
end type
type st_2 from statictext within w_misc_cash_disbursements_sheet
end type
type st_6 from statictext within w_misc_cash_disbursements_sheet
end type
type em_from_date from editmask within w_misc_cash_disbursements_sheet
end type
type em_to_date from editmask within w_misc_cash_disbursements_sheet
end type
type st_7 from statictext within w_misc_cash_disbursements_sheet
end type
type cb_apply from commandbutton within w_misc_cash_disbursements_sheet
end type
type gb_d from groupbox within w_misc_cash_disbursements_sheet
end type
type gb_m from groupbox within w_misc_cash_disbursements_sheet
end type
type cb_main from commandbutton within w_misc_cash_disbursements_sheet
end type
type cb_disburse from commandbutton within w_misc_cash_disbursements_sheet
end type
type cb_process_disburse from commandbutton within w_misc_cash_disbursements_sheet
end type
type st_message from statictext within w_misc_cash_disbursements_sheet
end type
type dw_check from datawindow within w_misc_cash_disbursements_sheet
end type
type cb_print_check from commandbutton within w_misc_cash_disbursements_sheet
end type
end forward

global type w_misc_cash_disbursements_sheet from w_base_sheet
integer x = 66
integer y = 16
integer width = 3690
integer height = 2067
string title = "Miscellaneous Cash Disbursements"
windowstate windowstate = normal!
toolbaralignment toolbaralignment = alignatleft!
event ue_totals pbm_custom18
sle_lname sle_lname
sle_fname sle_fname
st_1 st_1
st_2 st_2
st_6 st_6
em_from_date em_from_date
em_to_date em_to_date
st_7 st_7
cb_apply cb_apply
gb_d gb_d
gb_m gb_m
cb_main cb_main
cb_disburse cb_disburse
cb_process_disburse cb_process_disburse
st_message st_message
dw_check dw_check
cb_print_check cb_print_check
end type
global w_misc_cash_disbursements_sheet w_misc_cash_disbursements_sheet

type variables
boolean i_bFirstSearch, i_bReceived, i_bButtonOnly
boolean i_bExit, i_bNew, i_bContinueItem
string i_achMode, i_achCBType, i_achLName, i_achFName
string i_achSaveSQL, i_achNewSQL
integer i_iCBYear, i_iDockYear, i_iCBDisYear
long i_lCBNum, i_lDockNum, i_lCBDisNum
date i_dtPaidDate, i_dtFromPaidDate, i_dtToPaidDate
end variables

on w_misc_cash_disbursements_sheet.create
int iCurrent
call super::create
this.sle_lname=create sle_lname
this.sle_fname=create sle_fname
this.st_1=create st_1
this.st_2=create st_2
this.st_6=create st_6
this.em_from_date=create em_from_date
this.em_to_date=create em_to_date
this.st_7=create st_7
this.cb_apply=create cb_apply
this.gb_d=create gb_d
this.gb_m=create gb_m
this.cb_main=create cb_main
this.cb_disburse=create cb_disburse
this.cb_process_disburse=create cb_process_disburse
this.st_message=create st_message
this.dw_check=create dw_check
this.cb_print_check=create cb_print_check
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_lname
this.Control[iCurrent+2]=this.sle_fname
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_6
this.Control[iCurrent+6]=this.em_from_date
this.Control[iCurrent+7]=this.em_to_date
this.Control[iCurrent+8]=this.st_7
this.Control[iCurrent+9]=this.cb_apply
this.Control[iCurrent+10]=this.gb_d
this.Control[iCurrent+11]=this.gb_m
this.Control[iCurrent+12]=this.cb_main
this.Control[iCurrent+13]=this.cb_disburse
this.Control[iCurrent+14]=this.cb_process_disburse
this.Control[iCurrent+15]=this.st_message
this.Control[iCurrent+16]=this.dw_check
this.Control[iCurrent+17]=this.cb_print_check
end on

on w_misc_cash_disbursements_sheet.destroy
call super::destroy
destroy(this.sle_lname)
destroy(this.sle_fname)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_6)
destroy(this.em_from_date)
destroy(this.em_to_date)
destroy(this.st_7)
destroy(this.cb_apply)
destroy(this.gb_d)
destroy(this.gb_m)
destroy(this.cb_main)
destroy(this.cb_disburse)
destroy(this.cb_process_disburse)
destroy(this.st_message)
destroy(this.dw_check)
destroy(this.cb_print_check)
end on

event ue_search;call super::ue_search;// script variables
integer s_iFromPaidYear, s_iFromPaidMonth, s_iFromPaidDay, s_iNumRows, s_iDockYear, s_iDockNum
string s_achSQL, s_achFromPaid, s_achFromPaidYear, s_achFromPaidMonth, s_achFromPaidDay, s_achDWColor
date s_dtFromPaidDate
integer s_iToPaidYear, s_iToPaidMonth, s_iToPaidDay
string s_achToPaid, s_achToPaidYear, s_achToPaidMonth, s_achToPaidDay
date s_dtToPaidDate
integer s_iBusNum
string s_achSSAN

SetPointer(HourGlass!)

cb_add.enabled = False
m_main.m_general.m_add.enabled = False

// Security - Add Docket Cash Disbursement Information
If w_main.dw_perms.Find("code=54", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_new.enabled = True
	m_main.m_general.m_new.enabled = True
End If

// Security - Update Docket Cash Disbursement Information
If w_main.dw_perms.Find("code=55", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_update.enabled = True
	m_main.m_general.m_update.enabled = True
End If

// Security - Delete Docket Cash Disbursement Information
If w_main.dw_perms.Find("code=56", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_delete.enabled = True	
	m_main.m_general.m_delete.enabled = True
End If

s_achDWColor = dw_detail.Describe("datawindow.color")

dw_detail.DataObject = "dw_cash_disburse_detail"

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
	" disburse_note.background.color = " + s_achDWColor + & 
	" disburse_note.tabsequence = 0" + &														
	" check_number.background.color = " + s_achDWColor + & 
	" check_number.tabsequence = 0")
dw_detail.SetRedraw(True)			
dw_scan.enabled = True

i_achLName = Trim(sle_lname.text)
i_achFName = Trim(sle_fname.text)

SetNull(i_dtFromPaidDate)

s_achFromPaid = Trim(String(em_from_date.text))
s_achFromPaidYear = Mid(s_achFromPaid,7,4)
s_achFromPaidMonth = Mid(s_achFromPaid,1,2)
s_achFromPaidDay = Mid(s_achFromPaid,4,2)
s_iFromPaidYear = Integer(s_achFromPaidYear)
s_iFromPaidMonth = Integer(s_achFromPaidMonth)
s_iFromPaidDay = Integer(s_achFromPaidDay)
s_dtFromPaidDate = Date(s_iFromPaidYear, s_iFromPaidMonth, s_iFromPaidDay)
If s_achFromPaid <> "" Then
	i_dtFromPaidDate = s_dtFromPaidDate
End If	

SetNull(i_dtToPaidDate)

s_achToPaid = Trim(String(em_to_date.text))
s_achToPaidYear = Mid(s_achToPaid,7,4)
s_achToPaidMonth = Mid(s_achToPaid,1,2)
s_achToPaidDay = Mid(s_achToPaid,4,2)
s_iToPaidYear = Integer(s_achToPaidYear)
s_iToPaidMonth = Integer(s_achToPaidMonth)
s_iToPaidDay = Integer(s_achToPaidDay)
s_dtToPaidDate = Date(s_iToPaidYear, s_iToPaidMonth, s_iToPaidDay)
If s_achToPaid <> "" Then
	i_dtToPaidDate = s_dtToPaidDate
End If	

// didn't pick a last name

If i_achLName = "" Then
	// didn't pick a first name
   If sle_fname.text <> "" Then
	   // picked a first name
      s_achSQL = &
         " WHERE sh_docket_disbursement.first_name LIKE ~~~'" + i_achFName + "%" + "~~~'" 
	End If
Else
	// picked a last name
	s_achSQL = &
         " WHERE sh_docket_disbursement.last_name LIKE ~~~'" + i_achLName + "%" + "~~~'" 
	If sle_fname.text <> "" Then
		// picked a last and a first name
		s_achSQL += &
        " AND sh_docket_disbursement.first_name LIKE ~~~'" + i_achFName + "%" + "~~~'" 
   End If
End If

If s_achFromPaid <> "" And Not IsNull(s_achFromPaid) Then
   If Len(s_achSQL) = 0 Then
      s_achSQL = &
         " WHERE sh_docket_disbursement.date_paid <= ~~~'" + String(i_dtFromPaidDate, "yyyy-mm-dd") + "~~~'" 
   Else 
		s_achSQL += &
         " AND sh_docket_disbursement.date_paid <= ~~~'" + String(i_dtFromPaidDate, "yyyy-mm-dd") + "~~~'" 
   End If
End If

If s_achToPaid <> "" And Not IsNull(s_achToPaid) Then
   If Len(s_achSQL) = 0 Then
      s_achSQL = &
         " WHERE sh_docket_disbursement.date_paid >= ~~~'" + String(i_dtToPaidDate, "yyyy-mm-dd") + "~~~'" 
   Else 
		s_achSQL += &
         " AND sh_docket_disbursement.date_paid >= ~~~'" + String(i_dtToPaidDate, "yyyy-mm-dd") + "~~~'" 
   End If
End If

If Len(s_achSQL) = 0 Then
	s_achSQL = &	
   	" WHERE sh_docket_disbursement.cb_type = ~~~'" + i_achCBType + "~~~'" 	
Else
	s_achSQL += &	
   	" AND sh_docket_disbursement.cb_type = ~~~'" + i_achCBType + "~~~'" 	
End If 

s_achSQL += &
   " ORDER BY sh_docket_disbursement.cbdis_year DESC, sh_docket_disbursement.cbdis_number DESC" 

dw_scan.enabled = True

s_achSQL = i_achSQL + s_achSQL
i_achSaveSQL = s_achSQL

dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")

dw_scan.Reset()
If dw_scan.Retrieve() = 0 Then
	MessageBox("Complete", "No Cash Disbursement rows found.")

	sle_lname.text = ""
	sle_fname.text = ""
	sle_lname.SetFocus()
Else
	cb_main.enabled = False
	cb_disburse.enabled = True
	
   dw_scan.SetFocus()
End If
end event

event open;//  Used wih Docket Cash Receipt Section - Overrides Ancestor Script
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
gnv_resize.of_Register(em_from_date, gnv_resize.SCALE)
gnv_resize.of_Register(em_to_date, gnv_resize.SCALE)
gnv_resize.of_Register(cb_add, gnv_resize.SCALE)
gnv_resize.of_Register(cb_back, gnv_resize.SCALE)
gnv_resize.of_Register(cb_clear, gnv_resize.SCALE)
gnv_resize.of_Register(cb_delete, gnv_resize.SCALE)
gnv_resize.of_Register(cb_detail, gnv_resize.SCALE)
gnv_resize.of_Register(cb_disburse, gnv_resize.SCALE)
gnv_resize.of_Register(cb_escape, gnv_resize.SCALE)
gnv_resize.of_Register(cb_exit, gnv_resize.SCALE)
gnv_resize.of_Register(cb_first, gnv_resize.SCALE)
gnv_resize.of_Register(cb_last, gnv_resize.SCALE)
gnv_resize.of_Register(cb_list, gnv_resize.SCALE)
gnv_resize.of_Register(cb_main, gnv_resize.SCALE)
gnv_resize.of_Register(cb_new, gnv_resize.SCALE)
gnv_resize.of_Register(cb_next, gnv_resize.SCALE)
gnv_resize.of_Register(cb_print_check, gnv_resize.SCALE)
gnv_resize.of_Register(cb_process_disburse, gnv_resize.SCALE)
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
gnv_resize.of_Register(sle_fname, gnv_resize.SCALE)
gnv_resize.of_Register(sle_lname, gnv_resize.SCALE)
gnv_resize.of_Register(st_message, gnv_resize.SCALE)
gnv_resize.of_Register(st_1, gnv_resize.SCALE)
gnv_resize.of_Register(st_2, gnv_resize.SCALE)
gnv_resize.of_Register(st_6, gnv_resize.SCALE)
gnv_resize.of_Register(st_7, gnv_resize.SCALE)

sle_lname.SetFocus()

i_achCBType = "M"
i_bFirstSearch = True
i_bReceived = False
g_bReceived = False
end event

event ue_next;		
Choose Case dw_detail.DataObject
	Case "dw_cash_disburse_detail"
		
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

event ue_back;		
Choose Case dw_detail.DataObject
	Case "dw_cash_disburse_detail"
		
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

event ue_clear;call super::ue_clear;
sle_lname.text = ""
sle_fname.text = ""

i_bFirstSearch = True
g_bReceived = False
i_bReceived = False
i_achOpType = ""
i_achCBType = "M"
i_iCBYear = 0
i_lCBNum = 0
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

dw_scan.enabled = True

end event

event ue_update;call super::ue_update;string s_achDWColor
integer s_iRow

i_achOpType ="Update"

s_achDWColor = dw_scan.Describe("datawindow.color")

s_iRow = dw_detail.GetRow()
Choose Case dw_detail.DataObject
	Case "dw_cash_disburse_detail"

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
			" suffix.tabsequence = 6" + &									
			" disburse_note.background.color = " + s_achDWColor + & 
			" disburse_note.tabsequence = 7")
		dw_detail.SetColumn("date_paid")			
			
End Choose

dw_detail.SetRedraw(True)
dw_detail.SetRow(s_iRow)		
dw_detail.SetFocus()

end event

event ue_val_fields;integer s_iRowCount, s_iRow, s_iCount, s_iCBDisYear
long s_lLineNum, s_lMaxNum, s_lCBDisNum

dw_detail.SetTransObject(SQLCA)
dw_detail.AcceptText()
Choose Case dw_detail.DataObject
	
	Case "dw_cash_disburse_detail"

		If IsNull(dw_detail.GetItemString(1,"last_name")) Or (dw_detail.GetItemString(1,"last_name") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Last name MUST be entered!")
			dw_detail.SetColumn("last_name")
			dw_detail.SetFocus()
			Return
		End If	

End Choose		

Choose Case dw_detail.DataObject

	Case "dw_cash_disburse_detail"

		s_iRow = dw_detail.GetRow()
		s_iCBDisYear = Year(Today())		

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

event ue_save;string s_achDWColor, s_achCBType, s_achWhomDue, s_achErrText
integer s_iCBYear, s_iDockYear, s_iCBDisYear
long s_lCBNum, s_lDockNum, s_lCBDisNum
datawindowchild dwc

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

	Case "dw_cash_disburse_detail"
		
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
				" suffix.tabsequence = 0" + &									
				" disburse_note.background.color = " + s_achDWColor + & 
				" disburse_note.tabsequence = 0" + &																	
				" check_number.background.color = " + s_achDWColor + & 
				" check_number.tabsequence = 0")
			dw_detail.SetRedraw(True)

			// Security - Add Docket Cash Disbursement Information
			If w_main.dw_perms.Find("code=54", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_new.enabled = True
				m_main.m_general.m_new.enabled = True
			End If
			
			// Security - Update Docket Cash Disbursement Information
			If w_main.dw_perms.Find("code=55", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_update.enabled = True				
				m_main.m_general.m_update.enabled = True
			End If
			
			// Security - Delete Docket Cash Disbursement Information
			If w_main.dw_perms.Find("code=56", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_delete.enabled = True				
				m_main.m_general.m_delete.enabled = True
			End If

			cb_escape.enabled = False
			m_main.m_general.m_escape.enabled = False
			cb_save.enabled = False
			m_main.m_general.m_save.enabled = False
			
			integer s_iRow

			i_iRow = dw_detail.GetRow()

			s_achCBType = dw_detail.GetItemString(i_iRow,"cb_type")
			s_iDockYear = dw_detail.GetItemNumber(i_iRow,"docket_year")
			s_lDockNum = dw_detail.GetItemNumber(i_iRow,"docket_number")				
			s_iCBDisYear = dw_detail.GetItemNumber(i_iRow,"cbdis_year")
			s_lCBDisNum = dw_detail.GetItemNumber(i_iRow,"cbdis_number")				

			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)			
			dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
			dw_scan.Retrieve() 						

			dw_scan.Retrieve(s_achCBType, s_iCBDisYear, s_lCBDisNum)

			integer s_sRow
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
/*
			st_disburseparms 	s_stparms			
			
			s_stparms.achCBType = i_achCBType
			s_stparms.iDockYear = s_iDockYear					
			s_stparms.lDockNum = s_lDockNum					
			s_stparms.iDisYear = s_iCBDisYear										
			s_stparms.iDisNum = s_lCBDisNum										
//			s_stparms.dtRecDate = s_dtRecDate
			s_stparms.wPrev = This
//			s_stparms.achOpType = i_achOpType
//			s_stparms.dBalDisb = s_dTotPaid
			i_bReceived = True
			
			OpenWithParm(w_cash_receipts_detail,s_stparms)			
*/
		End If
			
End Choose

dw_detail.SetFocus()

end event

event ue_first;		
Choose Case dw_detail.DataObject
	Case "dw_cash_disburse_detail"
		
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

event ue_last;		
Choose Case dw_detail.DataObject
	Case "dw_cash_disburse_detail"
		
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

event ue_new;datawindowchild dwc
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

// Security - Add Docket Cash Disbursement Information
If w_main.dw_perms.Find("code=54", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_escape.enabled = True
	m_main.m_general.m_escape.enabled = True	
	cb_save.enabled = True
	m_main.m_general.m_save.enabled = True
End If

// Security - Update Docket Cash Disbursement Information
If w_main.dw_perms.Find("code=55", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_escape.enabled = True
	m_main.m_general.m_escape.enabled = True		
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

// Security - Delete Docket Cash Disbursement Information
If w_main.dw_perms.Find("code=56", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_escape.enabled = True
	m_main.m_general.m_escape.enabled = True		
	cb_save.enabled = True	
	m_main.m_general.m_save.enabled = True
End If

dw_detail.Tag = "Miscellaneous Cash Disbursement Information"
dw_detail.DataObject = "dw_cash_disburse_detail"
dw_detail.SetTransObject(SQLCA)

Choose Case dw_detail.DataObject
	Case "dw_cash_disburse_detail"

		dw_detail.Tag = "Docket Cash Disbursement Information"		
		dw_detail.Reset()		
		dw_detail.InsertRow(0)

		dw_detail.SetItem(1,"cb_type", i_achCBType)																	
		dw_detail.SetItem(1,"docket_year", 0)			
		dw_detail.SetItem(1,"docket_number", 0)			
		
		If i_iCBYear <> 0 Then
			dw_detail.SetItem(1,"cbdis_year", i_iCBYear)
		Else	
			dw_detail.SetItem(1,"cbdis_year", Year(Today()))			
		End If	
		If i_lCBNum <> 0 Then
			dw_detail.SetItem(1,"cbdis_number", i_lCBNum)
		Else	
			dw_detail.SetItem(1,"cbdis_number", 0)			
		End If	
		
   	dw_detail.SetItem(1,"date_paid", "")		
		dw_detail.SetItem(1,"last_name", "")																		
		dw_detail.SetItem(1,"first_name", "")																				
		dw_detail.SetItem(1,"middle_name", "")																				
		dw_detail.SetItem(1,"suffix", "")																				
		dw_detail.SetItem(1,"check_number", 0)		
		dw_detail.SetItem(1,"amount_paid", 0)																			
		dw_detail.SetItem(1,"disburse_note", "")																			
		dw_detail.SetItem(1,"balance_disbursed", 0)							
										
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
			" suffix.tabsequence = 6" + &									
			" disburse_note.background.color = " + s_achDWColor + & 
			" disburse_note.tabsequence = 7" + &																
			" check_number.background.color = " + s_achDWColor + & 
			" check_number.tabsequence = 8")
		dw_detail.SetRedraw(True)		
		
		i_iRow = 1
		dw_detail.SetRow(i_iRow)		
		dw_detail.ScrollToRow(i_iRow)								

End Choose	

dw_detail.SetFocus()

end event

event ue_add;// override ancestor
end event

event resize;gnv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
end event

type cb_escape from w_base_sheet`cb_escape within w_misc_cash_disbursements_sheet
integer taborder = 110
end type

type cb_exit from w_base_sheet`cb_exit within w_misc_cash_disbursements_sheet
integer taborder = 200
end type

type cb_last from w_base_sheet`cb_last within w_misc_cash_disbursements_sheet
integer taborder = 190
end type

type cb_next from w_base_sheet`cb_next within w_misc_cash_disbursements_sheet
integer taborder = 180
end type

type cb_back from w_base_sheet`cb_back within w_misc_cash_disbursements_sheet
integer taborder = 160
end type

type cb_first from w_base_sheet`cb_first within w_misc_cash_disbursements_sheet
integer taborder = 150
end type

type cb_save from w_base_sheet`cb_save within w_misc_cash_disbursements_sheet
integer taborder = 120
end type

type cb_delete from w_base_sheet`cb_delete within w_misc_cash_disbursements_sheet
integer taborder = 100
end type

type cb_update from w_base_sheet`cb_update within w_misc_cash_disbursements_sheet
integer taborder = 90
end type

type cb_add from w_base_sheet`cb_add within w_misc_cash_disbursements_sheet
integer taborder = 80
end type

type cb_new from w_base_sheet`cb_new within w_misc_cash_disbursements_sheet
integer taborder = 70
end type

type cb_clear from w_base_sheet`cb_clear within w_misc_cash_disbursements_sheet
integer taborder = 60
end type

type cb_search from w_base_sheet`cb_search within w_misc_cash_disbursements_sheet
integer taborder = 50
end type

type dw_detail from w_base_sheet`dw_detail within w_misc_cash_disbursements_sheet
event ue_dwnkey pbm_dwnkey
integer y = 813
integer width = 3101
integer height = 995
integer taborder = 220
string dataobject = "dw_cash_disburse_detail"
boolean vscrollbar = true
end type

event dw_detail::ue_dwnkey;string s_achDWColor, s_achCBType
integer s_iRow, s_iCount, s_lCount, s_iDockYear, s_iCBDisYear
long s_lDockNum, s_lCBDisNum

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_cash_disburse_detail"
		
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "check_number"
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
					" disburse_note.background.color = " + s_achDWColor + & 
					" disburse_note.tabsequence = 0" + &																		
					" check_number.background.color = " + s_achDWColor + & 
					" check_number.tabsequence = 0")
				dw_detail.SetRedraw(True)			

				s_iRow = dw_scan.GetRow()
	
				s_achCBType = Trim(dw_scan.GetItemString(s_iRow,"cb_type"))	
				s_iCBDisYear = dw_scan.GetItemNumber(s_iRow,"cbdis_year")
				s_lCBDisNum = dw_scan.GetItemNumber(s_iRow,"cbdis_number")
				s_iDockYear = dw_scan.GetItemNumber(s_iRow,"docket_year")
				s_lDockNum = dw_scan.GetItemNumber(s_iRow,"docket_number")
				
				dw_detail.Retrieve(s_achCBType, s_iDockYear, s_lDockNum, s_iCBDisYear, s_lCBDisNum)
			
				dw_scan.enabled = True
			
				// Security - Add Docket Cash Disbursements Information
				If w_main.dw_perms.Find("code=54", 1, w_main.dw_perms.RowCount()) > 0 Then
					cb_new.enabled = True
					m_main.m_general.m_new.enabled = True
				End If
				
				// Security - Update Docket Cash Disbursements Information
				If w_main.dw_perms.Find("code=55", 1, w_main.dw_perms.RowCount()) > 0 Then
					cb_update.enabled = True					
					m_main.m_general.m_update.enabled = True
				End If

				// Security - Delete Docket Cash Disbursements Information
				If w_main.dw_perms.Find("code=56", 1, w_main.dw_perms.RowCount()) > 0 Then
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

event dw_detail::getfocus;call super::getfocus;//string s_achFromWhom
//integer s_iRow, s_iDockYear, s_iCBDisYear
//long s_lDockNum, s_lCBDisNum
//
//If g_bReceived Then
//	g_bReceived = False
//	cb_search.TriggerEvent("clicked")
//	
//	dw_scan.SetTransObject(SQLCA)
//	dw_scan.SetRedraw(False)							
//	dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
//	dw_scan.Retrieve() 			
//	
//	If s_iRow > 0 Then
//	
//		s_iDockYear = dw_scan.GetItemNumber(s_iRow,"docket_year")
//		s_lDockNum = dw_scan.GetItemNumber(s_iRow,"docket_number")
//		s_iCBDisYear = dw_scan.GetItemNumber(s_iRow,"cbdis_year")
//		s_lCBDisNum = dw_scan.GetItemNumber(s_iRow,"cbdis_number")
//		
//		// find the row closest to this one
//		s_iRow = dw_scan.Find("cb_type = '" + i_achCBType + &
//			"' AND docket_year = " + String(s_iDockYear) + &
//			" AND docket_number = " + String(s_lDockNum) + &
//			" AND cbdis_year = " + String(s_iCBDisYear) + &				
//			" AND cbdis_number = " + String(s_lCBDisNum), 0, dw_scan.RowCount())
//		
//		If s_iRow = 0 Then s_iRow = 1
//		
//		// highlight only the closest row
//		dw_scan.ScrollToRow(s_iRow)				
//		dw_scan.SetRowFocusIndicator(Hand!)				
//					
//		dw_scan.SetRedraw(True)				
//		dw_scan.enabled = True
//	End If
//	
//	s_iRow = dw_scan.GetRow()
//	If s_iRow > 0 Then
//		dw_detail.Retrieve(dw_scan.GetItemString(s_irow, "cb_type"), &
//			dw_scan.GetItemNumber(s_irow, "docket_year"), &
//			dw_scan.GetItemNumber(s_irow, "docket_number"), &
//			dw_scan.GetItemNumber(s_irow, "cbdis_year"), &
//			dw_scan.GetItemNumber(s_irow, "cbdis_number"))
//	End If
//
//	dw_scan.SetTransObject(SQLCA)
//	dw_scan.SetRedraw(False)							
//	dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
//	dw_scan.Retrieve() 			
//	
//	If s_iRow > 0 Then
//	
//		s_iDockYear = dw_scan.GetItemNumber(s_iRow,"docket_year")
//		s_lDockNum = dw_scan.GetItemNumber(s_iRow,"docket_number")
//		s_iCBDisYear = dw_scan.GetItemNumber(s_iRow,"cbdis_year")
//		s_lCBDisNum = dw_scan.GetItemNumber(s_iRow,"cbdis_number")
//		
//		// find the row closest to this one
//		s_iRow = dw_scan.Find("cb_type = '" + i_achCBType + &
//			"' AND docket_year = " + String(s_iDockYear) + &
//			" AND docket_number = " + String(s_lDockNum) + &
//			" AND cbdis_year = " + String(s_iCBDisYear) + &				
//			" AND cbdis_number = " + String(s_lCBDisNum), 0, dw_scan.RowCount())
//		
//		If s_iRow = 0 Then s_iRow = 1
//		
//		// highlight only the closest row
//		dw_scan.ScrollToRow(s_iRow)				
//		dw_scan.SetRowFocusIndicator(Hand!)				
//					
//		dw_scan.SetRedraw(True)				
//		dw_scan.enabled = True
//	End If
//
//End If	
end event

event dw_detail::losefocus;call super::losefocus;//g_bReceived = True
//dw_detail.Update()
//COMMIT;
end event

event dw_detail::ue_tabenter;
Choose Case dw_detail.DataObject
		
	Case "dw_cash_disburse_detail"
		
		Send(Handle(this),256,9,Long(0,0))
		RETURN 1

End Choose		

end event

type dw_scan from w_base_sheet`dw_scan within w_misc_cash_disbursements_sheet
integer y = 205
integer width = 3101
integer height = 512
integer taborder = 210
string dataobject = "dw_misc_cash_disburse_scan"
end type

event dw_scan::rowfocuschanged;integer s_iRow
datawindowchild dwc

dw_detail.SetTransObject(SQLCA)

s_iRow = dw_scan.GetRow()
If s_iRow > 0 Then
	Choose Case dw_detail.DataObject
		Case "dw_cash_disburse_detail"
			
			dw_detail.Tag = "Miscellaneous Cash Disbursement Information"
			
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(currentrow, True)
			
			dw_detail.Tag = "Miscellaneous Cash Disbursement Information"
			dw_detail.Retrieve(dw_scan.GetItemString(s_iRow, "cb_type"), &
				dw_scan.GetItemNumber(s_iRow, "cbdis_year"), &
				dw_scan.GetItemNumber(s_iRow, "cbdis_number"))

			// RowFocusChanged Trigger for Title Refreshment
			dw_detail.TriggerEvent(RowFocusChanged!)				
	
	End Choose

End If	
end event

type gb_5 from w_base_sheet`gb_5 within w_misc_cash_disbursements_sheet
end type

type gb_4 from w_base_sheet`gb_4 within w_misc_cash_disbursements_sheet
end type

type gb_1 from w_base_sheet`gb_1 within w_misc_cash_disbursements_sheet
end type

type gb_2 from w_base_sheet`gb_2 within w_misc_cash_disbursements_sheet
end type

type cb_list from w_base_sheet`cb_list within w_misc_cash_disbursements_sheet
integer taborder = 130
end type

type cb_detail from w_base_sheet`cb_detail within w_misc_cash_disbursements_sheet
integer taborder = 140
end type

type gb_3 from w_base_sheet`gb_3 within w_misc_cash_disbursements_sheet
end type

type sle_lname from singlelineedit within w_misc_cash_disbursements_sheet
integer x = 358
integer y = 13
integer width = 1108
integer height = 83
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

type sle_fname from singlelineedit within w_misc_cash_disbursements_sheet
integer x = 2070
integer y = 13
integer width = 563
integer height = 83
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

type st_1 from statictext within w_misc_cash_disbursements_sheet
integer x = 4
integer y = 22
integer width = 344
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

type st_2 from statictext within w_misc_cash_disbursements_sheet
integer x = 1660
integer y = 22
integer width = 395
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

type st_6 from statictext within w_misc_cash_disbursements_sheet
integer x = 4
integer y = 122
integer width = 344
integer height = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Date From:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_from_date from editmask within w_misc_cash_disbursements_sheet
integer x = 358
integer y = 109
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
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
boolean spin = true
string displaydata = ""
end type

type em_to_date from editmask within w_misc_cash_disbursements_sheet
integer x = 1057
integer y = 109
integer width = 410
integer height = 83
integer taborder = 40
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

type st_7 from statictext within w_misc_cash_disbursements_sheet
integer x = 786
integer y = 122
integer width = 260
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Date To:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_apply from commandbutton within w_misc_cash_disbursements_sheet
boolean visible = false
integer x = 2487
integer y = 1686
integer width = 549
integer height = 86
integer taborder = 170
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Disbursements..."
end type

event clicked;/*
string s_achDWColor, s_achCBType
integer s_iCBYear, s_iDockYear
long s_lCBNum, s_lDockNum

i_iRow = dw_detail.GetRow()

s_achCBType = dw_detail.GetItemString(i_iRow, "cb_type")
s_lDockNum = dw_detail.GetItemNumber(i_iRow, "docket_number")
s_iDockYear = dw_detail.GetItemNumber(i_iRow, "docket_year")					
s_lCBNum = dw_detail.GetItemNumber(i_iRow, "cbdis_number")
s_iCBYear = dw_detail.GetItemNumber(i_iRow, "cbdis_year")			

st_disburseparms 	s_stparms			

s_stparms.achCBType = s_achCBType
s_stparms.iDockYear = s_iDockYear					
s_stparms.lDockNum = s_lDockNum					
s_stparms.iDisYear = s_iCBYear										
s_stparms.iDisNum = s_lCBNum										
s_stparms.wPrev = parent
i_bReceived = True

OpenWithParm(w_cash_receipts_detail,s_stparms)			



/*integer s_iDockYear, s_iRow
long s_lDockNum
decimal {2} s_dFeeAmtDisb

s_iRow = dw_detail.GetRow()
s_lDockNum = dw_detail.GetItemNumber(s_iRow, "docket_num")
s_iDockYear = dw_detail.GetItemNumber(s_iRow, "docket_year")

SELECT SUM(amount_disbursed) INTO :s_dFeeAmtDisb
	FROM sh_docket_cash_ref
	WHERE sh_docket_cash_ref.cbdis_year = :i_iCBDisYear
	AND sh_docket_cash_ref.cbdis_number = :i_lCBDisNum;
Choose Case SQLCA.SQLCODE
	Case 100  // Not Found
		UPDATE sh_docket_disbursement
			SET amount_paid = :s_dFeeAmtDisb
			FROM sh_docket_disbursement
			WHERE sh_docket_disbursement.cb_type = 'M'
			AND sh_docket_disbursement.cbdis_year = :i_iCBDisYear
			AND sh_docket_disbursement.cbdis_number = :i_lCBDisNum;						
//			AND sh_docket_disbursement."docket_year" = :s_iDockYear
//			AND sh_docket_disbursement."docket_num" = :s_lDockNum								
		// error check
		If SQLCA.SQLCode = -1 Then
			MessageBox("System Error","CB_Dis Update Error - " + SQLCA.SQLErrText)
			ROLLBACK;
		Else
			COMMIT;
		End If	
		
	Case 0 // Cash Ref Found
		UPDATE sh_docket_disbursement
			SET amount_paid = :s_dFeeAmtDisb
			FROM sh_docket_disbursement
			WHERE sh_docket_disbursement.cb_type = 'M'
			AND sh_docket_disbursement.cbdis_year = :i_iCBDisYear
			AND sh_docket_disbursement.cbdis_number = :i_lCBDisNum;
//			AND sh_docket_disbursement."docket_year" = :s_iDockYear
//			AND sh_docket_disbursement."docket_num" = :s_lDockNum								
		// error check
		If SQLCA.SQLCode = -1 Then
			MessageBox("System Error","CB_Dis Update 2 Error - " + SQLCA.SQLErrText)
			ROLLBACK;
		Else
			COMMIT;
		End If	
	
	Case -1 // System error

		
End Choose
cb_main.TriggerEvent("clicked")

*/
*/
end event

type gb_d from groupbox within w_misc_cash_disbursements_sheet
integer x = 3138
integer y = 1226
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

type gb_m from groupbox within w_misc_cash_disbursements_sheet
integer x = 3138
integer y = 778
integer width = 497
integer height = 224
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_main from commandbutton within w_misc_cash_disbursements_sheet
integer x = 3163
integer y = 835
integer width = 450
integer height = 67
integer taborder = 230
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

type cb_disburse from commandbutton within w_misc_cash_disbursements_sheet
integer x = 3163
integer y = 909
integer width = 450
integer height = 67
integer taborder = 240
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

s_achcbtyped = "M"

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
	WHERE sh_docket_fee_paid.cb_type = 'M'	
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

	dw_detail.Retrieve("M", i_iCBDisYear, i_lCBDisNum)		
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

type cb_process_disburse from commandbutton within w_misc_cash_disbursements_sheet
integer x = 3163
integer y = 1280
integer width = 450
integer height = 67
integer taborder = 250
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
	WHERE cb_type = 'M'
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
s_lDisbursementRows = lds_Disbursement.Retrieve("M", s_iCBDisYear, s_lCBDisNum, "O")
messagebox("rows",s_lDisbursementRows)
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
	WHERE sh_docket_disbursement.cb_type = 'M'
	AND sh_docket_disbursement.cbdis_year = :s_iCBDisYear
	AND sh_docket_disbursement.cbdis_number = :s_lCBDisNum;							
// error check
If SQLCA.SQLCode = -1 Then
	MessageBox("System Error","Disbursement Update Error - " + SQLCA.SQLErrText)
	ROLLBACK;
Else
	COMMIT;
End If								

dw_detail.DataObject = "dw_cash_disburse_detail"		
dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Miscellaneous Disbursement Information"

// get Fee Type
dw_detail.GetChild("fee_type", dwc)
dwc.SetTransObject(SQLCA)
dwc.Reset()
dwc.Retrieve("FEE")

dw_detail.Retrieve("M", s_iCBDisYear, s_lCBDisNum)		
dw_detail.SetRowFocusIndicator(Hand!)

cb_main.enabled = True
cb_disburse.enabled = False

s_achCBType = "M"
dw_scan.SetTransObject(SQLCA)
dw_scan.SetRedraw(False)			
dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			

dw_scan.Retrieve() 			

long s_sRow
// find the row closest to this one
s_sRow = dw_scan.Find("cb_type = '" + s_achCBType + &
	"' AND cbdis_year = " + String(s_iCBDisYear) + &
	" AND cbdis_number = " + String(s_lCBDisNum), 0, dw_scan.RowCount())

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

type st_message from statictext within w_misc_cash_disbursements_sheet
integer x = 18
integer y = 726
integer width = 3101
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

type dw_check from datawindow within w_misc_cash_disbursements_sheet
boolean visible = false
integer x = 1496
integer y = 1059
integer width = 1072
integer height = 368
boolean bringtotop = true
string dataobject = "dw_civil_misc_check_rpt"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_print_check from commandbutton within w_misc_cash_disbursements_sheet
integer x = 3163
integer y = 1408
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

