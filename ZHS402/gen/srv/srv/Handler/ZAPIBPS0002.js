var registerZAPIBPS0002Handler = function (that, cds) {
    that.on('UPDATE', 'ZCDSEBPS0004', async req => {
        const bupa = await cds.connect.to('db');
        return bupa.run(req.query);
    });
    that.on('updateDiff', async (req) => {
        let oDataResults = await SELECT.from("ZHS402.ZTHBT0027").where(req.query.SELECT.from.ref[0].where);
        for(oData of oDataResults){
            if(oData.REASON_DIFF) {
                req.reject({
                    code: 403,
                    message: 'Reason is Already updated'
                });
            }
            oData.REASON_DIFF = req.data.ReasonForDiff;
            oData.CONFIRM_STATUS = 1;
            await UPSERT.into('ZHS402.ZTHBT0027').entries(oData);  
        }
        req.info({
            code: 200,
            message: 'Reason For Difference is updated successfully'
        });

        return oData;

    });
    that.on('updateDiffSM', async (req) => {
        let oDataResults = await SELECT.from("ZHS402.ZTHBT0027").where(req.query.SELECT.from.ref[0].where);
        for(oData of oDataResults){
            if(oData.REASON_DIFF) {
                req.reject({
                    code: 403,
                    message: 'Reason is Already updated'
                });
            }
            oData.REASON_DIFF = req.data.ReasonForDiff;
            oData.CONFIRM_STATUS = 1;
            await UPSERT.into('ZHS402.ZTHBT0027').entries(oData);  
        }
        req.info({
            code: 200,
            message: 'Reason For Difference is updated successfully'
        });

        return oData;

    })
    

    

}

module.exports = registerZAPIBPS0002Handler;