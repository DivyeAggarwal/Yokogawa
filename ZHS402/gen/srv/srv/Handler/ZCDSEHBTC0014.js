var registerZCDSEHBTC0014Handler = function (that, cds) {
    
    that.on('READ', 'ZCDSEHPPP0004', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0014');
        return bupa.run(req.query);
    });
}
 
module.exports = registerZCDSEHBTC0014Handler;