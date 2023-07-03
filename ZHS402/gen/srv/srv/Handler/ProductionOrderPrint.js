var registerProductionOrderPrint = function (that, cds) {
    that.on('READ', 'ProcessRecordSheetCombined', async req => {
        /* Read Data from the External API for Process Record Sheet */
        const bupa = await cds.connect.to('ProductionOrder');
        const results = await bupa.run(req.query);
        /* Prepare array of Production Order by which Addiional status is going to be 
        Read from the Cloud Table */
        let arrayInput = [];
        if (Array.isArray(results)) {
            for (let result of results) {
                arrayInput.push(result.OrderNumber);
            }
        }
        else {
            arrayInput.push(results.OrderNumber);
        }

        let objectAddStatus = {};
        await PrepareResultObject(arrayInput, objectAddStatus);
        /*Manipulate the result from cloud and On Premise */
        if (Array.isArray(results)) {
            for (let result of results) {
                let DataFromObject = objectAddStatus[result.OrderNumber];
                if (DataFromObject) {
                    result.RePrint = DataFromObject;
                }

            }
        }
        else {
            let DataFromObject = objectAddStatus[results.OrderNumber];
            if (DataFromObject) {
                results.RePrint = DataFromObject;
            }
        }

        return results;
    });
    that.on('READ', 'OperationList', async req => {
        const bupa = await cds.connect.to('ProductionOrder');
        return bupa.run(req.query);
    });
    that.on('READ', 'Components', async req => {
        const bupa = await cds.connect.to('ProductionOrder');
        return bupa.run(req.query);
    });
    that.on('READ', 'ProductionOrderSheetCombined', async req => {
        const bupa = await cds.connect.to('ProductionOrder');
        const results = await bupa.run(req.query);
        /* Prepare array of Production Order by which Addiional status is going to be 
        Read from the Cloud Table */
        let arrayInput = [];
        if (Array.isArray(results)) {
            for (let result of results) {
                arrayInput.push(result.OrderNumber);
            }
        }
        else {
            arrayInput.push(results.OrderNumber);
        }
        let objectAddStatus = {};
        await PrepareResultObject(arrayInput, objectAddStatus);

        /*Manipulate the result from cloud and On Premise */
        if (Array.isArray(results)) {
            for (let result of results) {
                let DataFromObject = objectAddStatus[result.OrderNumber];
                if (DataFromObject) {
                    result.RePrint = DataFromObject;
                }

            }
        }
        else {
            let DataFromObject = objectAddStatus[results.OrderNumber];
            if (DataFromObject) {
                results.RePrint = DataFromObject;
            }
        }

        return results;
    });
    that.on('READ', 'ChildPartListCombined', async req => {
        const bupa = await cds.connect.to('ProductionOrder');
        const results = await bupa.run(req.query);
        /* Prepare array of Production Order by which Addiional status is going to be 
        Read from the Cloud Table */
        let arrayInput = [];
        if (Array.isArray(results)) {
            for (let result of results) {
                arrayInput.push(result.ProductionOrderNo);
            }
        }
        else {
            arrayInput.push(results.ProductionOrderNo);
        }
        let objectAddStatus = {};
        await PrepareResultObject(arrayInput, objectAddStatus);
        /*Manipulate the result from cloud and On Premise */
        if (Array.isArray(results)) {
            for (let result of results) {
                let DataFromObject = objectAddStatus[result.ProductionOrderNo];
                if (DataFromObject) {
                    result.RePrint = DataFromObject;
                }
            }
        }
        else {
            let DataFromObject = objectAddStatus[results.ProductionOrderNo];
            if (DataFromObject) {
                results.RePrint = DataFromObject;
            }
        }

        return results;
    });
}

const PrepareResultObject = async (arrayInput, objectAddStatus) => {
    /*Fire the Query to the Cloiud table */
    const addStatusDataArray = await SELECT.from('ZHS402.ZTHBT0028').where({ PRODUCTIONORDER: { in: arrayInput } });
    /*Prepare the Result in Object Format so that processing is quick */
    if (objectAddStatus) {
        objectAddStatus = {};
    }
    if (addStatusDataArray.length > 0) {
        for (let addStatusData of addStatusDataArray) {
            objectAddStatus[addStatusData.PRODUCTIONORDER] = addStatusData.ZPRINT;
        }
    }
}

module.exports = registerProductionOrderPrint;