$PBExportHeader$w_base_tabs.srw
forward
global type w_base_tabs from Window
end type
type cb_apply from commandbutton within w_base_tabs
end type
type cb_cancel from commandbutton within w_base_tabs
end type
type cb_ok from commandbutton within w_base_tabs
end type
type tab_1 from tab within w_base_tabs
end type
type tabpage_tabs from userobject within tab_1
end type
type tabpage_tabs from userobject within tab_1
end type
type tab_1 from tab within w_base_tabs
tabpage_tabs tabpage_tabs
end type
end forward

global type w_base_tabs from Window
int X=673
int Y=265
int Width=1582
int Height=1213
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_apply cb_apply
cb_cancel cb_cancel
cb_ok cb_ok
tab_1 tab_1
end type
global w_base_tabs w_base_tabs

event open;SetPointer(HourGlass!)

w_main.enabled = False

this.PostEvent("opentimer")

end event

on w_base_tabs.create
this.cb_apply=create cb_apply
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.tab_1=create tab_1
this.Control[]={ this.cb_apply,&
this.cb_cancel,&
this.cb_ok,&
this.tab_1}
end on

on w_base_tabs.destroy
destroy(this.cb_apply)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.tab_1)
end on

type cb_apply from commandbutton within w_base_tabs
int X=855
int Y=929
int Width=385
int Height=109
int TabOrder=20
string Text="&Apply"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_base_tabs
int X=444
int Y=929
int Width=385
int Height=109
int TabOrder=10
string Text="&Cancel"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ok from commandbutton within w_base_tabs
int X=33
int Y=929
int Width=385
int Height=109
int TabOrder=40
string Text="&OK"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;w_main.enabled = True
w_main.SetFocus()

Close(Parent)
end event

type tab_1 from tab within w_base_tabs
int X=37
int Y=37
int Width=1459
int Height=865
int TabOrder=30
boolean RaggedRight=true
int SelectedTab=1
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_tabs tabpage_tabs
end type

on tab_1.create
this.tabpage_tabs=create tabpage_tabs
this.Control[]={ this.tabpage_tabs}
end on

on tab_1.destroy
destroy(this.tabpage_tabs)
end on

type tabpage_tabs from userobject within tab_1
int X=19
int Y=113
int Width=1422
int Height=737
long BackColor=79741120
string Text="none"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
end type

