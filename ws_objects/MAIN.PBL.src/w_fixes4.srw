$PBExportHeader$w_fixes4.srw
forward
global type w_fixes4 from w_base_no_criteria_scan
end type
type cb_generate from commandbutton within w_fixes4
end type
type st_message from statictext within w_fixes4
end type
type cb_create_collection_ledgers from commandbutton within w_fixes4
end type
type cb_create_holding_ledgers from commandbutton within w_fixes4
end type
type cb_create_de_disbursements from commandbutton within w_fixes4
end type
type cb_create_ledgers from commandbutton within w_fixes4
end type
type cb_set_fee_balances from commandbutton within w_fixes4
end type
type cb_import_outstanding_checks from commandbutton within w_fixes4
end type
type cb_set_misc_fee_balances from commandbutton within w_fixes4
end type
type cb_set_military_times from commandbutton within w_fixes4
end type
end forward

global type w_fixes4 from w_base_no_criteria_scan
int Width=3741
int Height=2182
boolean TitleBar=true
string Title="Fixes4"
boolean ControlMenu=true
boolean MinBox=false
boolean MaxBox=true
boolean Resizable=true
cb_generate cb_generate
st_message st_message
cb_create_collection_ledgers cb_create_collection_ledgers
cb_create_holding_ledgers cb_create_holding_ledgers
cb_create_de_disbursements cb_create_de_disbursements
cb_create_ledgers cb_create_ledgers
cb_set_fee_balances cb_set_fee_balances
cb_import_outstanding_checks cb_import_outstanding_checks
cb_set_misc_fee_balances cb_set_misc_fee_balances
cb_set_military_times cb_set_military_times
end type
global w_fixes4 w_fixes4

type variables
string i_achreport, i_achSQL
end variables

on w_fixes4.create
int iCurrent
call super::create
this.cb_generate=create cb_generate
this.st_message=create st_message
this.cb_create_collection_ledgers=create cb_create_collection_ledgers
this.cb_create_holding_ledgers=create cb_create_holding_ledgers
this.cb_create_de_disbursements=create cb_create_de_disbursements
this.cb_create_ledgers=create cb_create_ledgers
this.cb_set_fee_balances=create cb_set_fee_balances
this.cb_import_outstanding_checks=create cb_import_outstanding_checks
this.cb_set_misc_fee_balances=create cb_set_misc_fee_balances
this.cb_set_military_times=create cb_set_military_times
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_generate
this.Control[iCurrent+2]=this.st_message
this.Control[iCurrent+3]=this.cb_create_collection_ledgers
this.Control[iCurrent+4]=this.cb_create_holding_ledgers
this.Control[iCurrent+5]=this.cb_create_de_disbursements
this.Control[iCurrent+6]=this.cb_create_ledgers
this.Control[iCurrent+7]=this.cb_set_fee_balances
this.Control[iCurrent+8]=this.cb_import_outstanding_checks
this.Control[iCurrent+9]=this.cb_set_misc_fee_balances
this.Control[iCurrent+10]=this.cb_set_military_times
end on

on w_fixes4.destroy
call super::destroy
destroy(this.cb_generate)
destroy(this.st_message)
destroy(this.cb_create_collection_ledgers)
destroy(this.cb_create_holding_ledgers)
destroy(this.cb_create_de_disbursements)
destroy(this.cb_create_ledgers)
destroy(this.cb_set_fee_balances)
destroy(this.cb_import_outstanding_checks)
destroy(this.cb_set_misc_fee_balances)
destroy(this.cb_set_military_times)
end on

event open;SetPointer(HourGlass!)

this.x = 10
this.y = 10

this.Width = dw_scan.width + dw_scan.x + 200
this.Height = dw_scan.Height + 1100

cb_generate.SetFocus()

end event

event addclicked;// Override ancestor script
end event

event deleteclicked;// Override ancestor script
end event

event opentimer;// Override ancestor script
end event

event updateclicked;// Override ancestor script
end event

event viewclicked;// Override ancestor script
end event

type cb_view from w_base_no_criteria_scan`cb_view within w_fixes4
int TabOrder=0
boolean Visible=false
end type

type cb_print from w_base_no_criteria_scan`cb_print within w_fixes4
int X=3324
int Y=166
int Width=315
int Height=96
int TabOrder=20
int TextSize=-9
end type

type cb_update from w_base_no_criteria_scan`cb_update within w_fixes4
int TabOrder=0
boolean Visible=false
end type

type dw_scan from w_base_no_criteria_scan`dw_scan within w_fixes4
int X=925
int Y=746
int Width=2684
int Height=909
int TabOrder=0
string DataObject="dw_cash_disburse_scan"
boolean HScrollBar=true
end type

event dw_scan::doubleclicked;// Override
end event

type cb_exit from w_base_no_criteria_scan`cb_exit within w_fixes4
int X=3324
int Y=298
int Width=315
int Height=96
int TabOrder=30
int TextSize=-9
end type

type cb_delete from w_base_no_criteria_scan`cb_delete within w_fixes4
int TabOrder=0
boolean Visible=false
end type

type cb_add from w_base_no_criteria_scan`cb_add within w_fixes4
int TabOrder=0
boolean Visible=false
end type

type cb_generate from commandbutton within w_fixes4
int X=3328
int Y=32
int Width=315
int Height=96
int TabOrder=10
boolean BringToTop=true
string Text="&Generate"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//// script variables
//string s_achcriteria, s_achrptcriteria, s_achHomePhone, s_achWorkPhone, s_achCode, s_achMessage
//string s_achSQL, s_achAcctType, s_achFundNum, s_achActNum, s_achDeptNum, s_achObjNum
//string s_achProjNum, s_achSrcNum, s_achALENum, s_achDebitCredit, s_achSSAN, s_achLstCgLog
//integer s_iFY, s_iYear, s_iPeriodYear, s_iPeriodNum, s_iPastYear, s_iCount, s_iParcelYear
//long s_lLedgerRows, s_lRowCount, s_lItemRow, s_lLedItemRow, s_lMaxNum, s_lCorrItemRows
//long s_lFamilyRows, s_lRow, s_lFreeLegalRows
//string s_achTownshipNum, s_achSectionNum, s_achParcelBlkNum, s_achParcelNum, s_achBldgNum
//string s_achJurisdiction, s_achCompleteParcelNum, s_achClassCode, s_achErrText
//long s_lFixAssessRows, rtn, s_lCount
//datetime s_dtLtChgDtTm
//date s_dtPeriodDate, s_dtPostDate, s_dtEndDate
//decimal {2} s_dPeriod1, s_dPeriod2, s_dPeriod3, s_dPeriod4, s_dPeriod5, s_dPeriod6
//decimal {2} s_dPeriod7, s_dPeriod8, s_dPeriod9, s_dPeriod10, s_dPeriod11, s_dPeriod12
//decimal {2} s_dAmount, s_dBeginBal, s_dPastBal, s_dPastBegBal, s_dHourlyRate, s_dBudget
//decimal {3} s_dHours, s_dGrossPay
//decimal {6} s_dPercentage
//string s_achSubdiv, s_achDescription, s_achAddress1, s_achAddress2, s_achCity, s_achState
//string s_achZip, s_achZip4, s_achCommonUsed, s_achLegal
//date s_dtreturn_filed_date, s_dtmarriage_date
//integer s_iRowCount, s_iCMSLegalCounter
//long s_lReturnRows, s_lCMSLegalReturnRows, s_lFixSalesRows
//integer s_iNumBuildings, s_iNumDwellings, s_iNumUnits
//
//datastore lds_Ledger, lds_NewLedger, lds_LedgerItem, lds_ClaimItem, lds_CorrItem, lds_Family
//datastore lds_FreeLegal, lds_TaxImport, lds_AudCodes, lds_AsrCodes, lds_RecCodes, lds_UtCodes
//datastore lds_CMS_Legal, lds_Doc_Note, lds_TreCodes, lds_FixSales
//
//SetPointer(HourGlass!)
///*
//// Load CMS Frozen Exempt Property records
//If rb_load_cms_frozen_exempt.checked = True Then
//	
//	string s_achPrevClassCode, s_achFExemptCode, s_achFTaxDistrict
//	long s_lParcelFrozenExemptRows, s_lFCount, s_lFExemptImprove, s_lFExemptLand, s_lFExemptValue
//	decimal {2} s_dFExemptAcres
//	integer s_iRow, s_iFCount
//	
//	datastore lds_ParcelFrozenExempt, lds_AssessorFrozenExempt
//	
//	// allocate the resources for the datastores
//	lds_ParcelFrozenExempt = Create DataStore
//				
//	lds_ParcelFrozenExempt.DataObject = 'dw_import_cms_parcel_frozen_exempt_ds'
//	lds_ParcelFrozenExempt.SetTransObject(SQLCA)
//
//	// allocate the resources for the datastores
//	lds_AssessorFrozenExempt = Create DataStore
//	lds_AssessorFrozenExempt.DataObject = 'dw_new_parcel_exempt_frozen_ds'
//	lds_AssessorFrozenExempt.SetTransObject(SQLCA)
//	
//	DELETE FROM ut_parcel_exempt_frozen WHERE jurisdiction = 'C';
//	
//	// Retrieve ledgers for a specified year
//	s_lParcelFrozenExemptRows = lds_ParcelFrozenExempt.Retrieve()
//	For s_lFCount = 1 To s_lParcelFrozenExemptRows
//
//		s_achCompleteParcelNum = Trim(lds_ParcelFrozenExempt.GetItemString(s_lFCount,"complete_parcel_number"))
//		If IsNull(s_achCompleteParcelNum) Then s_achCompleteParcelNum = ""
//
//		s_achTownshipNum = Mid(s_achCompleteParcelNum,1,2)
//		s_achSectionNum = Mid(s_achCompleteParcelNum,3,2)				
//		s_achParcelBlkNum = Mid(s_achCompleteParcelNum,5,3)				
//		s_achParcelNum = Mid(s_achCompleteParcelNum,8,3)								
//		s_achBldgNum = Mid(s_achCompleteParcelNum,11,2)				
//
//		s_achFTaxDistrict = Trim(lds_ParcelFrozenExempt.GetItemString(s_lFCount,"tax_district"))
//		If IsNull(s_achFTaxDistrict) Then s_achFTaxDistrict = ""
//
//		s_achFExemptCode = Trim(lds_ParcelFrozenExempt.GetItemString(s_lFCount,"exempt_code"))
//		If IsNull(s_achFExemptCode) Then s_achFExemptCode = ""
//		
//		s_lFExemptValue = lds_ParcelFrozenExempt.GetItemNumber(s_lFCount,"exempt_land")
//		If IsNull(s_lFExemptValue) Then s_lFExemptValue = 0
//
//		s_lFExemptLand = 0
//		s_lFExemptImprove = 0
//
//		If Right(s_achFExemptCode,1) = 'L' Then
//			s_lFExemptLand = s_lFExemptValue
//		Else
//			s_lFExemptImprove = s_lFExemptValue
//		End If
//
//		s_achFExemptCode = Left(s_achFExemptCode,2)
//
//		s_dFExemptAcres = lds_ParcelFrozenExempt.GetItemNumber(s_lFCount,"exempt_acres")
//		If IsNull(s_dFExemptAcres) Then s_dFExemptAcres = 0
//		
//		SELECT prev_class_code INTO :s_achPrevClassCode
//			FROM ut_parcel_year
//			WHERE ut_parcel_year.parcel_year = 2006
//			AND ut_parcel_year.township_number = :s_achTownshipNum			
//			AND ut_parcel_year.section_number = :s_achSectionNum						
//			AND ut_parcel_year.parcel_blk_number = :s_achParcelBlkNum						
//			AND ut_parcel_year.parcel_number = :s_achParcelNum									
//			AND ut_parcel_year.bldg_number = :s_achBldgNum;
//		If IsNull(s_achPrevClassCode) Then s_achPrevClassCode = ""			
//		s_achPrevClassCode = Trim(s_achPrevClassCode)
//		
//		If s_achPrevClassCode = "" Then
//			SELECT class_code INTO :s_achPrevClassCode
//				FROM ut_parcel_year
//				WHERE ut_parcel_year.parcel_year = 2006
//				AND ut_parcel_year.township_number = :s_achTownshipNum			
//				AND ut_parcel_year.section_number = :s_achSectionNum						
//				AND ut_parcel_year.parcel_blk_number = :s_achParcelBlkNum						
//				AND ut_parcel_year.parcel_number = :s_achParcelNum									
//				AND ut_parcel_year.bldg_number = :s_achBldgNum;
//			If IsNull(s_achPrevClassCode) Then s_achPrevClassCode = ""			
//			s_achPrevClassCode = Trim(s_achPrevClassCode)
//		End If
//
//		SELECT COUNT(*) INTO :s_iFCount
//			FROM ut_parcel_exempt_frozen
//			WHERE ut_parcel_exempt_frozen.parcel_year = 2005
//			AND ut_parcel_exempt_frozen.township_number = :s_achTownshipNum			
//			AND ut_parcel_exempt_frozen.section_number = :s_achSectionNum						
//			AND ut_parcel_exempt_frozen.parcel_blk_number = :s_achParcelBlkNum						
//			AND ut_parcel_exempt_frozen.parcel_number = :s_achParcelNum									
//			AND ut_parcel_exempt_frozen.bldg_number = :s_achBldgNum;
//		If IsNull(s_iFCount) Then s_iFCount = 0			
//		s_iFCount ++
//		
//		st_message.Text = s_achCompleteParcelNum
//
//		// Create Corresponding Assessor Exempt Property Record
//		s_iRow = lds_AssessorFrozenExempt.InsertRow(0)
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"parcel_year", 2005)					
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"township_number", s_achTownshipNum)					
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"section_number", s_achSectionNum)										
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"parcel_blk_number", s_achParcelBlkNum)										
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"parcel_number", s_achParcelNum)															
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"bldg_number", s_achBldgNum)		
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"jurisdiction", "C")				
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"exempt_prop_number", s_iFCount)
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"tax_district", s_achFTaxDistrict)						
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"exempt_code", s_achFExemptCode)		
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"class_code", s_achPrevClassCode)				
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"number_buildings", 0)		
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"number_dwellings_units", 0)			
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"acres", s_dFExemptAcres)			
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"exempt_land", s_lFExemptLand)			
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"exempt_improvements", s_lFExemptImprove)				
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"comments", "")				
//	
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"last_chg_login", "mimlay")						
//		lds_AssessorFrozenExempt.SetItem(s_iRow,"last_chg_datetime", g_dtToday)										
//				
//		lds_AssessorFrozenExempt.Update()
//			
//		COMMIT;
//	Next	
//	
//	Destroy lds_ParcelFrozenExempt
//	
//End If	
//*/
//
//// Load CMS Frozen Exempt Tax District
//If rb_load_cms_frozen_exempt_td.checked = True Then
//	
//	string s_achFTaxDistrict
//	long s_lParcelFrozenExemptRows, s_lFCount
//	integer s_iRow, s_iFCount
//	
//	datastore lds_ParcelFrozenExempt
//	
//	// allocate the resources for the datastores
//	lds_ParcelFrozenExempt = Create DataStore
//				
//	lds_ParcelFrozenExempt.DataObject = 'dw_import_parcel_frozen_exempt_ds'
//	lds_ParcelFrozenExempt.SetTransObject(SQLCA)
//
//	// Retrieve ledgers for a specified year
//	s_lParcelFrozenExemptRows = lds_ParcelFrozenExempt.Retrieve(2006)
//
//	MessageBox("s_lParcelFrozenExemptRows",s_lParcelFrozenExemptRows)
//
//	For s_lFCount = 1 To s_lParcelFrozenExemptRows
//
//		s_achTownshipNum = ""
//		s_achSectionNum = ""
//		s_achParcelBlkNum = ""
//		s_achParcelNum = ""
//		s_achBldgNum = ""
//		s_achFTaxDistrict = ""
//
//		s_achTownshipNum = Trim(lds_ParcelFrozenExempt.GetItemString(s_lFCount,"township_number"))
//		If IsNull(s_achTownshipNum) Then s_achTownshipNum = ""
//
//		s_achSectionNum = Trim(lds_ParcelFrozenExempt.GetItemString(s_lFCount,"section_number"))
//		If IsNull(s_achSectionNum) Then s_achSectionNum = ""
//
//		s_achParcelBlkNum = Trim(lds_ParcelFrozenExempt.GetItemString(s_lFCount,"parcel_blk_number"))
//		If IsNull(s_achParcelBlkNum) Then s_achParcelBlkNum = ""
//
//		s_achParcelNum = Trim(lds_ParcelFrozenExempt.GetItemString(s_lFCount,"parcel_number"))
//		If IsNull(s_achParcelNum) Then s_achParcelNum = ""
//
//		s_achBldgNum = Trim(lds_ParcelFrozenExempt.GetItemString(s_lFCount,"bldg_number"))
//		If IsNull(s_achBldgNum) Then s_achBldgNum = ""
//
//		SELECT tax_district
//			INTO :s_achFTaxDistrict
//			FROM ut_parcel_year			
//			WHERE ut_parcel_year.parcel_year = 2006
//			AND ut_parcel_year.township_number = :s_achTownshipNum			
//			AND ut_parcel_year.section_number = :s_achSectionNum						
//			AND ut_parcel_year.parcel_blk_number = :s_achParcelBlkNum						
//			AND ut_parcel_year.parcel_number = :s_achParcelNum									
//			AND ut_parcel_year.bldg_number = :s_achBldgNum;
//		If IsNull(s_achFTaxDistrict) Then s_achFTaxDistrict = ""
//
////		s_achFTaxDistrict = Trim(lds_ParcelFrozenExempt.GetItemString(s_lFCount,"tax_district"))
////		If IsNull(s_achFTaxDistrict) Then s_achFTaxDistrict = ""
//
//		UPDATE ut_parcel_exempt_frozen
//			SET tax_district = :s_achFTaxDistrict
//			WHERE ut_parcel_exempt_frozen.parcel_year = 2006
//			AND ut_parcel_exempt_frozen.township_number = :s_achTownshipNum			
//			AND ut_parcel_exempt_frozen.section_number = :s_achSectionNum						
//			AND ut_parcel_exempt_frozen.parcel_blk_number = :s_achParcelBlkNum						
//			AND ut_parcel_exempt_frozen.parcel_number = :s_achParcelNum									
//			AND ut_parcel_exempt_frozen.bldg_number = :s_achBldgNum;
//		COMMIT;
//	Next	
//	
//	Destroy lds_ParcelFrozenExempt
//	
//End If	
//
///*
//// Load parcel free text records
//If rb_load_free_text_legals.checked = True Then
//	
//	string s_achLegal1, s_achLegal2, s_achLegal3, s_achLegal4, s_achFreeTextLegal
//	string s_achLegal5, s_achLegal6, s_achAgdwell
////	string s_achTownshipNum, s_achSectionNum, s_achParcelBlkNum, s_achParcelNum, s_achBldgNum
//   long s_iRow
//	long s_lParcelLegalRows, s_lCount
//	
//	datastore lds_ParcelLegal, lds_NewParcelLegal
//
////	delete ut_parcel_legal where parcel_year = :g_iCurrYear;
//		
//	// allocate the resources for the datastores
//	lds_ParcelLegal = Create DataStore
//				
//	lds_ParcelLegal.DataObject = 'dw_import_parcel_free_text_legal_ds'
//	lds_ParcelLegal.SetTransObject(SQLCA)
//	
//	// allocate the resources for the datastores
//	lds_NewParcelLegal = Create DataStore
//	lds_NewParcelLegal.DataObject = 'dw_new_parcel_legal_ds'
//	lds_NewParcelLegal.SetTransObject(SQLCA)
//	
//	s_achLstCgLog = "CMS Conversion"
//	s_dtLtChgDtTm = DateTime(Today())
//	
//	// Retrieve ledgers for a specified year
//	s_lParcelLegalRows = lds_ParcelLegal.Retrieve()
//	For s_lCount = 1 To s_lParcelLegalRows
//
//		s_achFreeTextLegal = ""
//		
//		s_achTownshipNum = Trim(lds_ParcelLegal.GetItemString(s_lCount,"township_number"))
//		If IsNull(s_achTownshipNum) Then s_achTownshipNum = ""
//
//		s_achSectionNum = Trim(lds_ParcelLegal.GetItemString(s_lCount,"section_number"))
//		If IsNull(s_achSectionNum) Then s_achSectionNum = ""
//
//		s_achParcelBlkNum = Trim(lds_ParcelLegal.GetItemString(s_lCount,"parcel_blk_number"))
//		If IsNull(s_achParcelBlkNum) Then s_achParcelBlkNum = ""
//
//		s_achParcelNum = Trim(lds_ParcelLegal.GetItemString(s_lCount,"parcel_number"))
//		If IsNull(s_achParcelNum) Then s_achParcelNum = ""
//
//		s_achBldgNum = Trim(lds_ParcelLegal.GetItemString(s_lCount,"bldg_number"))
//		If IsNull(s_achBldgNum) Then s_achBldgNum = ""
//
//		s_achLegal1 = Trim(lds_ParcelLegal.GetItemString(s_lCount,"legal1"))
//		If IsNull(s_achLegal1) Then s_achLegal1 = ""
//
//		s_achLegal2 = Trim(lds_ParcelLegal.GetItemString(s_lCount,"legal2"))
//		If IsNull(s_achLegal2) Then s_achLegal2 = ""
//
//		s_achLegal3 = Trim(lds_ParcelLegal.GetItemString(s_lCount,"legal3"))
//		If IsNull(s_achLegal3) Then s_achLegal3 = ""
//
//		s_achLegal4 = Trim(lds_ParcelLegal.GetItemString(s_lCount,"legal4"))
//		If IsNull(s_achLegal4) Then s_achLegal4 = ""
//		
//		s_achLegal5 = Trim(lds_ParcelLegal.GetItemString(s_lCount,"legal5"))
//		If IsNull(s_achLegal5) Then s_achLegal5 = ""
//
//		s_achLegal6 = Trim(lds_ParcelLegal.GetItemString(s_lCount,"legal6"))
//		If IsNull(s_achLegal6) Then s_achLegal6 = ""		
//		
//		s_achAgdwell = Trim(lds_ParcelLegal.GetItemString(s_lCount,"agdwell"))
//		If IsNull(s_achAgdwell) Then s_achAgdwell = ""
//
//		s_achFreeTextLegal = Trim(s_achLegal1 + " " + s_achLegal2 + " " + s_achLegal3 + &
//			" " + s_achLegal4 + " " + s_achLegal5 + " " + s_achLegal6 + " " + s_achAgdwell)
//			
//		st_message.text = "cms " + s_achTownshipNum + "-" + s_achSectionNum + "-" + &
//			s_achParcelBlkNum + "-" + s_achParcelNum + "-" + s_achBldgNum + " " + &
//			string(s_lcount) + " of " + string(s_lParcelLegalRows)		
//
//		// Create Corresponding Free Text Legal Record
//		s_iRow = lds_NewParcelLegal.InsertRow(0)
//		lds_NewParcelLegal.SetItem(s_iRow,"parcel_year", g_iCurrYear)					
//		lds_NewParcelLegal.SetItem(s_iRow,"township_number", s_achTownshipNum)					
//		lds_NewParcelLegal.SetItem(s_iRow,"section_number", s_achSectionNum)										
//		lds_NewParcelLegal.SetItem(s_iRow,"parcel_blk_number", s_achParcelBlkNum)										
//		lds_NewParcelLegal.SetItem(s_iRow,"parcel_number", s_achParcelNum)															
//		lds_NewParcelLegal.SetItem(s_iRow,"bldg_number", s_achBldgNum)															
//		lds_NewParcelLegal.SetItem(s_iRow,"legal_number", 1)
//		lds_NewParcelLegal.SetItem(s_iRow,"legal_description", s_achFreeTextLegal)		
//		lds_NewParcelLegal.SetItem(s_iRow,"last_chg_login", s_achLstCgLog)						
//		lds_NewParcelLegal.SetItem(s_iRow,"last_chg_datetime", s_dtLtChgDtTm)										
//	
//		lds_NewParcelLegal.Update()
//
//		UPDATE ut_parcel_year
//			SET legal_description = :s_achFreeTextLegal
//			WHERE ut_parcel_year.parcel_year = :g_iCurrYear
//			AND ut_parcel_year.township_number = :s_achTownshipNum			
//			AND ut_parcel_year.section_number = :s_achSectionNum						
//			AND ut_parcel_year.parcel_blk_number = :s_achParcelBlkNum						
//			AND ut_parcel_year.parcel_number = :s_achParcelNum									
//			AND ut_parcel_year.bldg_number = :s_achBldgNum;
//				
//		COMMIT;
//	Next	
//	
//	Destroy lds_ParcelLegal
//	
//End If	
//*/
///*
//// Load missing parcel address records
//If rb_miss_address.checked = True Then
//	
//	decimal {2} s_dGrossAcres, s_dNetAcres, s_dROWAcres, s_dWasteAcres, s_dTaxableAcres
//	long s_lParcelYearRows
//	
//	datastore lds_ParcelYear, lds_SiteAddress
//
//	// allocate the resources for the datastores
//	lds_ParcelYear = Create DataStore
//				
//	lds_ParcelYear.DataObject = 'dw_calc_row_acres_ds'
//	lds_ParcelYear.SetTransObject(SQLCA)
//
//	// allocate the resources for the datastores
//	lds_SiteAddress = Create DataStore
//				
//	lds_SiteAddress.DataObject = 'dw_new_parcel_address_ds'
//	lds_SiteAddress.SetTransObject(SQLCA)
//	
//	// Retrieve ledgers for a specified year
//	s_lParcelYearRows = lds_ParcelYear.Retrieve(2006)
//	For s_lCount = 1 To s_lParcelYearRows
//
//		s_achCompleteParcelNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"complete_parcel_number"))
//		If IsNull(s_achCompleteParcelNum) Then s_achCompleteParcelNum = ""
//
////		if s_achCompleteParcelNum <> '171223000100' then continue
////		if s_achCompleteParcelNum <> '061715100100' Then Continue		
//		
//		s_iParcelYear = lds_ParcelYear.GetItemNumber(s_lCount,"parcel_year")
//		If IsNull(s_iParcelYear) Then s_iParcelYear = 0
//
//		s_achTownshipNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"township_number"))
//		If IsNull(s_achTownshipNum) Then s_achTownshipNum = ""
//		
//		s_achSectionNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"section_number"))
//		If IsNull(s_achSectionNum) Then s_achSectionNum = ""
//
//		s_achParcelBlkNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"parcel_blk_number"))
//		If IsNull(s_achParcelBlkNum) Then s_achParcelBlkNum = ""
//
//		s_achParcelNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"parcel_number"))
//		If IsNull(s_achParcelNum) Then s_achParcelNum = ""
//
//		s_achBldgNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"bldg_number"))
//		If IsNull(s_achBldgNum) Then s_achBldgNum = ""
//
//		s_achJurisdiction = Trim(lds_ParcelYear.GetItemString(s_lCount,"jurisdiction"))
//		If IsNull(s_achJurisdiction) Then s_achJurisdiction = ""
//
//		SELECT COUNT(*) INTO :s_iCount
//			FROM ut_parcel_address
//			WHERE ut_parcel_address.parcel_year = :s_iParcelYear
//			AND ut_parcel_address.township_number = :s_achTownshipNum			
//			AND ut_parcel_address.section_number = :s_achSectionNum						
//			AND ut_parcel_address.parcel_blk_number = :s_achParcelBlkNum						
//			AND ut_parcel_address.parcel_number = :s_achParcelNum									
//			AND ut_parcel_address.bldg_number = :s_achBldgNum
//			AND ut_parcel_address.main_address = 'Y';
//		If s_iCount = 0 Then
//			
//			INSERT INTO ut_parcel_address
//					(parcel_year, township_number, section_number, parcel_blk_number, 
//					parcel_number, bldg_number, line_number, street_number, street_number_suffix,
//					street_code, alr_type, apt_lot_room, community, zip_code, main_address)
//				VALUES (:s_iParcelYear, :s_achTownshipNum, :s_achSectionNum, :s_achParcelBlkNum,
//					:s_achParcelNum, :s_achBldgNum, 1, '', '', 
//					0, '', '', '', '', 'Y');				
//			COMMIT;
//			/*
//			// Create Corresponding Site Address Record
//			s_iRow = lds_SiteAddress.InsertRow(0)
//MessageBox("s_iRow",s_iRow)
//			lds_SiteAddress.SetItem(s_iRow,"parcel_year", s_iParcelYear)					
//			lds_SiteAddress.SetItem(s_iRow,"township_number", s_achTownshipNum)					
//			lds_SiteAddress.SetItem(s_iRow,"section_number", s_achSectionNum)										
//			lds_SiteAddress.SetItem(s_iRow,"parcel_blk_number", s_achParcelBlkNum)										
//			lds_SiteAddress.SetItem(s_iRow,"parcel_number", s_achParcelNum)															
//			lds_SiteAddress.SetItem(s_iRow,"bldg_number", s_achBldgNum)															
//			lds_SiteAddress.SetItem(s_iRow,"line_number", 1)
//			lds_SiteAddress.SetItem(s_iRow,"main_address", 'Y')		
//			lds_SiteAddress.SetItem(s_iRow,"street_number", "")			
//			lds_SiteAddress.SetItem(s_iRow,"street_number_suffix", "")			
//			lds_SiteAddress.SetItem(s_iRow,"alr_type", "")				
//			lds_SiteAddress.SetItem(s_iRow,"apt_lot_room", "")					
//			lds_SiteAddress.SetItem(s_iRow,"street_code", 0)					
//			lds_SiteAddress.SetItem(s_iRow,"community", "")			
//			lds_SiteAddress.SetItem(s_iRow,"zip_code", "")			
//			lds_SiteAddress.SetItem(s_iRow,"last_chg_login", "CATS Repair")						
//			lds_SiteAddress.SetItem(s_iRow,"last_chg_datetime", g_dtToday)										
//			lds_SiteAddress.Update()
//			*/
//		End If
//		
//		st_message.text = "parcel " + s_achTownshipNum + "-" + s_achSectionNum + "-" + &
//			s_achParcelBlkNum + "-" + s_achParcelNum + "-" + s_achBldgNum + " " + &
//			string(s_lcount) + " of " + string(s_lParcelYearRows)		
//
//				
//		COMMIT;
//	Next	
//	
//	Destroy lds_ParcelYear
//	
//End If	
//*/
///*
//// Fix City Township records
//If rb_fix_city_township.checked = True Then
//	
//	string s_achCityTownship, s_achTaxDistrict 
////	long s_lParcelYearRows
//	
//	datastore lds_ParcelYear
//
//	// allocate the resources for the datastores
//	lds_ParcelYear = Create DataStore
//				
//	lds_ParcelYear.DataObject = 'dw_calc_row_acres_ds'
//	lds_ParcelYear.SetTransObject(SQLCA)
//	
//	// Retrieve ledgers for a specified year
//	s_lParcelYearRows = lds_ParcelYear.Retrieve(2006)
//	For s_lCount = 1 To s_lParcelYearRows
//
//		s_achCompleteParcelNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"complete_parcel_number"))
//		If IsNull(s_achCompleteParcelNum) Then s_achCompleteParcelNum = ""
//
////		if s_achCompleteParcelNum <> '150312600100' then continue
////		if s_achCompleteParcelNum <> '061715100100' Then Continue		
//		
//		s_iParcelYear = lds_ParcelYear.GetItemNumber(s_lCount,"parcel_year")
//		If IsNull(s_iParcelYear) Then s_iParcelYear = 0
//
//		s_achTownshipNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"township_number"))
//		If IsNull(s_achTownshipNum) Then s_achTownshipNum = ""
//		
//		s_achSectionNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"section_number"))
//		If IsNull(s_achSectionNum) Then s_achSectionNum = ""
//
//		s_achParcelBlkNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"parcel_blk_number"))
//		If IsNull(s_achParcelBlkNum) Then s_achParcelBlkNum = ""
//
//		s_achParcelNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"parcel_number"))
//		If IsNull(s_achParcelNum) Then s_achParcelNum = ""
//
//		s_achBldgNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"bldg_number"))
//		If IsNull(s_achBldgNum) Then s_achBldgNum = ""
//
//		s_achTaxDistrict = Trim(lds_ParcelYear.GetItemString(s_lCount,"tax_district"))
//		If IsNull(s_achTaxDistrict) Then s_achTaxDistrict = ""
//
//		SELECT township_city INTO :s_achCityTownship
//			FROM ut_tax_district
//			WHERE ut_tax_district.tax_year = :s_iParcelYear
//			AND ut_tax_district.tax_district = :s_achTaxDistrict
//			AND ut_tax_district.tif_district = '';			
//		If IsNull(s_achCityTownship) Then s_achCityTownship = ""
//
//		st_message.text = "parcel " + s_achTownshipNum + "-" + s_achSectionNum + "-" + &
//			s_achParcelBlkNum + "-" + s_achParcelNum + "-" + s_achBldgNum + " " + &
//			string(s_lcount) + " of " + string(s_lParcelYearRows)		
//
//		lds_ParcelYear.SetItem(s_lCount,"city_township_code", s_achCityTownship)		
//		lds_ParcelYear.Update()
//				
//		COMMIT;
//	Next	
//	
//	Destroy lds_ParcelYear
//	
//End If	
//
//// Combine Exempt Property records
//If rb_combine_exempt_prop.checked = True Then
//	
//	string s_achPrevCompleteParcelNum, s_achExemptCode
//	long s_PropRows, s_iExemptPropNum, s_lRow2, s_lExemptPropRows
//	integer s_iCount2
//	decimal {2} s_dExemptLand, s_dExemptImprovements, s_dExemptAcres
//	
//	datastore lds_ExemptProp, lds_WfExemptProperty
//
//	// allocate the resources for the datastores
//	lds_ExemptProp = Create DataStore
//				
//	lds_ExemptProp.DataObject = 'dw_combine_exempt_prop_ds'
//	lds_ExemptProp.SetTransObject(SQLCA)
//	
//	// allocate the resources for the datastores
//	lds_WfExemptProperty = Create DataStore
//				
//	lds_WfExemptProperty.DataObject = 'dw_new_wf_exempt_prop_ds'
//	lds_WfExemptProperty.SetTransObject(SQLCA)
//
//	DELETE wf_parcel_exempt_property;
//	COMMIT;
//	
//	// Retrieve ledgers for a specified year
//	s_lExemptPropRows = lds_ExemptProp.Retrieve(2006)
//	For s_lCount = 1 To s_lExemptPropRows
//
//		s_dROWAcres = 0
//		s_dWasteAcres = 0		
//
//		s_iParcelYear = lds_ExemptProp.GetItemNumber(s_lCount,"parcel_year")
//		If IsNull(s_iParcelYear) Then s_iParcelYear = 0
//
//		s_achTownshipNum = Trim(lds_ExemptProp.GetItemString(s_lCount,"township_number"))
//		If IsNull(s_achTownshipNum) Then s_achTownshipNum = ""
//		
//		s_achSectionNum = Trim(lds_ExemptProp.GetItemString(s_lCount,"section_number"))
//		If IsNull(s_achSectionNum) Then s_achSectionNum = ""
//
//		s_achParcelBlkNum = Trim(lds_ExemptProp.GetItemString(s_lCount,"parcel_blk_number"))
//		If IsNull(s_achParcelBlkNum) Then s_achParcelBlkNum = ""
//
//		s_achParcelNum = Trim(lds_ExemptProp.GetItemString(s_lCount,"parcel_number"))
//		If IsNull(s_achParcelNum) Then s_achParcelNum = ""
//
//		s_achBldgNum = Trim(lds_ExemptProp.GetItemString(s_lCount,"bldg_number"))
//		If IsNull(s_achBldgNum) Then s_achBldgNum = ""
//
//		s_achJurisdiction = Trim(lds_ExemptProp.GetItemString(s_lCount,"jurisdiction"))
//		If IsNull(s_achJurisdiction) Then s_achJurisdiction = ""
//
//		s_achExemptCode = Trim(lds_ExemptProp.GetItemString(s_lCount,"exempt_code"))								
//		If IsNull(s_achExemptCode) Then s_achExemptCode = ""				
//
//		s_achClassCode = Trim(lds_ExemptProp.GetItemString(s_lCount,"class_code"))								
//		If IsNull(s_achClassCode) Then s_achClassCode = ""				
//
//		s_dExemptAcres = lds_ExemptProp.GetItemNumber(s_lCount,"acres")								
//		If IsNull(s_dExemptAcres) Then s_dExemptAcres = 0
//
//		s_dExemptLand = lds_ExemptProp.GetItemNumber(s_lCount,"exempt_land")								
//		If IsNull(s_dExemptLand) Then s_dExemptLand = 0
//
//		s_dExemptImprovements = lds_ExemptProp.GetItemNumber(s_lCount,"exempt_improvements")								
//		If IsNull(s_dExemptImprovements) Then s_dExemptImprovements = 0
//
//		st_message.text = "parcel " + s_achTownshipNum + "-" + s_achSectionNum + "-" + &
//			s_achParcelBlkNum + "-" + s_achParcelNum + "-" + s_achBldgNum + " " + &
//			string(s_lcount) + " of " + string(s_lExemptPropRows)		
//		
//		SELECT COUNT(*) INTO :s_iCount2
//			FROM wf_parcel_exempt_property
//			WHERE wf_parcel_exempt_property.parcel_year = :s_iParcelYear
//			AND wf_parcel_exempt_property.township_number = :s_achTownshipNum
//			AND wf_parcel_exempt_property.section_number = :s_achSectionNum				
//			AND wf_parcel_exempt_property.parcel_blk_number = :s_achParcelBlkNum				
//			AND wf_parcel_exempt_property.parcel_number = :s_achParcelNum								
//			AND wf_parcel_exempt_property.bldg_number = :s_achBldgNum								
//			AND wf_parcel_exempt_property.jurisdiction = :s_achJurisdiction					
//			AND wf_parcel_exempt_property.exempt_code = :s_achExemptCode;			
//		IF s_iCount2 = 0 Then
//
//			// Create Corresponding Exempt Property Workfile Record
//			s_lRow2 = lds_WfExemptProperty.InsertRow(0)
//			lds_WfExemptProperty.SetItem(s_lRow2,"parcel_year", s_iParcelYear)					
//			lds_WfExemptProperty.SetItem(s_lRow2,"township_number", s_achTownshipNum)										
//			lds_WfExemptProperty.SetItem(s_lRow2,"section_number", s_achSectionNum)														
//			lds_WfExemptProperty.SetItem(s_lRow2,"parcel_blk_number", s_achParcelBlkNum)														
//			lds_WfExemptProperty.SetItem(s_lRow2,"parcel_number", s_achParcelNum)																		
//			lds_WfExemptProperty.SetItem(s_lRow2,"bldg_number", s_achBldgNum)																		
//			lds_WfExemptProperty.SetItem(s_lRow2,"jurisdiction", s_achJurisdiction)																					
//			lds_WfExemptProperty.SetItem(s_lRow2,"exempt_code", s_achExemptCode)															
//			lds_WfExemptProperty.SetItem(s_lRow2,"class_code", s_achClassCode)																		
//			lds_WfExemptProperty.SetItem(s_lRow2,"exempt_prop_number", 1)																	
//			lds_WfExemptProperty.SetItem(s_lRow2,"exempt_land", s_dExemptLand)															
//			lds_WfExemptProperty.SetItem(s_lRow2,"exempt_improvements", s_dExemptImprovements)																		
//			lds_WfExemptProperty.SetItem(s_lRow2,"acres", s_dExemptAcres)																		
//			rtn = lds_WfExemptProperty.Update()									
////			messagebox("rtn",rtn)
//			COMMIT;
//		Else
////messagebox("update",s_achlevyauthoritycode + " " + s_achlevycode + " levy " + string(s_dLevyRate) + " tot levy " + string(s_dtotalLevy) + " new tot levy " + string(s_dLATotalLevyRate) + " parcel tax " + string(s_dTotalTax) + "calc la tax " + string(s_dLATax ))							
//			UPDATE wf_parcel_exempt_property
//				SET wf_parcel_exempt_property.exempt_land = 
//					 wf_parcel_exempt_property.exempt_land + :s_dExemptLand,
//				    wf_parcel_exempt_property.exempt_improvements = 
//					 wf_parcel_exempt_property.exempt_improvements + :s_dExemptImprovements,
//				    wf_parcel_exempt_property.acres = 
//					 wf_parcel_exempt_property.acres + :s_dExemptAcres									 
//				WHERE wf_parcel_exempt_property.parcel_year = :s_iParcelYear
//				AND wf_parcel_exempt_property.township_number = :s_achTownshipNum
//				AND wf_parcel_exempt_property.section_number = :s_achSectionNum				
//				AND wf_parcel_exempt_property.parcel_blk_number = :s_achParcelBlkNum				
//				AND wf_parcel_exempt_property.parcel_number = :s_achParcelNum								
//				AND wf_parcel_exempt_property.bldg_number = :s_achBldgNum								
//				AND wf_parcel_exempt_property.jurisdiction = :s_achJurisdiction					
//				AND wf_parcel_exempt_property.exempt_code = :s_achExemptCode;							
//			If SQLCA.SQLCode = -1 Then
//				s_achErrText = SQLCA.SQLErrText
//				ROLLBACK;
//				MessageBox("Error", "Workfile Parcel Exempt Property Update Failed - " + s_achErrText)
//			Else
//				COMMIT;
//			End If					
//				
//		End If		
//	
//	Next	
//	
//	Destroy lds_ExemptProp
//	
//End If	
//*/
//If rb_fix_sales.checked = True Then
//	
//	// get employee records
//	// allocate the resources for the datastores
//	lds_FixSales = Create DataStore
//			
//	lds_FixSales.DataObject = 'dw_fix_sales_ds'
//	lds_FixSales.SetTransObject(SQLCA)
//	
//	s_lFixSalesRows = lds_FixSales.Retrieve()
//messagebox("rows",string(s_lFixSalesrows))	
//	For s_lCount = 1 To s_lFixSalesRows
//	
//		s_achCompleteParcelNum = ""
//		
//		s_achTownshipNum = Trim(lds_FixSales.GetItemString(s_lCount,"township_number"))
//		If IsNull(s_achTownshipNum) Then s_achTownshipNum = ""
//
//		s_achSectionNum = Trim(lds_FixSales.GetItemString(s_lCount,"section_number"))
//		If IsNull(s_achSectionNum) Then s_achSectionNum = ""
//
//		s_achParcelBlkNum = Trim(lds_FixSales.GetItemString(s_lCount,"parcel_blk_number"))
//		If IsNull(s_achParcelBlkNum) Then s_achParcelBlkNum = ""
//
//		s_achParcelNum = Trim(lds_FixSales.GetItemString(s_lCount,"parcel_number"))
//		If IsNull(s_achParcelNum) Then s_achParcelNum = ""
//
//		s_achBldgNum = Trim(lds_FixSales.GetItemString(s_lCount,"bldg_number"))
//		If IsNull(s_achBldgNum) Then s_achBldgNum = ""
//		
//		st_message.text = "sales " + s_achTownshipNum + "-" + s_achSectionNum + "-" + &
//			s_achParcelBlkNum + "-" + s_achParcelNum + "-" + s_achBldgNum + " " + &
//			string(s_lcount) + " of " + string(s_lFixSalesRows)		
//
//		s_achCompleteParcelNum = s_achTownshipNum + s_achSectionNum + s_achParcelBlkNum + &
//			s_achParcelNum + s_achBldgNum
//		
//		lds_FixSales.SetItem(s_lCount,"complete_parcel_number", s_achCompleteParcelNum)
//		lds_FixSales.Update()
//		
//		COMMIT;
//	Next
//
//End If
//
//
//If rb_clean_legal.checked = True Then
//	
//	// get employee records
//	// allocate the resources for the datastores
//	lds_FreeLegal = Create DataStore
//			
//	lds_FreeLegal.DataObject = 'dw_clean_legal_ds'
//	lds_FreeLegal.SetTransObject(SQLCA)
//	
//	s_lFreeLegalRows = lds_FreeLegal.Retrieve(2005)
//messagebox("rows",string(s_lFreeLegalrows))	
//	For s_lCount = 1 To s_lFreeLegalRows
//	
//		s_achLegal = Upper(Trim(lds_FreeLegal.GetItemString(s_lCount,"legal_description")))
//
//		s_achTownshipNum = Trim(lds_FreeLegal.GetItemString(s_lCount,"township_number"))
//		If IsNull(s_achTownshipNum) Then s_achTownshipNum = ""
//
//		s_achSectionNum = Trim(lds_FreeLegal.GetItemString(s_lCount,"section_number"))
//		If IsNull(s_achSectionNum) Then s_achSectionNum = ""
//
//		s_achParcelBlkNum = Trim(lds_FreeLegal.GetItemString(s_lCount,"parcel_blk_number"))
//		If IsNull(s_achParcelBlkNum) Then s_achParcelBlkNum = ""
//
//		s_achParcelNum = Trim(lds_FreeLegal.GetItemString(s_lCount,"parcel_number"))
//		If IsNull(s_achParcelNum) Then s_achParcelNum = ""
//
//		s_achBldgNum = Trim(lds_FreeLegal.GetItemString(s_lCount,"bldg_number"))
//		If IsNull(s_achBldgNum) Then s_achBldgNum = ""
//		
//		lds_FreeLegal.SetItem(s_lCount,"legal_description", s_achLegal)		
//
//		st_message.text = "legal " + s_achTownshipNum + "-" + s_achSectionNum + "-" + &
//			s_achParcelBlkNum + "-" + s_achParcelNum + "-" + s_achBldgNum + " " + &
//			string(s_lcount) + " of " + string(s_lFreeLegalRows)		
//
//		UPDATE ut_parcel_year
//			SET legal_description = :s_achLegal
//			WHERE ut_parcel_year.parcel_year = 2005
//			AND ut_parcel_year.township_number = :s_achTownshipNum			
//			AND ut_parcel_year.section_number = :s_achSectionNum						
//			AND ut_parcel_year.parcel_blk_number = :s_achParcelBlkNum						
//			AND ut_parcel_year.parcel_number = :s_achParcelNum									
//			AND ut_parcel_year.bldg_number = :s_achBldgNum;
//				
//		COMMIT;
//	Next
//	lds_FreeLegal.Update()
//	COMMIT;
//End If
//
//
//If rb_trim_codes.checked = True Then
//
//	// get Assessor code records
//	// allocate the resources for the datastores
//	lds_AsrCodes = Create DataStore
//			
//	lds_AsrCodes.DataObject = 'dw_trim_asr_codes_ds'
//	lds_AsrCodes.SetTransObject(SQLCA)
//	
//	s_lLedgerRows = lds_AsrCodes.Retrieve()
//messagebox("code rows",string(s_lledgerrows))	
//	For s_lRowCount = 1 To s_lLedgerRows
//	
//		s_achCode = Upper(Trim(lds_AsrCodes.GetItemString(s_lRowCount,"code")))
//		s_achDescription = Upper(Trim(lds_AsrCodes.GetItemString(s_lRowCount,"description")))		
//		lds_AsrCodes.SetItem(s_lRowCount,"code", s_achCode)
//		lds_AsrCodes.SetItem(s_lRowCount,"description", s_achDescription)		
//
//	Next
//	lds_AsrCodes.Update()
//	COMMIT;
//
//	// get auditor code records
//	// allocate the resources for the datastores
//	lds_AudCodes = Create DataStore
//			
//	lds_AudCodes.DataObject = 'dw_trim_aud_codes_ds'
//	lds_AudCodes.SetTransObject(SQLCA)
//	
//	s_lLedgerRows = lds_AudCodes.Retrieve()
//messagebox("code rows",string(s_lledgerrows))	
//	For s_lRowCount = 1 To s_lLedgerRows
//	
//		s_achCode = Upper(Trim(lds_AudCodes.GetItemString(s_lRowCount,"code")))
//		s_achDescription = Upper(Trim(lds_AudCodes.GetItemString(s_lRowCount,"description")))		
//		lds_AudCodes.SetItem(s_lRowCount,"code", s_achCode)
//		lds_AudCodes.SetItem(s_lRowCount,"description", s_achDescription)		
//
//	Next
//	lds_AudCodes.Update()
//	COMMIT;
//
//	// get universal code records
//	// allocate the resources for the datastores
//	lds_UtCodes = Create DataStore
//			
//	lds_UtCodes.DataObject = 'dw_trim_ut_codes_ds'
//	lds_UtCodes.SetTransObject(SQLCA)
//	
//	s_lLedgerRows = lds_UtCodes.Retrieve()
//messagebox("code rows",string(s_lledgerrows))	
//	For s_lRowCount = 1 To s_lLedgerRows
//	
//		s_achCode = Upper(Trim(lds_UtCodes.GetItemString(s_lRowCount,"code")))
//		s_achDescription = Upper(Trim(lds_UtCodes.GetItemString(s_lRowCount,"description")))		
//		lds_UtCodes.SetItem(s_lRowCount,"code", s_achCode)
//		lds_UtCodes.SetItem(s_lRowCount,"description", s_achDescription)		
//
//	Next
//	lds_UtCodes.Update()
//	COMMIT;
//
//	// get universal code records
//	// allocate the resources for the datastores
//	lds_TreCodes = Create DataStore
//			
//	lds_TreCodes.DataObject = 'dw_trim_tre_codes_ds'
//	lds_TreCodes.SetTransObject(SQLCA)
//	
//	s_lLedgerRows = lds_TreCodes.Retrieve()
//messagebox("code rows",string(s_lledgerrows))	
//	For s_lRowCount = 1 To s_lLedgerRows
//	
//		s_achCode = Upper(Trim(lds_TreCodes.GetItemString(s_lRowCount,"code")))
//		s_achDescription = Upper(Trim(lds_TreCodes.GetItemString(s_lRowCount,"description")))		
//		lds_TreCodes.SetItem(s_lRowCount,"code", s_achCode)
//		lds_TreCodes.SetItem(s_lRowCount,"description", s_achDescription)		
//
//	Next
//	lds_TreCodes.Update()
//	COMMIT;
//
//	cb_generate.SetFocus()
//
//End If
//
//// Load parcel neighborhood records
//If rb_load_exempt_class.checked = True Then
//	
//	string s_achOrigClassCode, s_achExemptPropClassCode
//	long s_lParcelExemptClassRows
//	
//	datastore lds_ParcelExemptClass
//	
//	// allocate the resources for the datastores
//	lds_ParcelExemptClass = Create DataStore
//				
//	lds_ParcelExemptClass.DataObject = 'dw_import_exempt_class_ds'
//	lds_ParcelExemptClass.SetTransObject(SQLCA)
//	
//	// Retrieve ledgers for a specified year
//	s_lParcelExemptClassRows = lds_ParcelExemptClass.Retrieve()
//	For s_lCount = 1 To s_lParcelExemptClassRows
//
//		s_achCompleteParcelNum = Trim(lds_ParcelExemptClass.GetItemString(s_lCount,"complete_parcel_number"))
//		If IsNull(s_achCompleteParcelNum) Then s_achCompleteParcelNum = ""
//
//		s_achTownshipNum = Mid(s_achCompleteParcelNum,1,2)
//		s_achSectionNum = Mid(s_achCompleteParcelNum,3,2)				
//		s_achParcelBlkNum = Mid(s_achCompleteParcelNum,5,3)				
//		s_achParcelNum = Mid(s_achCompleteParcelNum,8,3)								
//		s_achBldgNum = Mid(s_achCompleteParcelNum,11,2)				
//
//		s_achClassCode = Trim(lds_ParcelExemptClass.GetItemString(s_lCount,"class_code"))
//		If IsNull(s_achClassCode) Then s_achClassCode = ""
//		
//		st_message.Text = s_achCompleteParcelNum + " " + s_achClassCode
//
//		SELECT class_code INTO :s_achOrigClassCode
//			FROM ut_parcel_year
//			WHERE ut_parcel_year.parcel_year = 2005
//			AND ut_parcel_year.township_number = :s_achTownshipNum			
//			AND ut_parcel_year.section_number = :s_achSectionNum						
//			AND ut_parcel_year.parcel_blk_number = :s_achParcelBlkNum						
//			AND ut_parcel_year.parcel_number = :s_achParcelNum									
//			AND ut_parcel_year.bldg_number = :s_achBldgNum;
//		If IsNull(s_achOrigClassCode) Then s_achOrigClassCode = ""			
//		s_achOrigClassCode = Trim(s_achOrigClassCode)
///*
//		If s_achOrigClassCode = "" Then
//			UPDATE ut_parcel_year
//				SET class_code = :s_achClassCode
//				WHERE ut_parcel_year.parcel_year = 2005
//				AND ut_parcel_year.township_number = :s_achTownshipNum			
//				AND ut_parcel_year.section_number = :s_achSectionNum						
//				AND ut_parcel_year.parcel_blk_number = :s_achParcelBlkNum						
//				AND ut_parcel_year.parcel_number = :s_achParcelNum									
//				AND ut_parcel_year.bldg_number = :s_achBldgNum;
//				
//			UPDATE asr_parcel_assessment
//				SET orig_class_code = :s_achClassCode,
//					 class_code = :s_achClassCode
//				WHERE asr_parcel_assessment.parcel_year = 2005
//				AND asr_parcel_assessment.township_number = :s_achTownshipNum			
//				AND asr_parcel_assessment.section_number = :s_achSectionNum						
//				AND asr_parcel_assessment.parcel_blk_number = :s_achParcelBlkNum						
//				AND asr_parcel_assessment.parcel_number = :s_achParcelNum									
//				AND asr_parcel_assessment.bldg_number = :s_achBldgNum;
//*/
//			SELECT class_code INTO :s_achExemptPropClassCode
//				FROM wf_parcel_recon_exempt_property
//				WHERE wf_parcel_recon_exempt_property.parcel_year = 2005
//				AND wf_parcel_recon_exempt_property.township_number = :s_achTownshipNum			
//				AND wf_parcel_recon_exempt_property.section_number = :s_achSectionNum						
//				AND wf_parcel_recon_exempt_property.parcel_blk_number = :s_achParcelBlkNum						
//				AND wf_parcel_recon_exempt_property.parcel_number = :s_achParcelNum									
//				AND wf_parcel_recon_exempt_property.bldg_number = :s_achBldgNum;
//			If IsNull(s_achExemptPropClassCode) Then s_achExemptPropClassCode = ""
//		
//			If s_achExemptPropClassCode = "" Then		
//				UPDATE wf_parcel_recon_exempt_property
//					SET class_code = :s_achClassCode
//					WHERE wf_parcel_recon_exempt_property.parcel_year = 2005
//					AND wf_parcel_recon_exempt_property.township_number = :s_achTownshipNum			
//					AND wf_parcel_recon_exempt_property.section_number = :s_achSectionNum						
//					AND wf_parcel_recon_exempt_property.parcel_blk_number = :s_achParcelBlkNum						
//					AND wf_parcel_recon_exempt_property.parcel_number = :s_achParcelNum									
//					AND wf_parcel_recon_exempt_property.bldg_number = :s_achBldgNum;
//			End If					
//			
//			COMMIT;
////		End If				
//	Next	
//	
//	Destroy lds_ParcelExemptClass
//	
//End If	
///*
//// Finish Equalization Process for Exempt Property records
//If rb_fix_equal_exempt_prop.checked = True Then
//	
//	long s_lEqualParcelYearRows, s_lLandFactor, s_lImprovementsFactor
//	long s_lExemptCount, s_lExemptLand, s_lExemptImprovements
//	
//	datastore lds_Equalization, lds_ExemptProperty
//	
//	// allocate the resources for the datastores
//	lds_Equalization = Create DataStore
//				
//	lds_Equalization.DataObject = 'dw_equalization_ds'
//	lds_Equalization.SetTransObject(SQLCA)
//
//	// allocate the resources for the datastores
//	lds_ExemptProperty = Create DataStore
//				
//	lds_ExemptProperty.DataObject = 'dw_equalized_exempt_prop_ds'
//	lds_ExemptProperty.SetTransObject(SQLCA)
//	
//	// Retrieve row to equalize exempt property for a specified year
//	s_lEqualParcelYearRows = lds_Equalization.Retrieve(2005, 2006, "M", "A")
//messagebox("rows",string(s_lEqualParcelYearRows))		
//	For s_lCount = 1 To s_lEqualParcelYearRows
//
//		s_achCompleteParcelNum = Trim(lds_Equalization.GetItemString(s_lCount,"complete_parcel_number"))
//		If IsNull(s_achCompleteParcelNum) Then s_achCompleteParcelNum = ""
//
//		s_achTownshipNum = Mid(s_achCompleteParcelNum,1,2)
//		s_achSectionNum = Mid(s_achCompleteParcelNum,3,2)				
//		s_achParcelBlkNum = Mid(s_achCompleteParcelNum,5,3)				
//		s_achParcelNum = Mid(s_achCompleteParcelNum,8,3)								
//		s_achBldgNum = Mid(s_achCompleteParcelNum,11,2)				
//
//		s_achClassCode = Trim(lds_Equalization.GetItemString(s_lCount,"class_code"))
//		If IsNull(s_achClassCode) Then s_achClassCode = ""
//
//		s_lLandFactor = lds_Equalization.GetItemNumber(s_lCount,"ut_equalization_factor_land_factor")
//		If IsNull(s_lLandFactor) Then s_lLandFactor = 0	
//		s_lImprovementsFactor = lds_Equalization.GetItemNumber(s_lCount,"ut_equalization_factor_improvements_fact")
//		If IsNull(s_lImprovementsFactor) Then s_lImprovementsFactor = 0	
//		
//		st_message.Text = s_achCompleteParcelNum + " " + s_achClassCode
//
//		// Retrieve exempt property for specified equalized parcels
//		s_lExemptPropRows = lds_ExemptProperty.Retrieve(2006, s_achTownshipNum, &
//			s_achSectionNum, s_achParcelBlkNum, s_achParcelNum, s_achBldgNum)
//		//messagebox("ex prop rows",s_lExemptPropRows)
//		For s_lExemptCount = 1 To s_lExemptPropRows
//
//			s_lExemptLand = 0
//			s_lExemptImprovements = 0
//			
//			s_lExemptLand = lds_ExemptProperty.GetItemNumber(s_lExemptCount,"exempt_land")
//			s_lExemptImprovements = lds_ExemptProperty.GetItemNumber(s_lExemptCount,"exempt_improvements")
////messagebox("pre ex prop",s_lexemptland)	
//			s_lExemptLand = s_lExemptLand + (s_lExemptLand * s_lLandFactor * 0.01)
//		
//			s_lExemptImprovements = s_lExemptImprovements + &
//				(s_lExemptImprovements * s_lImprovementsFactor * 0.01)
////messagebox("post ex prop",s_lexemptland)		
//			lds_ExemptProperty.SetItem(s_lExemptCount,"exempt_land", s_lExemptLand)
//			lds_ExemptProperty.SetItem(s_lExemptCount,"exempt_improvements", s_lExemptImprovements)				
//			lds_ExemptProperty.Update()
//			COMMIT;
//		Next
//
//	Next	
//	
//	Destroy lds_Equalization
//	Destroy lds_ExemptProperty	
//	
//End If	
//*/
//If rb_load_tax_site_address.checked = True Then
//	
//	long s_lParcelYearRows
//	long s_lStreetCode	
//	string s_achStreetNum, s_achStreetNumSuffix,	s_achALRType, s_achAptLotRoom
//	string s_achCommunity, s_achZipCode, s_achFullStreet
//	datastore lds_ParcelYear
//
//	// allocate the resources for the datastores
//	lds_ParcelYear = Create DataStore
//				
//	lds_ParcelYear.DataObject = 'dw_parcel_site_address_ds'
//	lds_ParcelYear.SetTransObject(SQLCA)
//
//	// Retrieve ledgers for a specified year
//	s_lParcelYearRows = lds_ParcelYear.Retrieve(2005)
//	For s_lCount = 1 To s_lParcelYearRows
//
//		s_achFullStreet = ""
//		
//		s_achCompleteParcelNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"complete_parcel_number"))
//		If IsNull(s_achCompleteParcelNum) Then s_achCompleteParcelNum = ""
//
////		if s_achCompleteParcelNum <> '171223000100' then continue
////		if s_achCompleteParcelNum <> '061715100100' Then Continue		
//		
//		s_iParcelYear = lds_ParcelYear.GetItemNumber(s_lCount,"parcel_year")
//		If IsNull(s_iParcelYear) Then s_iParcelYear = 0
//
//		s_achTownshipNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"township_number"))
//		If IsNull(s_achTownshipNum) Then s_achTownshipNum = ""
//		
//		s_achSectionNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"section_number"))
//		If IsNull(s_achSectionNum) Then s_achSectionNum = ""
//
//		s_achParcelBlkNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"parcel_blk_number"))
//		If IsNull(s_achParcelBlkNum) Then s_achParcelBlkNum = ""
//
//		s_achParcelNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"parcel_number"))
//		If IsNull(s_achParcelNum) Then s_achParcelNum = ""
//
//		s_achBldgNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"bldg_number"))
//		If IsNull(s_achBldgNum) Then s_achBldgNum = ""
//
//		s_achJurisdiction = Trim(lds_ParcelYear.GetItemString(s_lCount,"jurisdiction"))
//		If IsNull(s_achJurisdiction) Then s_achJurisdiction = ""
//
//		s_achStreetNum = Trim(lds_ParcelYear.GetItemString(s_lCount,"street_number"))
//		If IsNull(s_achStreetNum) Then s_achStreetNum = ""
//	
//		s_achStreetNumSuffix = Trim(lds_ParcelYear.GetItemString(s_lCount,"street_number_suffix"))
//		If IsNull(s_achStreetNumSuffix) Then s_achStreetNumSuffix = ""
//	
//		s_achALRType = Trim(lds_ParcelYear.GetItemString(s_lCount,"alr_type"))
//		If IsNull(s_achALRType) Then s_achALRType = ""
//	
//		s_achAptLotRoom = Trim(lds_ParcelYear.GetItemString(s_lCount,"apt_lot_room"))
//		If IsNull(s_achAptLotRoom) Then s_achAptLotRoom = ""
//	
//		s_lStreetCode = lds_ParcelYear.GetItemNumber(s_lCount,"street_code")
//		If IsNull(s_lStreetCode) Then s_lStreetCode = 0
//	
//		s_achCommunity = Trim(lds_ParcelYear.GetItemString(s_lCount,"community"))
//		If IsNull(s_achCommunity) Then s_achCommunity = ""
//	
//		s_achZipCode = Trim(lds_ParcelYear.GetItemString(s_lCount,"zip_code"))
//		If IsNull(s_achZipCode) Then s_achZipCode = ""
//
//		SELECT full_street INTO :s_achFullStreet
//			FROM ut_street
//			WHERE street_code = :s_lStreetCode;
//		If IsNull(s_achFullStreet) Then s_achFullStreet = ""						
//
//		SELECT COUNT(*) INTO :s_iCount
//			FROM ut_parcel_address
//			WHERE ut_parcel_address.parcel_year = 2004
//			AND ut_parcel_address.township_number = :s_achTownshipNum			
//			AND ut_parcel_address.section_number = :s_achSectionNum						
//			AND ut_parcel_address.parcel_blk_number = :s_achParcelBlkNum						
//			AND ut_parcel_address.parcel_number = :s_achParcelNum									
//			AND ut_parcel_address.bldg_number = :s_achBldgNum
//			AND ut_parcel_address.main_address = 'Y';
//		If s_iCount = 0 Then
//			
//			INSERT INTO ut_parcel_address
//					(parcel_year, township_number, section_number, parcel_blk_number, 
//					parcel_number, bldg_number, line_number, street_number, street_number_suffix,
//					street_code, alr_type, apt_lot_room, community, zip_code, main_address)
//				VALUES (2004, :s_achTownshipNum, :s_achSectionNum, :s_achParcelBlkNum,
//					:s_achParcelNum, :s_achBldgNum, 1, :s_achStreetNum, :s_achStreetNumSuffix, 
//					:s_lStreetCode, :s_achALRType, :s_achAptLotRoom, :s_achCommunity, :s_achZipCode, 
//					'Y');				
//			COMMIT;
//
//		End If
//		
//		st_message.text = "parcel " + s_achTownshipNum + "-" + s_achSectionNum + "-" + &
//			s_achParcelBlkNum + "-" + s_achParcelNum + "-" + s_achBldgNum + " " + &
//			string(s_lcount) + " of " + string(s_lParcelYearRows)		
//
//		UPDATE ut_parcel_year
//			SET street_number = :s_achStreetNum,
//			    street_number_suffix = :s_achStreetNumSuffix,			
//				 alr_type = :s_achALRType,
//				 apt_lot_room = :s_achAptLotRoom,
//				 street_code = :s_lStreetCode,
//				 community = :s_achCommunity,
//				 zip_code = :s_achZipCode
//			WHERE ut_parcel_year.parcel_year = 2004
//			AND ut_parcel_year.township_number = :s_achTownshipNum			
//			AND ut_parcel_year.section_number = :s_achSectionNum						
//			AND ut_parcel_year.parcel_blk_number = :s_achParcelBlkNum						
//			AND ut_parcel_year.parcel_number = :s_achParcelNum									
//			AND ut_parcel_year.bldg_number = :s_achBldgNum;
//				
//		COMMIT;
//
//		UPDATE ut_parcel_year_tax
//			SET street_number = :s_achStreetNum,
//			    street_number_suffix = :s_achStreetNumSuffix,			
//				 alr_type = :s_achALRType,
//				 apt_lot_room = :s_achAptLotRoom,
//				 street_code = :s_lStreetCode,
//				 street_name = :s_achFullStreet,				 
//				 community = :s_achCommunity
//			WHERE ut_parcel_year_tax.parcel_year = 2004
//			AND ut_parcel_year_tax.township_number = :s_achTownshipNum			
//			AND ut_parcel_year_tax.section_number = :s_achSectionNum						
//			AND ut_parcel_year_tax.parcel_blk_number = :s_achParcelBlkNum						
//			AND ut_parcel_year_tax.parcel_number = :s_achParcelNum									
//			AND ut_parcel_year_tax.bldg_number = :s_achBldgNum;
//		If SQLCA.SQLCODE = -1 Then
//			MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
//			ROLLBACK;
//			Return
//		Else
//			COMMIT;			
//		End If
//			
//			
//	Next	
//	
//	Destroy lds_ParcelYear
//	
//
//End If	
//
///*
//If rb_cms_sub.checked = True Then
//// allocate the resources for the datastores
//
//	lds_CMS_Legal = Create DataStore
//			
//	lds_CMS_Legal.DataObject = 'dw_rec_cms_legal_trim_ds'
//	lds_CMS_Legal.SetTransObject(SQLCA)
//
//// Retrieve 
//	s_lCMSLegalReturnRows = lds_CMS_Legal.Retrieve()
//
//	For s_iCMSLegalCounter = 1 To s_lCMSLegalReturnRows
//
//		s_achSubdiv = Trim(lds_CMS_Legal.GetItemString(s_iCMSLegalCounter, "subdivision"))
//		
//		st_message.Text = s_achSubdiv
//
//		lds_CMS_Legal.SetItem(s_iCMSLegalCounter, "subdivision", s_achSubdiv)
//		lds_CMS_Legal.Update()
//	Next	
//	
//	Destroy lds_CMS_Legal
//
//End If	
//
//If rb_trim_doc_notes.checked = True Then
//// allocate the resources for the datastores
//
//	lds_Doc_Note = Create DataStore
//			
//	lds_Doc_Note.DataObject = 'dw_rec_doc_note_trim_ds'
//	lds_Doc_Note.SetTransObject(SQLCA)
//
//// Retrieve 
//	s_lCMSLegalReturnRows = lds_Doc_Note.Retrieve()
//
//	For s_iCMSLegalCounter = 1 To s_lCMSLegalReturnRows
//
//		s_achComment = Trim(lds_Doc_Note.GetItemString(s_iCMSLegalCounter, "comments"))
//		
//		st_message.Text = s_achComment
//
//		lds_Doc_Note.SetItem(s_iCMSLegalCounter, "comments", s_achComment)
//		lds_Doc_Note.Update()
//	Next	
//	
//	Destroy lds_Doc_Note
//
//End If	
//
//If rb_trim_misc_doc_notes.checked = True Then
//// allocate the resources for the datastores
//
//	lds_Doc_Note = Create DataStore
//			
//	lds_Doc_Note.DataObject = 'dw_rec_misc_doc_note_trim_ds'
//	lds_Doc_Note.SetTransObject(SQLCA)
//
//// Retrieve 
//	s_lCMSLegalReturnRows = lds_Doc_Note.Retrieve()
//
//	For s_iCMSLegalCounter = 1 To s_lCMSLegalReturnRows
//
//		s_achComment = Trim(lds_Doc_Note.GetItemString(s_iCMSLegalCounter, "comments"))
//		
//		st_message.Text = s_achComment
//
//		lds_Doc_Note.SetItem(s_iCMSLegalCounter, "comments", s_achComment)
//		lds_Doc_Note.Update()
//	Next	
//	
//	Destroy lds_Doc_Note
//
//End If	
//*/
//
//If rb_copy_aud_legals.checked = True Then
//// allocate the resources for the datastores
//	long s_lLegalRows
//	string s_achLegalDesc
//	datastore lds_ParcelLegal
//	
//	lds_ParcelLegal = Create DataStore
//			
//	lds_ParcelLegal.DataObject = 'dw_import_aud_legals_ds'
//	lds_ParcelLegal.SetTransObject(SQLCA)
//
//// Retrieve 
//	s_lLegalRows = lds_ParcelLegal.Retrieve()
//messagebox("rows",s_lLegalRows)
//	For s_lCount = 1 To s_lLegalRows
//
//		s_achCompleteParcelNum = Trim(lds_ParcelLegal.GetItemString(s_lCount, "complete_parcel_number"))
//		If IsNull(s_achCompleteParcelNum) Then s_achCompleteParcelNum = ""
//
//		s_achTownshipNum = Mid(s_achCompleteParcelNum,1,2)
//		s_achSectionNum = Mid(s_achCompleteParcelNum,3,2)				
//		s_achParcelBlkNum = Mid(s_achCompleteParcelNum,5,3)				
//		s_achParcelNum = Mid(s_achCompleteParcelNum,8,3)								
//		s_achBldgNum = Mid(s_achCompleteParcelNum,11,2)				
//		
//		st_message.Text = s_achCompleteParcelNum + "     " + string(s_lcount) + " of " + string(s_lLegalRows)
//	
//		SELECT legal_description INTO :s_achLegalDesc
//			FROM ut_parcel_legal
//			WHERE ut_parcel_legal.parcel_year = 2005
//			AND ut_parcel_legal.township_number = :s_achTownshipNum			
//			AND ut_parcel_legal.section_number = :s_achSectionNum						
//			AND ut_parcel_legal.parcel_blk_number = :s_achParcelBlkNum						
//			AND ut_parcel_legal.parcel_number = :s_achParcelNum									
//			AND ut_parcel_legal.bldg_number = :s_achBldgNum;		
//		If IsNull(s_achLegalDesc) Then s_achLegalDesc = ""			
//
//		UPDATE ut_parcel_legal
//			SET legal_description = :s_achLegalDesc
//			WHERE ut_parcel_legal.parcel_year = 2006
//			AND ut_parcel_legal.township_number = :s_achTownshipNum			
//			AND ut_parcel_legal.section_number = :s_achSectionNum						
//			AND ut_parcel_legal.parcel_blk_number = :s_achParcelBlkNum						
//			AND ut_parcel_legal.parcel_number = :s_achParcelNum									
//			AND ut_parcel_legal.bldg_number = :s_achBldgNum;
//		COMMIT;
//
//		UPDATE ut_parcel_year
//			SET legal_description = :s_achLegalDesc
//			WHERE ut_parcel_year.parcel_year = 2006
//			AND ut_parcel_year.township_number = :s_achTownshipNum			
//			AND ut_parcel_year.section_number = :s_achSectionNum						
//			AND ut_parcel_year.parcel_blk_number = :s_achParcelBlkNum						
//			AND ut_parcel_year.parcel_number = :s_achParcelNum									
//			AND ut_parcel_year.bldg_number = :s_achBldgNum;
//		COMMIT;
//
//	Next	
//	
//	Destroy lds_ParcelLegal
//
//End If	
//
//
//If rb_del_py_assessments.checked = True Then
//// allocate the resources for the datastores
//
//	datastore lds_SplitChild
//	long s_lSplitChildRows
//	
//	lds_SplitChild = Create DataStore
//			
//	lds_SplitChild.DataObject = 'dw_delete_py_asr_split_child_ds'
//	lds_SplitChild.SetTransObject(SQLCA)
//
//// Retrieve 
//	s_lSplitChildRows = lds_SplitChild.Retrieve(2006)
//
//	For s_lCount = 1 To s_lSplitChildRows
//
//		s_iParcelYear = lds_SplitChild.GetItemNumber(s_lCount, "parcel_year")
//		s_achTownshipNum = Trim(lds_SplitChild.GetItemString(s_lCount, "township_number"))		
//		s_achSectionNum = Trim(lds_SplitChild.GetItemString(s_lCount, "section_number"))				
//		s_achParcelBlkNum = Trim(lds_SplitChild.GetItemString(s_lCount, "parcel_blk_number"))				
//		s_achParcelNum = Trim(lds_SplitChild.GetItemString(s_lCount, "parcel_number"))						
//		s_achBldgNum = Trim(lds_SplitChild.GetItemString(s_lCount, "bldg_number"))						
//
//		s_achMessage = "Parcel #: " + &
//			String(s_iParcelYear) + " " + s_achTownshipNum + &
//			"-" + s_achSectionNum + "-" + s_achParcelBlkNum + "-" + s_achParcelNum + &
//			"-" + s_achBldgNum + "    " + string(s_lCount) + " Of " + string(s_lSplitChildRows)
//
//	
//		st_message.text = s_achMessage
//
//		DELETE asr_parcel_assessment
//			WHERE asr_parcel_assessment.parcel_year = 2006
//			AND asr_parcel_assessment.township_number = :s_achTownshipNum			
//			AND asr_parcel_assessment.section_number = :s_achSectionNum						
//			AND asr_parcel_assessment.parcel_blk_number = :s_achParcelBlkNum						
//			AND asr_parcel_assessment.parcel_number = :s_achParcelNum									
//			AND asr_parcel_assessment.bldg_number = :s_achBldgNum
//			AND asr_parcel_assessment.assess_category = 'PY';
//
//		COMMIT;
///*		
//		UPDATE ut_parcel_year
//			SET py_assess_land = 0,
//				 py_assess_improvements = 0
//			WHERE ut_parcel_year.parcel_year = 2006
//			AND ut_parcel_year.township_number = :s_achTownshipNum			
//			AND ut_parcel_year.section_number = :s_achSectionNum						
//			AND ut_parcel_year.parcel_blk_number = :s_achParcelBlkNum						
//			AND ut_parcel_year.parcel_number = :s_achParcelNum									
//			AND ut_parcel_year.bldg_number = :s_achBldgNum;
//		COMMIT;
//	*/
//	
//	Next	
//	
//	Destroy lds_SplitChild
//
//End If	
//
end event

type st_message from statictext within w_fixes4
int X=1042
int Y=522
int Width=2414
int Height=96
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=8388608
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_create_collection_ledgers from commandbutton within w_fixes4
int X=1723
int Y=627
int Width=669
int Height=64
int TabOrder=40
boolean BringToTop=true
string Text="Create Ledgers"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string s_achDWColor, s_achErrText, s_achCBType, s_achFeeType
string s_achCode, s_achLeftCode
integer s_iCount, s_iRow, s_iItemCount, s_iItemRow

long s_lCodeRows, s_lCount

datastore lds_UTCodes, lds_Ledger, lds_LedgerItem

lds_UTCodes = Create DataStore
			
lds_UTCodes.DataObject = 'dw_get_ut_codes_ds'
lds_UTCodes.SetTransObject(SQLCA)

lds_Ledger = Create DataStore
			
lds_Ledger.DataObject = 'dw_create_ledgers_ds'
lds_Ledger.SetTransObject(SQLCA)

// get ledger item records
// allocate the resources for the datastores
lds_LedgerItem = Create DataStore
	
lds_LedgerItem.DataObject = 'dw_create_ledger_items_ds'
lds_LedgerItem.SetTransObject(SQLCA)

DELETE FROM ut_ledger where dock_year = 2007;
DELETE FROM ut_ledger_item where dock_year = 2007;
commit;

// Retrieve transaction type (codes
s_lCodeRows = lds_UTCodes.Retrieve(2004, "FEE")
messagebox("s_lCodeRows",s_lCodeRows)
For s_iCount = 1 To s_lCodeRows
	
	s_achCode = Trim(lds_UTCodes.GetItemString(s_iCount,"code"))				
	If IsNull(s_achCode) Then s_achCode = ""			

	s_achLeftCode = Left(s_achCode,2)
	/*
	If s_achLeftCode = 'MS' Then
		s_achCBType = "M"
	Else
		s_achCBType = "D"
	End If
	*/
	s_achCBType = "M"
		
	st_message.Text = " Type " + s_achCode
	
	// Create Corresponding Ledger Record
	s_iRow = lds_Ledger.InsertRow(0)
	lds_Ledger.SetItem(s_iRow,"dock_year", 2007)								
	lds_Ledger.SetItem(s_iRow,"cb_type", s_achCBType)					
	lds_Ledger.SetItem(s_iRow,"fee_type", s_achCode)					
	lds_Ledger.SetItem(s_iRow,"beg_balance", 0)										
	lds_Ledger.SetItem(s_iRow,"period1", 0)																		
	lds_Ledger.SetItem(s_iRow,"period2", 0)																					
	lds_Ledger.SetItem(s_iRow,"period3", 0)																					
	lds_Ledger.SetItem(s_iRow,"period4", 0)																		
	lds_Ledger.SetItem(s_iRow,"period5", 0)																					
	lds_Ledger.SetItem(s_iRow,"period6", 0)																					
	lds_Ledger.SetItem(s_iRow,"period7", 0)																		
	lds_Ledger.SetItem(s_iRow,"period8", 0)																					
	lds_Ledger.SetItem(s_iRow,"period9", 0)																					
	lds_Ledger.SetItem(s_iRow,"period10", 0)																		
	lds_Ledger.SetItem(s_iRow,"period11", 0)																					
	lds_Ledger.SetItem(s_iRow,"period12", 0)																					
	
	For s_iItemCount = 1 To 12

		// Create new tax Ledger item record
		s_iItemRow = lds_LedgerItem.InsertRow(0)
		lds_LedgerItem.SetItem(s_iItemRow,"dock_year", 2007)
		lds_LedgerItem.SetItem(s_iItemRow,"cb_type", s_achCBType)
		lds_LedgerItem.SetItem(s_iItemRow,"fee_type", s_achCode)
		lds_LedgerItem.SetItem(s_iItemRow,"period", s_iItemCount)						
		lds_LedgerItem.SetItem(s_iItemRow,"period_bal", 0)				
		lds_LedgerItem.Update()
		COMMIT;			
	Next
	lds_Ledger.Update()						
	COMMIT;			
Next

	// Retrieve transaction type (codes
s_lCodeRows = lds_UTCodes.Retrieve(2004, "FEE")
messagebox("s_lCodeRows",s_lCodeRows)
For s_iCount = 1 To s_lCodeRows
	
	s_achCode = Trim(lds_UTCodes.GetItemString(s_iCount,"code"))				
	If IsNull(s_achCode) Then s_achCode = ""			

	s_achLeftCode = Left(s_achCode,2)
	/*
	If s_achLeftCode = 'MS' Then
		s_achCBType = "M"
	Else
		s_achCBType = "D"
	End If
	*/
	s_achCBType = "D"
		
	st_message.Text = " Type " + s_achCode
	
	// Create Corresponding Ledger Record
	s_iRow = lds_Ledger.InsertRow(0)
	lds_Ledger.SetItem(s_iRow,"dock_year", 2007)								
	lds_Ledger.SetItem(s_iRow,"cb_type", s_achCBType)					
	lds_Ledger.SetItem(s_iRow,"fee_type", s_achCode)					
	lds_Ledger.SetItem(s_iRow,"beg_balance", 0)										
	lds_Ledger.SetItem(s_iRow,"period1", 0)																		
	lds_Ledger.SetItem(s_iRow,"period2", 0)																					
	lds_Ledger.SetItem(s_iRow,"period3", 0)																					
	lds_Ledger.SetItem(s_iRow,"period4", 0)																		
	lds_Ledger.SetItem(s_iRow,"period5", 0)																					
	lds_Ledger.SetItem(s_iRow,"period6", 0)																					
	lds_Ledger.SetItem(s_iRow,"period7", 0)																		
	lds_Ledger.SetItem(s_iRow,"period8", 0)																					
	lds_Ledger.SetItem(s_iRow,"period9", 0)																					
	lds_Ledger.SetItem(s_iRow,"period10", 0)																		
	lds_Ledger.SetItem(s_iRow,"period11", 0)																					
	lds_Ledger.SetItem(s_iRow,"period12", 0)																					
	
	For s_iItemCount = 1 To 12

		// Create new tax Ledger item record
		s_iItemRow = lds_LedgerItem.InsertRow(0)
		lds_LedgerItem.SetItem(s_iItemRow,"dock_year", 2007)
		lds_LedgerItem.SetItem(s_iItemRow,"cb_type", s_achCBType)
		lds_LedgerItem.SetItem(s_iItemRow,"fee_type", s_achCode)
		lds_LedgerItem.SetItem(s_iItemRow,"period", s_iItemCount)						
		lds_LedgerItem.SetItem(s_iItemRow,"period_bal", 0)				
		lds_LedgerItem.Update()
		COMMIT;			
	Next
	lds_Ledger.Update()						
	COMMIT;			
Next

end event

type cb_create_holding_ledgers from commandbutton within w_fixes4
int X=2436
int Y=627
int Width=669
int Height=64
int TabOrder=50
boolean BringToTop=true
string Text="Create Holding Ledger"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string s_achDWColor, s_achErrText, s_achCBType, s_achFeeType
string s_achCode, s_achLeftCode
integer s_iCount, s_iRow, s_iItemCount, s_iItemRow

long s_lCodeRows, s_lCount

datastore lds_UTCodes, lds_Ledger, lds_LedgerItem

lds_UTCodes = Create DataStore
			
lds_UTCodes.DataObject = 'dw_get_ut_codes_ds'
lds_UTCodes.SetTransObject(SQLCA)

lds_Ledger = Create DataStore
			
lds_Ledger.DataObject = 'dw_create_hold_ledgers_ds'
lds_Ledger.SetTransObject(SQLCA)

// get ledger item records
// allocate the resources for the datastores
lds_LedgerItem = Create DataStore
	
lds_LedgerItem.DataObject = 'dw_create_hold_ledger_items_ds'
lds_LedgerItem.SetTransObject(SQLCA)

DELETE FROM ut_hold_ledger where dock_year = 2007;
DELETE FROM ut_hold_ledger_item where dock_year = 2007;
commit;

// Retrieve transaction type (codes
s_lCodeRows = lds_UTCodes.Retrieve(2004, "FEE")
messagebox("s_lCodeRows",s_lCodeRows)
For s_iCount = 1 To s_lCodeRows
	
	s_achCode = Trim(lds_UTCodes.GetItemString(s_iCount,"code"))				
	If IsNull(s_achCode) Then s_achCode = ""			

	s_achLeftCode = Left(s_achCode,2)
	/*
	If s_achLeftCode = 'MS' Then
		s_achCBType = "M"
	Else
		s_achCBType = "D"
	End If
	*/
	s_achCBType = "D"
		
	st_message.Text = " Type " + s_achCode
	
	// Create Corresponding Ledger Record
	s_iRow = lds_Ledger.InsertRow(0)
	lds_Ledger.SetItem(s_iRow,"dock_year", 2007)								
	lds_Ledger.SetItem(s_iRow,"cb_type", s_achCBType)					
	lds_Ledger.SetItem(s_iRow,"fee_type", s_achCode)					
	lds_Ledger.SetItem(s_iRow,"beg_balance", 0)										
	lds_Ledger.SetItem(s_iRow,"period1", 0)																		
	lds_Ledger.SetItem(s_iRow,"period2", 0)																					
	lds_Ledger.SetItem(s_iRow,"period3", 0)																					
	lds_Ledger.SetItem(s_iRow,"period4", 0)																		
	lds_Ledger.SetItem(s_iRow,"period5", 0)																					
	lds_Ledger.SetItem(s_iRow,"period6", 0)																					
	lds_Ledger.SetItem(s_iRow,"period7", 0)																		
	lds_Ledger.SetItem(s_iRow,"period8", 0)																					
	lds_Ledger.SetItem(s_iRow,"period9", 0)																					
	lds_Ledger.SetItem(s_iRow,"period10", 0)																		
	lds_Ledger.SetItem(s_iRow,"period11", 0)																					
	lds_Ledger.SetItem(s_iRow,"period12", 0)																					
	
	For s_iItemCount = 1 To 12

		// Create new tax Ledger item record
		s_iItemRow = lds_LedgerItem.InsertRow(0)
		lds_LedgerItem.SetItem(s_iItemRow,"dock_year", 2007)
		lds_LedgerItem.SetItem(s_iItemRow,"cb_type", s_achCBType)
		lds_LedgerItem.SetItem(s_iItemRow,"fee_type", s_achCode)
		lds_LedgerItem.SetItem(s_iItemRow,"period", s_iItemCount)						
		lds_LedgerItem.SetItem(s_iItemRow,"period_bal", 0)				
		lds_LedgerItem.Update()
		COMMIT;			
	Next
	lds_Ledger.Update()						
	COMMIT;			
Next

// Retrieve transaction type (codes
s_lCodeRows = lds_UTCodes.Retrieve(2004, "FEE")
messagebox("s_lCodeRows",s_lCodeRows)
For s_iCount = 1 To s_lCodeRows
	
	s_achCode = Trim(lds_UTCodes.GetItemString(s_iCount,"code"))				
	If IsNull(s_achCode) Then s_achCode = ""			

	s_achLeftCode = Left(s_achCode,2)
	/*
	If s_achLeftCode = 'MS' Then
		s_achCBType = "M"
	Else
		s_achCBType = "D"
	End If
	*/
	s_achCBType = "M"
		
	st_message.Text = " Type " + s_achCode
	
	// Create Corresponding Ledger Record
	s_iRow = lds_Ledger.InsertRow(0)
	lds_Ledger.SetItem(s_iRow,"dock_year", 2007)								
	lds_Ledger.SetItem(s_iRow,"cb_type", s_achCBType)					
	lds_Ledger.SetItem(s_iRow,"fee_type", s_achCode)					
	lds_Ledger.SetItem(s_iRow,"beg_balance", 0)										
	lds_Ledger.SetItem(s_iRow,"period1", 0)																		
	lds_Ledger.SetItem(s_iRow,"period2", 0)																					
	lds_Ledger.SetItem(s_iRow,"period3", 0)																					
	lds_Ledger.SetItem(s_iRow,"period4", 0)																		
	lds_Ledger.SetItem(s_iRow,"period5", 0)																					
	lds_Ledger.SetItem(s_iRow,"period6", 0)																					
	lds_Ledger.SetItem(s_iRow,"period7", 0)																		
	lds_Ledger.SetItem(s_iRow,"period8", 0)																					
	lds_Ledger.SetItem(s_iRow,"period9", 0)																					
	lds_Ledger.SetItem(s_iRow,"period10", 0)																		
	lds_Ledger.SetItem(s_iRow,"period11", 0)																					
	lds_Ledger.SetItem(s_iRow,"period12", 0)																					
	
	For s_iItemCount = 1 To 12

		// Create new tax Ledger item record
		s_iItemRow = lds_LedgerItem.InsertRow(0)
		lds_LedgerItem.SetItem(s_iItemRow,"dock_year", 2007)
		lds_LedgerItem.SetItem(s_iItemRow,"cb_type", s_achCBType)
		lds_LedgerItem.SetItem(s_iItemRow,"fee_type", s_achCode)
		lds_LedgerItem.SetItem(s_iItemRow,"period", s_iItemCount)						
		lds_LedgerItem.SetItem(s_iItemRow,"period_bal", 0)				
		lds_LedgerItem.Update()
		COMMIT;			
	Next
	lds_Ledger.Update()						
	COMMIT;			
Next

end event

type cb_create_de_disbursements from commandbutton within w_fixes4
int X=1035
int Y=250
int Width=695
int Height=64
int TabOrder=70
boolean BringToTop=true
string Text="Create DE Disbursements"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string s_achDWColor, s_achErrText, s_achCBType, s_achFeeType, s_achFeeNote
string s_achCode, s_achWhomDue, s_achCaseNum
integer s_iCount, s_iRow, s_iItemCount, s_iItemRow, s_iDockYear, s_iDisbCount
integer s_iCBDisYear, s_iPos, s_iFeeNum, s_iRecCount, s_iCBRecYear, s_iRCount, s_iFCount
integer s_iOpenCount
long s_lFeeRows, s_lCount, s_lDockNum, s_lCBDisNum, s_lCBRecNum, s_lRecRows
decimal {2} s_dFeeAmtRcvd
datetime s_dtRecDate

datastore lds_ReceiptFees

lds_ReceiptFees = Create DataStore
			
lds_ReceiptFees.DataObject = 'dw_get_receipt_fees_ds'
lds_ReceiptFees.SetTransObject(SQLCA)

// update fee statement
update sh_docket_fee 
set balance_due = fee_amount,
	 amount_received = 0;
COMMIT;

DELETE FROM sh_docket_disbursement;
//DELETE FROM sh_docket_fee_paid where fee_type = 'DE';
commit;

// Retrieve Due on Execution Fees
s_lFeeRows = lds_ReceiptFees.Retrieve("D", "DE")
messagebox("s_lFeeRows",s_lFeeRows)
For s_iCount = 1 To s_lFeeRows

	s_achCaseNum = ""
	s_iPos = 0
	s_dFeeAmtRcvd = 0
	s_achWhomDue = ""
	
	s_iDockYear = lds_ReceiptFees.GetItemNumber(s_iCount,"docket_year")
	If IsNull(s_iDockYear) Then s_iDockYear = 0
	
	s_lDockNum = lds_ReceiptFees.GetItemNumber(s_iCount,"docket_number")
	If IsNull(s_lDockNum) Then s_lDockNum = 0

	SELECT case_number INTO :s_achCaseNum
		FROM sh_docket
		WHERE sh_docket.docket_year = :s_iDockYear
		AND sh_docket.docket_number = :s_lDockNum;
	If IsNull(s_achCaseNum) Then s_achCaseNum = ""		
		
	s_iFeeNum = lds_ReceiptFees.GetItemNumber(s_iCount,"fee_number")
	If IsNull(s_iFeeNum) Then s_iFeeNum = 0

	s_achFeeType = Trim(lds_ReceiptFees.GetItemString(s_iCount,"fee_type"))				
	If IsNull(s_achFeeType) Then s_achFeeType = ""			

	s_achFeeNote = Trim(lds_ReceiptFees.GetItemString(s_iCount,"fee_note"))				
	If IsNull(s_achFeeNote) Then s_achFeeNote = ""			

	s_iPos = Pos(s_achFeeNote, " to ")
	s_achWhomDue = Mid(s_achFeeNote, s_iPos + 4)

	s_dFeeAmtRcvd = lds_ReceiptFees.GetItemNumber(s_iCount,"fee_amount")
	If IsNull(s_dFeeAmtRcvd) Then s_dFeeAmtRcvd = 0
	
	st_message.Text = " Docket " + String(s_iDockYear) + "-" + String(s_lDockNum) 
	
	s_iOpenCount = 0	
	SELECT COUNT(*) INTO :s_iOpenCount
		FROM sh_open_docket
		WHERE sh_open_docket.cb_type = 'D'
		AND sh_open_docket.docket_year = :s_iDockYear
		AND sh_open_docket.docket_number = :s_lDockNum;
	
	If s_iOpenCount > 0 Then
		SELECT COUNT(*) INTO :s_iDisbCount
			FROM sh_docket_disbursement
			WHERE sh_docket_disbursement.cb_type = 'D'
			AND sh_docket_disbursement.docket_year = :s_iDockYear
			AND sh_docket_disbursement.docket_number = :s_lDockNum;
		If s_iDisbCount = 0 Then
			
			s_iCBDisYear = s_iDockYear
			SELECT MAX(cbdis_number) INTO :s_lCBDisNum
				FROM sh_docket_disbursement
				WHERE sh_docket_disbursement.cbdis_year = :s_iDockYear
				AND sh_docket_disbursement.cb_type = 'D';																			
			If IsNull(s_lCBDisNum) Then s_lCBDisNum = 0
			s_lCBDisNum ++
	//messagebox("new T disb",s_lCBDisNum)		
			INSERT INTO sh_docket_disbursement
				(cb_type, docket_number, docket_year, cbdis_number, cbdis_year,
				 date_paid, amount_paid, check_number, last_name,
				 first_name, middle_name, suffix, whom_due, balance_disbursed,
				 case_number, disburse_status, disburse_date, disburse_type,
				 fee_type)
			 VALUES ('D', :s_lDockNum, :s_iDockYear, :s_lCBDisNum, :s_iCBDisYear,
				 NULL, 0, 0, :s_achWhomDue,
				 '', '', '', '', :s_dFeeAmtRcvd, 
				 :s_achCaseNum, 'O', NULL, 'O',
				 :s_achFeeType);
			If SQLCA.SQLCODE = -1 Then
				MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
				ROLLBACK;
				Return
			Else
				COMMIT;
			End If				
			
		End If
	
		UPDATE sh_docket_fee_paid
				SET cbdis_year = :s_iCBDisYear,
					 cbdis_number = :s_lCBDisNum,
					 fee_type = :s_achFeeType,
					 receipt_status = 'O'
			WHERE sh_docket_fee_paid.cb_type = 'D'
			AND sh_docket_fee_paid.docket_year = :s_iDockYear
			AND sh_docket_fee_paid.docket_number = :s_lDockNum
			AND sh_docket_fee_paid.fee_number = :s_iFeeNum;
		// error check
		If SQLCA.SQLCode = -1 Then
			MessageBox("System Error"," Update Error - " + SQLCA.SQLErrText)
			ROLLBACK;
		Else
			COMMIT;
		End If				
		
	
		UPDATE sh_docket_disbursement
				SET amount_paid = amount_paid + :s_dFeeAmtRcvd
			WHERE sh_docket_disbursement.cb_type = 'D'
			AND sh_docket_disbursement.docket_year = :s_iDockYear
			AND sh_docket_disbursement.docket_number = :s_lDockNum
			AND sh_docket_disbursement.cbdis_year = :s_iCBDisYear		
			AND sh_docket_disbursement.cbdis_number = :s_lCBDisNum;
		// error check
		If SQLCA.SQLCode = -1 Then
			MessageBox("System Error","Disburse Update Error - " + SQLCA.SQLErrText)
			ROLLBACK;
		Else
			COMMIT;
		End If				
	Else
		
		UPDATE sh_docket_fee_paid
				SET fee_type = :s_achFeeType,
					 receipt_status = 'C'
			WHERE sh_docket_fee_paid.cb_type = 'D'
			AND sh_docket_fee_paid.docket_year = :s_iDockYear
			AND sh_docket_fee_paid.docket_number = :s_lDockNum
			AND sh_docket_fee_paid.fee_number = :s_iFeeNum;
		// error check
		If SQLCA.SQLCode = -1 Then
			MessageBox("System Error"," Update Error - " + SQLCA.SQLErrText)
			ROLLBACK;
		Else
			COMMIT;
		End If				
		
	End If

Next


end event

type cb_create_ledgers from commandbutton within w_fixes4
int X=1042
int Y=186
int Width=669
int Height=64
int TabOrder=60
boolean BringToTop=true
string Text="Create Ledgers"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string s_achDWColor, s_achErrText, s_achCBType, s_achFeeType
string s_achCode, s_achLeftCode
integer s_iCount, s_iRow, s_iItemCount, s_iItemRow

long s_lCodeRows, s_lCount

datastore lds_UTCodes, lds_Ledger, lds_LedgerItem

lds_UTCodes = Create DataStore
			
lds_UTCodes.DataObject = 'dw_get_ut_codes_ds'
lds_UTCodes.SetTransObject(SQLCA)

lds_Ledger = Create DataStore
			
lds_Ledger.DataObject = 'dw_create_ledgers_ds'
lds_Ledger.SetTransObject(SQLCA)

// get ledger item records
// allocate the resources for the datastores
lds_LedgerItem = Create DataStore
	
lds_LedgerItem.DataObject = 'dw_create_ledger_items_ds'
lds_LedgerItem.SetTransObject(SQLCA)

DELETE FROM ut_ledger where dock_year = 2008;
DELETE FROM ut_ledger_item where dock_year = 2008;
commit;

// Retrieve transaction type (codes
//s_lCodeRows = lds_UTCodes.Retrieve(2004, "FEE")
messagebox("s_lCodeRows",s_lCodeRows)
For s_iCount = 1 To 1 //s_lCodeRows
	
	s_achCBType = "M"
		
//	st_message.Text = " Type " + s_achCode
	
	// Create Corresponding Ledger Record
	s_iRow = lds_Ledger.InsertRow(0)
	lds_Ledger.SetItem(s_iRow,"dock_year", 2008)								
//	lds_Ledger.SetItem(s_iRow,"cb_type", s_achCBType)					
	lds_Ledger.SetItem(s_iRow,"beg_balance", 0)										
	lds_Ledger.SetItem(s_iRow,"period1", 0)																		
	lds_Ledger.SetItem(s_iRow,"period2", 0)																					
	lds_Ledger.SetItem(s_iRow,"period3", 0)																					
	lds_Ledger.SetItem(s_iRow,"period4", 0)																		
	lds_Ledger.SetItem(s_iRow,"period5", 0)																					
	lds_Ledger.SetItem(s_iRow,"period6", 0)																					
	lds_Ledger.SetItem(s_iRow,"period7", 0)																		
	lds_Ledger.SetItem(s_iRow,"period8", 0)																					
	lds_Ledger.SetItem(s_iRow,"period9", 0)																					
	lds_Ledger.SetItem(s_iRow,"period10", 0)																		
	lds_Ledger.SetItem(s_iRow,"period11", 0)																					
	lds_Ledger.SetItem(s_iRow,"period12", 0)																					
	
	For s_iItemCount = 1 To 12

		// Create new tax Ledger item record
		s_iItemRow = lds_LedgerItem.InsertRow(0)
		lds_LedgerItem.SetItem(s_iItemRow,"dock_year", 2008)
//		lds_LedgerItem.SetItem(s_iItemRow,"cb_type", s_achCBType)
		lds_LedgerItem.SetItem(s_iItemRow,"period", s_iItemCount)						
		lds_LedgerItem.SetItem(s_iItemRow,"period_bal", 0)				
		lds_LedgerItem.Update()
		COMMIT;			
	Next
	lds_Ledger.Update()						
	COMMIT;			
Next
/*
// Retrieve transaction type (codes
//s_lCodeRows = lds_UTCodes.Retrieve(2004, "FEE")
messagebox("s_lCodeRows",s_lCodeRows)
For s_iCount = 1 To 1 //s_lCodeRows
	
	s_achCBType = "D"
		
//	st_message.Text = " Type " + s_achCode
	
	// Create Corresponding Ledger Record
	s_iRow = lds_Ledger.InsertRow(0)
	lds_Ledger.SetItem(s_iRow,"dock_year", 2008)								
	lds_Ledger.SetItem(s_iRow,"cb_type", s_achCBType)					
	lds_Ledger.SetItem(s_iRow,"beg_balance", 0)										
	lds_Ledger.SetItem(s_iRow,"period1", 0)																		
	lds_Ledger.SetItem(s_iRow,"period2", 0)																					
	lds_Ledger.SetItem(s_iRow,"period3", 0)																					
	lds_Ledger.SetItem(s_iRow,"period4", 0)																		
	lds_Ledger.SetItem(s_iRow,"period5", 0)																					
	lds_Ledger.SetItem(s_iRow,"period6", 0)																					
	lds_Ledger.SetItem(s_iRow,"period7", 0)																		
	lds_Ledger.SetItem(s_iRow,"period8", 0)																					
	lds_Ledger.SetItem(s_iRow,"period9", 0)																					
	lds_Ledger.SetItem(s_iRow,"period10", 0)																		
	lds_Ledger.SetItem(s_iRow,"period11", 0)																					
	lds_Ledger.SetItem(s_iRow,"period12", 0)																					
	
	For s_iItemCount = 1 To 12

		// Create new tax Ledger item record
		s_iItemRow = lds_LedgerItem.InsertRow(0)
		lds_LedgerItem.SetItem(s_iItemRow,"dock_year", 2008)
		lds_LedgerItem.SetItem(s_iItemRow,"cb_type", s_achCBType)
		lds_LedgerItem.SetItem(s_iItemRow,"period", s_iItemCount)						
		lds_LedgerItem.SetItem(s_iItemRow,"period_bal", 0)				
		lds_LedgerItem.Update()
		COMMIT;			
	Next
	lds_Ledger.Update()						
	COMMIT;			
Next
*/
end event

type cb_set_fee_balances from commandbutton within w_fixes4
int X=1035
int Y=317
int Width=695
int Height=64
int TabOrder=80
boolean BringToTop=true
string Text="Set Fee Balances"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string s_achDWColor, s_achErrText, s_achCBType, s_achFeeType, s_achFeeNote
string s_achCode, s_achReceiptStatus
long s_iCount, s_iRow, s_iItemCount, s_iItemRow, s_iDockYear, s_iDisbCount
integer s_iCBDisYear, s_iPos, s_iFeeNum, s_iRecCount, s_iCBRecYear, s_iRCount, s_iFCount
long s_lFeeRows, s_lCount, s_lDockNum, s_lCBDisNum, s_lCBRecNum, s_lRecRows
decimal {2} s_dFeeAmtRcvd
datetime s_dtRecDate
date s_dtDateRcvd

datastore lds_FeePaid

lds_FeePaid = Create DataStore
			
lds_FeePaid.DataObject = 'dw_get_receipt_fee_paid_ds'
lds_FeePaid.SetTransObject(SQLCA)

// update fee statement
update sh_docket_fee 
set balance_due = fee_amount,
	 amount_received = 0;
COMMIT;

// Retrieve Receipt Fee Paid Records
s_lFeeRows = lds_FeePaid.Retrieve("D")
messagebox("s_lFeeRows",s_lFeeRows)
For s_iCount = 1 To s_lFeeRows
	
	s_dFeeAmtRcvd = 0
	
	s_iDockYear = lds_FeePaid.GetItemNumber(s_iCount,"docket_year")
	If IsNull(s_iDockYear) Then s_iDockYear = 0
	
	s_lDockNum = lds_FeePaid.GetItemNumber(s_iCount,"docket_number")
	If IsNull(s_lDockNum) Then s_lDockNum = 0
	
	s_iCBRecYear = lds_FeePaid.GetItemNumber(s_iCount,"cbrec_year")
	If IsNull(s_iCBRecYear) Then s_iCBRecYear = 0
	
	s_lCBRecNum = lds_FeePaid.GetItemNumber(s_iCount,"cbrec_number")
	If IsNull(s_lCBRecNum) Then s_lCBRecNum = 0

	s_iFeeNum = lds_FeePaid.GetItemNumber(s_iCount,"fee_number")
	If IsNull(s_iFeeNum) Then s_iFeeNum = 0

	SELECT fee_type INTO :s_achFeeType
		FROM sh_docket_fee
		WHERE sh_docket_fee.cb_type = 'D'
		AND sh_docket_fee.docket_year = :s_iDockYear
		AND sh_docket_fee.docket_number = :s_lDockNum
		AND sh_docket_fee.fee_number = :s_iFeeNum;		
	If IsNull(s_achFeeType) Then s_achFeeType = ""			

	s_dFeeAmtRcvd = lds_FeePaid.GetItemNumber(s_iCount,"amount_received")
	If IsNull(s_dFeeAmtRcvd) Then s_dFeeAmtRcvd = 0

	s_dtDateRcvd = Date(lds_FeePaid.GetItemDateTime(s_iCount,"date_received"))

	st_message.Text = " Docket " + String(s_iDockYear) + "-" + String(s_lDockNum) 

	UPDATE sh_docket_fee
			SET amount_received = amount_received + :s_dFeeAmtRcvd,
				 balance_due = balance_due - :s_dFeeAmtRcvd
		WHERE sh_docket_fee.cb_type = 'D'
		AND sh_docket_fee.docket_year = :s_iDockYear
		AND sh_docket_fee.docket_number = :s_lDockNum
		AND sh_docket_fee.fee_number = :s_iFeeNum;
	// error check
	If SQLCA.SQLCode = -1 Then
		MessageBox("System Error"," Update Error - " + SQLCA.SQLErrText)
		ROLLBACK;
	Else
		COMMIT;
	End If				

	If s_dtDateRcvd < Date('2008-1-1') Then
		s_achReceiptStatus = "C"
	End If	

	If s_dtDateRcvd >= Date('2008-1-1') And &
		(s_achFeeType = "DE" Or s_achFeeType = "OP" Or s_achFeeType = "BD") Then
		s_achReceiptStatus = "C"
	End If
	
	If s_dtDateRcvd >= Date('2008-1-1') And &
		(s_achFeeType <> "DE" And s_achFeeType <> "OP" And s_achFeeType <> "BD") Then
		s_achReceiptStatus = "O"
	End If
	
	UPDATE sh_docket_receipt
			SET receipt_status = :s_achReceiptStatus
		WHERE sh_docket_receipt.cb_type = 'D'
		AND sh_docket_receipt.docket_year = :s_iDockYear
		AND sh_docket_receipt.docket_number = :s_lDockNum
		AND sh_docket_receipt.cbrec_year = :s_iCBRecYear		
		AND sh_docket_receipt.cbrec_number = :s_lCBRecNum;
	// error check
	If SQLCA.SQLCode = -1 Then
		MessageBox("System Error"," Update Receipt Error - " + SQLCA.SQLErrText)
		ROLLBACK;
	Else
		COMMIT;
	End If				
/*
	UPDATE sh_docket_fee_paid
			SET receipt_status = :s_achReceiptStatus,
			    amount_received = amount_received + :s_dFeeAmtRcvd,
				 fee_type = :s_achFeeType
		WHERE sh_docket_fee_paid.cb_type = 'D'
		AND sh_docket_fee_paid.docket_year = :s_iDockYear
		AND sh_docket_fee_paid.docket_number = :s_lDockNum
		AND sh_docket_fee_paid.cbrec_year = :s_iCBRecYear		
		AND sh_docket_fee_paid.cbrec_number = :s_lCBRecNum;		
	// error check
	If SQLCA.SQLCode = -1 Then
		MessageBox("System Error"," Update Fee Paid Error - " + SQLCA.SQLErrText)
		ROLLBACK;
	Else
		COMMIT;
	End If				
	*/

	UPDATE sh_docket_fee_paid
			SET receipt_status = :s_achReceiptStatus,
				 fee_type = :s_achFeeType
		WHERE sh_docket_fee_paid.cb_type = 'D'
		AND sh_docket_fee_paid.docket_year = :s_iDockYear
		AND sh_docket_fee_paid.docket_number = :s_lDockNum
		AND sh_docket_fee_paid.cbrec_year = :s_iCBRecYear		
		AND sh_docket_fee_paid.cbrec_number = :s_lCBRecNum;		
	// error check
	If SQLCA.SQLCode = -1 Then
		MessageBox("System Error"," Update Fee Paid Error - " + SQLCA.SQLErrText)
		ROLLBACK;
	Else
		COMMIT;
	End If				

Next


end event

type cb_import_outstanding_checks from commandbutton within w_fixes4
int X=1035
int Y=448
int Width=702
int Height=64
int TabOrder=90
boolean BringToTop=true
string Text="Import Outstanding Checks"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string s_achDWColor, s_achErrText, s_achCBType, s_achFeeType, s_achFeeNote
string s_achCode, s_achReceiptStatus
long s_iCount, s_iRow, s_lCheckNum, s_iItemRow, s_iDockYear, s_iDisbCount
integer s_iCBDisYear, s_iPos, s_iFeeNum, s_iRecCount, s_iCBRecYear, s_iRCount, s_iFCount
long s_lCheckRows, s_lCount, s_lDockNum, s_lCBDisNum, s_lCBRecNum, s_lRecRows
decimal {2} s_dAmountPaid
datetime s_dtRecDate
date s_dtDateRcvd

datastore lds_ImportChecks

lds_ImportChecks = Create DataStore
			
lds_ImportChecks.DataObject = 'dw_import_outstanding_check_ds'
lds_ImportChecks.SetTransObject(SQLCA)

//DELETE sh_docket_disbursement where cbdis_year = 2007;
//COMMIT;

// Retrieve Receipt Fee Paid Records
s_lCheckRows = lds_ImportChecks.Retrieve()
messagebox("s_lCheckRows",s_lCheckRows)
For s_iCount = 1 To s_lCheckRows
	
	s_lCheckNum = lds_ImportChecks.GetItemNumber(s_iCount,"check_number")
	If IsNull(s_lCheckNum) Then s_lCheckNum = 0
	
	s_dAmountPaid = lds_ImportChecks.GetItemNumber(s_iCount,"amount_paid")
	If IsNull(s_dAmountPaid) Then s_dAmountPaid = 0
						
	st_message.Text = " Check " + String(s_lCheckNum) 
	
	s_iCBDisYear = 2007
	SELECT MAX(cbdis_number) INTO :s_lCBDisNum
		FROM sh_docket_disbursement
		WHERE sh_docket_disbursement.cbdis_year = :s_iCBDisYear;
	If IsNull(s_lCBDisNum) Then s_lCBDisNum = 0
	s_lCBDisNum ++
//messagebox("cbdis",s_lCBDisNum)		
	INSERT INTO sh_docket_disbursement
		(cb_type, docket_number, docket_year, cbdis_number, cbdis_year,
		 date_paid, amount_paid, check_number, last_name,
		 first_name, middle_name, suffix, whom_due, balance_disbursed,
		 case_number, disburse_status, disburse_date, 
		 disburse_type, fee_type, reconcile)
	 VALUES ('D', 0, 0, :s_lCBDisNum, :s_iCBDisYear,
		 NULL, :s_dAmountPaid, :s_lCheckNum, 'Old Outstanding Check',
		 '', '', '', '', :s_dAmountPaid, 
		 'Old Case', 'W', NULL, 
		 'O', 'DE', 'N');
	If SQLCA.SQLCODE = -1 Then
		MessageBox("System Error",SQLCA.SQLERRTEXT,Stopsign!)
		ROLLBACK;
		Return
	Else
		COMMIT;
	End If				
//messagebox("cbdis",s_lCBDisNum)																			

Next


end event

type cb_set_misc_fee_balances from commandbutton within w_fixes4
int X=1042
int Y=381
int Width=695
int Height=64
int TabOrder=100
boolean BringToTop=true
string Text="Set Misc Fee Balances"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string s_achDWColor, s_achErrText, s_achCBType, s_achFeeType, s_achFeeNote
string s_achCode, s_achReceiptStatus
long s_iCount, s_iRow, s_iItemCount, s_iItemRow, s_iDockYear, s_iDisbCount
integer s_iCBDisYear, s_iPos, s_iFeeNum, s_iRecCount, s_iCBRecYear, s_iRCount, s_iFCount
long s_lFeeRows, s_lCount, s_lDockNum, s_lCBDisNum, s_lCBRecNum, s_lRecRows
decimal {2} s_dFeeAmtRcvd
datetime s_dtRecDate
date s_dtDateRcvd

datastore lds_FeePaid

lds_FeePaid = Create DataStore
			
lds_FeePaid.DataObject = 'dw_get_receipt_fee_paid_ds'
lds_FeePaid.SetTransObject(SQLCA)
/*
// update fee statement
update sh_docket_fee 
set balance_due = fee_amount,
	 amount_received = 0;
COMMIT;
*/
// Retrieve Receipt Fee Paid Records
s_lFeeRows = lds_FeePaid.Retrieve("M")
messagebox("s_lFeeRows",s_lFeeRows)
For s_iCount = 1 To s_lFeeRows
	
	s_dFeeAmtRcvd = 0
	
	s_iDockYear = lds_FeePaid.GetItemNumber(s_iCount,"docket_year")
	If IsNull(s_iDockYear) Then s_iDockYear = 0
	
	s_lDockNum = lds_FeePaid.GetItemNumber(s_iCount,"docket_number")
	If IsNull(s_lDockNum) Then s_lDockNum = 0
	
	s_iCBRecYear = lds_FeePaid.GetItemNumber(s_iCount,"cbrec_year")
	If IsNull(s_iCBRecYear) Then s_iCBRecYear = 0
	
	s_lCBRecNum = lds_FeePaid.GetItemNumber(s_iCount,"cbrec_number")
	If IsNull(s_lCBRecNum) Then s_lCBRecNum = 0

	s_iFeeNum = lds_FeePaid.GetItemNumber(s_iCount,"fee_number")
	If IsNull(s_iFeeNum) Then s_iFeeNum = 0

	SELECT fee_type INTO :s_achFeeType
		FROM sh_docket_fee
		WHERE sh_docket_fee.cb_type = 'M'
		AND sh_docket_fee.docket_year = :s_iDockYear
		AND sh_docket_fee.docket_number = :s_lDockNum
		AND sh_docket_fee.fee_number = :s_iFeeNum;		
	If IsNull(s_achFeeType) Then s_achFeeType = ""			

	s_dFeeAmtRcvd = lds_FeePaid.GetItemNumber(s_iCount,"amount_received")
	If IsNull(s_dFeeAmtRcvd) Then s_dFeeAmtRcvd = 0

	s_dtDateRcvd = Date(lds_FeePaid.GetItemDateTime(s_iCount,"date_received"))

	st_message.Text = " Docket " + String(s_iDockYear) + "-" + String(s_lDockNum) 

	UPDATE sh_docket_fee
			SET amount_received = amount_received + :s_dFeeAmtRcvd,
				 balance_due = balance_due - :s_dFeeAmtRcvd
		WHERE sh_docket_fee.cb_type = 'M'
		AND sh_docket_fee.docket_year = :s_iDockYear
		AND sh_docket_fee.docket_number = :s_lDockNum
		AND sh_docket_fee.fee_number = :s_iFeeNum;
	// error check
	If SQLCA.SQLCode = -1 Then
		MessageBox("System Error"," Update Error - " + SQLCA.SQLErrText)
		ROLLBACK;
	Else
		COMMIT;
	End If				

	If s_dtDateRcvd < Date('2008-1-1') Then
		s_achReceiptStatus = "C"
	End If	

	If s_dtDateRcvd >= Date('2008-1-1') And &
		(s_achFeeType = "DE" Or s_achFeeType = "OP" Or s_achFeeType = "BD") Then
		s_achReceiptStatus = "C"
	End If
	
	If s_dtDateRcvd >= Date('2008-1-1') And &
		(s_achFeeType <> "DE" And s_achFeeType <> "OP" And s_achFeeType <> "BD") Then
		s_achReceiptStatus = "O"
	End If
	
	UPDATE sh_docket_receipt
			SET receipt_status = :s_achReceiptStatus
		WHERE sh_docket_receipt.cb_type = 'M'
		AND sh_docket_receipt.docket_year = :s_iDockYear
		AND sh_docket_receipt.docket_number = :s_lDockNum
		AND sh_docket_receipt.cbrec_year = :s_iCBRecYear		
		AND sh_docket_receipt.cbrec_number = :s_lCBRecNum;
	// error check
	If SQLCA.SQLCode = -1 Then
		MessageBox("System Error"," Update Receipt Error - " + SQLCA.SQLErrText)
		ROLLBACK;
	Else
		COMMIT;
	End If				
/*
	UPDATE sh_docket_fee_paid
			SET receipt_status = :s_achReceiptStatus,
			    amount_received = amount_received + :s_dFeeAmtRcvd,
				 fee_type = :s_achFeeType
		WHERE sh_docket_fee_paid.cb_type = 'D'
		AND sh_docket_fee_paid.docket_year = :s_iDockYear
		AND sh_docket_fee_paid.docket_number = :s_lDockNum
		AND sh_docket_fee_paid.cbrec_year = :s_iCBRecYear		
		AND sh_docket_fee_paid.cbrec_number = :s_lCBRecNum;		
	// error check
	If SQLCA.SQLCode = -1 Then
		MessageBox("System Error"," Update Fee Paid Error - " + SQLCA.SQLErrText)
		ROLLBACK;
	Else
		COMMIT;
	End If				
	*/

	UPDATE sh_docket_fee_paid
			SET receipt_status = :s_achReceiptStatus,
				 fee_type = :s_achFeeType
		WHERE sh_docket_fee_paid.cb_type = 'M'
		AND sh_docket_fee_paid.docket_year = :s_iDockYear
		AND sh_docket_fee_paid.docket_number = :s_lDockNum
		AND sh_docket_fee_paid.cbrec_year = :s_iCBRecYear		
		AND sh_docket_fee_paid.cbrec_number = :s_lCBRecNum;		
	// error check
	If SQLCA.SQLCode = -1 Then
		MessageBox("System Error"," Update Fee Paid Error - " + SQLCA.SQLErrText)
		ROLLBACK;
	Else
		COMMIT;
	End If				

Next


end event

type cb_set_military_times from commandbutton within w_fixes4
int X=1035
int Y=118
int Width=695
int Height=64
int TabOrder=90
boolean BringToTop=true
string Text="Set Military Times"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string s_achDWColor, s_achErrText
string s_achPersonalTime, s_achPersonalAMPM, s_achSubsTime, s_achSubsAMPM, s_achCorpTime, s_achCorpAMPM
string s_achMilPersonalTime, s_achMilSubsTime, s_achMilCorpTime
long s_iRow, s_iItemCount, s_iPersonalTime, s_iSubsTime, s_iCorpTime, s_iDockYear
long s_lFeeRows, s_lCount, s_lDockNum

datastore lds_DocketServed

lds_DocketServed = Create DataStore
			
lds_DocketServed.DataObject = 'dw_get_docket_served_ds'
lds_DocketServed.SetTransObject(SQLCA)


// Retrieve Receipt Fee Paid Records
s_lFeeRows = lds_DocketServed.Retrieve()
messagebox("s_lFeeRows",s_lFeeRows)
For s_lCount = 1 To s_lFeeRows
	
	s_achPersonalTime = ""
	s_achMilPersonalTime = ""	
	s_iPersonalTime = 0
	
	s_achSubsTime = ""
	s_achMilSubsTime = ""
	s_iSubsTime = 0
	
	s_achCorpTime = ""
	s_achMilCorpTime = ""
	s_iCorpTime = 0

	s_iDockYear = lds_DocketServed.GetItemNumber(s_lCount,"docket_year")
	If IsNull(s_iDockYear) Then s_iDockYear = 0
	
	s_lDockNum = lds_DocketServed.GetItemNumber(s_lCount,"docket_number")
	If IsNull(s_lDockNum) Then s_lDockNum = 0
		
//	s_lServedNum = lds_DocketServed.GetItemNumber(s_lCount,"served_number")
//	If IsNull(s_lServedNum) Then s_lServedNum = 0

	s_achPersonalTime = Trim(lds_DocketServed.GetItemString(s_lCount,"personal_time_served"))
	If IsNull(s_achPersonalTime) Then s_achPersonalTime = ""

	s_achPersonalAMPM = Trim(lds_DocketServed.GetItemString(s_lCount,"personal_am_pm"))
	If IsNull(s_achPersonalAMPM) Then s_achPersonalAMPM = ""


	s_achSubsTime = Trim(lds_DocketServed.GetItemString(s_lCount,"subs_time_served"))
	If IsNull(s_achSubsTime) Then s_achSubsTime = ""

	s_achSubsAMPM = Trim(lds_DocketServed.GetItemString(s_lCount,"subs_am_pm"))
	If IsNull(s_achSubsAMPM) Then s_achSubsAMPM = ""

	s_achCorpTime = Trim(lds_DocketServed.GetItemString(s_lCount,"corp_time_served"))
	If IsNull(s_achCorpTime) Then s_achCorpTime = ""

	s_achCorpAMPM = Trim(lds_DocketServed.GetItemString(s_lCount,"corp_am_pm"))
	If IsNull(s_achCorpAMPM) Then s_achCorpAMPM = ""

	st_message.Text = " Year " + String(s_iDockYear) + " Docket " + String(s_lDockNum) + &
		" " + string(s_lCount) + "--" + string(s_lFeeRows)
	
	If Left(s_achPersonalTime,2) = "12" And s_achPersonalAMPM = "A" Then
		s_achPersonalTime = "00" + Right(s_achPersonalTime,2)
		lds_DocketServed.SetItem(s_lCount,"personal_military_time",s_achPersonalTime)
		
	ElseIf s_achPersonalAMPM = "P" And Left(s_achPersonalTime,2) <> "12" Then
		s_iPersonalTime = Integer(Left(s_achPersonalTime,2))
		s_iPersonalTime = s_iPersonalTime + 12 
		s_achMilPersonalTime = String(s_iPersonalTime,"00")
		s_achPersonalTime = s_achMilPersonalTime + Right(s_achPersonalTime,2)
		lds_DocketServed.SetItem(s_lCount,"personal_military_time",s_achPersonalTime)
		
	Else
		lds_DocketServed.SetItem(s_lCount,"personal_military_time",s_achPersonalTime)		
	End If

	If Left(s_achSubsTime,2) = "12" And s_achSubsAMPM = "A" Then
		s_achSubsTime = "00" + Right(s_achSubsTime,2)
		lds_DocketServed.SetItem(s_lCount,"subs_military_time",s_achSubsTime)
		
	ElseIf s_achSubsAMPM = "P" And Left(s_achSubsTime,2) <> "12" Then
		s_iSubsTime = Integer(Left(s_achSubsTime,2))
		s_iSubsTime = s_iSubsTime + 12 
		s_achMilSubsTime = String(s_iSubsTime,"00")
		s_achSubsTime = s_achMilSubsTime + Right(s_achSubsTime,2)
		lds_DocketServed.SetItem(s_lCount,"subs_military_time",s_achSubsTime)
	Else
		lds_DocketServed.SetItem(s_lCount,"subs_military_time",s_achSubsTime)
	End If

	If Left(s_achCorpTime,2) = "12" And s_achCorpAMPM = "A" Then
		s_achCorpTime = "00" + Right(s_achCorpTime,2)
		lds_DocketServed.SetItem(s_lCount,"corp_military_time",s_achCorpTime)
		
	ElseIf s_achCorpAMPM = "P" And Left(s_achCorpTime,2) <> "12" Then
		s_iCorpTime = Integer(Left(s_achCorpTime,2))
		s_iCorpTime = s_iCorpTime + 12 
		s_achMilCorpTime = String(s_iCorpTime,"00")
		s_achCorpTime = s_achMilCorpTime + Right(s_achCorpTime,2)
		lds_DocketServed.SetItem(s_lCount,"corp_military_time",s_achCorpTime)
	Else
		lds_DocketServed.SetItem(s_lCount,"corp_military_time",s_achCorpTime)
	End If
		
		
	lds_DocketServed.Update()
	COMMIT;
Next


end event

