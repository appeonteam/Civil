﻿$PBExportHeader$w_base_no_criteria_scan.srw
$PBExportComments$Ancestor window
forward
global type w_base_no_criteria_scan from Window
end type
type cb_view from commandbutton within w_base_no_criteria_scan
end type
type cb_print from commandbutton within w_base_no_criteria_scan
end type
type cb_update from commandbutton within w_base_no_criteria_scan
end type
type dw_scan from datawindow within w_base_no_criteria_scan
end type
type cb_exit from commandbutton within w_base_no_criteria_scan
end type
type cb_delete from commandbutton within w_base_no_criteria_scan
end type
type cb_add from commandbutton within w_base_no_criteria_scan
end type
end forward

global type w_base_no_criteria_scan from Window
int X=358
int Y=422
int Width=2209
int Height=1085
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
boolean MaxBox=true
boolean Resizable=true
event addclicked pbm_custom01
event printclicked pbm_custom02
event deleteclicked pbm_custom03
event updateclicked pbm_custom04
event opendetail pbm_custom05
event viewclicked pbm_custom06
event opentimer pbm_custom75
cb_view cb_view
cb_print cb_print
cb_update cb_update
dw_scan dw_scan
cb_exit cb_exit
cb_delete cb_delete
cb_add cb_add
end type
global w_base_no_criteria_scan w_base_no_criteria_scan

type variables
integer i_iRow
string   i_achOpType
w_timer_bar w_timer
end variables

on addclicked;i_achOpType = "add"
i_irow = 0
This.PostEvent("opendetail")
end on

event printclicked;
OpenWithParm(w_datawindow_print_dialog,dw_scan)

//PrintSetup()
//dw_scan.Print()
end event

on deleteclicked;string s_achErrText
integer temp

i_iRow = dw_scan.GetRow()
If i_iRow = 0 Then
   MessageBox("Error","Select Row to Delete",Stopsign!)
Else
   dw_scan.ScrollToRow(i_iRow)
   If 2 = MessageBox("Delete","Delete This Entry?",Question!,OkCancel!,2) Then
      MessageBox("Delete","Entry NOT Deleted",None!)
   Else
		SetPointer(Hourglass!) 
		temp = dw_scan.DeleteRow(i_iRow) 
		If dw_scan.Update(True) = -1 Then
			s_achErrText = SQLCA.SQLErrText
			ROLLBACK;
			MessageBox("Error", "Delete Failed - " + s_achErrText)
			dw_scan.Reset()
			dw_scan.Retrieve()
		Else
			COMMIT;
			If SQLCA.SQLCode = -1 Then
				s_achErrText = SQLCA.SQLErrText
				ROLLBACK;
				MessageBox("Error", "Delete Failed - " + s_achErrText)
				dw_scan.Reset()
				dw_scan.Retrieve()	
			End If
		End If
	End If
End If
	
end on

on updateclicked;
i_iRow = dw_scan.GetRow()
If i_iRow = 0 Then
   MessageBox("Error","Select Row to Update",Stopsign!)
Else
	i_achOpType = "update"
   This.PostEvent("opendetail")
End if
end on

on viewclicked;
i_iRow = dw_scan.GetRow()
If i_iRow = 0 Then
   MessageBox("Error","Select Row to View",Stopsign!)
Else
	i_achOpType = "view"
   This.PostEvent("opendetail")
End if
end on

event opentimer;Open(w_timer, this)
w_timer.wf_pos_timer(this.height, this.width, this.x, this.y)
//w_timer.visible = True
this.dw_scan.SetFocus()
end event

event open;integer nwidth, nheight
window s_wActiveSheet

SetPointer(HourGlass!)

w_main.enabled = False

nheight = w_main.workspaceheight()
nwidth = w_main.workspacewidth()
//nwidth = nwidth + 170 // 170
//nheight = nheight + 70 // 50

//this.Resize(nwidth, nheight)
this.Resize(g_iwidth, g_iheight)

this.PostEvent("opentimer")

dw_scan.SetTransObject(SQLCA)
dw_scan.Retrieve()
dw_scan.SetRowFocusIndicator(Hand!)
dw_scan.SetFocus()
end event

on w_base_no_criteria_scan.create
this.cb_view=create cb_view
this.cb_print=create cb_print
this.cb_update=create cb_update
this.dw_scan=create dw_scan
this.cb_exit=create cb_exit
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.Control[]={this.cb_view,&
this.cb_print,&
this.cb_update,&
this.dw_scan,&
this.cb_exit,&
this.cb_delete,&
this.cb_add}
end on

on w_base_no_criteria_scan.destroy
destroy(this.cb_view)
destroy(this.cb_print)
destroy(this.cb_update)
destroy(this.dw_scan)
destroy(this.cb_exit)
destroy(this.cb_delete)
destroy(this.cb_add)
end on

type cb_view from commandbutton within w_base_no_criteria_scan
int X=753
int Y=822
int Width=285
int Height=109
int TabOrder=40
string Text="&View"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Parent.TriggerEvent("viewclicked")
end on

type cb_print from commandbutton within w_base_no_criteria_scan
int X=1393
int Y=822
int Width=285
int Height=109
int TabOrder=60
string Text="&Print"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Parent.TriggerEvent("printclicked")
end on

type cb_update from commandbutton within w_base_no_criteria_scan
int X=435
int Y=822
int Width=285
int Height=109
int TabOrder=30
string Text="&Update"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Parent.TriggerEvent("updateclicked")
end on

type dw_scan from datawindow within w_base_no_criteria_scan
int X=113
int Y=109
int Width=1935
int Height=634
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;
Parent.PostEvent("updateclicked")
end event

type cb_exit from commandbutton within w_base_no_criteria_scan
int X=1770
int Y=822
int Width=285
int Height=109
int TabOrder=70
string Text="E&xit"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;w_main.enabled = True
w_main.SetFocus()

Close(Parent)
end on

type cb_delete from commandbutton within w_base_no_criteria_scan
int X=1075
int Y=822
int Width=285
int Height=109
int TabOrder=50
string Text="&Delete"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Parent.TriggerEvent("deleteclicked")
end on

type cb_add from commandbutton within w_base_no_criteria_scan
int X=113
int Y=822
int Width=285
int Height=109
int TabOrder=20
string Text="&Add"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Parent.TriggerEvent("addclicked")
end on
