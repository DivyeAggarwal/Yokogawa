var registerZAPIBPS0007Handler = function (that, cds) {

    that.on('READ', 'ZCDSEHPPB0097', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0019');
        return bupa.run(req.query);
    });
    this.on('CREATE', 'ZCDSEHPPB0097', async req => {
        const soapi = await cds.connect.to('ZSRVBHPP0019');
        var response = await soapi.tx(req).post("/ZCDSEHPPB0097", req.data);
        return response;
    });
    this.on('CREATE', 'IndividualIssue', async req => {
        const soapi = await cds.connect.to('ZSRVBHPP0019');
        var payload = {
            plant: req.data.plant,
            material: req.data.material,
            quantity: req.data.quantity,
            unit: req.data.unit,
            strgloc_frm: req.data.strgloc_frm,
            strgloc_to: req.data.strgloc_to,
            recip: req.data.recip,
            unl_pnt: req.data.unl_pnt,
            prodord: req.data.prodord,
            linkage: req.data.linkage,
            costcntr: req.data.costcntr,
            glacc: req.data.glacc,
            text: req.data.text,
            basedt: req.data.basedt,
            linkage: req.data.plant,
            glacc: req.data.glacc,
            text: req.data.text,
            basedt: req.data.basedt,
            linkage: req.data.plant
        }
        var response = await soapi.tx(req).post("/ZCDSEHPPB0097", payload);
        return response;
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