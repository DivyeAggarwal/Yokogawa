namespace ZHS402;
using { managed, cuid } from '@sap/cds/common';
using { CatalogService } from '../srv/cat-service';
using { TimeSheetEntry } from '../srv/external/TimeSheetEntry';


entity Books {
  key ID : Integer;
  title  : String;
  stock  : Integer;
}
entity ZTHBT0001: managed {
    Key PARTS_NO: String(18) @title : 'Parts  Number';
        E_PARTS_NO: String(40) @title : 'Material Number';
        SOURCE_CD: String(2) @title : 'Source  Code';
        YEOS_MNF_NO: String(5) @title : 'Maker Model Number';
        YEOS_MNF_MODEL: String(80) @title : 'Maker Model Name';
        PCKG_CD: String(1) @title : 'Packing Code';
        IND_DEMAND_SIGN: String(1) @title : 'Ind Demand Sign';

}

entity ZTHBT0002: managed, cuid {
    PCKG_TYPE: String(2) @title : 'Packing Type';
    PCKG_STYLE: String(2) @title : 'Packing Style';
    PCKG_STYLE_N: String(40) @title : 'Packing Style Name';
}

entity ZTHBT0003: managed {
    key PCKG_TYPE: String(2) @title : 'Packing Type';
        PCKG_TYPE_N: String(40) @title : 'Packing Type Name';
}

entity ZTHBT0004: managed {
    key PCKG_TYPE: String(2) @title : 'Packing Type';
    key SUPPLY_STYLE: String(4) @title : 'Supply Style';
        SUPPLY_STYLE_N: String(40) @title : 'Supply Style Name';
}

entity ZTHBT0006: managed {
    key E_PARTS_NO: String(18) @title : 'Material Number';
        E_PARTS_N: String(20) @title : 'Parts Name';
        PARTS_TYPE: String(4) @title : 'Parts Type';
        RCMND_CLASS: String(2) @title : 'Rcmnd Class';
        MOUNT_TYPE: String(6) @title : 'Mount Type';
        SAFETY_SIGN: String(1) @title : 'Safety Sign';
        ANTIEXPLODE_SIGN: String(1) @title : 'Antiexplode Sign';
        RADIO_SIGN: String(1) @title : 'Radio Sign';
        USE_NON_COMPLAINT: String(1) @title : 'Use non complaint product Sign';
        EMC_SIGN: String(1) @title : 'Emc Sign';
        PED_SIGN: String(1) @title : 'Ped Sign';
        PARTS_UNIT: String(3) @title : 'Parts Unit';
        CLASS3_NAME: String(3) @title : 'Class Name';
        PRODUCT_TYPE: String(1) @title : 'Product Type';
}
entity ZTHBT0007: managed {
    key E_PARTS_NO: String(18) @title : 'Material Number';
    key SOURCE_CD: String(2) @title : 'Source Code';
        DATA_ST: String(1) @title : 'Data status';
        YEOS_MNF_NO: String(5) @title : 'Maker Code';
        YEOS_MNF_MODEL: String(90) @title : 'Maker Model Name';
        Y_LEVEL: String(2) @title : 'level';
        PARTS_NO_EXT_SIGN: Decimal(13, 3) @title : 'Parts No ext sign';
        MASS: String(40) @title : 'Mass';
        INVESTIGATION_UNIT: String(5) @title : 'Investigation Unit';
}

entity ZTHBT0005: managed{ 
    key E_PARTS_NO: String(40) @title : 'Material Number';
    key PCKG_CD: String(1) @title : 'Packing Code';
    PCKG_TYPE: String(2) @title : 'Packing Type';
    PCKG_STYLE: String(2) @title : 'Packing Style';
    SUPPLY_STYLE: String(2) @title : 'Supply Style';
    PCKG_UNIT_QTY: Decimal(13, 3) @title : 'Number of storage';
    PARTS_UNIT: String(3) @title : 'Parts Unit'; 
}

entity ZTHBT0015: managed{ 
    key PARTS_TYPE: String(4) @title : 'Parts Type';
        PARTS_TYPE_N: String(30) @title : 'Parts Type Name';
    PARTS_TYPE_ABB_N: String(20) @title : 'Parts Type Abb Name';
    PARTS_NO_EXT_SIGN: String(1) @title : 'Parts No ext sign'; 
}
@title : '{i18n>YEOSMakerNO}'
entity ZTHBT0016: managed{ 
    key YEOS_MNF_NO: String(5) @title : 'Makers Model Number';
        YEOS_MNF_N: String(30) @title : 'Makers Model Name';
        YEOS_MNF_N_J: String(20) @title : 'Makers Model Name J';
        YEOS_MNF_ABB_N: String(1) @title : 'Makers Model Abb'; 
}
@title : '{i18n>SalesRegistration}'
entity ZTHBT0021: managed {
    key PROJECTID    : String;
    ACTIVITYTYPE : String;
    AI           : String;
    UNITPRICE    : Integer;
    CURRENCY     : String;
}
@title : '{i18n>DraftInvoice}'
entity ZTHBT0022: managed {
    key INVOICEID     : String;
    ID:             Integer;
    INVDATE       : Date;
    PROJECTID     : String;
    COMPANYCODE   : String;
    TOTALAMOUNT   : Decimal(13, 2) @odata.Type:'Edm.String';
    TAXAMOUNT     : Integer;
    RESOURCES      : Association to many ZTHBT0023
                      on RESOURCES.INVOICEID = $self;
    EXPENSE       : Association to many ZTHBT0024
                      on EXPENSE.INVOICEID = $self;
    MATERIAL      : Association to many ZTHBT0025
                      on MATERIAL.INVOICEID = $self;
}

@title : '{i18n>DraftResources}'
entity ZTHBT0023: managed, cuid {
    INVOICEID     : Association to one ZTHBT0022;
    YEARMONTH     : String;
    EMPID         : Integer;
    EMPNAME       : String;
    GRADE         : String; 
    BELONGS       : String;
    CURR          : String;
    UNITPRICE     : Integer;
    HOURS         : Decimal(13, 2);
    BILLINGAMOUNT : Decimal(13, 2);
}
entity ZTHBT0024: managed, cuid {
    INVOICEID     : Association to one ZTHBT0022;
    COSTELEMENT   : String;
    NOTE          : String;
    ITEMTEXT      : String;
    CURRENCY      : String;
    AMOUNT        : Integer;
    CALCTYPE      : String;
    MARKUP        : Integer;
    BILLINGAMOUNT : Decimal(13, 2);
}
entity ZTHBT0025: managed, cuid {
    INVOICEID     : Association to one ZTHBT0022;  
    MATERIALDESC  : String;
    CURRENCY      : String;
    UNITPRICE     : Integer;
    QUAN          : Integer;
    UOM           : String;
    BILLINGAMOUNT : Decimal(13, 2);
}
entity ZTHBT0020: managed {
    key ZTCODE: String(8) @title : 'Task Code';
        ZTCDS: String(80) @title : 'Task Code Description';
        ZOBJECT: String(16) @title : 'Object';
        KOKRS: String(4) @title : 'Company Code';
}
entity ZTHBT0019: managed {
    key ZPNAME: String(40) @title : 'Assignment Name';
        ZPFDT: Date @title : 'Assignment Validity From Date';
        ZPTDT: Date @title : 'Assignment Validity To Date';
        STAGR: String(6) @title : 'Statistical Key Figure'; 
        EAUFNR: String(12) @title : 'Internal Order';
        ZTCODE: Association to ZTHBT0020 @assert.integrity @title : 'Task Code';
        EKOSTL: String(10) @title : 'Receiver Cost Center';
        COSTCENTERNAME: String(20) @title : 'Cost Center Name' ;
        BEMOT: String(2) @title : 'Accounting Indicator';
        ACINDICATORDESC: String(25) @title : 'Account Indicator Description' ;
        OBJECT_ID: String(10) @title : 'Service Order'; 
        BEGDA: Date @title : 'Employee Start Date';
        ENDDA: Date @title : 'Employee End Date';
        ZESTA: String(1) @title : 'Employee Status';
        ZPSTS: Boolean @title : 'Assignment Status';
        RWBS: String(24) @title : 'Receiver WBS';
        RWBSDESC: String(40) @title : 'Receiver WBS Description' ;
        SERVICEORDERITEM: String(6) @title : 'Service Order Item';
        SERVORDERITEMDESC: String(40) @title : 'Service Order Item Description' ;
        PWBS: String(24) @title : 'Parent WBS';
        PARENTWBSDESC: String(40) @title : 'Parent WBS Description' ;
        ZPS_IDENTIFIER: String(1) @title : 'Assignment Identifier';

}
entity ZTHBT0051 : managed {
    key PERNR: String(10) @title : 'Employee Number';
    key WEEK_NUMBER: Integer @title : 'WWeek Number';
    key ZPNAME: Association to ZTHBT0019 @title : 'Assignment Name';
    DAY1_DATE: Date @title : 'Date of Day1';
    DAY1_HOUR: Integer @title : 'Hours for Day1';
    DAY2_DATE: Date @title : 'Date of Day2';
    DAY2_HOUR: Integer @title : 'Hours for Day2';
    DAY3_DATE: Date @title : 'Date of Day3';
    DAY3_HOUR: Integer @title : 'Hours for Day3';
    DAY4_DATE: Date @title : 'Date of Day4';
    DAY4_HOUR: Integer @title : 'Hours for Day4';
    DAY5_DATE: Date @title : 'Date of Day5';
    DAY5_HOUR: Integer @title : 'Hours for Day5';
    DAY6_DATE: Date @title : 'Date of Day6';
    DAY6_HOUR: Integer @title : 'Hours for Day6';
    DAY7_DATE: Date @title : 'Date of Day7';
    DAY7_HOUR: Integer @title : 'Hours for Day7';

}

@title : '{i18n>WorkOrder}'
entity ZTHBT0026: cuid, managed {
    ZZ1_EMPLOYEE_ID: String;
    ZZ1_WORKORDER_ID: String;
    ZZ1_COSTCATEGORY: String;
    ZZ1_COSTOJECT: String;
}

@title : '{i18n>CreatepurchaseItemRecord}'
entity ZTHBT0027 : managed {
        PBUKR               : String(4);
        PSPHI               : String(10);
        PS_PSP_PNR          : String(24);
        MATNR               : String(40);
        ZZ1_MSCODE_PRD      : String(80);
        IDNLF               : String(35);
    key MBLNR               : String(10);
    key ZEILE               : String(4);
    key MJAHR               : String(4);
        KDAUF               : String(10);
        KDPOS               : String(6);
        CPUDT_MKPF          : Date;
        ERFMG               : String(18);
        ERFME               : String(3);
        CONFIRM_STATUS      : Integer;
        REASON_DIFF         : String(200);
    key SERNR               : String(18);
} 

entity ZTHBT0048 : managed {
        ID: Integer;
    key MSCODE : String(80);
        PRODUCTCAREER: String(8);
    key INSTRUMENTMODEL: String(18);
    key PARTSNUMBER: String(18);
    key MODEL: String(18);
    key MATERIALCODE: String(40);
        TOKUCHUFLAG: String(1);
        IDENTIFIER: String(2);
}

entity ZTHBT0032 : managed {
    key MATERIALCODE : String(80);
        MODEL: String(18);
    key SUFFIXLEVEL: String(18);
    key SUFFIXVALUE: String(18);
}

entity ZTHBT0033 : managed {
    key MSCODE : String(80);
    key PRODUCTCAREER: String(8);
    key INSTRUMENTMODEL: String(18);
    key PARTSNUMBER: String(18);
    key MODEL: String(18);
        PPLLAG: String(1);
        STATUS: String(40);
}
@title : '{i18n>PartsStructureSpecification}'
entity ZTHBT0010 : managed {
    key E_DOC_NO: String(18) @title : 'Technical document No';
    key E_REV_NO: String(5) @title : 'Technical renewal REV No';
    key PS_GROUP_NO: String(3) @title : 'PS group No';
    KEY PS_ITEM_NO: String(3) @title : 'PS Item No';
    MODEL1: String(18) @title : 'MODEL1';
    PS_SYMBOL: String(10) @title : 'PS Symbol';
    E_PART_NO: String(18) @title : 'Material number';
    PARTS_QTY: String(13) @title : 'Parts quantity';
    PARTS_QTY_UNIT: String(4) @title : 'Parts quantity unit';
    SELECT_SIGN: String(1) @title : 'Select sign';
    PARTS_USE_RATIO: String(3) @title : 'Parts use ratio';
    PS_NOTE: String(64) @title : 'PS note';
    OR_SIGN: String(1) @title : 'OR sign';
    SFIX_DIGIT_PTN: String(1) @title : 'Basic suffix digit pattern';
    SFIX_PTN: String @title : 'Suffix pattern';
    OPTION_PTN: String @title : 'Option pattern';
    PROD_CARRER: String(9) @title : 'Production carrer';
    E_TR_TYPE: String(1) @title : 'Techinical transaction type';
    PARTS_NO_EXT_SIGN: String(1) @title : 'Parts no exist sign';
    EFFECT_D: Date @title : 'Valid From';
    INVALID_D: Date @title : 'Valid To';
}

@title : '{i18n>PartsStructureTr}'
entity ZTHBT0014 : managed {
    key E_DOC_NO: String(18) @title : 'Technical document No';
    key E_REV_NO: String(5) @title : 'Technical renewal REV No';
    key PS_GROUP_NO: String(3) @title : 'PS group No';
    key PS_ITEM_NO: String(3) @title : 'PS Item No';
    PS_SYMBOL: String(10) @title : 'PS Symbol';
    E_SIGN: String(1) @title : 'E SIGN';
    M_SIGN: String(1) @title : 'M SIGN';
    PARENT_PARTS_NO: String(40) @title : 'Parts no.';
    E_PART_NO: String(40) @title : 'Material number';
    COMP_PARTS_QTY: String(13) @title : 'Parts quantity';
    COMP_PARTS_QTY_UNIT: String(4) @title : 'Parts quantity unit';
    SELECT_SIGN: String(1) @title : 'Select sign';
    PARTS_USE_RATIO: String(3) @title : 'Parts use ratio';
    PS_NOTE: String(64) @title : 'PS note';
    E_TR_TYPE: String(1) @title : 'Techinical transaction type';
    PARTS_NO_EXT_SIGN: String(1) @title : 'Parts no exist sign';
    EFFECT_D: Date @title : 'Valid From';
    INVALID_D: Date @title : 'Valid To';
}

@title : '{i18n>PartsStructureMaster}'
entity ZTHBT0037 : managed {
    key WERKS: String(4) @title : 'Plant';
    key E_DOC_TYPE: String(3) @title : 'Document Type';
    key E_DOC_NO: String(18) @title : 'Technical document No';
    key E_REV_NO: String(5) @title : 'Technical renewal REV No';
    key PS_GROUP_NO: String(3) @title : 'PS group No';
    key PS_ITEM_NO: String(3) @title : 'PS Item No';
    key MODEL: String(10) @title : 'MODEL';
    key E_SEQUENCE_NO: String(3) @title : 'Sequence No';
    PS_SYMBOL: String(10) @title : 'PS Symbol';
    E_PART_NO: String(18) @title : 'Material number';
    TEN_DIGIT_SIGN: String(1) @title : '10 Digit Sign';
    COMP_PART_NO: String(18) @title : 'Part No';
    PARTS_QTY: String(13) @title : 'Parts quantity';
    PARTS_QTY_UNIT: String(3) @title : 'Parts quantity unit';
    SELECT_SIGN: String(1) @title : 'Select sign';
    PARTS_USE_RATIO: String(3) @title : 'Parts use ratio';
    PS_NOTE: String(64) @title : 'PS note';
    OR_SIGN: String(1) @title : 'OR sign';
    SFIX_DIGIT_PTN: String(50) @title : 'Basic suffix digit pattern';
    SFIX_PTN: String @title : 'Suffix pattern';
    OPTION_PTN: String @title : 'Option pattern';
    PROD_CARRER: String(9) @title : 'Production carrer';
    EFFECT_D: Date @title : 'Valid From';
    INVALID_D: Date @title : 'Valid To';
    E_TR_TYPE: String(1) @title : 'Techinical transaction type';
    PARTS_NO_EXT_SIGN: String(1) @title : 'Parts no exist sign';
}

entity ZTHBT0009: managed {
    key YEOS_MODEL_GROUP: String(18) @title : 'Yeos Model Group';
    key FZ2_NO: String(5) @title : 'Fz2 Number';
    key FZ2_NO_SFIX: String(4) @title : 'Fz2 Number Sfix';
    E_DOC_TYPE: String(5) @title : 'Engineering Doc Type';
    E_DOC_NO: String(18) @title : 'Technical document No.';
    E_REV_NO: String(5) @title : 'Technical renewal REV No.';
    E_DOC_N: String(20) @title : 'Engineering Doc Name';
    MEDAI_TYPE: String(1) @title : 'Media Type';

}

entity ZTHBT0008: managed {
    key YEOS_MODEL_GROUP: String(18) @title : 'Yeos Model Group';
    key FZ2_NO: String(5) @title : 'Fz2 Number';
    YEOS_MODEL_GROUP_N: String(40) @title : 'Yeos Model Gp Name';
    REV_SBJCT: String(80) @title : 'Rev Sbjct';
    E_EMP_NO: String(7) @title : 'Engineering Emp Number';
    E_EMP_NAME: String(80) @title : 'Engineering Emp Name';
    E_DEPT_IN: String(60) @title : 'Engineering Dept Name';
    E_AUTHORIZED_D: String(8) @title : 'Engineering Authorized Date';
    APPLY_DATE_CD: String(1) @title : 'Apply Date Code';
    MODIFY_CAUSE: String(2) @title : 'Modify Cause';
    TRIAL_TYPE: String(2) @title : 'Trial Type';

}

entity ZTHBT0017: managed {
    key MODIFY_CAUSE: String(2) @title : 'Modify Cause';
    MODIFY_CAUSE_N: String(40) @title : 'Modify Cause N';

}
entity ZTHBT0018: managed {
    key APPLY_DATE_CD: String(1) @title : 'Apply date CD';
    APPLY_DATE_N: String(40) @title : 'Apply date Name';

}
entity ZTHBT0028: managed{
    key PRODUCTIONORDER: String(12) @title : 'Production Order';
        ZPRINT: String(1) @title : 'Print Status';
        STATUS: String(10) @title : 'Change Status';
        FTRMS_S: Date @title : 'Initial Specified Start Date';
        GLTRS_S: Date @title : 'Initial Specified Finish Date';
        FTRMS_I: Date @title : 'Initial Specified Finish Date';
        GLTRS_I: Date @title : 'Initial scheduled start date';
        FTRMS_C: Date @title : 'Initial scheduled finish date';
        GLTRS_C: Date @title : 'Changed scheduled finish date';
        ZZINDEXNO: String(8) @title : 'Index No.';  
        ZZPLANT: String(4) @title : 'Plant';
        MAT_TEXT: String(40) @title : 'Material Description';
        ZZINTERFACEFLAG: String(1) @title : 'Interface Flag';
        ZZG_PRINTED_REV: String(2) @title : 'Printed Revision of Production Order Sheet';
        ZZG_PRNTDATE: Date @title : 'Printed Date';
        ZZG_PRNTTIME: Time @title : 'Printed Time';
        ZZG_PRNTPRID: String(12) @title : 'Printed Person Id';
        PRDSTNO       : String(8)  @title: 'Prod. Start No.';
}
entity ZTHBT0058: managed {
    key REPORTID   : Integer @title : 'Report ID';
    key KEY1: String(10) @title: 'Key1';
    key KEY2: String(10) @title: 'Key2';
        PRINTERID: String(10) @title: 'Printer Id'
}

entity ZTHBT0052: managed {
    key BUKRS: String(4) @title: 'Company Code';
    key CATEGORY: String(3) @title: 'Category'
}

entity ZTHBT0056 : managed {
    key WERKS         : String(4)  @title : 'Plant';
    key MOD_ITEM      : String(18) @title : 'Module Item';
    key MOD_CODE      : String(40) @title : 'Module Code';
        BOM_CRTE_FLAG : String(1)  @title : 'BOM creation Flag';
}
entity ZTHBT0059 : managed {
        ZSD_GRPSUPP           : String(20) @title : 'Group Supplier';
    key ZWBS_ELEMENT          : String(20) @title : 'WBS Element';
        ZSD_SOWEVENT          : String(3)  @title : 'SOW Event Number';
    key ZSD_MILESTONE         : String(10) @title : 'SAP MileStone Number';
        ZSD_ACTUAL_DATE       : Date       @title : 'SAP Actual Date';
        ZSD_BILLINGPLAN_VALUE : String(16) @title : 'SAP Billing Plan Value';
    key ZFG_INVOICE_ID        : String(20) @title : 'FG Invoice ID';
        ZSD_MAIN_SONUM        : String(10) @title : 'SAP Main SO Number';
        ZSD_SO_DEBIT_NUM      : String(10) @title : 'SAP SO Debit Memo Number';
        ZSD_INV_SUBMIT_DATE   : Date       @title : 'FG Invoice submit date';
        ZSD_GROSS_VALUE       : String(16) @title : 'FG Gross Invoice Amt';
        ZSD_BILLING_DATE      : Date       @title : 'SAP SO Debit Memo Billing Date';
        ZSD_PRICING_DATE      : Date       @title : 'SAP SO Pricing Date';
        ZSD_DEBIT_DOC_DATE    : Date       @title : 'SAP SO Debit Document Date';
        ZSD_DEBIT_NET_VALUE   : String(16) @title : 'SAP SO Debit Net Value';
        ZSD_STATUS            : String(40) @title : 'Status';
        ZSD_ERROR             : String     @title : 'Error Message';

}
entity ZTHBT0029 : managed {
    key BTYPEORDER    : String(13) @title: 'B-type Prod. No';
    key BTYPEITEM     : Integer    @title: 'B-type Prod. Item No';
        DWERK         : String(4)  @title: 'Plant';
        LEVELINGGROUP : String(8)  @title: 'Leveling group';
        ARBPL         : String(8)  @title: 'Parts Work Center';
        BTYPECAT      : String(1)  @title: 'By-Order Category';
        BTYPESTATUS   : String(1)  @title: 'By-Order Parts Status';
        PRDSTNO       : String(8)  @title: 'Prod. Start No.';
        AUFNR         : String(12) @title: 'Prod. Order';
        KDAUF         : String(10) @title: 'Sales Order';
        KDPOS         : Integer    @title: 'Sales Order Item';
        COMPNO        : String(4)  @title: 'Comp No.';
        MSCODE        : String(40) @title: 'MS Code';
        GSTRP         : Date       @title: 'Basic start date';
        GLTRP         : Date       @title: 'Basic finish date';
        MATNR         : String(40) @title: 'Parts Material';
        GSMNG         : String(13) @title: 'Order quantity'; //check
        MEINS         : String(3)  @title: 'Base Unit';
        PSTTR         : Date       @title: 'Parts Planned start date';
        PLNUM         : String(10) @title: 'Parts Planned Order';
        PAUFNR        : String(12) @title: 'Parts Production Order';
        PEBELN        : String(10) @title: 'Parts PO';
        PEBELP        : String(5)  @title: 'Parts PO Item';
        BTYPENOTE     : String(20) @title: 'By-Order Parts Note';
        SYDATS        : Date       @title: 'Printed Date';
        SYTIME        : Time       @title: 'Printed Time';
        STARTTIME     : Time       @title: 'Parts Planned start time';
        UUSR          : String(12) @title: 'Changed by';
        UREPID        : String(40) @title: 'PROGRAMM';
}

entity ZTHBT0057 : managed {
    key WERKS: String(14) @title : 'Plant';
    key E_DOC_NO  : String(18) @title : 'Document No​r';
    key E_REV_NO: String(5) @title : 'Technical renewal REV No.';
    key PS_GROUP_NO: String(3) @title : 'PS group No.';
    key PS_ITEM_NO: String(3) @title : 'PS Item No.';
    key MODEL: String(10) @title : 'Model name​';
    key MATNR: String(40) @title : 'Material code at MS code level';
    key SEQ_NO: String(3) @title : 'Sequence No';
    ERROR_SEQ_NO: String(3) @title : 'Error Sequence No';
    FORMALIZE_DATE: Date @title : 'Formalization date​';
    ERROR_MSG: String(40) @title : 'Error Message​';
    PROCESS_MODE: String(1) @title : 'Process Mode';
    PROCESSED_STATUS: String(1) @title : 'Process Status';

}

entity ZTHBT0055 : managed,cuid {
    ZCABNUM:String(20) @title : 'Cabinet number';
    PBUKR: String(4) @title: 'Company code';
    PS_PSPNR: String(24) @title: 'Project Definition';
    ZMSCODE:String(50) @title : 'MS Code';	
    PS_POSNR : String(24) @title : 'WBS Element';		
    MATNR:String(40) @title : 'SAP MATERIAL';	
    ZZ1_MSCODE:String(3) @title : 'Material Type Code';
    ZIDEX:String(40) @title : 'Material Type Code Description';
    ZVMCODE:String(50) @title : 'Vendor Material code';	
    ZQTY:Decimal(13,2) @title : 'Quantity';	
    ZUT:String(5)  @title : 'Unit';		
    ZDESCRIP:String(50) @title : 'Material Description';					
    ZSER:String(20) @title : 'Serial number';		
    ZSHTP:String(20) @title : 'Ship to Party';		
    ZSHPNAME1:String(40) @title : 'Contact Ship to Name 1';	
    ZSHPNAME2:String(40) @title : 'Contact Ship to Name 2';	
    ZSHPNAME3:String(40) @title : 'Contact Ship to Name 3';	
    ZSHPNAME4:String(40) @title : 'Contact Ship to Name 4';	
    ZCONTACTTEL:String(30) @title : 'Contact ship to Telephone';		
    ZDELNOTE1:String(50) @title : 'Delivery Note1';	
    ZDELNOTE2:String(50) @title : 'Delivery Note2';	
    ZDONUM:Integer @title : 'DO Number Title';	
    ZDOITEM:String(7) @title : 'DO Number Item';	
    ZDOPDATE:Date @title : 'DO Plan Date';		
    ZDOADATE:Date @title : 'DO Actual Date';	
    ZDELFLAG:String(1) @title : 'Deletion Flag';
    ZSHPSTAT:String(1) @title : 'Shipping Status' enum {
        Shipped = 'X'
    };
    REMARKS: String(1000) @title : 'Shipping Status';
    CRITICALITY:Integer @title : 'Confirm Status'
}


entity ZTHBT0030 : managed {
    key PKNUM   : String(7) @title : 'Control Cycle';
    key PKKEY  : Int16 @title : 'Kanban Identification Number';
        REVNR   : Int16  @title : 'Revision number'; 
        PDATS   : Date @title : 'Toku Parts Delivery Date';
        PZEIT   : Time @title : 'Printed Local Time';
        PRVNR   : Int16  @title : 'Revision number which is regular printed';
}

entity ZTHBT0072: managed {
    key USERID: String(100) @title: 'User Id';
        COPIEDDATA: String(1000) @title: 'Copied Data in stringified format of selected row in ZTHBT0052 table'
}
entity ZTHBT0073: managed {
    key ZDONUM: Integer @title: 'Delivery Order Number';
        CHANGESETID: UUID @title: 'Change Set Id from Odata Batch Call'
}

entity ZTHBT0074: cuid, managed {
        PhysInvDoc: String(100) @title: 'Physical Inventory Document';
        HEADER: String @title: 'Header Data';
        ITEM: String @title: 'Item Data';
        STATUS: String @title: 'Status';
        MTYPE: String @title: 'Type';
        CLASS: String @title: 'Class';
        MNO: String @title: 'Message nO';
        MESSAGE: String @title: 'Message';
        REQ_BY: String @title: 'Message';
}

entity YARDTESTDB: managed,cuid {
    name: String(40);
    DOB: Date;
}

//Reservation Stock
entity ZTHBT0043 : managed {
    key VBELN : String(10) @title: 'Sales Document';
    key POSNR : Integer @title: 'Sales Document Item';
    key SEQNO : Integer @title: 'Sequence number';
    MATNR : String(18) @title: 'Material Number';
    ZZG_RESMS : String(80) @title: 'Reserved MS-Code';
    ZZG_RESQT : Decimal(13, 3) @title: 'Reserved quantity';
    MEINS : String(3) @title: 'Base Unit of Measure';
    ZZG_RESDAT : Date @title: 'Reserved date';
    USDQTY : Decimal(13, 3) @title: 'Used quantity';
    CTDAT : Date @title: 'Counted date';
    CTUSR : String(12) @title: 'Counted by';
    SO_CHDAT : Date @title: 'SO Changed date';
    RSVD_STAT : String(1) @title: 'Reserved status';
}
//YSTO Allotment reservation information)
entity ZTHBT0044 : managed {
    key WERKS : String(4) @title: 'Plant'; 
    key LGORT : String(4) @title: 'Storage location (of Free Stock)';
    SER_NO : String(18) @title: 'Serial Number (Free stock)';
    PLNUM : String(10) @title: 'Planned order(Allotment)';
    AUFNR : String(12) @title: 'Production order(Allotment)';
    KDAUF : String(10) @title: 'Sales order(Main SO)';
    KDPOS : Integer @title: 'Sales order item(Main SO Item)';
    ZZCOMPNO : String(4) @title: 'Component (Main SO Component)';
    ZZSERNO : String(18) @title: 'Serial number (Allotment)';
}
//ROHS INFO
entity ZTHBT0060 : managed {
    key Parts_number            : String(18) @title : 'Parts number';
    key Source_CD               : String(2)  @title : 'Source CD';
    key Rev_number              : String(3) @title : 'Rev number';
    key CSIM_Number             : String(512) @title : 'CSIM Number'; 
        MAKEMKCD                : String(64) @title : 'Maker code';
        FILEKNRN                : String(160) @title : 'Document Number';
        R6_SELKOMOKUNO          : String(3) @title : 'RoHS(6)';
        R6_KOMOKUDATA_1         : String(2400) @title : 'Supplement1';
        R6_KOMOKUDATA_2         : String(2400) @title : 'Supplement2';
        R6_KOMOKUDATA_3         : String(2400) @title : 'Supplement3';
        R10_SELKOMOKUNO         : String(3) @title : 'RoHS(10)';
        R10_KOMOKUDATA_1        : String(2400) @title : 'Supplement1';
        R10_KOMOKUDATA_2        : String(2400) @title : 'Supplement2';
        R10_KOMOKUDATA_3        : String(2400) @title : 'Supplement3';
        TOROKUHI_1              : Date @title : 'RoHS Creation Date';
        KOUSINHI_1              : Date @title : 'RoHS Change Date';
        TOROKUHI_2              : Date @title : 'Supplement Creation Date';
        KOUSINHI_2              : Date @title : 'Supplement Change Date';

}