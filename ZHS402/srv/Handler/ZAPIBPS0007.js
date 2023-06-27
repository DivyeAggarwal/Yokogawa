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

        if (optionValue === "None(Store)" && immValue == true) {
            functionImport = "/none";
            immflag = "X";
            optionalFlag = "X";
        } else if (optionValue === "Order Transfer" && immValue == true && orderTransVal == "Production Order No.") {
            functionImport = "/ordertrf";
            immflag = "X";
            optionalFlag = "Y";
        } else if (optionValue === "Order Transfer" && immValue == true && orderTransVal == "Linkage No.") {
            functionImport = "/linkage";
            immflag = "X";
            optionalFlag = "Y";
        } else if (optionValue === "Cost Center Transfer" && immValue == true) {
            functionImport = "/cctrans";
            immflag = "X";
            optionalFlag = "Z";
        } else if (immValue == false) {
            functionImport = "/immblank";
            immflag = ""
        }

        var url = functionImport + "?sap-client=120&plant='" + req.data.plant + "'&Material='" + req.data.Material +
            "'&Quantity=" + req.data.Quantity + "m&unit='" + req.data.unit + "'&StorageLocationFrom='" + req.data.StorageLocationFrom +
            "'&StorageLocationTo='" + req.data.StorageLocationTo + "'&Recipient='" + req.data.Recipient + "'&UnlPoint='" + req.data.UnlPoint +
            "'&ProdOrder='" + req.data.ProdOrder + "'&Linkage='" + req.data.Linkage + "'&Costcenter='" + req.data.Costcenter +
            "'&GLAccountcode='" + req.data.GLAccountcode + "'&Text='" + req.data.Text + "'&basedate='" + req.data.basedate +
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

    that.on('CREATE', 'IndividualIssueMassUpload', async req => {
        const soapi = await cds.connect.to('ZSRVBHPP0019');
        var output = [];

        // req.data.UploadFile.forEach(e => { 
        for (var i = 0; i < req.data.uploadFile.length; i++) {

            var linkage = req.data.uploadFile[i].Linkage;
            var prodOrder = req.data.uploadFile[i].ProdOrder;
            var costCenter = req.data.uploadFile[i].Costcenter;
            var glAccount = req.data.uploadFile[i].GLAccountcode;
            var immediately = req.data.uploadFile[i].Immediately;
            var functionImport;
            var immflag;
            var optionalFlag;
            var ordflag;

            if (linkage && immediately) {
                functionImport = "/linkage";
                immflag = "X";
                optionalFlag = "Y";
                ordflag = "2";

            } else if (prodOrder && immediately) {
                functionImport = "/ordertrf";
                immflag = "X";
                optionalFlag = "Y";
                ordflag = "1";
            } else if (!prodOrder && !linkage && immediately) {
                functionImport = "/none";
                immflag = "X";
                optionalFlag = "X";
            } else if (costCenter && glAccount && immediately) {
                functionImport = "/cctrans";
                immflag = "X";
                optionalFlag = "Z";
            } else if (!immediately) {
                functionImport = "/immblank";
                immflag = ""
            }


            var url = "/inputfield?sap-client=120&plant='" + req.data.uploadFile[i].plant + "'&Material='" + req.data.uploadFile[i].Material +
                "'&Quantity=" + req.data.uploadFile[i].Quantity + "m&unit='" + req.data.uploadFile[i].unit + "'&StorageLocationFrom='" + req.data.uploadFile[i].StorageLocationFrom +
                "'&StorageLocationTo='" + req.data.uploadFile[i].StorageLocationTo + "'&Recipient='" + req.data.uploadFile[i].Recipient + "'&UnlPoint='" + req.data.uploadFile[i].UnlPoint +
                "'&ProdOrder='" + req.data.uploadFile[i].ProdOrder + "'&Linkage='" + req.data.uploadFile[i].Linkage + "'&Costcenter='" + req.data.uploadFile[i].Costcenter +
                "'&GLAccountcode='" + req.data.uploadFile[i].GLAccountcode + "'&Text='" + req.data.uploadFile[i].Text + "'&basedate='" + req.data.uploadFile[i].basedate +
                "'&immflag='" + immflag + "'&optflag='" + optionalFlag + "'&ordflag='" + ordflag + "'";
                
            var response = await soapi.tx(req).post(url);
            output.push(response);
        }
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