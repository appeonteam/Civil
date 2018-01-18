$PBExportHeader$civil.sra
forward
global type civil from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
string g_achVersion, g_achUserEmpNum, g_achUserID
date g_dtToday
integer g_iCurrYear, g_iheight, g_iwidth
boolean g_bDisbursed, g_bReceived


n_cst_resize gnv_resize
n_cst_dwsrv_resize gnv_dwresize

n_logservice i_log
end variables
global type civil from application
string appname = "civil"
boolean toolbartext = false
boolean toolbartips = true
boolean toolbarusercontrol = true
integer ddetimeout = 0
boolean righttoleft = false
boolean freedblibraries = false
end type
global civil civil

on civil.create
appname="civil"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on civil.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;g_achversion = "1.80     10/27/2008     11:00"

open(w_login)

i_log = create n_logservice
end event

event close;destroy i_log
end event

