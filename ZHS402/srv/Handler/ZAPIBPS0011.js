var registerZAPIBPS0011Handler = function (that, cds) {    
   
    that.on('READ', 'ZCDSEHPPB0062', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        return bupa.run(req.query);
    });
    
    that.on('READ', 'ZCDSEHPPC0010', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');       
        req.query.SELECT.columns = formatProdOrderColumns(req); 
        var where = [];
        var sBTYPEORDER = "";
        var sTRANS_DES = "";
        for (let index = 0; index < req.query.SELECT.where.length; index++) {
            const element = req.query.SELECT.where[index];
            if(element && element.ref && (element.ref[0] === "BTYPEORDER" || element.ref[0] === "TRANS_DES")){
                index = index + 2;
                if(element.ref[0] === "BTYPEORDER"){
                    sBTYPEORDER = req.query.SELECT.where[index].val
                }
                if(element.ref[0] === "TRANS_DES"){
                    sTRANS_DES = req.query.SELECT.where[index].val
                }
                where.pop();
            }else{
                where.push(element);
            }
        }
        req.query.SELECT.where = where;
        return bupa.run(req.query).then(async (res) => {           
            return formatProdOrderFields(res, sBTYPEORDER, sTRANS_DES);
        });
    });
    
    that.on('READ', 'ZCDSEHPPC0011', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        return bupa.run(req.query);
    });
    
    that.on('READ', 'ZCDSEHPPC0023', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        return bupa.run(req.query);
    });    
    
    that.on('READ', 'ZCDSEHPPC0012', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        return bupa.run(req.query);
    });
    
    that.on('READ', 'ZCDSEHPPC0013', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        req.query.SELECT.columns = formatCancelColumns(req);
        return bupa.run(req.query).then(async (res) => {           
            return formatProdOrderCancelFields(res);
        });
    });
    
    that.on('READ', 'ZCDSEHPPC0014', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');       
        req.query.SELECT.columns = formatProdOrderColumns(req);
        var where = [];
        var sBTYPEORDER = "";
        var sTRANS_DES = "";
        for (let index = 0; index < req.query.SELECT.where.length; index++) {
            const element = req.query.SELECT.where[index];
            if(element && element.ref && (element.ref[0] === "BTYPEORDER" || element.ref[0] === "TRANS_DES")){
                index = index + 2;
                if(element.ref[0] === "BTYPEORDER"){
                    sBTYPEORDER = req.query.SELECT.where[index].val
                }
                if(element.ref[0] === "TRANS_DES"){
                    sTRANS_DES = req.query.SELECT.where[index].val
                }
                where.pop();
            }else{
                where.push(element);
            }
        }
        req.query.SELECT.where = where;
        return bupa.run(req.query).then(async (res) => {           
            return formatProdOrderFields(res, sBTYPEORDER, sTRANS_DES);
        });
    });
    
    that.on('READ', 'ZAPIBPS0011', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        return bupa.run(req.query);
    });
    
    that.on('READ', 'I_PlannedOrderStdVH', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        return bupa.run(req.query);
    });
    
    that.on('READ', 'I_SalesOrderStdVH', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        return bupa.run(req.query);
    });
    
    that.on('READ', 'I_WorkCenterStdVH', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        return bupa.run(req.query);
    });
    
    that.on('READ', 'I_ProductionOrderStdVH', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        return bupa.run(req.query);
    });
    
    that.on('READ', 'I_MaterialStdVH', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        return bupa.run(req.query);
    });
    
    that.on('READ', 'I_PlantStdVH', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        return bupa.run(req.query);
    });
} 

async function formatProdOrderCancelFields(res){
    // console.log(res);
    var finalData = [];
    for (let index = 0; index < res.length; index++) {
        const element = res[index];
        var object = {
            STATUS:""
        }        
        var aZTHBT0028 = await SELECT.from('ZHS402.ZTHBT0028').where({
            PRODUCTIONORDER: element.aufnr
        });
        if(aZTHBT0028.length > 0){
            object.STATUS = aZTHBT0028[0].STATUS;
        }
        object = {...object, ...element}
        finalData.push(object);
    }
    return finalData; 
}

async function formatProdOrderFields(res, sBTYPEORDER, sTRANS_DES){
    // console.log(res);
    var finalData = [];
    for (let index = 0; index < res.length; index++) {
        const element = res[index];
        var object = {
            BTYPEORDER:"",
            TRANS_DES:"",
            BTYPEITEM:"",
            BTYPECAT:"",
            BTYPESTATUS:"",
            PRDSTNO:"",
            AUFNR:"",
            ZZG_PRINTED_REV:"",
            ZPRINT:"",
        }
        var objet = {}
        if(element.porder){
            objet.PAUFNR = element.porder;
        }else{
            objet.PAUFNR = element.aufnr;
        }
        if(sBTYPEORDER){
            objet.BTYPEORDER = sBTYPEORDER;
        }
        if(sTRANS_DES){
            objet.TRANS_DES = sTRANS_DES;
        }
        
        var aZTHBT0029 = await SELECT.from('ZHS402.ZTHBT0029').where(objet);
        if(aZTHBT0029.length > 0){
            object.BTYPEORDER = aZTHBT0029[0].BTYPEORDER;
            object.BTYPEITEM = aZTHBT0029[0].BTYPEITEM;
            object.BTYPECAT = aZTHBT0029[0].BTYPECAT;
            object.BTYPESTATUS = aZTHBT0029[0].BTYPESTATUS;
            object.PRDSTNO = aZTHBT0029[0].PRDSTNO;
            object.AUFNR = aZTHBT0029[0].AUFNR;
        }
        
        var aZTHBT0028 = await SELECT.from('ZHS402.ZTHBT0028').where({
            PRODUCTIONORDER: element.aufnr
        });
        if(aZTHBT0028.length > 0){
            object.ZZG_PRINTED_REV = aZTHBT0028[0].ZZG_PRINTED_REV;
            object.ZPRINT = aZTHBT0028[0].ZPRINT;
        }
        object = {...object, ...element}
        finalData.push(object);
    }
    return finalData; 
}

function formatProdOrderColumns(req){
    var columns = []
    req.query.SELECT.columns.forEach(element => {
        if(["BTYPEORDER","TRANS_DES", "BTYPEITEM", "BTYPECAT", "BTYPESTATUS", "PRDSTNO",  "AUFNR", "ZZG_PRINTED_REV", "ZPRINT", "STATUS"].indexOf(element.ref[0]) === -1){
            columns.push(element);
        }
    });
    return columns;
}
function formatCancelColumns(req){
    var columns = []
    req.query.SELECT.columns.forEach(element => {
        if(["STATUS"].indexOf(element.ref[0]) === -1){
            columns.push(element);
        }
    });
    return columns;
}
module.exports = registerZAPIBPS0011Handler;