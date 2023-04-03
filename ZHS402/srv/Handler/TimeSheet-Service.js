var registerTimeSheetHandler = function (that, cds) {
    that.on('READ', 'AccountingIndicator', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    that.on('READ', 'I_StatisticalKeyFigureText', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    that.on('READ', 'ServiceOrderItem', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    that.on('READ', 'ServiceOrder', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    that.on('READ', 'InternalOrder', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    that.on('READ', 'ReceiverWBSExt', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    that.on('READ', 'ZTHBT0019', async req => {
        const db = await cds.connect.to('db');
        var oData = await db.run(req.query);
        return oData;
    });
    that.before('CREATE', 'ZTHBT0019', async (req) => {
        await ValidateAssignment(req);

    });
    that.before('UPDATE', 'ZTHBT0019', async (req) => {
        await ValidateAssignment(req);

    });
    that.on('READ', 'ParentWBSExt', async req => {

        const db = await cds.connect.to('TimeSheetEntry');
        var oData = await db.run(req.query);
        return oData;
    });


    that.on('READ', 'ParentWBS', async req => {

        const bupa = await cds.connect.to('TimeSheetEntry');
        const LoggUser = await bupa.get('ZCDSEHBTC0003.LoggedInUser');
        var oData = [];
        if (LoggUser.length > 0) {
            const AssignmentByPassData = await SELECT.from('ZHS402.ZTHBT0052').where({ BUKRS: LoggUser[0].CompanyCode });
            if (AssignmentByPassData && AssignmentByPassData.length > 0) {
                switch (AssignmentByPassData[0].CATEGORY) {
                    case 'PJT':
                        oData = await bupa.get('ZCDSEHBTC0003.ParentWBSExt').where({ projectType: 'E1', and: { LevelInHierarchy: { '>=': 006 } } });
                        break;
                    case 'OPP':
                        oData = await bupa.get('ZCDSEHBTC0003.ParentWBSExt').where({ projectType: 'D1', and: { LevelInHierarchy: { '>=': 002 } } });
                    default:
                        oData = await bupa.get('ZCDSEHBTC0003.ParentWBSExt').where({ projectType: 'E1', and: { LevelInHierarchy: { '>=': 006 } , and: { IhpaObjFound: 'X' } }});
                        break;
                }

            }
        }
        return oData;
    });
    that.on('READ', 'LoggedInUser', async req => {

        const db = await cds.connect.to('TimeSheetEntry');
        var oData = await db.run(req.query);
        return oData;
    });
    that.on('READ', 'ReceiverWBS', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        const LoggUser = await bupa.get('ZCDSEHBTC0003.LoggedInUser');
        var oData = [];
        var level = 006;
        if (LoggUser.length > 0) {
            const AssignmentByPassData = await SELECT.from('ZHS402.ZTHBT0052').where({ BUKRS: LoggUser[0].CompanyCode });
            if (AssignmentByPassData && AssignmentByPassData.length > 0) {
                switch (AssignmentByPassData[0].CATEGORY) {
                    case 'PJT':
                        //oData = await bupa.get('ZCDSEHBTC0003.ReceiverWBSExt').where({ Profile: 'YE00001', and: { LevelInHierarchy: level}, and: { ProjectType: 'E1' } });
                        oData = await bupa.get('ZCDSEHBTC0003.ReceiverWBSExt').where({ Profile: 'YE00001',and: { LevelInHierarchy: { '>=': 006 }, and:{ProjectType: 'E1'} } });
                        break;
                    case 'OPP':
                        oData = await bupa.get('ZCDSEHBTC0003.ReceiverWBSExt').where({ Profile: 'YD00001', and: { LevelInHierarchy: { '>=': 002 } , and: { ProjectType: 'D1' } } });
                    default:
                        oData = await bupa.get('ZCDSEHBTC0003.ReceiverWBSExt').where({ UserStatus: 'CCTW', and: { LevelInHierarchy: { '>=': 006 } } });
                        break;
                }

            }
        }
        return oData;
    });
    that.on('READ', 'ReceiverCostCenter', async req => {
        const db = await cds.connect.to('TimeSheetEntry');
        var oData = await db.run(req.query);
        return oData;
    });
    that.on('SubmitTimeSheet', async (req) => {
        

    });

}

const ValidateAssignment = async (req) => {
    const bupa = await cds.connect.to('TimeSheetEntry');
    if (req.data.ZPFDT > req.data.ZPTDT) {
        req.reject({
            code: 403,
            message: 'Valid from Date cant be greater than Valid To Date'
        })
    }
    if (req.data.ZPS_IDENTIFIER === 'P') {
        await validateAssignmentProject(req, bupa);
    }
}
const validateAssignmentProject = async (req, bupa) => {
    // Validate Receiver WBS
    if (!req.data.RWBS && !req.data.EKOSTL) {
        req.reject({
            code: 403,
            message: 'Receiver WBS / Receiver Cost Center is Manadatory'
        })
    }
    else {
        // Validate existance of Receiver WBS Provided
        const data = await bupa.get('ZCDSEHBTC0003.ReceiverWBS').where({ WBSId: req.data.RWBS });
        if (data.length === 0) {
            req.reject({
                code: 403,
                message: 'Invalid Receiver WBS. Kindly choose a valid one'
            });
        }
        else {
            // Check the need for Parent WBS
            if (data[0].UserStatus = 'CCTW' && !req.data.PWBS) {
                req.reject({
                    code: 403,
                    message: 'Kindly provide a valid Parent WBS'
                });
            }
        }
    };
    //Validate Task CCode
    if (!req.data.ZTCODE_ZTCODE) {
        req.reject({
            code: 403,
            message: 'Kindly provide a valid Task Code'
        });
    }
    else {
        const Taskdata = await SELECT.from('ZCDSEHBTC0003.ZTHBT0020').where({ ZTCODE: req.data.ZTCODE_ZTCODE });
        if (Taskdata.length === 0) {
            req.reject({
                code: 403,
                message: 'Provided Task code does not exists'
            });
        }

    }
    //Validate Accounting Indicator
    if (!req.data.BEMOT) {
        req.reject({
            code: 403,
            message: 'Kindly provide valid Accounting Indicator'
        });
    }
    else {
        const Taskdata = await bupa.get('ZCDSEHBTC0003.AccountingIndicator').where({ AccountingIndicator: req.data.BEMOT });
        if (Taskdata.length === 0) {
            req.reject({
                code: 403,
                message: 'Provided Accounting indicator does not exists'
            });
        }

    }
    // Validate Receiver Cost Center
    const LoggUser = await bupa.get('ZCDSEHBTC0003.LoggedInUser');
    if (LoggUser.length > 0) {
        if ((!LoggUser[0].ActivityType && !LoggUser[0].CostCenter) || LoggUser[0].CostCenter === req.data.EKOSTL) {
            req.reject({
                code: 403,
                message: 'Kindly Provide a valid Receiver Cost Center'
            });
        }
    }
    if (req.data.EKOSTL) {
        const costCenterdata = await bupa.get('ZCDSEHBTC0003.ReceiverCostCenter').where({ CostCenter: req.data.EKOSTL });
        if (costCenterdata.length == 0) {
            req.reject({
                code: 403,
                message: 'Provided Cost Center does not exists'
            });
        }
    }
    //Validate Existance of Parent WBS
    if (req.data.PWBS) {
        const parentWBSdata = await bupa.get('ZCDSEHBTC0003.ParentWBS').where({ ParentWBS: req.data.PWBS });
        if (parentWBSdata.length == 0) {
            req.reject({
                code: 403,
                message: 'Provided Parent WBS does not exists'
            });
        }
    }
}
const SubmitTimeSheet = async(req,bupa) => {
    await UPSERT.into('ZHS402.ZTHBT0051').entries(req.data);
    arrayPernr = [];
    arrayWeekNumber = [];
    arrarAssignment = [];
    if(req.data instanceof Array) 
        {
            for( let reqData of req.data) {
                arrayPernr.push(reqData.PERNR);
                arrayWeekNumber.push(reqData.WEEK_NUMBER);
                arrarAssignment.push(reqData.ZPNAME);

            }
        }
    
    else {
        arrayPernr.push(req.data.PERNR);
        arrayWeekNumber.push(req.data.WEEK_NUMBER);
        arrarAssignment.push(req.data.ZPNAME);
    }
    const capTimeSheet = await SELECT.from('ZHS402.ZTHBT0028').where({ PERNR: { in: arrayPernr },
                                                                       and:{WEEK_NUMBER: { in: arrayWeekNumber}},
                                                                       and:{ZPNAME:{in: arrarAssignment}}
                                                                     });
    const db = await cds.connect.to('TimeSheetEntry');
    if(req.data instanceof Array) {
        for(let reqData of req.data) {
            const dataFound = capTimeSheet.find(PERNR === reqData.PERNR && WEEK_NUMBER === reqData.WEEK_NUMBER && ZPNAME === reqData.ZPNAME) ;
            if(dataFound) {
                try {
                    db.send({
                        method: 'POST',
                        path: 'ZCDSEHPSC0011',
                        data: t
                    })
                } catch (error) {
                    
                }
                
            }
            else {

            }
        }
    }
    


}
module.exports = registerTimeSheetHandler;