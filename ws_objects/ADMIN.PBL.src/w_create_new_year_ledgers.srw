$PBExportHeader$w_create_new_year_ledgers.srw
forward
global type w_create_new_year_ledgers from Window
end type
type st_1 from statictext within w_create_new_year_ledgers
end type
type em_year from editmask within w_create_new_year_ledgers
end type
type st_3 from statictext within w_create_new_year_ledgers
end type
type cb_cancel from commandbutton within w_create_new_year_ledgers
end type
type cb_ok from commandbutton within w_create_new_year_ledgers
end type
type gb_2 from groupbox within w_create_new_year_ledgers
end type
type gb_1 from groupbox within w_create_new_year_ledgers
end type
end forward

global type w_create_new_year_ledgers from Window
int X=955
int Y=925
int Width=1843
int Height=621
boolean TitleBar=true
string Title="Create New Year Ledgers"
long BackColor=12632256
st_1 st_1
em_year em_year
st_3 st_3
cb_cancel cb_cancel
cb_ok cb_ok
gb_2 gb_2
gb_1 gb_1
end type
global w_create_new_year_ledgers w_create_new_year_ledgers

type variables
w_timer_bar w_timer
end variables

event open;SetPointer(HourGlass!)

w_main.enabled = False

em_year.SetFocus()

// Window Controls
cb_cancel.pointer="arrow!"
cb_ok.pointer="arrow!"
gb_1.pointer="arrow!"
gb_2.pointer="arrow!"
end event

on w_create_new_year_ledgers.create
this.st_1=create st_1
this.em_year=create em_year
this.st_3=create st_3
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.st_1,&
this.em_year,&
this.st_3,&
this.cb_cancel,&
this.cb_ok,&
this.gb_2,&
this.gb_1}
end on

on w_create_new_year_ledgers.destroy
destroy(this.st_1)
destroy(this.em_year)
destroy(this.st_3)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type st_1 from statictext within w_create_new_year_ledgers
int X=73
int Y=378
int Width=1211
int Height=86
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=8388608
int TextSize=-10
int Weight=400
string FaceName="Arial"
boolean Italic=true
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_year from editmask within w_create_new_year_ledgers
int X=929
int Y=144
int Width=285
int Height=90
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_create_new_year_ledgers
int X=139
int Y=157
int Width=779
int Height=74
boolean Enabled=false
string Text="Ledger Year To Be Created:"
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

type cb_cancel from commandbutton within w_create_new_year_ledgers
int X=1353
int Y=192
int Width=406
int Height=109
int TabOrder=30
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

type cb_ok from commandbutton within w_create_new_year_ledgers
int X=1353
int Y=70
int Width=406
int Height=109
int TabOrder=20
string Text="&OK"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// script variables
integer s_iDockYear, s_iLastDockYear, s_iCount
long s_lLedgerRows, s_lRowCount, s_lRow, s_lItemRow, s_lItemRowCount
string s_achAcctType
decimal {2} s_dBegBalance

datastore lds_OldLedger, lds_Ledger, lds_LedgerItem

SetPointer(HourGlass!)

If em_year.text = "" OR Len(em_year.text) < 4 Then
	MessageBox("Error", "Fiscal year must be four digits.")
	em_year.SetFocus()
	Return
End If

s_iDockYear = Integer(em_year.text)

SELECT COUNT(*) INTO :s_iCount
	FROM ut_ledger
	WHERE ut_ledger.dock_year = :s_iDockYear;
If s_iCount > 0 Then
	MessageBox("Create New Year Ledgers Information", &
		"Ledgers have already been created for this year -- CANNOT Process Twice!!",StopSign!)
	em_year.SetFocus()
	Return
End If

s_iLastDockYear = s_iDockYear - 1

// get ledger records
// allocate the resources for the datastores
lds_OldLedger = Create DataStore
	
lds_OldLedger.DataObject = 'dw_prior_year_ledgers_ds'
lds_OldLedger.SetTransObject(SQLCA)

// get ledger records
// allocate the resources for the datastores
lds_Ledger = Create DataStore
	
lds_Ledger.DataObject = 'dw_create_new_year_ledgers_ds'
lds_Ledger.SetTransObject(SQLCA)
		
// get ledger item records
// allocate the resources for the datastores
lds_LedgerItem = Create DataStore	
	
lds_LedgerItem.DataObject = 'dw_create_new_year_ledger_items_ds'
lds_LedgerItem.SetTransObject(SQLCA)

s_lLedgerRows = lds_OldLedger.Retrieve(s_iLastDockYear)

For s_lRowCount = 1 To s_lLedgerRows

	s_dBegBalance = 0

	st_1.text = "Ledger: " + String(s_lRowCount) + " of " + String(s_lLedgerRows) + " " + s_achAcctType
	
	// Create new ALE ledger record
	s_lRow = lds_Ledger.InsertRow(0)
	lds_Ledger.SetItem(s_lRow,"dock_year", s_iDockYear)
	lds_Ledger.SetItem(s_lRow,"period1", 0)			
	lds_Ledger.SetItem(s_lRow,"period2", 0)				
	lds_Ledger.SetItem(s_lRow,"period3", 0)			
	lds_Ledger.SetItem(s_lRow,"period4", 0)			
	lds_Ledger.SetItem(s_lRow,"period5", 0)				
	lds_Ledger.SetItem(s_lRow,"period6", 0)				
	lds_Ledger.SetItem(s_lRow,"period7", 0)				
	lds_Ledger.SetItem(s_lRow,"period8", 0)				
	lds_Ledger.SetItem(s_lRow,"period9", 0)				
	lds_Ledger.SetItem(s_lRow,"period10", 0)			
	lds_Ledger.SetItem(s_lRow,"period11", 0)
	lds_Ledger.SetItem(s_lRow,"period12", 0)				
	lds_Ledger.SetItem(s_lRow,"beg_balance", s_dBegBalance)					
	
	For s_lItemRowCount = 1 To 12

		// Create new ALE ledger item record
		s_lItemRow = lds_LedgerItem.InsertRow(0)
		lds_LedgerItem.SetItem(s_lItemRow,"dock_year", s_iDockYear)
		lds_LedgerItem.SetItem(s_lItemRow,"period", s_lItemRowCount)						
		lds_LedgerItem.SetItem(s_lItemRow,"period_bal", 0)	
		
		lds_LedgerItem.Update()
		COMMIT;
		
	Next
Next

lds_Ledger.Update()
COMMIT;

w_main.enabled = True
w_main.SetFocus()
Close(Parent)
end event

type gb_2 from groupbox within w_create_new_year_ledgers
int X=51
int Y=554
int Width=1123
int Height=490
boolean Visible=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_create_new_year_ledgers
int X=73
int Y=32
int Width=1211
int Height=269
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

