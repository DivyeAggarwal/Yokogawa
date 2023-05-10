var registerZAPIBPS0002Handler = function (that, cds) {
    that.on('UPDATE', 'ZCDSEBPS0004', async req => {
        const bupa = await cds.connect.to('db');
        return bupa.run(req.query);
    });

    

}

module.exports = registerZAPIBPS0001Handler;