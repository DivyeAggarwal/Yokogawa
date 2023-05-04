
const SequenceHelper = require("./lib/SequenceHelper");
const registerTimeSheetHandler = require("./Handler/TimeSheet-Service");
const registerProductionOrderPrint = require("./Handler/ProductionOrderPrint");
const registerBomRegisterError = require("./Handler/BomRegistrationErrorUpdate");
const registerZAPIBPS0001Handler = require("./Handler/ZAPIBPS0001");
const cds = require('@sap/cds');
const { read } = require("@sap/cds/lib/utils/cds-utils");
const { SELECT, INSERT, UPDATE } = cds.ql

module.exports = cds.service.impl(async function (srv) {

    const db = await cds.connect.to("db");
    registerTimeSheetHandler(this, cds);
    registerProductionOrderPrint(this,cds);
    registerBomRegisterError(this,cds);
    registerZAPIBPS0001Handler(this,cds);
    
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
    this.on('READ', 'A_ProductPlant', async req => {
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

    
 this.on('READ', 'ZCDSEHPPB0060', async req => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});

this.on('READ', 'ZCDSEHPPB0083', async req => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Picking_List', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Step2_Requires2', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Step2_Requires1', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Step2_GoodsReceipt2', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Step2_GoodsReceipt1', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Step2_GoodsIssue2', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Step2_GoodsIssue1', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Step1_Requires2', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Step1_Requires1', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Step1_GoodsIssue2', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Step1_GoodsIssue1', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Signal_Start4', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Signal_Start3', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Signal_Start2', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Signal_Start1', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Scan_Start3', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Scan_Start2', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0005');
    return kandanListScanSrv.run(req.query);
});
this.on('Scan_Start1', async (req) => {
    const api = await cds.connect.to('ZSRVBHPP0005');
    var response = await api.tx(req).post("/Scan_Start1",req.data);
    return response;
    // return kandanListScanSrv.run(req.query);
});

this.on('READ', 'ZCDSEHPPB0085', async req => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0015');
    return kandanListScanSrv.run(req.query);
});
    this.on('CREATE', 'TenDigitsParts', async req => {
        const api = await cds.connect.to('API_PRODUCT_SRV');
        var dulicate = Object.assign({}, req.data);
        delete dulicate.PCKG_TYPE;
        delete dulicate.PCKG_TYPE_N; 
        delete dulicate.PCKG_STYLE;
        delete dulicate.PCKG_STYLE_N; 
        delete dulicate.SUPPLY_STYLE;
        delete dulicate.SUPPLY_STYLE_N; 
        delete dulicate.YEOS_MNF_MODEL; 
        delete dulicate.YEOS_MNF_NO; 
        delete dulicate.CreationDate;
        delete dulicate.LastChangeDate; 
        delete dulicate.ZTHBT0001;
        delete dulicate.ZTHBT0005; 
        var response = await api.tx(req).post("/A_Product",dulicate);

        var conversion = req.data.ZTHBT0001;
        conversion.PARTS_NO = response.Product;
        await INSERT.into('ZHS402.ZTHBT0001').entries(conversion);
        var oObject5 = req.data.ZTHBT0005; 
        await UPSERT.into('ZHS402.ZTHBT0005').entries(oObject5);
        return response;
    });
    

   
    this.on('CREATE', 'ZCDSEHPSC0011', async req => {
        const soapi = await cds.connect.to('ZSRVBHPS0010');
        req.data.InvDat = req.data.InvDat.split('-').join('');
        req.data.ActDat = req.data.ActDat.split('-').join('');
        var response = await soapi.tx(req).post("/ZCDSEHPSC0011",req.data);
        response.InvDat = response.InvDat.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
        response.ActDat = response.ActDat.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
        
        return response;
        // try {
        //     const results = await so.send({
        //         method: 'POST',
        //         path: 'ZCDSEHPSC0011',
        //         data: req.data
        //     });
        //     return results;
        // } catch (error) {
        //     console.log(error);
        //     req.error({
        //         code: 403,
        //         message: error.message
        //     })
        // }

    });



    this.on('UpdatePOItem', async (req) => {
        var inserEntries = []; 
        for (let index = 0; index < req.data.input.update.length; index++) {
            const oInput = req.data.input.update[index];
            var oInputQuery = SELECT.from('ZHS402.ZTHBT0027').where({ MBLNR: { '=': oInput.MBLNR }, ZEILE: { '=': oInput.ZEILE }, MJAHR: { '=': oInput.MJAHR }, SERNR: { '=': oInput.SERNR } });
            var oInputResults = await srv.run(oInputQuery); 
            if(oInputResults.length == 0){
                inserEntries.push(req.data.input.update[index]);
            }else{
              const updateQuery =  UPDATE.entity('ZHS402.ZTHBT0027').data(oInput).where({ MBLNR: { '=': oInput.MBLNR }, ZEILE: { '=': oInput.ZEILE }, MJAHR: { '=': oInput.MJAHR }, SERNR: { '=': oInput.SERNR } }); //UPDATE('ZHS402.ZTHBT0027').with(oInput); 
              await srv.run(updateQuery);
            }
        } 
        if (inserEntries.length > 0) {
            const insertQuery = INSERT.into('ZHS402.ZTHBT0027').entries(inserEntries); 
            await srv.run(insertQuery);
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

    this.on('READ', 'BOMDisplay', async req => {
        const db = await cds.connect.to('db');
        if (req.query) {
            const doc_type_idx = req.query.SELECT.where.findIndex((filter) => filter && filter.ref && filter.ref.find((field) => field === "E_DOC_TYPE"));
            if (doc_type_idx >= 0) {
                var E_DOC_TYPE = req.query.SELECT.where[doc_type_idx + 2].val
            }
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
        }

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
    this.after('READ', 'DigitPartList', async (req,res) => {
        res.results.$count = req.length;
    });

    this.on('READ', 'DigitPartList', async req => {
        const db = await cds.connect.to('db');
        var material;
        if(req.query.SELECT.where) {
            material = await SELECT.from('ZHS402.ZTHBT0001').where(req.query.SELECT.where); 
        } else {
            material = await SELECT.from('ZHS402.ZTHBT0001');
        }
        

        let arrayInput = [];
        if (Array.isArray(material)) {
            for (let result of material) {
                arrayInput.push(result.E_PARTS_NO);
            }
        }
        else {
            arrayInput.push(results.E_PARTS_NO);
        }
        let objectMaterialDesc = {};
        objectMaterialDesc = await PrepareMaterialData(arrayInput, objectMaterialDesc);

        let aData = [];
        for (let oData of material) {
            const data = {
                PARTS_NO: oData.PARTS_NO,
                E_PARTS_NO: oData.E_PARTS_NO,
                SOURCE_CD: oData.SOURCE_CD,
                YEOS_MNF_NO: oData.YEOS_MNF_NO
            }
            if (oData.E_PARTS_NO) {
                let matDescription = objectMaterialDesc[oData.E_PARTS_NO];
                // const bupa = await cds.connect.to('API_PRODUCT_SRV');
                // const MatDesc = await bupa.get('ZCDSEHBTC0009.A_ProductDescription').where({ Product: oData.E_PARTS_NO });
                if (matDescription) {
                    data.MATERIALDESC = matDescription;
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
                    result.MOD_CODE = DataFromObject;
                } else if(DataFromModTable) {
                    result.MOD_CODE = DataFromModTable;
                }

            }
        }
        else {
            let DataFromObject = objectAddStatus[results.ZZ1_MSCODE_PRD];
            let DataFromModTable = objectAddModel[result.ZZ1_MSCODE_PRD];
            if (DataFromObject) {
                results.MOD_CODE = DataFromObject;
            } else if(DataFromModTable) {
                results.MOD_CODE = DataFromModTable;
            }
        }

        return results;
    });

    this.on('READ', 'materialWhereUsedMaster', async req => {
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
                    result.MOD_CODE = DataFromObject;
                } else if(DataFromModTable) {
                    result.MOD_CODE = DataFromModTable;
                }

            }
        }
        else {
            let DataFromObject = objectAddStatus[results.ZZ1_MSCODE_PRD];
            let DataFromModTable = objectAddModel[result.ZZ1_MSCODE_PRD];
            if (DataFromObject) {
                results.MOD_CODE = DataFromObject;
            } else if(DataFromModTable) {
                results.MOD_CODE = DataFromModTable;
            }
        }

        return results;
    });

    this.on('READ', 'checkProductionPart', async req => {
        if (req._query) {
            var prodPart = req._query.prodPart;

            const parts = await SELECT.from('ZHS402.ZTHBT0001').where({ PARTS_NO: prodPart });
            if (parts.length > 0) {
                const product = await cds.connect.to('API_PRODUCT_SRV');
                const productPlant = await product.get('ZCDSEHBTC0007.A_ProductPlant').where({ Product: prodPart });
                if (productPlant.length > 0) {
                    var results = {
                        "flag": true
                    }
                } else {
                    var results = {
                        "flag": false
                    }
                }
            } else {
                var results = {
                    "flag": false
                }
            }
            return results;
        }
    });

    //BOM Table Update
    this.on('CREATE', 'ManBOMUpload', async req => {
        const api = await cds.connect.to('ZSRVBHPP0012');
        var queries = [];
        req.data.UploadFile.forEach(e => {
            let query =  SELECT.from("ZSRVBHPP0012.ZCDSEHPPB0071").where([ 
                { ref: ["e_doc_type"] }, '=', { val: e.e_doc_type }, 'and', 
                { ref: ["e_doc_no"] }, '=', { val: e.e_doc_no }, 'and', 
                { ref: ["e_rev_no"] }, '=', { val: e.e_rev_no }, 'and', 
                { ref: ["e_doc_n"] }, '=', { val: e.e_doc_n }, 'and', 
                { ref: ["ps_group_no"] }, '=', { val: e.ps_group_no }, 'and', 
                { ref: ["ps_item_no"] }, '=', { val: e.ps_item_no }, 'and', 
                { ref: ["model1"] }, '=', { val: e.model1 }, 'and', 
                { ref: ["e_parts_no"] }, '=', { val: e.e_parts_no }, 'and', 
                { ref: ["comp_parts_no"] }, '=', { val: e.comp_parts_no }, 'and', 
                { ref: ["ten_digit_sign"] }, '=', { val: e.ten_digit_sign }, 'and', 
                { ref: ["parts_qty"] }, '=', { val: e.parts_qty }, 'and', 
                { ref: ["parts_qty_unit"] }, '=', { val: e.parts_qty_unit }, 'and', 
                { ref: ["select_sign"] }, '=', { val: e.select_sign }, 'and', 
                { ref: ["parts_use_ratio"] }, '=', { val: e.parts_use_ratio }, 'and', 
                { ref: ["ps_note"] }, '=', { val: e.ps_note }, 'and', 
                { ref: ["or_sign"] }, '=', { val: e.or_sign }, 'and', 
                { ref: ["sfix_digit_ptn"] }, '=', { val: e.sfix_digit_ptn }, 'and', 
                { ref: ["sfix_ptn"] }, '=', { val: e.sfix_ptn }, 'and', 
                { ref: ["option_ptn"] }, '=', { val: e.option_ptn }, 'and', 
                { ref: ["prod_career"] }, '=', { val: e.prod_career }, 'and', 
                { ref: ["e_tr_type"] }, '=', { val: e.e_tr_type }, 'and', 
                { ref: ["ps_symbol"] }, '=', { val: e.ps_symbol }, 'and', 
                { ref: ["valid_frm"] }, '=', { val: e.valid_frm }
            ]);
            queries.push(query);
        }); 
        return api.tx(req).run(queries).then(async (response) => {
            var output = [];
            for (let index = 0; index < response.length; index++) {
                const element = response[index][0];
                delete element["$metadata"];
                output.push(element);
            }
            bomFileDuplicateCheck(output);
            return itemMasterCheck(output).then(() =>{
                return mapZTHBT0008(output, req).then(() =>{
                    return mapZTHBT0009(output, req).then(() =>{
                        return mapZTHBT0037(output, req).then(() =>{
                            for (let index = 0; index < output.length; index++) {
                                const element = output[index];
                                delete element.Parts_No_ext_sign; 
                            }
                            return {
                                "Plant":"5800",
                                "UploadFile":output
                            };
                        });
                    });
                });
            });
             
           
        });
    });

    
    this.on('READ', 'ZCDSEHPPB0071', async req => {
        const product = await cds.connect.to('ZSRVBHPP0012');
        return product.run(req.query);
    });

});

const mapZTHBT0037 = async (finalData,req) => {
    var aZTHBT0037 = [];
    for (let index = 0; index < finalData.length; index++) {
        const element = finalData[index];
        var object = {};
        if(!element.error_cod){
            object.WERKS = req.data.Plant;
            object.E_DOC_TYPE = element.e_doc_type;
            object.E_DOC_NO = element.e_doc_no;
            object.E_REV_NO = element.e_rev_no;
            object.PS_GROUP_NO = element.ps_group_no;
            object.PS_ITEM_NO = element.ps_item_no;
            object.MODEL = element.model1;
            object.E_SEQUENCE_NO = '001';
            object.PS_SYMBOL = element.ps_symbol;
            object.E_PART_NO = element.e_parts_no;
            object.TEN_DIGIT_SIGN = element.ten_digit_sign;
            object.COMP_PART_NO = element.comp_parts_no;
            object.PARTS_QTY = element.parts_qty;
            object.PARTS_QTY_UNIT = element.parts_qty_unit;
            object.SELECT_SIGN = element.select_sign;
            object.PARTS_USE_RATIO = element.parts_use_ratio;
            object.PS_NOTE = element.ps_note;
            object.OR_SIGN = element.or_sign;
            object.SFIX_DIGIT_PTN = element.sfix_digit_ptn;
            object.SFIX_PTN = element.sfix_ptn;
            object.OPTION_PTN = element.option_ptn;
            object.PROD_CARRER = element.prod_career;
            object.EFFECT_D = element.valid_frm;
            // object.INVALID_D = element.Plant;
            object.E_TR_TYPE = element.e_tr_type;
            object.PARTS_NO_EXT_SIGN = element.Parts_No_ext_sign; 
            if(object.E_TR_TYPE === "A"){
                var erTypeA = await SELECT.from('ZHS402.ZTHBT0037').where({
                    E_DOC_NO: object.E_DOC_NO,
                    PS_GROUP_NO: object.PS_GROUP_NO,
                    PS_ITEM_NO: object.PS_ITEM_NO,
                    MODEL: object.MODEL
                });
                if(erTypeA.length > 0 && (erTypeA[0].E_TR_TYPE === "A" || erTypeA[0].E_TR_TYPE === "C")){
                    element.error_cod += "Add-on table updated error for E_TR_TYPE Not-match. ";
                }
            }
            if(object.E_TR_TYPE === "C" || object.E_TR_TYPE === "D"){
                var erTypeCD = await SELECT.from('ZHS402.ZTHBT0037').where({
                    E_DOC_NO: object.E_DOC_NO,
                    PS_GROUP_NO: object.PS_GROUP_NO,
                    PS_ITEM_NO: object.PS_ITEM_NO,
                    MODEL: object.MODEL
                });
                if(erTypeCD.length > 0 && (erTypeCD[0].E_TR_TYPE === "A" || erTypeCD[0].E_TR_TYPE === "C")){
                    element.error_cod += "Add-on table updated error for E_TR_TYPE Not-match. ";
                }
            }
            var allOld = await SELECT.from('ZHS402.ZTHBT0037').where({
                E_DOC_NO: object.E_DOC_NO,
                PS_GROUP_NO: object.PS_GROUP_NO,
                PS_ITEM_NO: object.PS_ITEM_NO,
                MODEL: object.MODEL
            });
            if(allOld.length > 1){
                allOld.sort(function(c,d){return c.EFFECT_D - d.EFFECT_D});
                if(allOld[allOld.length - 1].EFFECT_D > new Date(element.valid_frm)){
                    element.error_cod += "old revision entry is in future than the Valid From date of new revision entry. ";
                }else if(!element.error_cod){
                    allOld[allOld.length - 1].INVALID_D = element.valid_frm;
                    var currentOld = allOld[allOld.length - 1];
                    UPDATE.entity('ZHS402.ZTHBT0037').with({INVALID_D:currentOld.INVALID_D}).where({ WERKS: { '=': currentOld.WERKS }, E_DOC_TYPE: { '=': currentOld.E_DOC_TYPE }, E_DOC_NO: { '=': currentOld.E_DOC_NO }, E_REV_NO: { '=': currentOld.E_REV_NO }, PS_GROUP_NO: { '=': currentOld.PS_GROUP_NO }, PS_ITEM_NO: { '=': currentOld.PS_ITEM_NO }, MODEL: { '=': currentOld.MODEL }, E_SEQUENCE_NO: { '=': currentOld.E_SEQUENCE_NO } }); //UPDATE('ZHS402.ZTHBT0027').with(oInput); 
                }
            }else if(allOld.length === 1){
                var validToDate = new Date(object.EFFECT_D);
                validToDate.setDate(validToDate.getDate() - 1);
                allOld[0].INVALID_D = validToDate;
            }
            if(!element.error_cod){
                aZTHBT0037.push(object);
            }     
                
        }       
    } 
    if(aZTHBT0037.length > 0){
        for (let index = 0; index < aZTHBT0037.length; index++) {
            const element = aZTHBT0037[index];
            const updateQuery = UPDATE.entity('ZHS402.ZTHBT0037').data(element).where({ WERKS: { '=': element.WERKS }, E_DOC_TYPE: { '=': element.E_DOC_TYPE }, E_DOC_NO: { '=': element.E_DOC_NO }, E_REV_NO: { '=': element.E_REV_NO }, PS_GROUP_NO: { '=': element.PS_GROUP_NO }, PS_ITEM_NO: { '=': element.PS_ITEM_NO }, MODEL: { '=': element.MODEL }, E_SEQUENCE_NO: { '=': element.E_SEQUENCE_NO } }); //UPDATE('ZHS402.ZTHBT0027').with(oInput); 
            await srv.run(updateQuery);
        }
    }
    return finalData;
}

const bomFileDuplicateCheck = (finalData) => { 
    for (let index = 0; index < finalData.length; index++) {
        var element = finalData[index];
        var aObject = finalData.filter(function name(params) {
            return params.e_doc_no === element.e_doc_no &&
            params.e_rev_no === element.e_rev_no &&
            params.ps_group_no === element.ps_group_no &&
            params.ps_item_no === element.ps_item_no
        });
        //16	Duplicate Check
        if(aObject.length > 1){
            aObject.forEach(element => {
                element.error_cod += "Key Field Duplicate in file. ";
            }); 
        }
    } 
    return finalData;
}

const itemMasterCheck = async (finalData) => {
    for (let index = 0; index < finalData.length; index++) {
        var element = finalData[index];
        //15	Validate E_TR_TYPE
        if(element.e_tr_type !== "A" && element.e_tr_type !== "C" && element.e_tr_type !== "D"){
            element.error_cod += "E_TR_TYPE  is  other than 'A'  or 'C'  or  'D'. ";
        }
        // Input file check/Required Check
        if(element.e_doc_type === "FE0" && 
        (element.e_doc_no.length === 0 || element.e_rev_no.length === 0 || element.ps_group_no.length === 0 || 
            element.ps_item_no.length === 0 || element.model1.length === 0 || element.valid_frm.length === 0 ||
            element.e_parts_no.length === 0 || element.comp_parts_no.length === 0 ||
            element.ten_digit_sign.length === 0 || element.parts_qty.length === 0  || element.parts_qty_unit.length === 0
            || element.select_sign.length === 0 || element.parts_use_ratio.length === 0 || element.e_tr_type.length === 0) ){
            element.error_cod += "Key field not availabl. ";
        }
        if(element.e_doc_type === "FE1" && 
        (element.or_sign.length === 0 || element.sfix_digit_ptn.length === 0 || element.sfix_ptn.length === 0 || element.option_ptn.length === 0 || element.prod_career.length === 0 ) ){
            element.error_cod += "Key field not availabl. ";
        }
        var results = await SELECT.from('ZHS402.ZTHBT0006').where({
            E_PARTS_NO: element.e_parts_no
        });
        //18	Acquire part No.Item Master (Engineering Parts Data) (ZTHBT0006)

        if(results.length === 0){
            element.error_cod += "Item Master does not exist. ";
        }else{
        //19	Retrieval of the Parts Type Parts Type (ZTHBT0015)

         var aPARTS_TYPE = await SELECT.from('ZHS402.ZTHBT0015').where({
                PARTS_TYPE: results[0].PARTS_TYPE
            });
            if(aPARTS_TYPE.length === 0){
                element.error_cod += "PARTS_TYPE does not exist . ";
            }else if(aPARTS_TYPE[0].PARTS_NO_EXT_SIGN === "1"){
                finalData.Parts_No_ext_sign = "1";
            }else{
                finalData.Parts_No_ext_sign = "0";
            }
        }        
    }
    return finalData;
}

const mapZTHBT0008 = async (finalData, req) => {
    var aZTHBT0008 = [];
    element = req.data; 
        var object = {};
        object.YEOS_MODEL_GROUP = element.MainModel;
        object.FZ2_NO = element.FZ2No; 
        object.YEOS_MODEL_GROUP_N = element.MainModelName; 
        object.REV_SBJCT = element.Title; 
        object.E_EMP_NO = req.user.email; //Execution User ID  
        object.E_EMP_NAME = req.user.familyName; //Execution User Name
        object.E_DEPT_IN = element.OperationDept; 
        object.E_AUTHORIZED_D = element.ApprovedDate.toString().replace(/-/g,""); 
        object.APPLY_DATE_CD = element.ExecutionSchedule; 
        object.MODIFY_CAUSE = element.RevisionReason; 
        object.TRIAL_TYPE = null; 
        aZTHBT0008.push(object);  
        var noError = false;
        finalData.forEach(element => {
            var object = {};        
            if(!element.error_cod){ 
                noError = true;
            }
        }); 
        if(noError){
           await INSERT.into('ZHS402.ZTHBT0008').entries(aZTHBT0008);
        }       
}

const mapZTHBT0009 = async (finalData, req) => {
    var aZTHBT0009 = [];
    var index = 1;
    finalData.forEach(element => {
        var object = {};        
        if(!element.error_cod){
            object.YEOS_MODEL_GROUP = req.data.MainModel;
            object.FZ2_NO = req.data.FZ2No;
            object.FZ2_NO_SFIX = index.toString();
            object.E_DOC_TYPE = element.e_doc_type;
            object.E_DOC_NO = element.e_doc_no;
            object.E_REV_NO = element.e_rev_no;
            object.E_DOC_N = element.e_doc_n;
            object.MEDAI_TYPE = 'P'; 
            index++;
            aZTHBT0009.push(object);
        }
    });
    if(aZTHBT0009.length > 0){
        await INSERT.into('ZHS402.ZTHBT0009').entries(aZTHBT0009); 
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



const PrepareMaterialData = async (arrayInput, objectAddMaterial) => {
    /*Fire the Query to the Cloiud table */
    const bupa = await cds.connect.to('API_PRODUCT_SRV');
    const materialArray = await bupa.get('ZCDSEHBTC0009.A_ProductDescription').where({ Product: { in: arrayInput } });
    
    // const addMSCodeDataArray = await SELECT.from('ZHS402.ZTHBT0056').where({ MOD_CODE: { in: arrayInput } });
    /*Prepare the Result in Object Format so that processing is quick */
    if (objectAddMaterial) {
        objectAddMaterial = {};
    }
    if (materialArray.length > 0) {
        for (let addMaterial of materialArray) {
            objectAddMaterial[addMaterial.Product] = addMaterial.ProductDescription;
        }
    }
    return objectAddMaterial;
}
