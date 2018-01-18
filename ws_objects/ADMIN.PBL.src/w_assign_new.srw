$PBExportHeader$w_assign_new.srw
forward
global type w_assign_new from Window
end type
type dw_2 from datawindow within w_assign_new
end type
type st_2 from statictext within w_assign_new
end type
type st_1 from statictext within w_assign_new
end type
type dw_1 from datawindow within w_assign_new
end type
type cb_cancel from commandbutton within w_assign_new
end type
type cb_apply from commandbutton within w_assign_new
end type
type ddlb_permissions from dropdownlistbox within w_assign_new
end type
end forward

global type w_assign_new from Window
int X=347
int Y=499
int Width=3050
int Height=1466
boolean TitleBar=true
string Title="Assign Permissions to Multiple Users"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
dw_2 dw_2
st_2 st_2
st_1 st_1
dw_1 dw_1
cb_cancel cb_cancel
cb_apply cb_apply
ddlb_permissions ddlb_permissions
end type
global w_assign_new w_assign_new

type variables
string i_achSQL
integer i_irow, i_iCode
boolean i_bUpdateOccurred


end variables

event open;SetPointer(HourGlass!)

w_access_sheet.enabled = False

i_achSQL = dw_1.GetSQLSelect()
dw_1.SetTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)
string	achtemp1, achTemp2, achTemp3

achTemp1 = "code"
achTemp2 = "description"
achTemp3 = "ut_permissions"

f_load_perms_ddlb(ddlb_permissions, achTemp1, achTemp2, achTemp3, SQLCA)

dw_2.Retrieve()

// Window Controls
cb_apply.pointer="arrow!"
cb_cancel.pointer="arrow!"




end event

on w_assign_new.create
this.dw_2=create dw_2
this.st_2=create st_2
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_cancel=create cb_cancel
this.cb_apply=create cb_apply
this.ddlb_permissions=create ddlb_permissions
this.Control[]={this.dw_2,&
this.st_2,&
this.st_1,&
this.dw_1,&
this.cb_cancel,&
this.cb_apply,&
this.ddlb_permissions}
end on

on w_assign_new.destroy
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_apply)
destroy(this.ddlb_permissions)
end on

type dw_2 from datawindow within w_assign_new
int X=1971
int Y=125
int Width=984
int Height=1027
int TabOrder=20
string DataObject="dw_perm_personnel"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;integer s_irowchange
string s_achEmpNum

If row > 0 Then
	i_bUpdateOccurred = True
	s_achEmpNum = dw_2.GetItemString(row,"ssan")
	If dw_2.IsSelected(row) Then
		dw_2.SelectRow(row,False)
		s_irowchange = dw_1.Find("ssan = '" + s_achEmpNum + "'",1,i_irow)
		dw_1.DeleteRow(s_irowchange)
		i_irow = i_irow - 1
	Else
		dw_2.SelectRow(row,True)
		s_irowchange = dw_1.InsertRow(0)
		dw_1.SetItem(s_irowchange,"ssan",s_achEmpNum)
		dw_1.SetItem(s_irowchange,"code",i_iCode)
		i_irow = i_irow + 1
	End If
End If
end event

type st_2 from statictext within w_assign_new
int X=1975
int Y=48
int Width=406
int Height=74
boolean Enabled=false
string Text="Personnel"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_assign_new
int X=73
int Y=48
int Width=709
int Height=74
boolean Enabled=false
string Text="Selected Permission"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_assign_new
int X=59
int Y=317
int Width=1686
int Height=397
int TabOrder=30
boolean Visible=false
string DataObject="dw_assigned_scan"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

on sqlpreview;//messagebox("",this.getsqlpreview())
end on

type cb_cancel from commandbutton within w_assign_new
event mousemove pbm_mousemove
int X=2677
int Y=1210
int Width=278
int Height=109
int TabOrder=50
string Text="&Cancel"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event mousemove;w_main.SetMicroHelp("Cancel Assignments of Permissions.")
end event

event clicked;SetPointer(HourGlass!)

If i_bUpdateOccurred Then
	If 1 = MessageBox("Changes Pending","Do you want to save changes to permissions",Question!,YesNo!,2) Then
		cb_apply.TriggerEvent(Clicked!)
	End If
	i_bUpdateOccurred = False
End If

w_access_sheet.enabled = True
w_access_sheet.SetFocus()

close(parent)
end event

type cb_apply from commandbutton within w_assign_new
event mousemove pbm_mousemove
int X=73
int Y=1210
int Width=278
int Height=109
int TabOrder=40
string Text="&Apply"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event mousemove;w_main.SetMicroHelp("Apply Changes to Records.")
end event

on clicked;// script variables
string	s_achErrText

SetPointer(HourGlass!)

If dw_1.Update(True) = -1 Then
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
		i_bUpdateOccurred = False
	End If
End If


end on

type ddlb_permissions from dropdownlistbox within w_assign_new
int X=73
int Y=128
int Width=1821
int Height=1027
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event selectionchanged;string s_achSQL, s_achEmpNum
integer s_icount, s_iitem, s_iRcount
datawindowchild dwc

If i_bUpdateOccurred Then
	If 1 = MessageBox("Changes Pending","Do you want to save changes to permissions",Question!,YesNo!,2) Then
		cb_apply.TriggerEvent(Clicked!)
	End If
	i_bUpdateOccurred = False
End If

i_iCode = Long(Trim(Left(ddlb_permissions.text, Pos(ddlb_permissions.text, " "))))

If i_iCode = 0 Then
	// and didn't pick a permission
	s_achSQL = i_achSQL
Else
	// but did pick a permission
	s_achSQL = i_achSQL + " AND ~~~"ut_assigned_permissions~~~".~~~"code~~~" = " + String(i_iCode)
End If

dw_1.Modify("datawindow.table.select='" + s_achSQL + "'")

dw_1.Reset()
//
/*// get Personnel
dw_1.GetChild("emp_num", dwc)
dwc.SetTransObject(SQLCA)
dwc.Reset()
dwc.Retrieve()*/
//
i_irow = dw_1.Retrieve()
dw_2.SelectRow(0,False)
s_iRcount = dw_2.RowCount()
For s_icount = 1 To i_irow
	// find person in users list box and highlight their row
	s_achEmpNum = dw_1.GetItemString(s_icount,"ssan")
	s_iitem = dw_2.Find("ssan = '" + s_achEmpNum + "'",1,s_iRcount)
	If s_iitem > 0 Then dw_2.SelectRow(s_iitem,True)
Next


end event

