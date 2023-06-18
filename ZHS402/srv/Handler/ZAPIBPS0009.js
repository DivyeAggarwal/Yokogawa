var registerZAPIBPS0009Handler = function (that, cds) {
    
    // that.on('READ', 'ZAPIBPS0009_Product', async req => {
        // const bupa = await cds.connect.to('ZSRVBHMM0008');
        // return bupa.run(req.query);
    // });
    this.on('ZAPIBPS0009_Product', async (req) => {
        var aResponse = {};
        const api = await cds.connect.to('API_PRODUCT_SRV');
        var postData = req.data.input.postData;
        for (let index = 0; index < postData.length; index++) {
            const element = postData[index];
            var response = await api.tx(req).post("/A_Product",element);
            aResponse.push(response);
        }
        return {outputObject:JSON.stringify(aResponse)};
    });
}
 
module.exports = registerZAPIBPS0009Handler;