var registerZAPIBPS0004Handler = function (that, cds, Readable, PassThrough, XLSX,SequenceHelper) {

    that.on('READ', 'Customer', async req => {
        const bupa = await cds.connect.to('BusinessPartner');
        return bupa.run(req.query);
    });
    that.on('READ', 'Project', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    that.on('READ', 'ZCDSEBPS0015', async req => {
        const bupa = await cds.connect.to('ProjectDetails');
        return bupa.run(req.query);
    });
    that.after('READ', 'ZCDSEBPS0012', async req => {
        // const bupa = await cds.connect.to('db');
        // // req.query.SELECT.columns.splice(5,1);
        // // req.query.SELECT.columns.splice(6,1);
        // // if(req.query.SELECT.where[0].hasOwnProperty('xpr') ){
        // //     req.query.SELECT.where.splice(0,1);
        // //     if(req.query.SELECT.where[0] === 'and') {
        // //         req.query.SELECT.where.splice(0,1);
        // //     }
        // // }
         let results = req;
        //  await bupa.run(req.query);
        
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
        let srv = await cds.connect.to('ZAPIBPS0004');
        let oDataResults =  await srv.get('ZAPIBPS0004.ZCDSEBPS0012').where(req.query.SELECT.from.ref[0].where);
        let dataForUpsert = [];
        for (oData of oDataResults) {
            dataForUpsert.push({
                ID:oData.ID,
                ZCABNUM: oData.ZCABNUM,
                PBUKR: oData.PBUKR,
                PS_PSPNR: oData.PS_PSPNR,
                ZMSCODE: oData.ZMSCODE,
                PS_POSNR: oData.PS_POSNR,	
                MATNR: oData.MATNR,
                ZZ1_MSCODE: oData.ZZ1_MSCODE,
                ZIDEX: oData.ZIDEX,
                ZVMCODE: oData.ZVMCODE,
                ZQTY: oData.ZQTY,
                ZUT: oData.ZUT,
                ZDESCRIP: oData.ZDESCRIP,				
                ZSER: oData.ZSER,	
                ZSHTP: oData.ZSHTP,	
                ZSHPNAME1: oData.ZSHPNAME1,
                ZSHPNAME2: oData.ZSHPNAME2,	
                ZSHPNAME3: oData.ZSHPNAME3,
                ZSHPNAME4: oData.ZSHPNAME4,
                ZCONTACTTEL: oData.ZCONTACTTEL,	
                ZDELNOTE1: oData.ZDELNOTE1,
                ZDELNOTE2: oData.ZDELNOTE2,
                ZDONUM: oData.ZDONUM,
                ZDOITEM: oData.ZDOITEM,
                ZDOPDATE: oData.ZDOPDATE,	
                ZDOADATE: oData.ZDOADATE,	
                ZDELFLAG: 'X',
                ZSHPSTAT: oData.ZSHPSTAT,
                CRITICALITY: oData.CRITICALITY,
                REMARKS: oData.REMARKS
            })
        }
        await UPSERT.into('ZHS402.ZTHBT0055').entries(dataForUpsert);
        req.info({
            code: 200,
            message: 'Deletion flag is set successfully'
        });
        return await srv.get('ZAPIBPS0004.ZCDSEBPS0012').where(req.query.SELECT.from.ref[0].where);

    });
    that.on('split', async (req) => {
        let srv = await cds.connect.to('ZAPIBPS0004');
        let oDataResults =  await srv.get('ZAPIBPS0004.ZCDSEBPS0012').where(req.query.SELECT.from.ref[0].where);
        if (oDataResults.length > 1) {
            req.reject({
                code: 403,
                message: 'Select only one line item to split'
            });
        }
        let oData = oDataResults[0];
        if ((!oData.ZQTY || oData.ZQTY === 1 || oData.ZQTY === '1' || oData.ZQTY === '1.00') && oData.ZZ1_MSCODE === '020') {
            req.reject({
                code: 403,
                message: 'Split can be done only when quantity is more than 1 and Material Type is Built-in Cabinet'
            });
        }
        let dataForInsert = [];
        while (oData.ZQTY > 1) {
            let newRow = Object.assign({}, oData);
            newRow.ZQTY = 1;
            delete newRow.ID;
            delete newRow.IsActiveEntity;     
            delete newRow.HasActiveEntity;
            delete newRow.HasDraftEntity;
            delete newRow.createdAt;
            delete newRow.createdBy;
            delete newRow.modifiedAt;
            delete newRow.modifiedBy;
            oData.ZQTY = oData.ZQTY - 1;
            dataForInsert.push(newRow);
        }
        await UPSERT.into('ZHS402.ZTHBT0055').entries(dataForInsert);
        await UPSERT.into('ZHS402.ZTHBT0055').entries(oDataResults);
        req.info({
            code: 200,
            message: 'Split is successfully completed. Refresh / click on GO button to fetch the new data.'
        });

        return oDataResults;
    });
    that.on('copy', async (req) => {

        let oDataResults = await SELECT.from("ZHS402.ZTHBT0055").where(req.query.SELECT.from.ref[0].where);
        if (oDataResults) {
            let copiedData = {
                ZSHTP: oDataResults[0].ZSHTP,
                ZSHPNAME1: oDataResults[0].SHPNAME1,
                ZSHPNAME2: oDataResults[0].ZSHPNAME2,
                ZSHPNAME3: oDataResults[0].ZSHPNAME3,
                ZSHPNAME4: oDataResults[0].ZSHPNAME4,
                ZCONTACTTEL: oDataResults[0].ZCONTACTTEL,
                ZDELNOTE1: oDataResults[0].ZDELNOTE1,
                ZDELNOTE2: oDataResults[0].ZDELNOTE2,
                ZDOPDATE: oDataResults[0].ZDOPDATE
            }
            let data = { USERID: req.user.id, COPIEDDATA: JSON.stringify(copiedData) };
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
            var entity = req.headers.slug ? req.headers.slog : 'ZCDSEBPS0012';
            var whollyupload = req.headers.WhollyUplaod !== null ? req.headers.WhollyUplaod : false;
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
                    let data = [];
                    let companyCodes = [];
                    let projectDefinitions = [];
                    const sheets = workbook.SheetNames
                    for (let i = 0; i < sheets.length; i++) {
                        const temp = XLSX.utils.sheet_to_json(
                            workbook.Sheets[workbook.SheetNames[i]], { cellText: true, cellDates: true, dateNF: 'dd"."mm"."yyyy', rawNumbers: false })
                        temp.forEach((res, index) => {
                            if (index === 0 || index === 1 || index === 2) return;
                            data.push(JSON.parse(JSON.stringify(res)));
                            let projectAdded = projectDefinitions.includes(res['Project Definition']);
                            if (!projectAdded) {
                                projectDefinitions.push(res['Project Definition']);
                            }
                            let compCodeAdded = companyCodes.includes(res['Company code']);
                            if (!compCodeAdded) {
                                companyCodes.push(res['Company code']);
                            }

                        })
                    }
                    if (data) {
                        return await CallEntity(entity, data, req, projectDefinitions, companyCodes, whollyupload);
                    }
                });
            });
        }
        //  else {
        //     return next();
        // }
    });
    that.on('paste', async (req) => {

        let oDataCopy = await SELECT.from("ZHS402.ZTHBT0072").where({ USERID: req.user.id });
        if (!oDataCopy) {
            req.reject({
                code: 403,
                message: 'No Data is availble in clipboard for paste. Kindly Copy before Paste'
            });
        }
        let oDataSelectedData = await SELECT.from("ZHS402.ZTHBT0055").where(req.query.SELECT.from.ref[0].where);
        if (oDataSelectedData) {
            let copiedData = JSON.parse(oDataCopy[0].COPIEDDATA);
            for (let selectedData of oDataSelectedData) {
                selectedData.ZSHTP = copiedData.ZSHTP,
                    selectedData.ZSHPNAME1 = copiedData.ZSHPNAME1,
                    selectedData.ZSHPNAME2 = copiedData.ZSHPNAME2,
                    selectedData.ZSHPNAME3 = copiedData.ZSHPNAME3,
                    selectedData.ZSHPNAME4 = copiedData.ZSHPNAME4,
                    selectedData.ZCONTACTTEL = copiedData.ZCONTACTTEL,
                    selectedData.ZDELNOTE1 = copiedData.ZDELNOTE1,
                    selectedData.ZDELNOTE2 = copiedData.ZDELNOTE2,
                    selectedData.ZDOPDATE = copiedData.ZDOPDATE
            }
        }
        await UPSERT.into('ZHS402.ZTHBT0055').entries(oDataSelectedData);
        req.info({
            code: 200,
            message: 'Data is been pasted successfully from clipboard'
        });
        let srv = await cds.connect.to('ZAPIBPS0004');
        return await srv.get('ZAPIBPS0004.ZCDSEBPS0012').where(req.query.SELECT.from.ref[0].where);
    });
    that.on('DOCreate', async (req) => {
        const db = await cds.connect.to("db");
        let DONumber;
        let SavedNumber = await SELECT.from("ZHS402.ZTHBT0073").where({CHANGESETID: req.id});
        if(!SavedNumber.length) {
            const DOGenerator = new SequenceHelper({
                db: db,
                sequence: "INVOICE_ID",
                table: "ZTHBT0022",
                field: "ID"
            });
            DONumber =  await DOGenerator.getNextNumber();
        }
        else {
            DONumber = SavedNumber[0].ZDONUM;
        }
        let oDataResults = await SELECT.from("ZHS402.ZTHBT0055").where(req.query.SELECT.from.ref[0].where);
        for (oData of oDataResults) {
            oData.ZDONUM = DONumber; 
        }
        await UPSERT.into('ZHS402.ZTHBT0055').entries(oDataResults);
        req.info({
            code: 200,
            message: 'DO number is generated and updated successfully'
        });
        let srv = await cds.connect.to('ZAPIBPS0004');
        return await srv.get('ZAPIBPS0004.ZCDSEBPS0012').where(req.query.SELECT.from.ref[0].where);
        
        
        
    });
    that.on('MassEdit', async (req) => {
        let oDataResults = await SELECT.from("ZHS402.ZTHBT0055").where(req.query.SELECT.from.ref[0].where);

        for (oData of oDataResults) {
            if (req.data.ZSHTP) {
                oData.ZSHTP = req.data.ZSHTP;
            }
            if (req.data.ZSHPNAME1) {
                oData.ZSHPNAME1 = req.data.ZSHPNAME1;
            }
            if (req.data.ZSHPNAME2) {
                oData.ZSHPNAME2 = req.data.ZSHPNAME2;
            }
            if (req.data.ZSHPNAME3) {
                oData.ZSHPNAME3 = req.data.ZSHPNAME3;
            }
            if (req.data.ZSHPNAME4) {
                oData.ZSHPNAME4 = req.data.ZSHPNAME4;
            }

        }
        await UPSERT.into('ZHS402.ZTHBT0055').entries(oDataResults);
        req.info({
            code: 200,
            message: 'Successfully updated'
        });
        let srv = await cds.connect.to('ZAPIBPS0004');
        return await srv.get('ZAPIBPS0004.ZCDSEBPS0012').where(req.query.SELECT.from.ref[0].where);
    });
    


}

async function CallEntity(entity, data, req, arrayProjectDefinitions, arrayCompanyCodes, whollyupload) {
    let existingCabs = await getExistingCabinets(arrayProjectDefinitions, arrayCompanyCodes);
    let dataForInsert = [];
    let dataForUpdate = [];
    let criticality = 3;
    for (let dataFromExcel of data) {
        let remark = '';
        let deletionFlag = '';
        let enteredQuantity = dataFromExcel['Quantity'];
        if (!dataFromExcel['Cabinet Number'] ||
            !dataFromExcel['Company code'] ||
            !dataFromExcel['Material type code'] ||
            !dataFromExcel['Material type code  desc'] ||
            !dataFromExcel['Project Definition'] ||
            !dataFromExcel['MS code'] ||
            !dataFromExcel['Vendor material code'] ||
            enteredQuantity === null  ||
            enteredQuantity === undefined ||
            !dataFromExcel['UNIT']) {
            remark = 'Mandatory Parameter is missing.';
            criticality = 1;
        }
        
        let dataFoundInDB = existingCabs.find((data) => {
            return data.ZCABNUM === dataFromExcel['Cabinet Number'] &&
            data.PBUKR === dataFromExcel['Company code'] && data.PS_PSPNR === dataFromExcel['Project Definition']});
        if(enteredQuantity === 0){
            criticality = 1;
        }   
        if(dataFoundInDB){
            if(enteredQuantity < dataFoundInDB.ZQTY) {
                deletionFlag = 'X';
                remark += 'System will delete this line, please check';
            }
            if ( enteredQuantity === 0 && dataFoundInDB.ZQTY ){
                deletionFlag = 'X';
                remark += 'System will delete this line, please check';
            }
        }
        
        if(dataFoundInDB){
            dataForUpdate.push({
                ID:dataFoundInDB.ID,
                ZCABNUM: dataFromExcel['Cabinet Number'],
                PBUKR: dataFromExcel['Company code'],
                PS_PSPNR: dataFromExcel['Project Definition'],
                ZMSCODE: dataFromExcel['MS code'],
                PS_POSNR: dataFromExcel['WBS element'],
                MATNR: dataFromExcel['SAP Material'],
                ZZ1_MSCODE: dataFromExcel['Material type code'],
                ZIDEX: dataFromExcel['Material type code  desc'],
                ZVMCODE: dataFromExcel['Vendor material code'],
                ZQTY: dataFoundInDB.ZQTY,
                ZUT: enteredQuantity,
                ZDESCRIP: dataFromExcel['Material Description'],
                ZSER: dataFromExcel['Serial number'],
                ZSHTP: dataFromExcel['Ship-to party'],
                ZSHPNAME1: dataFromExcel['Contact ship Name 1'],
                ZSHPNAME2: dataFromExcel['Contact ship Name 2'],
                ZSHPNAME3: dataFromExcel['Contact ship Name 3'],
                ZSHPNAME4: dataFromExcel['Contact ship Name 4'],
                ZCONTACTTEL: dataFromExcel['Contact ship telephone'],
                ZDELNOTE1: dataFromExcel['Delivery note1'],
                ZDELNOTE2: dataFromExcel['Delivery note2'],
                ZDONUM: dataFromExcel['Do Number Title'],
                ZDOITEM: dataFromExcel['Do Number Item'],
                ZDOPDATE: dataFromExcel['Do Plan Date'],
                ZDELFLAG : deletionFlag ? 'X':dataFoundInDB.ZDELFLAG,
                ZSHPSTAT: dataFoundInDB.ZSHPSTAT,
                ZDOADATE: dataFoundInDB.ZDOADATE,
                REMARKS: remark,
                CRITICALITY:criticality
            });
            if(enteredQuantity > dataFoundInDB.ZQTY && !remark && !deletionFlag) {
                dataForInsert.push({
                    ZCABNUM: dataFromExcel['Cabinet Number'],
                    PBUKR: dataFromExcel['Company code'],
                    PS_PSPNR: dataFromExcel['Project Definition'],
                    ZMSCODE: dataFromExcel['MS code'],
                    PS_POSNR: dataFromExcel['WBS element'],
                    MATNR: dataFromExcel['SAP Material'],
                    ZZ1_MSCODE: dataFromExcel['Material type code'],
                    ZIDEX: dataFromExcel['Material type code  desc'],
                    ZVMCODE: dataFromExcel['Vendor material code'],
                    ZQTY: enteredQuantity - dataFoundInDB.ZQTY,
                    ZUT: dataFromExcel['UNIT'],
                    ZDESCRIP: dataFromExcel['Material Description'],
                    ZSER: dataFromExcel['Serial number'],
                    ZSHTP: dataFromExcel['Ship-to party'],
                    ZSHPNAME1: dataFromExcel['Contact ship Name 1'],
                    ZSHPNAME2: dataFromExcel['Contact ship Name 2'],
                    ZSHPNAME3: dataFromExcel['Contact ship Name 3'],
                    ZSHPNAME4: dataFromExcel['Contact ship Name 4'],
                    ZCONTACTTEL: dataFromExcel['Contact ship telephone'],
                    ZDELNOTE1: dataFromExcel['Delivery note1'],
                    ZDELNOTE2: dataFromExcel['Delivery note2'],
                    ZDONUM: dataFromExcel['Do Number Title'],
                    ZDOITEM: dataFromExcel['Do Number Item'],
                    ZDOPDATE: dataFromExcel['Do Plan Date']
                });
            }
        }
        else {
            dataForInsert.push({
                ZCABNUM: dataFromExcel['Cabinet Number'],
                PBUKR: dataFromExcel['Company code'],
                PS_PSPNR: dataFromExcel['Project Definition'],
                ZMSCODE: dataFromExcel['MS code'],
                PS_POSNR: dataFromExcel['WBS element'],
                MATNR: dataFromExcel['SAP Material'],
                ZZ1_MSCODE: dataFromExcel['Material type code'],
                ZIDEX: dataFromExcel['Material type code  desc'],
                ZVMCODE: dataFromExcel['Vendor material code'],
                ZQTY: dataFromExcel['Quantity'],
                ZUT: dataFromExcel['UNIT'],
                ZDESCRIP: dataFromExcel['Material Description'],
                ZSER: dataFromExcel['Serial number'],
                ZSHTP: dataFromExcel['Ship-to party'],
                ZSHPNAME1: dataFromExcel['Contact ship Name 1'],
                ZSHPNAME2: dataFromExcel['Contact ship Name 2'],
                ZSHPNAME3: dataFromExcel['Contact ship Name 3'],
                ZSHPNAME4: dataFromExcel['Contact ship Name 4'],
                ZCONTACTTEL: dataFromExcel['Contact ship telephone'],
                ZDELNOTE1: dataFromExcel['Delivery note1'],
                ZDELNOTE2: dataFromExcel['Delivery note2'],
                ZDONUM: dataFromExcel['Do Number Title'],
                ZDOITEM: dataFromExcel['Do Number Item'],
                ZDOPDATE: dataFromExcel['Do Plan Date'],
                REMARKS: remark,
                CRITICALITY:criticality,
                ZDELFLAG: deletionFlag
            })
        }   
    }

    if (whollyupload) {
        for (let existingCab of existingCabs) {
            let dataFoundInExcel = dataForInsert.find((dataDb) => {
                return dataDb.ZCABNUM === existingCab.ZCABNUM &&
                dataDb.PBUKR === existingCab.PBUKR && dataDb.PS_PSPNR === existingCab.PS_PSPNR });
            if (!dataFoundInExcel) {
                existingCab.ZDELFLAG = 'X';
                dataForUpdate.push(existingCab);
            }
        }
    }
    if(dataForInsert){
        await UPSERT.into('ZHS402.ZTHBT0055').entries(dataForInsert);
    }
    
    if(dataForUpdate.length){
        await UPSERT.into('ZHS402.ZTHBT0055').entries(dataForUpdate);
    }
   
    let srv = await cds.connect.to('ZAPIBPS0004');
    req.info({
        code: 200,
        message: 'Data is been uploaded successfull'
    });
    return await srv.get('ZAPIBPS0004.ZCDSEBPS0012');

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

const getExistingCabinets = async (arrayProjectDefinitions, arrayCompanyCodes) => {
    return await SELECT.from("ZHS402.ZTHBT0055").where({ PBUKR: { in: arrayCompanyCodes }, and: { PS_PSPNR: { in: arrayProjectDefinitions } } });
}

module.exports = registerZAPIBPS0004Handler;