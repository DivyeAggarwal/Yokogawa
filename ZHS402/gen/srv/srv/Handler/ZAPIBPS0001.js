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
    that.on ('pgi', async (req)=> {
        console.log(req);
        // await UPSERT.into('ZHS402.ZTHBT0051').entries(req.data.input);
        // const n = await UPDATE(Inquiries).set({ 
        //     status_code:'2',
        //     startedAt: Date.now()
        // }).where ({ID:id}).and({status_code:'1'})
    })
    
}

var populateCustomerFullName = async (oData) => {
    const BusinessPartner = await cds.connect.to('BusinessPartner');
    var arrayKunnr = [];
    var customerObj = {};
    for(let data of oData) {
        if(data.ZSHTP) {
            arrayKunnr.push(data.ZSHTP);
        }   
    }
    try {
        if(arrayKunnr.length > 0) {
            const customers = await BusinessPartner.get('ZAPIBPS0001.ZCDSEBPS0001').where({ Customer: { in: arrayKunnr } });
            if(customers.length > 0) {
                for(let customer of customers) {
                    customerObj[customer.Customer] = customer.CustomerFullName;
                }
                for(let data of oData) {
                    if(data.ZSHTP) {
                        let customerFullName = customerObj[data.ZSHTP];
                        if(customerFullName) {
                            data.CustomerFullName = customerFullName;
                        }
                    }
                }  
            }
        }
        return oData;
    }
    catch (oError){
        return oData;
    }
}

var populateManager = async (oData) => {
    const BusinessPartner = await cds.connect.to('ProjectDetails');
    var arrayPSPNR = [];
    var projectObj = {};
    for(let data of oData) {
        if(data.PS_PSPNR) {
            arrayPSPNR.push(data.PS_PSPNR);
        }   
    }
    try {
        if(arrayKunnr.length > 0) {
            const projects = await BusinessPartner.get('ZAPIBPS0001.ZCDSEBPS0002').where({ ProjectId: { in: arrayPSPNR } });
            if(projects.length > 0) {
                for(let project of projects) {
                    projectObj[project.ProjectId] = { approver: project.ApproverPM, desc: project.ProjDesc};
                }
                for(let data of oData) {
                    if(data.PS_PSPNR) {
                        let projectObjOfPSPNR = projectObj[data.PS_PSPNR];
                        if(projectObjOfPSPNR) {
                            data.ProjectManager = projectObjOfPSPNR.approver;
                            data.ProjDesc = projectObjOfPSPNR.desc;
                        }
                    }
                }  
            }
        }
        return oData;
    }
    catch (oError){
        return oData;
    }
}

module.exports = registerZAPIBPS0001Handler;