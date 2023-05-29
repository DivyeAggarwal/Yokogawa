var registerZAPIBPS0004Handler = function (that, cds, Readable, PassThrough, XLSX, SequenceHelper) {

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
        let results = req;
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
        //await PrepareResultObject(arrayInput, objectCustomer);

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
        let oDataResults = await srv.get('ZAPIBPS0004.ZCDSEBPS0012').where(req.query.SELECT.from.ref[0].where);
        let dataForUpsert = [];
        for (oData of oDataResults) {
            dataForUpsert.push({
                ID: oData.ID,
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
        if (!this.isDeleteMessageRaised) {
            this.isDeleteMessageRaised = true;
            req.info({
                code: 200,
                message: 'Deletion flag is set successfully'
            });
        }

        return await srv.get('ZAPIBPS0004.ZCDSEBPS0012').where(req.query.SELECT.from.ref[0].where);

    });
    that.after('DeleteSet', async (req) => {
        this.isDeleteMessageRaised = false;
    });
    that.on('split', async (req) => {
        let srv = await cds.connect.to('ZAPIBPS0004');
        let oDataResults = await srv.get('ZAPIBPS0004.ZCDSEBPS0012').where(req.query.SELECT.from.ref[0].where);
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
            delete newRow.name1;
            delete newRow.name2;
            delete newRow.PostalCode;
            delete newRow.Region;
            delete newRow.City;
            delete newRow.StreetName;
            delete newRow.TelephoneNumber1;
            delete newRow.BusinessPartnerName3;
            delete newRow.BusinessPartnerName4;
            delete newRow.StreetPrefixName;
            delete newRow.AdditionalStreetPrefixName;
            oData.ZQTY = oData.ZQTY - 1;
            dataForInsert.push(newRow);
        }
        delete oData.name1;
        delete oData.name2;
        delete oData.PostalCode;
        delete oData.Region;
        delete oData.City;
        delete oData.StreetName;
        delete oData.TelephoneNumber1;
        delete oData.BusinessPartnerName3;
        delete oData.BusinessPartnerName4;
        delete oData.StreetPrefixName;
        delete oData.AdditionalStreetPrefixName;
        delete oData.IsActiveEntity;
        delete oData.HasActiveEntity;
        delete oData.HasDraftEntity;
        await UPSERT.into('ZHS402.ZTHBT0055').entries(dataForInsert);
        await UPSERT.into('ZHS402.ZTHBT0055').entries(oDataResults);
        if (!this.isSplitMessageRaised) {
            this.isSplitMessageRaised = true;
            req.info({
                code: 200,
                message: 'Split is successfully completed. Refresh / click on GO button to fetch the new data.'
            });
        }

        return oDataResults;
    });
    that.after('split', async (req) => {
        this.isSplitMessageRaised = false;
    });
    that.on('copy', async (req) => {
        let srv = await cds.connect.to('ZAPIBPS0004');
        let oDataResults = await srv.get('ZAPIBPS0004.ZCDSEBPS0012').where(req.query.SELECT.from.ref[0].where);
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
                        let success;
                        await CallEntity(entity, data, req, projectDefinitions, companyCodes, whollyupload,success);
                        if(success){
                            resolve(req.notify({
                                message: 'Data has been uploaded successfully.',
                                status: 200
                            }));  
                        }
                        else {
                            reject(req.error(400, 'Error while uploading the data. Kindly try again. Kindly notify the admin if the issue persists'));
                        }
                    }
                });
            });
        }
         else {
            return next();
        }
    });
    that.on('paste', async (req) => {

        let oDataCopy = await SELECT.from("ZHS402.ZTHBT0072").where({ USERID: req.user.id });
        if (!oDataCopy) {
            req.reject({
                code: 403,
                message: 'No Data is availble in clipboard for paste. Kindly Copy before Paste'
            });
        }
        let srv = await cds.connect.to('ZAPIBPS0004');
        let oDataSelectedData = await srv.get('ZAPIBPS0004.ZCDSEBPS0012').where(req.query.SELECT.from.ref[0].where);
        let dataForUpsert = [];
        if (oDataSelectedData) {
            let copiedData = JSON.parse(oDataCopy[0].COPIEDDATA);
            for (let oData of oDataSelectedData) {
                dataForUpsert.push({
                    ID: oData.ID,
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
                    ZSHTP: copiedData.ZSHTP,
                    ZSHPNAME1: copiedData.ZSHPNAME1,
                    ZSHPNAME2: copiedData.ZSHPNAME2,
                    ZSHPNAME3: copiedData.ZSHPNAME3,
                    ZSHPNAME4: copiedData.ZSHPNAME4,
                    ZCONTACTTEL: copiedData.ZCONTACTTEL,
                    ZDELNOTE1: copiedData.ZDELNOTE1,
                    ZDELNOTE2: copiedData.ZDELNOTE2,
                    ZDONUM: oData.ZDONUM,
                    ZDOITEM: oData.ZDOITEM,
                    ZDOPDATE: copiedData.ZDOPDATE,
                    ZDOADATE: oData.ZDOADATE,
                    ZDELFLAG: oData.ZDELFLAG,
                    ZSHPSTAT: oData.ZSHPSTAT,
                    CRITICALITY: oData.CRITICALITY,
                    REMARKS: oData.REMARKS
                })
            }
        }
        await UPSERT.into('ZHS402.ZTHBT0055').entries(dataForUpsert);
        if (!this.isPasteMessageRaised) {
            this.isPasteMessageRaised = true;
            req.info({
                code: 200,
                message: 'Data is been pasted successfully from clipboard'
            });
        }
        return await srv.get('ZAPIBPS0004.ZCDSEBPS0012').where(req.query.SELECT.from.ref[0].where);
    });
    that.after('paste', async (req) => {
        this.isPasteMessageRaised = false;
    });
    that.before('DOCreate', async (req) => {
        const db = await cds.connect.to("db");
        let newNumber = await getGenerateNewNumber(that, req, SequenceHelper, db);
    })
    that.after('DOCreate', async (req) => {

        if (that.DONumberMap[req.id]) {
            delete that.DONumberMap[req.id];
        }
        this.isDeleteMessageRaised = false;
    })
    that.on('DOCreate', async (req) => {
        const db = await cds.connect.to("db");
        let DONumberMap = await getGenerateNewNumber(that, req, SequenceHelper, db);
        let srv = await cds.connect.to('ZAPIBPS0004');
        let oDataResults = await srv.get('ZAPIBPS0004.ZCDSEBPS0012').where(req.query.SELECT.from.ref[0].where);
        let dataForUpsert = [];
        for (oData of oDataResults) {
            dataForUpsert.push({
                ID: oData.ID,
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
                ZDONUM: DONumberMap.DONumber,
                ZDOITEM: DONumberMap.numberOfCabinet.toString().padStart(3, '0') + DONumberMap.numberOfComponent.toString().padStart(4, '0'),
                ZDOPDATE: oData.ZDOPDATE,
                ZDOADATE: oData.ZDOADATE,
                ZDELFLAG: oData.ZDELFLAG,
                ZSHPSTAT: oData.ZSHPSTAT,
                CRITICALITY: oData.CRITICALITY,
                REMARKS: oData.REMARKS
            })
            DONumberMap.numberOfComponent = DONumberMap.numberOfComponent + 1;
            that.DONumberMap[req.id].numberOfComponent = DONumberMap.numberOfComponent;
        }

        await UPSERT.into('ZHS402.ZTHBT0055').entries(dataForUpsert);
        if (!this.isDeleteMessageRaised) {
            this.isDeleteMessageRaised = true;
            req.info({
                code: 200,
                message: `DO number is generated and updated successfully against the ID ` + dataForUpsert[0].ID
            });
        }
        return await srv.get('ZAPIBPS0004.ZCDSEBPS0012').where(req.query.SELECT.from.ref[0].where);
    });
    that.on('MassEdit', async (req) => {
        let srv = await cds.connect.to('ZAPIBPS0004');
        let oDataResults = await srv.get('ZAPIBPS0004.ZCDSEBPS0012').where(req.query.SELECT.from.ref[0].where);
        let dataForUpsert = [];
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
            dataForUpsert.push({
                ID: oData.ID,
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
                ZDELFLAG: oData.ZDELFLAG,
                ZSHPSTAT: oData.ZSHPSTAT,
                CRITICALITY: oData.CRITICALITY,
                REMARKS: oData.REMARKS
            })
        }
        await UPSERT.into('ZHS402.ZTHBT0055').entries(dataForUpsert);
        if (!this.isMassEditMessageRaised) {
            this.isMassEditMessageRaised = true;
            req.info({
                code: 200,
                message: 'Successfully updated'
            });
        }
        return await srv.get('ZAPIBPS0004.ZCDSEBPS0012').where(req.query.SELECT.from.ref[0].where);
    });
    that.after('MassEdit', async (req) => {
        this.isMassEditMessageRaised = false;
    });
}

async function CallEntity(entity, data, req, arrayProjectDefinitions, arrayCompanyCodes, whollyupload,success) {
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
            enteredQuantity === null ||
            enteredQuantity === undefined ||
            !dataFromExcel['UNIT']) {
            remark = 'Mandatory Parameter is missing.';
            criticality = 1;
        }

        let dataFoundInDB = existingCabs.find((data) => {
            return data.ZCABNUM === dataFromExcel['Cabinet Number'] &&
                data.PBUKR === dataFromExcel['Company code'] && data.PS_PSPNR === dataFromExcel['Project Definition']
        });
        if (enteredQuantity === 0) {
            criticality = 1;
        }
        if (dataFoundInDB) {
            if (enteredQuantity < dataFoundInDB.ZQTY) {
                deletionFlag = 'X';
                remark += 'System will delete this line, please check';
            }
            if (enteredQuantity === 0 && dataFoundInDB.ZQTY) {
                deletionFlag = 'X';
                remark += 'System will delete this line, please check';
            }
        }

        if (dataFoundInDB) {
            dataForUpdate.push({
                ID: dataFoundInDB.ID,
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
                ZDELFLAG: deletionFlag ? 'X' : dataFoundInDB.ZDELFLAG,
                ZSHPSTAT: dataFoundInDB.ZSHPSTAT,
                ZDOADATE: dataFoundInDB.ZDOADATE,
                REMARKS: remark,
                CRITICALITY: criticality
            });
            if (enteredQuantity > dataFoundInDB.ZQTY && !remark && !deletionFlag) {
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
                CRITICALITY: criticality,
                ZDELFLAG: deletionFlag
            })
        }
    }

    if (whollyupload) {
        for (let existingCab of existingCabs) {
            let dataFoundInExcel = dataForInsert.find((dataDb) => {
                return dataDb.ZCABNUM === existingCab.ZCABNUM &&
                    dataDb.PBUKR === existingCab.PBUKR && dataDb.PS_PSPNR === existingCab.PS_PSPNR
            });
            if (!dataFoundInExcel) {
                existingCab.ZDELFLAG = 'X';
                dataForUpdate.push(existingCab);
            }
        }
    }
    if (dataForInsert) {
        await UPSERT.into('ZHS402.ZTHBT0055').entries(dataForInsert);
    }

    if (dataForUpdate.length) {
        await UPSERT.into('ZHS402.ZTHBT0055').entries(dataForUpdate);
    }
    success = true;

    // let srv = await cds.connect.to('ZAPIBPS0004');
    // req.info({
    //     code: 200,
    //     message: 'Data is been uploaded successfull'
    // });

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
async function getGenerateNewNumber(that, req, SequenceHelper, db) {
    if (!that.DONumberMap) {
        that.DONumberMap = {};
    }
    if (!that.DONumberMap[req.id]) {
        const DOGenerator = await new SequenceHelper({
            db: db,
            sequence: "ZTHBT0055_ZDONUM",
            table: "ZTHBT0073",
            field: "ZDONUM"
        });
        DONumber = await DOGenerator.getNextNumber();
        if (!that.DONumberMap[req.id]) {
            that.DONumberMap[req.id] = { DONumber, numberOfCabinet: 1, numberOfComponent: 1 };
            await UPSERT.into('ZHS402.ZTHBT0073').entries({ CHANGESETID: req.id, ZDONUM: DONumber });
        }
        return DONumber
    }
    else {
        return that.DONumberMap[req.id];
    }
}

module.exports = registerZAPIBPS0004Handler;