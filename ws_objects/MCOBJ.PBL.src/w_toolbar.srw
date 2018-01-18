$PBExportHeader$w_toolbar.srw
forward
global type w_toolbar from Window
end type
type gb_1 from groupbox within w_toolbar
end type
type cbx_text from checkbox within w_toolbar
end type
type rb_left from radiobutton within w_toolbar
end type
type rb_right from radiobutton within w_toolbar
end type
type rb_top from radiobutton within w_toolbar
end type
type rb_bottom from radiobutton within w_toolbar
end type
type rb_float from radiobutton within w_toolbar
end type
type cbx_visible from checkbox within w_toolbar
end type
type cbx_tips from checkbox within w_toolbar
end type
type p_1 from picture within w_toolbar
end type
type cb_cancel from commandbutton within w_toolbar
end type
type cb_apply from commandbutton within w_toolbar
end type
type cb_ok from commandbutton within w_toolbar
end type
end forward

global type w_toolbar from Window
int X=1
int Y=1
int Width=1814
int Height=711
boolean TitleBar=true
string Title="Toolbar Options"
long BackColor=12632256
gb_1 gb_1
cbx_text cbx_text
rb_left rb_left
rb_right rb_right
rb_top rb_top
rb_bottom rb_bottom
rb_float rb_float
cbx_visible cbx_visible
cbx_tips cbx_tips
p_1 p_1
cb_cancel cb_cancel
cb_apply cb_apply
cb_ok cb_ok
end type
global w_toolbar w_toolbar

forward prototypes
public subroutine wf_save ()
end prototypes

public subroutine wf_save ();SetPointer(HourGlass!)

// set checkboxes
//w_terminal.ToolbarVisible = cbx_visible.checked
If cbx_visible.checked Then
	//SetProfileString(gs_ConfigFile, gs_Secret, "Toolbar", "Y")
Else
	//SetProfileString(gs_ConfigFile, gs_Secret, "Toolbar", "N")
End If

//prosyspc.ToolbazD@p/¯€7”ä€$€HÆ@	?þ@? x`0	À‡âñÀFCàpÇ„x9hâ@™Ð„D=nŒ DÛaƒ¿2M¼Œc€8ÄüÈ$Ì'	€@‡ @€x@!àofileString(gs_ConfigFile, gs_Secret, "ToolbarText", "N")
//End If

//prosyspc.ToolbarTips = cbx_tips.checked
If cbx_tips.checked Then
	//SetProfileString(gs_ConfigFile, gs_Secret, "ToolbarTips", "Y")
Else
	//SetProfileString(gs_ConfigFile, gs_Secret, "ToolbarTips", "N")
End If

// set radio buttons
If rb_bottom.checked = True Then
	//w_terminal.ToolbarAlignment = AlignAtBottom!
	//SetProfileString(gs_ConfigFile, gs_Secret, "ToolbarAlignment", "AlignAtBottom!")
ElseIf rb_top.checked = True Then
	//w_terminal.ToolbarAlignment = AlignAtTop!
	//SetProfileString(gs_ConfigFile, gs_Secret, "ToolbarAlignment", "AlignAtTop!")
ElseIf rb_left.checked = True Then
	//w_terminal.ToolbarAlignment = AlignAtLeft!
	//SetProfileString(gs_ConfigFile, gs_Secret, "ToolbarAlignment", "AlignAtLeft!")
ElseIf rb_right.checked = True Then
	//w_terminal.ToolbarAlignment = AlignAtRight!
//	SetProfileString(gs_ConfigFile, gs_Secret, "ToolbarAlignment", "AlignAtRight!")
ElseIf rb_float.checked = True Then
	//w_terminal.ToolbarAlignment = Floating!
	//SetProfileString(gs_ConfigFile, gs_Secret, "ToolbarAlignment", "Floating!")
End If

cb_ok.enabled = False
cb_apply.enabled = False
cb_cancel.enabled = False

end subroutine

event ue_ok;SetPointer(HourGlass!)

wf_save()
Close(this)
	

end event

event open;SetPointer(HourGlass!)

// set checkboxes
//cbx_visible.checked = w_terminal.ToolbarVisible
//cbx_text.checked = prosyspc.ToolbarText
//cbx_tips.checked = prosyspc.ToolbarTips

// set radio buttons
//Choose Case w_terminal.ToolbarAlignment
//	Case AlignAtBottom!
//		rb_bottom.checked = True
//	Case AlignAtLeft!
//		rb_left.checked = True
//	Case AlignAtRight!
//		rb_right.checked = True
//	Case AlignAtTop!
//		rb_top.checked = True
//	Case Floating!
//		rb_float.checked = True
//End Choose

// trigger the save so if they changed stuff with the right mouse button
// the changes will be written to the file

/*
wf_save()

cbx_visible.SetFocus()
*/
end event

on ue_cancel;this.PostEvent(Open!)
end on

on w_toolbar.create
this.gb_1=create gb_1
this.cbx_text=create cbx_text
this.rb_left=create rb_left
this.rb_right=create rb_right
this.rb_top=create rb_top
this.rb_bottom=create rb_bottom
this.rb_float=create rb_float
this.cbx_visible=create cbx_visible
this.cbx_tips=create cbx_tips
this.p_1=create p_1
this.cb_cancel=create cb_cancel
this.cb_apply=create cb_apply
this.cb_ok=create cb_ok
this.Control[]={ this.gb_1,&
this.cbx_text,&
this.rb_left,&
this.rb_right,&
this.rb_top,&
this.rb_bottom,&
this.rb_float,&
this.cbx_visible,&
this.cbx_tips,&
this.p_1,&
this.cb_cancel,&
this.cb_apply,&
this.cb_ok}
end on

on w_toolbar.destroy
destroy(this.gb_1)
destroy(this.cbx_text)
destroy(this.rb_left)
destroy(this.rb_right)
destroy(this.rb_top)
destroy(this.rb_bottom)
destroy(this.rb_float)
destroy(this.cbx_visible)
destroy(this.cbx_tips)
destroy(this.p_1)
destroy(this.cb_cancel)
destroy(this.cb_apply)
destroy(this.cb_ok)
end on

type gb_1 from groupbox within w_toolbar
int X=114
int Y=212
int Width=1057
int Height=337
int TabOrder=40
string Text="Alignment"
BorderStyle BorderStyle=StyleRaised!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type cbx_text from checkbox within w_toolbar
int X=822
int Y=93
int Width=345
int Height=71
int TabOrder=30
boolean BringToTop=true
string Text="&Show Text"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

on clicked;cb_ok.enabled = True
cb_apply.enabled = True
cb_cancel.enabled = True
end on

type rb_left from radiobutton within w_toolbar
int X=185
int Y=269
int Width=260
int Height=71
boolean BringToTop=true
string Text="&Left"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

on clicked;cb_ok.enabled = True
cb_apply.enabled = True
cb_cancel.enabled = True
end on

type rb_right from radiobutton within w_toolbar
int X=185
int Y=356
int Width=260
int Height=71
boolean BringToTop=true
string Text="&Right"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

on clicked;cb_ok.enabled = True
cb_apply.enabled = True
cb_cancel.enabled = True
end on

type rb_top from radiobutton within w_toolbar
int X=737
int Y=269
int Width=260
int Height=71
boolean BringToTop=true
string Text="&Top"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

on clicked;cb_ok.enabled = True
cb_apply.enabled = True
cb_cancel.enabled = True
end on

type rb_bottom from radiobutton within w_toolbar
int X=737
int Y=356
int Width=281
int Height=71
boolean BringToTop=true
string Text="&Bottom"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

on clicked;cb_ok.enabled = True
cb_apply.enabled = True
cb_cancel.enabled = True
end on

type rb_float from radiobutton within w_toolbar
int X=185
int Y=445
int Width=306
int Height=71
boolean BringToTop=true
string Text="&Floating"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

on clicked;cb_ok.enabled = True
cb_apply.enabled = True
cb_cancel.enabled = True
end on

type cbx_visible from checkbox within w_toolbar
int X=114
int Y=93
int Width=281
int Height=71
int TabOrder=10
boolean BringToTop=true
string Text="&Visible"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

on clicked;cb_ok.enabled = True
cb_apply.enabled = True
cb_cancel.enabled = True
end on

type cbx_tips from checkbox within w_toolbar
int X=427
int Y=93
int Width=345
int Height=71
int TabOrder=20
boolean BringToTop=true
string Text="&Show Tips"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

on clicked;cb_ok.enabled = True
cb_apply.enabled = True
cb_cancel.enabled = True
end on

type p_1 from picture within w_toolbar
int X=1369
int Y=36
int Width=321
int Height=215
boolean BringToTop=true
string PictureName="logo_col.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

type cb_cancel from commandbutton within w_toolbar
int X=1330
int Y=455
int Width=395
int Height=84
int TabOrder=70
string Text="&Cancel"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_apply from commandbutton within w_toolbar
int X=1330
int Y=369
int Width=395
int Height=84
int TabOrder=60
string Text="&Apply"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ok from commandbutton within w_toolbar
int X=1330
int Y=279
int Width=395
int Height=84
int TabOrder=50
string Text="&OK"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event cb_ok::clicked;// NOTE - Stuck this code in here because the inherited code was not working
// 		 properly. DGR - 3/26/96
SetPointer(HourGlass!)

Parent.PostEvent("ue_ok")
end event

