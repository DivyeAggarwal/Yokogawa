var registerZAPIBPS0004Handler = function (that, cds) {

    that.on('READ', 'Customer', async req => {
        const bupa = await cds.connect.to('BusinessPartner');
        return bupa.run(req.query);
    });
    that.on('READ', 'Project', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    that.on('READ', 'ZCDSEBPS0012', async req => {
        const bupa = await cds.connect.to('db');
        let results = await bupa.run(req.query);
        let arrayInput = [];
        if (Array.isArray(results)) {
            for (let result of results) {
                if (result.ZSHTP) {
                    arrayInput.push(result.ZSHTP);
                }
            }
        }
        else {
            if (results.ZSHTP) {
                arrayInput.push(results.ZSHTP);
            }
        }
        let objectCustomer = {};
        await PrepareResultObject(arrayInput, objectCustomer);

        /*Manipulate the result from cloud and On Premise */
        if (Array.isArray(results)) {
            for (let result of results) {
                if (result.ZSHTP) {
                    let dataFromObject = objectCustomer[result.ZSHTP];
                    if (dataFromObject) {
                        delete dataFromObject.Customer;
                        delete dataFromObject.name1;
                        delete dataFromObject.name2;
                        Object.assign(result, dataFromObject);

                    }
                }

            }
        }
        else {
            if (results.ZSHTP) {
                let dataFromObject = objectCustomer[results.ZSHTP];
                if (dataFromObject) {
                    delete dataFromObject.Customer;
                    delete dataFromObject.name1;
                    delete dataFromObject.name2;
                    Object.assign(results, dataFromObject);
                }
            }

        }

        return results;
    })
    that.on('DeleteSet', async (req) => {
        let oDataResults = await SELECT.from("ZHS402.ZTHBT0055").where(req.query.SELECT.from.ref[0].where);
        for (oData of oDataResults) {

            oData.ZDELFLAG = 'X';
        }
        await UPSERT.into('ZHS402.ZTHBT0055').entries(oData);
        req.info({
            code: 200,
            message: 'Deletion flag is set successfully'
        });
        return oData;

    });
    that.on('split', async (req) => {
        let oDataResults = await SELECT.from("ZHS402.ZTHBT0055").where(req.query.SELECT.from.ref[0].where);
        if (oDataResults.length > 1) {
            req.reject({
                code: 403,
                message: 'Select only one line item to split'
            });
        }
        let oData = oDataResults[0];
        if (!oData.ZQTY || oData.ZQTY === 1) {
            req.reject({
                code: 403,
                message: 'Split can be done only when quantity is more than 1'
            });
        }
        while (oData.ZQTY > 1) {
            let newRow = Object.assign({}, oData);
            newRow.ZQTY = 1;
            oData.ZQTY = oData.ZQTY - 1;
            oDataResults.push(newRow);
        }
        await UPSERT.into('ZHS402.ZTHBT0055').entries(oData);
        req.info({
            code: 200,
            message: 'Split is successfully completed'
        });

        return oDataResults;
    });
    that.on('copy', async (req) => {

        let oDataResults = await SELECT.from("ZHS402.ZTHBT0055").where(req.query.SELECT.from.ref[0].where);
        if (oDataResults) {

            let data = { USERID: req.user.id, COPIEDGUID: oDataResults[0].UUID };
            await UPSERT.into('ZHS402.ZTHBT0072').entries(data);
            req.info({
                code: 200,
                message: 'Data has been copied successfully. Kindly Click on Paste to apply the data'
            });
        }

        return req.data;

    });
    that.on('PUT', 'ExcelUpload', async (req, next) => {
        if (req.data.excel) {
            var entity = req.headers.slug;
            const stream = new PassThrough();
            var buffers = [];
            req.data.excel.pipe(stream);
            await new Promise((resolve, reject) => {
                stream.on('data', dataChunk => {
                    buffers.push(dataChunk);
                });
                stream.on('end', async () => {
                    var buffer = Buffer.concat(buffers);
                    var workbook = XLSX.read(buffer, { type: "buffer", cellText: true, cellDates: true, dateNF: 'dd"."mm"."yyyy', cellNF: true, rawNumbers: false });
                    let data = []
                    const sheets = workbook.SheetNames
                    for (let i = 0; i < sheets.length; i++) {
                        const temp = XLSX.utils.sheet_to_json(
                            workbook.Sheets[workbook.SheetNames[i]], { cellText: true, cellDates: true, dateNF: 'dd"."mm"."yyyy', rawNumbers: false })
                        temp.forEach((res, index) => {
                            if (index === 0 || index === 1 || index === 2) return;
                            data.push(JSON.parse(JSON.stringify(res)))
                        })
                    }
                    if (data) {
                            const responseCall = await CallEntity(entity, data);
                            if (responseCall == -1)
                                reject(req.error(400, JSON.stringify(data)));
                            else {
                                resolve(req.notify({
                                    message: 'Upload Successful',
                                    status: 200
                                }));   
                        }
                    }
                });
            });
        } else {
            return next();
        }
    });
}

 async function CallEntity(entity, data) {
    const insertQuery = INSERT.into(entity).entries(data);  
    let srv = await cds.connect.to('ZAPIBPS0004');
    const insertResult = await srv.run(insertQuery);
    let query = SELECT.from(entity);
    await srv.run(query);
    return insertResult; //returns response to excel upload entity
   
};

const PrepareResultObject = async (arrayInput, objectCustomer) => {
    const bupa = await cds.connect.to('BusinessPartner');
    const customers = await bupa.get('ZAPIBPS0004.Customer').where({ Customer: { in: arrayInput } });
    /*Prepare the Result in Object Format so that processing is quick */
    if (!objectCustomer) {
        objectCustomer = {};
    }
    if (customers.length > 0) {
        for (let customer of customers) {
            objectCustomer[customer.Customer] = customer;
        }
    }
}

module.exports = registerZAPIBPS0004Handler;