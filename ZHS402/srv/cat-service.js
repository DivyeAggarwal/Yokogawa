
const SequenceHelper = require("./lib/SequenceHelper");
const cds = require('@sap/cds');
const { read } = require("@sap/cds/lib/utils/cds-utils");
const { SELECT, INSERT, UPDATE } = cds.ql

module.exports = cds.service.impl(async function (srv) {

    const db = await cds.connect.to("db");

    this.on('READ', 'AccountingIndicator', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    this.on('READ', 'I_StatisticalKeyFigureText', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    this.on('READ', 'ServiceOrderItem', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    this.on('READ', 'ServiceOrder', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    this.on('READ', 'InternalOrder', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    this.on('READ', 'ReceiverWBSExt', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });


    this.on('READ', 'ZCDSEHPSB0004', async req => {
        const bupa = await cds.connect.to('ZSRVBHPS0008');
        return bupa.run(req.query);
    });
    this.on('READ', 'ZCDSEHPSB0037', async req => {
        const bupa = await cds.connect.to('ZSRVBHPS0008');
        return bupa.run(req.query);
    });
    this.on('READ', 'ZCDSEHPSB0038', async req => {
        const bupa = await cds.connect.to('ZSRVBHPS0008');
        return bupa.run(req.query);
    });
    this.on('READ', 'ZCDSEHPSC0005', async req => {
        const bupa = await cds.connect.to('ZSRVBHPS0008');
        return bupa.run(req.query);
    });
    this.on('READ', 'ZCDSEHSDB0013', async req => {
        const bupa = await cds.connect.to('ZSRVBHPS0008');
        return bupa.run(req.query);
    });
    this.on('READ', 'SAP__Currencies', async req => {
        const bupa = await cds.connect.to('ZSRVBHPS0008');
        return bupa.run(req.query);
    });
    this.on('READ', 'SAP__UnitsOfMeasure', async req => {
        const bupa = await cds.connect.to('ZSRVBHPS0008');
        return bupa.run(req.query);
    });

    this.on('READ', 'VL_SH_H_T001', async req => {
        const plant = await cds.connect.to('PlantAPI');
        return plant.run(req.query);
    });
    this.on('READ', 'A_ProductDescription', async req => {
        const product = await cds.connect.to('API_PRODUCT_SRV');
        return product.run(req.query);
    });
    this.on('READ', 'ZCDSEHMMC0004', async req => {
        const specData = await cds.connect.to('ZSRVBHMM0004');
        return specData.run(req.query);
    });
    this.on('READ', 'A_Product', async req => {
        const product = await cds.connect.to('API_PRODUCT_SRV');
        return product.run(req.query);
    });
    this.on('CREATE', 'A_Product', async req => {
        const product = await cds.connect.to('API_PRODUCT_SRV');
        return product.run(req.query);
    });
    

    this.on('READ', 'ZTHBT0019', async req => {
        const db = await cds.connect.to('db');
        var oData = await db.run(req.query);
        return oData;
    });
    this.before('CREATE', 'ZTHBT0019', async (req) => {
        await ValidateAssignment(req);

    });
    this.before('UPDATE', 'ZTHBT0019', async (req) => {
        await ValidateAssignment(req);

    });

    this.on('CREATE', 'ZCDSEHPSC0011', async req => {
        const product = await cds.connect.to('ZSRVBHPS0010');
        var t = {
            "GrpSup":"67",
            "WbsElmt":"78"
          }
        product.tx(req).post("/ZCDSEHPSC0011",req.data);
        // return product.run(req.query);
    });



    this.on('UpdatePOItem', async (req) => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        if (req.data.input.update.length > 0) {
            await UPSERT.into('ZHS402.ZTHBT0027').entries(req.data.input.update);
        }
        for (let oDelete of req.data.input.delete) {
            await DELETE.from('ZHS402.ZTHBT0027').where({ MBLNR: { '=': oDelete.MBLNR }, ZEILE: { '=': oDelete.ZEILE }, MJAHR: { '=': oDelete.MJAHR }, SERNR: { '=': oDelete.SERNR } });
        }
        return {
            acknowledge: "Success", message: "Deleted " + req.data.input.delete.length + " entries \n"
                + "Updated " + req.data.input.update.length + " entries \n"
        }
    });

    this.before('CREATE', 'ZTHBT0022', async (context) => {
        const productId = new SequenceHelper({
            db: db,
            sequence: "INVOICE_ID",
            table: "ZTHBT0022",
            field: "ID"
        });

        context.data.ID = await productId.getNextNumber();
        var ID = context.data.ID;
        var currentYear = new Date().getFullYear();
        var convertedID = String(ID).padStart(5, "0");
        var InvoiceID = currentYear + "-" + convertedID;
        context.data.INVOICEID = InvoiceID;
    });

    this.after('CREATE', 'ZTHBT0033', async (context) => {
        var MSCODE = context.MSCODE;
        var PRODUCTCAREER = context.PRODUCTCAREER;
        var INSTRUMENTMODEL = context.INSTRUMENTMODEL;
        var PARTSNUMBER = context.PARTSNUMBER;
        var MODEL = context.MODEL;
        var PPLFLAG = context.PPLLAG;
        // var value = "";
        const mscode = await SELECT.from('ZHS402.ZTHBT0048').where({
            MSCODE: context.MSCODE,
            PRODUCTCAREER: context.PRODUCTCAREER,
            INSTRUMENTMODEL: context.INSTRUMENTMODEL,
            PARTSNUMBER: context.PARTSNUMBER,
            MODEL: context.MODEL,
        })
        if (mscode.length > 0) {
            return;
        } else {
            if (PPLFLAG == "X") {
                //PPL
                const mcodeId = new SequenceHelper({
                    db: db,
                    sequence: "MATERIALCODE_ID",
                    table: "ZTHBT0048",
                    field: "ID"
                });
                var ID = await mcodeId.getNextNumber();
                var convertedID = String(ID).padStart(9, "0");
                var MaterialCode = MODEL + "_" + convertedID;
                var conversion = {
                    ID: ID,
                    MSCODE: MSCODE,
                    PRODUCTCAREER: PRODUCTCAREER,
                    INSTRUMENTMODEL: INSTRUMENTMODEL,
                    PARTSNUMBER: PARTSNUMBER,
                    MODEL: MODEL,
                    MATERIALCODE: MaterialCode,
                    TOKUCHUFLAG: ""
                };
                await INSERT.into('ZHS402.ZTHBT0048').entries(conversion);
                await DELETE.from('ZHS402.ZTHBT0033').where({ MSCODE: { '=': MSCODE }, PRODUCTCAREER: { '=': PRODUCTCAREER }, INSTRUMENTMODEL: { '=': INSTRUMENTMODEL }, PARTSNUMBER: { '=': PARTSNUMBER }, MODEL: { '=': MODEL } });
            }
            if (MSCODE) {
                const mcodeId = new SequenceHelper({
                    db: db,
                    sequence: "MATERIALCODE_ID",
                    table: "ZTHBT0048",
                    field: "ID"
                });
                var ID = await mcodeId.getNextNumber();
                var convertedID = String(ID).padStart(9, "0");

                let checkZ = MSCODE.includes('Z');
                if (checkZ == false) {
                    //Normal scenario
                    var MaterialCode = MODEL + "_F" + convertedID;
                    var conversion = {
                        ID: ID,
                        MSCODE: MSCODE,
                        PRODUCTCAREER: PRODUCTCAREER,
                        INSTRUMENTMODEL: INSTRUMENTMODEL,
                        PARTSNUMBER: PARTSNUMBER,
                        MODEL: MODEL,
                        MATERIALCODE: MaterialCode,
                        TOKUCHUFLAG: ""
                    };
                    await UPSERT.into('ZHS402.ZTHBT0048').entries(conversion);

                } else if (checkZ == true && INSTRUMENTMODEL === "" && PARTSNUMBER === "") {
                    //Tokuchu Product
                    var MaterialCode = MODEL + "_Z" + convertedID;
                    var conversion = {
                        ID: ID,
                        MSCODE: MSCODE,
                        PRODUCTCAREER: PRODUCTCAREER,
                        INSTRUMENTMODEL: INSTRUMENTMODEL,
                        PARTSNUMBER: PARTSNUMBER,
                        MODEL: MODEL,
                        MATERIALCODE: MaterialCode,
                        TOKUCHUFLAG: "X"
                    };
                    await UPSERT.into('ZHS402.ZTHBT0048').entries(conversion);
                } else if (checkZ == true && INSTRUMENTMODEL !== "" && PARTSNUMBER !== "") {
                    //Tokuchu Parts
                    var MaterialCode = PARTSNUMBER + "_" + convertedID;
                    var conversion = {
                        ID: ID,
                        MSCODE: MSCODE,
                        PRODUCTCAREER: PRODUCTCAREER,
                        INSTRUMENTMODEL: INSTRUMENTMODEL,
                        PARTSNUMBER: PARTSNUMBER,
                        MODEL: MODEL,
                        MATERIALCODE: MaterialCode,
                        TOKUCHUFLAG: "X"
                    };
                    await UPSERT.into('ZHS402.ZTHBT0048').entries(conversion);
                }
            }
            //code for spec table
            const specData = await bupa.get('ZCDSEHBTC0006.ZCDSEHMMC0004').where({ model: MODEL });
            if(specData.length > 0) {
                var conversionSpec = {
                    MATERIALCODE: specData[0].mscode,
                    MODEL: specData[0].model,
                    SUFFIXLEVEL: specData[0].suffixlevel,
                    SUFFIXVALUE: specData[0].suffixvalue
                };
                await UPSERT.into('ZHS402.ZTHBT0032').entries(conversionSpec);
            }
        }
    });

    //    this.on('CreateMaterialCode', async (req) => {
    //     if(req.data.input.data.length > 0){	
    //     await UPSERT.into('ZHS402.ZTHBT0033').entries(req.data.input.data);
    //     }
    //     var data = req.data.input.data;
    //     var value = await SELECT.from('ZHS402.ZTHBT0032').where ({MSCODE:{'=':data.MSCODE},PRODUCTCAREER:{'=':data.PRODUCTCAREER},INSTRUMENTMODEL:{'=':data.INSTRUMENTMODEL},PARTSNUMBER:{'=':data.PARTSNUMBER},MODEL:{'=':data.MODEL}})
    //     if(value){
    //         return {acknowledge:"Error", message: "Data Already Exist"  }
    //     } else {
    //         if(data.PPLFlag == "X") {
    //             //PPL
    //         }
    //         if(data.MSCODE) {
    //             let checkZ = data.MSCODE.includes('Z');
    //             if(checkZ == false) {
    //                 //Normal
    //             } else if(checkZ == true && data.INSTRUMENTMODEL === "" && data.PARTSNUMBER === "") {
    //                 //Tokuchu Product
    //             } else if (checkZ == true && data.INSTRUMENTMODEL !== "" && data.PARTSNUMBER !== "") {
    //                 //Tokuchu Parts
    //             }
    //         }

    //     }
    //     for (let oDelete of req.data.input.delete) {  
    //         await DELETE.from('ZHS402.ZTHBT0027').where ({MBLNR:{'=':oDelete.MBLNR},ZEILE:{'=':oDelete.ZEILE},MJAHR:{'=':oDelete.MJAHR},SERNR:{'=':oDelete.SERNR}});
    //     }
    //     return {acknowledge:"Success", message: "Deleted " + req.data.input.delete.length + " entries \n" 
    //     + "Updated " + req.data.input.update.length + " entries \n"  }
    // });
    this.on('READ', 'ReceiverCostCenter', async req => {
        const db = await cds.connect.to('TimeSheetEntry');
        var oData = await db.run(req.query);
        return oData;
    });
    this.on('READ', 'BOMDisplay', async req => {
        const db = await cds.connect.to('db');
        // if (req._query) {
            // const doc_type_idx = req.query.SELECT.where.findIndex((filter) => filter && filter.ref && filter.ref.find((field) => field === "E_DOC_TYPE"));
            // if (doc_type_idx >= 0) {
            //     var E_DOC_TYPE = req.query.SELECT.where[doc_type_idx + 2].val
            // }
            // const WERKS_idx = req.query.SELECT.where.findIndex((filter) => filter && filter.ref && filter.ref.find((field) => field === "WERKS"));
            // if (WERKS_idx >= 0) {
            //     var WERKS = req.query.SELECT.where[WERKS_idx + 2].val
            // }
            // const DOC_NO_idx = req.query.SELECT.where.findIndex((filter) => filter && filter.ref && filter.ref.find((field) => field === "E_DOC_NO"));
            // if (DOC_NO_idx >= 0) {
            //     var E_DOC_NO = req.query.SELECT.where[DOC_NO_idx + 2].val
            // }
            // const REV_NO_idx = req.query.SELECT.where.findIndex((filter) => filter && filter.ref && filter.ref.find((field) => field === "E_REV_NO"));
            // if (REV_NO_idx >= 0) {
            //     var E_REV_NO = req.query.SELECT.where[REV_NO_idx + 2].val
            // }
            // const GROUP_NO_idx = req.query.SELECT.where.findIndex((filter) => filter && filter.ref && filter.ref.find((field) => field === "PS_GROUP_NO"));
            // if (GROUP_NO_idx >= 0) {
            //     var PS_GROUP_NO = req.query.SELECT.where[GROUP_NO_idx + 2].val
            // }
        // }
        if (E_DOC_TYPE == "FE0") {
            const dataFe0 = await SELECT.from('ZCDSEHBTC0007.DATAFE0').where(req.query.SELECT.where)

            let aData = [];
            for (let oData of dataFe0) {
                const data = {
                    E_DOC_TYPE: oData.E_DOC_TYPE,
                    WERKS: oData.WERKS,
                    PS_ITEM_NO: oData.PS_ITEM_NO,
                    E_DOC_NO: oData.E_DOC_NO,
                    E_REV_NO: oData.E_REV_NO,
                    PS_GROUP_NO: oData.PS_GROUP_NO,
                    FORMALIZE_DATE: oData.INVALID_D,
                    CREATION_DATE: oData.EFFECT_D
                }
                aData.push(data);
            }
            return aData;
        } else if (E_DOC_TYPE == "FE1") {
            const dataFe1 = await SELECT.from('ZCDSEHBTC0007.DATAFE1').where(req.query.SELECT.where)
            let aData = [];
            for (let oData of dataFe1) {
                const data = {
                    E_DOC_TYPE: oData.E_DOC_TYPE,
                    WERKS: oData.WERKS,
                    PS_ITEM_NO: oData.PS_ITEM_NO,
                    E_DOC_NO: oData.E_DOC_NO,
                    E_REV_NO: oData.E_REV_NO,
                    PS_GROUP_NO: oData.PS_GROUP_NO,
                    FORMALIZE_DATE: oData.INVALID_D,
                    CREATION_DATE: oData.EFFECT_D
                }
                aData.push(data);
            }
            return aData;
        }
        // }

        // return oData;
    });
    this.on('READ', 'Doc_Type', async req => {
        const db = await cds.connect.to('db');

        let aData = [];
        const data = {
            DOC_TYPE: "FE0",
        }
        aData.push(data);
        const data1 = {
            DOC_TYPE: "FE1",
        }
        aData.push(data1);
        return aData;

    });
    this.on('READ', 'DigitPartList', async req => {
        const db = await cds.connect.to('db');
        const material = await SELECT.from('ZHS402.ZTHBT0001').limit(1);

        let aData = [];
        for (let oData of material) {
            const data = {
                PARTS_NO: oData.PARTS_NO,
                E_PARTS_NO: oData.E_PARTS_NO,
                SOURCE_CD: oData.SOURCE_CD,
                YEOS_MNF_NO: oData.YEOS_MNF_NO
            }
            if (oData.E_PARTS_NO) {
                const bupa = await cds.connect.to('API_PRODUCT_SRV');
                const MatDesc = await bupa.get('ZCDSEHBTC0009.A_ProductDescription').where({ Product: oData.E_PARTS_NO });
                if (MatDesc.length > 0) {
                    console.log(MatDesc);
                    data.MATERIALDESC = MatDesc[0].ProductDescription;
                } else {
                    data.MATERIALDESC = "Not Found"
                }
            } else {
                data.MATERIALDESC = "Test Material";
            }
            aData.push(data);
        }
        return aData;

        // }

        // return oData;
    });
    this.on('READ', 'ProcessRecordSheetCombined', async req => {
        /* Read Data from the External API for Process Record Sheet */
        const bupa = await cds.connect.to('ProductionOrder');
        const results = await bupa.run(req.query);
        /* Prepare array of Production Order by which Addiional status is going to be 
        Read from the Cloud Table */
        let arrayInput = [];
        if (Array.isArray(results)) {
            for (let result of results) {
                arrayInput.push(result.OrderNumber);
            }
        }
        else {
            arrayInput.push(results.OrderNumber);
        }

        let objectAddStatus = {};
        await PrepareResultObject(arrayInput, objectAddStatus);
        /*Manipulate the result from cloud and On Premise */
        if (Array.isArray(results)) {
            for (let result of results) {
                let DataFromObject = objectAddStatus[result.OrderNumber];
                if (DataFromObject) {
                    result.RePrint = DataFromObject;
                }

            }
        }
        else {
            let DataFromObject = objectAddStatus[results.OrderNumber];
            if (DataFromObject) {
                results.RePrint = DataFromObject;
            }
        }

        return results;
    });
    this.on('READ', 'OperationList', async req => {
        const bupa = await cds.connect.to('ProductionOrder');
        return bupa.run(req.query);
    });
    this.on('READ', 'Components', async req => {
        const bupa = await cds.connect.to('ProductionOrder');
        return bupa.run(req.query);
    });
    this.on('READ', 'ProductionOrderSheetCombined', async req => {
        const bupa = await cds.connect.to('ProductionOrder');
        const results = await bupa.run(req.query);
        /* Prepare array of Production Order by which Addiional status is going to be 
        Read from the Cloud Table */
        let arrayInput = [];
        if (Array.isArray(results)) {
            for (let result of results) {
                arrayInput.push(result.OrderNumber);
            }
        }
        else {
            arrayInput.push(results.OrderNumber);
        }
        let objectAddStatus = {};
        await PrepareResultObject(arrayInput, objectAddStatus);

        /*Manipulate the result from cloud and On Premise */
        if (Array.isArray(results)) {
            for (let result of results) {
                let DataFromObject = objectAddStatus[result.OrderNumber];
                if (DataFromObject) {
                    result.RePrint = DataFromObject;
                }

            }
        }
        else {
            let DataFromObject = objectAddStatus[results.OrderNumber];
            if (DataFromObject) {
                results.RePrint = DataFromObject;
            }
        }

        return results;
    });
    this.on('READ', 'ChildPartListCombined', async req => {
        const bupa = await cds.connect.to('ProductionOrder');
        const results = await bupa.run(req.query);
        /* Prepare array of Production Order by which Addiional status is going to be 
        Read from the Cloud Table */
        let arrayInput = [];
        if (Array.isArray(results)) {
            for (let result of results) {
                arrayInput.push(result.ProductionOrderNo);
            }
        }
        else {
            arrayInput.push(results.ProductionOrderNo);
        }
        let objectAddStatus = {};
        await PrepareResultObject(arrayInput, objectAddStatus);
        /*Manipulate the result from cloud and On Premise */
        if (Array.isArray(results)) {
            for (let result of results) {
                let DataFromObject = objectAddStatus[result.ProductionOrderNo];
                if (DataFromObject) {
                    result.RePrint = DataFromObject;
                }
            }
        }
        else {
            let DataFromObject = objectAddStatus[results.ProductionOrderNo];
            if (DataFromObject) {
                results.RePrint = DataFromObject;
            }
        }

        return results;
    });
    this.on('READ','ParentWBSExt', async req => {
        
        const db = await cds.connect.to('TimeSheetEntry');
        var oData = await db.run(req.query);
        return oData;
    });

    
    this.on('READ','ParentWBS', async req => {
        
        const bupa = await cds.connect.to('TimeSheetEntry');
        const LoggUser = await bupa.get('ZCDSEHBTC0003.LoggedInUser');
        var oData=[];
        if(LoggUser.length > 0) {
            const AssignmentByPassData = await SELECT.from('ZHS402.ZTHBT0052').where({ BUKRS: LoggUser[0].CompanyCode });
            if(AssignmentByPassData && AssignmentByPassData.length > 0) {
                switch (AssignmentByPassData[0].CATEGORY) {
                    case 'PJT':
                        oData = await bupa.get('ZCDSEHBTC0003.ParentWBSExt').where({projectType:'E1', and:{LevelInHierarchy:{'>=':006}}});
                        break;
                    case 'OPP':
                        oData = await bupa.get('ZCDSEHBTC0003.ParentWBSExt').where({projectType:'D1', and:{LevelInHierarchy:{'>=':002}}});
                    default:
                        oData = await bupa.get('ZCDSEHBTC0003.ParentWBSExt').where({projectType:'E1', and:{LevelInHierarchy:{'>=':006}}, and:{IhpaObjFound:'X'}});
                        break;
                }
                
            }
        } 
        return oData;
    });
    this.on('READ','LoggedInUser', async req => {
        
        const db = await cds.connect.to('TimeSheetEntry');
        var oData = await db.run(req.query);
        return oData;
    });
    this.on('READ', 'ReceiverWBS', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        const LoggUser = await bupa.get('ZCDSEHBTC0003.LoggedInUser');
        var oData=[];
        if(LoggUser.length > 0) {
            const AssignmentByPassData = await SELECT.from('ZHS402.ZTHBT0052').where({ BUKRS: LoggUser[0].CompanyCode });
            if(AssignmentByPassData && AssignmentByPassData.length > 0) {
                switch (AssignmentByPassData[0].CATEGORY) {
                    case 'PJT':
                        oData = await bupa.get('ZCDSEHBTC0003.ReceiverWBSExt').where({Profile:'YE00001', and:{LevelInHierarchy:{'>=':006}}, and:{ProjectType:'E1'}});
                        break;
                    case 'OPP':
                        oData = await bupa.get('ZCDSEHBTC0003.ReceiverWBSExt').where({Profile:'YD00001', and:{LevelInHierarchy:{'>=':002}}, and:{ProjectType:'D1'}});
                    default:
                        oData = await bupa.get('ZCDSEHBTC0003.ReceiverWBSExt').where({UserStatus:'CCTW', and:{LevelInHierarchy:{'>=':006}}});
                        break;
                }
                
            }
        } 
        return oData;
    });

    this.on('READ', 'materialWhereUsed', async req => {
        const materialWhereUsed = await cds.connect.to('ZSRVBHPP0011');
        const results = await materialWhereUsed.run(req.query);
        // const bupa = await cds.connect.to('ProductionOrder');
        // return materialWhereUsed.run(req.query);
        /* Prepare array of Model by which Addiional status is going to be 
        Read from the Cloud Table */
        let arrayInput = [];
        if (Array.isArray(results)) {
            for (let result of results) {
                arrayInput.push(result.ZZ1_MSCODE_PRD);
            }
        }
        else {
            arrayInput.push(results.ZZ1_MSCODE_PRD);
        }
        let objectAddMSCode = {};
        objectAddMSCode = await PrepareWherUsedObject(arrayInput, objectAddMSCode);

        let objectAddModel = {};
        objectAddModel = await PrepareModelData(arrayInput, objectAddModel);

        /*Manipulate the result from cloud and On Premise */
        if (Array.isArray(results)) {
            for (let result of results) {
                let DataFromObject = objectAddMSCode[result.ZZ1_MSCODE_PRD];
                let DataFromModTable = objectAddModel[result.ZZ1_MSCODE_PRD];
                if (DataFromObject) {
                    result.MTART = DataFromObject;
                } else if(DataFromModTable) {
                    result.MTART = DataFromModTable;
                }

            }
        }
        else {
            let DataFromObject = objectAddStatus[results.ZZ1_MSCODE_PRD];
            let DataFromModTable = objectAddModel[result.ZZ1_MSCODE_PRD];
            if (DataFromObject) {
                results.MTART = DataFromObject;
            } else if(DataFromModTable) {
                results.MTART = DataFromModTable;
            }
        }

        return results;
    });


});

const ValidateAssignment = async (req) => {
    const bupa = await cds.connect.to('TimeSheetEntry');
    // if(req.data.ZPS_IDENTIFIER === 'P') {
    // if(req.BEMOT) {
    // const data = await bupa.get('ZCDSEHBTC0003.AccountingIndicator').where({ AccountingIndicator: 'G6' });
    // if (data.length === 0) {
        //throw 'Order quantity must not exceed 11'
        //req.reject(418, 'Accounting Indicator is Invalid', "BEMOT");
        //req.error(400,'Accounting Indicator is Invalid',"BEMOT");
        // }
        // }

        req.reject ({
            code: 403,
            msg: 'Accounting Indicator is Invalid'
          })

    // }
}
const PrepareResultObject = async (arrayInput, objectAddStatus) => {
    /*Fire the Query to the Cloiud table */
    const addStatusDataArray = await SELECT.from('ZHS402.ZTHBT0028').where({ PRODUCTIONORDER: { in: arrayInput } });
    /*Prepare the Result in Object Format so that processing is quick */
    if (objectAddStatus) {
        objectAddStatus = {};
    }
    if (addStatusDataArray.length > 0) {
        for (let addStatusData of addStatusDataArray) {
            objectAddStatus[addStatusData.PRODUCTIONORDER] = addStatusData.ZPRINT;
        }
    }
}

const PrepareWherUsedObject = async (arrayInput, objectAddMSCode) => {
    /*Fire the Query to the Cloiud table */
    const addMSCodeDataArray = await SELECT.from('ZHS402.ZTHBT0033').where({ MSCODE: { in: arrayInput } });
    /*Prepare the Result in Object Format so that processing is quick */
    if (objectAddMSCode) {
        objectAddMSCode = {};
    }
    if (addMSCodeDataArray.length > 0) {
        for (let addCodeData of addMSCodeDataArray) {
            objectAddMSCode[addCodeData.MSCODE] = addCodeData.MODEL;
        }
    }
    return objectAddMSCode;
}
const PrepareModelData = async (arrayInput, objectAddModel) => {
    /*Fire the Query to the Cloiud table */
    const addMSCodeDataArray = await SELECT.from('ZHS402.ZTHBT0056').where({ MOD_CODE: { in: arrayInput } });
    /*Prepare the Result in Object Format so that processing is quick */
    if (objectAddModel) {
        objectAddModel = {};
    }
    if (addMSCodeDataArray.length > 0) {
        for (let addModelData of addMSCodeDataArray) {
            objectAddModel[addModelData.MSCODE] = addModelData.MOD_ITEM;
        }
    }
    return objectAddModel;
}
