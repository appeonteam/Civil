$PBExportHeader$w_main.srw
forward
global type w_main from Window
end type
type mdi_1 from mdiclient within w_main
end type
type dw_perms from datawindow within w_main
end type
end forward

global type w_main from Window
int X=4
int Y=3
int Width=9999
int Height=4000
boolean TitleBar=true
string Title="County Information System"
string MenuName="m_main"
long BackColor=16777215
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
dw_perms dw_perms
end type
global w_main w_main

type variables
w_timer_bar w_timer
end variables

event open;date s_dttoday
string s_achstart, s_achstartyear, s_achstartmonth, s_achstartday, s_achSystemType
integer s_istartyear, s_istartmonth, s_istartday, s_iVariance, h

datawindowchild dwc, dwc1

dw_perms.SetTransObject(SQLCA)
dw_perms.Reset()
dw_perms.Retrieve(g_achUserEmpNum)

integer nwidth, nheight

s_iVariance = 200

// workspace 4945, 4000 --Rod determined -- w_main
// nwidth = 3750, nheight = 2163 correct for 1024 x 768 large fonts...one monitor or more

nheight = w_main.workspaceheight()
nwidth = w_main.workspacewidth()

Integer  li_screenheight 
Integer  li_screenwidth 
Integer  li_rc 
Integer  li_x = 1 
Integer  li_y = 1 
environment lenv_obj 



// Get environment 
If GetEnvironment (lenv_obj) = -1 Then 
 Return -1 
End If 


// Determine current screen resolution and validate 
li_screenheight = PixelsToUnits (lenv_obj.screenheight, YPixelsToUnits!) 
li_screenwidth = PixelsToUnits (lenv_obj.screenwidth, XPixelsToUnits!) 
If Not (li_screenheight > 0) or Not (li_screenwidth > 0) Then 
 Return -1 
End If 

//messagebox("li_screenheight",li_screenheight)
//messagebox("li_screenwidth",li_screenwidth)
//messagebox("work space nwidth",nwidth)
//messagebox("work space nheight",nheight)	

// Dual Monitors
If w_main.workspacewidth() > 6500 Then
	// Monitor - 1024 X 768 - Normal Font
	If li_screenheight = 3072 and li_screenwidth = 4681 Then
		nwidth = 4699	
		nheight = 2796
	End If

	// Monitor - 1024 X 768 - Large Font
	If li_screenheight = 2458 and li_screenwidth = 3745 Then
		nwidth = 3760
		nheight = 2202
	End If	

	// Monitor - 1152 X 864 - Normal Font
	If li_screenheight = 3456 and li_screenwidth = 5266 Then
		nwidth = 5285	
		nheight = 3180
	End If

	// Monitor - 1152 X 864 - Large Font
	If li_screenheight = 2765 and li_screenwidth = 4213 Then
		nwidth = 4228
		nheight = 2509
	End If	

	// Monitor - 1280 X 768 - Normal Font
	If li_screenheight = 3072 and li_screenwidth = 5851 Then
		nwidth = 5870	
		nheight = 2796
	End If

	// Monitor - 1280 X 768 - Large Font
	If li_screenheight = 2458 and li_screenwidth = 4681 Then
		nwidth = 4696
		nheight = 2202
	End If		
	
	// Monitor - 1280 X 960 - Normal Font
	If li_screenheight = 3840 and li_screenwidth = 5851 Then
		nwidth = 5870	
		nheight = 3564
	End If

	// Monitor - 1280 X 960 - Large Font
	If li_screenheight = 3072 and li_screenwidth = 4681 Then
		nwidth = 4696
		nheight = 2816
	End If	

	// Monitor - 1280 X 1024 - Normal Font
	If li_screenheight = 4096 and li_screenwidth = 5851 Then
		nwidth = 5870	
		nheight = 3676
	End If

	// Monitor - 1280 X 1024 - Large Font
	If li_screenheight = 3277 and li_screenwidth = 4681 Then
		nwidth = 4696
		nheight = 3021
	End If	

End If

g_iheight = nheight
g_iwidth = nwidth

//	messagebox("work space w",nwidth)
//	messagebox("work space h",nheight)	
//nheight = 2100 //w_main.workspaceheight()
//nwidth = 3750 //w_main.workspacewidth()
//nwidth = nwidth + 225 // 170
//nheight = nheight + 500 // 150

mdi_1.move(0,90) //120,  new 130
mdi_1.Resize(nwidth, nheight)

w_main.Resize(nwidth, nheight)

s_dttoday = Today()

s_achStart = String(s_dttoday, "mm/dd/yyyy")
s_achStartYear = Mid(s_achStart,7,4)
s_achStartMonth = Mid(s_achStart,1,2)
s_achStartDay = Mid(s_achStart,4,2)
s_iStartYear = Integer(s_achStartYear)
s_iStartMonth = Integer(s_achStartMonth)
s_iStartDay = Integer(s_achStartDay)
g_dttoday = Date(s_iStartYear, s_iStartMonth, s_iStartDay)
g_iCurrYear = Year(Today())

If ( DayNumber(g_dttoday) >=2 and DayNumber(g_dttoday) <= 6 ) &
	and ( Month(g_dttoday) < Month(RelativeDate(g_dttoday, 1)) ) Then
	MessageBox("End of Month Reminder", "POST Receipts at 2 PM and then WRITE checks to County and State", StopSign!)
ElseIf ( DayNumber(g_dttoday) = 6 ) &
	and ( Month(g_dttoday) < Month(RelativeDate(g_dttoday, 2)) ) Then
	MessageBox("End of Month Reminder", "POST Receipts at 2 PM and then WRITE checks to County and State", StopSign!)
ElseIf ( DayNumber(g_dttoday) = 6 ) &
	and ( Month(g_dttoday) < Month(RelativeDate(g_dttoday, 3)) ) Then
	MessageBox("End of Month Reminder", "POST Receipts at 2 PM and then WRITE checks to County and State", StopSign!)
End If

m_main.m_file.m_exit.Visible = True
w_main.Title = "Cerro Gordo County Civil System Program"
//+ Space(45) + string(today(),'mm/dd/yyyy')

// File Submenu
// Maintain Fixes
If dw_perms.Find("code=70", 1, dw_perms.RowCount()) > 0 Then
	m_main.m_file.visible = True
	m_main.m_file.m_fixes.visible = True
	m_main.m_file.m_fixes.enabled = True
End If

// Administration Submenu
// Maintain Personnel Information / Serving Personnel Information
If dw_perms.Find("code=1", 1, dw_perms.RowCount()) > 0 Then
	m_main.m_administration.visible = True
	m_main.m_administration.m_personnel.visible = True	
	m_main.m_administration.m_personnel.enabled = True
End If

// Maintain Serving Personnel Information
If dw_perms.Find("code=71", 1, dw_perms.RowCount()) > 0 Then
	m_main.m_administration.visible = True
	m_main.m_administration.m_servingpersonnel.visible = True	
	m_main.m_administration.m_servingpersonnel.enabled = True
End If

// Maintain General Codes
If dw_perms.Find("code=13", 1, dw_perms.RowCount()) > 0 Then
	m_main.m_administration.visible = True
	m_main.m_administration.m_generalcodes.visible = True
	m_main.m_administration.m_generalcodes.enabled = True
End If

// Maintain Cash Book Ledgers
If dw_perms.Find("code=57", 1, dw_perms.RowCount()) > 0 Then
	m_main.m_administration.visible = True
	m_main.m_administration.m_cashbookledgers.visible = True
	m_main.m_administration.m_cashbookledgers.enabled = True
End If

// Maintain Corrective Entries
If dw_perms.Find("code=61", 1, dw_perms.RowCount()) > 0 Then
	m_main.m_administration.visible = True
	m_main.m_administration.m_postdepositreceipts.visible = True
	m_main.m_administration.m_postdepositreceipts.enabled = True
End If

// Maintain Reconcile Checks / Clear Checks / Check Book Ledger / Post Deposit Receipts
If dw_perms.Find("code=65", 1, dw_perms.RowCount()) > 0 Then
	m_main.m_administration.visible = True
	m_main.m_administration.m_reconcilechecks.visible = True
	m_main.m_administration.m_reconcilechecks.enabled = True
	
	m_main.m_administration.m_clearchecks.visible = True
	m_main.m_administration.m_clearchecks.enabled = True	
	
	m_main.m_administration.m_cashbookledgers.visible = True
	m_main.m_administration.m_cashbookledgers.enabled = True
	
	m_main.m_administration.m_postdepositreceipts.visible = True
	m_main.m_administration.m_postdepositreceipts.enabled = True	
End If

// Maintain Incremented Number Information
If dw_perms.Find("code=33", 1, dw_perms.RowCount()) > 0 Then
	m_main.m_administration.visible = True
	m_main.m_administration.m_incrementednumbers.visible = True	
	m_main.m_administration.m_incrementednumbers.enabled = True
End If

// Create New Year Incremented Numbers / New Year Ledgers
If dw_perms.Find("code=34", 1, dw_perms.RowCount()) > 0 Then
	m_main.m_administration.visible = True
	m_main.m_administration.m_createnewyearincrementednumbers.visible = True	
	m_main.m_administration.m_createnewyearincrementednumbers.enabled = True
	
	m_main.m_administration.m_createnewyearledgers.visible = True	
	m_main.m_administration.m_createnewyearledgers.enabled = True	
End If

// Administration Security Submenu
// Maintain Permissions
If dw_perms.Find("code=5", 1, dw_perms.RowCount()) > 0 Then
	m_main.m_administration.visible = True
	m_main.m_administration.m_security.visible = True
	m_main.m_administration.m_security.m_permissions.visible = True	
	m_main.m_administration.m_security.m_permissions.enabled = True
End If

// Administration Security Submenu
// Maintain Access 
If dw_perms.Find("code=9", 1, dw_perms.RowCount()) > 0 Then
	m_main.m_administration.visible = True
	m_main.m_administration.m_security.visible = True
	m_main.m_administration.m_security.m_access.visible = True
	m_main.m_administration.m_security.m_access.enabled = True
End If

// Civil Processes Submenu
// Maintain Dockets
If dw_perms.Find("code=17", 1, dw_perms.RowCount()) > 0 Then
	m_main.m_civilprocesses.visible = True
	m_main.m_civilprocesses.m_dockets.visible = True
	m_main.m_civilprocesses.m_dockets.enabled = True
End If

// Maintain Docket Receipts
If dw_perms.Find("code=45", 1, dw_perms.RowCount()) > 0 Then
	m_main.m_civilprocesses.visible = True
	m_main.m_civilprocesses.m_docketreceipts.visible = True
	m_main.m_civilprocesses.m_docketreceipts.enabled = True
End If

// Maintain Misc Cash Receipts
If dw_perms.Find("code=49", 1, dw_perms.RowCount()) > 0 Then
	m_main.m_civilprocesses.visible = True
	m_main.m_civilprocesses.m_miscellaneouscashreceipts.visible = True
	m_main.m_civilprocesses.m_miscellaneouscashreceipts.enabled = True
End If

// Maintain Docket Disbursements / Misc Cash Disbursements / Print Checks
If dw_perms.Find("code=53", 1, dw_perms.RowCount()) > 0 Then
	m_main.m_civilprocesses.visible = True
	m_main.m_civilprocesses.m_docketdisbursements.visible = True
	m_main.m_civilprocesses.m_docketdisbursements.enabled = True
	
	m_main.m_civilprocesses.m_miscellaneouscashdisbursements.visible = True
	m_main.m_civilprocesses.m_miscellaneouscashdisbursements.enabled = True
	
//	m_main.m_civilprocesses.m_printdocketchecks.visible = True
//	m_main.m_civilprocesses.m_printdocketchecks.enabled = True

//	m_main.m_civilprocesses.m_printmiscreceiptchecks.visible = True
//	m_main.m_civilprocesses.m_printmiscreceiptchecks.enabled = True	
End If


end event

on w_main.create
if this.MenuName = "m_main" then this.MenuID = create m_main
this.mdi_1=create mdi_1
this.dw_perms=create dw_perms
this.Control[]={this.mdi_1,&
this.dw_perms}
end on

on w_main.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.dw_perms)
end on

event resize;/*integer nwidth, nheight

nheight = w_main.workspaceheight()
nwidth = w_main.workspacewidth()
nwidth = nwidth + 170 // 170
nheight = nheight + 50 // 50

mdi_1.move(0,120) //120,  new 130
mdi_1.Resize(nwidth, nheight)
*/
Close(w_banner)
end event

type mdi_1 from mdiclient within w_main
long BackColor=16777215
end type

type dw_perms from datawindow within w_main
int X=69
int Y=397
int Width=1858
int Height=365
int TabOrder=10
boolean Visible=false
string DataObject="dw_security"
boolean LiveScroll=true
end type

