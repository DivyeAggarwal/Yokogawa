var registerZAPIBPS0004Handler = function (that, cds) {
    
    that.on('READ', 'Customer', async req => {
        const bupa = await cds.connect.to('BusinessPartner');
        return bupa.run(req.query);
    });
    that.on('READ', 'Project', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    that.on('READ','ZCDSEBPS0012',async req => {
        const bupa = await cds.connect.to('db');
        let results = bupa.run(req.query);
        let arrayInput = [];
        if (Array.isArray(results)) {
            for (let result of results) {
                arrayInput.push(result.ZSHTP);
            }
        }
        else {
            arrayInput.push(results.ZSHTP);
        }
        let objectCustomer = {};
        await PrepareResultObject(arrayInput, objectCustomer);

        /*Manipulate the result from cloud and On Premise */
        if (Array.isArray(results)) {
            for (let result of results) {
                let dataFromObject = objectCustomer[result.OrderNumber];
                if(dataFromObject){
                    delete dataFromObject.Customer;
                    delete dataFromObject.name1;
                    delete dataFromObject.name2;
                    Object.assign(result,dataFromObject);
                    
                }
            }
        }
        else {
            let dataFromObject = objectCustomer[results.OrderNumber];
                if(dataFromObject){
                    delete dataFromObject.Customer;
                    delete dataFromObject.name1;
                    delete dataFromObject.name2;
                    Object.assign(results,dataFromObject);
                }
        }

        return results;
    })
    that.on('DeleteSet', async (req) => {
        let oDataResults = await SELECT.from("ZHS402.ZTHBT0055").where(req.query.SELECT.from.ref[0].where);
        for(oData of oDataResults){
            oData.ZDELFLAG = abap_true;
        }
        await UPSERT.into('ZHS402.ZTHBT0027').entries(oData);  
        req.info({
            code: 200,
            message: 'Deletion flag is set successfully'
        });
        return oData;

    });
    that.on('split', async (req) => {
        let oDataResults = await SELECT.from("ZHS402.ZTHBT0055").where(req.query.SELECT.from.ref[0].where);
        if(oDataResults.length > 0) {
            req.reject({
                code: 403,
                message: 'Select only one line item to split'
            });
        }
        let oData = oDataResults[0];
        if(!oData.ZQTY || oData.ZQTY === 1) {
            req.reject({
                code: 403,
                message: 'Split can be done only when quantity is more than 1'
            });
        }
        while (oData.ZQTY > 1) {
            let newRow = Object.assign({},oData);
            newRow.ZQTY = 1;
            oData.ZQTY = oData.ZQTY - 1;
            oDataResults.push(newRow);
        }
        await UPSERT.into('ZHS402.ZTHBT0027').entries(oData); 
        req.info({
            code: 200,
            message: 'Split is successfully completed'
        });

        return oDataResults;
    })
}

const PrepareResultObject = async (arrayInput, objectCustomer) => {
    const bupa = await cds.connect.to('BusinessPartner');
    const customers = await bupa.get('ZAPIBPS0004.Customer').where({ Customer: { in: arrayInput} });
    /*Prepare the Result in Object Format so that processing is quick */
    if (objectCustomer) {
        objectCustomer = {};
    }
    if (customers.length > 0) {
        for (let customer of customers) {
            objectCustomer[customer.Customer] = customer;
        }
    }
}

module.exports = registerZAPIBPS0004Handler;