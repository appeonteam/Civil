$PBExportHeader$w_cancel_warrants.srw
forward
global type w_cancel_warrants from Window
end type
type st_warrant from statictext within w_cancel_warrants
end type
type st_4 from statictext within w_cancel_warrants
end type
type em_date from editmask within w_cancel_warrants
end type
type em_warrant from editmask within w_cancel_warrants
end type
type st_3 from statictext within w_cancel_warrants
end type
type cb_cancel from commandbutton within w_cancel_warrants
end type
type cb_ok from commandbutton within w_cancel_warrants
end type
type gb_1 from groupbox within w_cancel_warrants
end type
end forward

global type w_cancel_warrants from Window
int X=848
int Y=301
int Width=2044
int Height=640
boolean TitleBar=true
string Title="Clear Checks"
long BackColor=12632256
st_warrant st_warrant
st_4 st_4
em_date em_date
em_warrant em_warrant
st_3 st_3
cb_cancel cb_cancel
cb_ok cb_ok
gb_1 gb_1
end type
global w_cancel_warrants w_cancel_warrants

type variables
integer i_iPeriodNum, i_iPeriodYear
date i_dtWarrant

end variables

event open;date s_dtClearDate
integer s_iYear, s_iMonth

SetPointer(HourGlass!)

w_main.enabled = False

s_iYear = Year(g_dtToday)
s_iMonth = Month(g_dtToday)

s_dtClearDate = Date(s_iYear, s_iMonth, 1)
s_dtClearDate = RelativeDate(s_dtClearDate, -1)

em_date.text = String(s_dtClearDate, "mm/dd/yyyy")
em_warrant.SetFocus()

// Window Controls
cb_cancel.pointer="arrow!"
cb_ok.pointer="arrow!"
gb_1.pointer="arrow!"


end event

on w_cancel_warrants.create
this.st_warrant=create st_warrant
this.st_4=create st_4
this.em_date=create em_date
this.em_warrant=create em_warrant
this.st_3=create st_3
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.gb_1=create gb_1
this.Control[]={this.st_warrant,&
this.st_4,&
this.em_date,&
this.em_warrant,&
this.st_3,&
this.cb_cancel,&
this.cb_ok,&
this.gb_1}
end on

on w_cancel_warrants.destroy
destroy(this.st_warrant)
destroy(this.st_4)
destroy(this.em_date)
destroy(this.em_warrant)
destroy(this.st_3)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.gb_1)
end on

event close;w_main.enabled = True
w_main.SetFocus()
Close(This)

end event

type st_warrant from statictext within w_cancel_warrants
int X=33
int Y=384
int Width=1953
int Height=99
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=8388608
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_cancel_warrants
int X=362
int Y=208
int Width=497
int Height=74
boolean Enabled=false
string Text="Clear Date:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_date from editmask within w_cancel_warrants
int X=874
int Y=195
int Width=402
int Height=90
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
string Mask="mm/dd/yyyy"
MaskDataType MaskDataType=DateMask!
boolean Spin=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_warrant from editmask within w_cancel_warrants
int X=874
int Y=80
int Width=344
int Height=90
int TabOrder=10
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="######"
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_cancel_warrants
int X=73
int Y=93
int Width=786
int Height=74
boolean Enabled=false
string Text="Check Number To Cancel:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_cancel_warrants
int X=1584
int Y=160
int Width=406
int Height=109
int TabOrder=40
string Text="&Cancel"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;SetPointer(HourGlass!)

w_main.enabled = True
w_main.SetFocus()
Close(Parent)
end on

type cb_ok from commandbutton within w_cancel_warrants
int X=1584
int Y=38
int Width=406
int Height=109
int TabOrder=30
string Text="&OK"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// script variables
integer s_iFY, s_iPeriodNum, s_iPeriodYear, s_iThisYear, s_iCount, s_iTrailNum, s_iCount2
integer s_iCount3
long s_lTransMax, s_lClaimItemRows, s_lRowCount
string s_achWarrant, s_achWarrantYear, s_achWarrantMonth, s_achWarrantDay
integer s_iWarrantYear, s_iWarrantMonth, s_iWarrantDay, s_iPerCount, s_iAcctCount
date s_dtWarrant, s_dtToday, s_dtPeriodDate, s_dtPostDate
string s_achOrigPost, s_achFundNum, s_achActNum, s_achDeptNum
string s_achObjNum, s_achProjNum, s_achSrcNum, s_achClaimNum, s_achError, s_achDoc
string s_achWriteWarr, s_achClearWarr
decimal {2} s_dAmount, s_dWarrTot
long s_lLineNum, s_lWarrNum, s_iCBDisYear, s_lCBDisNum
string s_achCBType
datastore lds_ClaimItem

SetPointer(HourGlass!)

// get claim item records
// allocate the resources for the datastores
lds_ClaimItem = Create DataStore
	
lds_ClaimItem.DataObject = 'dw_sh_docket_disbursement_cancel_ds'
lds_ClaimItem.SetTransObject(SQLCA)

s_iPeriodNum = Month(Today())
s_iPeriodYear = Year(Today())
/*
DELETE FROM cancel_warrant_errors;
// error check
If SQLCA.SQLCode = -1 Then
	MessageBox("System Error","Cancel Warrant Delete Error - " + SQLCA.SQLErrText)
	ROLLBACK;
	Return -1
End If							
*/
// Error report line counter
s_lLineNum = 1

If em_warrant.text = "" OR IsNull(em_warrant.text) Then
	MessageBox("Error", "Warrant number must be entered.")
	em_warrant.SetFocus()
	Return
End If
s_lWarrNum = Long(em_warrant.text)

If em_date.text = "" OR IsNull(em_date.text) Then
	MessageBox("Error", "Warrant date must be entered.")
	em_date.SetFocus()
	Return
End If
s_achWarrant = String(em_date.text)
s_achWarrantYear = Mid(s_achWarrant,7,4)
s_achWarrantMonth = Mid(s_achWarrant,1,2)
s_achWarrantDay = Mid(s_achWarrant,4,2)
s_iWarrantYear = Integer(s_achWarrantYear)
s_iWarrantMonth = Integer(s_achWarrantMonth)
s_iWarrantDay = Integer(s_achWarrantDay)
s_dtWarrant = Date(s_iWarrantYear, s_iWarrantMonth, s_iWarrantDay)
i_dtWarrant = s_dtWarrant

// Get period month and year from cancel date
s_iPeriodYear = Year(s_dtWarrant)
s_iPeriodNum = Month(s_dtWarrant)

	
// Make sure there is a valid warrant specified
SELECT COUNT(*) INTO :s_iCount
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.check_number = :s_lWarrNum;
If s_iCount = 0 Then
	MessageBox("Warranted Claim Error", &
		"Warrant specified is not valid -- re-enter warrant number!",StopSign!)
	em_warrant.SetFocus()
	Return
End If	

// Make sure warrant is not already cancelled
SELECT COUNT(*) INTO :s_iCount2
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.check_number = :s_lWarrNum
	AND sh_docket_disbursement.clear_date IS NOT NULL;		

If s_iCount2 > 0 Then 	
	MessageBox("Warranted Claim Error", &
		"Warrant " + String(s_lWarrNum) + " is already canceled!", StopSign!)
	em_warrant.SetFocus()
	Return
End If	
/*
// Make sure warrant is not voided
SELECT COUNT(*) INTO :s_iCount3
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.check_number = :s_lWarrNum
	AND sh_docket_disbursement.void_date IS NOT NULL;		

If s_iCount3 > 0 Then 	
	MessageBox("Warranted Claim Error", &
		"Warrant " + String(s_lWarrNum) + " has been voided!", StopSign!)
	em_warrant.SetFocus()
	Return
End If	

*/
// Warranted claim item specified
DECLARE warr_num_csr CURSOR FOR
	SELECT check_number
		FROM sh_docket_disbursement
		WHERE sh_docket_disbursement.check_number = :s_lWarrNum
		AND sh_docket_disbursement.clear_date IS NOT NULL;		
OPEN warr_num_csr;
If SQLCA.SQLCode = -1 Then
	MessageBox("Cursor Open Error", "warrant number - " + SQLCA.SQLErrText)
	Return
End If
FETCH warr_num_csr INTO :s_lWarrNum;
// check if fetch failed
If SQLCA.SQLCode = -1 Then
	MessageBox("System Error", SQLCA.SQLErrText)
	Return
Else
	// Row Found
	If SQLCA.SQLCODE = 0 Then 	
		MessageBox("Warranted Claim Error2", &
			"Warrant " + String(s_lWarrNum) + " is already canceled!", StopSign!)
		em_warrant.SetFocus()
		Return
	End If		
	CLOSE warr_num_csr;
End If

SELECT amount_paid INTO :s_dWarrTot
	FROM sh_docket_disbursement
	WHERE sh_docket_disbursement.check_number = :s_lWarrNum;
If SQLCA.SQLCODE = -1 Then
	MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
   Return
Else
	If IsNull(s_dWarrTot) Then s_dWarrTot = 0
End If	

st_warrant.text = "WARRANT " + String(s_lWarrNum) + " DATE " + String(s_dtWarrant, "mm/dd/yyyy") + " AMOUNT " + String(s_dWarrTot)

If 1 = MessageBox("Clear Check","CLEAR this check?", Question!, YesNo!, 1) Then

	SELECT cbdis_year, cbdis_number, cb_type
	 	INTO :s_iCBDisYear, :s_lCBDisNum, :s_achCBType
		FROM sh_docket_disbursement
		WHERE check_number = :s_lWarrNum;

	UPDATE sh_docket_disbursement
		SET reconcile = 'Y',
			 clear_date = :s_dtWarrant,
			 disburse_status = 'C'
		WHERE cb_type = :s_achCBtype
		AND cbdis_year = :s_iCBDisYear
		AND cbdis_number = :s_lCBDisNum;
	If SQLCA.SQLCODE = -1 Then
		MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
		ROLLBACK;
		Return
	Else
		COMMIT;
	End If			

	// Credit Ut_Ledger - "-"
	UPDATE ut_ledger_item
			SET ut_ledger_item.period_bal = ut_ledger_item.period_bal - :s_dWarrTot
		WHERE ut_ledger_item.dock_year = :s_iPeriodYear
		AND ut_ledger_item.period = :s_iPeriodNum;								
	If SQLCA.SQLCODE = -1 Then
		MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
		ROLLBACK;
		Return
	Else
		COMMIT;
	End If					
End If
st_warrant.text = ""
em_warrant.text = ""
em_date.text = String(i_dtWarrant, "mm/dd/yyyy")
em_warrant.SetFocus()


end event

type gb_1 from groupbox within w_cancel_warrants
int X=33
int Y=6
int Width=1346
int Height=326
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

