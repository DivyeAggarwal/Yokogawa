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
        ZTCODE: Association to ZTHBT0020 @title : 'Task Code';
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
    ZZ1_CostCategory: String;
    ZZ1_COSTOJECT: String;
}

@title : '{i18n>CreatepurchaseItemRecord}'
entity ZTHBT0027 : managed {
        PBUKR          : String(4);
        PSPHI          : String(8);
        PS_PSP_PNR     : String(8);
        MATNR          : String(40);
        ZZ1_MSCODE_PRD : String(80);
        IDNLF          : String(35);
    key MBLNR          : String(10);
    key ZEILE          : String(4);
    key MJAHR          : String(4);
        KDAUF          : String(10);
        KDPOS          : String(6);
        CPUDT_MKPF     : DateTime;
        ERFMG          : String(18);
        ERFME          : String(3);
    key SERNR          : String(18);
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