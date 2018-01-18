$PBExportHeader$w_banner.srw
forward
global type w_banner from Window
end type
type st_4 from statictext within w_banner
end type
type st_3 from statictext within w_banner
end type
type st_2 from statictext within w_banner
end type
end forward

global type w_banner from Window
int X=1009
int Y=966
int Width=1730
int Height=531
long BackColor=12632256
WindowType WindowType=response!
event ue_open_main pbm_custom01
st_4 st_4
st_3 st_3
st_2 st_2
end type
global w_banner w_banner

event ue_open_main;open(w_main)
end event

event open;//st_1.text = g_achAppName
st_2.text = "Version " + g_achVersion

PostEvent("ue_open_main")
end event

on w_banner.create
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.Control[]={this.st_4,&
this.st_3,&
this.st_2}
end on

on w_banner.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
end on

type st_4 from statictext within w_banner
int X=88
int Y=179
int Width=1496
int Height=74
boolean Enabled=false
string Text="Civil System"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_banner
int X=88
int Y=102
int Width=1496
int Height=74
boolean Enabled=false
string Text="Cerro Gordo County"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_banner
int X=88
int Y=307
int Width=1496
int Height=74
boolean Enabled=false
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

