var registerZAPIBPS0011Handler = function (that, cds) {    
   
    that.on('READ', 'ZCDSEHPPB0062', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        return bupa.run(req.query);
    });
    
    that.on('READ', 'ZCDSEHPPC0010', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        return bupa.run(req.query);
    });
    
    that.on('READ', 'ZCDSEHPPC0011', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        return bupa.run(req.query);
    });
    
    that.on('READ', 'ZCDSEHPPC0012', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        return bupa.run(req.query);
    });
    
    that.on('READ', 'ZCDSEHPPC0013', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        return bupa.run(req.query);
    });
    
    that.on('READ', 'ZCDSEHPPC0014', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0003');
        return bupa.run(req.query);
    });

} 
module.exports = registerZAPIBPS0011Handler;