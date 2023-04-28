var registerZAPIBPS0001Handler = function (that, cds) {
    that.on('READ', 'ZCDSEBPS0001', async req => {
        const bupa = await cds.connect.to('BusinessPartner');
        return bupa.run(req.query);
    });
    that.on('READ', 'ZCDSEBPS0002', async req => {
        const bupa = await cds.connect.to('ProjectDetails');
        return bupa.run(req.query);
    });
    that.on('READ', 'ZCDSEBPS0003', async req => {
        const db = await cds.connect.to('db');
        var oData = await db.run(req.query);
        var oDataWithCustomer = await populateCustomerFullName(oData);
        var oDataWithManager = await populateManager(oDataWithCustomer);
        return oDataWithManager;

    });
    that.on('pgi', async (req) => {
        const db = await cds.connect.to('db');
        var oData = await db.run(req.query);
        db.send('ZCDSEBPS0003',oData);
        console.log(req);
    })

}

var updateShipStatus = async (odata) => {

}

var populateCustomerFullName = async (oData) => {
    const BusinessPartner = await cds.connect.to('BusinessPartner');
    var arrayKunnr = [];
    var customerObj = {};
    if (oData instanceof Array) {
        for (let data of oData) {
            if (data.ZSHTP) {
                arrayKunnr.push(data.ZSHTP);
            }
        }
    }
    else {
        arrayKunnr.push(oData.ZSHTP);
    }

    try {
        if (arrayKunnr.length > 0) {
            const customers = await BusinessPartner.get('ZAPIBPS0001.ZCDSEBPS0001').where({ Customer: { in: arrayKunnr } });
            if (customers.length > 0) {
                for (let customer of customers) {
                    customerObj[customer.Customer] = customer.CustomerFullName;
                }
                if (oData instanceof Array) {
                    for (let data of oData) {
                        if (data.ZSHTP) {
                            let customerFullName = customerObj[data.ZSHTP];
                            if (customerFullName) {
                                data.CustomerFullName = customerFullName;
                            }
                        }
                    }
                }
                else {
                    let customerFullName = customerObj[oData.ZSHTP];
                    if (customerFullName) {
                        oData.CustomerFullName = customerFullName;
                    }
                }

            }
        }
        return oData;
    }
    catch (oError) {
        return oData;
    }
}

var populateManager = async (oData) => {
    const BusinessPartner = await cds.connect.to('ProjectDetails');
    var arrayPSPNR = [];
    var projectObj = {};
    if (oData instanceof Array) {
        for (let data of oData) {
            if (data.PS_PSPNR) {
                arrayPSPNR.push(data.PS_PSPNR);
            }
        }
    }
    else {
        arrayPSPNR.push(oData.PS_PSPNR);
    }
    try {
        if (arrayKunnr.length > 0) {
            const projects = await BusinessPartner.get('ZAPIBPS0001.ZCDSEBPS0002').where({ ProjectId: { in: arrayPSPNR } });
            if (projects.length > 0) {
                for (let project of projects) {
                    projectObj[project.ProjectId] = { approver: project.ApproverPM, desc: project.ProjDesc };
                }
                if (oData instanceof Array) {
                    for (let data of oData) {
                        if (data.PS_PSPNR) {
                            let projectObjOfPSPNR = projectObj[data.PS_PSPNR];
                            if (projectObjOfPSPNR) {
                                data.ProjectManager = projectObjOfPSPNR.approver;
                                data.ProjDesc = projectObjOfPSPNR.desc;
                            }
                        }
                    }
                }
                else {
                    let projectObjOfPSPNR = projectObj[oData.PS_PSPNR];
                    if (projectObjOfPSPNR) {
                        oData.ProjectManager = projectObjOfPSPNR.approver;
                        oData.ProjDesc = projectObjOfPSPNR.desc;
                    }
                }
            }
        }
        return oData;
    }
    catch (oError) {
        return oData;
    }
}

module.exports = registerZAPIBPS0001Handler;