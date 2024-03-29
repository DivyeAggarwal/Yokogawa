var registerZAPIBPS0001Handler = function (that, cds) {
    that.on('READ', 'ZCDSEBPS0001', async req => {
        const bupa = await cds.connect.to('BusinessPartner');
        return bupa.run(req.query);
    });
    that.on('READ', 'ZCDSEBPS0002', async req => {
        const bupa = await cds.connect.to('ProjectDetails');
        return bupa.run(req.query);
    });
    that.on('CREATE', 'outputSet', async req => {
        const api = await cds.connect.to('ZAPIHPS0003_SRV');
        var response = await api.tx(req).post("/outputSet",req.data);
        return response;
    });
    that.before('READ','ZCDSEBPS0003', async req => {
        if(!req._queryOptions.$filter || (!req._queryOptions.$filter.includes('PS_PSPNR') && !req._queryOptions.$filter.includes('ZDONUM'))){
            req.reject({
                code: 403,
                message: 'Either Project Definition or DO Number is mandatory'
            });
        }

    });
    that.after('READ', 'ZCDSEBPS0003', async req => {
        var oData = req;
        var oDataWithCustomer = await populateCustomerFullName(oData);
        var oDataWithManager = await populateManager(oDataWithCustomer);
        return oDataWithManager;

    });
    that.on('UPDATE', 'ZCDSEBPS0013', async req => {
        var oInput = req.data;
        var input = await SELECT.from('ZHS402.ZTHBT0055').where({ ID: { '=': oInput.ID }});
        var oInputQueryData = await SELECT.from('ZHS402.ZTHBT0055').where({ MATNR: { '=': input[0].MATNR }, PS_PSPNR: { '=': input[0].PS_PSPNR }, ZDONUM: { '=': input[0].ZDONUM } }); //UPDATE('ZHS402.ZTHBT0055').with(oInput)where({ ID: { '=': oData.data.ID }});
        for(var i=0; i < oInputQueryData.length; i++) {
            oInputQueryData[i].ZSHPSTAT = "T";
            const updateQuery = await UPDATE.entity('ZHS402.ZTHBT0055').data(oInputQueryData[i]).where({ ID: { '=': oInputQueryData[i].ID }}); 
            //   await db.run(updateQuery);
        }
        // return oDataWithManager;

    });
    that.on('READ', 'ZCDSEBPS0013', async req => {
        const db = await cds.connect.to('db');
        var oData = await db.run(req.query);
        var oDataWithCustomer = await populateCustomerFullName(oData);
        var oDataWithManager = await populateManager(oDataWithCustomer);
        // return oDataWithManager;
        var sum = 0;
        var updated = Object.values(oDataWithManager.reduce((obj, item) => {
            var key = item.ZDONUM + item.ZSHTP
           
            if (!obj[key]) {
              obj[key] = Object.assign(item)
              sum += Number(item.ZQTY)
              obj[key].ZQTY = sum
            } else {
                 sum += Number(item.ZQTY)
              obj[key].ZQTY = sum
            }
            return obj
          }, {}))
          return updated;

    });
    that.on('pgi', async (req) => {
        let oData = await SELECT.from("ZHS402.ZTHBT0055").where(req.query.SELECT.from.ref[0].where);
        if(oData[0].ZSHPSTAT === 'P') {
            req.reject({
                code: 403,
                message: 'Goods Issued already completed for this Combination'
            });
        }
        oData[0].ZSHPSTAT = 'P';
        await UPSERT.into('ZHS402.ZTHBT0055').entries(oData[0]);
        req.info({
            code: 200,
            message: 'Goods Issued successfully'
        });

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
        if (arrayPSPNR.length > 0) {
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