$PBExportHeader$w_base_sheet.srw
forward
global type w_base_sheet from Window
end type
type cb_escape from commandbutton within w_base_sheet
end type
type cb_exit from commandbutton within w_base_sheet
end type
type cb_last from commandbutton within w_base_sheet
end type
type cb_next from commandbutton within w_base_sheet
end type
type cb_back from commandbutton within w_base_sheet
end type
type cb_first from commandbutton within w_base_sheet
end type
type cb_save from commandbutton within w_base_sheet
end type
type cb_delete from commandbutton within w_base_sheet
end type
type cb_update from commandbutton within w_base_sheet
end type
type cb_add from commandbutton within w_base_sheet
end type
type cb_new from commandbutton within w_base_sheet
end type
type cb_clear from commandbutton within w_base_sheet
end type
type cb_search from commandbutton within w_base_sheet
end type
type dw_detail from datawindow within w_base_sheet
end type
type dw_scan from datawindow within w_base_sheet
end type
type gb_5 from groupbox within w_base_sheet
end type
type gb_4 from groupbox within w_base_sheet
end type
type gb_1 from groupbox within w_base_sheet
end type
type gb_2 from groupbox within w_base_sheet
end type
type cb_list from commandbutton within w_base_sheet
end type
type cb_detail from commandbutton within w_base_sheet
end type
type gb_3 from groupbox within w_base_sheet
end type
end forward

global type w_base_sheet from Window
int X=355
int Y=336
int Width=4297
int Height=1933
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
event ue_add pbm_custom01
event ue_delete pbm_custom02
event ue_save pbm_custom03
event ue_print_list pbm_custom04
event ue_exit pbm_custom05
event ue_search pbm_custom06
event ue_clear pbm_custom07
event ue_help pbm_custom08
event ue_next pbm_custom09
event ue_back pbm_custom10
event ue_print_detail pbm_custom11
event ue_move_window pbm_custom12
event ue_val_fields pbm_custom13
event ue_update pbm_custom14
event ue_first pbm_custom15
event ue_last pbm_custom16
event ue_new pbm_custom17
event ue_escape pbm_custom18
cb_escape cb_escape
cb_exit cb_exit
cb_last cb_last
cb_next cb_next
cb_back cb_back
cb_first cb_first
cb_save cb_save
cb_delete cb_delete
cb_update cb_update
cb_add cb_add
cb_new cb_new
cb_clear cb_clear
cb_search cb_search
dw_detail dw_detail
dw_scan dw_scan
gb_5 gb_5
gb_4 gb_4
gb_1 gb_1
gb_2 gb_2
cb_list cb_list
cb_detail cb_detail
gb_3 gb_3
end type
global w_base_sheet w_base_sheet

type variables
integer i_iRow, i_iinitheight, i_iinitwidth
integer i_iValFlag = 0
string   i_achSQL, i_achOpType
st_menuparms i_menuparms
end variables

event ue_add;i_achOpType = "Add"
dw_detail.Reset()
dw_detail.InsertRow(0)

cb_add.enabled = False
m_main.m_general.m_add.enabled = False
cb_update.enabled = False
m_main.m_general.m_update.enabled = False
cb_delete.enabled = False
m_main.m_general.m_delete.enabled = False
cb_escape.enabled = True
m_main.m_general.m_escape.enabled = True
cb_save.enabled = True
m_main.m_general.m_save.enabled = True

end event

event ue_delete;string s_achErrText

i_achOpType = "Delete"

cb_new.enabled = False
m_main.m_general.m_new.enabled = False
cb_add.enabled = False
m_main.m_general.m_add.enabled = False
cb_update.enabled = False
m_main.m_general.m_update.enabled = False
cb_delete.enabled = False
m_main.m_general.m_delete.enabled = False

If dw_detail.RowCount() = 0 Then
   MessageBox("Error","Select Row to Delete",StopSign!)
Else
   If 2 = MessageBox("Delete","Delete This Entry?",Question!,OkCancel!,2) Then
      MessageBox("Delete","Entry NOT Deleted",None!)
   Else
		
		SetPointer(Hourglass!) 
		
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
			End If
		End If
	End If
End If
	

end event

event ue_save;// script variables
string	s_achErrText

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
		ROLLBACK;
		MessageBox("Error", "Update Failed - " + s_achErrText)
	End If
End If


end event

event ue_print_list;
OpenWithParm(w_datawindow_print_dialog,dw_scan)

//PrintSetup()
//dw_scan.Print()
end event

event ue_exit;Close(this)
end event

event ue_search;// cb_add.enabled = True
// cb_delete.enabled = True
// cb_update.enabled = True
// cb_save.enabled = False

cb_search.default = False
end event

event ue_clear;dw_scan.Reset()
dw_detail.Reset()

dw_scan.enabled = TRUE
cb_search.default = True

cb_new.enabled = False
m_main.m_general.m_new.enabled = False
cb_add.enabled = False
m_main.m_general.m_add.enabled = False
cb_delete.enabled = False
m_main.m_general.m_delete.enabled = False
cb_update.enabled = False
m_main.m_general.m_update.enabled = False
cb_escape.enabled = False
m_main.m_general.m_escape.enabled = False
cb_save.enabled = False
m_main.m_general.m_save.enabled = False
end event

event ue_help;OpenWithParm(w_construct, "Help")
end event

event ue_print_detail;
OpenWithParm(w_datawindow_print_dialog,dw_detail)

//dw_detail.Print()
end event

event ue_move_window;this.x = 5
this.y = 5
end event

event ue_update;i_achOpType = "Update"
dw_detail.SetFocus()

cb_new.enabled = False
m_main.m_general.m_new.enabled = False
cb_add.enabled = False
m_main.m_general.m_add.enabled = False
cb_delete.enabled = False
m_main.m_general.m_delete.enabled = False
cb_update.enabled = False
m_main.m_general.m_update.enabled = False
cb_escape.enabled = True
m_main.m_general.m_escape.enabled = True
cb_save.enabled = True
m_main.m_general.m_save.enabled = True


end event

event ue_new;dw_scan.enabled = False
end event

event open;integer nheight, nwidth
SetPointer(HourGlass!)

//this.Width = dw_scan.width + dw_scan.x + 1100  /*1600*/   /*135*/
i_achSQL = dw_scan.GetSQLSelect()
dw_scan.SetTransObject(SQLCA)

this.Visible = False
//this.SetRedraw(False)
PostEvent("ue_move_window")
//this.SetRedraw(True)

nheight = w_main.workspaceheight()
nwidth = w_main.workspacewidth()
//nwidth = nwidth + 170 // 170
//nheight = nheight + 70 // 50

this.Resize(g_iwidth, g_iheight)

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


end event

on w_base_sheet.create
this.cb_escape=create cb_escape
this.cb_exit=create cb_exit
this.cb_last=create cb_last
this.cb_next=create cb_next
this.cb_back=create cb_back
this.cb_first=create cb_first
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_update=create cb_update
this.cb_add=create cb_add
this.cb_new=create cb_new
this.cb_clear=create cb_clear
this.cb_search=create cb_search
this.dw_detail=create dw_detail
this.dw_scan=create dw_scan
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_1=create gb_1
this.gb_2=create gb_2
this.cb_list=create cb_list
this.cb_detail=create cb_detail
this.gb_3=create gb_3
this.Control[]={this.cb_escape,&
this.cb_exit,&
this.cb_last,&
this.cb_next,&
this.cb_back,&
this.cb_first,&
this.cb_save,&
this.cb_delete,&
this.cb_update,&
this.cb_add,&
this.cb_new,&
this.cb_clear,&
this.cb_search,&
this.dw_detail,&
this.dw_scan,&
this.gb_5,&
this.gb_4,&
this.gb_1,&
this.gb_2,&
this.cb_list,&
this.cb_detail,&
this.gb_3}
end on

on w_base_sheet.destroy
destroy(this.cb_escape)
destroy(this.cb_exit)
destroy(this.cb_last)
destroy(this.cb_next)
destroy(this.cb_back)
destroy(this.cb_first)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_update)
destroy(this.cb_add)
destroy(this.cb_new)
destroy(this.cb_clear)
destroy(this.cb_search)
destroy(this.dw_detail)
destroy(this.dw_scan)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.cb_list)
destroy(this.cb_detail)
destroy(this.gb_3)
end on

event resize;
If i_iinitheight > this.Height Then this.VScrollBar = True
If i_iinitwidth > this.Width Then this.HScrollBar = True

end event

event closequery;Choose Case gf_check_pending(dw_detail)
	Case 1	// save changes
		this.TriggerEvent("ue_save")
		
	Case 3	// cancel
		Return(1) // don't close the window
		
	Case 0	// no changes pending
		
	Case 2	// changes pending but don't save
		
End Choose
end event

event mousemove;w_main.SetMicroHelp("Ready")
end event

event activate;integer nwidth, nheight
window s_wActiveSheet

/*nheight = w_main.workspaceheight()
nwidth = w_main.workspacewidth()
nwidth = nwidth + 170 // 170
nheight = nheight + 70 // 50
*/
/***
nheight = w_main.workspaceheight()
nwidth = w_main.workspacewidth()
//nwidth = nwidth + 170 // 170
//nheight = nheight + 70 // 50

this.Resize(nwidth, nheight)
***/
s_wActiveSheet = w_main.GetFirstSheet()
If IsValid(s_wActiveSheet) = True Then 
//	w_main.mdi_1.move(0,90) //120,  new 130
//	w_main.mdi_1.Resize(nwidth, nheight)

	If i_menuparms.bnew = True Then
		cb_new.enabled = True
		m_main.m_general.m_new.enabled = True
	Else	
		cb_new.enabled = False		
		m_main.m_general.m_new.enabled = False		
	End If
	
	If i_menuparms.badd = True Then
		cb_add.enabled = True		
		m_main.m_general.m_add.enabled = True
	Else	
		cb_add.enabled = False		
		m_main.m_general.m_add.enabled = False		
	End If
	
	If i_menuparms.bupdate = True Then
		cb_update.enabled = True		
		m_main.m_general.m_update.enabled = True
	Else	
		cb_update.enabled = False		
		m_main.m_general.m_update.enabled = False		
	End If
	
	If i_menuparms.bdelete = True Then
		cb_delete.enabled = True		
		m_main.m_general.m_delete.enabled = True
	Else	
		cb_delete.enabled = False		
		m_main.m_general.m_delete.enabled = False		
	End If

	If i_menuparms.bescape = True Then
		cb_escape.enabled = True		
		m_main.m_general.m_escape.enabled = True
	Else	
		cb_escape.enabled = False
		m_main.m_general.m_escape.enabled = False		
	End If
	
	If i_menuparms.bsave = True Then
		cb_save.enabled = True		
		m_main.m_general.m_save.enabled = True
	Else	
		cb_save.enabled = False
		m_main.m_general.m_save.enabled = False		
	End If
	
	If i_menuparms.bfirst = True Then
		cb_first.enabled = True		
		m_main.m_general.m_first.enabled = True
	Else	
		cb_first.enabled = False		
		m_main.m_general.m_first.enabled = False		
	End If
	
	If i_menuparms.bback = True Then
		cb_back.enabled = True		
		m_main.m_general.m_back.enabled = True
	Else	
		cb_back.enabled = False		
		m_main.m_general.m_back.enabled = False		
	End If
	
	If i_menuparms.bnext = True Then
		cb_next.enabled = True		
		m_main.m_general.m_next.enabled = True
	Else	
		cb_next.enabled = False		
		m_main.m_general.m_next.enabled = False		
	End If
	
	If i_menuparms.blast = True Then
		cb_last.enabled = True		
		m_main.m_general.m_last.enabled = True
	Else	
		cb_last.enabled = False		
		m_main.m_general.m_last.enabled = False		
	End If
	
Else	
//	w_main.mdi_1.move(0,90) //120,  new 130
//	w_main.mdi_1.Resize(nwidth, nheight)
		
	If i_menuparms.bnew = True Then
		cb_new.enabled = True
		m_main.m_general.m_new.enabled = True
	Else	
		cb_new.enabled = False		
		m_main.m_general.m_new.enabled = False		
	End If
	
	If i_menuparms.badd = True Then
		cb_add.enabled = True		
		m_main.m_general.m_add.enabled = True
	Else	
		cb_add.enabled = False		
		m_main.m_general.m_add.enabled = False		
	End If
	
	If i_menuparms.bupdate = True Then
		cb_update.enabled = True		
		m_main.m_general.m_update.enabled = True
	Else	
		cb_update.enabled = False		
		m_main.m_general.m_update.enabled = False		
	End If
	
	If i_menuparms.bdelete = True Then
		cb_delete.enabled = True		
		m_main.m_general.m_delete.enabled = True
	Else	
		cb_delete.enabled = False		
		m_main.m_general.m_delete.enabled = False		
	End If

	If i_menuparms.bescape = True Then
		cb_escape.enabled = True		
		m_main.m_general.m_escape.enabled = True
	Else	
		cb_escape.enabled = False
		m_main.m_general.m_escape.enabled = False		
	End If
	
	If i_menuparms.bsave = True Then
		cb_save.enabled = True		
		m_main.m_general.m_save.enabled = True
	Else	
		cb_save.enabled = False
		m_main.m_general.m_save.enabled = False		
	End If
	
	If i_menuparms.bfirst = True Then
		cb_first.enabled = True		
		m_main.m_general.m_first.enabled = True
	Else	
		cb_first.enabled = False		
		m_main.m_general.m_first.enabled = False		
	End If
	
	If i_menuparms.bback = True Then
		cb_back.enabled = True		
		m_main.m_general.m_back.enabled = True
	Else	
		cb_back.enabled = False		
		m_main.m_general.m_back.enabled = False		
	End If
	
	If i_menuparms.bnext = True Then
		cb_next.enabled = True		
		m_main.m_general.m_next.enabled = True
	Else	
		cb_next.enabled = False		
		m_main.m_general.m_next.enabled = False		
	End If
	
	If i_menuparms.blast = True Then
		cb_last.enabled = True		
		m_main.m_general.m_last.enabled = True
	Else	
		cb_last.enabled = False		
		m_main.m_general.m_last.enabled = False		
	End If
	
End If	
end event

event close;integer nwidth, nheight

nheight = w_main.workspaceheight()
nwidth = w_main.workspacewidth()
nwidth = nwidth + 170 // 170
nheight = nheight + 70 // 50

this.SetRedraw(False)
//w_main.mdi_1.move(0,90) //120,  new 130
//w_main.mdi_1.Resize(nwidth, nheight)
this.SetRedraw(True)
end event

event deactivate;
If m_main.m_general.m_new.enabled = True Then
	i_menuparms.bnew = True
Else
	i_menuparms.bnew = False
End if 	

If m_main.m_general.m_add.enabled = True Then
	i_menuparms.badd = True
Else
	i_menuparms.badd = False
End if 	

If m_main.m_general.m_update.enabled = True Then
	i_menuparms.bupdate = True
Else
	i_menuparms.bupdate = False
End if 	

If m_main.m_general.m_delete.enabled = True Then
	i_menuparms.bdelete = True
Else
	i_menuparms.bdelete = False
End if 	

If m_main.m_general.m_escape.enabled = True Then
	i_menuparms.bescape = True
Else
	i_menuparms.bescape = False
End if 	

If m_main.m_general.m_save.enabled = True Then
	i_menuparms.bsave = True
Else
	i_menuparms.bsave = False
End if 	

If m_main.m_general.m_first.enabled = True Then
	i_menuparms.bfirst = True
Else
	i_menuparms.bfirst = False
End if 	

If m_main.m_general.m_next.enabled = True Then
	i_menuparms.bnext = True
Else
	i_menuparms.bnext = False
End if

If m_main.m_general.m_back.enabled = True Then
	i_menuparms.bback = True
Else
	i_menuparms.bback = False
End if 	

If m_main.m_general.m_last.enabled = True Then
	i_menuparms.blast = True
Else
	i_menuparms.blast = False
End if 	

end event

type cb_escape from commandbutton within w_base_sheet
int X=3163
int Y=528
int Width=201
int Height=67
int TabOrder=150
string Text="Escape"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;window lw_window

lw_window = parent.getactivesheet()

if isvalid(lw_window) then lw_window.postevent("ue_escape")
end event

type cb_exit from commandbutton within w_base_sheet
int X=3412
int Y=598
int Width=201
int Height=67
int TabOrder=150
string Text="Exit"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;window lw_window

lw_window = parent.getactivesheet()

if isvalid(lw_window) then lw_window.postevent("ue_exit")
end event

type cb_last from commandbutton within w_base_sheet
int X=3412
int Y=461
int Width=201
int Height=67
int TabOrder=140
string Text="Last"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;window lw_window

lw_window = parent.getactivesheet()

if isvalid(lw_window) then lw_window.postevent("ue_last")
end event

type cb_next from commandbutton within w_base_sheet
int X=3412
int Y=394
int Width=201
int Height=67
int TabOrder=130
string Text="Next"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;window lw_window

lw_window = parent.getactivesheet()

if isvalid(lw_window) then lw_window.postevent("ue_next")
end event

type cb_back from commandbutton within w_base_sheet
int X=3412
int Y=326
int Width=201
int Height=67
int TabOrder=120
string Text="Back"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;window lw_window

lw_window = parent.getactivesheet()

if isvalid(lw_window) then lw_window.postevent("ue_back")
end event

type cb_first from commandbutton within w_base_sheet
int X=3412
int Y=259
int Width=201
int Height=67
int TabOrder=100
string Text="First"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;window lw_window

lw_window = parent.getactivesheet()

if isvalid(lw_window) then lw_window.postevent("ue_first")
end event

type cb_save from commandbutton within w_base_sheet
int X=3163
int Y=598
int Width=201
int Height=67
int TabOrder=70
string Text="Save"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;window lw_window

lw_window = parent.getactivesheet()

if isvalid(lw_window) then lw_window.postevent("ue_save")
end event

type cb_delete from commandbutton within w_base_sheet
int X=3163
int Y=461
int Width=201
int Height=67
int TabOrder=60
string Text="Delete"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;window lw_window

lw_window = parent.getactivesheet()

if isvalid(lw_window) then lw_window.postevent("ue_delete")
end event

type cb_update from commandbutton within w_base_sheet
int X=3163
int Y=394
int Width=201
int Height=67
int TabOrder=50
string Text="Update"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;window lw_window

lw_window = parent.getactivesheet()

if isvalid(lw_window) then lw_window.postevent("ue_update")
end event

type cb_add from commandbutton within w_base_sheet
int X=3163
int Y=326
int Width=201
int Height=67
int TabOrder=40
string Text="Add"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;window lw_window

lw_window = parent.getactivesheet()

if isvalid(lw_window) then lw_window.postevent("ue_add")
end event

type cb_new from commandbutton within w_base_sheet
int X=3163
int Y=259
int Width=201
int Height=67
int TabOrder=30
string Text="New"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;window lw_window

lw_window = parent.getactivesheet()

if isvalid(lw_window) then lw_window.postevent("ue_new")
end event

type cb_clear from commandbutton within w_base_sheet
int X=3163
int Y=115
int Width=201
int Height=67
int TabOrder=20
string Text="Clear"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;window lw_window

lw_window = parent.getactivesheet()

if isvalid(lw_window) then lw_window.postevent("ue_clear")
end event

type cb_search from commandbutton within w_base_sheet
int X=3163
int Y=48
int Width=201
int Height=67
int TabOrder=10
string Text="Search"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;window lw_window

lw_window = parent.getactivesheet()

if isvalid(lw_window) then lw_window.postevent("ue_search")
end event

type dw_detail from datawindow within w_base_sheet
event ue_stopmove pbm_nclbuttondown
event ue_tabenter pbm_dwnprocessenter
int X=18
int Y=662
int Width=2615
int Height=1078
int TabOrder=160
boolean TitleBar=true
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event ue_stopmove;Choose Case message.wordparm
	Case 6, 7
		Return
	Case Else
		message.returnvalue=1
		message.processed=true
		Return
End Choose
end event

event ue_tabenter;Send(Handle(this),256,9,Long(0,0))
RETURN 1
end event

event getfocus;//datawindow	ldw_This
//window		lw_Parent
//
//dw_detail.enabled = True
//lw_Parent = Parent
//ldw_This = This
//
//gf_scroll_window_to_dw(lw_Parent, ldw_This)
//
//dw_scan.enabled = False
end event

event rowfocuschanged;dw_detail.Title = dw_detail.Tag + " " + "Record " + String(dw_detail.GetRow()) + " of " + String(dw_detail.RowCount()) + "."

end event

type dw_scan from datawindow within w_base_sheet
int X=18
int Y=16
int Width=2615
int Height=630
int TabOrder=110
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;// dw_detail.SetFocus()
end event

event clicked;/*
datawindow ldw_Sort
ldw_Sort = This
gf_sortcolumn(ldw_Sort)
*/
end event

type gb_5 from groupbox within w_base_sheet
int X=3387
int Y=550
int Width=249
int Height=134
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_4 from groupbox within w_base_sheet
int X=3387
int Y=208
int Width=249
int Height=342
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_base_sheet
int X=3138
int Width=249
int Height=208
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_base_sheet
int X=3138
int Y=208
int Width=249
int Height=477
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_list from commandbutton within w_base_sheet
int X=3412
int Y=48
int Width=201
int Height=67
int TabOrder=80
boolean BringToTop=true
string Text="Prt List"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;window lw_window

lw_window = parent.getactivesheet()

if isvalid(lw_window) then lw_window.postevent("ue_print_list")
end event

type cb_detail from commandbutton within w_base_sheet
int X=3412
int Y=115
int Width=201
int Height=67
int TabOrder=90
boolean BringToTop=true
string Text="Prt Det"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;window lw_window

lw_window = parent.getactivesheet()

if isvalid(lw_window) then lw_window.postevent("ue_print_detail")
end event

type gb_3 from groupbox within w_base_sheet
int X=3387
int Width=249
int Height=208
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

