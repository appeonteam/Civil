$PBExportHeader$w_datawindow_print_dialog.srw
forward
global type w_datawindow_print_dialog from Window
end type
type cbx_rich_text from checkbox within w_datawindow_print_dialog
end type
type cb_help from commandbutton within w_datawindow_print_dialog
end type
type cbx_html from checkbox within w_datawindow_print_dialog
end type
type st_current_printer from statictext within w_datawindow_print_dialog
end type
type rb_current_page from radiobutton within w_datawindow_print_dialog
end type
type cb_printer_setup from commandbutton within w_datawindow_print_dialog
end type
type cb_cancel from commandbutton within w_datawindow_print_dialog
end type
type cb_ok from commandbutton within w_datawindow_print_dialog
end type
type st_3 from statictext within w_datawindow_print_dialog
end type
type ddlb_range_include from dropdownlistbox within w_datawindow_print_dialog
end type
type cbx_collate from checkbox within w_datawindow_print_dialog
end type
type cbx_print_to_file from checkbox within w_datawindow_print_dialog
end type
type st_2 from statictext within w_datawindow_print_dialog
end type
type sle_page_range from singlelineedit within w_datawindow_print_dialog
end type
type rb_pages from radiobutton within w_datawindow_print_dialog
end type
type rb_all_pages from radiobutton within w_datawindow_print_dialog
end type
type st_1 from statictext within w_datawindow_print_dialog
end type
type st_current_printer_heading from statictext within w_datawindow_print_dialog
end type
type em_copies from editmask within w_datawindow_print_dialog
end type
type gb_1 from groupbox within w_datawindow_print_dialog
end type
end forward

global type w_datawindow_print_dialog from Window
int X=1020
int Y=707
int Width=1719
int Height=1059
boolean TitleBar=true
string Title="Print"
long BackColor=12632256
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
cbx_rich_text cbx_rich_text
cb_help cb_help
cbx_html cbx_html
st_current_printer st_current_printer
rb_current_page rb_current_page
cb_printer_setup cb_printer_setup
cb_cancel cb_cancel
cb_ok cb_ok
st_3 st_3
ddlb_range_include ddlb_range_include
cbx_collate cbx_collate
cbx_print_to_file cbx_print_to_file
st_2 st_2
sle_page_range sle_page_range
rb_pages rb_pages
rb_all_pages rb_all_pages
st_1 st_1
st_current_printer_heading st_current_printer_heading
em_copies em_copies
gb_1 gb_1
end type
global w_datawindow_print_dialog w_datawindow_print_dialog

type variables
Datawindow	i_dwToActOn
String		i_szFileName = ""
end variables

forward prototypes
public function integer wf_control_enabler (boolean arg_enabled)
end prototypes

public function integer wf_control_enabler (boolean arg_enabled);// wf_contol_enabler - Turn controls on or off
//                     Copyright (C) 1998 DEVNET, Inc.  All rights reserved
//
// Arguments: 
// 	arg_enabled - TRUE to enable controls, FALSE to disable

cbx_collate.enabled = arg_enabled
ddlb_range_include.enabled = arg_enabled
em_copies.enabled = arg_enabled
rb_all_pages.enabled = arg_enabled
rb_current_page.enabled = arg_enabled
rb_pages.enabled = arg_enabled
sle_page_range.enabled = arg_enabled
cbx_print_to_file.enabled = arg_enabled

return 1

end function

event open;String szCopies

i_dwToActOn = Message.PowerObjectParm

st_current_printer.text = String(i_dwToActOn.Object.DataWindow.Printer)

szCopies = String( i_dwToActOn.Object.DataWindow.Print.Copies)
If szCopies <> "" And szCopies <> "0" Then
   em_copies.Text = szCopies
Else
   em_copies.Text = "1"
End If

cbx_collate.Checked = (Upper(String(i_dwToActOn.Object.DataWindow.Print.Collate)) = "YES")
i_szFileName = Trim( String( i_dwToActOn.Object.DataWindow.Print.FileName))
cbx_print_to_file.Checked = (i_szFileName <> "")

// Ancestor Controls
cb_cancel.pointer="arrow!"
cb_help.pointer="arrow!"
cb_ok.pointer="arrow!"
cb_printer_setup.pointer="arrow!"
cbx_collate.pointer="arrow!"
cbx_html.pointer="arrow!"
cbx_print_to_file.pointer="arrow!"
cbx_rich_text.pointer="arrow!"
gb_1.pointer="arrow!"
rb_all_pages.pointer="arrow!"
rb_current_page.pointer="arrow!"
rb_pages.pointer="arrow!"

end event

on w_datawindow_print_dialog.create
this.cbx_rich_text=create cbx_rich_text
this.cb_help=create cb_help
this.cbx_html=create cbx_html
this.st_current_printer=create st_current_printer
this.rb_current_page=create rb_current_page
this.cb_printer_setup=create cb_printer_setup
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_3=create st_3
this.ddlb_range_include=create ddlb_range_include
this.cbx_collate=create cbx_collate
this.cbx_print_to_file=create cbx_print_to_file
this.st_2=create st_2
this.sle_page_range=create sle_page_range
this.rb_pages=create rb_pages
this.rb_all_pages=create rb_all_pages
this.st_1=create st_1
this.st_current_printer_heading=create st_current_printer_heading
this.em_copies=create em_copies
this.gb_1=create gb_1
this.Control[]={this.cbx_rich_text,&
this.cb_help,&
this.cbx_html,&
this.st_current_printer,&
this.rb_current_page,&
this.cb_printer_setup,&
this.cb_cancel,&
this.cb_ok,&
this.st_3,&
this.ddlb_range_include,&
this.cbx_collate,&
this.cbx_print_to_file,&
this.st_2,&
this.sle_page_range,&
this.rb_pages,&
this.rb_all_pages,&
this.st_1,&
this.st_current_printer_heading,&
this.em_copies,&
this.gb_1}
end on

on w_datawindow_print_dialog.destroy
destroy(this.cbx_rich_text)
destroy(this.cb_help)
destroy(this.cbx_html)
destroy(this.st_current_printer)
destroy(this.rb_current_page)
destroy(this.cb_printer_setup)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_3)
destroy(this.ddlb_range_include)
destroy(this.cbx_collate)
destroy(this.cbx_print_to_file)
destroy(this.st_2)
destroy(this.sle_page_range)
destroy(this.rb_pages)
destroy(this.rb_all_pages)
destroy(this.st_1)
destroy(this.st_current_printer_heading)
destroy(this.em_copies)
destroy(this.gb_1)
end on

type cbx_rich_text from checkbox within w_datawindow_print_dialog
int X=1203
int Y=579
int Width=358
int Height=74
string Text="Print to &Text"
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

event clicked;String szFile

If this.Checked Then
	GetFileSaveName("Select Print File", i_szFileName, szFile, "TXT", "Text Files (*.TXT),*.TXT")
	wf_control_enabler(false)
	cbx_html.enabled = false
Else
	i_szFileName = ""	
	wf_control_enabler(true)
	cbx_html.enabled = true
End If
end event

type cb_help from commandbutton within w_datawindow_print_dialog
int X=1203
int Y=451
int Width=435
int Height=96
int TabOrder=70
boolean Enabled=false
string Text="Help"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Inet inService

GetContextService("Internet", inService)

inService.HyperlinkToURL("file://m:\sys\print_help.htm")

end event

type cbx_html from checkbox within w_datawindow_print_dialog
int X=1203
int Y=656
int Width=450
int Height=74
string Text="Print to &HTML"
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

event clicked;String szFile

If this.Checked Then
	GetFileSaveName("Select Print File", i_szFileName, szFile, "HTM", "HTML Files (*.HTM),*.HTM")
	wf_control_enabler(false)
	cbx_rich_text.enabled = false
Else
	i_szFileName = ""	
	if cbx_rich_text.checked = false then
		wf_control_enabler(true)
		cbx_rich_text.enabled = true
	end if
End If
end event

type st_current_printer from statictext within w_datawindow_print_dialog
int X=249
int Y=26
int Width=1371
int Height=74
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_current_page from radiobutton within w_datawindow_print_dialog
int X=66
int Y=413
int Width=505
int Height=74
int TabOrder=40
string Text="&Current Page"
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

type cb_printer_setup from commandbutton within w_datawindow_print_dialog
int X=1203
int Y=339
int Width=435
int Height=96
int TabOrder=90
string Text="Printer. . ."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;PrintSetup()

st_current_printer.text = String(i_dwToActOn.Object.DataWindow.Printer)
end event

type cb_cancel from commandbutton within w_datawindow_print_dialog
int X=1203
int Y=227
int Width=435
int Height=96
int TabOrder=80
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_datawindow_print_dialog
int X=1203
int Y=115
int Width=435
int Height=96
int TabOrder=10
string Text="OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Integer nIndex
String szModify, szPage, szReturn

if cbx_html.checked = true then
	i_dwtoacton.SaveAs(i_szFileName,HTMLTable!,false)
end if

if cbx_rich_text.checked = true then
	i_dwtoacton.SaveAs(i_szFileName,Text!,True)
end if

if cbx_rich_text.Checked or cbx_html.checked then 
	Close(parent)
	return
end if

szModify = "DataWindow.Print.Copies=" + em_copies.text

If cbx_collate.Checked Then
	szModify = szModify + " DataWindow.Print.Collate=Yes"
Else
	szModify = szModify + " DataWindow.Print.Collate=No"
End If

If cbx_print_to_file.Checked Then
	szModify = szModify + " DataWindow.Print.FileName='" + i_szFileName + "'"
Else
	szModify = szModify + " DataWindow.Print.FileName=''"
End If

If rb_all_pages.Checked Then
	szModify = szModify + " DataWindow.Print.Page.Range=''"
ElseIf rb_current_page.Checked Then
	szPage = i_dwToActOn.Describe( "Evaluate( 'Page()', " + String(i_dwToActOn.GetRow()) + ")")
	szModify = szModify + " DataWindow.Print.Page.Range='" + szPage + "'"
Else
	szModify = szModify + " DataWindow.Print.Page.Range='" + sle_page_range.text + "'"
End If

nIndex = ddlb_range_include.FindItem( ddlb_range_include.Text, 0)
szModify = szModify + " DataWindow.Print.Page.RangeInclude=" + String( nIndex - 1)

szReturn = i_dwToActOn.Modify( szModify)

If szReturn <> "" Then
	MessageBox("cb_ok", szReturn)
End If

Parent.Visible = FALSE

i_dwToActOn.Print(TRUE)

this.SetFocus()

Close(Parent)
end event

type st_3 from statictext within w_datawindow_print_dialog
int X=33
int Y=819
int Width=121
int Height=74
boolean Enabled=false
string Text="P&rint:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_range_include from dropdownlistbox within w_datawindow_print_dialog
int X=183
int Y=813
int Width=980
int Height=288
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"All Pages In Range",&
"Even Pages",&
"Odd Pages"}
end type

on constructor;this.SelectItem( 1)
end on

type cbx_collate from checkbox within w_datawindow_print_dialog
int X=1203
int Y=810
int Width=410
int Height=74
int TabOrder=110
boolean Visible=false
string Text="Col&late Copies"
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

type cbx_print_to_file from checkbox within w_datawindow_print_dialog
int X=1203
int Y=579
int Width=494
int Height=74
int TabOrder=100
boolean Visible=false
string Text="Print To &File"
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

on clicked;String szFile

If this.Checked Then
	GetFileSaveName("Select Print File", i_szFileName, szFile, "PRN", "Print Files (*.PRN),*.PRN")
Else
	i_szFileName = ""	
End If
end on

type st_2 from statictext within w_datawindow_print_dialog
int X=66
int Y=602
int Width=1050
int Height=128
boolean Enabled=false
string Text="Enter page numbers and/or page ranges separated by commas.  For example, 2,5,8-10"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_page_range from singlelineedit within w_datawindow_print_dialog
int X=333
int Y=502
int Width=585
int Height=90
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_pages from radiobutton within w_datawindow_print_dialog
int X=66
int Y=502
int Width=260
int Height=74
int TabOrder=50
string Text="&Pages"
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

on clicked;If this.Checked Then
	sle_page_range.SetFocus()
End If
end on

type rb_all_pages from radiobutton within w_datawindow_print_dialog
int X=66
int Y=326
int Width=249
int Height=74
int TabOrder=30
string Text="&All"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_datawindow_print_dialog
int X=33
int Y=125
int Width=205
int Height=74
boolean Visible=false
boolean Enabled=false
string Text="Cop&ies:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_current_printer_heading from statictext within w_datawindow_print_dialog
int X=33
int Y=26
int Width=161
int Height=74
boolean Enabled=false
string Text="Printer:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_copies from editmask within w_datawindow_print_dialog
int X=249
int Y=115
int Width=176
int Height=90
int TabOrder=20
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
string Mask="###"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_datawindow_print_dialog
int X=33
int Y=250
int Width=1130
int Height=515
string Text="Page Range"
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

