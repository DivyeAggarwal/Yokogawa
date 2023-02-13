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
    Key PARTS_NO: String(40);
        PCKG_CD: String(1);
        PCKG_TYPE: String(2);
        PCKG_STYLE: String(2);
        SUPPLY_STYLE: String(2);
        PCKG_UNIT_QTY: String;
        PARTS_UNIT: String;

}

entity ZTHBT0002: managed {
    PCKG_TYPE: String(2);
    PCKG_STYLE: String(2);
    PCKG_STYLE_N: String(40);
}

entity ZTHBT0003: managed {
    key PCKG_TYPE: String(2);
        PCKG_TYPE_N: String(40);
}

entity ZTHBT0004: managed {
    key PCKG_TYPE: String(2);
    key SUPPLY_STYLE: String(4);
        SUPPLY_STYLE_N: String(40);
}

entity ZTHBT0005: managed{
    key PARTS_NO: String(18);
        E_PARTS_NO: String(40);
        SOURCE_CD: String(2);
        YEOS_MNF_NO: String(5);
        YEOS_MNF_MODEL: String(80);
        PCKG_CD: String(1);
        IND_DEMAND_SIGN: String(1);
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
    TOTALAMOUNT   : Integer;
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
    HOURS         : Decimal(4, 2);
    BILLINGAMOUNT : Integer;
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
    BILLINGAMOUNT : Integer;
}
entity ZTHBT0025: managed, cuid {
    INVOICEID     : Association to one ZTHBT0022;  
    MATERIALDESC  : String;
    CURRENCY      : String;
    UNITPRICE     : Integer;
    QUAN          : Integer;
    UOM           : String;
    BILLINGAMOUNT : Integer;
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
        COSTCENTERNAME: String(20) @title : 'Cost Center Name' @readonly;
        BEMOT: String(2) @title : 'Accounting Indicator';
        ACINDICATORDESC: String(25) @title : 'Account Indicator Description' @readonly;
        OBJECT_ID: String(10) @title : 'Service Order'; 
        BEGDA: Date @title : 'Employee Start Date';
        ENDDA: Date @title : 'Employee End Date';
        ZESTA: String(1) @title : 'Employee Status';
        ZPSTS: Boolean @title : 'Assignment Status';
        RWBS: String(24) @title : 'Receiver WBS';
        RWBSDESC: String(40) @title : 'Receiver WBS Description' @readonly;
        SERVICEORDERITEM: String(6) @title : 'Service Order Item';
        SERVORDERITEMDESC: String(40) @title : 'Service Order Item Description' @readonly;
        PWBS: String(24) @title : 'Parent WBS';
        PARENTWBSDESC: String(40) @title : 'Parent WBS Description' @readonly;
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
        CPUDT_MKPF          : DateTime;
        ERFMG               : String(18);
        ERFME               : String(3);
        CONFIRM_STATUS      : String(100);
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
}

entity ZTHBT0032 : managed {
    key MATERIALCODE : String(80);
        MODEL: String(8);
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
}

@title : '{i18n>PartsStructureMaster}'
entity ZTHBT0037 : managed {
    key WERKS: String(4) @title : 'Plant';
    key E_DOC_TYPE: String(3) @title : 'Document Type7';
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
    EFFECT_D: String(8) @title : 'Valid From';
    INVALID_D: String(8) @title : 'Valid To';
    E_TR_TYPE: String(1) @title : 'Techinical transaction type';
    PARTS_NO_EXT_SIGN: String(1) @title : 'Parts no exist sign';
}