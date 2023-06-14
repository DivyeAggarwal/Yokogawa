var registerZAPIBPS0007Handler = function (that, cds) {
    
    that.on('READ', 'ZCDSEHPPB0097', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0019');
        return bupa.run(req.query);
    });
    that.on('READ', 'I_PlantStdVH', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0019');
        return bupa.run(req.query);
    });
    that.on('READ', 'I_CostCenterStdVH', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0019');
        return bupa.run(req.query);
    });
    that.on('READ', 'I_GLAccountStdVH', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0019');
        return bupa.run(req.query);
    });
    that.on('READ', 'I_MaterialStdVH', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0019');
        return bupa.run(req.query);
    });
    that.on('READ', 'I_ProductionOrderStdVH', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0019');
        return bupa.run(req.query);
    });
    that.on('READ', 'I_StorageLocationStdVH', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0019');
        return bupa.run(req.query);
    })
}
 
module.exports = registerZAPIBPS0007Handler;