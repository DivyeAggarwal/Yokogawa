namespace ZHS402;
using { managed, cuid } from '@sap/cds/common';
using { CatalogService } from '../srv/cat-service';


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
    key ProjectID    : String;
    ActivityType : String;
    AI           : String;
    UnitPrice    : Integer;
    Currency     : String;
}
@title : '{i18n>DraftInvoice}'
entity ZTHBT0022: managed {
    key InvoiceID     : String;
    ID:             Integer;
    InvDate       : Date;
    ProjectID     : String;
    CompanyCode   : String;
    TotalAmount   : Integer;
    TaxAmount     : Integer;
    Resources      : Association to many ZTHBT0023
                      on Resources.InvoiceID = $self;
    Expense       : Association to many ZTHBT0024
                      on Expense.InvoiceID = $self;
    Material      : Association to many ZTHBT0025
                      on Material.InvoiceID = $self;
}

@title : '{i18n>DraftResources}'
entity ZTHBT0023: managed, cuid {
    InvoiceID     : Association to one ZTHBT0022;
    YearMonth     : String;
    EmpID         : Integer;
    EmpName       : String;
    Grade         : String; 
    Belongs       : String;
    Curr          : String;
    UnitPrice     : Integer;
    Hours         : Decimal(4, 2);
    BillingAmount : Integer;
}
entity ZTHBT0024: managed, cuid {
    InvoiceID     : Association to one ZTHBT0022;
    CostElement   : String;
    Note          : String;
    ItemText      : String;
    Currency      : String;
    Amount        : Integer;
    CalcType      : String;
    MarkUp        : Integer;
    BillingAmount : Integer;
}
entity ZTHBT0025: managed, cuid {
    InvoiceID     : Association to one ZTHBT0022;  
    MaterialDesc  : String;
    Currency      : String;
    UnitPrice     : Integer;
    Quan          : Integer;
    UoM           : String;
    BillingAmount : Integer;
}
entity ZTHBT0020: managed {
    key ZTcode: String(8);
        ZTcds: String(80);
        ZObject: String(16);
        Kokrs: String(4);
}
entity ZTHBT0019: managed {
    key ZPname: String(40);
        ZPfdt: Date;
        ZPtdt: Date;
        Werks: String(4);
        Stagr: String(6);
        Posid: String(24);
        EAUFNR: String(12);
        Kokrs: String(4);
        Arbpl: String(8);
        ZTcode: Association to ZTHBT0020;
        SKostl: String(10);
        EKostl: String(10);
        LStar: String(6);
        BEMOT: String(2) ;
        ObjectId: String(10);
        Kostl: String(10);
        ZCrtOn: Date;
        ZCrtBy: String(40);
        ZChnOn: Date;
        ZChnBy: String(40);
        Begda: Date;
        Endda: Date;
        Zests: String(1);
        Zpsts: String(2);


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
        ERFMG          : String(1);
        ERFME          : String(3);
    key SERNR          : String(18);
} 