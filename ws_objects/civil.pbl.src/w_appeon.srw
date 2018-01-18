$PBExportHeader$w_appeon.srw
forward
global type w_appeon from window
end type
type cb_2 from commandbutton within w_appeon
end type
type cb_1 from commandbutton within w_appeon
end type
type dw_scan from datawindow within w_appeon
end type
end forward

global type w_appeon from window
integer width = 2601
integer height = 1916
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_scan dw_scan
end type
global w_appeon w_appeon

type variables
int ll
end variables

on w_appeon.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_scan=create dw_scan
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_scan}
end on

on w_appeon.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_scan)
end on

type cb_2 from commandbutton within w_appeon
integer x = 937
integer y = 1644
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ScrollToRow"
end type

event clicked;dw_scan.ScrollToRow(ll)	
end event

type cb_1 from commandbutton within w_appeon
integer x = 475
integer y = 1656
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "retreieve"
end type

event clicked;string  i_achSQL
long newrow,s_srow,s_iDockYear,s_lDockNum
i_achSQL = "SELECT DISTINCT sh_docket.docket_year, sh_docket.docket_number, sh_docket.case_number,   sh_docket.parties_involved   FROM sh_docket, sh_docket_name  WHERE ( sh_docket.docket_year  = sh_docket_name.docket_year) and   ( sh_docket.docket_number  = sh_docket_name.docket_number)    "
dw_scan.SetTransObject(SQLCA)
//dw_scan.SetRedraw(False)			
//dw_scan.Modify("datawindow.table.select='" + i_achSQL + "'")			
i_log.of_log(i_achSQL)
newrow = dw_scan.Retrieve() 

//i_log.of_log("appeon retrieve")			

//integer s_sRow
//s_iDockYear = 2008
//s_lDockNum = 978
//ll = dw_scan.Find("docket_year = " + String(s_iDockYear) + &
//					" AND docket_number = " + String(s_lDockNum), 0, newrow) //dw_scan.RowCount())		
ll = dw_scan.Rowcount( )
//	i_log.of_log(string(s_sRow))
//	i_log.of_log("appeon find")			
//				If s_sRow = 0 Then s_sRow = 1
//		
				// highlight only the closest row
//dw_scan.ScrollToRow(s_sRow)	
//i_log.of_log("appeon end")			
//dw_scan.SetRedraw(true)
end event

type dw_scan from datawindow within w_appeon
integer x = 123
integer y = 48
integer width = 2318
integer height = 1544
integer taborder = 10
string title = "none"
string dataobject = "dw_appeon"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

