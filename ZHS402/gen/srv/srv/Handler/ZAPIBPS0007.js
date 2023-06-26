var registerZAPIBPS0007Handler = function (that, cds) {

    that.on('READ', 'ZCDSEHPPB0097', async req => {
        const bupa = await cds.connect.to('ZSRVBHPP0019');
        return bupa.run(req.query);
    });
    // this.on('CREATE', 'ZCDSEHPPB0097', async req => {
    //     const soapi = await cds.connect.to('ZSRVBHPP0019');
    //     var response = await soapi.tx(req).post("/ZCDSEHPPB0097", req.data);
    //     return response;
    // });
    that.on('CREATE', 'IndividualIssue', async req => {
        const soapi = await cds.connect.to('ZSRVBHPP0019');

        var optionValue = req.data.option;
        var orderTransVal = req.data.OrderTransfer;
        var immValue = req.data.Immediately;
        var functionImport;
        var immflag;
        var optionalFlag;

        if(optionValue === "None(Store)" && immValue == true ) {
            functionImport = "/none";
            immflag = "X";
            optionalFlag = "X";
        } else if(optionValue === "Order Transfer" && immValue == true && orderTransVal == "Production Order No." ) {
            functionImport = "/ordertrf";
            immflag = "X";
            optionalFlag = "Y";
        } else if(optionValue === "Order Transfer" && immValue == true && orderTransVal == "Linkage No."  ) {
            functionImport = "/linkage";
            immflag = "X";
            optionalFlag = "Y";
        } else if(optionValue === "Cost Center Transfer" && immValue == true ) {
            functionImport = "/cctrans";
            immflag = "X";
            optionalFlag = "Z";
        } else if(immValue == false ) {
            functionImport = "/immblank"; 
            immflag = ""
        }

        var url = functionImport + "?sap-client=120&plant='" + req.data.plant +"'&material='" + req.data.materia +
                 "'&quantity=" + req.data.quantity + "m&unit='" + req.data.unit + "'&strgloc_frm='" + req.data.strgloc_frm + 
                 "'&strgloc_to='" + req.data.strgloc_frm + "'&recip='" + req.data.recip + "'&unl_pnt='" + req.data.unl_pnt + 
                 "'&prodord='" + req.data.prodord + "'&linkage='" + req.data.linkage + "'&costcntr='" + req.data.costcntr + 
                 "'&glacc='" + req.data.glacc + "'&text='" + req.data.text + "'&basedt='" + req.data.basedt + 
                 "'&immflag='" + immflag + "'&optflag='" + optionalFlag + "'";
        var response = await soapi.tx(req).post(url);
        // var payload = {
        //     plant: req.data.plant,
        //     material: req.data.material,
        //     quantity: req.data.quantity,
        //     unit: req.data.unit,
        //     strgloc_frm: req.data.strgloc_frm,
        //     strgloc_to: req.data.strgloc_frm,
        //     recip: req.data.recip,
        //     unl_pnt: req.data.unl_pnt,
        //     prodord: req.data.prodord,
        //     linkage: req.data.linkage,
        //     costcntr: req.data.costcntr,
        //     glacc: req.data.glacc,
        //     text: req.data.text,
        //     basedt: req.data.basedt,
        //     linkage: req.data.plant,
        //     glacc: req.data.glacc,
        //     text: req.data.text,
        //     basedt: req.data.basedt,
        //     linkage: req.data.plant
        // }
        // var response = await soapi.tx(req).post("/ZCDSEHPPB0097", payload);
        return response;
    });
    that.on('READ', 'InputField', async req => {
        let aData = [];
        let data = {};
        data = {
            InputFieldDesc: "From the Screen"
        }
        aData.push(data);
        data = {
            InputFieldDesc: "File Upload"
        }
        aData.push(data);
        return aData;
    });
    that.on('READ', 'option', async req => {
        let aData = [];
        let data = {};
        data = {
            optionDesc: "None(Store)"
        }
        aData.push(data);
        data = {
            optionDesc: "Order Transfer"
        }
        aData.push(data);
        data = {
            optionDesc: "Cost Center Transfer"
        }
        aData.push(data);
        return aData;
    });
    that.on('READ', 'OrderTransfer', async req => {
        let aData = [];
        let data = {};
        data = {
            OrderTransferDesc: "Production Order No."
        }
        aData.push(data);
        data = {
            OrderTransferDesc: "Linkage No."
        }
        aData.push(data);
        return aData;
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