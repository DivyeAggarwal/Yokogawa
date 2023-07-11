var registerZAPIBPS0009Handler = function (that, cds) {
    
    // that.on('READ', 'ZAPIBPS0009_Product', async req => {
        // const bupa = await cds.connect.to('ZSRVBHMM0008');
        // return bupa.run(req.query);
    // });
    that.on('ZAPIBPS0009_CHARACTERISTIC', async (req) => {
        var aResponse = [];
        const api = await cds.connect.to('API_CLFN_CHARACTERISTIC_SRV');
        var postData = req.data.input.postData;        
        for (let index = 0; index < postData.length; index++) {
            const element = postData[index];
            try {
                var response = await api.tx(req).post("/A_ClfnCharacteristicForKeyDate",element);
                aResponse.push({success:true,row:index + 6, CharcInternalID : element.CharcInternalID, message:response});
            } catch (error) {
                // aResponse.push(error);
                aResponse.push({success:false,row:index + 6, CharcInternalID : element.CharcInternalID, message:error});
            }            
        }
        return {outputObject:JSON.stringify(aResponse)};    
    });
    
    that.on('ZAPIBPS0009_CLASS', async (req) => {
        var aResponse = [];
        const api = await cds.connect.to('API_CLFN_CLASS_SRV');
        var postData = req.data.input.postData;        
        for (let index = 0; index < postData.length; index++) {
            const element = postData[index];
            try {
                var response = await api.tx(req).post("/A_ClfnClassCharcForKeyDate",element);
                aResponse.push({success:true,row:index + 6, ClassInternalID : element.ClassInternalID, message:response});
            } catch (error) {
                // aResponse.push(error);
                aResponse.push({success:false,row:index + 6, ClassInternalID : element.ClassInternalID, message:error});
            }            
        }
        return {outputObject:JSON.stringify(aResponse)};    
    });
    
    that.on('ZAPIBPS0009_INFORECORD', async (req) => {
        var aResponse = [];
        const api = await cds.connect.to('API_INFORECORD_PROCESS_SRV');
        var postData = req.data.input.postData;        
        for (let index = 0; index < postData.length; index++) {
            const element = postData[index];
            try {
                var response = await api.tx(req).post("/A_PurchasingInfoRecord",element);
                aResponse.push({success:true,row:index + 6, PurchasingInfoRecord : element.PurchasingInfoRecord, message:response});
            } catch (error) {
                // aResponse.push(error);
                aResponse.push({success:false,row:index + 6, PurchasingInfoRecord : element.PurchasingInfoRecord, message:error});
            }            
        }
        return {outputObject:JSON.stringify(aResponse)};    
    });
    
    that.on('ZAPIBPS0009_PURCHASING_SOURCE', async (req) => {
        var aResponse = [];
        const api = await cds.connect.to('API_PURCHASING_SOURCE_SRV');
        var postData = req.data.input.postData;        
        for (let index = 0; index < postData.length; index++) {
            const element = postData[index];
            try {
                var response = await api.tx(req).post("/A_PurchasingSource",element);
                aResponse.push({success:true,row:index + 6, SourceListRecord : element.SourceListRecord, message:response});
            } catch (error) {
                // aResponse.push(error);
                aResponse.push({success:false,row:index + 6, SourceListRecord : element.SourceListRecord, message:error});
            }            
        }
        return {outputObject:JSON.stringify(aResponse)};    
    });
    
    that.on('ZAPIBPS0009_PURGPRCGCONDITIONRECORD', async (req) => {
        var aResponse = [];
        const api = await cds.connect.to('API_PURGPRCGCONDITIONRECORD_SRV');
        var postData = req.data.input.postData;        
        for (let index = 0; index < postData.length; index++) {
            const element = postData[index];
            try {
                var response = await api.tx(req).post("/A_PurgPrcgConditionRecord",element);
                aResponse.push({success:true,row:index + 6, ConditionRecord : element.ConditionRecord, message:response});
            } catch (error) {
                // aResponse.push(error);
                aResponse.push({success:false,row:index + 6, ConditionRecord : element.ConditionRecord, message:error});
            }            
        }
        return {outputObject:JSON.stringify(aResponse)};    
    });
    
    that.on('ZAPIBPS0009_SLSPRICINGCONDITIONRECORD', async (req) => {
        var aResponse = [];
        const api = await cds.connect.to('API_SLSPRICINGCONDITIONRECORD_SRV');
        var postData = req.data.input.postData;        
        for (let index = 0; index < postData.length; index++) {
            const element = postData[index];
            try {
                var response = await api.tx(req).post("/A_SlsPrcgConditionRecord",element);
                aResponse.push({success:true,row:index + 6, ConditionRecord : element.ConditionRecord, message:response});
            } catch (error) {
                // aResponse.push(error);
                aResponse.push({success:false,row:index + 6, ConditionRecord : element.ConditionRecord, message:error});
            }            
        }
        return {outputObject:JSON.stringify(aResponse)};    
    });
    
    that.on('ZAPIBPS0009_ZSRVBHMM0010', async (req) => {
        var aResponse = [];
        const api = await cds.connect.to('ZSRVBHMM0010');
        var postData = req.data.input.postData;        
        for (let index = 0; index < postData.length; index++) {
            const element = postData[index];
            try {
                var response = await api.tx(req).post("/ZCDSEHMMC0015",element);
                aResponse.push({success:true,row:index + 6, DESIGNNAME : element.DESIGNNAME, message:response});
            } catch (error) {
                // aResponse.push(error);
                aResponse.push({success:false,row:index + 6, DESIGNNAME : element.DESIGNNAME, message:error});
            }            
        }
        return {outputObject:JSON.stringify(aResponse)};    
    });
    
    that.on('ZAPIBPS0009_Product', async (req) => {
        var aResponse = [];
        const api = await cds.connect.to('API_PRODUCT_SRV');
        var postData = req.data.input.postData;        
        for (let index = 0; index < postData.length; index++) {
            const element = postData[index];
            try {
                var response = await api.tx(req).post("/A_Product",element);
                aResponse.push({success:true,row:index + 6, Product : element.Product, message:response});
            } catch (error) {
                // aResponse.push(error);
                aResponse.push({success:false,row:index + 6, Product : element.Product, message:error});
            }            
        }
        return {outputObject:JSON.stringify(aResponse)};    
    });
}
 
module.exports = registerZAPIBPS0009Handler;