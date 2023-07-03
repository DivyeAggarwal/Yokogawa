var registerZAPIBPS0008Handler = function (that, cds) {
    
    that.on('READ', 'ZCDSEHMMC0012', async req => {
        const bupa = await cds.connect.to('ZSRVBHMM0008');
        return bupa.run(req.query);
    });
}
 
module.exports = registerZAPIBPS0008Handler;