var registerZAPIBPS0005Handler = function (that, cds) {
    
    that.on('READ', 'ZCDSEHSDC0009', async req => {
        const bupa = await cds.connect.to('ZSRVBHSD0011');
        return bupa.run(req.query);
   

    })
}
 
module.exports = registerZAPIBPS0005Handler;