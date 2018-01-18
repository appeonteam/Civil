$PBExportHeader$hikhinj.sra
$PBExportComments$Generated Application Object
forward
global type hikhinj from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type hikhinj from application
string appname = "hikhinj"
end type
global hikhinj hikhinj

on hikhinj.create
appname = "hikhinj"
message = create message
sqlca = create transaction
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on hikhinj.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

