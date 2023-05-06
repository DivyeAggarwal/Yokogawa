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


        var where = req.query.SELECT.where;
        if (!where) {
            where = {};
        }
        var limit = req.query.SELECT.limit;
        return await readParentWBSCombined(where, limit, req);
    });
    that.on('READ', 'LoggedInUser', async req => {

        const db = await cds.connect.to('TimeSheetEntry');
        var oData = await db.run(req.query);

        return oData;
    });
    that.on('READ', 'ReceiverWBS', async req => {


        var where = req.query.SELECT.where;
        if (!where) {
            where = {};
        }
        var limit = req.query.SELECT.limit;
        return await readReceiverWBSCombined(where, limit, req);
    });
    that.on('READ', 'ReceiverCostCenter', async req => {
        const db = await cds.connect.to('TimeSheetEntry');
        var oData = await db.run(req.query);
        return oData;
    });
    that.on('SubmitTimeSheet', async (req) => {
        const bupa = await cds.connect.to('db');
        return await submitTimeSheet(req, bupa);

    });
    that.on('READ', 's4TimeSheet', async req => {
        const db = await cds.connect.to('TimeSheetEntry');

        var oData = await db.run(req.query);
        return oData;
    })
    that.on('READ', 'TimeSheetTemplate', async req => {
        const db = await cds.connect.to('db');
        var oData = await db.run(req.query);
        oData = await populateSubmittedFlag(oData);
        return oData;


    });
    that.on('READ', 'ZTHBT0051', async req => {
        const db = await cds.connect.to('db');
        var oData = await db.run(req.query);
        return oData;
    });

}
const populateSubmittedFlag = async (oData) => {
    var arrayPernr = [];
    var arrayWeekNumber = [];
    for (let reqData of oData) {
        if (!arrayPernr.includes(reqData.PERNR)) {
            arrayPernr.push(reqData.PERNR);
        }
        if (!arrayWeekNumber.includes(reqData.WEEK_NUMBER)) {
            arrayWeekNumber.push(reqData.WEEK_NUMBER);
        }
    }
    const db = await cds.connect.to('TimeSheetEntry');
    try {
        const s4TimeSheets = await db.get('ZCDSEHBTC0003.s4TimeSheet').where({ EMPLOYEENUMBER: { in: arrayPernr }, and: { WEEKNUMBER: { in: arrayWeekNumber } } });
        for (let reqData of oData) {
            reqData.SUBMITTED = false;
            reqData.RELEASED = false;
            for (let s4TimeSheet of s4TimeSheets) {
                if(s4TimeSheet.EMPLOYEENUMBER === reqData.PERNR && s4TimeSheet.WEEKNUMBER === reqData.WEEK_NUMBER
                && s4TimeSheet.ZPNAME === reqData.ZPNAME_ZPNAME)
                {
                    if (!reqData.SUBMITTED && s4TimeSheet.Status === '10') {
                        reqData.SUBMITTED = true;
                    }
                    else if (!reqData.RELEASED && s4TimeSheet.Status === '30') {
                        reqData.RELEASED = true;
                    }

                    switch (s4TimeSheet.WORKDATE) {
                        case reqData.DAY1_DATE:
                            reqData.DAY1_COUNTER = s4TimeSheet.COUNTER;
                            break;
                        case reqData.DAY2_DATE:
                            reqData.DAY2_COUNTER = s4TimeSheet.COUNTER;
                            break;
                        case reqData.DAY3_DATE:
                            reqData.DAY3_COUNTER = s4TimeSheet.COUNTER;
                            break;
                        case reqData.DAY4_DATE:
                            reqData.DAY4_COUNTER = s4TimeSheet.COUNTER;
                            break;
                        case reqData.DAY5_DATE:
                            reqData.DAY5_COUNTER = s4TimeSheet.COUNTER;
                            break;
                        case reqData.DAY6_DATE:
                            reqData.DAY6_COUNTER = s4TimeSheet.COUNTER;
                            break;
                        case reqData.DAY7_DATE:
                            reqData.DAY7_COUNTER = s4TimeSheet.COUNTER;
                            break;
                        default:
                            break;
                    }
                }  
            }
        }
        return oData;
    } catch (error) {
        return oData;
    }
}

const ValidateAssignment = async (req) => {
    const bupa = await cds.connect.to('TimeSheetEntry');
    if (req.data.ZPFDT > req.data.ZPTDT) {
        req.reject({
            code: 403,
            message: 'Valid from Date cant be greater than Valid To Date'
        })
    }

    let savedData = await SELECT.from('ZCDSEHBTC0003.ZTHBT0019').where({ ZPNAME: req.data.ZPNAME });
    let savingData = {};
    if (savedData.length > 0) {
        req.data = { ...savedData[0], ...req.data };
    }
    else {
        req.data = req.data;
    }

    if (req.data.ZPS_IDENTIFIER === 'P') {
        await validateAssignmentProject(req, bupa);
    }
}
const validateAssignmentProject = async (req, bupa) => {
    let loggedinId = req.user.id;
    loggedinId = loggedinId.toUpperCase();
    const LoggUser = await bupa.get('ZCDSEHBTC0003.LoggedInUser').where({ email_Address: loggedinId, or: { globalID: loggedinId } });
    if (LoggUser.length > 0) {
        if ((!LoggUser[0].ActivityType && !LoggUser[0].CostCenter) || LoggUser[0].CostCenter === req.data.EKOSTL) {
            req.reject({
                code: 403,
                message: 'Kindly Provide a valid Receiver Cost Center'
            });
        }
    }
    // Validate Receiver WBS
    if (!req.data.RWBS && !req.data.EKOSTL) {
        req.reject({
            code: 403,
            message: 'Receiver WBS / Receiver Cost Center is Mandatory'
        })
    }
    else {
        // Validate existance of Receiver WBS Provided
        if (req.data.RWBS) {
            const whereRWB = [{ ref: ['WBSId'] }, '=', { val: req.data.RWBS }];

            const data = await readReceiverWBSCombined(whereRWB, null, req);
            //const data = await bupa.get('ZCDSEHBTC0003.ReceiverWBS').where({ WBSId: req.data.RWBS });
            if (data.length === 0) {
                req.reject({
                    code: 403,
                    message: 'Invalid Receiver WBS. Kindly choose a valid one'
                });
            }
            else {
                // Check the need for Parent WBS
                if (data[0].UserStatus === 'CCTW' && !req.data.PWBS) {
                    req.reject({
                        code: 403,
                        message: 'Kindly provide a valid Parent WBS'
                    });
                }
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


    //Validate Existance of Parent WBS
    if (req.data.PWBS) {
        const wherePWBS = [{ ref: ['ParentWBS'] }, '=', { val: req.data.PWBS }, 'and', { ref: ['ReceiverWBS'] }, '=', { val: req.data.RWBS }];
        parentWBSdata = await readParentWBSCombined(wherePWBS, null, req);
        //const parentWBSdata = await bupa.get('ZCDSEHBTC0003.ParentWBS').where({ ParentWBS: req.data.PWBS });
        if (parentWBSdata.length == 0) {
            req.reject({
                code: 403,
                message: 'Provided Parent WBS does not exists'
            });
        }
    }
}
const submitTimeSheet = async (req, db) => {
    var response = {};
    // let loggedInUser;
    // const LoggUser = await bupa.get('ZCDSEHBTC0003.LoggedInUser');
    // if (LoggUser.length > 0) {
    //     loggedInUser = LoggUser[0];
    // }

    arrayPernr = [];
    arrayWeekNumber = [];
    arrarAssignment = [];

    arrayPernr.push(req.data.input.PERNR);
    arrayWeekNumber.push(req.data.input.WEEK_NUMBER);
    arrarAssignment.push(req.data.input.ZPNAME_ZPNAME);


    const assignmentsData = await SELECT.from('ZHS402.ZTHBT0019').where({
        ZPNAME: { in: arrarAssignment }
    });
    if (assignmentsData.length != arrarAssignment.length) {
        req.reject({
            code: 403,
            message: 'Assignmnet(s) you have selecteds are does not exists'
        });
    };
    try {
        await UPSERT.into('ZHS402.ZTHBT0051').entries(req.data.input);

        let reqData = req.data.input;
        response = {
            PERNR: reqData.PERNR,
            WEEK_NUMBER: reqData.WEEK_NUMBER,
            ZPNAME: reqData.ZPNAME,
            messageType: 'S',
            message: 'TimeSheet is Saved Successfully'
        };
        return response;
    } catch (error) {
        req.reject({
            code: 403,
            message: 'Error while updating TimeSheet in Cloud'
        });
    }



    // const db = await cds.connect.to('TimeSheetAPI');
    // if (req.data instanceof Array) {
    //     for (let reqData of req.data) {
    //         const dataFound = capTimeSheet.find(PERNR === reqData.PERNR && WEEK_NUMBER === reqData.WEEK_NUMBER && ZPNAME === reqData.ZPNAME);
    //         const assignmentData = assignmentsData.find(ZPNAME === reqData.ZPNAME);
    //         if (dataFound) {
    //             try {
    //                 await sendTimeSheetToS4(loggedInUser,assignmentData,reqData,response);
    //                 return response;
    //             } catch (error) {
    //                 req.reject({
    //                     code: 403,
    //                     message: 'error while saving TimeSheet into S4 system'
    //                 });
    //             }

    //         }
    //         else {
    //             req.reject({
    //                 code: 403,
    //                 message: `Assignment ${reqData.ZPNAME} does not exists`
    //             });
    //         }
    //     }
    // }



}

const prepareFilterAsObject = async (where, obj) => {
    const ge = '>=';
    if (Object.keys(where).length === 0) {
        Object.assign(where, obj);
        return;
    }
    else {
        if (obj) {
            where.push('and');
        }
    }
    if (obj) {
        for (let property in obj) {
            if (obj[property] instanceof Object) {
                if (obj[property].hasOwnProperty(ge)) {
                    where.push({ ref: [property] });
                    where.push('>=');
                    where.push({ val: obj[property]['>='] });
                    continue;
                }
                await prepareFilterAsObject(where, obj[property]);
                return;
            }
            where.push({ ref: [property] });
            where.push('=');
            where.push({ val: obj[property] });
        }
    }
}

const readReceiverWBSCombined = async (where, limit, req) => {
    const bupa = await cds.connect.to('TimeSheetEntry');
    let loggedinId = req.user.id;
    loggedinId = loggedinId.toUpperCase();
    const LoggUser = await bupa.get('ZCDSEHBTC0003.LoggedInUser').where({ email_Address: loggedinId, or: { globalID: loggedinId } });

    var oData = [];
    if (LoggUser.length > 0) {
        const AssignmentByPassData = await SELECT.from('ZHS402.ZTHBT0052').where({ BUKRS: LoggUser[0].CompanyCode });
        if (AssignmentByPassData && AssignmentByPassData.length > 0) {
            switch (AssignmentByPassData[0].CATEGORY) {
                case 'PJT':
                    await prepareFilterAsObject(where, { Profile: 'YE00001', and: { LevelInHierarchy: { '>=': 006 }, and: { ProjectType: 'E1' } } })

                    break;
                case 'OPP':
                    await prepareFilterAsObject(where, { Profile: 'YD00001', and: { LevelInHierarchy: { '>=': 002 }, and: { ProjectType: 'D1' } } })

                    break;
                default:
                    await prepareFilterAsObject(where, { UserStatus: 'CCTW', and: { LevelInHierarchy: { '>=': 006 } } });

                    break;
            }
            if (limit) {
                oData = await bupa.get('ZCDSEHBTC0003.ReceiverWBSExt').where(where).limit(limit);
            }
            else {
                oData = await bupa.get('ZCDSEHBTC0003.ReceiverWBSExt').where(where);
            }

        }
    }
    return oData;
}

const readParentWBSCombined = async (where, limit, req) => {
    const bupa = await cds.connect.to('TimeSheetEntry');
    let loggedinId = req.user.id;
    loggedinId = loggedinId.toUpperCase();
    const LoggUser = await bupa.get('ZCDSEHBTC0003.LoggedInUser').where({ email_Address: loggedinId, or: { globalID: loggedinId } });
    var oData = [];
    if (LoggUser.length > 0) {
        const AssignmentByPassData = await SELECT.from('ZHS402.ZTHBT0052').where({ BUKRS: LoggUser[0].CompanyCode });
        if (AssignmentByPassData && AssignmentByPassData.length > 0) {
            switch (AssignmentByPassData[0].CATEGORY) {
                case 'PJT':
                    await prepareFilterAsObject(where, { projectType: 'E1', and: { LevelInHierarchy: { '>=': 006 } } })

                    break;
                case 'OPP':
                    await prepareFilterAsObject(where, { projectType: 'D1', and: { LevelInHierarchy: { '>=': 002 } } })

                    break;
                default:
                    await prepareFilterAsObject(where, { projectType: 'E1', and: { LevelInHierarchy: { '>=': 006 }, and: { IhpaObjFound: 'X' } } })

                    break;
            }
            if (limit) {
                oData = await bupa.get('ZCDSEHBTC0003.ParentWBSExt').where(where).limit(limit);
            }
            else {
                oData = await bupa.get('ZCDSEHBTC0003.ParentWBSExt').where(where);
            }


        }
    }
    return oData;
}
const sendTimeSheetToS4 = async (loggedInUser, assignmentData, reqData, response) => {

    var s4TimeSheetData = {
        EmploymentInternalID: loggedInUser.EmployeeId,
        ZZ1_ParentWBS_TIM: assignmentData.PWBS,
        ZZ1_TaskCodeDescriptio_TIM: assignmentData.ZTCODE.ZTCDS,
        ZZ1_TaskCode_TIM: assignmentData.ZTCODE.ZTCODE,
        LSTAR: loggedInUser.ActivityType,
        BEMOT: assignmentData.BEMOT,
        KOKRS: loggedInUser.CompanyCode,
        RKOSTL: assignmentData.EKOSTL,
        RAUFNR: assignmentData.EAUFNR,
        SKOSTL: loggedInUser.CostCenter,
        WorkDate: reqData.DAY1_DATE,
        Status: "30",
        ZZ1_ServiceOrderItemNo_TIM: assignmentData.SERVICEORDERITEM,
        CATSHOURS: reqData.DAY1_HOUR,
        POSID: assignmentData.RWBS,
        STATKEYFIG: assignmentData.STAGR
    };

    var s4Response = await db.tx(req).post("s4TimeSheet", s4TimeSheetData);
    response = {
        PERNR: reqData.PERNR,
        WEEK_NUMBER: reqData.WEEK_NUMBER,
        ZPNAME: reqData.ZPNAME,
        messageType: 'S',
        message: 'TimeSheet is Saved Successfully'
    };
}
module.exports = registerTimeSheetHandler;