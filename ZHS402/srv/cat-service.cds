using ZHS402 as db from '../db/data-model';
using TimeSheetEntry from './external/TimeSheetEntry';
using ZSRVBHPS0008 from './external/ZSRVBHPS0008';
using { PlantAPI as external } from './external/PlantAPI';
using  API_PRODUCT_SRV from './external/API_PRODUCT_SRV';
using ProductionOrder from './external/ProductionOrder';
using ZSRVBHPP0011 from './external/ZSRVBHPP0011';
using ZSRVBHPP0012 from './external/ZSRVBHPP0012';

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
    entity ReceiverWBSExt as projection on TimeSheetEntry.ZCDSEHPSC0008;
    entity ReceiverWBS as projection on TimeSheetEntry.ZCDSEHPSC0008 {
        key WBSId,
            ProjectDesc,
            ProjectId,
            Profile,
            UserStatus,
            LevelInHierarchy,
            ProjectType
    }
    entity ReceiverCostCenter as projection on TimeSheetEntry.ZCDSEHFIC0007 {
        key CostCenter,
            CostCenterName
    }
    entity ParentWBSExt as projection on TimeSheetEntry.ZCDSEHPSC0006;
    
    entity ParentWBS as projection on TimeSheetEntry.ZCDSEHPSC0006{
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
    entity LoggedInUser as projection on TimeSheetEntry.CurrentLoginUser;
   
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
    entity ZTHBT0008 as projection on db.ZTHBT0048;
    entity ZTHBT0009 as projection on db.ZTHBT0010;
    entity ZTHBT0017 as projection on db.ZTHBT0014;
    entity ZTHBT0018 as projection on db.ZTHBT0018;
    entity ZTHBT0056 as projection on db.ZTHBT0056;
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
    entity ZTHBT0008 as projection on db.ZTHBT0048;
    entity ZTHBT0009 as projection on db.ZTHBT0010;
    entity ZTHBT0017 as projection on db.ZTHBT0014;
    entity ZTHBT0018 as projection on db.ZTHBT0018;
    entity VL_SH_H_T001 as projection on external.VL_SH_H_T001; 

    entity DOC_NO_HELP as select ZTHBT0009.E_DOC_TYPE, ZTHBT0009.E_DOC_NO, ZTHBT0009.E_REV_NO, ZTHBT0009.E_DOC_N, ZTHBT0009.MEDAI_TYPE, ZTHBT0009.YEOS_MODEL_GROUP, ZTHBT0009.FZ2_NO, ZTHBT0008.REV_SBJCT, ZTHBT0017.MODIFY_CAUSE_N, ZTHBT0018.APPLY_DATE_N  from db.ZTHBT0009 join db.ZTHBT0008 
        on ZTHBT0009.YEOS_MODEL_GROUP = ZTHBT0008.YEOS_MODEL_GROUP
        and ZTHBT0009.FZ2_NO = ZTHBT0008.FZ2_NO
        join db.ZTHBT0017
        on ZTHBT0008.MODIFY_CAUSE = ZTHBT0017.MODIFY_CAUSE
        join db.ZTHBT0018 
        on ZTHBT0008.APPLY_DATE_CD = ZTHBT0018.APPLY_DATE_CD;

    entity MAIN_MODEL_HELP as select ZTHBT0009.E_DOC_TYPE, ZTHBT0009.E_DOC_NO, ZTHBT0009.E_REV_NO, ZTHBT0009.E_DOC_N, ZTHBT0009.MEDAI_TYPE, ZTHBT0009.YEOS_MODEL_GROUP, ZTHBT0009.FZ2_NO, ZTHBT0008.REV_SBJCT, ZTHBT0017.MODIFY_CAUSE_N, ZTHBT0018.APPLY_DATE_N  from db.ZTHBT0009 join db.ZTHBT0008 
        on ZTHBT0009.YEOS_MODEL_GROUP = ZTHBT0008.YEOS_MODEL_GROUP
        and ZTHBT0009.FZ2_NO = ZTHBT0008.FZ2_NO
        join db.ZTHBT0017
        on ZTHBT0008.MODIFY_CAUSE = ZTHBT0017.MODIFY_CAUSE
        join db.ZTHBT0018 
        on ZTHBT0008.APPLY_DATE_CD = ZTHBT0018.APPLY_DATE_CD;

    @cds.persistence.skip
    entity BOMDisplay {
     E_DOC_TYPE: String(3) @title : 'Document Type7';
     WERKS: String(4) @title : 'Plant';
    key E_DOC_NO: String(18) @title : 'Technical document No';
    key E_REV_NO: String(5) @title : 'Technical renewal REV No';
    key PS_GROUP_NO: String(3) @title : 'PS group No';
    key PS_ITEM_NO: String(3) @title : 'PS Item No';
    FORMALIZE_DATE: Date @title : 'Formalized Date';
    CREATION_DATE: Date @title : 'Creation Date';
    }
    @cds.persistence.skip
    entity Doc_Type {
    key DOC_TYPE: String(3) @title : 'Document Type';
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
    entity DATAFE0 as
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
            key B.PS_ITEM_NO as PS_ITEM_NO,
                B.E_DOC_TYPE  as E_DOC_TYPE,
                B.WERKS       as WERKS,
                B.MODEL       as MODEL,
                B.EFFECT_D    as EFFECT_D,
                B.INVALID_D   as INVALID_D,
                ZTHBT0010 : Association [*] to ZCDSEHBTC0007.ZTHBT0010
                                on ZTHBT0010.E_DOC_NO = E_DOC_NO
        }
        where
            B.E_DOC_TYPE = 'FE0';
    
    entity DATAFE1 as
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
            key B.PS_ITEM_NO as PS_ITEM_NO,
                B.E_DOC_TYPE  as E_DOC_TYPE,
                B.WERKS       as WERKS,
                B.EFFECT_D    as EFFECT_D,
                B.INVALID_D   as INVALID_D,
                ZTHBT0014 : Association [*] to ZCDSEHBTC0007.ZTHBT0014
                                on ZTHBT0014.E_DOC_NO = E_DOC_NO
        }
        where
            B.E_DOC_TYPE = 'FE1';


}

service ZSRVBHPS0008Service {

    entity ZCDSEHPSB0004 as projection on ZSRVBHPS0008.ZCDSEHPSB0004; 
    entity ZCDSEHPSB0037 as projection on ZSRVBHPS0008.ZCDSEHPSB0037; 
    entity ZCDSEHPSB0038 as projection on ZSRVBHPS0008.ZCDSEHPSB0038; 
    entity ZCDSEHPSC0005 as projection on ZSRVBHPS0008.ZCDSEHPSC0005; 
    entity ZCDSEHSDB0013 as projection on ZSRVBHPS0008.ZCDSEHSDB0013; 
    entity SAP__Currencies as projection on ZSRVBHPS0008.SAP__Currencies; 
    entity SAP__UnitsOfMeasure as projection on ZSRVBHPS0008.SAP__UnitsOfMeasure; 

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
    entity A_ProductDescription as projection on API_PRODUCT_SRV.A_ProductDescription;
    entity A_Product as projection on API_PRODUCT_SRV.A_Product;

    // entity DigitPartList as select ZTHBT0001.SOURCE_CD, ZTHBT0001.YEOS_MNF_MODEL, A_ProductDescription.ProductDescription from db.ZTHBT0001 left outer join API_PRODUCT_SRV.A_ProductDescription 
    //     on ZTHBT0001.E_PARTS_NO  = A_ProductDescription.Product;// where ZTHBT0007.E_PARTS_NO = '123';
    @cds.persistence.skip
    entity DigitPartList {
        PARTS_NO: String(18) @title : 'Parts  Number';
        E_PARTS_NO: String(40) @title : 'Material Number';
        MATERIALDESC: String(40) @title : 'Material Description';
        SOURCE_CD: String(2) @title : 'Source  Code';
        YEOS_MNF_NO: String(5) @title : 'Maker Model Number';

    }

    
    entity MaterialInput as select ZTHBT0006.E_PARTS_NO from db.ZTHBT0006 left outer join db.ZTHBT0015 
        on ZTHBT0006.PARTS_TYPE = ZTHBT0015.PARTS_TYPE where ZTHBT0015.PARTS_NO_EXT_SIGN = '1';
    entity MakersList as select ZTHBT0007.E_PARTS_NO, ZTHBT0007.SOURCE_CD, ZTHBT0007.YEOS_MNF_NO, ZTHBT0007.DATA_ST, ZTHBT0007.YEOS_MNF_MODEL, ZTHBT0016.YEOS_MNF_N from db.ZTHBT0007 left outer join db.ZTHBT0016 
        on ZTHBT0007.YEOS_MNF_NO = ZTHBT0016.YEOS_MNF_NO;// where ZTHBT0007.E_PARTS_NO = :E_PART_NO;

    
      entity PackingList as select ZTHBT0005.E_PARTS_NO, ZTHBT0005.PCKG_CD, ZTHBT0005.PCKG_TYPE, ZTHBT0005.PCKG_STYLE, ZTHBT0005.SUPPLY_STYLE, ZTHBT0003.PCKG_TYPE_N, ZTHBT0002.PCKG_STYLE_N, ZTHBT0004.SUPPLY_STYLE_N from db.ZTHBT0005 join db.ZTHBT0003 
        on ZTHBT0005.PCKG_TYPE = ZTHBT0003.PCKG_TYPE
        join db.ZTHBT0002
        on ZTHBT0005.PCKG_TYPE = ZTHBT0002.PCKG_TYPE
        and ZTHBT0005.PCKG_STYLE = ZTHBT0002.PCKG_STYLE
        join db.ZTHBT0004 
        on ZTHBT0005.PCKG_TYPE = ZTHBT0004.PCKG_TYPE
        and ZTHBT0005.SUPPLY_STYLE = ZTHBT0004.SUPPLY_STYLE;
    
    // entity DigitPartList as
    //     select from db.ZTHBT0001 {
    //         *
    //     };
}

service ZCDSEHBTC0010 {
    entity OperationList as projection on ProductionOrder.ZCDSEHPPB0031;
    entity Components as projection on ProductionOrder.ZCDSEHPPB0020;
    entity AdditionalStatus as projection on db.ZTHBT0028;
    entity ChildPartListCombined as projection on ProductionOrder.ZCDSEHPPI0001{
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
        to_Components: Association to many ProductionOrder.ZCDSEHPPB0020
               on ProductionOrderNo = $projection.ProductionOrderNo
    }
    
    entity ProcessRecordSheetCombined as projection on ProductionOrder.ZCDSEHPPI0004
       {
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
        memo4 ,
        ReportId ,
        to_OpertaionsList: Association to many ProductionOrder.ZCDSEHPPB0031
                         on OrderNumber = $projection.OrderNumber
    };
    entity ProductionOrderSheetCombined as projection on ProductionOrder.ZCDSEHPPI0010
    {
        key   OrderNumber,
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
        Scanner ,
        to_OpertaionsListColumn1:Association to many ProductionOrder.ZCDSEHPPB0031
                                 on OrderNumber = $projection.OrderNumber,
        to_OpertaionsListColumn2:Association to many ProductionOrder.ZCDSEHPPB0031
                                 on OrderNumber = $projection.OrderNumber,
        to_OpertaionsListColumn3:Association to many ProductionOrder.ZCDSEHPPB0031
                                 on OrderNumber = $projection.OrderNumber  
    };
    entity PrinterConfiguration as projection on db.ZTHBT0058;

}

//BOM Update
service ZCDSEHBTC0011 {
    entity ZTHBT0006 as projection on db.ZTHBT0006;
    entity ZTHBT0008 as projection on db.ZTHBT0008;
    entity ZTHBT0009 as projection on db.ZTHBT0009;
    entity ZTHBT0015 as projection on db.ZTHBT0015;
    entity ZTHBT0017 as projection on db.ZTHBT0017;
    entity ZTHBT0018 as projection on db.ZTHBT0018;
    entity ZTHBT0037 as projection on db.ZTHBT0037; 
    entity ZCDSEHPPB0071 as projection on ZSRVBHPP0012.ZCDSEHPPB0071
}

service ZCDSEHBTC0012 {
    entity ZTHBT0056  as projection on db.ZTHBT0056;

    entity materialWhereUsed as projection on ZSRVBHPP0011.ZCDSEHPPB0070 {
        key WERKS,
        key MATNR_COM,
            MAKTX_COM,
            MTART_COM,
            POTX1_0,
            POSNR,
            SORTF,
            POTX1_19,
            MATNR,
            MAKTX,
            MTART,
            EMENG,
            @Semantics.unitOfMeasure
            BMEIN,
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
            SCHGT_FROM,
            BESKZ_FROM,
            SOBSL_FROM,
            LVORM_FROM,
            @Semantics.unitOfMeasure
            BSTME,
            MEINS,
            BMTYP,
            SUMFG,
            STLAN,
            STLNR,
            MMSTD,
            DT_MFG,
            MESSAGE,
            LIST_TYPE,
            MASTER_DATA,
    };
}
