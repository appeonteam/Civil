$PBExportHeader$ue_microhelp.sru
forward
global type ue_microhelp from UserObject
end type
type st_1 from statictext within ue_microhelp
end type
type ln_top_white from line within ue_microhelp
end type
type ln_top from line within ue_microhelp
end type
type ln_3 from line within ue_microhelp
end type
type ln_bottom_white from line within ue_microhelp
end type
type ln_right_upright from line within ue_microhelp
end type
end forward

global type ue_microhelp from UserObject
int Width=1477
int Height=93
long BackColor=12632256
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
st_1 st_1
ln_top_white ln_top_white
ln_top ln_top
ln_3 ln_3
ln_bottom_white ln_bottom_white
ln_right_upright ln_right_upright
end type
global ue_microhelp ue_microhelp

forward prototypes
public subroutine uof_set_width (long al_width)
public subroutine uof_set_text (string as_text)
public subroutine uof_set_height (long al_height)
public function string uof_get_text ()
end prototypes

public subroutine uof_set_width (long al_width);this.width = al_Width
ln_Top_White.EndX = al_Width + 20
ln_Bottom_White.EndX = al_Width  - 20
ln_Top.EndX = al_Width  - 20
ln_Right_Upright.BeginX = al_Width  - 20
ln_Right_Upright.EndX = al_Width  - 20
end subroutine

public subroutine uof_set_text (string as_text);If st_1.Text <> as_Text Then st_1.text = as_Text
end subroutine

public subroutine uof_set_height (long al_height);this.y = al_Height - 184

end subroutine

public function string uof_get_text ();Return(st_1.Text)
end function

on ue_microhelp.create
this.st_1=create st_1
this.ln_top_white=create ln_top_white
this.ln_top=create ln_top
this.ln_3=create ln_3
this.ln_bottom_white=create ln_bottom_white
this.ln_right_upright=create ln_right_upright
this.Control[]={ this.st_1,&
this.ln_top_white,&
this.ln_top,&
this.ln_3,&
this.ln_bottom_white,&
this.ln_right_upright}
end on

on ue_microhelp.destroy
destroy(this.st_1)
destroy(this.ln_top_white)
destroy(this.ln_top)
destroy(this.ln_3)
destroy(this.ln_bottom_white)
destroy(this.ln_right_upright)
end on

type st_1 from statictext within ue_microhelp
int X=23
int Y=17
int Width=1431
int Height=61
boolean Enabled=false
string Text="Ready"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ln_top_white from line within ue_microhelp
boolean Enabled=false
int EndX=2378
int LineThickness=5
long LineColor=16777215
end type

type ln_top from line within ue_microhelp
boolean Enabled=false
int BeginX=5
int BeginY=13
int EndX=1463
int EndY=13
int LineThickness=5
long LineColor=8421504
end type

type ln_3 from line within ue_microhelp
boolean Enabled=false
int BeginX=5
int BeginY=13
int EndX=5
int EndY=77
int LineThickness=5
long LineColor=8421504
end type

type ln_bottom_white from line within ue_microhelp
boolean Enabled=false
int BeginX=10
int BeginY=77
int EndX=1463
int EndY=77
int LineThickness=5
long LineColor=16777215
end type

type ln_right_upright from line within ue_microhelp
boolean Enabled=false
int BeginX=1459
int BeginY=13
int EndX=1459
int EndY=77
int LineThickness=5
long LineColor=16777215
end type

