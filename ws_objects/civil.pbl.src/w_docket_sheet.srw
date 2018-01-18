$PBExportHeader$w_docket_sheet.srw
forward
global type w_docket_sheet from w_base_sheet
end type
type st_1 from statictext within w_docket_sheet
end type
type sle_lname from singlelineedit within w_docket_sheet
end type
type st_2 from statictext within w_docket_sheet
end type
type sle_fname from singlelineedit within w_docket_sheet
end type
type st_memo from statictext within w_docket_sheet
end type
type cb_pclip from commandbutton within w_docket_sheet
end type
type st_6 from statictext within w_docket_sheet
end type
type sle_feebook from singlelineedit within w_docket_sheet
end type
type cb_served from commandbutton within w_docket_sheet
end type
type cb_fees from commandbutton within w_docket_sheet
end type
type cb_billable from commandbutton within w_docket_sheet
end type
type cb_memo from commandbutton within w_docket_sheet
end type
type cb_name from commandbutton within w_docket_sheet
end type
type cb_main from commandbutton within w_docket_sheet
end type
type gb_9 from groupbox within w_docket_sheet
end type
type gb_8 from groupbox within w_docket_sheet
end type
type gb_6 from groupbox within w_docket_sheet
end type
type cb_return from commandbutton within w_docket_sheet
end type
type dw_return_service from datawindow within w_docket_sheet
end type
type cb_serv_slip from commandbutton within w_docket_sheet
end type
type dw_serv_slip from datawindow within w_docket_sheet
end type
type sle_dock_year from singlelineedit within w_docket_sheet
end type
type sle_dock_num from singlelineedit within w_docket_sheet
end type
type st_7 from statictext within w_docket_sheet
end type
type st_8 from statictext within w_docket_sheet
end type
type cb_bill_letter from commandbutton within w_docket_sheet
end type
type dw_bill_letter from datawindow within w_docket_sheet
end type
type em_rec_date from editmask within w_docket_sheet
end type
type st_9 from statictext within w_docket_sheet
end type
type cb_receipt from commandbutton within w_docket_sheet
end type
type cb_disbursement from commandbutton within w_docket_sheet
end type
type gb_7 from groupbox within w_docket_sheet
end type
type cb_balance_due from commandbutton within w_docket_sheet
end type
type st_served from statictext within w_docket_sheet
end type
type st_diligent from statictext within w_docket_sheet
end type
type st_message from statictext within w_docket_sheet
end type
type st_receipt from statictext within w_docket_sheet
end type
end forward

global type w_docket_sheet from w_base_sheet
integer x = 41
integer y = 28
integer width = 3689
integer height = 2040
string title = "Docket Information - F5"
toolbaralignment toolbaralignment = alignatleft!
st_1 st_1
sle_lname sle_lname
st_2 st_2
sle_fname sle_fname
st_memo st_memo
cb_pclip cb_pclip
st_6 st_6
sle_feebook sle_feebook
cb_served cb_served
cb_fees cb_fees
cb_billable cb_billable
cb_memo cb_memo
cb_name cb_name
cb_main cb_main
gb_9 gb_9
gb_8 gb_8
gb_6 gb_6
cb_return cb_return
dw_return_service dw_return_service
cb_serv_slip cb_serv_slip
dw_serv_slip dw_serv_slip
sle_dock_year sle_dock_year
sle_dock_num sle_dock_num
st_7 st_7
st_8 st_8
cb_bill_letter cb_bill_letter
dw_bill_letter dw_bill_letter
em_rec_date em_rec_date
st_9 st_9
cb_receipt cb_receipt
cb_disbursement cb_disbursement
gb_7 gb_7
cb_balance_due cb_balance_due
st_served st_served
st_diligent st_diligent
st_message st_message
st_receipt st_receipt
end type
global w_docket_sheet w_docket_sheet

type variables
string i_achSaveSQL, i_achMode
string i_achLName, i_achFName
string i_achMName, i_achSuffix
integer i_iDockYear
long i_lDockNum
boolean i_bFirstSearch, i_bExit, i_bContinueItem, i_bName
boolean i_bNew, i_bServed, i_bFees, i_bBillable, i_bMemo
string i_achNewSQL


end variables

on w_docket_sheet.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_lname=create sle_lname
this.st_2=create st_2
this.sle_fname=create sle_fname
this.st_memo=create st_memo
this.cb_pclip=create cb_pclip
this.st_6=create st_6
this.sle_feebook=create sle_feebook
this.cb_served=create cb_served
this.cb_fees=create cb_fees
this.cb_billable=create cb_billable
this.cb_memo=create cb_memo
this.cb_name=create cb_name
this.cb_main=create cb_main
this.gb_9=create gb_9
this.gb_8=create gb_8
this.gb_6=create gb_6
this.cb_return=create cb_return
this.dw_return_service=create dw_return_service
this.cb_serv_slip=create cb_serv_slip
this.dw_serv_slip=create dw_serv_slip
this.sle_dock_year=create sle_dock_year
this.sle_dock_num=create sle_dock_num
this.st_7=create st_7
this.st_8=create st_8
this.cb_bill_letter=create cb_bill_letter
this.dw_bill_letter=create dw_bill_letter
this.em_rec_date=create em_rec_date
this.st_9=create st_9
this.cb_receipt=create cb_receipt
this.cb_disbursement=create cb_disbursement
this.gb_7=create gb_7
this.cb_balance_due=create cb_balance_due
this.st_served=create st_served
this.st_diligent=create st_diligent
this.st_message=create st_message
this.st_receipt=create st_receipt
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_lname
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.sle_fname
this.Control[iCurrent+5]=this.st_memo
this.Control[iCurrent+6]=this.cb_pclip
this.Control[iCurrent+7]=this.st_6
this.Control[iCurrent+8]=this.sle_feebook
this.Control[iCurrent+9]=this.cb_served
this.Control[iCurrent+10]=this.cb_fees
this.Control[iCurrent+11]=this.cb_billable
this.Control[iCurrent+12]=this.cb_memo
this.Control[iCurrent+13]=this.cb_name
this.Control[iCurrent+14]=this.cb_main
this.Control[iCurrent+15]=this.gb_9
this.Control[iCurrent+16]=this.gb_8
this.Control[iCurrent+17]=this.gb_6
this.Control[iCurrent+18]=this.cb_return
this.Control[iCurrent+19]=this.dw_return_service
this.Control[iCurrent+20]=this.cb_serv_slip
this.Control[iCurrent+21]=this.dw_serv_slip
this.Control[iCurrent+22]=this.sle_dock_year
this.Control[iCurrent+23]=this.sle_dock_num
this.Control[iCurrent+24]=this.st_7
this.Control[iCurrent+25]=this.st_8
this.Control[iCurrent+26]=this.cb_bill_letter
this.Control[iCurrent+27]=this.dw_bill_letter
this.Control[iCurrent+28]=this.em_rec_date
this.Control[iCurrent+29]=this.st_9
this.Control[iCurrent+30]=this.cb_receipt
this.Control[iCurrent+31]=this.cb_disbursement
this.Control[iCurrent+32]=this.gb_7
this.Control[iCurrent+33]=this.cb_balance_due
this.Control[iCurrent+34]=this.st_served
this.Control[iCurrent+35]=this.st_diligent
this.Control[iCurrent+36]=this.st_message
this.Control[iCurrent+37]=this.st_receipt
end on

on w_docket_sheet.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_lname)
destroy(this.st_2)
destroy(this.sle_fname)
destroy(this.st_memo)
destroy(this.cb_pclip)
destroy(this.st_6)
destroy(this.sle_feebook)
destroy(this.cb_served)
destroy(this.cb_fees)
destroy(this.cb_billable)
destroy(this.cb_memo)
destroy(this.cb_name)
destroy(this.cb_main)
destroy(this.gb_9)
destroy(this.gb_8)
destroy(this.gb_6)
destroy(this.cb_return)
destroy(this.dw_return_service)
destroy(this.cb_serv_slip)
destroy(this.dw_serv_slip)
destroy(this.sle_dock_year)
destroy(this.sle_dock_num)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.cb_bill_letter)
destroy(this.dw_bill_letter)
destroy(this.em_rec_date)
destroy(this.st_9)
destroy(this.cb_receipt)
destroy(this.cb_disbursement)
destroy(this.gb_7)
destroy(this.cb_balance_due)
destroy(this.st_served)
destroy(this.st_diligent)
destroy(this.st_message)
destroy(this.st_receipt)
end on

event ue_search;call super::ue_search;// script variables
string s_achSQL, s_achDWColor, s_achFName, s_achLName, s_achMName, s_achEmpName
integer s_iNumRows, s_iDockYear
string s_achinst
string s_achNewSQL
long s_lDockNum
string s_achRec, s_achRecYear, s_achRecMonth, s_achRecDay
integer s_iRecYear, s_iRecMonth, s_iRecDay
date s_dtRec

SetPointer(HourGlass!)

cb_add.enabled = False
m_main.m_general.m_add.enabled = False

// Security - Add Docket Information
If w_main.dw_perms.Find("code=18", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_new.enabled = True
	m_main.m_general.m_new.enabled = True
End If

// Security - Update Docket Information
If w_main.dw_perms.Find("code=19", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_update.enabled = True
	m_main.m_general.m_update.enabled = True
End If

// Security - Delete Docket Information
If w_main.dw_perms.Find("code=20", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_delete.enabled = True
	m_main.m_general.m_delete.enabled = True
End If

s_achDWColor = dw_detail.Describe("datawindow.color")

dw_detail.DataObject = "dw_docket_detail"

dw_detail.SetRedraw(False)
dw_detail.Modify("docket_state.background.color = " + s_achDWColor + & 
	" docket_state.tabsequence = 0" + &
	" county.background.color = " + s_achDWColor + & 
	" county.tabsequence = 0" + &			
	" process_description.background.color = " + s_achDWColor + & 
	" process_description.tabsequence = 0" + &		
	" case_number.background.color = " + s_achDWColor + & 
	" case_number.tabsequence = 0" + &			
	" received_date.background.color = " + s_achDWColor + & 
	" received_date.tabsequence = 0")
dw_detail.SetRedraw(True)

i_achLName = Trim(sle_lname.text)
i_achFName = Trim(sle_fname.text)

i_achMode = "" 
i_bNew = False

s_achinst = Trim(sle_feebook.text)
s_iDockYear = Integer(Trim(sle_dock_year.text))
s_lDockNum = Long(Trim(sle_dock_num.text))

s_achRec = String(em_rec_date.text)
s_achRecYear = Mid(s_achRec,7,4)
s_achRecMonth = Mid(s_achRec,1,2)
s_achRecDay = Mid(s_achRec,4,2)
s_iRecYear = Integer(s_achRecYear)
s_iRecMonth = Integer(s_achRecMonth)
s_iRecDay = Integer(s_achRecDay)
s_dtRec = Date(s_iRecYear, s_iRecMonth, s_iRecDay)

// didn't pick a last name
If sle_lname.text = "" Then
	// didn't pick a first name
   If sle_fname.text <> "" Then
	   // picked a first name
      s_achSQL = &
         " AND sh_docket_name.first_name LIKE ~~~'" + sle_fname.text + "%" + "~~~'" 
	End If
Else
	// picked a last name
	s_achSQL = &
         " AND (sh_docket_name.last_name LIKE ~~~'" + "%" + sle_lname.text + "%" + "~~~' &
				OR sh_docket_name.first_name LIKE ~~~'" + "%" + sle_lname.text + "%" + "~~~' &
				OR sh_docket_name.middle_name LIKE ~~~'" + "%" + sle_lname.text + "%" + "~~~' &
				OR sh_docket_name.suffix LIKE ~~~'" + "%" + sle_lname.text + "%" + "~~~')" 

//	s_achSQL = &
//         " AND sh_docket_name.last_name LIKE ~~~'" + "%" + sle_lname.text + "%" + "~~~'" 
	
	If sle_fname.text <> "" Then
		// picked a last and a first name
		s_achSQL = &
				" AND sh_docket_name.last_name LIKE ~~~'" + "%" + sle_lname.text + "%" + "~~~'" 		
		s_achSQL += &
        " AND sh_docket_name.first_name LIKE ~~~'" + sle_fname.text + "%" + "~~~'" 
   End If
End If

// Fee Book Num
If trim(s_achinst) <> "" Then
	If Len(s_achSQL) = 0 Then
		s_achSQL = &
			 " AND sh_docket.case_number LIKE ~~~'" + "%" + s_achinst + "%" + "~~~'" 
	Else
		s_achSQL += &
			 " AND sh_docket.case_number LIKE ~~~'" + "%" + s_achinst + "%" + "~~~'" 
	End If
End If

// Docket Year and Docket Number
If s_iDockYear <> 0 Then
	If Len(s_achSQL) = 0 Then
		s_achSQL = &
			 " AND sh_docket.docket_year = ~~~'" + String(s_iDockYear) + "~~~'" 
	Else
		s_achSQL += &
			 " AND sh_docket.docket_year = ~~~'" + String(s_iDockYear) + "~~~'" 
	End If
End If

If s_lDockNum <> 0 Then
	If Len(s_achSQL) = 0 Then
		s_achSQL = &
			 " AND sh_docket.docket_number = ~~~'" + String(s_lDockNum) + "~~~'" 
	Else
		s_achSQL += &
			 " AND sh_docket.docket_number = ~~~'" + String(s_lDockNum) + "~~~'" 
	End If
End If

// Received Date
If s_achRec <> "" And s_achRec <> "00/00/0000" And Not IsNull(s_achRec) And s_dtRec <> Date('1900-01-01') Then
	If Len(s_achSQL) = 0 Then
		s_achSQL = &
			 " AND sh_docket.received_date = ~~~'" + String(s_dtRec, 'yyyy-mm-dd') + "~~~'" 
	Else
		s_achSQL += &
			 " AND sh_docket.received_date = ~~~'" + String(s_dtRec, 'yyyy-mm-dd') + "~~~'" 
	End If
End If

s_achSQL += &
   " ORDER BY sh_docket.docket_year DESC, sh_docket.docket_number DESC" 
s_achSQL = i_achSQL + s_achSQL
i_achSaveSQL = s_achSQL


// NEW Entry
s_achnewSQL = &
   " ORDER BY sh_docket.docket_year DESC, sh_docket.docket_number DESC" 
i_achNewSQL = i_achSQL + s_achnewSQL

dw_scan.Modify("datawindow.table.select='" + s_achSQL + "'")
//messagebox("sql",s_achSQL)
dw_scan.Reset()
If dw_scan.Retrieve() = 0 Then
	MessageBox("Complete", "No Docket Information rows found.")

	sle_lname.text = ""
	sle_fname.text = ""
	sle_feebook.text = ""
	sle_dock_year.text = ""
	sle_dock_num.text = ""
	em_rec_date.text = ""
	sle_lname.SetFocus()

	st_memo.visible = False
	st_served.visible = False
	st_diligent.visible = False
	st_receipt.visible = False	
	
	cb_balance_due.enabled = False
	cb_bill_letter.enabled = False
	cb_return.enabled = False
	cb_serv_slip.enabled = False	
	
Else
	
	cb_main.enabled = False
	cb_name.enabled = True
	cb_memo.enabled = True
	cb_served.enabled = True		
	cb_fees.enabled = True		
	cb_billable.enabled = True		
	cb_receipt.enabled = True			
	cb_disbursement.enabled = True	
	
	cb_balance_due.enabled = True
	cb_bill_letter.enabled = True
	cb_return.enabled = True
	cb_serv_slip.enabled = True	
	
   dw_scan.SetFocus()
End If

end event

event open;integer nwidth, nheight
datawindowchild	dwc

SetPointer(HourGlass!)

//this.Width = dw_scan.width + dw_scan.x + 1100  
i_achSQL = dw_scan.GetSQLSelect()
dw_scan.SetTransObject(SQLCA)

this.Visible = False
PostEvent("ue_move_window")

//this.Height = dw_detail.Height + 2000
//this.Width = dw_detail.Width + 690


gnv_resize = create n_cst_resize
gnv_resize.of_SetOrigSize (This.Width, This.Height)
gnv_resize.of_Register(dw_scan, gnv_resize.SCALE)
gnv_resize.of_Register(dw_detail, gnv_resize.SCALE)
gnv_resize.of_Register(st_1, gnv_resize.SCALE)
gnv_resize.of_Register(st_2, gnv_resize.SCALE)
gnv_resize.of_Register(st_6, gnv_resize.SCALE)
gnv_resize.of_Register(st_7, gnv_resize.SCALE)
gnv_resize.of_Register(st_8, gnv_resize.SCALE)
gnv_resize.of_Register(st_9, gnv_resize.SCALE)
gnv_resize.of_Register(st_diligent, gnv_resize.SCALE)
gnv_resize.of_Register(st_memo, gnv_resize.SCALE)
gnv_resize.of_Register(st_message, gnv_resize.SCALE)
gnv_resize.of_Register(st_receipt, gnv_resize.SCALE)
gnv_resize.of_Register(st_served, gnv_resize.SCALE)
gnv_resize.of_Register(em_rec_date, gnv_resize.SCALE)
gnv_resize.of_Register(sle_dock_num, gnv_resize.SCALE)
gnv_resize.of_Register(sle_dock_year, gnv_resize.SCALE)
gnv_resize.of_Register(sle_feebook, gnv_resize.SCALE)
gnv_resize.of_Register(sle_fname, gnv_resize.SCALE)
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
gnv_resize.of_Register(gb_6, gnv_resize.SCALE)
gnv_resize.of_Register(gb_7, gnv_resize.SCALE)
gnv_resize.of_Register(gb_8, gnv_resize.SCALE)
gnv_resize.of_Register(gb_9, gnv_resize.SCALE)

gnv_resize.of_Register(cb_balance_due, gnv_resize.SCALE)
gnv_resize.of_Register(cb_bill_letter, gnv_resize.SCALE)
gnv_resize.of_Register(cb_billable, gnv_resize.SCALE)
gnv_resize.of_Register(cb_disbursement, gnv_resize.SCALE)
gnv_resize.of_Register(cb_fees, gnv_resize.SCALE)
gnv_resize.of_Register(cb_main, gnv_resize.SCALE)
gnv_resize.of_Register(cb_memo, gnv_resize.SCALE)
gnv_resize.of_Register(cb_name, gnv_resize.SCALE)
gnv_resize.of_Register(cb_pclip, gnv_resize.SCALE)
gnv_resize.of_Register(cb_receipt, gnv_resize.SCALE)
gnv_resize.of_Register(cb_return, gnv_resize.SCALE)
gnv_resize.of_Register(cb_serv_slip, gnv_resize.SCALE)
gnv_resize.of_Register(cb_served, gnv_resize.SCALE)

i_bFirstSearch = True

sle_lname.SetFocus()

cb_balance_due.enabled = False
cb_bill_letter.enabled = False
cb_return.enabled = False
cb_serv_slip.enabled = False

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

// Window Controls
cb_balance_due.pointer="arrow!"
cb_bill_letter.pointer="arrow!"
cb_billable.pointer="arrow!"
cb_fees.pointer="arrow!"
cb_main.pointer="arrow!"
cb_memo.pointer="arrow!"
cb_name.pointer="arrow!"
cb_pclip.pointer="arrow!"
cb_return.pointer="arrow!"
cb_serv_slip.pointer="arrow!"
cb_served.pointer="arrow!"
gb_6.pointer="arrow!"
gb_7.pointer="arrow!"
gb_8.pointer="arrow!"
gb_9.pointer="arrow!"



end event

event ue_next;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_docket_detail"
		cb_first.enabled = False					
		m_main.m_general.m_first.enabled = False					
		cb_back.enabled = False
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False		
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False		
		m_main.m_general.m_last.enabled = False

		Return
		
	Case "dw_docket_parties_involved_detail"	
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
		
	Case "dw_docket_note_detail"	
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

	Case "dw_docket_served_detail"	
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

	Case "dw_docket_fees_scan"	
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

	Case "dw_docket_billable_detail"	
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
	Case "dw_docket_detail"
		cb_first.enabled = False							
		m_main.m_general.m_first.enabled = False		
		cb_back.enabled = False									
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False									
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False									
		m_main.m_general.m_last.enabled = False

		Return

	Case "dw_docket_parties_involved_detail"
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
		
	Case "dw_docket_note_detail"
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

	Case "dw_docket_served_detail"
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

	Case "dw_docket_fees_scan"
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

	Case "dw_docket_billable_detail"
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

event ue_val_fields;integer s_iRowCount, s_iRow, s_iCount, s_iDockYear
long s_lLineNum, s_lMaxNum
string s_achOffName
integer s_iOffCount
string s_achPersonalTime, s_achPersonalAMPM, s_achMilPersonalTime, s_achSubsTime, s_achSubsAMPM, s_achMilSubsTime
string s_achCorpTime, s_achCorpAMPM, s_achMilCorpTime
integer s_iPersonalTime, s_iSubsTime, s_iCorpTime

dw_detail.SetTransObject(SQLCA)
dw_detail.AcceptText()
Choose Case dw_detail.DataObject
	
	Case "dw_docket_detail"
		
		If IsNull(dw_detail.GetItemString(1,"process_description")) Or (dw_detail.GetItemString(1,"process_description") = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Process Description MUST be entered!")
			dw_detail.SetColumn("process_description")
			dw_detail.SetFocus()
			Return
		End If	
		
		If Date(dw_detail.GetItemDateTime(1,"received_date")) > Today() Then
			i_ivalflag = 1 
			MessageBox("Error", "Received date MUST be today or before!")
			dw_detail.SetColumn("received_date")
			dw_detail.SetFocus()
			Return
		End If			

	Case "dw_docket_parties_involved_detail"
		
		s_iRowCount = dw_detail.RowCount()
						
		For s_iCount = 1 to s_iRowCount
			Choose Case dw_detail.GetItemStatus(s_iCount,0, Primary!)
				Case NotModified!, New!
					Continue
			End Choose
		
			If IsNull(dw_detail.GetItemString(s_iCount, "last_name")) Or (dw_detail.GetItemString(s_iCount, "last_name") = "") Then
				i_ivalflag = 1 
				MessageBox("Error", "Last name must be entered!")
				dw_detail.SetColumn("last_name")
				dw_detail.SetRow(s_iCount)
				dw_detail.SetFocus()
				Return
			End If	

			If IsNull(dw_detail.GetItemString(s_iCount, "involvement")) Or (dw_detail.GetItemString(s_iCount, "involvement") = "") Then
				i_ivalflag = 1 
				MessageBox("Error", "Involvement must be entered!")
				dw_detail.SetColumn("involvement")
				dw_detail.SetRow(s_iCount)
				dw_detail.SetFocus()
				Return
			End If	

		Next

	Case "dw_docket_note_detail"
		
		s_iRowCount = dw_detail.RowCount()
						
		For s_iCount = 1 to s_iRowCount
			Choose Case dw_detail.GetItemStatus(s_iCount,0, Primary!)
				Case NotModified!, New!
					Continue
			End Choose
		
			If IsNull(dw_detail.GetItemString(s_iCount, "comments")) Or (dw_detail.GetItemString(s_iCount, "comments") = "") Then
				i_ivalflag = 1 
				MessageBox("Error", "Memo must be entered!")
				dw_detail.SetColumn("comments")
				dw_detail.SetRow(s_iCount)
				dw_detail.SetFocus()
				Return
			End If	

		Next

	Case "dw_docket_served_detail"
		
		s_iRowCount = dw_detail.RowCount()
						
		For s_iCount = 1 to s_iRowCount
			Choose Case dw_detail.GetItemStatus(s_iCount,0, Primary!)
				Case NotModified!, New!
					Continue
			End Choose

			If IsNull(dw_detail.GetItemString(s_iCount, "type_served")) Or (dw_detail.GetItemString(s_iCount, "type_served") = "") Then
				i_ivalflag = 1 
				MessageBox("Error", "Type Served must be entered!")
				dw_detail.SetColumn("type_served")
				dw_detail.SetRow(s_iCount)
				dw_detail.SetFocus()
				Return
			End If		
		
			If IsNull(dw_detail.GetItemString(s_iCount, "officer_name")) Or (dw_detail.GetItemString(s_iCount, "officer_name") = "") Then
				i_ivalflag = 1 
				MessageBox("Error", "Officer name must be entered!")
				dw_detail.SetColumn("officer_name")
				dw_detail.SetRow(s_iCount)
				dw_detail.SetFocus()
				Return
			End If

			// Valid Officer Name
			s_achOffName = trim(dw_detail.GetItemString(s_iCount, "officer_name")) + "%"
				
			SELECT COUNT(*)
				INTO :s_iOffCount
				FROM sh_serve_personnel
				WHERE officer_name like :s_achOffName;

			If s_iOffCount = 0 Then
				i_ivalflag = 1 
				MessageBox("Error", "Officer name is not valid!")
				dw_detail.SetColumn("officer_name")
				dw_detail.SetRow(s_iCount)
				dw_detail.SetFocus()
				Return
			End If

		Next

	Case "dw_docket_fees_scan"
		
		s_iRowCount = dw_detail.RowCount()
		
		If IsNull(dw_detail.GetItemString(s_iRowCount,"fee_type")) Or (trim(dw_detail.GetItemString(s_iRowCount,"fee_type")) = "") Then
			i_ivalflag = 1 
			MessageBox("Error", "Fee Type MUST be entered!")
			dw_detail.SetColumn("fee_type")
			dw_detail.SetFocus()
			Return
		End If	

		If IsNull(dw_detail.GetItemNumber(s_iRowCount,"fee_amount")) Or dw_detail.GetItemNumber(s_iRowCount,"fee_amount") = 0 Then
			i_ivalflag = 1 
			MessageBox("Error", "Fee Amount MUST be entered!")
			dw_detail.SetColumn("fee_amount")
			dw_detail.SetFocus()
			Return
		End If	

End Choose		

Choose Case dw_detail.DataObject

	Case "dw_docket_detail"

		s_iRow = dw_detail.GetRow()
		s_iDockYear = dw_detail.GetItemNumber(s_iRow,"docket_year")

		If i_achOpType = "Add" Then

			SELECT max_number INTO :s_lMaxNum
				FROM ut_incremented_number
				WHERE ut_incremented_number.number_type = 'DOCK-MAX'
				AND ut_incremented_number.civil_year = :s_iDockYear;				
			If SQLCA.SQLCODE = -1 Then
				MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
				Return
			End If						
			
			If IsNull(s_lMaxNum) Then s_lMaxNum = 0			
			s_lMaxNum ++
			
			dw_detail.SetItem(s_iRow, "docket_number", s_lMaxNum)
			dw_detail.SetItem(s_iRow, "docket_year", s_iDockYear)			

			UPDATE ut_incremented_number
				SET max_number = :s_lMaxNum
				WHERE ut_incremented_number.number_type = 'DOCK-MAX'
				AND ut_incremented_number.civil_year = :s_iDockYear;								
			If SQLCA.SQLCODE = -1 Then
				MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
				Return
			End If

		End If


	Case "dw_docket_served_detail"

		s_achPersonalTime = ""
		s_achMilPersonalTime = ""	
		s_iPersonalTime = 0
		
		s_achSubsTime = ""
		s_achMilSubsTime = ""
		s_iSubsTime = 0
		
		s_achCorpTime = ""
		s_achMilCorpTime = ""
		s_iCorpTime = 0

		s_iRow = dw_detail.GetRow()
		s_achPersonalTime = Trim(dw_detail.GetItemString(s_iRow,"personal_time_served"))
		s_achPersonalAMPM = Trim(dw_detail.GetItemString(s_iRow,"personal_am_pm"))		
		s_achSubsTime = Trim(dw_detail.GetItemString(s_iRow,"subs_time_served"))
		s_achSubsAMPM = Trim(dw_detail.GetItemString(s_iRow,"subs_am_pm"))				
		s_achCorpTime = Trim(dw_detail.GetItemString(s_iRow,"corp_time_served"))
		s_achCorpAMPM = Trim(dw_detail.GetItemString(s_iRow,"corp_am_pm"))		
		
		If Left(s_achPersonalTime,2) = "12" And s_achPersonalAMPM = "A" Then
			s_achPersonalTime = "00" + Right(s_achPersonalTime,2)
			dw_detail.SetItem(s_iRow,"personal_military_time",s_achPersonalTime)
			
		ElseIf s_achPersonalAMPM = "P" And Left(s_achPersonalTime,2) <> "12" Then
			s_iPersonalTime = Integer(Left(s_achPersonalTime,2))
			s_iPersonalTime = s_iPersonalTime + 12 
			s_achMilPersonalTime = String(s_iPersonalTime,"00")
			s_achPersonalTime = s_achMilPersonalTime + Right(s_achPersonalTime,2)
			dw_detail.SetItem(s_iRow,"personal_military_time",s_achPersonalTime)
			
		Else
			dw_detail.SetItem(s_iRow,"personal_military_time",s_achPersonalTime)		
		End If
		

		If Left(s_achSubsTime,2) = "12" And s_achSubsAMPM = "A" Then
			s_achSubsTime = "00" + Right(s_achSubsTime,2)
			dw_detail.SetItem(s_iRow,"subs_military_time",s_achSubsTime)
			
		ElseIf s_achSubsAMPM = "P" And Left(s_achSubsTime,2) <> "12" Then
			s_iSubsTime = Integer(Left(s_achSubsTime,2))
			s_iSubsTime = s_iSubsTime + 12 
			s_achMilSubsTime = String(s_iSubsTime,"00")
			s_achSubsTime = s_achMilSubsTime + Right(s_achSubsTime,2)
			dw_detail.SetItem(s_iRow,"subs_military_time",s_achSubsTime)
			
		Else
			dw_detail.SetItem(s_iRow,"subs_military_time",s_achSubsTime)		
		End If
		
		If Left(s_achCorpTime,2) = "12" And s_achCorpAMPM = "A" Then
			s_achCorpTime = "00" + Right(s_achCorpTime,2)
			dw_detail.SetItem(s_iRow,"corp_military_time",s_achCorpTime)
			
		ElseIf s_achCorpAMPM = "P" And Left(s_achCorpTime,2) <> "12" Then
			s_iCorpTime = Integer(Left(s_achCorpTime,2))
			s_iCorpTime = s_iCorpTime + 12 
			s_achMilCorpTime = String(s_iCorpTime,"00")
			s_achCorpTime = s_achMilCorpTime + Right(s_achCorpTime,2)
			dw_detail.SetItem(s_iRow,"corp_military_time",s_achCorpTime)
			
		Else
			dw_detail.SetItem(s_iRow,"corp_military_time",s_achCorpTime)		
		End If

/*		If i_achOpType = "Add" Or i_achOpType = "Update" Then		
			dw_detail.SetItem(s_iRow, "last_chg_login", g_achUserID)					
			dw_detail.SetItem(s_iRow, "last_chg_datetime", Today())					
		End If
*/
End Choose   

end event

event ue_clear;call super::ue_clear;
sle_lname.text = ""
sle_fname.text = ""
sle_feebook.text = ""
sle_dock_year.text = ""
sle_dock_num.text = ""
em_rec_date.text = ""
st_memo.visible = False
st_served.visible = False
st_diligent.visible = False
st_receipt.visible = False

i_achOpType = ""
i_iDockYear = 0
i_lDockNum = 0
i_achLName = ""
i_achFName = ""
i_achMName = ""
i_achSuffix = ""
i_bFirstSearch = True

cb_first.enabled = False
m_main.m_general.m_first.enabled = False
cb_back.enabled = False
m_main.m_general.m_back.enabled = False
cb_next.enabled = False
m_main.m_general.m_next.enabled = False
cb_last.enabled = False
m_main.m_general.m_last.enabled = False

cb_main.enabled = False
cb_name.enabled = False
cb_memo.enabled = False
cb_served.enabled = False
cb_fees.enabled = False
cb_billable.enabled = False

cb_balance_due.enabled = False
cb_bill_letter.enabled = False
cb_return.enabled = False
cb_serv_slip.enabled = False

sle_lname.SetFocus()


		
end event

event ue_first;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_docket_detail"
		cb_first.enabled = False					
		m_main.m_general.m_first.enabled = False					
		cb_back.enabled = False		
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False		
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False
		m_main.m_general.m_last.enabled = False

		Return

	Case "dw_docket_parties_involved_detail"
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

	Case "dw_docket_note_detail"
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

	Case "dw_docket_served_detail"
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

	Case "dw_docket_fees_scan"
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

	Case "dw_docket_billable_detail"
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

event ue_update;call super::ue_update;string s_achDWColor
integer s_iRow, s_iScanRow

i_achOpType ="Update"

s_achDWColor = dw_scan.Describe("datawindow.color")

cb_main.enabled = False
cb_name.enabled = False
cb_memo.enabled = False
cb_served.enabled = False
cb_fees.enabled = False
cb_billable.enabled = False

s_iScanRow = dw_scan.GetRow()
s_iRow = dw_detail.GetRow()
Choose Case dw_detail.DataObject
			 
	Case "dw_docket_detail"

		dw_detail.SetRedraw(False)
		dw_detail.Modify("docket_state.background.color = " + s_achDWColor + & 
			" docket_state.tabsequence = 1" + &	
			" county.background.color = " + s_achDWColor + & 
			" county.tabsequence = 2" + &					
			" process_description.background.color = " + s_achDWColor + & 
			" process_description.tabsequence = 3" + &		
			" case_number.background.color = " + s_achDWColor + & 
			" case_number.tabsequence = 4" + &			
			" received_date.background.color = " + s_achDWColor + & 
			" received_date.tabsequence = 5")		
		dw_detail.SetColumn("docket_state")						
		
	Case "dw_docket_parties_involved_detail"

		dw_detail.SetRedraw(False)
		dw_detail.Modify("business.background.color = " + s_achDWColor + & 
			" business.tabsequence = 1" + &		
			" last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 2" + &					
			" first_name.background.color = " + s_achDWColor + & 
			" first_name.tabsequence = 3" + &		
			" middle_name.background.color = " + s_achDWColor + & 
			" middle_name.tabsequence = 4" + &						
			" suffix.background.color = " + s_achDWColor + & 
			" suffix.tabsequence = 5" + &
			" involvement.background.color = " + s_achDWColor + & 
			" involvement.tabsequence = 6" + &	
			" served.background.color = " + s_achDWColor + & 
			" served.tabsequence = 7" + &			
			" name_addr.background.color = " + s_achDWColor + & 
			" name_addr.tabsequence = 8" + &
			" name_employ.background.color = " + s_achDWColor + & 
			" name_employ.tabsequence = 9" + &					
			" name_remark.background.color = " + s_achDWColor + & 
			" name_remark.tabsequence = 10")							
		dw_detail.SetColumn("business")						
		If i_achMode = "Continue" And i_bNew Then
			i_achOpType = "Add"
		End If				

	Case "dw_docket_note_detail"

		dw_detail.SetRedraw(False)
		dw_detail.Modify("comments.background.color = " + s_achDWColor + & 
			" comments.tabsequence = 1" + &
			" comment_date.background.color = " + s_achDWColor + & 
			" comment_date.tabsequence = 2")						
		dw_detail.SetColumn("comments")						
		If i_achMode = "Continue" Then
			i_achOpType = "Add"
		End If				

	Case "dw_docket_served_detail"

		dw_detail.SetRedraw(False)
		dw_detail.Modify("last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 1" + &
			" first_name.background.color = " + s_achDWColor + & 
			" first_name.tabsequence = 2" + &
			" middle_name.background.color = " + s_achDWColor + & 
			" middle_name.tabsequence = 3" + &						
			" suffix.background.color = " + s_achDWColor + & 
			" suffix.tabsequence = 4" + &
			" type_served.background.color = " + s_achDWColor + & 
			" type_served.tabsequence = 5" + &			
			" date_returned.background.color = " + s_achDWColor + & 
			" date_returned.tabsequence = 6" + &
			" personal_place_served.background.color = " + s_achDWColor + & 
			" personal_place_served.tabsequence = 7" + &
			" personal_date_served.background.color = " + s_achDWColor + & 
			" personal_date_served.tabsequence = 8" + &
			" personal_time_served.background.color = " + s_achDWColor + & 
			" personal_time_served.tabsequence = 9" + &
			" personal_am_pm.background.color = " + s_achDWColor + & 
			" personal_am_pm.tabsequence = 10" + &			
			" subs_served_on.background.color = " + s_achDWColor + & 
			" subs_served_on.tabsequence = 11" + &		
			" subs_place_served.background.color = " + s_achDWColor + & 
			" subs_place_served.tabsequence = 12" + &
			" subs_date_served.background.color = " + s_achDWColor + & 
			" subs_date_served.tabsequence = 13" + &
			" subs_time_served.background.color = " + s_achDWColor + & 
			" subs_time_served.tabsequence = 14" + &
			" subs_am_pm.background.color = " + s_achDWColor + & 
			" subs_am_pm.tabsequence = 15" + &	
			" corp_served_on.background.color = " + s_achDWColor + & 
			" corp_served_on.tabsequence = 17" + &				
			" corp_position.background.color = " + s_achDWColor + & 
			" corp_position.tabsequence = 18" + &
			" corp_place_served.background.color = " + s_achDWColor + & 
			" corp_place_served.tabsequence = 19" + &
			" corp_date_served.background.color = " + s_achDWColor + & 
			" corp_date_served.tabsequence = 20" + &
			" corp_time_served.background.color = " + s_achDWColor + & 
			" corp_time_served.tabsequence = 21" + &
			" corp_am_pm.background.color = " + s_achDWColor + & 
			" corp_am_pm.tabsequence = 22" + &					
			" other_served.background.color = " + s_achDWColor + & 
			" other_served.tabsequence = 25" + &				
			" officer_name.background.color = " + s_achDWColor + & 
			" officer_name.tabsequence = 26" + &			
			" served_note.background.color = " + s_achDWColor + & 
			" served_note.tabsequence = 27")
		dw_detail.SetColumn("last_name")						
		If i_achMode = "Continue" And i_bNew Then
			i_achOpType = "Add"
		End If				

	Case "dw_docket_fees_scan"
		
		dw_detail.SetRedraw(False)
		dw_detail.Modify("fee_type.background.color = " + s_achDWColor + & 
			" fee_type.tabsequence = 1" + &
			" fee_amount.background.color = " + s_achDWColor + & 
			" fee_amount.tabsequence = 2" + &
			" fee_note.background.color = " + s_achDWColor + & 
			" fee_note.tabsequence = 3")
		dw_detail.SetColumn("fee_type")						
		If i_achMode = "Continue" And i_bNew Then
			i_achOpType = "Add"
		End If				
		
	Case "dw_docket_billable_detail"

		dw_detail.SetRedraw(False)
		dw_detail.Modify("last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 2" + &			
			" address1.background.color = " + s_achDWColor + & 
			" address1.tabsequence = 6" + &
			" address2.background.color = " + s_achDWColor + & 
			" address2.tabsequence = 7" + &			
			" city.background.color = " + s_achDWColor + & 
			" city.tabsequence = 8" + &			
			" state.background.color = " + s_achDWColor + & 
			" state.tabsequence = 9" + &			
			" zip_code.background.color = " + s_achDWColor + & 
			" zip_code.tabsequence = 10" + &			
			" zip_4.background.color = " + s_achDWColor + & 
			" zip_4.tabsequence = 11" + &
			" work_phone.background.color = " + s_achDWColor + & 
			" work_phone.tabsequence = 12")						
		dw_detail.SetColumn("business")						
		If i_achMode = "Continue" And i_bNew Then
			i_achOpType = "Add"
		End If				

End Choose 
dw_detail.SetRedraw(True)
dw_detail.SetRow(s_iRow)		
dw_detail.SetFocus()


end event

event ue_save;// script variables
string s_achDWColor, s_achInvolvement, s_achErrText, s_achLName, s_achFName, s_achMName
string s_achSuffix, s_achName, s_achAllNames, s_achBusiness
integer s_iRow, s_iCount, s_iDockYear
long s_lNameRows, s_lDockNum, newrow
decimal{2} s_dbalancedue

Decimal {2} s_dtotfees

datastore lds_Name

SetPointer(HourGlass!)

// validate the fields
i_log.of_log(1, "ue_save begin")
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

i_log.of_log(1, "triggerevnet")

Choose Case dw_detail.DataObject
	Case "dw_docket_detail"

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
			dw_detail.Modify("docket_state.background.color = " + s_achDWColor + & 
				" docket_state.tabsequence = 0" + &	
				" county.background.color = " + s_achDWColor + & 
				" county.tabsequence = 0" + &					
				" process_description.background.color = " + s_achDWColor + & 
				" process_description.tabsequence = 0" + &					
				" case_number.background.color = " + s_achDWColor + & 
				" case_number.tabsequence = 0" + &			
				" received_date.background.color = " + s_achDWColor + & 
				" received_date.tabsequence = 0")					
			dw_detail.SetRedraw(True)
i_log.of_log("ue_save modify")
			// Security - Add Docket Information
			If w_main.dw_perms.Find("code=18", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_new.enabled = True
				m_main.m_general.m_new.enabled = True
			End If
			
			// Security - Update Docket Information
			If w_main.dw_perms.Find("code=19", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_update.enabled = True
				m_main.m_general.m_update.enabled = True
			End If
			
			// Security - Delete Docket Information
			If w_main.dw_perms.Find("code=20", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_delete.enabled = True				
				m_main.m_general.m_delete.enabled = True
			End If
			
			cb_save.enabled = False
			m_main.m_general.m_save.enabled = False

			cb_main.enabled = False
			cb_name.enabled = True
			cb_memo.enabled = True			
			cb_served.enabled = True			
			cb_fees.enabled = True						
			cb_billable.enabled = True						
			
			s_iRow = dw_detail.GetRow()
			s_iDockYear = dw_detail.GetItemNumber(s_iRow,"docket_year")
			s_lDockNum = dw_detail.GetItemNumber(s_iRow,"docket_number")			
i_log.of_log("ue_save 2")
			If i_achOpType = "Add" Then
				INSERT INTO sh_docket_name 
					(docket_year, docket_number, party_number, last_name, first_name, 
						middle_name, suffix, involvement, served, business)
					VALUES (:s_iDockYear, :s_lDockNum, 1, '', '', '', '', '', 'N', 'N');
				COMMIT;
//messagebox("commit","com")				
			End If
	//This is the area where the code is slow
	/*==================================================*/
				dw_scan.SetTransObject(SQLCA)
				dw_scan.SetRedraw(False)			
				If i_achOpType = "Add" Then			
					i_achSQL = i_achSQL +  " AND (sh_docket_name.last_name LIKE ~~~'" + "%" + sle_lname.text + "%" + "~~~' &
				OR sh_docket_name.first_name LIKE ~~~'" + "%" + sle_lname.text + "%" + "~~~' &
				OR sh_docket_name.middle_name LIKE ~~~'" + "%" + sle_lname.text + "%" + "~~~' &
				OR sh_docket_name.suffix LIKE ~~~'" + "%" + sle_lname.text + "%" + "~~~')" 
				
					dw_scan.Modify("datawindow.table.select='" + i_achSQL + "'")	
					
	i_log.of_log(i_achSQL)
				Else	
					dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")			
	i_log.of_log("not add")				
				End If
				newrow = dw_scan.Retrieve() 			
	i_log.of_log("retrieve")			
			
				i_log.of_log(string(s_iDockYear))
				i_log.of_log(String(s_lDockNum))
				integer s_sRow
				s_sRow = dw_scan.Find("docket_year = " + String(s_iDockYear) + &
					" AND docket_number = " + String(s_lDockNum), 0, newrow) //dw_scan.RowCount())			
	i_log.of_log( 'find done')
				If s_sRow = 0 Then s_sRow = 1
		
				// highlight only the closest row
				dw_scan.ScrollToRow(s_sRow)				
				i_log.of_log( 'scroll')
				dw_scan.SelectRow(0,False)
				dw_scan.SelectRow(s_sRow, True)		
				i_log.of_log( 'selectrow done')
				dw_scan.SetRedraw(True)
				i_log.of_log( 'setredraw')
				dw_scan.enabled = True			
	/*=========================================================*/
			If i_achMode = "Continue" And i_bNew = True Then
				If i_achOpType = "Add" Then
					If 1 = MessageBox("Docket Parties Involved Information", &
						"Add Docket Parties Involved Information?",Question!,YesNo!,2) Then
						cb_name.PostEvent("clicked")
					End If
				End If	
			End If				

		End If

	Case "dw_docket_parties_involved_detail"

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
			dw_detail.Modify("business.background.color = " + s_achDWColor + & 
				" business.tabsequence = 0" + &
			   " last_name.background.color = " + s_achDWColor + & 
				" last_name.tabsequence = 0" + &					
			   " first_name.background.color = " + s_achDWColor + & 
				" first_name.tabsequence = 0" + &				
			   " middle_name.background.color = " + s_achDWColor + & 
				" middle_name.tabsequence = 0" + &
			   " suffix.background.color = " + s_achDWColor + & 
				" suffix.tabsequence = 0" + &	
			   " involvement.background.color = " + s_achDWColor + & 
				" involvement.tabsequence = 0" + &	
			   " served.background.color = " + s_achDWColor + & 
				" served.tabsequence = 0" + &				
			   " name_addr.background.color = " + s_achDWColor + & 
				" name_addr.tabsequence = 0" + &
			   " name_employ.background.color = " + s_achDWColor + & 
				" name_employ.tabsequence = 0" + &					
			   " name_remark.background.color = " + s_achDWColor + & 
				" name_remark.tabsequence = 0")										
			dw_detail.SetRedraw(True)			
/*			
			// Security - Add Document Indexing Information
			If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_new.enabled = True
				m_main.m_general.m_new.enabled = True
			End If
*/						
			// Security - Add Docket Parties Involved
			If w_main.dw_perms.Find("code=22", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_add.enabled = True
				m_main.m_general.m_add.enabled = True
			End If

			// Security - Update Docket Parties Involved
			If w_main.dw_perms.Find("code=23", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_update.enabled = True				
				m_main.m_general.m_update.enabled = True
			End If
			
			// Security - Delete Docket Parties Involved
			If w_main.dw_perms.Find("code=24", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_delete.enabled = True
				m_main.m_general.m_delete.enabled = True
			End If
			
			cb_save.enabled = False
			m_main.m_general.m_save.enabled = False
			
			cb_main.enabled = True
			cb_name.enabled = False
			cb_memo.enabled = True
			cb_served.enabled = True			
			cb_fees.enabled = True						
			cb_billable.enabled = True									

			s_iRow = dw_detail.GetRow()
			s_iDockYear = dw_detail.GetItemNumber(s_iRow,"docket_year")
			s_lDockNum = dw_detail.GetItemNumber(s_iRow,"docket_number")			

			// allocate the resources for the datastores
			lds_Name = Create DataStore
			
			lds_Name.DataObject = 'dw_docket_names_ds'
			lds_Name.SetTransObject(SQLCA)

			// Retrieve Names on a document
			s_lNameRows = lds_Name.Retrieve(s_iDockYear, s_lDockNum)
			For s_iCount = 1 To s_lNameRows

				s_achLName = Trim(lds_Name.GetItemString(s_iCount,"last_name"))				
				s_achFName = Trim(lds_Name.GetItemString(s_iCount,"first_name"))								
				s_achMName = Trim(lds_Name.GetItemString(s_iCount,"middle_name"))								
				s_achSuffix = Trim(lds_Name.GetItemString(s_iCount,"suffix"))												
				s_achInvolvement = Trim(lds_Name.GetItemString(s_iCount,"involvement"))		
				s_achBusiness = Trim(lds_Name.GetItemString(s_iCount,"business"))	

				If s_achInvolvement = 'S' Or s_achInvolvement = 'O' Then
					Continue
				End If

				If s_achBusiness = 'Y' Then
					s_achName = s_achLName + " " + s_achFName + " " + s_achMName + " " + s_achSuffix
					s_achName = Trim(s_achName) + " (" + s_achInvolvement + ")"						
				Else
					s_achName = s_achFName + " " + s_achMName + " " + s_achLName + " " + s_achSuffix 
					s_achName = Trim(s_achName) + " (" + s_achInvolvement + ")"
				End If

				If Len(s_achAllNames) = 0 Then
						s_achAllNames = s_achName
					Else						
						s_achAllNames = s_achAllNames + " & " + s_achName
				End If
			Next	

			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)

			If i_achOpType = "Add" Then
				dw_scan.Modify("datawindow.table.select='" + i_achNewSQL + "'")	
			Else
				dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")		
			End If
		
			dw_scan.Retrieve()		

			// find the row closest to this one
			s_iRow = dw_scan.Find("docket_year = " + String(s_iDockYear) + &
				" AND docket_number = " + String(s_lDockNum), 0, dw_scan.RowCount())			
			
			s_achAllNames = Left(Trim(s_achAllNames),600)
			
			dw_scan.SetItem(s_iRow, "parties_involved", s_achAllNames)
			dw_scan.SetTransObject(SQLCA)
			dw_scan.Update()
			COMMIT;

			If s_iRow = 0 Then s_iRow = 1

			// highlight only the closest row
			dw_scan.ScrollToRow(s_iRow)				
			dw_scan.SelectRow(0,False)
			dw_scan.SelectRow(s_iRow, True)				

			dw_scan.SetRedraw(True)
	
			If i_achMode = "Continue" And i_bNew = True Then
				If i_achOpType = "Add" Then
					m_main.m_general.m_add.PostEvent("clicked")
				End If	
			End If							
		End If

	Case "dw_docket_note_detail"
		
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
			dw_detail.Modify("comments.background.color = " + s_achDWColor + & 
				" comments.tabsequence = 0" + &
				" comment_date.background.color = " + s_achDWColor + & 
				" comment_date.tabsequence = 0")							
			dw_detail.SetRedraw(True)			
/*			
			// Security - New Birth Certificate Information
			If w_main.dw_perms.Find("code=18", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_new.enabled = True
				m_main.m_general.m_new.enabled = True
			End If
*/						
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
			
			cb_main.enabled = True
			cb_name.enabled = True			
			cb_memo.enabled = False
			cb_served.enabled = True			
			cb_fees.enabled = True						
			cb_billable.enabled = True									

			s_iRow = dw_detail.GetRow()
			s_iDockYear = dw_detail.GetItemNumber(s_iRow,"docket_year")
			s_lDockNum = dw_detail.GetItemNumber(s_iRow,"docket_number")			

			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)
			
			If i_achOpType = "Add" Then
				dw_scan.Modify("datawindow.table.select='" + i_achNewSQL + "'")	
			Else
				dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")		
			End If
			
			dw_scan.Retrieve()		

			// find the row closest to this one
			s_iRow = dw_scan.Find("docket_year = " + String(s_iDockYear) + &
				" AND docket_number = " + String(s_lDockNum), 0, dw_scan.RowCount())			

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

	Case "dw_docket_served_detail"
		
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
			dw_detail.Modify("last_name.background.color = " + s_achDWColor + & 
				" last_name.tabsequence = 0" + &
				" first_name.background.color = " + s_achDWColor + & 
				" first_name.tabsequence = 0" + &
				" middle_name.background.color = " + s_achDWColor + & 
				" middle_name.tabsequence = 0" + &						
				" suffix.background.color = " + s_achDWColor + & 
				" suffix.tabsequence = 0" + &
				" type_served.background.color = " + s_achDWColor + & 
				" type_served.tabsequence = 0" + &			
				" date_returned.background.color = " + s_achDWColor + & 
				" date_returned.tabsequence = 0" + &
				" personal_place_served.background.color = " + s_achDWColor + & 
				" personal_place_served.tabsequence = 0" + &
				" personal_date_served.background.color = " + s_achDWColor + & 
				" personal_date_served.tabsequence = 0" + &
				" personal_time_served.background.color = " + s_achDWColor + & 
				" personal_time_served.tabsequence = 0" + &
				" personal_am_pm.background.color = " + s_achDWColor + & 
				" personal_am_pm.tabsequence = 0" + &			
				" subs_served_on.background.color = " + s_achDWColor + & 
				" subs_served_on.tabsequence = 0" + &		
				" subs_place_served.background.color = " + s_achDWColor + & 
				" subs_place_served.tabsequence = 0" + &
				" subs_date_served.background.color = " + s_achDWColor + & 
				" subs_date_served.tabsequence = 0" + &
				" subs_time_served.background.color = " + s_achDWColor + & 
				" subs_time_served.tabsequence = 0" + &
				" subs_am_pm.background.color = " + s_achDWColor + & 
				" subs_am_pm.tabsequence = 0" + &	
				" corp_served_on.background.color = " + s_achDWColor + & 
				" corp_served_on.tabsequence = 0" + &				
				" corp_position.background.color = " + s_achDWColor + & 
				" corp_position.tabsequence = 0" + &
				" corp_place_served.background.color = " + s_achDWColor + & 
				" corp_place_served.tabsequence = 0" + &
				" corp_date_served.background.color = " + s_achDWColor + & 
				" corp_date_served.tabsequence = 0" + &
				" corp_time_served.background.color = " + s_achDWColor + & 
				" corp_time_served.tabsequence = 0" + &
				" corp_am_pm.background.color = " + s_achDWColor + & 
				" corp_am_pm.tabsequence = 0" + &					
				" other_served.background.color = " + s_achDWColor + & 
				" other_served.tabsequence = 0" + &				
				" officer_name.background.color = " + s_achDWColor + & 
				" officer_name.tabsequence = 0" + &			
				" served_note.background.color = " + s_achDWColor + & 
				" served_note.tabsequence = 0")
			dw_detail.SetRedraw(True)			
/*			
			// Security - Add Document Indexing Information
			If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_new.enabled = True
				m_main.m_general.m_new.enabled = True
			End If
*/						
			// Security - Add Docket Served
			If w_main.dw_perms.Find("code=38", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_add.enabled = True
				m_main.m_general.m_add.enabled = True
			End If

			// Security - Update Docket Served
			If w_main.dw_perms.Find("code=39", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_update.enabled = True				
				m_main.m_general.m_update.enabled = True
			End If
			
			// Security - Delete Docket Served
			If w_main.dw_perms.Find("code=40", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_delete.enabled = True
				m_main.m_general.m_delete.enabled = True
			End If
			
			cb_save.enabled = False
			m_main.m_general.m_save.enabled = False
			
			cb_main.enabled = True
			cb_name.enabled = True
			cb_memo.enabled = True
			cb_served.enabled = False			
			cb_fees.enabled = True						
			cb_billable.enabled = True						

			s_iRow = dw_detail.GetRow()
			s_iDockYear = dw_detail.GetItemNumber(s_iRow,"docket_year")
			s_lDockNum = dw_detail.GetItemNumber(s_iRow,"docket_number")			
			
			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)
			
			If i_achOpType = "Add" Then
				dw_scan.Modify("datawindow.table.select='" + i_achNewSQL + "'")	
			Else
				dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")		
			End If
			
			dw_scan.Retrieve()		

			// find the row closest to this one
			s_iRow = dw_scan.Find("docket_year = " + String(s_iDockYear) + &
				" AND docket_number = " + String(s_lDockNum), 0, dw_scan.RowCount())			

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

	Case "dw_docket_fees_scan"
		
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
/*			
			// Security - Add Document Indexing Information
			If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_new.enabled = True
				m_main.m_general.m_new.enabled = True
			End If
*/						
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
			cb_name.enabled = True
			cb_memo.enabled = True
			cb_served.enabled = True			
			cb_fees.enabled = False						
			cb_billable.enabled = True						

			s_iRow = dw_detail.GetRow()

			s_iDockYear = dw_detail.GetItemNumber(s_iRow,"docket_year")
			s_lDockNum = dw_detail.GetItemNumber(s_iRow,"docket_number")	
			s_dbalancedue = dw_detail.GetItemNumber(s_iRow,"fee_amount")	

			dw_detail.SetItem(s_iRow, "balance_due", s_dbalancedue)	
			dw_detail.Update()
			COMMIT;

			SELECT sum(fee_amount) 
				INTO :s_dtotfees
				FROM sh_docket_fee
				WHERE cb_type = 'D'
					AND docket_year = :s_iDockYear
					AND docket_number = :s_lDockNum;
					
			If IsNull(s_dtotfees) Then s_dtotfees = 0
			
			st_message.text = "Fee Total: " + String(s_dtotfees,'#,##0.00')				
			
			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)
			
			If i_achOpType = "Add" Then
				dw_scan.Modify("datawindow.table.select='" + i_achNewSQL + "'")	
			Else
				dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")		
			End If
			
			dw_scan.Retrieve()		

			// find the row closest to this one
			s_iRow = dw_scan.Find("docket_year = " + String(s_iDockYear) + &
				" AND docket_number = " + String(s_lDockNum), 0, dw_scan.RowCount())			

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

	Case "dw_docket_billable_detail"
		
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
			dw_detail.Modify("last_name.background.color = " + s_achDWColor + & 
				" last_name.tabsequence = 0" + &				
				" address1.background.color = " + s_achDWColor + & 
				" address1.tabsequence = 0" + &
				" address2.background.color = " + s_achDWColor + & 
				" address2.tabsequence = 0" + &			
				" city.background.color = " + s_achDWColor + & 
				" city.tabsequence = 0" + &			
				" state.background.color = " + s_achDWColor + & 
				" state.tabsequence = 0" + &			
				" zip_code.background.color = " + s_achDWColor + & 
				" zip_code.tabsequence = 0" + &			
				" zip_4.background.color = " + s_achDWColor + & 
				" zip_4.tabsequence = 0" + &
				" work_phone.background.color = " + s_achDWColor + & 
				" work_phone.tabsequence = 0")							
			dw_detail.SetRedraw(True)			
/*			
			// Security - Add Document Indexing Information
			If w_main.dw_perms.Find("code=50", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_new.enabled = True
				m_main.m_general.m_new.enabled = True
			End If
*/						
			// Security - Add Docket Billable Parties
			If w_main.dw_perms.Find("code=30", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_add.enabled = True
				m_main.m_general.m_add.enabled = True
			End If

			// Security - Update Docket Billable Parties
			If w_main.dw_perms.Find("code=31", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_update.enabled = True				
				m_main.m_general.m_update.enabled = True
			End If
			
			// Security - Delete Docket Billable Parties
			If w_main.dw_perms.Find("code=32", 1, w_main.dw_perms.RowCount()) > 0 Then
				cb_delete.enabled = True
				m_main.m_general.m_delete.enabled = True
			End If
			
			cb_save.enabled = False
			m_main.m_general.m_save.enabled = False
			
			cb_main.enabled = True
			cb_name.enabled = True
			cb_memo.enabled = True
			cb_served.enabled = True			
			cb_fees.enabled = True						
			cb_billable.enabled = False						

			s_iRow = dw_detail.GetRow()
			s_iDockYear = dw_detail.GetItemNumber(s_iRow,"docket_year")
			s_lDockNum = dw_detail.GetItemNumber(s_iRow,"docket_number")			
			
			dw_scan.SetTransObject(SQLCA)
			dw_scan.SetRedraw(False)
			
			If i_achOpType = "Add" Then
				dw_scan.Modify("datawindow.table.select='" + i_achNewSQL + "'")	
			Else
				dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")		
			End If
			
			dw_scan.Retrieve()		

			// find the row closest to this one
			s_iRow = dw_scan.Find("docket_year = " + String(s_iDockYear) + &
				" AND docket_number = " + String(s_lDockNum), 0, dw_scan.RowCount())			

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

End Choose
i_log.of_log( 'end')
dw_scan.SetFocus()

end event

event ue_last;// script variables
string s_achDWColor
		
Choose Case dw_detail.DataObject
	Case "dw_docket_detail"
		
		cb_first.enabled = False					
		m_main.m_general.m_first.enabled = False					
		cb_back.enabled = False		
		m_main.m_general.m_back.enabled = False
		cb_next.enabled = False		
		m_main.m_general.m_next.enabled = False
		cb_last.enabled = False
		m_main.m_general.m_last.enabled = False
		
		Return
		
	Case "dw_docket_parties_involved_detail"		
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
		
	Case "dw_docket_note_detail"		
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

	Case "dw_docket_served_detail"		
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

	Case "dw_docket_fees_scan"		
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

	Case "dw_docket_billable_detail"		
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
string s_achDWColor, s_achSSAN, s_achLName, s_achFName, s_achMName
long s_lMaxNum

s_achDWColor = dw_scan.Describe("datawindow.color")

SetPointer(Hourglass!)

i_bNew = True
i_achOpType = "Add"
i_achMode = "Continue"
i_bExit = False

st_memo.visible = False
st_served.visible = False
st_diligent.visible = False

cb_new.enabled = False
m_main.m_general.m_new.enabled = False
cb_add.enabled = False
m_main.m_general.m_add.enabled = False
cb_delete.enabled = False
m_main.m_general.m_delete.enabled = False
cb_update.enabled = False
m_main.m_general.m_update.enabled = False

// Security - Add Docket Information
If w_main.dw_perms.Find("code=18", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True
	m_main.m_general.m_save.enabled = True
End If

// Security - Update Docket Information
If w_main.dw_perms.Find("code=19", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True
	m_main.m_general.m_save.enabled = True
End If

// Security - Delete Docket Information
If w_main.dw_perms.Find("code=20", 1, w_main.dw_perms.RowCount()) > 0 Then
	cb_save.enabled = True
	m_main.m_general.m_save.enabled = True
End If

sle_lname.text = ""
sle_fname.text = ""
sle_feebook.text = ""

Choose Case dw_detail.DataObject
	Case "dw_docket_detail"

		dw_detail.Tag = "Docket Information"		
		dw_detail.Reset()		
		dw_detail.InsertRow(0)
		
		dw_detail.SetItem(1,"docket_year", Year(g_dtToday))															
		dw_detail.SetItem(1,"docket_number", 0)																	

		dw_detail.SetItem(1,"docket_state", "IOWA")
		dw_detail.SetItem(1,"county", "CERRO GORDO COUNTY")
		dw_detail.SetItem(1,"process_description", "")
		dw_detail.SetItem(1,"case_number", "")
//		dw_detail.SetItem(1,"incident_date", "")																	
		dw_detail.SetItem(1,"received_date", "")																	
										
		dw_detail.SetRedraw(False)
		dw_detail.Modify("docket_state.background.color = " + s_achDWColor + & 
			" docket_state.tabsequence = 1" + &	
			" county.background.color = " + s_achDWColor + & 
			" county.tabsequence = 2" + &				
			" process_description.background.color = " + s_achDWColor + & 
			" process_description.tabsequence = 3" + &				
			" case_number.background.color = " + s_achDWColor + & 
			" case_number.tabsequence = 4" + &			
			" received_date.background.color = " + s_achDWColor + & 
			" received_date.tabsequence = 5")
		dw_detail.SetRedraw(True)		
		
		i_iRow = 1
		dw_detail.SetRow(i_iRow)		
		dw_detail.ScrollToRow(i_iRow)								

End Choose	

dw_detail.SetFocus()

end event

event ue_delete;// script variables
string s_achErrText, s_achInstrument, s_achLName, s_achFName, s_achMName, s_achSuffix
string s_achName, s_achAllNames
long s_lNameRows
integer s_iCount, s_iRow
long s_lDocketYear, s_lDocketNum
string s_achDocketFee, s_achInvolvement, s_achBusiness

datastore lds_Name

s_achDocketFee = 'D'

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

i_iRow = dw_detail.GetRow()				
s_lDocketYear = dw_detail.getItemNumber(i_iRow,"docket_year")
s_lDocketNum = dw_detail.getItemNumber(i_iRow,"docket_number")
				
Choose Case dw_detail.DataObject
	Case "dw_docket_detail"
		
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
		   If 2 = MessageBox("Delete","Delete This ENTIRE Docket?",Question!,YesNo!,2) Then
		      MessageBox("Delete","Docket NOT Deleted",None!)
		   Else
		
				SetPointer(Hourglass!) 
				
				i_iRow = dw_detail.GetRow()	
				s_lDocketYear = dw_detail.getItemNumber(i_iRow,"docket_year")
				s_lDocketNum = dw_detail.getItemNumber(i_iRow,"docket_number")

				DELETE FROM sh_docket_name
					WHERE sh_docket_name.docket_year = :s_lDocketYear
					AND sh_docket_name.docket_number = :s_lDocketNum;
				If SQLCA.SQLCode = -1 Then
					s_achErrText = SQLCA.SQLErrText
					ROLLBACK;
					MessageBox("Error", "Docket Paries Involved Delete Failed - " + s_achErrText)
				Else
					COMMIT;
				End If			

				DELETE FROM sh_docket_note
					WHERE sh_docket_note.docket_year = :s_lDocketYear
					AND sh_docket_note.docket_number = :s_lDocketNum;
				If SQLCA.SQLCode = -1 Then
					s_achErrText = SQLCA.SQLErrText
					ROLLBACK;
					MessageBox("Error", "Docket Memos Delete Failed - " + s_achErrText)
				Else
					COMMIT;
				End If		

				DELETE FROM sh_docket_billable
					WHERE sh_docket_billable.docket_year = :s_lDocketYear
					AND sh_docket_billable.docket_number = :s_lDocketNum;
				If SQLCA.SQLCode = -1 Then
					s_achErrText = SQLCA.SQLErrText
					ROLLBACK;
					MessageBox("Error", "Docket Billable Delete Failed - " + s_achErrText)
				Else
					COMMIT;
				End If		
				
				DELETE FROM sh_docket_serve
					WHERE sh_docket_serve.docket_year = :s_lDocketYear
					AND sh_docket_serve.docket_number = :s_lDocketNum;
				If SQLCA.SQLCode = -1 Then
					s_achErrText = SQLCA.SQLErrText
					ROLLBACK;
					MessageBox("Error", "Docket Served Delete Failed - " + s_achErrText)
				Else
					COMMIT;
				End If						

				DELETE FROM sh_docket_fee
					WHERE sh_docket_fee.docket_year = :s_lDocketYear
					AND sh_docket_fee.docket_number = :s_lDocketNum
					AND sh_docket_fee.cb_type = :s_achDocketFee;
				If SQLCA.SQLCode = -1 Then
					s_achErrText = SQLCA.SQLErrText
					ROLLBACK;
					MessageBox("Error", "Docket Fees Delete Failed - " + s_achErrText)
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
					End If
				End If
			End If
		End If

	Case "dw_docket_parties_involved_detail"	
		If dw_detail.RowCount() = 0 Then
		   MessageBox("Error","Select Row to Delete",StopSign!)
		Else
		   If 2 = MessageBox("Delete","Delete This Docket Party Involved?",Question!,YesNo!,2) Then
		      MessageBox("Delete","Docket Party Involved NOT Deleted",None!)
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

						// allocate the resources for the datastores
						lds_Name = Create DataStore
						
						lds_Name.DataObject = 'dw_docket_names_ds'
						lds_Name.SetTransObject(SQLCA)
			
						// Retrieve Names on a Docket
	 					s_lNameRows = lds_Name.Retrieve(s_lDocketYear, s_lDocketNum)
						For s_iCount = 1 To s_lNameRows
							
							s_achLName = Trim(lds_Name.GetItemString(s_iCount,"last_name"))				
							s_achFName = Trim(lds_Name.GetItemString(s_iCount,"first_name"))								
							s_achMName = Trim(lds_Name.GetItemString(s_iCount,"middle_name"))								
							s_achSuffix = Trim(lds_Name.GetItemString(s_iCount,"suffix"))												
							s_achInvolvement = Trim(lds_Name.GetItemString(s_iCount,"involvement"))		
							s_achBusiness = Trim(lds_Name.GetItemString(s_iCount,"business"))								

							If s_achInvolvement = 'S' Or s_achInvolvement = 'O' Then
								Continue
							End If							

							If s_achBusiness = 'Y' Then
								s_achName = s_achLName + " " + s_achFName + " " + s_achMName + " " + s_achSuffix
								s_achName = Trim(s_achName) + " (" + s_achInvolvement + ")"						
							Else
								s_achName = s_achFName + " " + s_achMName + " " + s_achLName + " " + s_achSuffix 
								s_achName = Trim(s_achName) + " (" + s_achInvolvement + ")"
							End If	
	
							If Len(s_achAllNames) = 0 Then
									s_achAllNames = s_achName
								Else						
									s_achAllNames = s_achAllNames + " & " + s_achName
							End If
						Next	
			
						dw_scan.SetTransObject(SQLCA)
						dw_scan.SetRedraw(False)
			
						If i_achOpType = "Add" Then
							dw_scan.Modify("datawindow.table.select='" + i_achNewSQL + "'")	
						Else
							dw_scan.Modify("datawindow.table.select='" + i_achSaveSQL + "'")		
						End If
					
						dw_scan.Retrieve()		
			
						// find the row closest to this one
						s_iRow = dw_scan.Find("docket_year = " + String(s_lDocketYear) + &
							" AND docket_number = " + String(s_lDocketNum), 0, dw_scan.RowCount())			
		
						s_achAllNames = Left(Trim(s_achAllNames),600)
						dw_scan.SetItem(s_iRow, "parties_involved", s_achAllNames)
						dw_scan.SetTransObject(SQLCA)
						dw_scan.Update()
						COMMIT;
			
						If s_iRow = 0 Then s_iRow = 1
			
						// highlight only the closest row
						dw_scan.ScrollToRow(s_iRow)				
						dw_scan.SelectRow(0,False)
						dw_scan.SelectRow(s_iRow, True)				
			
						dw_scan.SetRedraw(True)

						// Security - Add Docket Information
						If w_main.dw_perms.Find("code=18", 1, w_main.dw_perms.RowCount()) > 0 Then
							cb_add.enabled = True			
							m_main.m_general.m_add.enabled = True
						End If
						
						// Security - Update Docket Information
						If w_main.dw_perms.Find("code=19", 1, w_main.dw_perms.RowCount()) > 0 Then
							cb_update.enabled = True			
							m_main.m_general.m_update.enabled = True
						End If
						
						// Security - Delete Docket Information
						If w_main.dw_perms.Find("code=20", 1, w_main.dw_perms.RowCount()) > 0 Then
							cb_delete.enabled = True
							m_main.m_general.m_delete.enabled = True
						End If
						cb_name.TriggerEvent("clicked")						
						
					End If
				End If
			End If
		End If

	Case "dw_docket_note_detail"	
		If dw_detail.RowCount() = 0 Then
		   MessageBox("Error","Select Row to Delete",StopSign!)
		Else
		   If 2 = MessageBox("Delete","Delete This Docket Memo?",Question!,YesNo!,2) Then
		      MessageBox("Delete","Docket Memo NOT Deleted",None!)
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
						cb_memo.TriggerEvent("clicked")												
					End If
				End If
			End If
		End If

	Case "dw_docket_billable_detail"	
		If dw_detail.RowCount() = 0 Then
		   MessageBox("Error","Select Row to Delete",StopSign!)
		Else
		   If 2 = MessageBox("Delete","Delete This Docket Billable Party?",Question!,YesNo!,2) Then
		      MessageBox("Delete","Docket Billable Party NOT Deleted",None!)
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
						cb_billable.TriggerEvent("clicked")												
					End If
				End If
			End If
		End If

	Case "dw_docket_served_detail"	
		If dw_detail.RowCount() = 0 Then
		   MessageBox("Error","Select Row to Delete",StopSign!)
		Else
		   If 2 = MessageBox("Delete","Delete This Docket Party Served?",Question!,YesNo!,2) Then
		      MessageBox("Delete","Docket Party Served NOT Deleted",None!)
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
						cb_served.TriggerEvent("clicked")												
					End If
				End If
			End If
		End If

	Case "dw_docket_fees_scan"	
		If dw_detail.RowCount() = 0 Then
		   MessageBox("Error","Select Row to Delete",StopSign!)
		Else
		   If 2 = MessageBox("Delete","Delete This Docket Fee?",Question!,YesNo!,2) Then
		      MessageBox("Delete","Docket Fee NOT Deleted",None!)
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
						cb_fees.TriggerEvent("clicked")												
					End If
				End If
			End If
		End If

End Choose

end event

event ue_print_detail;//string s_achinstnum, s_achReport
//
//s_achReport = "Single Marriage Record"
//
//s_achinstnum = dw_scan.GetItemString(i_iRow, "instrument_no")
//
//// Retrieve Information
//dw_single_marriage.SetTransObject(SQLCA)
//dw_single_marriage.Reset()
//dw_single_marriage.Retrieve(s_achinstnum)	
//
//// Printer Setup and Printout depending on current detail window
//PrintSetup()
//dw_single_marriage.Print()
end event

event ue_add;datawindowchild dwc
string s_achDWColor
integer s_iItemNum, s_iCount, s_iDockYear, s_iRow
long s_lDockNum

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
st_memo.visible = False
st_served.visible = False
st_diligent.visible = False

dw_scan.enabled = False			

i_achOpType = "Add"
If i_bNew = True Then
	i_achMode = "Continue"
Else 
	i_achMode = ""
End If	

Choose Case dw_detail.DataObject
		
	Case "dw_docket_parties_involved_detail"

		// get Involvement Type
		dw_detail.GetChild("involvement", dwc)
		dwc.SetTransObject(SQLCA)
		dwc.Reset()
		dwc.Retrieve("INV")

		If i_achMode = "Continue" Then
			cb_main.enabled = False
			cb_name.enabled = False
			cb_memo.enabled = False
			cb_served.enabled = False
			cb_fees.enabled = False
			cb_billable.enabled = False
		Else
			cb_main.enabled = True
			cb_name.enabled = False
			cb_memo.enabled = True
			cb_served.enabled = True		
			cb_fees.enabled = True		
			cb_billable.enabled = True		
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

		s_iRow = dw_detail.InsertRow(0)
		
		dw_detail.SetItem(s_iRow,"docket_year", s_iDockYear)															
		dw_detail.SetItem(s_iRow,"docket_number", s_lDockNum)																	

		SELECT MAX(party_number) INTO :s_iItemNum
			FROM sh_docket_name
			WHERE sh_docket_name.docket_year = :s_iDockYear
			AND sh_docket_name.docket_number = :s_lDockNum;			
			
		If IsNull(s_iItemNum) Then s_iItemNum = 0			
		s_iItemNum ++
		dw_detail.SetItem(s_iRow, "party_number", s_iItemNum)

		dw_detail.SetItem(s_iRow,"business", "N")		
		dw_detail.SetItem(s_iRow,"last_name", "")	
		dw_detail.SetItem(s_iRow,"first_name", "")	
		dw_detail.SetItem(s_iRow,"middle_name", "")			
		dw_detail.SetItem(s_iRow,"suffix", "")			
		dw_detail.SetItem(s_iRow,"involvement", "")					
		dw_detail.SetItem(s_iRow,"served", "N")							
		dw_detail.SetItem(s_iRow,"name_addr", "")	
		dw_detail.SetItem(s_iRow,"name_employ", "")	
		dw_detail.SetItem(s_iRow,"name_remark", "")	

		dw_detail.SetRedraw(False)
		dw_detail.Modify("business.background.color = " + s_achDWColor + & 
			" business.tabsequence = 1" + &
			" last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 2" + &			
			" first_name.background.color = " + s_achDWColor + & 
			" first_name.tabsequence = 3" + &
			" middle_name.background.color = " + s_achDWColor + & 
			" middle_name.tabsequence = 4" + &						
			" suffix.background.color = " + s_achDWColor + & 
			" suffix.tabsequence = 5" + &
			" involvement.background.color = " + s_achDWColor + & 
			" involvement.tabsequence = 6" + &
			" served.background.color = " + s_achDWColor + & 
			" served.tabsequence = 7" + &			
			" name_addr.background.color = " + s_achDWColor + & 
			" name_addr.tabsequence = 8" + &
			" name_employ.background.color = " + s_achDWColor + & 
			" name_employ.tabsequence = 9" + &					
			" name_remark.background.color = " + s_achDWColor + & 
			" name_remark.tabsequence = 10")					
		dw_detail.SetRedraw(True)			
		dw_detail.ScrollToRow(s_iRow)		
		
	Case "dw_docket_note_detail"

		i_achMode = "Continue"
		
		If i_achMode = "Continue" Then
			cb_main.enabled = False
			cb_name.enabled = False
			cb_memo.enabled = False
			cb_served.enabled = False
			cb_fees.enabled = False
			cb_billable.enabled = False
		Else
			
			cb_main.enabled = True
			cb_name.enabled = True
			cb_memo.enabled = False
			cb_served.enabled = True		
			cb_fees.enabled = True		
			cb_billable.enabled = True		
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

		s_iRow = dw_detail.InsertRow(0)
		
		dw_detail.SetItem(s_iRow,"docket_year", s_iDockYear)															
		dw_detail.SetItem(s_iRow,"docket_number", s_lDockNum)																	

		SELECT max(line_number) INTO :s_iItemNum
			FROM sh_docket_note
			WHERE sh_docket_note.docket_year = :s_iDockYear
			AND sh_docket_note.docket_number = :s_lDockNum;				

		If IsNull(s_iItemNum) Then s_iItemNum = 0			
		s_iItemNum ++
		dw_detail.SetItem(s_iRow, "line_number", s_iItemNum)
		
		dw_detail.SetItem(s_iRow,"comments", "")	
		dw_detail.SetItem(s_iRow,"comment_date", g_dttoday)	
		
		dw_detail.SetRedraw(False)
		dw_detail.Modify("comments.background.color = " + s_achDWColor + & 
			" comments.tabsequence = 1" + &
			" comment_date.background.color = " + s_achDWColor + & 
			" comment_date.tabsequence = 2")						
		dw_detail.SetRedraw(True)			
		dw_detail.ScrollToRow(s_iRow)						

	Case "dw_docket_served_detail"

		// get Service Type
		dw_detail.GetChild("type_served", dwc)
		dwc.SetTransObject(SQLCA)
		dwc.Reset()
		dwc.Retrieve("SRV")

		i_achMode = "Continue"
	
		cb_main.enabled = True
		cb_name.enabled = True
		cb_memo.enabled = True
		cb_served.enabled = False		
		cb_fees.enabled = True		
		cb_billable.enabled = True		

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
		
		dw_detail.SetItem(s_iRow,"docket_year", s_iDockYear)															
		dw_detail.SetItem(s_iRow,"docket_number", s_lDockNum)																	

		SELECT MAX(served_number) INTO :s_iItemNum
			FROM sh_docket_serve
			WHERE sh_docket_serve.docket_year = :s_iDockYear
			AND sh_docket_serve.docket_number = :s_lDockNum;			
			
		If IsNull(s_iItemNum) Then s_iItemNum = 0			
		s_iItemNum ++
		dw_detail.SetItem(s_iRow, "served_number", s_iItemNum)
		
		dw_detail.SetItem(s_iRow,"last_name", "")	
		dw_detail.SetItem(s_iRow,"first_name", "")	
		dw_detail.SetItem(s_iRow,"middle_name", "")			
		dw_detail.SetItem(s_iRow,"suffix", "")	
		dw_detail.SetItem(s_iRow,"type_served", "")				
		dw_detail.SetItem(s_iRow,"date_returned", "")		
		dw_detail.SetItem(s_iRow,"personal_place_served", "")				
		dw_detail.SetItem(s_iRow,"personal_date_served", "")					
		dw_detail.SetItem(s_iRow,"personal_time_served", "")							
		dw_detail.SetItem(s_iRow,"personal_am_pm", "")									
		dw_detail.SetItem(s_iRow,"subs_served_on", "")	
		dw_detail.SetItem(s_iRow,"subs_place_served", "")				
		dw_detail.SetItem(s_iRow,"subs_date_served", "")					
		dw_detail.SetItem(s_iRow,"subs_time_served", "")							
		dw_detail.SetItem(s_iRow,"subs_am_pm", "")	
		dw_detail.SetItem(s_iRow,"corp_served_on", "")
		dw_detail.SetItem(s_iRow,"corp_position", "")	
		dw_detail.SetItem(s_iRow,"corp_place_served", "")				
		dw_detail.SetItem(s_iRow,"corp_date_served", "")					
		dw_detail.SetItem(s_iRow,"corp_time_served", "")							
		dw_detail.SetItem(s_iRow,"corp_am_pm", "")
		dw_detail.SetItem(s_iRow,"diligent_search", "N")													
		dw_detail.SetItem(s_iRow,"time_limit", "")
		dw_detail.SetItem(s_iRow,"other_served", "")
		dw_detail.SetItem(s_iRow,"officer_name", "")															
		dw_detail.SetItem(s_iRow,"served_note", "")																	

		dw_detail.SetRedraw(False)
		dw_detail.Modify("last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 1" + &
			" first_name.background.color = " + s_achDWColor + & 
			" first_name.tabsequence = 2" + &
			" middle_name.background.color = " + s_achDWColor + & 
			" middle_name.tabsequence = 3" + &						
			" suffix.background.color = " + s_achDWColor + & 
			" suffix.tabsequence = 4" + &
			" type_served.background.color = " + s_achDWColor + & 
			" type_served.tabsequence = 5" + &			
			" date_returned.background.color = " + s_achDWColor + & 
			" date_returned.tabsequence = 6" + &
			" personal_place_served.background.color = " + s_achDWColor + & 
			" personal_place_served.tabsequence = 7" + &
			" personal_date_served.background.color = " + s_achDWColor + & 
			" personal_date_served.tabsequence = 8" + &
			" personal_time_served.background.color = " + s_achDWColor + & 
			" personal_time_served.tabsequence = 9" + &
			" personal_am_pm.background.color = " + s_achDWColor + & 
			" personal_am_pm.tabsequence = 10" + &			
			" subs_served_on.background.color = " + s_achDWColor + & 
			" subs_served_on.tabsequence = 11" + &		
			" subs_place_served.background.color = " + s_achDWColor + & 
			" subs_place_served.tabsequence = 12" + &
			" subs_date_served.background.color = " + s_achDWColor + & 
			" subs_date_served.tabsequence = 13" + &
			" subs_time_served.background.color = " + s_achDWColor + & 
			" subs_time_served.tabsequence = 14" + &
			" subs_am_pm.background.color = " + s_achDWColor + & 
			" subs_am_pm.tabsequence = 15" + &	
			" corp_served_on.background.color = " + s_achDWColor + & 
			" corp_served_on.tabsequence = 17" + &				
			" corp_position.background.color = " + s_achDWColor + & 
			" corp_position.tabsequence = 18" + &
			" corp_place_served.background.color = " + s_achDWColor + & 
			" corp_place_served.tabsequence = 19" + &
			" corp_date_served.background.color = " + s_achDWColor + & 
			" corp_date_served.tabsequence = 20" + &
			" corp_time_served.background.color = " + s_achDWColor + & 
			" corp_time_served.tabsequence = 21" + &
			" corp_am_pm.background.color = " + s_achDWColor + & 
			" corp_am_pm.tabsequence = 22" + &					
			" other_served.background.color = " + s_achDWColor + & 
			" other_served.tabsequence = 25" + &				
			" officer_name.background.color = " + s_achDWColor + & 
			" officer_name.tabsequence = 26" + &			
			" served_note.background.color = " + s_achDWColor + & 
			" served_note.tabsequence = 27")
			
		dw_detail.SetRedraw(True)			
		dw_detail.ScrollToRow(s_iRow)						

	Case "dw_docket_fees_scan"

		// get Fee Type
		dw_detail.GetChild("fee_type", dwc)
		dwc.SetTransObject(SQLCA)
		dwc.Reset()
		dwc.Retrieve("FEE")

		i_achMode = "Continue"
		
		cb_main.enabled = True
		cb_name.enabled = True
		cb_memo.enabled = True
		cb_served.enabled = True		
		cb_fees.enabled = False		
		cb_billable.enabled = True		

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
		
		dw_detail.SetItem(s_iRow,"docket_year", s_iDockYear)															
		dw_detail.SetItem(s_iRow,"docket_number", s_lDockNum)																	

		SELECT MAX(fee_number) INTO :s_iItemNum
			FROM sh_docket_fee
			WHERE sh_docket_fee.docket_year = :s_iDockYear
			AND sh_docket_fee.docket_number = :s_lDockNum;			
			
		If IsNull(s_iItemNum) Then s_iItemNum = 0			
		s_iItemNum ++
		dw_detail.SetItem(s_iRow, "fee_number", s_iItemNum)

		dw_detail.SetItem(s_iRow,"cb_type", "D")
		dw_detail.SetItem(s_iRow,"fee_type", "")	
		dw_detail.SetItem(s_iRow,"fee_amount", 0)	
		dw_detail.SetItem(s_iRow,"fee_note", "")		
		dw_detail.SetItem(s_iRow,"amount_received", 0)	
		dw_detail.SetItem(s_iRow,"balance_due", 0)

		dw_detail.SetRedraw(False)
		dw_detail.Modify("fee_type.background.color = " + s_achDWColor + & 
			" fee_type.tabsequence = 1" + &
			" fee_amount.background.color = " + s_achDWColor + & 
			" fee_amount.tabsequence = 2" + &
			" fee_note.background.color = " + s_achDWColor + & 
			" fee_note.tabsequence = 3")
		dw_detail.SetRedraw(True)			
		dw_detail.ScrollToRow(s_iRow)						

	Case "dw_docket_billable_detail"
		
//		i_achMode = "Continue"

		If i_achMode = "Continue" Then
			cb_main.enabled = False
			cb_name.enabled = False
			cb_memo.enabled = False
			cb_served.enabled = False
			cb_fees.enabled = False
			cb_billable.enabled = False
		Else
		
			cb_main.enabled = True
			cb_name.enabled = True
			cb_memo.enabled = True
			cb_served.enabled = True		
			cb_fees.enabled = True		
			cb_billable.enabled = False		
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

		s_iRow = dw_detail.InsertRow(0)
		
		dw_detail.SetItem(s_iRow,"docket_year", s_iDockYear)															
		dw_detail.SetItem(s_iRow,"docket_number", s_lDockNum)																	

		SELECT MAX(billable_number) INTO :s_iItemNum
			FROM sh_docket_billable
			WHERE sh_docket_billable.docket_year = :s_iDockYear
			AND sh_docket_billable.docket_number = :s_lDockNum;			
			
		If IsNull(s_iItemNum) Then s_iItemNum = 0			
		s_iItemNum ++
		dw_detail.SetItem(s_iRow, "billable_number", s_iItemNum)

		dw_detail.SetItem(s_iRow,"business", "Y")	
		dw_detail.SetItem(s_iRow,"last_name", "")	
		dw_detail.SetItem(s_iRow,"first_name", "")	
		dw_detail.SetItem(s_iRow,"middle_name", "")			
		dw_detail.SetItem(s_iRow,"suffix", "")			
		dw_detail.SetItem(s_iRow,"address1", "")					
		dw_detail.SetItem(s_iRow,"address2", "")							
		dw_detail.SetItem(s_iRow,"city", "")							
		dw_detail.SetItem(s_iRow,"state", "")							
		dw_detail.SetItem(s_iRow,"zip_code", "")							
		dw_detail.SetItem(s_iRow,"zip_4", "")							
		dw_detail.SetItem(s_iRow,"work_phone", "")									

		dw_detail.SetRedraw(False)
		dw_detail.Modify("last_name.background.color = " + s_achDWColor + & 
			" last_name.tabsequence = 2" + &
			" address1.background.color = " + s_achDWColor + & 
			" address1.tabsequence = 6" + &
			" address2.background.color = " + s_achDWColor + & 
			" address2.tabsequence = 7" + &			
			" city.background.color = " + s_achDWColor + & 
			" city.tabsequence = 8" + &			
			" state.background.color = " + s_achDWColor + & 
			" state.tabsequence = 9" + &			
			" zip_code.background.color = " + s_achDWColor + & 
			" zip_code.tabsequence = 10" + &			
			" zip_4.background.color = " + s_achDWColor + & 
			" zip_4.tabsequence = 11" + &
			" work_phone.background.color = " + s_achDWColor + & 
			" work_phone.tabsequence = 12")			
		dw_detail.SetRedraw(True)			
		dw_detail.ScrollToRow(s_iRow)						

End Choose	
		
dw_detail.SetFocus()

end event

event resize;gnv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())

end event

type cb_escape from w_base_sheet`cb_escape within w_docket_sheet
integer taborder = 130
end type

type cb_exit from w_base_sheet`cb_exit within w_docket_sheet
integer taborder = 210
end type

type cb_last from w_base_sheet`cb_last within w_docket_sheet
integer taborder = 200
end type

type cb_next from w_base_sheet`cb_next within w_docket_sheet
integer taborder = 190
end type

type cb_back from w_base_sheet`cb_back within w_docket_sheet
integer taborder = 180
end type

type cb_first from w_base_sheet`cb_first within w_docket_sheet
integer taborder = 170
end type

type cb_save from w_base_sheet`cb_save within w_docket_sheet
integer taborder = 140
end type

type cb_delete from w_base_sheet`cb_delete within w_docket_sheet
integer taborder = 120
end type

type cb_update from w_base_sheet`cb_update within w_docket_sheet
integer taborder = 110
end type

type cb_add from w_base_sheet`cb_add within w_docket_sheet
integer taborder = 100
end type

type cb_new from w_base_sheet`cb_new within w_docket_sheet
integer taborder = 90
end type

type cb_clear from w_base_sheet`cb_clear within w_docket_sheet
integer taborder = 80
end type

type cb_search from w_base_sheet`cb_search within w_docket_sheet
integer taborder = 70
end type

type dw_detail from w_base_sheet`dw_detail within w_docket_sheet
event ue_dwnkey pbm_dwnkey
event ue_continue_add pbm_custom13
integer x = 27
integer y = 660
integer width = 3072
integer height = 1276
integer taborder = 360
string dataobject = "dw_docket_detail"
end type

event dw_detail::ue_dwnkey;string s_achDWColor
integer s_iRow, s_iDockYear
long s_lDockNum

s_achDWColor = dw_detail.Describe("datawindow.color")

Choose Case dw_detail.DataObject
	Case "dw_docket_detail"
		
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "received_date"
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
				dw_detail.Modify("docket_state.background.color = " + s_achDWColor + & 
					" docket_state.tabsequence = 0" + &	
					" county.background.color = " + s_achDWColor + & 
					" county.tabsequence = 0" + &							
					" process_description.background.color = " + s_achDWColor + & 
					" process_description.tabsequence = 0" + &		
					" case_number.background.color = " + s_achDWColor + & 
					" case_number.tabsequence = 0" + &			
					" received_date.background.color = " + s_achDWColor + & 
					" received_date.tabsequence = 0")
				dw_detail.SetRedraw(True)			

				s_iRow = dw_scan.GetRow()
	
				s_iDockYear = dw_scan.GetItemNumber(s_iRow,"docket_year")
				s_lDockNum = dw_scan.GetItemNumber(s_iRow,"docket_number")				

				dw_detail.Retrieve(s_iDockYear, s_lDockNum)			
			
				dw_scan.enabled = True

				// Security - Add Dockets
				If w_main.dw_perms.Find("code=18", 1, w_main.dw_perms.RowCount()) > 0 Then
					cb_new.enabled = True
					m_main.m_general.m_new.enabled = True
				End If
				
				// Security - Update Dockets
				If w_main.dw_perms.Find("code=19", 1, w_main.dw_perms.RowCount()) > 0 Then
					cb_update.enabled = True
					m_main.m_general.m_update.enabled = True
				End If

				// Security - Delete Dockets
				If w_main.dw_perms.Find("code=20", 1, w_main.dw_perms.RowCount()) > 0 Then
					cb_delete.enabled = True
					m_main.m_general.m_delete.enabled = True
				End If

				m_main.m_general.m_escape.enabled = False
				cb_escape.enabled = False				
				cb_save.enabled = False
				m_main.m_general.m_save.enabled = False
//				i_bContinueItem = True
				cb_main.enabled = False
				cb_name.enabled = True
				cb_served.enabled = True
				cb_memo.enabled = True
				cb_billable.enabled = True				
				cb_fees.enabled = True				
				
				dw_scan.SetFocus()
			End If
		End If		

	Case "dw_docket_parties_involved_detail"

		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "name_remark"
				If KeyDown(KeyEnter!) Or KeyDown(KeyTab!) Then		
					parent.TriggerEvent("ue_save")
					Return
				End If
	
		End Choose 

		If i_achMode = "Continue" Then
			If KeyDown(KeyEscape!) Then
				i_bContinueItem = False
				
				dw_detail.SetRedraw(False)		
				dw_detail.Modify("business.background.color = " + s_achDWColor + & 
					" business.tabsequence = 0" + &
					" last_name.background.color = " + s_achDWColor + & 
					" last_name.tabsequence = 0" + &							
					" first_name.background.color = " + s_achDWColor + & 
					" first_name.tabsequence = 0" + &				
					" middle_name.background.color = " + s_achDWColor + & 
					" middle_name.tabsequence = 0" + &
					" suffix.background.color = " + s_achDWColor + & 
					" suffix.tabsequence = 0" + &	
					" involvement.background.color = " + s_achDWColor + & 
					" involvement.tabsequence = 0" + &	
					" served.background.color = " + s_achDWColor + & 
					" served.tabsequence = 0" + &					
					" name_addr.background.color = " + s_achDWColor + & 
					" name_addr.tabsequence = 0" + &
					" name_employ.background.color = " + s_achDWColor + & 
					" name_employ.tabsequence = 0" + &					
					" name_remark.background.color = " + s_achDWColor + & 
					" name_remark.tabsequence = 0")						
				dw_detail.SetRedraw(True)			
				
				If i_achOpType = "Add" Then
					dw_detail.PostEvent("ue_continue_add")
				End If
			End If
		End If		

	Case "dw_docket_note_detail"

		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "comment_date"
				If KeyDown(KeyEnter!) Or KeyDown(KeyTab!) Then		
					parent.TriggerEvent("ue_save")
					Return
				End If
	
		End Choose 

		If i_achMode = "Continue" Then
			If KeyDown(KeyEscape!) Then
				i_bContinueItem = False
				
				dw_detail.SetRedraw(False)		
				dw_detail.Modify("comments.background.color = " + s_achDWColor + & 
					" comments.tabsequence = 0" + &
					" comment_date.background.color = " + s_achDWColor + & 
					" comment_date.tabsequence = 0")								
				dw_detail.SetRedraw(True)			
				
				If i_achOpType = "Add" Then
					dw_detail.PostEvent("ue_continue_add")
				End If
			End If
		End If		

	Case "dw_docket_served_detail"

		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "served_note"
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
					" suffix.tabsequence = 0" + &
					" type_served.background.color = " + s_achDWColor + & 
					" type_served.tabsequence = 0" + &			
					" date_returned.background.color = " + s_achDWColor + & 
					" date_returned.tabsequence = 0" + &
					" personal_place_served.background.color = " + s_achDWColor + & 
					" personal_place_served.tabsequence = 0" + &
					" personal_date_served.background.color = " + s_achDWColor + & 
					" personal_date_served.tabsequence = 0" + &
					" personal_time_served.background.color = " + s_achDWColor + & 
					" personal_time_served.tabsequence = 0" + &
					" personal_am_pm.background.color = " + s_achDWColor + & 
					" personal_am_pm.tabsequence = 0" + &			
					" subs_served_on.background.color = " + s_achDWColor + & 
					" subs_served_on.tabsequence = 0" + &		
					" subs_place_served.background.color = " + s_achDWColor + & 
					" subs_place_served.tabsequence = 0" + &
					" subs_date_served.background.color = " + s_achDWColor + & 
					" subs_date_served.tabsequence = 0" + &
					" subs_time_served.background.color = " + s_achDWColor + & 
					" subs_time_served.tabsequence = 0" + &
					" subs_am_pm.background.color = " + s_achDWColor + & 
					" subs_am_pm.tabsequence = 0" + &	
					" corp_served_on.background.color = " + s_achDWColor + & 
					" corp_served_on.tabsequence = 0" + &				
					" corp_position.background.color = " + s_achDWColor + & 
					" corp_position.tabsequence = 0" + &
					" corp_place_served.background.color = " + s_achDWColor + & 
					" corp_place_served.tabsequence = 0" + &
					" corp_date_served.background.color = " + s_achDWColor + & 
					" corp_date_served.tabsequence = 0" + &
					" corp_time_served.background.color = " + s_achDWColor + & 
					" corp_time_served.tabsequence = 0" + &
					" corp_am_pm.background.color = " + s_achDWColor + & 
					" corp_am_pm.tabsequence = 0" + &					
					" other_served.background.color = " + s_achDWColor + & 
					" other_served.tabsequence = 0" + &				
					" officer_name.background.color = " + s_achDWColor + & 
					" officer_name.tabsequence = 0" + &			
					" served_note.background.color = " + s_achDWColor + & 
					" served_note.tabsequence = 0")		
				dw_detail.SetRedraw(True)			
				
				If i_achOpType = "Add" Then
					dw_detail.PostEvent("ue_continue_add")
				End If
			End If
		End If		
	
	Case "dw_docket_fees_scan"

		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "fee_amount"
				If KeyDown(KeyUpArrow!) Or KeyDown(KeyDownArrow!) Then		
					parent.TriggerEvent("ue_save")
					Return
				End If

			Case "fee_note"
				If KeyDown(KeyEnter!) Or KeyDown(KeyTab!) or KeyDown(KeyUpArrow!) Or KeyDown(KeyDownArrow!) Then		
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
				
				// Added to show balance due
				cb_balance_due.PostEvent("clicked")
				
			End If
		End If		
	
	Case "dw_docket_billable_detail"

		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters

			Case "work_phone"
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
					" address1.background.color = " + s_achDWColor + & 
					" address1.tabsequence = 0" + &
					" address2.background.color = " + s_achDWColor + & 
					" address2.tabsequence = 0" + &			
					" city.background.color = " + s_achDWColor + & 
					" city.tabsequence = 0" + &			
					" state.background.color = " + s_achDWColor + & 
					" state.tabsequence = 0" + &			
					" zip_code.background.color = " + s_achDWColor + & 
					" zip_code.tabsequence = 0" + &			
					" zip_4.background.color = " + s_achDWColor + & 
					" zip_4.tabsequence = 0" + &
					" work_phone.background.color = " + s_achDWColor + & 
					" work_phone.tabsequence = 0")								
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
	dw_detail.DataObject = "dw_docket_parties_involved_detail"
	dw_detail.SetTransObject(SQLCA)								

	If i_achMode = "Continue" And i_bNew = True Then 
		m_main.m_general.m_add.TriggerEvent("clicked")
	End If	

	If i_achMode = "Continue" And i_bServed Then	
		dw_detail.DataObject = "dw_docket_served_detail"
		dw_detail.SetTransObject(SQLCA)								
	
		m_main.m_general.m_add.TriggerEvent("clicked")
	End If

	If i_achMode = "Continue" And i_bMemo Then	
		dw_detail.DataObject = "dw_docket_note_detail"
		dw_detail.SetTransObject(SQLCA)								
	
		m_main.m_general.m_add.TriggerEvent("clicked")
	End If

Else

	If i_achMode = "Continue" And i_bName And i_bNew = True Then
		If i_achOpType = "Add" Then
			If 1 = MessageBox("Docket Memo Information","Add Docket Memo Information?",Question!,YesNo!,2) Then
				dw_detail.DataObject = "dw_docket_note_detail"
				dw_detail.SetTransObject(SQLCA)								
				cb_memo.PostEvent("clicked")
				Return
			Else
				If 1 = MessageBox("Docket Billing Information","Add Docket Billing Information?",Question!,YesNo!,1) Then
					dw_detail.DataObject = "dw_docket_billable_detail"
					dw_detail.SetTransObject(SQLCA)								
					cb_billable.PostEvent("clicked")
					Return
				End If				

			End If
		End If	
	End If				

	If i_achMode = "Continue" And i_bMemo And i_bNew = True Then
		If i_achOpType = "Add" Then
			If 1 = MessageBox("Docket Billing Information","Add Docket Billing Information?",Question!,YesNo!,1) Then
				dw_detail.DataObject = "dw_docket_billable_detail"
				dw_detail.SetTransObject(SQLCA)								
				cb_billable.PostEvent("clicked")
				Return
			End If
		End If	
	End If				

	dw_detail.DataObject = "dw_docket_detail"
	dw_detail.SetTransObject(SQLCA)								
	
	If i_achMode = "Continue" And i_bNew = True And i_bServed = False And i_bFees = False Then
		If 1 = MessageBox("Print Service Slip","Do you want to print a service slip?",Question!,YesNo!,1) Then
			cb_serv_slip.PostEvent("clicked")
		End If
		
		m_main.m_general.m_new.TriggerEvent("clicked")
	End If
	
	If i_achMode = "Continue" And (i_bServed = True Or i_bFees = True Or i_bMemo) = True Then 
		cb_main.PostEvent("clicked")
		Return		
	End If

End If

end event

event dw_detail::itemchanged;call super::itemchanged;datawindowchild dwc
string s_achInvolvement, s_achServiceType, s_achFeeType
string s_achDWColor, s_achDDWColor
integer s_iRow, s_iLegals, s_iPages, s_iHour, s_iCount
string s_achPersTime, s_achSubsTime, s_achCorpTime
string s_achPersonal, s_achSubstitute, s_achCorporate

s_achDWColor = dw_scan.Describe("datawindow.color")
s_achDDWColor = dw_detail.Describe("datawindow.color")
s_iRow = dw_detail.GetRow()					
Choose Case dw_detail.DataObject

	Case "dw_docket_parties_involved_detail"
		
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters
			Case "involvement"			
	
				s_achInvolvement = Upper(Trim(data))
				If s_achInvolvement <> "" Then				
					SELECT COUNT(*) INTO :s_iCount
						FROM ut_codes
						WHERE ut_codes.code = :s_achInvolvement
						AND ut_codes.code_type = 'INV';
					If s_iCount = 0 Then
						MessageBox("Error","Invalid Involvement Type!")
						dw_detail.SetItem(s_iRow,"involvement",s_achInvolvement)																		
						data = ""
						this.SetText(data)					
						RETURN 1
					Else
						dw_detail.SetItem(s_iRow,"involvement",s_achInvolvement)													
						this.SetText(data)
						Return 2						
					End If
				End If				
				
		End Choose

	Case "dw_docket_served_detail"
		
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters
			Case "type_served"			
	
				s_achServiceType = Upper(Trim(data))
				If s_achServiceType <> "" Then				
					SELECT COUNT(*) INTO :s_iCount
						FROM ut_codes
						WHERE ut_codes.code = :s_achServiceType
						AND ut_codes.code_type = 'SRV';
					If s_iCount = 0 Then
						MessageBox("Error","Invalid Service Type!")
						dw_detail.SetItem(s_iRow,"type_served",s_achServiceType)																		
						data = ""
						this.SetText(data)					
						RETURN 1
					Else
						dw_detail.SetItem(s_iRow,"type_served",s_achServiceType)													
						this.SetText(data)
						Return 2						
					End If
				End If				

			Case "personal_time_served"			
				s_achPersonal = data	
				s_achPersTime = Left(data, 2)

				If trim(s_achPersTime) <> "" and s_achPersTime <> "00" and s_achPersTime <> "01" &
					and s_achPersTime <> "02" and s_achPersTime <> "03" and s_achPersTime <> "04" &	
					and s_achPersTime <> "05" and s_achPersTime <> "06" and s_achPersTime <> "07" &	
					and s_achPersTime <> "08" and s_achPersTime <> "09" and s_achPersTime <> "10" &
					and s_achPersTime <> "11" and s_achPersTime <> "12" Then	
					
					MessageBox("Error","Invalid Personal Time Served!")
					dw_detail.SetItem(s_iRow,"personal_time_served",s_achPersonal)																		
					data = ""
					this.SetText(data)					
					RETURN 1
				Else
					dw_detail.SetItem(s_iRow,"personal_time_served",s_achPersonal)													
					this.SetText(data)
					Return 2						
				End If


			Case "subs_time_served"			
				s_achSubstitute = data	
				s_achSubsTime = Left(data, 2)

				If trim(s_achSubsTime) <> "" and s_achSubsTime <> "00" and s_achSubsTime <> "01" &
					and s_achSubsTime <> "02" and s_achSubsTime <> "03" and s_achSubsTime <> "04" &	
					and s_achSubsTime <> "05" and s_achSubsTime <> "06" and s_achSubsTime <> "07" &	
					and s_achSubsTime <> "08" and s_achSubsTime <> "09" and s_achSubsTime <> "10" &
					and s_achSubsTime <> "11" and s_achSubsTime <> "12" Then	
					
					MessageBox("Error","Invalid Substitute Time Served!")
					dw_detail.SetItem(s_iRow,"subs_time_served",s_achSubstitute)																		
					data = ""
					this.SetText(data)					
					RETURN 1
				Else
					dw_detail.SetItem(s_iRow,"subs_time_served",s_achSubstitute)													
					this.SetText(data)
					Return 2						
				End If			

			Case "corp_time_served"			
				s_achCorporate = data	
				s_achCorpTime = Left(data, 2)

				If trim(s_achCorpTime) <> "" and s_achCorpTime <> "00" and s_achCorpTime <> "01" &
					and s_achCorpTime <> "02" and s_achCorpTime <> "03" and s_achCorpTime <> "04" &	
					and s_achCorpTime <> "05" and s_achCorpTime <> "06" and s_achCorpTime <> "07" &	
					and s_achCorpTime <> "08" and s_achCorpTime <> "09" and s_achCorpTime <> "10" &
					and s_achCorpTime <> "11" and s_achCorpTime <> "12" Then	
					
					MessageBox("Error","Invalid Corporate Time Served!")
					dw_detail.SetItem(s_iRow,"corp_time_served",s_achCorporate)																		
					data = ""
					this.SetText(data)					
					RETURN 1
				Else
					dw_detail.SetItem(s_iRow,"corp_time_served",s_achCorporate)													
					this.SetText(data)
					Return 2						
				End If	
				
		End Choose

	Case "dw_docket_fees_scan"
		
		Choose Case this.GetColumnName()
		
			// getcolumnname always returns lower case letters
			Case "fee_type"			
	
				s_achFeeType = Upper(Trim(data))
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
		
	Case "dw_docket_detail"

//			Send(Handle(this),256,9,Long(0,0))
//			RETURN 1
		
			// getcolumnname always returns lower case letters

			Case "case_number" 
		
				Send(Handle(this),256,9,Long(0,0))
				RETURN 1
			
			Case "incident_date" 
		
				Send(Handle(this),256,9,Long(0,0))
				RETURN 1

			Case "received_date" 
		
				Send(Handle(this),256,9,Long(0,0))
				RETURN 1

	Case "dw_docket_parties_involved_detail"
		
		Send(Handle(this),256,9,Long(0,0))
		RETURN 1

	Case "dw_docket_served_detail"
		
		Send(Handle(this),256,9,Long(0,0))
		RETURN 1

	Case "dw_docket_fees_scan"
		
		Send(Handle(this),256,9,Long(0,0))
		RETURN 1

	Case "dw_docket_billable_detail"
		
		Send(Handle(this),256,9,Long(0,0))
		RETURN 1

	Case "dw_docket_note_detail"
		
		Send(Handle(this),256,9,Long(0,0))
		RETURN 1

End Choose		

end event

event dw_detail::constructor;call super::constructor;/*
gnv_dwresize = Create n_cst_dwsrv_resize
gnv_dwresize.of_SetRequestor ( this )
gnv_dwresize.of_SetOrigSize (this.Width, this.Height)

// Args - PercentageX, PercentageY, PercentageWidth, PercentageHeight
gnv_dwresize.of_Register('docket_year_t', 0, 0, 50, 50)
gnv_dwresize.of_Register('docket_year', 50, 0, 70, 50)
gnv_dwresize.of_Register('docket_number_t', 0, 40, 50, 50)
gnv_dwresize.of_Register('docket_number', 50, 40, 70, 50)
gnv_dwresize.of_Register('process_description_t', 0, 60, 50, 50)
gnv_dwresize.of_Register('process_description', 50, 60, 70, 50)	
	*/
end event

event dw_detail::resize;call super::resize;//gnv_dwresize.Event pfc_Resize (sizetype, This.Width, This.Height)
end event

event dw_detail::destructor;call super::destructor;//Destroy gnv_dwresize
end event

type dw_scan from w_base_sheet`dw_scan within w_docket_sheet
integer x = 27
integer y = 188
integer width = 3072
integer height = 380
integer taborder = 350
string dataobject = "dw_docket_scan"
end type

event dw_scan::rowfocuschanged;//datawindowchild	dwc
//integer s_iDockYear
//long s_lCount, s_lDockNum, s_lCount2, s_lCount3, s_lCount4
//integer s_irow
//
//i_log.of_log('rowfocuschanged begin')
//			
//dw_detail.SetTransObject(SQLCA)
//
//s_irow = dw_scan.GetRow()
//
//If s_irow > 0 Then
//	
//	Choose Case dw_detail.DataObject
//		Case "dw_docket_detail"
//i_log.of_log('dw  detao')
//			dw_detail.Tag = "Docket Information"
//			
//			dw_scan.SelectRow(0,False)
//			dw_scan.SelectRow(currentrow, True)
//			
//			dw_detail.Retrieve(dw_scan.GetItemNumber(s_irow, "docket_year"), &
//				dw_scan.GetItemNumber(s_irow, "docket_number"))
//i_log.of_log('dw  getitemnumber')
//			s_iDockYear = dw_scan.GetItemNumber(s_irow, "docket_year")
//			s_lDockNum = dw_scan.GetItemNumber(s_irow, "docket_number")
//
//			// Memo
//			SELECT Count(*) INTO :s_lCount
//				FROM sh_docket_note
//				WHERE sh_docket_note.docket_year = :s_iDockYear
//				AND sh_docket_note.docket_number = :s_lDockNum;				
//			i_log.of_log('dw  selectsql1')
//			If s_lCount > 0 Then
//				st_memo.visible = True
//			Else
//				st_memo.visible = False
//			End If
//
//			// Served
//			SELECT Count(*) INTO :s_lCount2
//				FROM sh_docket_serve
//				WHERE sh_docket_serve.docket_year = :s_iDockYear
//				AND sh_docket_serve.docket_number = :s_lDockNum
//				AND sh_docket_serve.type_served <> 'D';				
//			i_log.of_log('dw  selectsql2')			
//			If s_lCount2 > 0 Then
//				st_served.visible = True
//			Else
//				st_served.visible = False
//			End If
//
//			// Diligent Search
//			SELECT Count(*) INTO :s_lCount3
//				FROM sh_docket_serve
//				WHERE sh_docket_serve.docket_year = :s_iDockYear
//				AND sh_docket_serve.docket_number = :s_lDockNum
//				AND sh_docket_serve.type_served = 'D';				
//						i_log.of_log('dw  selectsql3')
//			If s_lCount3 > 0 Then
//				st_diligent.visible = True
//			Else
//				st_diligent.visible = False
//			End If		
//
//			// Receipt
//			SELECT Count(*) INTO :s_lCount4
//				FROM sh_docket_receipt
//				WHERE sh_docket_receipt.docket_year = :s_iDockYear
//				AND sh_docket_receipt.docket_number = :s_lDockNum;				
//						i_log.of_log('dw  selectsql4')
//			If s_lCount4 > 0 Then
//				st_receipt.visible = True
//			Else
//				st_receipt.visible = False
//			End If
//		
//	End Choose		
//
//End If	
//i_log.of_log('rowfocuschanged end')
end event

type gb_5 from w_base_sheet`gb_5 within w_docket_sheet
end type

type gb_4 from w_base_sheet`gb_4 within w_docket_sheet
end type

type gb_1 from w_base_sheet`gb_1 within w_docket_sheet
end type

type gb_2 from w_base_sheet`gb_2 within w_docket_sheet
end type

type cb_list from w_base_sheet`cb_list within w_docket_sheet
integer taborder = 150
end type

type cb_detail from w_base_sheet`cb_detail within w_docket_sheet
integer taborder = 160
end type

type gb_3 from w_base_sheet`gb_3 within w_docket_sheet
end type

type st_1 from statictext within w_docket_sheet
integer y = 20
integer width = 315
integer height = 76
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

type sle_lname from singlelineedit within w_docket_sheet
integer x = 325
integer y = 12
integer width = 1294
integer height = 84
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

type st_2 from statictext within w_docket_sheet
integer x = 1632
integer y = 20
integer width = 178
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "First:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_fname from singlelineedit within w_docket_sheet
integer x = 1819
integer y = 12
integer width = 507
integer height = 84
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

type st_memo from statictext within w_docket_sheet
boolean visible = false
integer x = 2821
integer y = 668
integer width = 265
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 255
boolean enabled = false
string text = "Memo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_pclip from commandbutton within w_docket_sheet
integer x = 3232
integer y = 1852
integer width = 201
integer height = 68
integer taborder = 340
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&PCLIP"
end type

event clicked;/*
string s_achexecute, s_achexecute2
string s_achbook, s_achpage, s_achFeeBook

i_iRow = dw_scan.GetRow()
	
s_achFeeBook = Trim(dw_scan.GetItemString(i_iRow,"instrument_no"))
s_achBook = Trim(dw_scan.GetItemString(i_iRow,"book"))
s_achPage = Trim(dw_scan.GetItemString(i_iRow,"page"))

s_achFeeBook = string(s_achFeeBook,'@@@@-@@@@@@')
s_achFeeBook = RightTrim(s_achFeeBook)

dw_scan.SetFocus()

//s_achexecute = "\\cgmis1\PaperClip\PaperClip32 Server\pclipwin.exe -F" + '"' + "XFILES|" + string(s_achbook) + "|" + string(s_achpage) + "|" + string(s_achfeebook) + '"'
s_achexecute = "\\cgmis1\PaperClip\PaperClip32 Server\pclipwin.exe -F" + '"' + "VITALS|" + string(s_achbook) + "|" + string(s_achpage) + "|" + string(s_achfeebook) + '"'
//s_achexecute2 = "C:\Program Files\Wsize32\wsize32.exe PaperClip32 (Cerro Gordo County),focus"

Run(s_achexecute)
//Run(s_achexecute2)
*/
end event

type st_6 from statictext within w_docket_sheet
integer y = 108
integer width = 315
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Case Num:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_feebook from singlelineedit within w_docket_sheet
integer x = 325
integer y = 96
integer width = 553
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_served from commandbutton within w_docket_sheet
integer x = 3163
integer y = 1100
integer width = 448
integer height = 68
integer taborder = 260
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Served"
end type

event clicked;
datawindowchild	dwc
string s_achLName
long s_lCount, s_lDockNum
integer s_iItemNum, s_iDockYear, s_iRow

dw_scan.enabled = False
i_bServed = True

//st_memo.visible = False
//st_served.visible = False
//st_diligent.visible = False

st_message.text = ""

cb_main.enabled = True
cb_name.enabled = True
cb_memo.enabled = True
cb_served.enabled = False
cb_fees.enabled = True
cb_billable.enabled = True
			
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

s_irow = dw_scan.GetRow()

s_iDockYear = dw_scan.GetItemNumber(s_iRow, "docket_year")
s_lDockNum = dw_scan.GetItemNumber(s_iRow, "docket_number")

dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Served Information"

SELECT COUNT(*) INTO :s_iItemNum
	FROM sh_docket_serve
	WHERE sh_docket_serve.docket_year = :s_iDockYear
	AND sh_docket_serve.docket_number = :s_lDockNum;	
If s_iItemNum = 0 Then
	// Not found, Okay to insert Docket Served Information
	// Security - Add Docket Served Information
	If w_main.dw_perms.Find("code=38", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True			
		m_main.m_general.m_add.enabled = True
	End If

	dw_detail.DataObject = "dw_docket_served_detail"
	dw_detail.SetTransObject(SQLCA)
	
	// Security - Add Docket Served Information
	If w_main.dw_perms.Find("code=38", 1, w_main.dw_perms.RowCount()) > 0 Then
		m_main.m_general.m_add.TriggerEvent("clicked")
	End If	

	// get Service Type
	dw_detail.GetChild("type_served", dwc)
	dwc.SetTransObject(SQLCA)
	dwc.Reset()
	dwc.Retrieve("SRV")

Else   // Found, Retrieve Docket Served Information
		
	// Security - Add Docket Served Information
	If w_main.dw_perms.Find("code=38", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True			
		m_main.m_general.m_add.enabled = True
	End If
	
	// Security - Update Docket Served Information
	If w_main.dw_perms.Find("code=39", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_update.enabled = True			
		m_main.m_general.m_update.enabled = True
	End If
	
	// Security - Delete Docket Served Information
	If w_main.dw_perms.Find("code=40", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_delete.enabled = True
		m_main.m_general.m_delete.enabled = True
	End If

	cb_save.enabled = False
	m_main.m_general.m_save.enabled = False	

	dw_detail.DataObject = "dw_docket_served_detail"		
	dw_detail.SetTransObject(SQLCA)
	dw_detail.Tag = "Docket Served Information"		

	// get Service Type
	dw_detail.GetChild("type_served", dwc)
	dwc.SetTransObject(SQLCA)
	dwc.Reset()
	dwc.Retrieve("SRV")

	dw_detail.Retrieve(s_iDockYear, s_lDockNum)		

	If i_achMode = "Continue" And i_bNew = True Then
		// Security - Add Docket Served
		If w_main.dw_perms.Find("code=38", 1, w_main.dw_perms.RowCount()) > 0 Then
			m_main.m_general.m_update.TriggerEvent("clicked")
		End If
	End If
		
End If
			
dw_detail.SetFocus()			

end event

type cb_fees from commandbutton within w_docket_sheet
integer x = 3163
integer y = 1176
integer width = 448
integer height = 68
integer taborder = 270
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Fees"
end type

event clicked;
datawindowchild	dwc
string s_achLName
long s_lCount, s_lDockNum
integer s_iItemNum, s_iDockYear, s_iRow
decimal {2} s_dtotfees

dw_scan.enabled = False
i_bFees = True

//st_memo.visible = False
//st_served.visible = False
//st_diligent.visible = False

//st_fee_total.visible = True
//st_fee_total_text.visible = True

cb_main.enabled = True
cb_name.enabled = True
cb_memo.enabled = True
cb_served.enabled = True
cb_fees.enabled = False
cb_billable.enabled = True
			
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

s_irow = dw_scan.GetRow()

s_iDockYear = dw_scan.GetItemNumber(s_iRow, "docket_year")
s_lDockNum = dw_scan.GetItemNumber(s_iRow, "docket_number")

SELECT sum(fee_amount) 
	INTO :s_dtotfees
	FROM sh_docket_fee
	WHERE cb_type = 'D'
		AND docket_year = :s_iDockYear
		AND docket_number = :s_lDockNum;
If IsNull(s_dtotfees) Then s_dtotfees = 0

st_message.text = "Fee Total: " + String(s_dtotfees,'#,##0.00')

dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Fees Information"

SELECT COUNT(*) INTO :s_iItemNum
	FROM sh_docket_fee
	WHERE sh_docket_fee.docket_year = :s_iDockYear
	AND sh_docket_fee.docket_number = :s_lDockNum
	AND sh_docket_fee.cb_type = 'D';	
If s_iItemNum = 0 Then
	// Not found, Okay to insert Docket Fees Information
	// Security - Add Docket Fees Information
	If w_main.dw_perms.Find("code=42", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True			
		m_main.m_general.m_add.enabled = True
	End If

	dw_detail.DataObject = "dw_docket_fees_scan"
	dw_detail.SetTransObject(SQLCA)
	
	// Security - Add Docket Fees Information
	If w_main.dw_perms.Find("code=42", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True					
		m_main.m_general.m_add.TriggerEvent("clicked")
	End If	

	// get Fee Type
	dw_detail.GetChild("fee_type", dwc)
	dwc.SetTransObject(SQLCA)
	dwc.Reset()
	dwc.Retrieve("FEE")

Else   // Found, Retrieve Docket Fees Information
		
	// Security - Add Docket Fees Information
	If w_main.dw_perms.Find("code=42", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True			
		m_main.m_general.m_add.enabled = True
	End If
	
	// Security - Update Docket Fees Information
	If w_main.dw_perms.Find("code=43", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_update.enabled = True			
		m_main.m_general.m_update.enabled = True
	End If
	
	// Security - Delete Docket Fees Information
	If w_main.dw_perms.Find("code=44", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_delete.enabled = True
		m_main.m_general.m_delete.enabled = True
	End If

	cb_save.enabled = False
	m_main.m_general.m_save.enabled = False	

	dw_detail.DataObject = "dw_docket_fees_scan"		
	dw_detail.SetTransObject(SQLCA)
	dw_detail.Tag = "Docket Fees Information"		

	// get Fee Type
	dw_detail.GetChild("fee_type", dwc)
	dwc.SetTransObject(SQLCA)
	dwc.Reset()
	dwc.Retrieve("FEE")

	dw_detail.Retrieve(s_iDockYear, s_lDockNum)		
	dw_detail.SetRowFocusIndicator(Hand!)

	If i_achMode = "Continue" And i_bNew = True Then
		// Security - Add Docket Fees
		If w_main.dw_perms.Find("code=42", 1, w_main.dw_perms.RowCount()) > 0 Then
			m_main.m_general.m_update.TriggerEvent("clicked")
		End If
	End If
		
End If
			
dw_detail.SetFocus()			

end event

type cb_billable from commandbutton within w_docket_sheet
integer x = 3163
integer y = 956
integer width = 448
integer height = 68
integer taborder = 250
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Billable Parties"
end type

event clicked;
datawindowchild	dwc
string s_achLName
long s_lCount, s_lDockNum, s_iRow
integer s_iItemNum, s_iDockYear

dw_scan.enabled = False
i_bBillable = True

i_bName = False
i_bMemo = False

//st_memo.visible = False
//st_served.visible = False
//st_diligent.visible = False

st_message.text = ""

cb_main.enabled = True
cb_name.enabled = True
cb_memo.enabled = True
cb_served.enabled = True
cb_fees.enabled = True
cb_billable.enabled = False
			
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

s_irow = dw_scan.GetRow()

s_iDockYear = dw_scan.GetItemNumber(s_iRow, "docket_year")
s_lDockNum = dw_scan.GetItemNumber(s_iRow, "docket_number")

dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Billable Parties Information"

SELECT COUNT(*) INTO :s_iItemNum
	FROM sh_docket_billable
	WHERE sh_docket_billable.docket_year = :s_iDockYear
	AND sh_docket_billable.docket_number = :s_lDockNum;	
If s_iItemNum = 0 Then
	// Not found, Okay to insert Docket Billable Parties Information
	// Security - Add Docket Billable Parties Information
	If w_main.dw_perms.Find("code=30", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True			
		m_main.m_general.m_add.enabled = True
	End If

	dw_detail.DataObject = "dw_docket_billable_detail"
	dw_detail.SetTransObject(SQLCA)
	
	// Security - Add Docket Billable Parties Information
	If w_main.dw_perms.Find("code=30", 1, w_main.dw_perms.RowCount()) > 0 Then
		m_main.m_general.m_add.TriggerEvent("clicked")
	End If	
		
Else   // Found, Retrieve Docket Billable Parties Information
		
	// Security - Add Docket Billable Parties Information
	If w_main.dw_perms.Find("code=30", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True			
		m_main.m_general.m_add.enabled = True
	End If
	
	// Security - Update Docket Billable Parties Information
	If w_main.dw_perms.Find("code=31", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_update.enabled = True			
		m_main.m_general.m_update.enabled = True
	End If
	
	// Security - Delete Docket Billable Parties Information
	If w_main.dw_perms.Find("code=32", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_delete.enabled = True
		m_main.m_general.m_delete.enabled = True
	End If

	cb_save.enabled = False
	m_main.m_general.m_save.enabled = False	

	dw_detail.DataObject = "dw_docket_billable_detail"		
	dw_detail.SetTransObject(SQLCA)
	dw_detail.Tag = "Docket Billable Parties Information"		

	dw_detail.Retrieve(s_iDockYear, s_lDockNum)		

	If i_achMode = "Continue" And i_bNew = True Then
		// Security - Add Docket Billable Parties
		If w_main.dw_perms.Find("code=30", 1, w_main.dw_perms.RowCount()) > 0 Then
			m_main.m_general.m_update.TriggerEvent("clicked")
		End If
	End If
		
End If
			
dw_detail.SetFocus()			

end event

type cb_memo from commandbutton within w_docket_sheet
integer x = 3163
integer y = 884
integer width = 448
integer height = 68
integer taborder = 240
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "M&emo"
end type

event clicked;
datawindowchild dwc
integer s_iItemNum, s_iDockYear, s_iRow
long s_lDockNum

dw_scan.enabled = False
cb_main.enabled = True
cb_name.enabled = True
cb_served.enabled = True
cb_fees.enabled = True
cb_billable.enabled = True

i_bName = False
i_bMemo = True

cb_memo.enabled = False

//st_memo.visible = False
//st_served.visible = False
//st_diligent.visible = False

st_message.text = ""

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

s_irow = dw_scan.GetRow()

s_iDockYear = dw_scan.GetItemNumber(s_iRow, "docket_year")
s_lDockNum = dw_scan.GetItemNumber(s_iRow, "docket_number")

i_achMode = "Continue"

dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Memos"

SELECT COUNT(*) INTO :s_iItemNum
	FROM sh_docket_note
	WHERE sh_docket_note.docket_year = :s_iDockYear
	AND sh_docket_note.docket_number = :s_lDockNum;
If s_iItemNum = 0 Then
	// Not found, Okay to insert Docket Memos
	// Security - Add Docket Memos
	If w_main.dw_perms.Find("code=26", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True
		m_main.m_general.m_add.enabled = True
	End If

	dw_detail.DataObject = "dw_docket_note_detail"
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
	
	dw_detail.DataObject = "dw_docket_note_detail"		
	dw_detail.SetTransObject(SQLCA)
	dw_detail.Tag = "Docket Memo"

	dw_detail.Retrieve(s_iDockYear, s_lDockNum)		
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

type cb_name from commandbutton within w_docket_sheet
integer x = 3163
integer y = 812
integer width = 448
integer height = 68
integer taborder = 230
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Parties &Involved"
end type

event clicked;
datawindowchild	dwc
string s_achLName
long s_lCount, s_lDockNum
integer s_iItemNum, s_iDockYear, s_iRow

dw_scan.enabled = False
i_bName = True
i_bMemo = False

//st_memo.visible = False
//st_served.visible = False
//st_diligent.visible = False

st_message.text = ""

cb_main.enabled = True
cb_name.enabled = False
cb_memo.enabled = True
cb_served.enabled = True
cb_fees.enabled = True
cb_billable.enabled = True
			
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

s_irow = dw_scan.GetRow()

s_iDockYear = dw_scan.GetItemNumber(s_iRow, "docket_year")
s_lDockNum = dw_scan.GetItemNumber(s_iRow, "docket_number")

dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Parties Involved Information"

SELECT COUNT(*) INTO :s_iItemNum
	FROM sh_docket_name
	WHERE sh_docket_name.docket_year = :s_iDockYear
	AND sh_docket_name.docket_number = :s_lDockNum;	
If s_iItemNum = 0 Then
	// Not found, Okay to insert Docket Parties Involved Information
	// Security - Add Docket Parties Involved Information
	If w_main.dw_perms.Find("code=22", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True			
		m_main.m_general.m_add.enabled = True
	End If

	dw_detail.DataObject = "dw_docket_parties_involved_detail"
	dw_detail.SetTransObject(SQLCA)
	
	// Security - Add Docket Parties Involved Information
	If w_main.dw_perms.Find("code=22", 1, w_main.dw_perms.RowCount()) > 0 Then
		m_main.m_general.m_add.TriggerEvent("clicked")
	End If	

	// get Involvement Type
	dw_detail.GetChild("involvement", dwc)
	dwc.SetTransObject(SQLCA)
	dwc.Reset()
	dwc.Retrieve("INV")

Else   // Found, Retrieve Docket Parties Involved Information
		
	// Security - Add Docket Parties Involved Information
	If w_main.dw_perms.Find("code=22", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_add.enabled = True			
		m_main.m_general.m_add.enabled = True
	End If
	
	// Security - Update Docket Parties Involved Information
	If w_main.dw_perms.Find("code=23", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_update.enabled = True			
		m_main.m_general.m_update.enabled = True
	End If
	
	// Security - Delete Docket Parties Involved Information
	If w_main.dw_perms.Find("code=24", 1, w_main.dw_perms.RowCount()) > 0 Then
		cb_delete.enabled = True
		m_main.m_general.m_delete.enabled = True
	End If

	cb_save.enabled = False
	m_main.m_general.m_save.enabled = False

	dw_detail.DataObject = "dw_docket_parties_involved_detail"		
	dw_detail.SetTransObject(SQLCA)
	dw_detail.Tag = "Docket Parties Involved Information"		

	// get Involvement Type
	dw_detail.GetChild("involvement", dwc)
	dwc.SetTransObject(SQLCA)
	dwc.Reset()
	dwc.Retrieve("INV")

	dw_detail.Retrieve(s_iDockYear, s_lDockNum)		

	If i_achMode = "Continue" And i_bNew = True Then
		// Security - Add Docket Parties Involved
		If w_main.dw_perms.Find("code=22", 1, w_main.dw_perms.RowCount()) > 0 Then
			m_main.m_general.m_update.TriggerEvent("clicked")
		End If
	End If
		
End If
			
dw_detail.SetFocus()			

end event

type cb_main from commandbutton within w_docket_sheet
integer x = 3163
integer y = 736
integer width = 448
integer height = 68
integer taborder = 220
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
string s_achCaseNum
integer s_iDockYear, s_iRow
long s_lCount, s_lDockNum, s_lCount2, s_lCount3

dw_scan.enabled = True

st_message.text = ""

cb_main.enabled = False
cb_name.enabled = True
cb_memo.enabled = True
cb_served.enabled = True
cb_fees.enabled = True
cb_billable.enabled = True
			
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

s_iDockYear = dw_scan.GetItemNumber(s_iRow, "docket_year")
s_lDockNum = dw_scan.GetItemNumber(s_iRow, "docket_number")

//dw_detail.VScrollBar = True

dw_detail.SetTransObject(SQLCA)
dw_detail.Tag = "Docket Information"

/*
// Memo
SELECT Count(*) INTO :s_lCount
	FROM sh_docket_note
	WHERE sh_docket_note.docket_year = :s_iDockYear
	AND sh_docket_note.docket_number = :s_lDockNum;
If s_lCount > 0 Then
	st_memo.visible = True
Else
	st_memo.visible = False
End If

// Served
SELECT Count(*) INTO :s_lCount2
	FROM sh_docket_serve
	WHERE sh_docket_serve.docket_year = :s_iDockYear
	AND sh_docket_serve.docket_number = :s_lDockNum
	AND sh_docket_serve.type_served <> 'D';
If s_lCount2 > 0 Then
	st_served.visible = True
Else
	st_served.visible = False
End If

// Diligent Search
SELECT Count(*) INTO :s_lCount3
	FROM sh_docket_serve
	WHERE sh_docket_serve.docket_year = :s_iDockYear
	AND sh_docket_serve.docket_number = :s_lDockNum
	AND sh_docket_serve.type_served = 'D';				

If s_lCount3 > 0 Then
	st_diligent.visible = True
Else
	st_diligent.visible = False
End If		
*/

DECLARE docket_csr CURSOR FOR
	SELECT sh_docket.case_number
	FROM sh_docket
	WHERE sh_docket.docket_year = :s_iDockYear
	AND sh_docket.docket_number = :s_lDockNum;
OPEN docket_csr;

FETCH docket_csr INTO :s_achCaseNum;
Choose Case SQLCA.SQLCODE
	Case 100 // Not found, Okay to insert Docket Information
		// Security - Add Docket Information
		If w_main.dw_perms.Find("code=18", 1, w_main.dw_perms.RowCount()) > 0 Then
			cb_add.enabled = True			
			m_main.m_general.m_add.enabled = True
		End If

		dw_detail.DataObject = "dw_docket_detail"
		dw_detail.SetTransObject(SQLCA)

		// Security - Add Docket Information
		If w_main.dw_perms.Find("code=18", 1, w_main.dw_perms.RowCount()) > 0 Then
			m_main.m_general.m_add.TriggerEvent("clicked")
		End If	
		
	Case 0   // Found, Retrieve Docket Information
		
	
		// Security - Update Docket Information
		If w_main.dw_perms.Find("code=19", 1, w_main.dw_perms.RowCount()) > 0 Then
			cb_update.enabled = True			
			m_main.m_general.m_update.enabled = True
		End If
		
		// Security - Delete Docket Information
		If w_main.dw_perms.Find("code=20", 1, w_main.dw_perms.RowCount()) > 0 Then
			cb_delete.enabled = True
			m_main.m_general.m_delete.enabled = True
		End If

		cb_save.enabled = False
		m_main.m_general.m_save.enabled = False

		dw_detail.DataObject = "dw_docket_detail"			
		dw_detail.SetTransObject(SQLCA)
		dw_detail.Tag = "Docket Information"		

		dw_detail.Retrieve(s_iDockYear, s_lDockNum)		
		
	Case -1  // Serious problems
		MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)

End Choose
			
CLOSE docket_csr;			 	
dw_scan.SetFocus()			

end event

type gb_9 from groupbox within w_docket_sheet
integer x = 3136
integer y = 1548
integer width = 498
integer height = 284
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_8 from groupbox within w_docket_sheet
integer x = 3136
integer y = 1052
integer width = 498
integer height = 220
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_6 from groupbox within w_docket_sheet
integer x = 3136
integer y = 684
integer width = 498
integer height = 364
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_return from commandbutton within w_docket_sheet
integer x = 3163
integer y = 1668
integer width = 448
integer height = 68
integer taborder = 320
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Return Service"
end type

event clicked;integer s_irow, s_iDockYear
long s_lDockNum
string s_achparty, s_achInvolve
string s_achplaintiffs, s_achdefendants
string s_ach3rdPlaintiffs, s_ach3rdDefendants
long s_lNameRows, s_iCount

datastore lds_ReturnName

s_irow = dw_scan.GetRow()

s_iDockYear = dw_scan.GetItemNumber(s_irow, "docket_year")
s_lDockNum = dw_scan.GetItemNumber(s_irow, "docket_number")

s_achplaintiffs = ""
s_achdefendants = ""
s_ach3rdPlaintiffs = ""
s_ach3rdDefendants = ""

// allocate the resources for the datastores
lds_ReturnName = Create DataStore

lds_ReturnName.DataObject = 'dw_return_service_parties_ds'
lds_ReturnName.SetTransObject(SQLCA)

// Retrieve Names on a document
s_lNameRows = lds_ReturnName.Retrieve(s_iDockYear, s_lDockNum, "P", "T", "D", "R", "L", "E")
For s_iCount = 1 To s_lNameRows
	
	s_achParty = Trim(lds_ReturnName.GetItemString(s_iCount,"complete_name"))				
	s_achInvolve = Trim(lds_ReturnName.GetItemString(s_iCount,"involvement"))								

	If (s_achInvolve = "P" OR s_achInvolve = "T" ) Then
		If Len(s_achplaintiffs) = 0 Then		
			s_achplaintiffs = s_achParty 
		Else
			s_achplaintiffs = s_achplaintiffs + ", " + s_achParty		
		End If
	End If

	If (s_achInvolve = "D" OR s_achInvolve = "R" ) Then
		If Len(s_achdefendants) = 0 Then		
			s_achdefendants = s_achParty 
		Else
			s_achdefendants = s_achdefendants + ", " + s_achParty		
		End If
	End If	
	
	If (s_achInvolve = "L") Then
		If Len(s_ach3rdPlaintiffs) = 0 Then		
			s_ach3rdPlaintiffs = s_achParty 
		Else
			s_ach3rdPlaintiffs = s_ach3rdPlaintiffs + ", " + s_achParty		
		End If
	End If

	If (s_achInvolve = "E") Then
		If Len(s_ach3rdDefendants) = 0 Then		
			s_ach3rdDefendants = s_achParty 
		Else
			s_ach3rdDefendants = s_ach3rdDefendants + ", " + s_achParty		
		End If
	End If		
Next

// Retrieve Information
dw_return_service.SetTransObject(SQLCA)
dw_return_service.Reset()
dw_return_service.Retrieve(s_iDockYear, s_lDockNum, s_achplaintiffs, s_achdefendants, s_ach3rdPlaintiffs, s_ach3rdDefendants)	

// Printer Setup and Printout depending on current detail window
OpenWithParm(w_datawindow_print_dialog,dw_return_service)

Destroy lds_ReturnName


end event

type dw_return_service from datawindow within w_docket_sheet
boolean visible = false
integer x = 78
integer y = 740
integer width = 1362
integer height = 364
boolean bringtotop = true
string dataobject = "dw_return_service_rpt"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_serv_slip from commandbutton within w_docket_sheet
integer x = 3163
integer y = 1596
integer width = 448
integer height = 68
integer taborder = 310
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Service Slip"
end type

event clicked;integer s_irow, s_iDockYear
long s_lDockNum
string s_achPrintName

s_irow = dw_scan.GetRow()

s_iDockYear = dw_scan.GetItemNumber(s_irow, "docket_year")
s_lDockNum = dw_scan.GetItemNumber(s_irow, "docket_number")
s_achPrintName = "Y"

// Retrieve Information
dw_serv_slip.SetTransObject(SQLCA)
dw_serv_slip.Reset()
dw_serv_slip.Retrieve(s_iDockYear, s_lDockNum, s_achPrintName)	

// Printer Setup and Printout depending on current detail window
OpenWithParm(w_datawindow_print_dialog,dw_serv_slip)




end event

type dw_serv_slip from datawindow within w_docket_sheet
boolean visible = false
integer x = 78
integer y = 1116
integer width = 1362
integer height = 368
boolean bringtotop = true
string dataobject = "dw_service_slip_rpt"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_dock_year from singlelineedit within w_docket_sheet
integer x = 1819
integer y = 96
integer width = 251
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

type sle_dock_num from singlelineedit within w_docket_sheet
integer x = 2473
integer y = 96
integer width = 306
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_7 from statictext within w_docket_sheet
integer x = 1399
integer y = 108
integer width = 407
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Docket Year:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_8 from statictext within w_docket_sheet
integer x = 2080
integer y = 108
integer width = 375
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Docket Num:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_bill_letter from commandbutton within w_docket_sheet
integer x = 3163
integer y = 1740
integer width = 448
integer height = 68
integer taborder = 330
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Billing Letter"
end type

event clicked;integer s_irow, s_iDockYear
long s_lDockNum
string s_achparty, s_achInvolve
string s_achplaintiffs, s_achdefendants
string s_ach3rdPlaintiffs, s_ach3rdDefendants
long s_lNameRows, s_iCount

datastore lds_ReturnName

s_irow = dw_scan.GetRow()

s_iDockYear = dw_scan.GetItemNumber(s_irow, "docket_year")
s_lDockNum = dw_scan.GetItemNumber(s_irow, "docket_number")

s_achplaintiffs = ""
s_achdefendants = ""
s_ach3rdPlaintiffs = ""
s_ach3rdDefendants = ""

// allocate the resources for the datastores
lds_ReturnName = Create DataStore

lds_ReturnName.DataObject = 'dw_return_service_parties_ds'
lds_ReturnName.SetTransObject(SQLCA)

// Retrieve Names on a document
s_lNameRows = lds_ReturnName.Retrieve(s_iDockYear, s_lDockNum, "P", "T", "D", "R", "L", "E")
For s_iCount = 1 To s_lNameRows
	
	s_achParty = Trim(lds_ReturnName.GetItemString(s_iCount,"complete_name"))				
	s_achInvolve = Trim(lds_ReturnName.GetItemString(s_iCount,"involvement"))								

	If (s_achInvolve = "P" OR s_achInvolve = "T" ) Then
		If Len(s_achplaintiffs) = 0 Then		
			s_achplaintiffs = s_achParty 
		Else
			s_achplaintiffs = s_achplaintiffs + ", " + s_achParty		
		End If
	End If

	If (s_achInvolve = "D" OR s_achInvolve = "R" ) Then
		If Len(s_achdefendants) = 0 Then		
			s_achdefendants = s_achParty 
		Else
			s_achdefendants = s_achdefendants + ", " + s_achParty		
		End If
	End If	
	
	If (s_achInvolve = "L") Then
		If Len(s_ach3rdPlaintiffs) = 0 Then		
			s_ach3rdPlaintiffs = s_achParty 
		Else
			s_ach3rdPlaintiffs = s_ach3rdPlaintiffs + ", " + s_achParty		
		End If
	End If

	If (s_achInvolve = "E") Then
		If Len(s_ach3rdDefendants) = 0 Then		
			s_ach3rdDefendants = s_achParty 
		Else
			s_ach3rdDefendants = s_ach3rdDefendants + ", " + s_achParty		
		End If
	End If		
Next

// Retrieve Information
dw_bill_letter.SetTransObject(SQLCA)
dw_bill_letter.Reset()
dw_bill_letter.Retrieve(s_iDockYear, s_lDockNum, s_achplaintiffs, s_achdefendants, s_ach3rdPlaintiffs, s_ach3rdDefendants)	

// Printer Setup and Printout depending on current detail window
OpenWithParm(w_datawindow_print_dialog,dw_bill_letter)

Destroy lds_ReturnName


end event

type dw_bill_letter from datawindow within w_docket_sheet
boolean visible = false
integer x = 78
integer y = 1492
integer width = 1362
integer height = 368
boolean bringtotop = true
string dataobject = "dw_billing_letter_rpt"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_rec_date from editmask within w_docket_sheet
integer x = 2674
integer y = 12
integer width = 421
integer height = 84
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

type st_9 from statictext within w_docket_sheet
integer x = 2354
integer y = 20
integer width = 311
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Rec. Date:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_receipt from commandbutton within w_docket_sheet
integer x = 3163
integer y = 1388
integer width = 448
integer height = 68
integer taborder = 290
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Receipt"
end type

event clicked;st_receiptparms s_stparms

i_irow = dw_scan.GetRow()
If i_irow = 0 Then

	s_stparms.achCBType = "D"	
	s_stparms.iDockYear = 0
	s_stparms.lDockNum = 0
	
Else
	
	s_stparms.achCBType = "D"	
	s_stparms.iDockYear = dw_scan.GetItemNumber(i_irow,"docket_year")
	s_stparms.lDockNum = dw_scan.GetItemNumber(i_irow,"docket_number")
//	s_stparms.dtRecDate = Date(dw_scan.GetItemDateTime(i_irow,"date_received"))
//	s_stparms.dTotRcvd = dw_scan.GetItemNumber(i_irow,"total_received")
	
End If

s_stparms.achOpType = i_achOpType

// if no fees, don't open receipts

OpenSheetWithParm(w_docket_receipt_sheet,s_stparms,w_main, 0, Layered!)


end event

type cb_disbursement from commandbutton within w_docket_sheet
integer x = 3163
integer y = 1460
integer width = 448
integer height = 68
integer taborder = 300
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Disbursement"
end type

event clicked;st_disburseparms s_stparms

i_irow = dw_scan.GetRow()
If i_irow = 0 Then

	s_stparms.achCBType = "D"	
	s_stparms.iDockYear = 0
	s_stparms.lDockNum = 0
	
Else
	
	s_stparms.achCBType = "D"	
	s_stparms.iDockYear = dw_scan.GetItemNumber(i_irow,"docket_year")
	s_stparms.lDockNum = dw_scan.GetItemNumber(i_irow,"docket_number")

End If

OpenSheetWithParm(w_docket_disbursement_sheet,s_stparms,w_main, 0, Layered!)


end event

type gb_7 from groupbox within w_docket_sheet
integer x = 3136
integer y = 1260
integer width = 498
integer height = 284
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_balance_due from commandbutton within w_docket_sheet
integer x = 3163
integer y = 1312
integer width = 448
integer height = 68
integer taborder = 280
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Balance Due"
end type

event clicked;integer s_irow, s_iDockYear
long s_lDockNum
string s_achCBType
decimal{2} s_dBalanceDue, s_dFeeAmount, s_dBalanceTotal

s_irow = dw_scan.GetRow()

s_iDockYear = dw_scan.GetItemNumber(s_irow, "docket_year")
s_lDockNum = dw_scan.GetItemNumber(s_irow, "docket_number")
s_achCBType = "D"
/*
SELECT sum(balance_due) 
	INTO :s_dBalanceDue
	FROM sh_docket_fee
	WHERE	cb_type = :s_achCBType
		AND docket_year = :s_iDockYear
		AND docket_number = :s_lDockNum
		AND fee_type <> 'OP';
*/
SELECT sum(balance_due) 
	INTO :s_dBalanceDue
	FROM sh_docket_fee
	WHERE	cb_type = :s_achCBType
		AND docket_year = :s_iDockYear
		AND docket_number = :s_lDockNum;		
If IsNull(s_dBalanceDue) Then s_dBalanceDue = 0 
/*
SELECT sum(fee_amount) 
	INTO :s_dFeeAmount
	FROM sh_docket_fee
	WHERE	cb_type = :s_achCBType
		AND docket_year = :s_iDockYear
		AND docket_number = :s_lDockNum
		AND fee_type = 'OP';
If IsNull(s_dFeeAmount) Then s_dFeeAmount = 0 	
*/
//s_dBalanceTotal = s_dBalanceDue - s_dFeeAmount

s_dBalanceTotal = s_dBalanceDue		
		
MessageBox("Balance Due This Docket", string(s_dBalanceTotal, "$#,###,##0.00"))
end event

type st_served from statictext within w_docket_sheet
boolean visible = false
integer x = 2542
integer y = 668
integer width = 265
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 16711680
boolean enabled = false
string text = "Served"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_diligent from statictext within w_docket_sheet
boolean visible = false
integer x = 2263
integer y = 668
integer width = 265
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 0
boolean enabled = false
string text = "Diligent"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_message from statictext within w_docket_sheet
integer x = 27
integer y = 576
integer width = 3072
integer height = 76
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

type st_receipt from statictext within w_docket_sheet
boolean visible = false
integer x = 1984
integer y = 668
integer width = 265
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 32768
boolean enabled = false
string text = "Receipt"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

