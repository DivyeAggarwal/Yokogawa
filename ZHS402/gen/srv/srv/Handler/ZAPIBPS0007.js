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
    // this.on('CREATE', 'IndividualIssue', async req => {
    //     const soapi = await cds.connect.to('ZSRVBHPP0019');

    //     var optionValue = req.data.option;
    //     var orderTransVal = req.data.OrderTransfer;
    //     var immValue = req.data.Immediately;
    //     var functionImport;

    //     if(optionValue === "X" && immValue == true ) {
    //         functionImport = "/none";
    //     } else if(optionValue === "Y" && immValue == true && orderTransVal == "X" ) {
    //         functionImport = "/ordertrf";
    //     } else if(optionValue === "Y" && immValue == true && orderTransVal == "Y"  ) {
    //         functionImport = "/linkage";
    //     } else if(optionValue === "Z" && immValue == true ) {
    //         functionImport = "/cctrans";
    //     } else if(immValue == false ) {
    //         functionImport = "/immblank"; 
    //     }

    //     var url = functionImport + "?sap-client=120&plant='" + req.data.plant +"'&material='" + req.data.materia +
    //              "'&quantity=" + req.data.quantity + "m&unit='" + req.data.unit + "'&strgloc_frm='" + req.data.strgloc_frm + 
    //              "'&strgloc_to='" + req.data.strgloc_frm + "'&recip='" + req.data.recip + "'&unl_pnt='" + req.data.unl_pnt + 
    //              "'&prodord='" + req.data.prodord + "'&linkage='" + req.data.linkage + "'&costcntr='" + req.data.costcntr + 
    //              "'&glacc='" + req.data.glacc + "'&text='" + req.data.text + "'&basedt='" + req.data.basedt + 
    //              "'&immflag='" + req.data.immflag + "'&optflag='" + req.data.optflag + "'&ordflag='" + req.data.ordflag + 
    //              "'&inpfile='" + req.data.inpfile + "'&outfile='" + req.data.outfile + "'&errmsg='" + req.data.errmsg + 
    //              "'&inputfd='" + req.data.inputfd + "'&inputfd='" + req.data.inputfd + "'&ordertfd='" + req.data.ordertfd + "'";
    //     var response = await soapi.tx(req).post(url, payload);
    //     // var payload = {
    //     //     plant: req.data.plant,
    //     //     material: req.data.material,
    //     //     quantity: req.data.quantity,
    //     //     unit: req.data.unit,
    //     //     strgloc_frm: req.data.strgloc_frm,
    //     //     strgloc_to: req.data.strgloc_frm,
    //     //     recip: req.data.recip,
    //     //     unl_pnt: req.data.unl_pnt,
    //     //     prodord: req.data.prodord,
    //     //     linkage: req.data.linkage,
    //     //     costcntr: req.data.costcntr,
    //     //     glacc: req.data.glacc,
    //     //     text: req.data.text,
    //     //     basedt: req.data.basedt,
    //     //     linkage: req.data.plant,
    //     //     glacc: req.data.glacc,
    //     //     text: req.data.text,
    //     //     basedt: req.data.basedt,
    //     //     linkage: req.data.plant
    //     // }
    //     // var response = await soapi.tx(req).post("/ZCDSEHPPB0097", payload);
    //     // return response;
    // });
    that.on('READ', 'InputField', async req => {
        let aData = [];
        let data = {};
        data = {
            InputField: "X",
            InputFieldDesc: "From the Screen"
        }
        aData.push(data);
        data = {
            InputField: "Y",
            InputFieldDesc: "File Upload"
        }
        aData.push(data);
        return aData;
    });
    that.on('READ', 'option', async req => {
        let aData = [];
        let data = {};
        data = {
            InputField: "X",
            InputFieldDesc: "None(Store)"
        }
        aData.push(data);
        data = {
            InputField: "Y",
            InputFieldDesc: "Order Transfer"
        }
        aData.push(data);
        data = {
            InputField: "Z",
            InputFieldDesc: "Cost Center Transfer"
        }
        aData.push(data);
        return aData;
    });
    that.on('READ', 'OrderTransfer', async req => {
        let aData = [];
        let data = {};
        data = {
            InputField: "X",
            InputFieldDesc: "Production Order No."
        }
        aData.push(data);
        data = {
            InputField: "Y",
            InputFieldDesc: "Linkage No."
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