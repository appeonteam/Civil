$PBExportHeader$w_assign_copy.srw
forward
global type w_assign_copy from window
end type
type cb_1 from commandbutton within w_assign_copy
end type
type cb_copy from commandbutton within w_assign_copy
end type
type st_2 from statictext within w_assign_copy
end type
type st_1 from statictext within w_assign_copy
end type
type cb_cancel from commandbutton within w_assign_copy
end type
type ddlb_copyto from dropdownlistbox within w_assign_copy
end type
type ddlb_copyfrom from dropdownlistbox within w_assign_copy
end type
end forward

global type w_assign_copy from window
integer x = 1056
integer y = 892
integer width = 1637
integer height = 672
boolean titlebar = true
string title = "Copy Permisions"
long backcolor = 12632256
cb_1 cb_1
cb_copy cb_copy
st_2 st_2
st_1 st_1
cb_cancel cb_cancel
ddlb_copyto ddlb_copyto
ddlb_copyfrom ddlb_copyfrom
end type
global w_assign_copy w_assign_copy

type variables

end variables

event open;SetPointer(HourGlass!)

w_access_sheet.enabled = False

// Window Controls
cb_cancel.pointer="arrow!"
cb_copy.pointer="arrow!"

string	achtemp1, achTemp2, achTemp3

achTemp1 = "ssan"
achTemp2 = "user_id"
achTemp3 = "ut_personnel"

f_load_ddlb(ddlb_copyfrom, achTemp1, achTemp2, achTemp3, SQLCA)

achTemp1 = "ssan"
achTemp2 = "user_id"
achTemp3 = "ut_personnel"

f_load_ddlb(ddlb_copyto, achTemp1, achTemp2, achTemp3, SQLCA)
end event

on w_assign_copy.create
this.cb_1=create cb_1
this.cb_copy=create cb_copy
this.st_2=create st_2
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.ddlb_copyto=create ddlb_copyto
this.ddlb_copyfrom=create ddlb_copyfrom
this.Control[]={this.cb_1,&
this.cb_copy,&
this.st_2,&
this.st_1,&
this.cb_cancel,&
this.ddlb_copyto,&
this.ddlb_copyfrom}
end on

on w_assign_copy.destroy
destroy(this.cb_1)
destroy(this.cb_copy)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.ddlb_copyto)
destroy(this.ddlb_copyfrom)
end on

type cb_1 from commandbutton within w_assign_copy
integer x = 869
integer y = 452
integer width = 302
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

type cb_copy from commandbutton within w_assign_copy
event mousemove pbm_mousemove
integer x = 466
integer y = 412
integer width = 279
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Co&py"
end type

on mousemove;parent.SetMicroHelp("Copy Permissions to User.")
end on

event clicked;// script variables
integer s_iCode, s_iCount
string s_achErrText, s_achEmpNumFrom, s_achEmpNumTo
long s_lAssignedPermRows, s_lRowCount
datastore lds_AssignedPerms
string s_achPermSystemType

SetPointer(HourGlass!)

cb_cancel.enabled = False

s_achEmpNumFrom = Trim(Left(ddlb_copyfrom.text, Pos(ddlb_copyfrom.text, " ")))
s_achEmpNumTo = Trim(Left(ddlb_copyto.text, Pos(ddlb_copyto.text, " ")))

// get employee county paid fringe benefit records
// allocate the resources for the datastores
lds_AssignedPerms = Create DataStore
		
lds_AssignedPerms.DataObject = 'dw_assigned_ds'
lds_AssignedPerms.SetTransObject(SQLCA)

s_lAssignedPermRows = lds_AssignedPerms.Retrieve(s_achEmpNumFrom)
For s_lRowCount = 1 To s_lAssignedPermRows
			
	s_iCode = lds_AssignedPerms.GetItemNumber(s_lRowCount,"code")

	SELECT COUNT(*) INTO :s_iCount
		FROM ut_assigned_permissions
		WHERE ssan = :s_achEmpNumTo
		AND code = :s_iCode;
	If s_iCount = 0 Then	
	
		INSERT INTO ut_assigned_permissions
				(ssan, code)
			VALUES(:s_achEmpNumTo, :s_iCode);

	End If
Next
COMMIT;
If SQLCA.SQLCode = -1 Then
	s_achErrText = SQLCA.SQLErrText
	ROLLBACK;
	MessageBox("Error", "Update Failed - " + s_achErrText)
Else 
	MessageBox("Copy","Permissions Copied")
End If

ddlb_copyfrom.SelectItem(1)
ddlb_copyto.SelectItem(1)

cb_cancel.enabled = True

ddlb_copyfrom.SetFocus()

end event

type st_2 from statictext within w_assign_copy
integer x = 192
integer y = 252
integer width = 270
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Copy To:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_assign_copy
integer x = 114
integer y = 92
integer width = 347
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Copy From:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_assign_copy
event mousemove pbm_mousemove
integer x = 1221
integer y = 412
integer width = 279
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancel"
end type

on mousemove;parent.SetMicroHelp("Cancel Copy.")
end on

event clicked;
w_access_sheet.enabled = True
w_access_sheet.SetFocus()

close(parent)
end event

type ddlb_copyto from dropdownlistbox within w_assign_copy
integer x = 466
integer y = 240
integer width = 1033
integer height = 444
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_copyfrom from dropdownlistbox within w_assign_copy
integer x = 466
integer y = 80
integer width = 1033
integer height = 444
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

