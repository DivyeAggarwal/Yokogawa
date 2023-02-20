using ZHS402 as db from '../db/data-model';
using TimeSheetEntry from './external/TimeSheetEntry';
using ZSRVBHPS0008 from './external/ZSRVBHPS0008';
using { PlantAPI as external } from './external/PlantAPI';

service ZSRVBHPS0008Service {

    entity ZCDSEHPSB0004 as projection on ZSRVBHPS0008.ZCDSEHPSB0004; 
    entity ZCDSEHPSB0037 as projection on ZSRVBHPS0008.ZCDSEHPSB0037; 
    entity ZCDSEHPSB0038 as projection on ZSRVBHPS0008.ZCDSEHPSB0038; 
    entity ZCDSEHPSC0005 as projection on ZSRVBHPS0008.ZCDSEHPSC0005; 
    entity ZCDSEHSDB0013 as projection on ZSRVBHPS0008.ZCDSEHSDB0013; 
    entity SAP__Currencies as projection on ZSRVBHPS0008.SAP__Currencies; 
    entity SAP__UnitsOfMeasure as projection on ZSRVBHPS0008.SAP__UnitsOfMeasure; 

}
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
    entity ZTHBT0016    as projection on db.ZTHBT0016;

    // entity ZSCREEN1 {
    //     E_PARTS_NO  : String(40)
    //     @sap.creatable
    //     @sap.insertable
    //     @sap.updatable;
    //     YEOS_MNF_NO : String(5);
    //     PCKG_CD     : String(1);
    // }

    // entity ZAdobeService {
    //     pdfFile : LargeString;
    // }

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

    // entity ZABTGETPDF {
    //     pdfFile : LargeString;
    //     Message : String;
    // }
}

service ZCDSEHBTC0003
{
   // entity ZTHBT0019 as projection on db.ZTHBT0019;
       entity AccountingIndicator as projection on TimeSheetEntry.ZCDSEHCSC0003 {
        key AccountingIndicator,
            AcctIndDescription,
            Language
    }
        entity I_StatisticalKeyFigureText as projection on TimeSheetEntry.ZCDSEHFIC0006 {
        key StatisticalKeyFigure,
            StatisticalKeyFigureName
    }
    entity ServiceOrderItem as projection on TimeSheetEntry.ZCDSEHCSC0005 {
        key object_id,
            number_int,
            description_i,
            ac_indicator,
            InternalOrder
    }

    entity ServiceOrder as projection on TimeSheetEntry.ZCDSEHCSC0006 {
        key object_id,
            description_h
    }
    entity InternalOrder as projection on TimeSheetEntry.ZCDSEHPSC0007 {
        key aufnr,
            ktext
    }

    entity ReceiverWBS as projection on TimeSheetEntry.ZCDSEHPSC0008 {
        key WBSId,
            ProjectDesc,
            ProjectId
    }
    entity ReceiverCostCenter as projection on TimeSheetEntry.ZCDSEHFIC0007 {
        key CostCenter,
            CostCenterName
    }
   entity ZTHBT0019 as
        select from db.ZTHBT0019 as _assignment
        {
            key _assignment.ZPNAME @mandatory,
                _assignment.ZPFDT,
                _assignment.ZPTDT,
                _assignment.BEMOT,
                _assignment.ACINDICATORDESC @Common.ValueListForValidation,
                _assignment.EAUFNR,
                _assignment.EKOSTL,
                _assignment.COSTCENTERNAME,
                _assignment.OBJECT_ID,
                _assignment.SERVICEORDERITEM,
                _assignment.SERVORDERITEMDESC,
                //'' as description_i,
                _assignment.PWBS,
                _assignment.PARENTWBSDESC,
                //_ParentWBS.ProjectDesc as ParentWBSDescr,
                _assignment.RWBS,
                _assignment.RWBSDESC,
                //_ReceiverWBS.ProjectDesc as ReceiverWBSDesc,
                _assignment.STAGR,
                _assignment.ZTCODE,
                _assignment.ZTCODE.ZTCDS @readonly,
                _assignment.BEGDA,
                _assignment.ENDDA,
                _assignment.ZESTA,
                _assignment.ZPSTS,
                _assignment.ZPS_IDENTIFIER,
        } ;

    entity ZTHBT0020 as
        projection on db.ZTHBT0020;
    
    entity TimeSheetTemplate as select from db.ZTHBT0051 as _TimeSheetTemplate{
        key _TimeSheetTemplate.PERNR,
        key _TimeSheetTemplate.WEEK_NUMBER,
        key _TimeSheetTemplate.ZPNAME.ZPNAME,
            _TimeSheetTemplate.ZPNAME.RWBS,
            _TimeSheetTemplate.ZPNAME.RWBSDESC,
            _TimeSheetTemplate.ZPNAME.OBJECT_ID,
            _TimeSheetTemplate.ZPNAME.SERVICEORDERITEM,
            _TimeSheetTemplate.ZPNAME.SERVORDERITEMDESC,
            _TimeSheetTemplate.ZPNAME.EKOSTL,
            _TimeSheetTemplate.ZPNAME.COSTCENTERNAME,
            _TimeSheetTemplate.ZPNAME.PWBS,
            _TimeSheetTemplate.ZPNAME.PARENTWBSDESC,
            _TimeSheetTemplate.ZPNAME.ZTCODE,
            _TimeSheetTemplate.ZPNAME.ZTCODE.ZTCDS,
            _TimeSheetTemplate.ZPNAME.BEMOT,
            _TimeSheetTemplate.ZPNAME.ACINDICATORDESC,
            _TimeSheetTemplate.ZPNAME.STAGR,
            _TimeSheetTemplate.DAY1_DATE,
            _TimeSheetTemplate.DAY1_HOUR,
            _TimeSheetTemplate.DAY2_DATE,
            _TimeSheetTemplate.DAY2_HOUR,
            _TimeSheetTemplate.DAY3_DATE,
            _TimeSheetTemplate.DAY3_HOUR,
            _TimeSheetTemplate.DAY4_DATE,
            _TimeSheetTemplate.DAY4_HOUR,
            _TimeSheetTemplate.DAY5_DATE,
            _TimeSheetTemplate.DAY5_HOUR,
            _TimeSheetTemplate.DAY6_DATE,
            _TimeSheetTemplate.DAY6_HOUR,
            _TimeSheetTemplate.DAY7_DATE,
            _TimeSheetTemplate.DAY7_HOUR,

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
    entity ZTHBT0006 as projection on db.ZTHBT0006;
    entity ZTHBT0007 as projection on db.ZTHBT0007;
    entity ZTHBT0015 as projection on db.ZTHBT0015;
    entity ZTHBT0019 as projection on db.ZTHBT0019;
    entity ZTHBT0020 as projection on db.ZTHBT0020;
    entity ZTHBT0021 as projection on db.ZTHBT0021;
    entity ZTHBT0022 as projection on db.ZTHBT0022;
    entity ZTHBT0023 as projection on db.ZTHBT0023;
    entity ZTHBT0024 as projection on db.ZTHBT0024;
    entity ZTHBT0025 as projection on db.ZTHBT0025;
    entity ZTHBT0026 as projection on db.ZTHBT0026;
    entity ZTHBT0027 as projection on db.ZTHBT0027;
    entity ZTHBT0032 as projection on db.ZTHBT0032;
    entity ZTHBT0033 as projection on db.ZTHBT0033;
    entity ZTHBT0048 as projection on db.ZTHBT0048;
    entity ZTHBT0010 as projection on db.ZTHBT0010;
    entity ZTHBT0014 as projection on db.ZTHBT0014;
    entity ZTHBT0037 as projection on db.ZTHBT0037;
}

service ZCDSEHBTC0006 {
    entity ZTHBT0048 as projection on db.ZTHBT0048;
    entity ZTHBT0032 as projection on db.ZTHBT0032;
    entity ZTHBT0033 as projection on db.ZTHBT0033;

}

service ZCDSEHBTC0007 {
    entity ZTHBT0010 as projection on db.ZTHBT0010;
    entity ZTHBT0014 as projection on db.ZTHBT0014;
    entity ZTHBT0037 as projection on db.ZTHBT0037;
    entity VL_SH_H_T001 as projection on external.VL_SH_H_T001; 

    @cds.persistence.skip
    entity BOMDisplay {
    key E_DOC_TYPE: String(3) @title : 'Document Type7';
    key WERKS: String(4) @title : 'Plant';
    key E_DOC_NO: String(18) @title : 'Technical document No';
    key E_REV_NO: String(5) @title : 'Technical renewal REV No';
    key PS_GROUP_NO: String(3) @title : 'PS group No';
    FORMALIZE_DATE: Date @title : 'Formalized Date';
    CREATION_DATE: Date @title : 'Creation Date';
    }
    @cds.persistence.skip
    entity Doc_Type {
    key DOC_TYPE: String(3) @title : 'Document Type';
    }

}


service ZCDSEHBTC0009 {
    entity ZTHBT0001 as projection on db.ZTHBT0001;
    entity ZTHBT0002 as projection on db.ZTHBT0002;
    entity ZTHBT0003 as projection on db.ZTHBT0003;
    entity ZTHBT0004 as projection on db.ZTHBT0004;
    entity ZTHBT0005 as projection on db.ZTHBT0005;
    entity ZTHBT0006 as projection on db.ZTHBT0006;
    entity ZTHBT0007 as projection on db.ZTHBT0007;
    entity ZTHBT0015 as projection on db.ZTHBT0015;
}
