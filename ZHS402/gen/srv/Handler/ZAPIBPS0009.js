var registerZAPIBPS0009Handler = function (that, cds) {
    
    // that.on('READ', 'ZAPIBPS0009_Product', async req => {
        // const bupa = await cds.connect.to('ZSRVBHMM0008');
        // return bupa.run(req.query);
    // });
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