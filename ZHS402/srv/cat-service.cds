using ZHS402 as db from '../db/data-model';
using TimeSheetEntry from './external/TimeSheetEntry';

service CatalogService {
    entity ZCDSEHCSC0003 as projection on TimeSheetEntry.ZCDSEHCSC0003 {
        key AccountingIndicator,
            AcctIndDescription
    };
}

service ZCDSEHBTC0001 {
    entity ZTHBT0001    as projection on db.ZTHBT0001;
    entity ZTHBT0002    as projection on db.ZTHBT0002;
    entity ZTHBT0003    as projection on db.ZTHBT0003;
    entity ZTHBT0004    as projection on db.ZTHBT0004;
    entity ZTHBT0005    as projection on db.ZTHBT0005;

    entity ZSCREEN1 {
        E_PARTS_NO  : String(40)
        @sap.creatable
        @sap.insertable
        @sap.updatable;
        YEOS_MNF_NO : String(5);
        PCKG_CD     : String(1);
    }

    entity ZAdobeService {
        pdfFile : LargeString;
    }

    entity ZCDSEHBT0001 as
        select from db.ZTHBT0005 {
            *
        };
}

service ZCDSEHBTC0002 {
    entity ZTHBT0021 as projection on db.ZTHBT0021;
    entity ZTHBT0022 as projection on db.ZTHBT0022;
    entity ZTHBT0023 as projection on db.ZTHBT0023;
    entity ZTHBT0024 as projection on db.ZTHBT0024;
    entity ZTHBT0025 as projection on db.ZTHBT0025;

    entity ZABTGETPDF {
        pdfFile : LargeString;
        Message : String;
    }
}

service ZCDSEHBTC0003 {
    entity ZTHBT0019     as projection on db.ZTHBT0019;
    entity ZTHBT0020     as projection on db.ZTHBT0020;

    entity ZCDSEHCSC0003 as projection on TimeSheetEntry.ZCDSEHCSC0003 {
        key AccountingIndicator,
            AcctIndDescription
    };

}

service ZCDSEHBTC0004 {
    entity ZTHBT0026 as projection on db.ZTHBT0026;
}

@protocol : 'rest'
service ZCDSEHBTC0005 {
    entity ZTHBT0027 as projection on db.ZTHBT0027;

    type UpdatePOItemSet {
        acknowledge : UpdatePOItemSet.acknowledge;
        message     : String;
    }

    @open
    type Object {}

    action UpdatePOItem(input : Object) returns UpdatePOItemSet;

    type UpdatePOItemSet.acknowledge : String enum {
        succeeded;
        failed;
    }
}

service ZCDS_ALL_ENTITIES {
    entity ZTHBT0001 as projection on db.ZTHBT0001;
    entity ZTHBT0002 as projection on db.ZTHBT0002;
    entity ZTHBT0003 as projection on db.ZTHBT0003;
    entity ZTHBT0004 as projection on db.ZTHBT0004;
    entity ZTHBT0005 as projection on db.ZTHBT0005;
    entity ZTHBT0019 as projection on db.ZTHBT0019;
    entity ZTHBT0020 as projection on db.ZTHBT0020;
    entity ZTHBT0021 as projection on db.ZTHBT0021;
    entity ZTHBT0022 as projection on db.ZTHBT0022;
    entity ZTHBT0023 as projection on db.ZTHBT0023;
    entity ZTHBT0024 as projection on db.ZTHBT0024;
    entity ZTHBT0025 as projection on db.ZTHBT0025;
    entity ZTHBT0026 as projection on db.ZTHBT0026;
}

service ZCDSEHBTC0006 {
    entity ZTHBT0048 as projection on db.ZTHBT0048;
    entity ZTHBT0032 as projection on db.ZTHBT0032;
    entity ZTHBT0033 as projection on db.ZTHBT0033;

}