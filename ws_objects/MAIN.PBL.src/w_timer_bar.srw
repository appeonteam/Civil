$PBExportHeader$w_timer_bar.srw
forward
global type w_timer_bar from Window
end type
type st_id from statictext within w_timer_bar
end type
type st_datetime from statictext within w_timer_bar
end type
type ln_1 from line within w_timer_bar
end type
type ln_2 from line within w_timer_bar
end type
type ln_3 from line within w_timer_bar
end type
type ln_4 from line within w_timer_bar
end type
type ln_5 from line within w_timer_bar
end type
type ln_6 from line within w_timer_bar
end type
type ln_7 from line within w_timer_bar
end type
type ln_8 from line within w_timer_bar
end type
type ln_9 from line within w_timer_bar
end type
type ln_10 from line within w_timer_bar
end type
type ln_11 from line within w_timer_bar
end type
end forward

global type w_timer_bar from Window
int X=673
int Y=265
int Width=1207
int Height=73
boolean Visible=false
boolean Enabled=false
long BackColor=12632256
boolean Border=false
WindowType WindowType=popup!
st_id st_id
st_datetime st_datetime
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
ln_5 ln_5
ln_6 ln_6
ln_7 ln_7
ln_8 ln_8
ln_9 ln_9
ln_10 ln_10
ln_11 ln_11
end type
global w_timer_bar w_timer_bar

forward prototypes
public subroutine wf_pos_timer (integer owner_height, integer owner_width, integer owner_x, integer owner_y)
end prototypes

public subroutine wf_pos_timer (integer owner_height, integer owner_width, integer owner_x, integer owner_y);If owner_height > 0 Then

	this.x = owner_x + owner_width - this.width - 10
	this.y = owner_y + owner_height - this.height - 7
	this.visible = True

Else

	this.visible = False

End If
end subroutine

on open;//Timer(1)
//st_id.text = g_achuserssan
st_id.text = g_achuserid
st_datetime.text = String(Today(), "mmmm d,yyyy") + " " + String(Now(), "h:mm:ss")

end on

on timer;st_datetime.text = String(Today(), "mmmm d,yyyy") + " " + String(Now(), "h:mm:ss")
end on

on close;Timer(0)
end on

on w_timer_bar.create
this.st_id=create st_id
this.st_datetime=create st_datetime
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
this.ln_5=create ln_5
this.ln_6=create ln_6
this.ln_7=create ln_7
this.ln_8=create ln_8
this.ln_9=create ln_9
this.ln_10=create ln_10
this.ln_11=create ln_11
this.Control[]={ this.st_id,&
this.st_datetime,&
this.ln_1,&
this.ln_2,&
this.ln_3,&
this.ln_4,&
this.ln_5,&
this.ln_6,&
this.ln_7,&
this.ln_8,&
this.ln_9,&
this.ln_10,&
this.ln_11}
end on

on w_timer_bar.destroy
destroy(this.st_id)
destroy(this.st_datetime)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
destroy(this.ln_5)
destroy(this.ln_6)
destroy(this.ln_7)
destroy(this.ln_8)
destroy(this.ln_9)
destroy(this.ln_10)
destroy(this.ln_11)
end on

type st_id from statictext within w_timer_bar
int X=138
int Y=9
int Width=471
int Height=57
boolean Enabled=false
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type st_datetime from statictext within w_timer_bar
int X=636
int Y=9
int Width=545
int Height=57
boolean Enabled=false
string Text="none"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type ln_1 from line within w_timer_bar
boolean Enabled=false
int BeginX=129
int BeginY=5
int EndX=609
int EndY=5
int LineThickness=5
long LineColor=8421504
end type

type ln_2 from line within w_timer_bar
boolean Enabled=false
int BeginX=622
int BeginY=65
int EndX=1198
int EndY=65
int LineThickness=5
long LineColor=16777215
end type

type ln_3 from line within w_timer_bar
boolean Enabled=false
int BeginX=124
int BeginY=65
int EndX=609
int EndY=65
int LineThickness=5
long LineColor=16777215
end type

type ln_4 from line within w_timer_bar
boolean Enabled=false
int BeginX=1194
int BeginY=65
int EndX=1194
int EndY=5
int LineThickness=5
long LineColor=16777215
end type

type ln_5 from line within w_timer_bar
boolean Enabled=false
int BeginX=622
int BeginY=65
int EndX=622
int LineThickness=5
long LineColor=8421504
end type

type ln_6 from line within w_timer_bar
boolean Enabled=false
int BeginX=609
int BeginY=65
int EndX=609
int LineThickness=5
long LineColor=16777215
end type

type ln_7 from line within w_timer_bar
boolean Enabled=false
int BeginX=622
int BeginY=5
int EndX=1194
int EndY=5
int LineThickness=5
long LineColor=8421504
end type

type ln_8 from line within w_timer_bar
boolean Enabled=false
int BeginX=124
int BeginY=65
int EndX=124
int LineThickness=5
long LineColor=8421504
end type

type ln_9 from line within w_timer_bar
boolean Enabled=false
int BeginX=110
int BeginY=61
int EndX=110
int EndY=5
int LineThickness=5
long LineColor=16777215
end type

type ln_10 from line within w_timer_bar
boolean Enabled=false
int BeginX=5
int BeginY=5
int EndX=110
int EndY=5
int LineThickness=5
long LineColor=8421504
end type

type ln_11 from line within w_timer_bar
boolean Enabled=false
int BeginX=5
int BeginY=65
int EndX=115
int EndY=65
int LineThickness=5
long LineColor=16777215
end type

