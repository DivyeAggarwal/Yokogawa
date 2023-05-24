using ZHS402 as db from '../db/data-model';
using TimeSheetEntry from './external/TimeSheetEntry';
using ZSRVBHPS0008 from './external/ZSRVBHPS0008';
using {PlantAPI as external} from './external/PlantAPI';
using API_PRODUCT_SRV from './external/API_PRODUCT_SRV';
using ProductionOrder from './external/ProductionOrder';
using ZSRVBHPP0011 from './external/ZSRVBHPP0011';
using ZSRVBHPP0012 from './external/ZSRVBHPP0012';
using ZSRVBHMM0004 from './external/ZSRVBHMM0004';
using ZSRVBHPS0010 from './external/ZSRVBHPS0010';
using ZSRVBHPP0014 from './external/ZSRVBHPP0014';
using ZSRVBHPP0005 from './external/ZSRVBHPP0005';
using ZSRVBHPP0007 from './external/ZSRVBHPP0007';
using ZSRVBHPP0008 from './external/ZSRVBHPP0008';
using ZSRVBHPP0015 from './external/ZSRVBHPP0015';
using TimeSheetAPI from './external/TimeSheetAPI';
using BusinessPartner from './external/BusinessPartner';
using ProjectDetails from './external/ProjectDetails';
using ZSRVBHPS0011 from './external/ZSRVBHPS0011';


service CatalogService {
    entity ZCDSEHCSC0003                as projection on TimeSheetEntry.ZCDSEHCSC0003 {
        key AccountingIndicator,
            AcctIndDescription
    };
}

type messageType                     : String enum {
    S = 'Success';
    E = 'Error';
    I = 'Information';
    W = 'Warning';
}

entity ZCDSEBPS0005                     as
    select from db.ZTHBT0027 {
        key PBUKR,
        key PSPHI,
        key PS_PSP_PNR,
        key ZZ1_MSCODE_PRD,
        key MATNR,
            IDNLF,
            @Semantics.quantity.unitOfMeasure: 'ERFME'
            cast(
                SUM(
                    cast(
                        ERFMG as Decimal(13, 2)
                    )
                ) as             Decimal(13, 2)
            ) as ERFMG,
            ERFME,
            CONFIRM_STATUS,
            REASON_DIFF
    }
    group by
        PBUKR,
        PSPHI,
        PS_PSP_PNR,
        ZZ1_MSCODE_PRD,
        MATNR,
        IDNLF,
        ERFME,
        CONFIRM_STATUS,
        REASON_DIFF;

entity ZCDSEBPS0012                     as
    select from db.ZTHBT0027 {
        key PBUKR,
        key PSPHI,
        key PS_PSP_PNR,
        key ZZ1_MSCODE_PRD,
        key MATNR,
            IDNLF,
            SERNR,
            @Semantics.quantity.unitOfMeasure: 'ERFME'
            cast(
                SUM(
                    cast(
                        ERFMG as Decimal(13, 2)
                    )
                ) as             Decimal(13, 2)
            ) as ERFMG,
            ERFME,
            CONFIRM_STATUS,
            REASON_DIFF
    }
    group by
        PBUKR,
        PSPHI,
        PS_PSP_PNR,
        ZZ1_MSCODE_PRD,
        MATNR,
        SERNR,
        IDNLF,
        ERFME,
        CONFIRM_STATUS,
        REASON_DIFF;

entity ZCDSEBPS0007                     as
    select from db.ZTHBT0027 {
        key PBUKR,
        key PSPHI,
        key PS_PSP_PNR,
        key ZZ1_MSCODE_PRD,
        key MATNR,
            cast(
                ERFMG as Decimal(13, 2)
            ) as ERFMG,
            ERFME,
            KDAUF,
            KDPOS
    };


entity ZCDSEBPS0006                     as
    select from db.ZTHBT0055 {
        key PBUKR,
        key PS_PSPNR,
        key PS_POSNR,
        key ZMSCODE,
        key MATNR,
            cast(
                SUM(ZQTY) as Decimal(15, 2)
            ) as USEDQTY,
            ZUT
    }
    group by
        PBUKR,
        PS_PSPNR,
        PS_POSNR,
        ZMSCODE,
        MATNR,
        ZUT;

entity ZCDSEBPS0008                     as
    select from db.ZTHBT0055 {
        key PBUKR,
        key PS_PSPNR,
        key PS_POSNR,
        key ZMSCODE,
        key MATNR,
            ZQTY as USEDQTY,
            ZUT,
            ZCABNUM
    };


service ZCDSEHBTC0001 {
    entity ZTHBT0001                    as projection on db.ZTHBT0001;
    entity ZTHBT0002                    as projection on db.ZTHBT0002;
    entity ZTHBT0003                    as projection on db.ZTHBT0003;
    entity ZTHBT0004                    as projection on db.ZTHBT0004;
    entity ZTHBT0005                    as projection on db.ZTHBT0005;
    entity ZTHBT0016                    as projection on db.ZTHBT0016;

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

    entity ZCDSEHBT0001                 as
        select from db.ZTHBT0005 {
            *
        };
}

service ZCDSEHBTC0002 {
    entity ZTHBT0021                    as projection on db.ZTHBT0021;
    entity ZTHBT0022                    as projection on db.ZTHBT0022;
    entity ZTHBT0023                    as projection on db.ZTHBT0023;
    entity ZTHBT0024                    as projection on db.ZTHBT0024;
    entity ZTHBT0025                    as projection on db.ZTHBT0025;

// entity ZABTGETPDF {
//     pdfFile : LargeString;
//     Message : String;
// }
}

service ZCDSEHBTC0003 {
    // entity ZTHBT0019 as projection on db.ZTHBT0019;
    entity AccountingIndicator          as projection on TimeSheetEntry.ZCDSEHCSC0003 {
        key AccountingIndicator,
            AcctIndDescription,
            Language
    }

    entity I_StatisticalKeyFigureText   as projection on TimeSheetEntry.ZCDSEHFIC0006 {
        key StatisticalKeyFigure,
            StatisticalKeyFigureName
    }

    entity ServiceOrderItem             as projection on TimeSheetEntry.ZCDSEHCSC0005 {
        key object_id,
            number_int,
            description_i,
            ac_indicator,
            InternalOrder
    }

    entity ServiceOrder                 as projection on TimeSheetEntry.ZCDSEHCSC0006 {
        key object_id,
            description_h
    }

    entity InternalOrder                as projection on TimeSheetEntry.ZCDSEHPSC0007 {
        key aufnr,
            ktext
    }

    entity ReceiverWBSExt               as projection on TimeSheetEntry.ZCDSEHPSC0008;

    entity ReceiverWBS                  as projection on TimeSheetEntry.ZCDSEHPSC0008 {
        key WBSId,
            ProjectDesc,
            ProjectId,
            Profile,
            UserStatus,
            LevelInHierarchy,
            ProjectType
    }

    entity ReceiverCostCenter           as projection on TimeSheetEntry.ZCDSEHFIC0007 {
        key CostCenter,
            CostCenterName
    }

    entity ParentWBSExt                 as projection on TimeSheetEntry.ZCDSEHPSC0006;

    entity ParentWBS                    as projection on TimeSheetEntry.ZCDSEHPSC0006 {
        key ReceiverWBS,
        key ReceiverProjDesc,
        key ParentWBS,
            ParentProjDesc,
            LevelInHierarchy,
            ParentCompanyCode,
            projectType,
            IhpaObjFound,
            UserStatus
    }

    entity LoggedInUser                 as projection on TimeSheetEntry.CurrentLoginUser;

    entity s4TimeSheet                  as projection on TimeSheetEntry.ZCDSEHPSB0030 {
        key EMPLOYEENUMBER,
        key WEEKNUMBER,
        key COUNTER,
            CATSHOURS,
            WORKDATE,
            ACTTYPE,
            REC_CCTR,
            REC_ORDER,
            SEND_CCTR,
            SERVICE,
            WBS_ELEMENT,
            WBS_ELEMENT_DESC,
            UNIT,
            ZPNAME,
            STATUS
    }

    @cds.persistence.skip
    entity UserInfo {
        id     : String(16);
        tenant : String(100);

    }

    @cds.persistence.skip
    entity userInfoUAA {
        user_id   : String(16);
        user_name : String(100);
        email     : String(150);

    }


    entity ZTHBT0019                    as
        select from db.ZTHBT0019 as _assignment {
            key _assignment.ZPNAME          @mandatory,
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
                _assignment.ZTCODE.ZTCDS    @readonly,
                _assignment.BEGDA,
                _assignment.ENDDA,
                _assignment.ZESTA,
                _assignment.ZPSTS,
                _assignment.ZPS_IDENTIFIER,
        };

    entity ZTHBT0020                    as projection on db.ZTHBT0020;
    entity ZTHBT0051                    as projection on db.ZTHBT0051;

    entity TimeSheetTemplate            as
        select from db.ZTHBT0051 as _TimeSheetTemplate {
            key _TimeSheetTemplate.PERNR,
            key _TimeSheetTemplate.WEEK_NUMBER,
            key _TimeSheetTemplate.ZPNAME.ZPNAME as ZPNAME_ZPNAME,
                _TimeSheetTemplate.ZPNAME.ZPFDT,
                _TimeSheetTemplate.ZPNAME.ZPTDT,
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
                null                             as DAY1_COUNTER : String(12),
                _TimeSheetTemplate.DAY2_DATE,
                _TimeSheetTemplate.DAY2_HOUR,
                null                             as DAY2_COUNTER : String(12),
                _TimeSheetTemplate.DAY3_DATE,
                _TimeSheetTemplate.DAY3_HOUR,
                null                             as DAY3_COUNTER : String(12),
                _TimeSheetTemplate.DAY4_DATE,
                _TimeSheetTemplate.DAY4_HOUR,
                null                             as DAY4_COUNTER : String(12),
                _TimeSheetTemplate.DAY5_DATE,
                _TimeSheetTemplate.DAY5_HOUR,
                null                             as DAY5_COUNTER : String(12),
                _TimeSheetTemplate.DAY6_DATE,
                _TimeSheetTemplate.DAY6_HOUR,
                null                             as DAY6_COUNTER : String(12),
                _TimeSheetTemplate.DAY7_DATE,
                _TimeSheetTemplate.DAY7_HOUR,
                null                             as DAY7_COUNTER : String(12),
                null                             as SUBMITTED    : Boolean,
                null                             as RELEASED     : Boolean
        };

    type timeSheetData {
        PERNR         : String;
        WEEK_NUMBER   : Integer;
        ZPNAME_ZPNAME : String;
        DAY1_DATE     : Date;
        DAY1_HOUR     : Integer;
        DAY2_DATE     : Date;
        DAY2_HOUR     : Integer;
        DAY3_DATE     : Date;
        DAY3_HOUR     : Integer;
        DAY4_DATE     : Date;
        DAY4_HOUR     : Integer;
        DAY5_DATE     : Date;
        DAY5_HOUR     : Integer;
        DAY6_DATE     : Date;
        DAY6_HOUR     : Integer;
        DAY7_DATE     : Date;
        DAY7_HOUR     : Integer;
    }

    type timeSheetSubmitResult {
        PERNR       : String;
        WEEK_NUMBER : Integer;
        ZPNAME      : String;
        messageType : messageType;
        message     : String;
    }

    action SubmitTimeSheet(input : timeSheetData) returns timeSheetSubmitResult;

}

service ZCDSEHBTC0004 {
    entity ZTHBT0026                    as projection on db.ZTHBT0026;
}

@protocol: 'rest'
service ZCDSEHBTC0005 {
    entity ZTHBT0027                    as projection on db.ZTHBT0027;

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
    entity ZTHBT0001                    as projection on db.ZTHBT0001;
    entity ZTHBT0002                    as projection on db.ZTHBT0002;
    entity ZTHBT0003                    as projection on db.ZTHBT0003;
    entity ZTHBT0004                    as projection on db.ZTHBT0004;
    entity ZTHBT0005                    as projection on db.ZTHBT0005;
    entity ZTHBT0006                    as projection on db.ZTHBT0006;
    entity ZTHBT0007                    as projection on db.ZTHBT0007;
    entity ZTHBT0015                    as projection on db.ZTHBT0015;
    entity ZTHBT0019                    as projection on db.ZTHBT0019;
    entity ZTHBT0020                    as projection on db.ZTHBT0020;
    entity ZTHBT0021                    as projection on db.ZTHBT0021;
    entity ZTHBT0022                    as projection on db.ZTHBT0022;
    entity ZTHBT0023                    as projection on db.ZTHBT0023;
    entity ZTHBT0024                    as projection on db.ZTHBT0024;
    entity ZTHBT0025                    as projection on db.ZTHBT0025;
    entity ZTHBT0026                    as projection on db.ZTHBT0026;
    entity ZTHBT0027                    as projection on db.ZTHBT0027;
    entity ZTHBT0032                    as projection on db.ZTHBT0032;
    entity ZTHBT0033                    as projection on db.ZTHBT0033;
    entity ZTHBT0048                    as projection on db.ZTHBT0048;
    entity ZTHBT0010                    as projection on db.ZTHBT0010;
    entity ZTHBT0014                    as projection on db.ZTHBT0014;
    entity ZTHBT0037                    as projection on db.ZTHBT0037;
    entity ZTHBT0008                    as projection on db.ZTHBT0048;
    entity ZTHBT0009                    as projection on db.ZTHBT0010;
    entity ZTHBT0017                    as projection on db.ZTHBT0014;
    entity ZTHBT0018                    as projection on db.ZTHBT0018;
    entity ZTHBT0056                    as projection on db.ZTHBT0056;
    entity ZTHBT0051                    as projection on db.ZTHBT0051;
    entity ZTHBT0029                    as projection on db.ZTHBT0029;
}

service ZCDSEHBTC0006 {
    entity ZTHBT0048                    as projection on db.ZTHBT0048;
    entity ZTHBT0032                    as projection on db.ZTHBT0032;
    entity ZTHBT0033                    as projection on db.ZTHBT0033;
    entity ZCDSEHMMC0004                as projection on ZSRVBHMM0004.ZCDSEHMMC0004;

}

service ZCDSEHBTC0007 {
    entity ZTHBT0001                    as projection on db.ZTHBT0001;
    entity ZTHBT0010                    as projection on db.ZTHBT0010;
    entity ZTHBT0014                    as projection on db.ZTHBT0014;
    entity ZTHBT0037                    as projection on db.ZTHBT0037;
    entity ZTHBT0008                    as projection on db.ZTHBT0048;
    entity ZTHBT0009                    as projection on db.ZTHBT0010;
    entity ZTHBT0017                    as projection on db.ZTHBT0014;
    entity ZTHBT0018                    as projection on db.ZTHBT0018;
    entity VL_SH_H_T001                 as projection on external.VL_SH_H_T001;
    entity A_ProductPlant               as projection on API_PRODUCT_SRV.A_ProductPlant;
    entity specificationChange          as projection on db.ZTHBT0037;

    @cds.persistence.skip
    entity checkProductionPart {
        flag : Boolean;
    }

    entity DOC_NO_HELP                  as
        select
            ZTHBT0009.E_DOC_TYPE,
            ZTHBT0009.E_DOC_NO,
            ZTHBT0009.E_REV_NO,
            ZTHBT0009.E_DOC_N,
            ZTHBT0009.MEDAI_TYPE,
            ZTHBT0009.YEOS_MODEL_GROUP,
            ZTHBT0009.FZ2_NO,
            ZTHBT0008.REV_SBJCT,
            ZTHBT0017.MODIFY_CAUSE_N,
            ZTHBT0018.APPLY_DATE_N
        from db.ZTHBT0009
        join db.ZTHBT0008
            on  ZTHBT0009.YEOS_MODEL_GROUP = ZTHBT0008.YEOS_MODEL_GROUP
            and ZTHBT0009.FZ2_NO           = ZTHBT0008.FZ2_NO
        join db.ZTHBT0017
            on ZTHBT0008.MODIFY_CAUSE = ZTHBT0017.MODIFY_CAUSE
        join db.ZTHBT0018
            on ZTHBT0008.APPLY_DATE_CD = ZTHBT0018.APPLY_DATE_CD;

    entity MAIN_MODEL_HELP              as
        select
            ZTHBT0009.E_DOC_TYPE,
            ZTHBT0009.E_DOC_NO,
            ZTHBT0009.E_REV_NO,
            ZTHBT0009.E_DOC_N,
            ZTHBT0009.MEDAI_TYPE,
            ZTHBT0009.YEOS_MODEL_GROUP,
            ZTHBT0009.FZ2_NO,
            ZTHBT0008.REV_SBJCT,
            ZTHBT0017.MODIFY_CAUSE_N,
            ZTHBT0018.APPLY_DATE_N
        from db.ZTHBT0009
        join db.ZTHBT0008
            on  ZTHBT0009.YEOS_MODEL_GROUP = ZTHBT0008.YEOS_MODEL_GROUP
            and ZTHBT0009.FZ2_NO           = ZTHBT0008.FZ2_NO
        join db.ZTHBT0017
            on ZTHBT0008.MODIFY_CAUSE = ZTHBT0017.MODIFY_CAUSE
        join db.ZTHBT0018
            on ZTHBT0008.APPLY_DATE_CD = ZTHBT0018.APPLY_DATE_CD;

    @cds.persistence.skip
    entity BOMDisplay {
            E_DOC_TYPE     : String(3)  @title: 'Document Type7';
            WERKS          : String(4)  @title: 'Plant';
        key E_DOC_NO       : String(18) @title: 'Technical document No';
        key E_REV_NO       : String(5)  @title: 'Technical renewal REV No';
        key PS_GROUP_NO    : String(3)  @title: 'PS group No';
        key PS_ITEM_NO     : String(3)  @title: 'PS Item No';
            FORMALIZE_DATE : Date       @title: 'Formalized Date';
            CREATION_DATE  : Date       @title: 'Creation Date';
    }

    @cds.persistence.skip
    entity Doc_Type {
        key DOC_TYPE : String(3) @title: 'Document Type';
    }

    // entity DATAFE0 as select ZTHBT0037.E_DOC_NO, ZTHBT0037.E_REV_NO, ZTHBT0037.PS_GROUP_NO, ZTHBT0037.E_DOC_TYPE, ZTHBT0037.EFFECT_D, ZTHBT0037.INVALID_D from db.ZTHBT0010 full outer join db.ZTHBT0037
    //     on ZTHBT0010.E_DOC_NO = ZTHBT0037.E_DOC_NO
    //     and ZTHBT0010.E_REV_NO = ZTHBT0037.E_REV_NO
    //     and ZTHBT0010.PS_GROUP_NO = ZTHBT0037.PS_GROUP_NO
    //     and ZTHBT0010.PS_ITEM_NO = ZTHBT0037.PS_ITEM_NO
    //     and ZTHBT0010.MODEL1 = ZTHBT0037.MODEL where ZTHBT0037.E_DOC_TYPE = 'FE0';

    // entity DATAFE1 as select ZTHBT0037.E_DOC_NO, ZTHBT0037.E_REV_NO, ZTHBT0037.PS_GROUP_NO, ZTHBT0037.E_DOC_TYPE, ZTHBT0037.EFFECT_D, ZTHBT0037.INVALID_D from db.ZTHBT0014 full outer join db.ZTHBT0037
    //     on ZTHBT0014.E_DOC_NO = ZTHBT0037.E_DOC_NO
    //     and ZTHBT0014.E_REV_NO = ZTHBT0037.E_REV_NO
    //     and ZTHBT0014.PS_GROUP_NO = ZTHBT0037.PS_GROUP_NO
    //     and ZTHBT0014.PS_ITEM_NO = ZTHBT0037.PS_ITEM_NO where ZTHBT0037.E_DOC_TYPE = 'FE1';
    // entity DATAFE0 as projection on db.DATAFE0;


    entity DATAFE0                      as
        select from db.ZTHBT0010 as A
        left outer join db.ZTHBT0037 as B
            on  A.E_DOC_NO    = B.E_DOC_NO
            and A.E_REV_NO    = B.E_REV_NO
            and A.PS_GROUP_NO = B.PS_GROUP_NO
            and A.PS_ITEM_NO  = B.PS_ITEM_NO
            and A.MODEL1      = B.MODEL
        {

            key B.E_DOC_NO    as E_DOC_NO,
            key B.E_REV_NO    as E_REV_NO,
            key B.PS_GROUP_NO as PS_GROUP_NO,
            key B.PS_ITEM_NO  as PS_ITEM_NO,
                B.E_DOC_TYPE  as E_DOC_TYPE,
                B.WERKS       as WERKS,
                B.MODEL       as MODEL,
                B.EFFECT_D    as EFFECT_D,
                B.INVALID_D   as INVALID_D,
                ZTHBT0010 : Association[ * ] to ZCDSEHBTC0007.ZTHBT0010 on ZTHBT0010.E_DOC_NO = E_DOC_NO
        }
        where
            B.E_DOC_TYPE = 'FE0';


    entity DATAFE1                      as
        select from db.ZTHBT0014 as A
        left outer join db.ZTHBT0037 as B
            on  A.E_DOC_NO    = B.E_DOC_NO
            and A.E_REV_NO    = B.E_REV_NO
            and A.PS_GROUP_NO = B.PS_GROUP_NO
            and A.PS_ITEM_NO  = B.PS_ITEM_NO
        {

            key B.E_DOC_NO    as E_DOC_NO,
            key B.E_REV_NO    as E_REV_NO,
            key B.PS_GROUP_NO as PS_GROUP_NO,
            key B.PS_ITEM_NO  as PS_ITEM_NO,
                B.E_DOC_TYPE  as E_DOC_TYPE,
                B.WERKS       as WERKS,
                B.EFFECT_D    as EFFECT_D,
                B.INVALID_D   as INVALID_D,
                ZTHBT0014 : Association[ * ] to ZCDSEHBTC0007.ZTHBT0014 on ZTHBT0014.E_DOC_NO = E_DOC_NO
        }
        where
            B.E_DOC_TYPE = 'FE1';


}

service ZSRVBHPS0008Service {

    entity ZCDSEHPSB0004                as projection on ZSRVBHPS0008.ZCDSEHPSB0004;
    entity ZCDSEHPSB0037                as projection on ZSRVBHPS0008.ZCDSEHPSB0037;
    entity ZCDSEHPSB0038                as projection on ZSRVBHPS0008.ZCDSEHPSB0038;
    entity ZCDSEHPSC0005                as projection on ZSRVBHPS0008.ZCDSEHPSC0005;
    entity ZCDSEHSDB0013                as projection on ZSRVBHPS0008.ZCDSEHSDB0013;
    entity SAP__Currencies              as projection on ZSRVBHPS0008.SAP__Currencies;
    entity SAP__UnitsOfMeasure          as projection on ZSRVBHPS0008.SAP__UnitsOfMeasure;

}

service ZCDSEHBTC0009 {
    entity ZTHBT0001                    as projection on db.ZTHBT0001;
    entity ZTHBT0002                    as projection on db.ZTHBT0002;
    entity ZTHBT0003                    as projection on db.ZTHBT0003;
    entity ZTHBT0004                    as projection on db.ZTHBT0004;
    entity ZTHBT0005                    as projection on db.ZTHBT0005;
    entity ZTHBT0006                    as projection on db.ZTHBT0006;
    entity ZTHBT0007                    as projection on db.ZTHBT0007;
    entity ZTHBT0015                    as projection on db.ZTHBT0015;
    entity A_ProductDescription         as projection on API_PRODUCT_SRV.A_ProductDescription;
    entity A_Product                    as projection on API_PRODUCT_SRV.A_Product;

    // entity DigitPartList as select ZTHBT0001.SOURCE_CD, ZTHBT0001.YEOS_MNF_MODEL, A_ProductDescription.ProductDescription from db.ZTHBT0001 left outer join API_PRODUCT_SRV.A_ProductDescription
    //     on ZTHBT0001.E_PARTS_NO  = A_ProductDescription.Product;// where ZTHBT0007.E_PARTS_NO = '123';
    @cds.persistence.skip
    entity DigitPartList {
        PARTS_NO     : String(18) @title: 'Parts  Number';
        E_PARTS_NO   : String(40) @title: 'Material Number';
        MATERIALDESC : String(40) @title: 'Material Description';
        SOURCE_CD    : String(2)  @title: 'Source  Code';
        YEOS_MNF_NO  : String(5)  @title: 'Maker Model Number';

    }

    @cds.persistence.skip
    entity TenDigitsPartsFilter {
        key Product     : String(40)  @title: 'Material'  @Common.QuickInfo: 'Material';
            YEOS_MNF_NO : String(5)   @title: 'Maker Code';
            PCKG_CD     : String(1)   @title: 'Packing Code';
    }

    @cds.persistence.skip
    entity TenDigitsParts {
        key Product                       : String(40)  @title: 'Product'                     @Common.QuickInfo: 'Product Number';
            ProductType                   : String(4)   @title: 'Product Type'                @Common.QuickInfo: 'Product Type';
            CrossPlantStatus              : String(2)   @title: 'Cross-Plant Product Status'  @Common.QuickInfo: 'Cross-Plant Product Status';
            CrossPlantStatusValidityDate  : String(2)   @title: 'Valid from'                  @Common.QuickInfo: 'Date from which the cross-plant material status is valid';
            CreationDate                  : DateTime    @title: 'Created On'                  @Common.QuickInfo: 'Created On';
            CreatedByUser                 : String(12)  @title: 'Created By'                  @Common.QuickInfo: 'Created By';
            LastChangeDate                : DateTime    @title: 'Last Change'                 @Common.QuickInfo: 'Last Change';
            LastChangedByUser             : String(12)  @title: 'Changed By'                  @Common.QuickInfo: 'Changed By';
            LastChangeDateTime            : Timestamp   @title: 'Last Changed'                @Common.QuickInfo: 'Last Changed';
            IsMarkedForDeletion           : Boolean     @title: 'Marked for Deletion'         @Common.QuickInfo: 'Marked for Deletion';
            ProductOldID                  : String(40)  @title: 'Old product number'          @Common.QuickInfo: 'Old product number';
            GrossWeight                   : Decimal     @title: 'Gross weight'                @Common.QuickInfo: 'Gross weight';
            PurchaseOrderQuantityUnit     : String(3)   @title: 'Order Unit'                  @Common.QuickInfo: 'Order Unit';
            SourceOfSupply                : String(1)   @title: 'Source of supply'            @Common.QuickInfo: 'Source of supply';
            WeightUnit                    : String(3)   @title: 'Weight Unit'                 @Common.QuickInfo: 'Weight Unit';
            NetWeight                     : Decimal     @title: 'Net weight'                  @Common.QuickInfo: 'Net weight';
            CountryOfOrigin               : String(3)   @title: 'Cntry/Reg of Origin'         @Common.QuickInfo: 'Cntry/Reg of Origin';
            CompetitorID                  : String(10)  @title: 'Competitor'                  @Common.QuickInfo: 'Competitor';
            ProductGroup                  : String(9)   @title: 'Product Group'               @Common.QuickInfo: 'Product Group';
            BaseUnit                      : String(3)   @title: 'Base Unit of Measure'        @Common.QuickInfo: 'Base Unit of Measure';
            ItemCategoryGroup             : String(4)   @title: 'Gen. item cat. grp'          @Common.QuickInfo: 'Gen. item cat. grp';
            ProductHierarchy              : String(18)  @title: 'Product hierarchy'           @Common.QuickInfo: 'Product hierarchy';
            Division                      : String(2)   @title: 'Division'                    @Common.QuickInfo: 'Division';
            VarblPurOrdUnitIsActive       : String(1)   @title: 'Var. Order Unit'             @Common.QuickInfo: 'Var. Order Unit';
            VolumeUnit                    : String(3)   @title: 'Volume unit'                 @Common.QuickInfo: 'Volume unit';
            MaterialVolume                : Decimal     @title: 'Volume'                      @Common.QuickInfo: 'Volume';
            ANPCode                       : String(9)   @title: 'ANP Code'                    @Common.QuickInfo: 'ANP Code';
            Brand                         : String(4)   @title: 'Brand'                       @Common.QuickInfo: 'Brand';
            ProcurementRule               : String(1)   @title: 'Procurement rule'            @Common.QuickInfo: 'Procurement rule';
            ValidityStartDate             : DateTime    @title: 'Valid-From Date'             @Common.QuickInfo: 'Valid-From Date';
            LowLevelCode                  : String(3)   @title: 'Low-Level Code'              @Common.QuickInfo: 'Low-Level Code';
            ProdNoInGenProdInPrepackProd  : String(40)  @title: 'Generic Material'            @Common.QuickInfo: 'Generic Material';
            SerialIdentifierAssgmtProfile : String(4)   @title: 'Serial No. Profile'          @Common.QuickInfo: 'Serial No. Profile';
            SizeOrDimensionText           : String(32)  @title: 'Size/dimensions'             @Common.QuickInfo: 'Size/dimensions';
            IndustryStandardName          : String(18)  @title: 'Industry Std Desc.'          @Common.QuickInfo: 'Industry Std Desc.';
            ProductStandardID             : String(18)  @title: 'GTIN'                        @Common.QuickInfo: 'GTIN';
            InternationalArticleNumberCat : String(2)   @title: 'EAN category'                @Common.QuickInfo: 'EAN category';
            ProductIsConfigurable         : Boolean     @title: 'Configurable'                @Common.QuickInfo: 'Configurable';
            IsBatchManagementRequired     : Boolean     @title: 'Batch Management'            @Common.QuickInfo: 'Batch Management';
            ExternalProductGroup          : String(18)  @title: 'Ext. Product Group'          @Common.QuickInfo: 'Ext. Product Group';
            CrossPlantConfigurableProduct : String(40)  @title: 'Cross-plant CP'              @Common.QuickInfo: 'Cross-plant CP';
            SerialNoExplicitnessLevel     : String(1)   @title: 'Serialization level'         @Common.QuickInfo: 'Serialization level';
            ProductManufacturerNumber     : String(40)  @title: 'Mfr Part Number'             @Common.QuickInfo: 'Mfr Part Number';
            ManufacturerNumber            : String(10)  @title: 'Manufacturer'                @Common.QuickInfo: 'Manufacturer';
            ManufacturerPartProfile       : String(4)   @title: 'Mfr part profile'            @Common.QuickInfo: 'Mfr part profile';
            QltyMgmtInProcmtIsActive      : Boolean     @title: 'QM in Procur. Active'        @Common.QuickInfo: 'QM in Procur. Active';
            IndustrySector                : String(1)   @title: 'Industry Sector'             @Common.QuickInfo: 'Industry Sector';
            ChangeNumber                  : String(12)  @title: 'Change Number'               @Common.QuickInfo: 'Change Number';
            MaterialRevisionLevel         : String(2)   @title: 'Revision Level'              @Common.QuickInfo: 'Revision Level';
            HandlingIndicator             : String(4)   @title: 'Handling Indicator'          @Common.QuickInfo: 'Handling Indicator';
            WarehouseProductGroup         : String(4)   @title: 'WH Material Group'           @Common.QuickInfo: 'WH Material Group';
            WarehouseStorageCondition     : String(2)   @title: 'Whse Stor. Condition'        @Common.QuickInfo: 'Whse Stor. Condition';
            StandardHandlingUnitType      : String(4)   @title: 'Standard HU Type'            @Common.QuickInfo: 'Standard HU Type';
            SerialNumberProfile           : String(4)   @title: 'Serial No. Profile'          @Common.QuickInfo: 'Serial No. Profile';
            AdjustmentProfile             : String(3)   @title: 'Adjust. Profile'             @Common.QuickInfo: 'Adjust. Profile';
            PreferredUnitOfMeasure        : String(3)   @title: 'Preferred UoM'               @Common.QuickInfo: 'Preferred UoM';
            IsPilferable                  : Boolean     @title: 'Pilferable'                  @Common.QuickInfo: 'Pilferable';
            IsRelevantForHzdsSubstances   : Boolean     @title: 'Relevant for HS'             @Common.QuickInfo: 'Relevant for HS';
            QuarantinePeriod              : Decimal     @title: 'Quarant. Per.'               @Common.QuickInfo: 'Quarant. Per.';
            TimeUnitForQuarantinePeriod   : String(3)   @title: 'Time Unit'                   @Common.QuickInfo: 'Time Unit';
            QualityInspectionGroup        : String(4)   @title: 'Quality Inspec. Grp'         @Common.QuickInfo: 'Quality Inspec. Grp';
            AuthorizationGroup            : String(4)   @title: 'Authorization Group'         @Common.QuickInfo: 'Authorization Group';
            HandlingUnitType              : String(4)   @title: 'Handling Unit Type'          @Common.QuickInfo: 'Handling Unit Type';
            HasVariableTareWeight         : Boolean     @title: 'Varb. Tare Weight'           @Common.QuickInfo: 'Varb. Tare Weight';
            MaximumPackagingLength        : Decimal     @title: 'Max. Pack. Length'           @Common.QuickInfo: 'Max. Pack. Length';
            MaximumPackagingWidth         : Decimal     @title: 'Max. Pack. Width'            @Common.QuickInfo: 'Max. Pack. Width';
            MaximumPackagingHeight        : Decimal     @title: 'Max. Pack. Height'           @Common.QuickInfo: 'Max. Pack. Height';
            UnitForMaxPackagingDimensions : String(3)   @title: 'Unit of Measurement'         @Common.QuickInfo: 'Unit of Measurement';
            DangerousGoodsIndProfile      : String(3)   @title: 'DG indicator profile'        @Common.QuickInfo: 'DG indicator profile';
            ZZ1_Testfield_PRD             : String(20)  @title: 'Testfield'                   @Common.QuickInfo: 'Testfield';
            ZZ1_AliasName_PRD             : String(18)  @title: 'Alias Name'                  @Common.QuickInfo: 'Alias Name';
            ZZ1_MSCode_PRD                : String(80)  @title: 'MS Code'                     @Common.QuickInfo: 'MS Code';
            to_Description                : Association to many API_PRODUCT_SRV.A_ProductDescription;

            @Semantics.quantity.unitOfMeasure: 'PCKG_TYPE_N'
            PCKG_TYPE                     : String(2)   @title: 'Packing Type';

            @Semantics.unitOfMeasure
            PCKG_TYPE_N                   : String(40)  @title: 'Packing Type Name';

            @Semantics.quantity.unitOfMeasure: 'PCKG_STYLE_N'
            PCKG_STYLE                    : String(2)   @title: 'Packing Style';

            @Semantics.unitOfMeasure
            PCKG_STYLE_N                  : String(40)  @title: 'Packing Style Name';

            @Semantics.quantity.unitOfMeasure: 'SUPPLY_STYLE_N'
            SUPPLY_STYLE                  : String(2)   @title: 'Supply Style';

            @Semantics.unitOfMeasure
            SUPPLY_STYLE_N                : String(40)  @title: 'Supply Style Name';
            YEOS_MNF_MODEL                : String(80)  @title: 'Manufacturing Model';
            YEOS_MNF_NO                   : String(5)   @title: 'Maker Code';
            ZTHBT0001                     : Association to one ZTHBT0001;
            ZTHBT0005                     : Association to one ZTHBT0005;
    }

    entity MaterialInput                as
        select ZTHBT0006.E_PARTS_NO from db.ZTHBT0006
        left outer join db.ZTHBT0015
            on ZTHBT0006.PARTS_TYPE = ZTHBT0015.PARTS_TYPE
        where
            ZTHBT0015.PARTS_NO_EXT_SIGN = '1';

    entity MakersList                   as
        select
            ZTHBT0007.E_PARTS_NO,
            ZTHBT0007.SOURCE_CD,
            ZTHBT0007.YEOS_MNF_NO,
            ZTHBT0007.DATA_ST,
            ZTHBT0007.YEOS_MNF_MODEL,
            ZTHBT0016.YEOS_MNF_N
        from db.ZTHBT0007
        left outer join db.ZTHBT0016
            on ZTHBT0007.YEOS_MNF_NO = ZTHBT0016.YEOS_MNF_NO; // where ZTHBT0007.E_PARTS_NO = :E_PART_NO;


    entity PackingList                  as
        select
            ZTHBT0005.E_PARTS_NO,
            ZTHBT0005.PCKG_CD,
            ZTHBT0005.PCKG_TYPE,
            ZTHBT0005.PCKG_STYLE,
            ZTHBT0005.SUPPLY_STYLE,
            ZTHBT0005.PCKG_UNIT_QTY,
            ZTHBT0003.PCKG_TYPE_N,
            ZTHBT0002.PCKG_STYLE_N,
            ZTHBT0004.SUPPLY_STYLE_N
        from db.ZTHBT0005
        join db.ZTHBT0003
            on ZTHBT0005.PCKG_TYPE = ZTHBT0003.PCKG_TYPE
        join db.ZTHBT0002
            on  ZTHBT0005.PCKG_TYPE  = ZTHBT0002.PCKG_TYPE
            and ZTHBT0005.PCKG_STYLE = ZTHBT0002.PCKG_STYLE
        join db.ZTHBT0004
            on  ZTHBT0005.PCKG_TYPE    = ZTHBT0004.PCKG_TYPE
            and ZTHBT0005.SUPPLY_STYLE = ZTHBT0004.SUPPLY_STYLE;

// entity DigitPartList as
//     select from db.ZTHBT0001 {
//         *
//     };
}

service ZCDSEHBTC0010 {
    entity OperationList                as projection on ProductionOrder.ZCDSEHPPB0031;
    entity Components                   as projection on ProductionOrder.ZCDSEHPPB0020;
    entity AdditionalStatus             as projection on db.ZTHBT0028;

    entity ChildPartListCombined        as projection on ProductionOrder.ZCDSEHPPI0001 {
        key ProductionOrderNo,
            Reservation,
            MaterialNumber,
            MaterialDescriptionH,
            OrderQty,
            BaseUnitMeasure,
            StartDate,
            EndDate,
            StorageLocation,
            Reprint,
            IssueDate,
            to_Components : Association to many ProductionOrder.ZCDSEHPPB0020 on ProductionOrderNo = $projection.ProductionOrderNo
    }

    entity ProcessRecordSheetCombined   as projection on ProductionOrder.ZCDSEHPPI0004 {
        key OrderNumber,
            title,
            ProductionVersion,
            WorkCenter,
            MaterialDescription,
            TransProd,
            Model,
            Ivtryprod,
            TRWorkCenter,
            StorageLocation,
            StorageBin,
            PartsNo,
            Store,
            MfgOrderPlannedTotalQty,
            ProductionUnit,
            MfgOrderScheduledStartDate,
            MfgOrderScheduledEndDate,
            PrintD,
            RePrint,
            Scanner,
            Note,
            memo1,
            memo2,
            memo3,
            memo4,
            ReportId,
            to_OpertaionsList : Association to many ProductionOrder.ZCDSEHPPB0031 on OrderNumber = $projection.OrderNumber
    };

    entity ProductionOrderSheetCombined as projection on ProductionOrder.ZCDSEHPPI0010 {
        key OrderNumber,
            title2,
            title,
            PrssType,
            MfgOrderScheduledStartDate,
            MfgOrderScheduledEndDate,
            StorageLocation,
            Material,
            MfgOrderPlannedTotalQty,
            ProductionUnit,
            WorkCenter,
            MaterialDescription,
            PartsNo,
            InvRecAddress,
            TransProd,
            BuildingLocation,
            rwcd,
            @Semantics.quantity.unitOfMeasure: 'EntryUnit'
            EntryQty,
            @Semantics.unitOfMeasure
            EntryUnit,
            @Semantics.quantity.unitOfMeasure: 'EntryUnit2'
            TotalReqQty,
            @Semantics.unitOfMeasure
            EntryUnit2,
            StorageBin,
            MtlLocation,
            MtlPartsShelfNo,
            Ivtryprod,
            MatExplanation,
            Finish,
            PrintDate,
            RePrint,
            Machine,
            Unit5,
            Labour,
            Unit4,
            SetUp,
            Unit3,
            memo1,
            memo2,
            memo3,
            TRWorkCenter,
            ReportId,
            Scanner,
            to_OpertaionsListColumn1 : Association to many ProductionOrder.ZCDSEHPPB0031 on OrderNumber = $projection.OrderNumber,
            to_OpertaionsListColumn2 : Association to many ProductionOrder.ZCDSEHPPB0031 on OrderNumber = $projection.OrderNumber,
            to_OpertaionsListColumn3 : Association to many ProductionOrder.ZCDSEHPPB0031 on OrderNumber = $projection.OrderNumber
    };

    entity PrinterConfiguration         as projection on db.ZTHBT0058;

}

//BOM Update
service ZCDSEHBTC0011 {
    entity ZTHBT0006                    as projection on db.ZTHBT0006;
    entity ZTHBT0008                    as projection on db.ZTHBT0008;
    entity ZTHBT0009                    as projection on db.ZTHBT0009;
    entity ZTHBT0015                    as projection on db.ZTHBT0015;
    entity ZTHBT0017                    as projection on db.ZTHBT0017;
    entity ZTHBT0018                    as projection on db.ZTHBT0018;
    entity ZTHBT0037                    as projection on db.ZTHBT0037;
    entity VL_SH_H_T001                 as projection on external.VL_SH_H_T001;
    entity ZCDSEHPPB0071                as projection on ZSRVBHPP0012.ZCDSEHPPB0071

    @cds.persistence.skip
    entity ManBOMUpload {
        key Plant             : String(4)    @title: 'Plant'               @Common.QuickInfo: 'Plant';
            MainModel         : String(40)   @title: 'Main Model'          @Common.QuickInfo: 'Main Model';
            FZ2No             : String(5)    @title: 'F2Z no.'             @Common.QuickInfo: 'FZ2 no.';
            MainModelName     : String(40)   @title: 'Main Model Name'     @Common.QuickInfo: 'Main Model Name';
            ApprovedDate      : Date         @title: 'Approved date'       @Common.QuickInfo: 'Approved date';
            OperationDept     : String(60)   @title: 'Operation Dept.'     @Common.QuickInfo: 'Operation Dept.';
            Title             : String(18)   @title: 'Title'               @Common.QuickInfo: 'Title';
            ExecutionSchedule : String(2)    @title: 'Execution Schedule'  @Common.QuickInfo: 'Execution Schedule';
            RevisionReason    : String(2)    @title: 'Revision Reason'     @Common.QuickInfo: 'Revision Reason';
            ErrorFile         : String(128)  @title: 'Error file'          @Common.QuickInfo: 'Error file';
            UploadFileName    : String(128)  @title: 'Upload file'         @Common.QuickInfo: 'Upload file';
            UploadFile        : Association to many ZCDSEHPPB0071;
    }
}

service ZCDSEHBTC0012 {
    entity ZTHBT0056                    as projection on db.ZTHBT0056;
    entity VL_SH_H_T001                 as projection on external.VL_SH_H_T001;
    entity A_ProductPlant               as projection on API_PRODUCT_SRV.A_ProductPlant;

    entity materialWhereUsed            as projection on ZSRVBHPP0011.ZCDSEHPPB0070 {
        key WERKS,
        key MATNR_COM,
        key MATNR,
            MAKTX_COM,
            MTART_COM,
            POTX1_0,
            POSNR,
            SORTF,
            POTX1_19,
            MOD_CODE,
            MAKTX,
            ZZ1_MSCODE_PRD,
            MTART,
            EMENG,
            @Semantics.unitOfMeasure
            BMEIN,
            ASM,
            POTX1_22,
            SCHGT,
            POTX1_24,
            ARBPL,
            VGW01,
            @Semantics.unitOfMeasure
            VGE01,
            VMSTD,
            LEVEL_BOM,
            SEARCH_FROM,
            SCHGT_TO,
            BESKZ_TO,
            SOBSL_TO,
            LVORM_TO,
            WERKS_FROM,
            UMLGO,
            SCHGT_FROM,
            BESKZ_FROM,
            SOBSL_FROM,
            LVORM_FROM,
            @Semantics.unitOfMeasure
            BSTME,
            MEINS,
            MMSTD,
            MESSAGE,
            LIST_TYPE,
            MASTER_DATA,
    };

    entity materialWhereUsedMaster      as projection on ZSRVBHPP0011.ZCDSEHPPB0070 {
        key WERKS,
        key MATNR_COM,
        key MATNR,
            MAKTX_COM,
            MTART_COM,
            POTX1_0,
            POSNR,
            SORTF,
            POTX1_19,
            MOD_CODE,
            MAKTX,
            ZZ1_MSCODE_PRD,
            MTART,
            EMENG,
            @Semantics.unitOfMeasure
            BMEIN,
            ASM,
            POTX1_22,
            SCHGT,
            POTX1_24,
            ARBPL,
            VGW01,
            @Semantics.unitOfMeasure
            VGE01,
            VMSTD,
            LEVEL_BOM,
            SEARCH_FROM,
            SCHGT_TO,
            BESKZ_TO,
            SOBSL_TO,
            LVORM_TO,
            WERKS_FROM,
            UMLGO,
            SCHGT_FROM,
            BESKZ_FROM,
            SOBSL_FROM,
            LVORM_FROM,
            @Semantics.unitOfMeasure
            BSTME,
            MEINS,
            MMSTD,
            MESSAGE,
            LIST_TYPE,
            MASTER_DATA,
    };

}

service ZCDSEHBTC0013 {
    entity ZTHBT0059                    as projection on db.ZTHBT0059;
    entity ZCDSEBPS0014                 as projection on db.ZTHBT0059;
    entity ZCDSEHPSC0011                as projection on ZSRVBHPS0010.ZCDSEHPSC0011;
}

//8410 Reserve Stock
service ZCDSEHBTC0014 {
    entity ZCDSEHPPP0004                as projection on ZSRVBHPP0014.ZCDSEHPPP0004;
    entity A_ProductDescription         as projection on API_PRODUCT_SRV.A_ProductDescription;
    entity A_Product                    as projection on API_PRODUCT_SRV.A_Product;
}

service ZAPIBPS0001 {
    entity ZCDSEBPS0001                 as projection on BusinessPartner.A_Customer {
        Customer,
        CustomerFullName
    }

    entity ZCDSEBPS0002                 as projection on ProjectDetails.ZCDSEHPSC0002 {
        ProjectId,
        ProjDesc,
        ApproverPM
    };
    entity ZTHBT0055 as projection on db.ZTHBT0055;
    entity ZCDSEBPS0013                 as
        select from db.ZTHBT0055 {
         key ID,
             ZCABNUM,
            PBUKR,
            PS_PSPNR,
            ZMSCODE,
            ZQTY,
            ZUT,
            ZSHTP,
            ZDONUM,
            ZDESCRIP,
            ZDOPDATE,
            ZSHPSTAT,
            ZDOITEM,
            MATNR,
            ZVMCODE,
            ZCONTACTTEL,
            ZSHPNAME1,
            ZSHPNAME2,
            ZSHPNAME3,
            ZSHPNAME4,
            null as ProjectManager   : String(50)  @title: 'Project Manager',
            null as CustomerFullName : String(100) @title: 'Ship To Party Name',
            null as ProjDesc         : String(50)  @title: 'Project Description'
        };

    entity ZCDSEBPS0003                 as
        select from db.ZTHBT0055 {
            ZCABNUM,
            PBUKR,
            PS_PSPNR,
            ZMSCODE,
            ZQTY,
            ZUT,
            ZSHTP,
            ZDONUM,
            ZDESCRIP,
            ZSHPSTAT,
            null as ProjectManager   : String(50)  @title: 'Project Manager',
            null as CustomerFullName : String(100) @title: 'Ship To Party Name',
            null as ProjDesc         : String(50)  @title: 'Project Description'
        }

        actions {
            action pgi();
        }
}

service ZCDSEHBTC0015 {
    entity ZTHBT0029                    as projection on db.ZTHBT0029;
    entity VL_SH_H_T001                 as projection on external.VL_SH_H_T001;

    @cds.persistence.skip
    entity OrderPartInformation {
        key Product    : String(40)  @title: 'Material'  @Common.QuickInfo: 'Material';
            DWERK      : String(4)   @title: 'Plant';
            BTYPECAT   : String(1)   @title: 'By-Order Category';
            MRPCONT    : String(12)  @title: 'MRP Controller';
            PLNUM      : String(10)  @title: 'Parts Planned Order';
            GSTRP      : Date        @title: 'Basic start date';
            GLTRP      : Date        @title: 'Basic finish date';
            CHNAGEDATE : Date        @title: 'Change date';
    }
}

service ZCDSEHBTC0016 {
    entity ZTHBT0057                    as projection on db.ZTHBT0057;
    entity ZTHBT0008                    as projection on db.ZTHBT0048;
    entity ZTHBT0009                    as projection on db.ZTHBT0010;
    entity ZTHBT0017                    as projection on db.ZTHBT0014;
    entity ZTHBT0018                    as projection on db.ZTHBT0018;
    entity VL_SH_H_T001                 as projection on external.VL_SH_H_T001;
    entity processData                  as projection on db.ZTHBT0057;

    entity DOC_NO_HELP                  as
        select
            ZTHBT0009.E_DOC_TYPE,
            ZTHBT0009.E_DOC_NO,
            ZTHBT0009.E_REV_NO,
            ZTHBT0009.E_DOC_N,
            ZTHBT0009.MEDAI_TYPE,
            ZTHBT0009.YEOS_MODEL_GROUP,
            ZTHBT0009.FZ2_NO,
            ZTHBT0008.REV_SBJCT,
            ZTHBT0017.MODIFY_CAUSE_N,
            ZTHBT0018.APPLY_DATE_N
        from db.ZTHBT0009
        join db.ZTHBT0008
            on  ZTHBT0009.YEOS_MODEL_GROUP = ZTHBT0008.YEOS_MODEL_GROUP
            and ZTHBT0009.FZ2_NO           = ZTHBT0008.FZ2_NO
        join db.ZTHBT0017
            on ZTHBT0008.MODIFY_CAUSE = ZTHBT0017.MODIFY_CAUSE
        join db.ZTHBT0018
            on ZTHBT0008.APPLY_DATE_CD = ZTHBT0018.APPLY_DATE_CD;

    entity MAIN_MODEL_HELP              as
        select
            ZTHBT0009.E_DOC_TYPE,
            ZTHBT0009.E_DOC_NO,
            ZTHBT0009.E_REV_NO,
            ZTHBT0009.E_DOC_N,
            ZTHBT0009.MEDAI_TYPE,
            ZTHBT0009.YEOS_MODEL_GROUP,
            ZTHBT0009.FZ2_NO,
            ZTHBT0008.REV_SBJCT,
            ZTHBT0017.MODIFY_CAUSE_N,
            ZTHBT0018.APPLY_DATE_N
        from db.ZTHBT0009
        join db.ZTHBT0008
            on  ZTHBT0009.YEOS_MODEL_GROUP = ZTHBT0008.YEOS_MODEL_GROUP
            and ZTHBT0009.FZ2_NO           = ZTHBT0008.FZ2_NO
        join db.ZTHBT0017
            on ZTHBT0008.MODIFY_CAUSE = ZTHBT0017.MODIFY_CAUSE
        join db.ZTHBT0018
            on ZTHBT0008.APPLY_DATE_CD = ZTHBT0018.APPLY_DATE_CD;

// type UpdateBOMRegistration {
//     acknowledge : UpdateBOMRegistration.acknowledge;
//     message     : String;
// }

// @open
// type Object {}

// action UpdateBOMStatus(input : Object) returns UpdateBOMRegistration;

// type UpdateBOMRegistration.acknowledge : String enum {
//     succeeded;
//     failed;
// }
}

//Scan Kanban picking list
service ZCDSEHBTC0017 {
    entity ZTHBT0030                    as projection on db.ZTHBT0030;
}


//Print Kanban
service ZCAPIH0018 {
    entity ZTHBT0030                    as projection on db.ZTHBT0030;
    entity ZTHBT0006                    as projection on db.ZTHBT0006;
    entity ZCDSEHPPB0085                as projection on ZSRVBHPP0015.ZCDSEHPPB0085;
    entity I_MaterialStdVH                as projection on ZSRVBHPP0015.I_MaterialStdVH;
    entity I_PlantStdVH                as projection on ZSRVBHPP0015.I_PlantStdVH;
    entity I_StorageLocationStdVH                as projection on ZSRVBHPP0015.I_StorageLocationStdVH;
    entity ZCDSEHPPB0068                as projection on ZSRVBHPP0007.ZCDSEHPPB0068;
    entity ZCDSEHPPB0069                as projection on ZSRVBHPP0008.ZCDSEHPPB0069; 
}

service ZAPIBPS0002 {
    entity ZCDSEBPS0009                 as projection on ZCDSEBPS0007;
    entity ZCDSEBPS0010                 as projection on ZCDSEBPS0008;

    entity ZCDSEBPS0004                 as
        select from ZCDSEBPS0005
        left outer join ZCDSEBPS0006
            on  ZCDSEBPS0006.PBUKR    = $projection.PBUKR
            and ZCDSEBPS0006.PS_PSPNR = $projection.PS_PSP_PNR
            and ZCDSEBPS0006.PS_POSNR = $projection.PSPHI
            and ZCDSEBPS0006.ZMSCODE  = $projection.ZZ1_MSCODE_PRD
            and ZCDSEBPS0006.MATNR    = $projection.MATNR

        {
            key ZCDSEBPS0005.PBUKR,
            key ZCDSEBPS0005.PSPHI,
            key ZCDSEBPS0005.PS_PSP_PNR,
            key ZCDSEBPS0005.ZZ1_MSCODE_PRD,
                ZCDSEBPS0005.IDNLF,
            key ZCDSEBPS0005.MATNR,
                @Semantics.quantity.unitOfMeasure: 'ERFME'
                ZCDSEBPS0005.ERFMG,
                ZCDSEBPS0005.ERFME,
                ZCDSEBPS0006.USEDQTY,
                ZCDSEBPS0006.ZUT,
                cast(
                    case ZCDSEBPS0005.CONFIRM_STATUS
                    when 1 
                        then ZCDSEBPS0005.CONFIRM_STATUS
                    when 2
                        then ZCDSEBPS0005.CONFIRM_STATUS
                    when 3 
                        then ZCDSEBPS0005.CONFIRM_STATUS
                    else 
                        case
                            when
                                ZCDSEBPS0005.ERFMG = ZCDSEBPS0006.USEDQTY
                            then
                                3
                            else
                                1
                        end     
                    end as            Integer
                ) as Criticality,
                ZCDSEBPS0005.CONFIRM_STATUS,
                ZCDSEBPS0005.REASON_DIFF,
                _ReceivedQuantities : Association[ * ] to ZAPIBPS0002.ZCDSEBPS0009 on _ReceivedQuantities.PBUKR          = PBUKR
                                      and                                             _ReceivedQuantities.PSPHI          = PSPHI
                                      and                                             _ReceivedQuantities.PS_PSP_PNR     = PS_PSP_PNR
                                      and                                             _ReceivedQuantities.ZZ1_MSCODE_PRD = ZZ1_MSCODE_PRD
                                      and                                             _ReceivedQuantities.MATNR          = MATNR,
                _UsedQuantities     : Association[ * ] to ZAPIBPS0002.ZCDSEBPS0010 on _UsedQuantities.PBUKR    = PBUKR
                                      and                                             _UsedQuantities.PS_PSPNR = PSPHI
                                      and                                             _UsedQuantities.PS_POSNR = PS_PSP_PNR
                                      and                                             _UsedQuantities.ZMSCODE  = ZZ1_MSCODE_PRD
                                      and                                             _UsedQuantities.MATNR    = MATNR,
        }
    actions {
        action updateDiffSM(ReasonForDiffSM : String @Common.Label: 'Reason For Difference' ) returns ZCDSEBPS0004;
    };
    

    entity ZCDSEBPS0011                 as
        select from ZCDSEBPS0012
        left outer join ZCDSEBPS0006
            on  ZCDSEBPS0006.PBUKR    = $projection.PBUKR
            and ZCDSEBPS0006.PS_PSPNR = $projection.PS_PSP_PNR
            and ZCDSEBPS0006.PS_POSNR = $projection.PSPHI
            and ZCDSEBPS0006.ZMSCODE  = $projection.ZZ1_MSCODE_PRD
            and ZCDSEBPS0006.MATNR    = $projection.MATNR

        {
            key ZCDSEBPS0012.PBUKR,
            key ZCDSEBPS0012.PSPHI,
            key ZCDSEBPS0012.PS_PSP_PNR,
            key ZCDSEBPS0012.ZZ1_MSCODE_PRD,
                ZCDSEBPS0012.IDNLF,
            key ZCDSEBPS0012.MATNR,
                ZCDSEBPS0012.SERNR,
                @Semantics.quantity.unitOfMeasure: 'ERFME'
                ZCDSEBPS0012.ERFMG,
                ZCDSEBPS0012.ERFME,
                ZCDSEBPS0006.USEDQTY,
                ZCDSEBPS0006.ZUT,
                cast(
                    case ZCDSEBPS0012.CONFIRM_STATUS
                    when 1 
                        then ZCDSEBPS0012.CONFIRM_STATUS
                    when 2
                        then ZCDSEBPS0012.CONFIRM_STATUS
                    when 3 
                        then ZCDSEBPS0012.CONFIRM_STATUS
                    else 
                        case
                            when
                                ZCDSEBPS0012.ERFMG = ZCDSEBPS0006.USEDQTY
                            then
                                3
                            else
                                1
                        end    
                    end as            Integer
                ) as Criticality,
                ZCDSEBPS0012.CONFIRM_STATUS,
                ZCDSEBPS0012.REASON_DIFF,
                _ReceivedQuantities : Association[ * ] to ZAPIBPS0002.ZCDSEBPS0009 on _ReceivedQuantities.PBUKR          = PBUKR
                                      and                                             _ReceivedQuantities.PSPHI          = PSPHI
                                      and                                             _ReceivedQuantities.PS_PSP_PNR     = PS_PSP_PNR
                                      and                                             _ReceivedQuantities.ZZ1_MSCODE_PRD = ZZ1_MSCODE_PRD
                                      and                                             _ReceivedQuantities.MATNR          = MATNR,
                _UsedQuantities     : Association[ * ] to ZAPIBPS0002.ZCDSEBPS0010 on _UsedQuantities.PBUKR    = PBUKR
                                      and                                             _UsedQuantities.PS_PSPNR = PSPHI
                                      and                                             _UsedQuantities.PS_POSNR = PS_PSP_PNR
                                      and                                             _UsedQuantities.ZMSCODE  = ZZ1_MSCODE_PRD
                                      and                                             _UsedQuantities.MATNR    = MATNR,
        }
    actions {
        action updateDiff(ReasonForDiff : String @Common.Label: 'Reason For Difference' @mandatory)   returns ZCDSEBPS0011;
    }
    


}
service ZAPIBPS0003 {
    entity ZCDSEHPSC0013 as projection on ZSRVBHPS0011.ZCDSEHPSC0013;
}

service ZAPIBPS0004 {
    entity Customer as projection on BusinessPartner.A_Customer {
        key Customer,
        name1,
        name2,
        PostalCode,
        Region,
        mcod3 as City,
        StreetName,
        TelephoneNumber1,
        BusinessPartnerName3,
        BusinessPartnerName4,
        StreetPrefixName,
        AdditionalStreetPrefixName

    };
    entity ZCDSEBPS0015  as projection on ProjectDetails.ZCDSEHPSC0002 {
        ProjectId,
        ProjDesc,
        ApproverPM
    };
    @cds.persistence.skip
    @odata.singleton
    entity ExcelUpload {
        @Core.MediaType : 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        excel : LargeBinary;
    };

    entity Project as projection on TimeSheetEntry.ZCDSEHPSB0032 {
        key projectId,
            CompanyCode,
            wbsElementExt,
            ProjectDesc
    };
    
    @odata.draft.enabled
    entity ZCDSEBPS0012 as select from db.ZTHBT0055
           left outer join db.ZTHBT0027 as ZTHBT0027
           on ZTHBT0027.PBUKR = ZTHBT0055.PBUKR
           and ZTHBT0027.MATNR = ZTHBT0055.MATNR
           and ZTHBT0027.PSPHI = ZTHBT0055.PS_PSPNR {
        key ID,
            ZCABNUM,
            ZTHBT0055.PBUKR,
            PS_PSPNR,
            ZMSCODE,
            PS_POSNR,	
            ZTHBT0055.MATNR,
            ZZ1_MSCODE,
            ZIDEX,
            ZVMCODE,
            ZQTY,
            ZUT,
            ZDESCRIP,				
            ZSER,	
            ZSHTP,	
            ZSHPNAME1,
            ZSHPNAME2,	
            ZSHPNAME3,
            ZSHPNAME4,
            ZCONTACTTEL,	
            ZDELNOTE1,
            ZDELNOTE2,
            ZDONUM,
            ZDOITEM,
            ZDOPDATE,	
            ZDOADATE,	
            ZDELFLAG,
            ZSHPSTAT,
            CRITICALITY,
            REMARKS,
            null as name1: String(40),
            null as name2: String(40),
            null as PostalCode:String(10),
            null as Region:String(5),
            null as City:String(25),
            null as StreetName: String(35),
            null as TelephoneNumber1:String(16),
            null as BusinessPartnerName3:String(40),
            null as BusinessPartnerName4:String(40),
            null as StreetPrefixName: String(40),
            null as AdditionalStreetPrefixName: String(40)
    }
    actions {
        action DeleteSet() returns ZCDSEBPS0012;
        action split() returns ZCDSEBPS0012;
        action copy() returns ZCDSEBPS0012;
        action paste() returns ZCDSEBPS0012;
        action DOCreate() returns ZCDSEBPS0012;
        action MassEdit(ZSHTP: String @Common: { Label: 'Ship to Party',
                                                 ValueList : {
                                                    CollectionPath : 'Customer',
                                                    Parameters     : [
                                                        {
                                                            $Type             : 'Common.ValueListParameterInOut',
                                                            LocalDataProperty : ZSHTP,
                                                            ValueListProperty : 'Customer'
                                                        },
                                                        {
                                                            $Type             : 'Common.ValueListParameterDisplayOnly',
                                                            ValueListProperty : 'name1'
                                                        },
                                                        {
                                                            $Type             : 'Common.ValueListParameterDisplayOnly',
                                                            ValueListProperty : 'name2'
                                                        }
                                                    ]
                                                }},
                        ZSHPNAME1: String @Common.Label: 'Contact Ship to Name 1',
                        ZSHPNAME2: String @Common.Label: 'Contact Ship to Name 2',
                        ZSHPNAME3: String @Common.Label: 'Contact Ship to Name 3',
                        ZSHPNAME4: String @Common.Label: 'Contact Ship to Name 4') returns ZCDSEBPS0012;
    };
}

