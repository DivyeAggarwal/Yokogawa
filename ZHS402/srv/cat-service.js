
const SequenceHelper = require("./lib/SequenceHelper");
const registerTimeSheetHandler = require("./Handler/TimeSheet-Service");
const registerProductionOrderPrint = require("./Handler/ProductionOrderPrint");
const registerBomRegisterError = require("./Handler/BomRegistrationErrorUpdate");
const registerZAPIBPS0001Handler = require("./Handler/ZAPIBPS0001");
const registerZAPIBPS0002Handler = require("./Handler/ZAPIBPS0002");
const registerZAPIBPS0004Handler = require("./Handler/ZAPIBPS0004");
const registerZAPIBPS0005Handler = require("./Handler/ZAPIBPS0005");
const registerZAPIBPS0006Handler = require("./Handler/ZAPIBPS0006");
const registerZCDSEHBTC0014Handler = require("./Handler/ZCDSEHBTC0014");
const registerZAPIBPS0007Handler = require("./Handler/ZAPIBPS0007");
const registerZAPIBPS0008Handler = require("./Handler/ZAPIBPS0008");
const registerZAPIBPS0009Handler = require("./Handler/ZAPIBPS0009");
const registerZAPIBPS0011Handler = require("./Handler/ZAPIBPS0011");
const registerZAPIBPS0012Handler = require("./Handler/ZAPIBPS0012");
const cds = require('@sap/cds');
const axios = require("axios");
const { read } = require("@sap/cds/lib/utils/cds-utils");
const { SELECT, INSERT, UPDATE } = cds.ql;
const { Readable, PassThrough } = require('stream');
const  XLSX  = require('xlsx');
// import { SCIMUsersShadowUsersApi} from "./generated/PlatformAPI";
//var SCIMUsersShadowUsersApi = require("./generated/PlatformAPI");

module.exports = cds.service.impl(async function (srv) {
    const api = 'xsuaa_api';
    const xsuaa_bind = JSON.parse(process.env.VCAP_SERVICES).xsuaa[0];
    const api_def = cds.env.requires[api];
    api_def.credentials.url = xsuaa_bind.credentials.url;
    const xsuaa = await cds.connect.to(api_def);
    this.on('READ', 'UserInfo', req => {
        const user = {
            id: req.user.id,
            tenant:req.user.tenant
        }
        return user;
    });
    this.on('READ', 'userInfoUAA', async () => {
        return await xsuaa.get("/userinfo");
    })

    const db = await cds.connect.to("db");
    registerTimeSheetHandler(this, cds);
    registerProductionOrderPrint(this,cds);
    registerBomRegisterError(this,cds);
    registerZAPIBPS0001Handler(this,cds);
    registerZAPIBPS0002Handler(this,cds);
    registerZAPIBPS0005Handler(this,cds);
    registerZAPIBPS0006Handler(this,cds);
    registerZCDSEHBTC0014Handler(this,cds);
    registerZAPIBPS0007Handler(this,cds);
    registerZAPIBPS0008Handler(this,cds);
    registerZAPIBPS0009Handler(this,cds);
    registerZAPIBPS0011Handler(this,cds);
    registerZAPIBPS0012Handler(this,cds);
    registerZAPIBPS0004Handler(this,cds,Readable, PassThrough,XLSX,SequenceHelper);
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
    this.on('READ', 'SAPCurrencies', async req => {
        const bupa = await cds.connect.to('ZSRVBHPS0010');
        return bupa.run(req.query);
    });
    this.on('READ', 'ZCDSEHPSB0055', async req => {
        const bupa = await cds.connect.to('ZSRVBHPS0010');
        return bupa.run(req.query);
    });
    this.on('READ', 'SAP__UnitsOfMeasure', async req => {
        const bupa = await cds.connect.to('ZSRVBHPS0008');
        return bupa.run(req.query);
    });
    this.on('READ', 'ZCDSEHPSC0013', async req => {
        const bupa = await cds.connect.to('ZSRVBHPS0011');
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

    this.on('READ', 'ZCDSEHMMC0009', async req => {
        const orderPart = await cds.connect.to('ZSRVBHMM0006');
        return orderPart.run(req.query);
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
this.on('Find_Scan', async (req) => {
    const api = await cds.connect.to('ZSRVBHPP0005');
    return api.postst("/Find_Scan?pkkey='" + req.data.pkkey + "'&pkbst='" + req.data.pkbst + "'&pkstu='" + req.data.pkstu + "'",{}).then((res, response, o) =>{
        return res;
    });
});

this.on('ZCDSEHPPB0093', async (req) => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0017');
    return kandanListScanSrv.run(req.query);
});

this.on('READ', 'ZCDSEHPPB0085', async req => {
    const api = await cds.connect.to('ZSRVBHPP0015');    
    return api.tx(req).run(req.query).then(async (response) => {
        var selectflag;
        const selectflag_idx = req.query.SELECT.where.findIndex((filter) => filter && filter.ref && filter.ref.find((field) => field === "selectflag"));
        if (selectflag_idx > 0) {
            selectflag = req.query.SELECT.where[selectflag_idx + 2].val
        }
        var output = [];
        for (let index = 0; index < response.length; index++) {
            const element = response[index];
            const aZTHBT0030 = await SELECT.from('ZHS402.ZTHBT0030').where({
                PKNUM: element.kanbannum,
                PKKEY: element.kanbanid
            }).orderBy({ REVNR: "desc" });
            //If its Display selectflag will be null
            //If its not Reissue there should not be any entry in 30
            //If its Reissue there should be any entry in 30 table
            if(!selectflag || (selectflag && selectflag !== "Y2" && aZTHBT0030 && aZTHBT0030.length === 0) || (selectflag && selectflag === "Y2" && aZTHBT0030 && aZTHBT0030.length > 0)){                
                if(aZTHBT0030.length > 0){
                    var iREVNR = 1;
                    if(Number(aZTHBT0030[0].REVNR) > 1 || Number(aZTHBT0030[0].REVNR) < 99){
                        iREVNR = Number(aZTHBT0030[0].REVNR) + 1;
                    }
                    iREVNR = "000" + iREVNR;
                    iREVNR = iREVNR.substr(iREVNR.length-2);
                    element.Process_flag = iREVNR;
                }                
                output.push(element);
            }            
        }  
        return output;
    }); 
});
this.on('READ', 'I_MaterialStdVH', async req => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0015');
    return kandanListScanSrv.run(req.query);
});
this.on('READ', 'I_PlantStdVH', async req => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0015');
    return kandanListScanSrv.run(req.query);
});
this.on('READ', 'I_StorageLocationStdVH', async req => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0015');
    return kandanListScanSrv.run(req.query);
});
this.on('READ', 'ZCDSEHPPB0068', async req => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0007');
    return kandanListScanSrv.run(req.query);
});
this.on('READ', 'ZCDSEHPPB0069', async req => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0008');
    return kandanListScanSrv.run(req.query);
});
this.on('READ', 'PickingData', async req => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0018');
    return kandanListScanSrv.run(req.query);
});
this.on('READ', 'ZCDSEHPPB0101', async req => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0018');
    return kandanListScanSrv.run(req.query);
});
this.on('READ', 'ZCDSEHPPB0100', async req => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0018');
    return kandanListScanSrv.run(req.query);
});
this.on('READ', 'ZCDSEHPPB0095', async req => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0018');
    return kandanListScanSrv.run(req.query);
});
this.on('READ', 'ZCDSEHPPB0008', async req => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0018');
    return kandanListScanSrv.run(req.query);
});
this.on('READ', 'ZCDSEHPPB0003', async req => {
    const kandanListScanSrv = await cds.connect.to('ZSRVBHPP0018');
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
        // req.data.InvDat = req.data.InvDat.split('-').join('');
        // req.data.ActDat = req.data.ActDat.split('-').join('');
        var response = await soapi.tx(req).post("/ZCDSEHPSC0011",req.data);
        // response.InvDat = response.InvDat.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
        // response.ActDat = response.ActDat.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
        
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

    this.on('CREATE', 'ZCDSEHMMC0013', async req => {
        const soapi = await cds.connect.to('ZSRVBHMM0006');
        var response = await soapi.tx(req).post("/ZCDSEHMMC0013",req.data);
        
        return response;

    });
    this.on('READ', 'ZCDSEHMMB0043', async req => {
        const product = await cds.connect.to('ZSRVBHMM0006');
        return product.run(req.query);
    });
    this.on('READ', 'ZCDSEHMMB0044', async req => {
        const product = await cds.connect.to('ZSRVBHMM0006');
        return product.run(req.query);
    });
    this.on('READ', 'ZCDSEHMMB0045', async req => {
        const product = await cds.connect.to('ZSRVBHMM0006');
        return product.run(req.query);
    });
    this.on('READ', 'ZCDSEHMMB0046', async req => {
        const product = await cds.connect.to('ZCDSEHMMB0046');
        return product.run(req.query);
    });
    this.on('READ', 'OrderPartInformation', async req => {
        var filterData = req._queryOptions;
        const orderApi = await cds.connect.to('ZSRVBHMM0006');
        req.query.SELECT.from.ref[0] = 'ZCDSEHBTC0015.ZCDSEHMMC0009'
        var t =  await orderApi.run(req.query);
        const vagrp_idx = req.query.SELECT.where.findIndex((filter) => filter && filter.ref && filter.ref.find((field) => field === "vagrp"));
            if (vagrp_idx >= 0) {
                var vagrp = req.query.SELECT.where[vagrp_idx + 2].val
            }
        // const plannedOrder = await orderApi.get('ZCDSEHBTC0015.ZCDSEHMMC0009').where(req.query.SELECT.where);
        if(vagrp == 3 || vagrp == 6) {
            // const plannedOrder = await orderApi.get('ZCDSEHBTC0015.ZCDSEHMMC0009').where({
            //     // plnum: filterData.plnum,
            //     plwrk: filterData.plwrk,
            //     vagrp: filterData.paart,
            //     dispo: filterData.dispo,
            //     // psttr: filterData.psttr,
            //     // pedtr: filterData.pedtr,
            //     // pertr: filterData.pertr
            // })
            const plannedOrder =  await orderApi.run(req.query);

            var uniqueKey = Math.floor(Math.random() * 99999).toString();
            var length = plannedOrder.length;
            var counter = 1;
            var lastValue = "";
            var payloadArray = [];
            for (let result of plannedOrder) {
                if(counter == length) {
                    lastValue = "X"
                }
                const btpPlannedOrder = await SELECT.from('ZHS402.ZTHBT0029').where({
                    DWERK: result.plwrk,
                    MATNR: result.matnr,
                    PLNUM: result.plnum
                })
                if (btpPlannedOrder.length == 0) {
                    result.psttr = result.psttr.split('-').join('');
                    result.pertr = result.pertr.split('-').join('');
                    result.pedtr = result.pedtr.split('-').join('');

                    var payload = {
                        plnum: result.plnum,
                        matnr: result.matnr,
                        plwrk: result.plwrk,
                        paart: result.paart,
                        gsmng: result.gsmng.toString(),
                        meins: result.meins,
                        psttr: result.psttr,
                        pedtr: result.pedtr,
                        pertr: result.pertr,
                        dispo: result.dispo,
                        kdauf: result.kdauf,
                        kdpos: result.kdpos,
                        kdein: result.kdein,
                        auffx: result.auffx,
                        vagrp: result.vagrp,
                        status: result.status,
                        errmsg: result.errmsg,
                        updqty: result.updqty,
                        auffx:"",
                        Cat3key:uniqueKey,
                        Cat3Last:lastValue
                    }
                    payloadArray.push(payload);
                    
                    //Create in S4 hana
                    try {
                        var response = await orderApi.tx(req).post("/ZCDSEHMMC0013",payload);
                    } catch (error) {
                        
                    }
                    
                }
                counter = counter + 1;
                
            }
            var responsePost = await orderApi.get('ZCDSEHBTC0015.ZCDSEHMMB0046').where({
                Cat3key: uniqueKey
            }) 
            for (let result of responsePost) {
            var dataPayload29 = {
                BTYPEORDER:result.Btypord.toString(),
                BTYPEITEM:parseInt(result.Btypitem),
                DWERK:result.Plwrk,
                BTYPECAT:result.Ordcat,
                AUFNR:result.Aufnr,
                PLNUM:result.Plnum,
                MATNR:result.Matnr,
                KDPOS:result.Kdpos,
                KDAUF:result.Kdauf,
                MEINS:result.Meins,
                GSMNG:result.Gsmng.toString(),
                MSCODE:result.MsCode,
                PSTTR: result.Pertr.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'),
                GSTRP: result.Psttr.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'),
                GLTRP: result.Pedtr.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'),
                PRDSTNO:result.Aufnr,
                ARBPL:response.Arbpl,
                LEVELINGGROUP:response.Lvlgrp,
                BTYPENOTE:response.Ktext
            }
            try {
                await INSERT.into('ZHS402.ZTHBT0029').entries(dataPayload29);
            } catch (error) {
                
            }
            
            var dataPayload28 = {
                PRODUCTIONORDER:result.Plnum,
                ZZPLANT:result.Plwrk,
                PRDSTNO:result.Aufnr
    
            }
            try {
                await INSERT.into('ZHS402.ZTHBT0028').entries(dataPayload28);
            } catch (error) {
                
            }
            
        }
        } else {
            // const plannedOrder = await orderApi.get('ZCDSEHBTC0015.ZCDSEHMMC0009').where({
            //     // plnum: filterData.plnum,
            //     plwrk: filterData.plwrk,
            //     vagrp: filterData.paart,
            //     dispo: filterData.dispo,
            //     // psttr: filterData.psttr,
            //     // pedtr: filterData.pedtr,
            //     // pertr: filterData.pertr
            // })
            const plannedOrder =  await orderApi.run(req.query);

            // var uniqueKey = Math.floor(Math.random() * 99999);
            // var length = plannedOrder.length;
            // var counter = 0;
            // var lastValue = "";
            for (let result of plannedOrder) {
                const btpPlannedOrder = await SELECT.from('ZHS402.ZTHBT0029').where({
                    DWERK: result.plwrk,
                    MATNR: result.matnr,
                    PLNUM: result.plnum
                })
                if (btpPlannedOrder.length == 0) {
                    result.psttr = result.psttr.split('-').join('');
                    result.pertr = result.pertr.split('-').join('');
                    result.pedtr = result.pedtr.split('-').join('');
                    var payload = {
                        plnum: result.plnum,
                        matnr: result.matnr,
                        plwrk: result.plwrk,
                        paart: result.paart,
                        gsmng: result.gsmng.toString(),
                        meins: result.meins,
                        psttr: result.psttr,
                        pedtr: result.pedtr,
                        pertr: result.pertr,
                        dispo: result.dispo,
                        kdauf: result.kdauf,
                        kdpos: result.kdpos,
                        kdein: result.kdein,
                        auffx: "",
                        vagrp: result.vagrp,
                        status: result.status,
                        errmsg: result.errmsg,
                        updqty: result.updqty,
                        Cat3key:"",
                        Cat3Last:""
                    }
                    // payloadArray.push(payload);
                    
                    //Create in S4 hana

                    var response = await orderApi.tx(req).post("/ZCDSEHMMC0013",payload);

                    var dataPayload29 = {
                        BTYPEORDER:response.btypord.toString(),
                        BTYPEITEM:parseInt(response.Btypitem),
                        DWERK:response.plwrk,
                        BTYPECAT:response.OrdCat,
                        AUFNR:response.aufnr,
                        PLNUM:response.plnum,
                        MATNR:response.matnr,
                        KDPOS:response.kdpos,
                        KDAUF:response.kdauf,
                        MEINS:response.meins,
                        GSMNG:response.gsmng.toString(),
                        MSCODE:response.ms_code,
                        PSTTR: response.pertr.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'),
                        GSTRP: response.psttr.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'),
                        GLTRP: response.pedtr.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'),
                        PRDSTNO:response.aufnr,
                        ARBPL:response.arbpl,
                        LEVELINGGROUP:response.LvlGrp
                    }
                    await INSERT.into('ZHS402.ZTHBT0029').entries(dataPayload29);
                    if(vagrp == 'A') {
                    var dataPayload28 = {
                        PRODUCTIONORDER:response.btypord.toString(),
                        ZZPLANT:response.plwrk,
                        PRDSTNO:response.aufnr
            
                    }
                }
                    // await INSERT.into('ZHS402.ZTHBT0028').entries(dataPayload28);
                }
                
            }
        }
        

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

    this.on('READ', 'ZCDSEHPPC0015', async (context) => {
        if (context.query.SELECT.where) {
        const mcode_idx = context.query.SELECT.where.findIndex((filter) => filter && filter.ref && filter.ref.find((field) => field === "MATERIALCODE"));
        if (mcode_idx >= 0) {
            var ms_code = context.query.SELECT.where[mcode_idx + 2].val
        
        let responseWorkato = await axios({
            method: 'GET',
            url: "https://apim.workato.com/yokogawa_veri/y-api-v1/iomodule/bmsdiv?ms_code=" + ms_code,
            params: {
              $format: "json"
            },
            headers: {
              'Accept': 'application/json',
              'API-TOKEN': 'd265459426fb462263e03438a47ee3195177cfdb92aee0188695a94f80dea07a'
            }
          });
          var response = [];
          if(responseWorkato.data.err_code == "") {
            var suffix = responseWorkato.data.suffix;
            var option = responseWorkato.data.option;
            var materialCode = ms_code;
            var model = responseWorkato.data.model;

            for(var i=0;i < suffix.length; i++ ) {
                var responseArray = {
                    MATERIALCODE:materialCode,
                    MODEL:model,
                    SUFFIXLEVEL:suffix[i].suffix_level,
                    SUFFIXVALUE:suffix[i].suffix_id
                }
                response.push(responseArray);
            }
            var counter = 1;
            for(var i=0;i < option.length; i++ ) {
                
                var responseArrayOp = {
                    MATERIALCODE:materialCode,
                    MODEL:model,
                    SUFFIXLEVEL:"00" + counter.toString(),
                    SUFFIXVALUE:option[i].option_id
                }
                response.push(responseArrayOp);
                counter = counter + 1;
            }
          }
          
          return response;
        }
    }
    })

    this.after('CREATE', 'ZTHBT0033', async (context) => {
        var MSCODE = context.MSCODE;
        var PRODUCTCAREER = context.PRODUCTCAREER;
        var INSTRUMENTMODEL = context.INSTRUMENTMODEL;
        var PARTSNUMBER = context.PARTSNUMBER;
        var MODEL = context.MODEL;
        var PPLFLAG = context.PPLLAG;
        // var value = "";
        var code;
        const materialcode = await SELECT.from('ZHS402.ZTHBT0048').where({
            MODEL: context.MODEL,
        })
        if(materialcode.length > 0) {
            let sortedmaterialcode = materialcode.sort(
                (p1, p2) => (p1.ID < p2.ID) ? 1 : (p1.ID > p2.ID) ? -1 : 0);
            code = sortedmaterialcode[0].ID + 1;
        } else {
            code = 1;
        }
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
                const materialcodeppl = await SELECT.from('ZHS402.ZTHBT0048').where({
                    MODEL: context.MODEL,
                })
                if(materialcodeppl.length == 0) { 
                //PPL
                // const mcodeId = new SequenceHelper({
                //     db: db,
                //     sequence: "MATERIALCODE_ID",
                //     table: "ZTHBT0048",
                //     field: "ID"
                // });
                // var ID = await mcodeId.getNextNumber();
                var ID = code;
                var convertedID = String(code).padStart(9, "0");
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

                await UPDATE.entity('ZHS402.ZTHBT0033').with({ STATUS: "Registering" }).where({ MSCODE: { '=': MSCODE }, PRODUCTCAREER: { '=': PRODUCTCAREER }, INSTRUMENTMODEL: { '=': INSTRUMENTMODEL }, PARTSNUMBER: { '=': PARTSNUMBER }, MODEL: { '=': MODEL } });
            }
            }
            if (MSCODE) {
                // const mcodeId = new SequenceHelper({
                //     db: db,
                //     sequence: "MATERIALCODE_ID",
                //     table: "ZTHBT0048",
                //     field: "ID"
                // });
                // var ID = await mcodeId.getNextNumber();
                var ID = code;
                var convertedID = String(code).padStart(9, "0");

                let checkZ = MSCODE.includes('Z');
                if (checkZ == false) {
                    //Normal scenario

                    const materialcodee = await SELECT.from('ZHS402.ZTHBT0048').where({
                        MODEL: context.MODEL,
                        IDENTIFIER: "NR"
                    })
                    if(materialcodee.length > 0) {
                        let sortedmaterialcode = materialcodee.sort(
                            (p1, p2) => (p1.ID < p2.ID) ? 1 : (p1.ID > p2.ID) ? -1 : 0);
                        code = sortedmaterialcode[0].ID + 1;
                    } else {
                        code = 1;
                    }

                    ID = code;
                    convertedID = String(code).padStart(9, "0");

                    var MaterialCode = MODEL + "_F" + convertedID;
                    var conversion = {
                        ID: ID,
                        MSCODE: MSCODE,
                        PRODUCTCAREER: PRODUCTCAREER,
                        INSTRUMENTMODEL: INSTRUMENTMODEL,
                        PARTSNUMBER: PARTSNUMBER,
                        MODEL: MODEL,
                        MATERIALCODE: MaterialCode,
                        TOKUCHUFLAG: "",
                        IDENTIFIER: "NR"
                    };
                    await UPSERT.into('ZHS402.ZTHBT0048').entries(conversion);
                    await UPDATE.entity('ZHS402.ZTHBT0033').with({ STATUS: "Registering" }).where({ MSCODE: { '=': MSCODE }, PRODUCTCAREER: { '=': PRODUCTCAREER }, INSTRUMENTMODEL: { '=': INSTRUMENTMODEL }, PARTSNUMBER: { '=': PARTSNUMBER }, MODEL: { '=': MODEL } });

                } else if (checkZ == true && INSTRUMENTMODEL === "" && PARTSNUMBER === "") {
                    //Tokuchu Product
                    const materialcodee = await SELECT.from('ZHS402.ZTHBT0048').where({
                        MODEL: context.MODEL,
                        IDENTIFIER: "PR"
                    })
                    if(materialcodee.length > 0) {
                        let sortedmaterialcode = materialcodee.sort(
                            (p1, p2) => (p1.ID < p2.ID) ? 1 : (p1.ID > p2.ID) ? -1 : 0);
                        code = sortedmaterialcode[0].ID + 1;
                    } else {
                        code = 1;
                    }

                    ID = code;
                    convertedID = String(code).padStart(9, "0");

                    var MaterialCode = MODEL + "_Z" + convertedID;
                    var conversion = {
                        ID: ID,
                        MSCODE: MSCODE,
                        PRODUCTCAREER: PRODUCTCAREER,
                        INSTRUMENTMODEL: INSTRUMENTMODEL,
                        PARTSNUMBER: PARTSNUMBER,
                        MODEL: MODEL,
                        MATERIALCODE: MaterialCode,
                        TOKUCHUFLAG: "X",
                        IDENTIFIER: "PR"
                    };
                    await UPSERT.into('ZHS402.ZTHBT0048').entries(conversion);
                    await UPDATE.entity('ZHS402.ZTHBT0033').with({ STATUS: "Registering" }).where({ MSCODE: { '=': MSCODE }, PRODUCTCAREER: { '=': PRODUCTCAREER }, INSTRUMENTMODEL: { '=': INSTRUMENTMODEL }, PARTSNUMBER: { '=': PARTSNUMBER }, MODEL: { '=': MODEL } });
                } else if (checkZ == true && INSTRUMENTMODEL !== "" && PARTSNUMBER !== "") {
                    //Tokuchu Parts
                    const materialcodee = await SELECT.from('ZHS402.ZTHBT0048').where({
                        MODEL: context.MODEL,
                        IDENTIFIER: "TP"
                    })
                    if(materialcodee.length > 0) {
                        let sortedmaterialcode = materialcodee.sort(
                            (p1, p2) => (p1.ID < p2.ID) ? 1 : (p1.ID > p2.ID) ? -1 : 0);
                        code = sortedmaterialcode[0].ID + 1;
                    } else {
                        code = 1;
                    }

                    ID = code;
                    convertedID = String(code).padStart(9, "0");

                    var MaterialCode = PARTSNUMBER + "_" + convertedID;
                    var conversion = {
                        ID: ID,
                        MSCODE: MSCODE,
                        PRODUCTCAREER: PRODUCTCAREER,
                        INSTRUMENTMODEL: INSTRUMENTMODEL,
                        PARTSNUMBER: PARTSNUMBER,
                        MODEL: MODEL,
                        MATERIALCODE: MaterialCode,
                        TOKUCHUFLAG: "X",
                        IDENTIFIER: "TP"
                    };
                    await UPSERT.into('ZHS402.ZTHBT0048').entries(conversion);
                    await UPDATE.entity('ZHS402.ZTHBT0033').with({ STATUS: "Registering" }).where({ MSCODE: { '=': MSCODE }, PRODUCTCAREER: { '=': PRODUCTCAREER }, INSTRUMENTMODEL: { '=': INSTRUMENTMODEL }, PARTSNUMBER: { '=': PARTSNUMBER }, MODEL: { '=': MODEL } });
                }
            }
            //code for spec table
            // const specData = await SELECT.from('ZCDSEHBTC0006.ZCDSEHPPC0015').where({ MATERIALCODE: MSCODE });
            if (MSCODE !== "") {
                let responseWorkato = await axios({
                    method: 'GET',
                    url: "https://apim.workato.com/yokogawa_veri/y-api-v1/iomodule/bmsdiv?ms_code=" + MSCODE,
                    params: {
                        $format: "json"
                    },
                    headers: {
                        'Accept': 'application/json',
                        'API-TOKEN': 'd265459426fb462263e03438a47ee3195177cfdb92aee0188695a94f80dea07a'
                    }
                });
                var response = [];
                if (responseWorkato.data.err_code == "") {
                    var suffix = responseWorkato.data.suffix;
                    var option = responseWorkato.data.option;
                    var materialCode = MSCODE;
                    var model = responseWorkato.data.model;

                    for (var i = 0; i < suffix.length; i++) {
                        var responseArray = {
                            MATERIALCODE: materialCode,
                            MODEL: model,
                            SUFFIXLEVEL: suffix[i].suffix_level,
                            SUFFIXVALUE: suffix[i].suffix_id
                        }
                        response.push(responseArray);
                    }
                    var counter = 1;
                    for (var i = 0; i < option.length; i++) {

                        var responseArrayOp = {
                            MATERIALCODE: materialCode,
                            MODEL: model,
                            SUFFIXLEVEL: "00" + counter.toString(),
                            SUFFIXVALUE: option[i].option_id
                        }
                        response.push(responseArrayOp);
                        counter = counter + 1;
                    }
                }
                // await SELECT.from('ZCDSEHBTC0007.DATAFE0').where(req.query.SELECT.where)
                if (response.length > 0) {
                    // for(var i=0; i<response.length; i++) { 
                    // var conversionSpec = {
                    //     MATERIALCODE: response[i].MATERIALCODE,
                    //     MODEL: response[i].MODEL,
                    //     SUFFIXLEVEL: response[i].SUFFIXLEVEL,
                    //     SUFFIXVALUE: response[i].SUFFIXVALUE
                    // };
                    // }
                    await INSERT.into('ZHS402.ZTHBT0032').entries(response);
                }
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
    this.after('UPDATE','ZCDSEHPPC0016', async req => {
        await UPDATE.entity('ZHS402.ZTHBT0037').with({INVALID_D:req.INVALID_D}).where({ WERKS: { '=': req.WERKS }, E_DOC_TYPE: { '=': req.E_DOC_TYPE }, E_DOC_NO: { '=': req.E_DOC_NO }, E_REV_NO: { '=': req.E_REV_NO }, PS_GROUP_NO: { '=': req.PS_GROUP_NO }, PS_ITEM_NO: { '=': req.PS_ITEM_NO }, MODEL: { '=': req.MODEL }, E_SEQUENCE_NO: { '=': req.E_SEQUENCE_NO } }); //UPDATE('ZHS402.ZTHBT0027').with(oInput);
    })
    this.on('READ', 'Formalize', async req => {
        const db = await cds.connect.to('db');
        if (req.query) {
            const doc_type_idx = req.query.SELECT.where.findIndex((filter) => filter && filter.ref && filter.ref.find((field) => field === "E_DOC_TYPE"));
            if (doc_type_idx >= 0) {
                var E_DOC_TYPE = req.query.SELECT.where[doc_type_idx + 2].val
            }
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
                { ref: ["e_doc_type"] }, '=', { val: e.e_doc_type ? e.e_doc_type : ''  }, 'and', 
                { ref: ["e_doc_no"] }, '=', { val: e.e_doc_no ? e.e_doc_no : ''  }, 'and', 
                { ref: ["e_rev_no"] }, '=', { val: e.e_rev_no ? e.e_rev_no : ''  }, 'and', 
                { ref: ["e_doc_n"] }, '=', { val: e.e_doc_n ? e.e_doc_n : ''  }, 'and', 
                { ref: ["ps_group_no"] }, '=', { val: e.ps_group_no ? e.ps_group_no : ''  }, 'and', 
                { ref: ["ps_item_no"] }, '=', { val: e.ps_item_no ? e.ps_item_no : ''  }, 'and', 
                { ref: ["model1"] }, '=', { val: e.model1 ? e.model1 : ''  }, 'and', 
                { ref: ["e_parts_no"] }, '=', { val: e.e_parts_no ? e.e_parts_no : ''  }, 'and', 
                { ref: ["comp_parts_no"] }, '=', { val: e.comp_parts_no ? e.comp_parts_no : ''  }, 'and', 
                { ref: ["ten_digit_sign"] }, '=', { val: e.ten_digit_sign ? e.ten_digit_sign : ''  }, 'and', 
                { ref: ["parts_qty"] }, '=', { val: e.parts_qty ? e.parts_qty : ''  }, 'and', 
                { ref: ["parts_qty_unit"] }, '=', { val: e.parts_qty_unit ? e.parts_qty_unit : ''  }, 'and', 
                { ref: ["select_sign"] }, '=', { val: e.select_sign ? e.select_sign : ''  }, 'and', 
                { ref: ["parts_use_ratio"] }, '=', { val: e.parts_use_ratio ? e.parts_use_ratio : ''  }, 'and', 
                { ref: ["ps_note"] }, '=', { val: e.ps_note ? e.ps_note : ''  }, 'and', 
                { ref: ["or_sign"] }, '=', { val: e.or_sign ? e.or_sign : ''  }, 'and', 
                { ref: ["sfix_digit_ptn"] }, '=', { val: e.sfix_digit_ptn ? e.sfix_digit_ptn : ''  }, 'and', 
                { ref: ["sfix_ptn"] }, '=', { val: e.sfix_ptn ? e.sfix_ptn : ''  }, 'and', 
                { ref: ["option_ptn"] }, '=', { val: e.option_ptn ? e.option_ptn : ''  }, 'and', 
                { ref: ["prod_career"] }, '=', { val: e.prod_career ? e.prod_career : ''  }, 'and', 
                { ref: ["e_tr_type"] }, '=', { val: e.e_tr_type ? e.e_tr_type : ''  }, 'and', 
                { ref: ["ps_symbol"] }, '=', { val: e.ps_symbol ? e.ps_symbol : ''  }, 'and', 
                { ref: ["valid_frm"] }, '=', { val: e.valid_frm ? e.valid_frm : ''  }
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
    this.after('READ', 'yentard', async req => {
        const product = await cds.connect.to('YAPIARD');
    });
    this.on('READ', 'specificationChangeMessage', async req => {
        if(req.query.SELECT.where) {
        var results = await SELECT.from('ZHS402.ZTHBT0037').where(req.query.SELECT.where);
        } else {
            var results = await SELECT.from('ZHS402.ZTHBT0037');
        }
        return results;      
    });
    this.on('UPDATE', 'specificationChangeMessage', async req => {
        var oInput = req.data;
        var flag = false;
        if(oInput.COMP_PART_NO) {
            var results = await SELECT.from('ZHS402.ZTHBT0001').where({ ID: { '=': oInput.COMP_PART_NO }});
            if (results.length > 0) {
                flag = true
            }
        }
        if(flag == true) {
            req.data.ERROR_MESSAGE = "Enter Valid Part Number";
            return;
        }else {
            await UPDATE.entity('ZHS402.ZTHBT0037').with(req.data).where({ WERKS: { '=': oInput.WERKS }, E_DOC_TYPE: { '=': oInput.E_DOC_TYPE }, E_DOC_NO: { '=': oInput.E_DOC_NO }, E_REV_NO: { '=': oInput.E_REV_NO }, PS_GROUP_NO: { '=': oInput.PS_GROUP_NO }, PS_ITEM_NO: { '=': oInput.PS_ITEM_NO }, MODEL: { '=': oInput.MODEL }, E_SEQUENCE_NO: { '=': oInput.E_SEQUENCE_NO }});
        }
        
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
            
            var allOld = await SELECT.from('ZHS402.ZTHBT0037').where({
                E_DOC_NO: object.E_DOC_NO,
                PS_GROUP_NO: object.PS_GROUP_NO,
                PS_ITEM_NO: object.PS_ITEM_NO,
                MODEL: object.MODEL
            });

            if(object.E_TR_TYPE === "A"){
                if(allOld.length > 0 ){
                    for (let i = 0; i < allOld.length; i++) {
                        const elementI = allOld[i];
                        if(elementI.E_TR_TYPE === "A" || elementI.E_TR_TYPE === "C"){
                            element.error_cod += "Add-on table updated error for E_TR_TYPE Not-match. ";
                            i = allOld.length;
                        }                        
                    }
                } 
            }
            if(object.E_TR_TYPE === "C" || object.E_TR_TYPE === "D"){
                if(allOld.length > 0 ){
                    let cdCount = 0;
                    for (let J = 0; J < allOld.length; J++) {
                        const elementJ = allOld[J];
                        if(elementJ.E_TR_TYPE === "A" || elementJ.E_TR_TYPE === "C"){
                            cdCount++;
                            J = allOld.length;
                        }                        
                    }
                    if(cdCount === 0){
                        element.error_cod += "Add-on table updated error for E_TR_TYPE Not-match. ";
                    }
                }                 
            }
            if(allOld.length > 0){
                allOld.sort(function(c,d){return c.EFFECT_D - d.EFFECT_D});
                if(allOld[allOld.length - 1].EFFECT_D > new Date(element.valid_frm)){
                    element.error_cod += "old revision entry is in future than the Valid From date of new revision entry. ";
                }else if(!element.error_cod){
                    allOld[allOld.length - 1].INVALID_D = element.valid_frm;
                    var currentOld = allOld[allOld.length - 1];
                    await UPDATE.entity('ZHS402.ZTHBT0037').with({INVALID_D:currentOld.INVALID_D}).where({ WERKS: { '=': currentOld.WERKS }, E_DOC_TYPE: { '=': currentOld.E_DOC_TYPE }, E_DOC_NO: { '=': currentOld.E_DOC_NO }, E_REV_NO: { '=': currentOld.E_REV_NO }, PS_GROUP_NO: { '=': currentOld.PS_GROUP_NO }, PS_ITEM_NO: { '=': currentOld.PS_ITEM_NO }, MODEL: { '=': currentOld.MODEL }, E_SEQUENCE_NO: { '=': currentOld.E_SEQUENCE_NO } }); //UPDATE('ZHS402.ZTHBT0027').with(oInput); 
                }
            }
            if(!element.error_cod){
                aZTHBT0037.push(object);
            }     
                
        }       
    } 
    if(aZTHBT0037.length > 0){
        // for (let index = 0; index < aZTHBT0037.length; index++) {
            // const element = aZTHBT0037[index];
            //  await UPDATE.entity('ZHS402.ZTHBT0037').data(element).where({ WERKS: { '=': element.WERKS }, E_DOC_TYPE: { '=': element.E_DOC_TYPE }, E_DOC_NO: { '=': element.E_DOC_NO }, E_REV_NO: { '=': element.E_REV_NO }, PS_GROUP_NO: { '=': element.PS_GROUP_NO }, PS_ITEM_NO: { '=': element.PS_ITEM_NO }, MODEL: { '=': element.MODEL }, E_SEQUENCE_NO: { '=': element.E_SEQUENCE_NO } }); //UPDATE('ZHS402.ZTHBT0027').with(oInput); 
        // }
        await INSERT.into('ZHS402.ZTHBT0037').entries(aZTHBT0037);
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
        if((element.e_doc_type === "FE0" || element.e_doc_type === "FE1") &&  
        (element.e_doc_no.length === 0 || element.e_rev_no.length === 0 || element.ps_group_no.length === 0 || 
            element.ps_item_no.length === 0 || element.model1.length === 0 || element.valid_frm.length === 0 ||
            element.e_parts_no.length === 0 || element.comp_parts_no.length === 0 ||
            element.ten_digit_sign.length === 0 || element.parts_qty.length === 0  || element.parts_qty_unit.length === 0
            || element.select_sign.length === 0 || element.parts_use_ratio.length === 0 || element.e_tr_type.length === 0) ){
            element.error_cod += "Key field not availabl. ";
        }
        if(element.e_doc_type === "FE0" && 
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
