$PBExportHeader$n_logservice.sru
forward
global type n_logservice from nonvisualobject
end type
end forward

global type n_logservice from nonvisualobject
end type
global n_logservice n_logservice

type variables

string  is_LogFile="C:\debug\logservice.log"
string  is_workdir="C:\debug\"
string   is_ErrorFile="C:\debug\logservice_error.log"
//LOG LEVEL
CONSTANT  int CI_LEVEL_INFO=1
CONSTANT  int CI_LEVEL_WARNING=2
CONSTANT  int CI_LEVEL_ERROR=3

String is_loglevel[]={"INFO","WARNING","ERROR"}
long     il_LogFileHandle
int      ii_LogLevel = CI_LEVEL_WARNING

end variables

forward prototypes
public function integer of_log_error (string as_message)
public function integer of_log (string as_message)
public function integer of_log_warning (string as_message)
public function integer of_log (integer ai_loglevel, string as_message)
public function integer of_setloglevel (integer ai_level)
public function integer of_log_success ()
end prototypes

public function integer of_log_error (string as_message);//////////////////////////////////////////////////////////////////////
// $<function>of_log_error()
// $<arguments>
//		value	string	as_message		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.09.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
long   ll_ErrorFile
String  ls_Error


return of_log( CI_LEVEL_ERROR, as_message+"~r~n")
end function

public function integer of_log (string as_message);//////////////////////////////////////////////////////////////////////
// $<function>of_log()
// $<arguments>
//		value	string	as_message		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.09.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

return of_log( CI_LEVEL_INFO, as_message)
end function

public function integer of_log_warning (string as_message);//////////////////////////////////////////////////////////////////////
// $<function>of_log_warning()
// $<arguments>
//		value	string	as_message		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.09.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

return of_log( CI_LEVEL_WARNING, as_message)
end function

public function integer of_log (integer ai_loglevel, string as_message);//////////////////////////////////////////////////////////////////////
// $<function>of_log_error()
// $<arguments>
//		value	string	as_message		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.09.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

//IF ai_loglevel < ii_LogLevel THEN
//	return 1
//END IF

IF FileExists(is_LogFile) THEN
	IF FileLength(is_LogFile) > 2097152 THEN//2M
		FileClose(il_logfilehandle)
		FileCopy(is_LogFile,is_LogFile+".bak",true)
		FileDelete(is_LogFile)
		
		il_LogFileHandle = FileOpen(is_LogFile,StreamMode!,write!,shared!,append!)
	END IF
END IF

as_message = "~r~n"+string(now(),"yyyy-mm-dd hh:mm:ss.fff")+" ["+upper(is_loglevel[ai_LogLevel])+"] "+as_message

FileWrite(il_logfilehandle,as_message)

return 1
end function

public function integer of_setloglevel (integer ai_level);ii_loglevel = ai_level

return 1
end function

public function integer of_log_success ();//////////////////////////////////////////////////////////////////////
// $<function>of_log_error()
// $<arguments>
//		value	string	as_message		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.09.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
long   ll_ErrorFile

try
	ll_ErrorFile = FileOpen(is_ErrorFile ,StreamMode!,write!,lockwrite!,replace!) 
	FileWrite(ll_ErrorFile,"OK")
	FileClose(ll_ErrorFile)
catch(exception e)
end try
return 1
end function

event constructor;IF NOT directoryexists(is_workdir) THEN
	createdirectory(is_workdir)
END IF



il_LogFileHandle = FileOpen(is_LogFile,StreamMode!,write!,shared!,append!)
FileWrite(il_LogFileHandle,"~r~n~r~n")
of_log("==========Log service initialized=========")

FileDelete(is_ErrorFile)



end event

on n_logservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_logservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;of_log("===========Log service finalized=========~r~n")
FileClose(il_LogFileHandle)
end event

