var registerZAPIBPS0006Handler = function (that, cds) {
    
    that.on('READ', 'ZCDSEHPPB0081', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0013');
        return bupa.run(req.query);
   

    })
}
 
module.exports = registerZAPIBPS0006Handler;