$PBExportHeader$w_base_detail.srw
$PBExportComments$Ancestor window
forward
global type w_base_detail from Window
end type
type cb_close from commandbutton within w_base_detail
end type
type cb_apply from commandbutton within w_base_detail
end type
type dw_detail from datawindow within w_base_detail
end type
end forward

global type w_base_detail from Window
int X=417
int Y=385
int Width=2085
int Height=1157
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean MinBox=true
event doupdate pbm_custom10
event disablescan pbm_custom11
event enablescan pbm_custom12
cb_close cb_close
cb_apply cb_apply
dw_detail dw_detail
end type
global w_base_detail w_base_detail

type variables
boolean  i_bUpdateOccurred, i_closefirst
w_timer_bar w_timer
end variables

on doupdate;// script variables
string	s_achErrText

SetPointer(HourGlass!)

If dw_detail.Update(True) = -1 Then
	s_achErrText = SQLCA.SQLErrText
	ROLLBACK;
	MessageBox("Error", "Update Failed - " + s_achErrText)
Else
	COMMIT;
	If SQLCA.SQLCode = -1 Then
		s_achErrText = SQLCA.SQLErrText
		ROLLBACK;
		MessageBox("Error", "Update Failed - " + s_achErrText)
	Else
		i_bUpdateOccurred = True
	End If
End If
i_closefirst = False
cb_close.PostEvent(Clicked!)	

end on

on w_base_detail.create
this.cb_close=create cb_close
this.cb_apply=create cb_apply
this.dw_detail=create dw_detail
this.Control[]={ this.cb_close,&
this.cb_apply,&
this.dw_detail}
end on

on w_base_detail.destroy
destroy(this.cb_close)
destroy(this.cb_apply)
destroy(this.dw_detail)
end on

type cb_close from commandbutton within w_base_detail
int X=1628
int Y=881
int Width=247
int Height=109
int TabOrder=30
string Text="&Close"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If i_closefirst Then
   If i_bupdateoccurred Then
      If 1 = MessageBox("Changes Made","Do you want to save changes",Question!,YesNo!,2) Then
         cb_apply.TriggerEvent(Clicked!)
		Else
			i_bupdateoccurred = False
		End If
	End If
End If

Parent.TriggerEvent("enablescan")
Close(Parent)
end on

type cb_apply from commandbutton within w_base_detail
int X=147
int Y=881
int Width=247
int Height=109
int TabOrder=20
string Text="&Apply"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_detail from datawindow within w_base_detail
int X=37
int Y=33
int Width=1994
int Height=769
int TabOrder=10
boolean LiveScroll=true
end type

on itemchanged;i_bupdateoccurred = True
end on

