var registerZAPIBPS0002Handler = function (that, cds) {
    
    that.on('UPDATE', 'ZCDSEBPS0004', async req => {
        const bupa = await cds.connect.to('db');
        return bupa.run(req.query);
    });
    that.on('updateDiff', async (req) => {
        if(!req.data.ReasonForDiff){
            req.reject({
                code: 403,
                message: 'please provide the reason for difference'
            });
        }
        let oDataResults = await SELECT.from("ZHS402.ZTHBT0027").where(req.query.SELECT.from.ref[0].where);
        for(oData of oDataResults){
            if(oData.REASON_DIFF) {
                req.reject({
                    code: 403,
                    message: 'Reason is Already updated'
                });
            }
            oData.REASON_DIFF = req.data.ReasonForDiff;
            oData.CONFIRM_STATUS = 2;
            await UPSERT.into('ZHS402.ZTHBT0027').entries(oData);  
        }
        req.info({
            code: 200,
            message: 'Reason For Difference is updated successfully'
        });
        oData.Criticality = 2;
        return oData;

    });
    that.on('updateDiffSM', async (req) => {
        if(!req.data.ReasonForDiffSM){
            req.reject({
                code: 403,
                message: 'please provide the reason for difference'
            });
        }
        let oDataResults = await SELECT.from("ZHS402.ZTHBT0027").where(req.query.SELECT.from.ref[0].where);
        for(oData of oDataResults){
            if(oData.REASON_DIFF) {
                req.reject({
                    code: 403,
                    message: 'Reason is Already updated'
                });
            }
            oData.REASON_DIFF = req.data.ReasonForDiffSM;
            oData.CONFIRM_STATUS = 2;
            
            await UPSERT.into('ZHS402.ZTHBT0027').entries(oData);  
        }
        req.info({
            code: 200,
            message: 'Reason For Difference is updated successfully'
        });
        oData.Criticality = 2;
        return oData;

    })
}

module.exports = registerZAPIBPS0002Handler;