$PBExportHeader$uo_claim_dw.sru
$PBExportComments$User Object to store common functionality of the datawindows on the claim form.
forward
global type uo_claim_dw from datawindow
end type
end forward

global type uo_claim_dw from datawindow
int Y=397
int Width=522
int Height=381
int TabOrder=20
boolean LiveScroll=true
event ue_display_on pbm_custom01
event ue_enterastab pbm_dwnprocessenter
event ue_keydown pbm_dwnkey
end type
global uo_claim_dw uo_claim_dw

type variables
boolean	uob_ScrollTo
integer	uoii_OrigHeight, uoii_OrigWidth
integer	uoii_OrigX, uoii_OrigY

end variables

forward prototypes
public subroutine uof_scroll_win ()
public subroutine uof_set_edit_limits ()
end prototypes

event ue_enterastab;// THIS CODE MAKES THE SYSTEM THINK THE USER HIT TAB WHEN THEY HIT ENTER
Send(Handle(this),256,9,Long(0,0))
Return(1) 
end event

public subroutine uof_scroll_win ();// setting tag so we know this is scrolling
this.tag = "scroll"

// script variables
integer	li_difference, li_last, li_Mark
integer	li_LRPageStep = -150, li_UDPageStep = 80
integer	li_BottomBorder = 175, li_RightBorder = 115	// constants
window	lw_parent	// reference to parent window, to call scrolling functions

// get a reference to the claim window this datawindow is on
lw_Parent = Parent

// make sure the window is still open
If Not(IsValid(lw_Parent)) Then Return

If lw_Parent.WindowState = Minimized! Then Return

// make sure the datawindow is redrawing, otherwise X and Y might not move
this.SetRedraw(True)

// DO LEFT AND RIGHT SCROLLING
// If the left edge of the datawindow is off the left edge of the window
// then we have to scroll the window to the left to bring it back on the screen
If this.x < 1 Then
	Do
		If Abs(this.x) > Abs(li_LRPageStep) Then
			gf_scroll_win_left_page(lw_Parent)
		Else
			gf_scroll_win_left(lw_Parent)
		End If
		// this yield allows the window to redraw, changing the X coordinate of the dw
		// allowing a correct test for when we're done scrolling
		Yield()
		// make sure the window is still open
		If Not(IsValid(lw_Parent)) Then Return
		
	Loop Until this.x > 0
Else
	// check if the right edge of the datawindow is off the right side of the window
	// we only want to do this if we didn't scroll left to pull the left edge on the screen
	li_Mark = this.x + this.Width + li_RightBorder
	li_Difference = lw_Parent.Width - li_Mark
	Do While li_Difference < 0
		If (Abs(li_Difference) > Abs(li_LRPageStep)) AND (this.x > Abs(li_LRPageStep)) Then
			gf_scroll_win_right_page(lw_Parent)
		Else
			If this.x < 10 Then exit
			gf_scroll_win_right(lw_Parent)
		End If
		Yield()
		// make sure the window is still open
		If Not(IsValid(lw_Parent)) Then Return

		// storing the last difference to make sure the scrolls are actually scrolling
		// had some problems with different resolutions and screen sizes that the window
		// size wasn't big enough to hold all of the datawindows.  To go to the footer it 
		// would say, "I need to scroll down", send the scroll down message, didn't move 
		// because it was at the bottom of the scrollable area.
		li_Last = li_Difference
		li_Mark = this.x + this.Width + li_RightBorder
		li_Difference = lw_Parent.Width - li_Mark

		If li_Last = li_Difference Then
			// it thinks it needs to scroll more, but the scroll didn't move it any
			// make sure the window is wide enough, and let it try to scroll again
			If lw_Parent.Width >= li_Mark + 5 Then
				// there shouldn't be a problem, why isn't it working???
				Exit
			Else
				lw_Parent.Width = li_Mark + 5
			End If
		End If
	Loop
End If 

// DO UP AND DOWN SCROLLING
// If the top edge of the datawindow is off the top of the window
// then we have to scroll the window up to bring it back on the screen
If this.y < 1 Then
	Do
		If Abs(this.y) > Abs(li_UDPageStep) Then
			gf_scroll_win_up_page(lw_Parent)
		Else
			gf_scroll_win_up(lw_Parent)
		End If
		// this yield allows the window to redraw, changing the Y coordinate of the dw
		// allowing a correct test for when we're done scrolling
		Yield()
		// make sure the window is still open
		If Not(IsValid(lw_Parent)) Then Return
		
	Loop Until this.y > 0
Else
	// check if the bottom edge of the datawindow is off the bottom of the window
	// we only want to do this if we didn't scroll up to pull the top edge on the screen
	li_Mark = this.y + this.height + li_BottomBorder
	li_Difference = lw_Parent.Height - li_Mark
	Do While li_Difference < 0
		If (Abs(li_Difference) > Abs(li_UDPageStep)) AND (this.y > Abs(li_UDPageStep)) Then
			gf_scroll_win_down_page(lw_Parent)
		Else
			If this.y < 10 Then exit
			gf_scroll_win_down(lw_Parent)
		End If
		Yield()
		// make sure the window is still open
		If Not(IsValid(lw_Parent)) Then Return

		// storing the last difference to make sure the scrolls are actually scrolling
		// had some problems with different resolutions and screen sizes that the window
		// size wasn't big enough to hold all of the datawindows.  To go to the footer it 
		// would say, "I need to scroll down", send the scroll down message, didn't move 
		// because it was at the bottom of the scrollable area.
		li_Last = li_Difference
		li_Mark = this.y + this.height + li_BottomBorder
		li_Difference = lw_Parent.Height - li_Mark

		If li_Last = li_Difference Then
			// it thinks it needs to scroll more, but the scroll didn't move it any
			// make sure the window is wide enough, and let it try to scroll again
			If lw_Parent.Height >= li_Mark + 5 Then
				// there shouldn't be a problem, why isn't it working???
				Exit
			Else
				lw_Parent.Height = li_Mark + 5
			End If
		End If
	Loop
End If 

// turn scroll tag off
this.tag = ""

end subroutine

public subroutine uof_set_edit_limits ();// script variables
long	ll_ColCount, ll_Count, ll_Limit
string	ls_Return

ll_ColCount = Long(this.Describe("DataWindow.Column.Count"))

For ll_Count = 1 To ll_ColCount
	ll_Limit = Long(this.Describe("#" + String(ll_Count) + ".edit.limit"))
	If ll_Limit > 0 Then 
		ls_Return = this.Modify("#" + String(ll_Count) + ".edit.limit="+String(ll_Limit))
	End If
Next


end subroutine

event losefocus;AcceptText()
end event

event constructor;uoii_OrigHeight = this.Height
uoii_OrigWidth = this.Width
uoii_OrigX = this.X
uoii_OrigY = this.Y
uob_ScrollTo = True

SetTransObject(SQLCA)



end event

event getfocus;If uob_ScrollTo Then uof_scroll_win()
PostEvent(ItemFocusChanged!)



end event

event clicked;SetFocus()
end event

