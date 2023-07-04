var registerZAPIBPS0012Handler = function (that, cds) {    
   
    that.on('READ', 'ZAPIBPS0012Report', async req => {
        const bupa = await cds.connect.to('ZSRVBHMM0007');
        req.query.SELECT.columns = [{ref:["PhysInvDoc"]},{ref:["Plant"]},{ref:["StorageLocation"]},{ref:["PlannedCountDate"]}];
        const selectflag_idx = req.req.originalUrl.indexOf("to_item");
        if (selectflag_idx > -1) {       
            var url = req.req.originalUrl.split("ZAPIBPS0012Report")      
            return await bupa.tx(req).get("/ZCDSEHMMC0014" + url[1]);
        }
        return bupa.run(req.query).then(async (res) => {
            console.log(res)
            var data = [];
            for (let index = 0; index < res.length; index++) {
                const element = res[index];               
                const dataFe =  await SELECT.from('ZHS402.ZTHBT0074').where({ PhysInvDoc: element.PhysInvDoc }).orderBy({ modifiedAt: "desc" });
                if(dataFe.length === 0){
                    element.STATUS = "Not Scheduled";
                }else{
                    element.STATUS = dataFe[0].STATUS;
                    element.MTYPE = dataFe[0].MTYPE;
                    element.CLASS = dataFe[0].CLASS;
                    element.MNO = dataFe[0].MNO;
                    element.MESSAGE = dataFe[0].MESSAGE;
                    element.SCHEDULED_DATE = dataFe[0].createdAt;
                    element.SCHEDULED_BY = dataFe[0].REQ_BY;
                    element.PROCESSED_DATE = dataFe[0].modifiedAt;
                } 
                data.push(element);
            }
            return data;
        });
    });
    
    that.on('CREATE', 'ZAPIBPS0012POST', async req => {
        const api = await cds.connect.to('ZAPIHMM0003_SRV');
        var dulicate = Object.assign({}, req.data);        
        dulicate.Budat = dulicate.Budat + "T00:00:00";
        dulicate.Gidat = dulicate.Gidat + "T00:00:00";
        // delete dulicate.HeaderToItemNav;
        // dulicate.HeaderToItemNav = JSON.parse(req.data.HeaderToItemNav);        
        var response = await api.tx(req).post("/HeaderPISet",dulicate); 
        return response;
    });
    
    that.on('READ', 'ZAPIBPS0012_PlantStdVH', async req => {
        const kandanListScanSrv = await cds.connect.to('ZSRVBHMM0007');
        return kandanListScanSrv.run(req.query);
    });
    that.on('READ', 'ZAPIBPS0012_StorageLocationStdVH', async req => {
        const kandanListScanSrv = await cds.connect.to('ZSRVBHMM0007');
        return kandanListScanSrv.run(req.query);
    });

} 
module.exports = registerZAPIBPS0012Handler;

