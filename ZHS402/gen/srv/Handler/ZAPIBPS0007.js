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
        var immflag = '';
        var optionalFlag = '';
        var ordflag = '';
        if (optionValue === "None(Store)" && immValue == true) {
            functionImport = "/none";
            immflag = "X";
            optionalFlag = "X";
            ordflag = "";
        } else if (optionValue === "Order Transfer" && immValue == true && orderTransVal == "Production Order No.") {
            functionImport = "/ordertrf";
            immflag = "X";
            optionalFlag = "Y";
            ordflag = "1";
        } else if (optionValue === "Order Transfer" && immValue == true && orderTransVal == "Linkage No.") {
            functionImport = "/linkage";
            immflag = "X";
            optionalFlag = "Y";
            ordflag = "2";
        } else if (optionValue === "Cost Center Transfer" && immValue == true) {
            functionImport = "/cctrans";
            immflag = "X";
            optionalFlag = "Z";
            ordflag = "";
        } else if (immValue == false) {
            functionImport = "/immblank";
            immflag = ""
            ordflag = "";
        }

        // var url = "/immediate?sap-client=120&plant='" + req.data.plant + "'&Material='" + req.data.Material +
        //     "'&Quantity=" + req.data.Quantity + "m&unit='" + req.data.unit + "'&StorageLocationFrom='" + req.data.StorageLocationFrom +
        //     "'&StorageLocationTo='" + req.data.StorageLocationTo + "'&Recipient='" + req.data.Recipient + "'&UnlPoint='" + req.data.UnlPoint +
        //     "'&ProdOrder='" + req.data.ProdOrder + "'&Linkage='" + req.data.Linkage + "'&Costcenter='" + req.data.Costcenter +
        //     "'&GLAccountcode='" + req.data.GLAccountcode + "'&Text='" + req.data.Text + "'&basedate='" + req.data.basedate +
        //     "'&immflag='" + immflag + "'&optflag='" + optionalFlag + "'";
        // var url = "/immediate?sap-client=120&plant='" + req.data.plant + "'&Material='" + req.data.Material + "'&type=''&Immediately='" + req.data.Immediately +
        //         "'&Quantity=" + req.data.Quantity + "m&unit='" + req.data.unit + "'&StorageLocationFrom='" + req.data.StorageLocationFrom + 
        //         "'&StorageLocationTo='" + req.data.StorageLocationTo + "'&Recipient='" + req.data.Recipient + "'&UnlPoint='" + req.data.UnlPoint +
        //         "'&ProdOrder='" + req.data.ProdOrder + "'&Linkage='" + req.data.Linkage + "'&Costcenter='" + req.data.Costcenter +
        //         "'&GLAccountcode='" + req.data.GLAccountcode + "'&Text='" + req.data.Text + "'&basedate='" + req.data.basedate +
        //         "'&inpfile=''&outfile=''&errflag=''&inputfd=''&optionfd=''&ordertfd=''&Message=''&inpflag='" + 
        //         "'&immflag='" + immflag + "'&optflag='" + optionalFlag + "'&ordflag='" + ordflag + "'";
        // var response = await soapi.tx(req).post(url);

        if(req.data.plant == undefined) {
            req.data.plant = ''
        }
        if(req.data.Material == undefined) {
            req.data.Material = ''
        }
        if(req.data.Quantity == undefined) {
            req.data.Quantity = '0.000'
        }
        if(req.data.Recipient == undefined) {
            req.data.Recipient = ''
        }
        if(req.data.UnlPoint == undefined) {
            req.data.UnlPoint = ''
        }
        if(req.data.Text == undefined) {
            req.data.Text = ''
        }
        if(req.data.ProdOrder == undefined) {
            req.data.ProdOrder = ''
        }
        if(req.data.Linkage == undefined) {
            req.data.Linkage = ''
        }
        if(req.data.Costcenter == undefined) {
            req.data.Costcenter = ''
        }
        if(req.data.GLAccountcode == undefined) {
            req.data.GLAccountcode = ''
        }
        if(req.data.unit == undefined) {
            req.data.unit = 'PS'
        }
        if(req.data.basedate == undefined) {
            req.data.basedate = ''
        }
        if(req.data.StorageLocationFrom == undefined) {
            req.data.StorageLocationFrom = ''
        }
        if(req.data.StorageLocationTo == undefined) {
            req.data.StorageLocationTo = ''
        }

        if(req.data.basedate !== undefined) {
            req.data.basedate = req.data.basedate.split('-').join('');
        }

        var payload = {
            plant: req.data.plant,
            Material: req.data.Material,
            Quantity: req.data.Quantity,
            unit: req.data.unit,
            StorageLocationFrom: req.data.StorageLocationFrom,
            StorageLocationTo: req.data.StorageLocationTo,
            Recipient: req.data.Recipient,
            UnlPoint: req.data.UnlPoint,
            ProdOrder: req.data.ProdOrder,
            Linkage: req.data.Linkage,
            Costcenter: req.data.Costcenter,
            GLAccountcode: req.data.GLAccountcode,
            Text: req.data.Text,
            immflag: immflag,
            optflag: optionalFlag,
            basedate: req.data.basedate,
            ordflag: ordflag
        }
        var response = await soapi.tx(req).post("/ZCDSEHPPB0097", payload);
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
                req.data.uploadFile[i].immflag = "X";
                req.data.uploadFile[i].optflag = "Y";
                req.data.uploadFile[i].ordflag = "2";

            } else if (prodOrder && immediately) {
                functionImport = "/ordertrf";
                req.data.uploadFile[i].immflag = "X";
                req.data.uploadFile[i].optflag = "Y";
                req.data.uploadFile[i].ordflag = "1";
                req.data.uploadFile[i].ordflag = "";
            } else if (!prodOrder && !linkage && immediately) {
                functionImport = "/none";
                req.data.uploadFile[i].immflag = "X";
                req.data.uploadFile[i].optflag = "X";
                req.data.uploadFile[i].ordflag = "";
            } else if (costCenter && glAccount && immediately) {
                functionImport = "/cctrans";
                req.data.uploadFile[i].immflag = "X";
                req.data.uploadFile[i].optflag = "Z";
                req.data.uploadFile[i].ordflag = "";
            } else if (!immediately) {
                functionImport = "/immblank";
                req.data.uploadFile[i].immflag = ""
                req.data.uploadFile[i].ordflag = "";
            }


            // var url = "/inputfield?sap-client=120&plant='" + req.data.uploadFile[i].plant + "'&Material='" + req.data.uploadFile[i].Material + "'&type=''&Immediately='" + req.data.uploadFile[i].Immediately +
            //     "'&Quantity=" + req.data.uploadFile[i].Quantity + "m&unit='" + req.data.uploadFile[i].unit + "'&StorageLocationFrom='" + req.data.uploadFile[i].StorageLocationFrom + 
            //     "'&StorageLocationTo='" + req.data.uploadFile[i].StorageLocationTo + "'&Recipient='" + req.data.uploadFile[i].Recipient + "'&UnlPoint='" + req.data.uploadFile[i].UnlPoint +
            //     "'&ProdOrder='" + req.data.uploadFile[i].ProdOrder + "'&Linkage='" + req.data.uploadFile[i].Linkage + "'&Costcenter='" + req.data.uploadFile[i].Costcenter +
            //     "'&GLAccountcode='" + req.data.uploadFile[i].GLAccountcode + "'&Text='" + req.data.uploadFile[i].Text + "'&basedate='" + req.data.uploadFile[i].basedate +
            //     "'&inpfile=''&outfile=''&errflag=''&inputfd=''&optionfd=''&ordertfd=''&Message=''&inpflag='" + 
            //     "'&immflag='" + immflag + "'&optflag='" + optionalFlag + "'&ordflag='" + ordflag + "'";
                
            // var response = await soapi.tx(req).post(url);

            if(req.data.uploadFile[i].plant == undefined) {
                req.data.uploadFile[i].plant = ''
            }
            if(req.data.uploadFile[i].Material == undefined) {
                req.data.uploadFile[i].Material = ''
            }
            if(req.data.uploadFile[i].Quantity == undefined) {
                req.data.uploadFile[i].Quantity = ''
            }
            if(req.data.uploadFile[i].Recipient == undefined) {
                req.data.uploadFile[i].Recipient = ''
            }
            if(req.data.uploadFile[i].UnlPoint == undefined) {
                req.data.uploadFile[i].UnlPoint = ''
            }
            if(req.data.uploadFile[i].Text == undefined) {
                req.data.uploadFile[i].Text = ''
            }
            if(req.data.uploadFile[i].ProdOrder == undefined) {
                req.data.uploadFile[i].ProdOrder = ''
            }
            if(req.data.uploadFile[i].Linkage == undefined) {
                req.data.uploadFile[i].Linkage = ''
            }
            if(req.data.uploadFile[i].Costcenter == undefined) {
                req.data.uploadFile[i].Costcenter = ''
            }
            if(req.data.uploadFile[i].GLAccountcode == undefined) {
                req.data.uploadFile[i].GLAccountcode = ''
            }
            if(req.data.uploadFile[i].unit == undefined) {
                req.data.uploadFile[i].unit = ''
            }
            if(req.data.uploadFile[i].basedate == undefined) {
                req.data.uploadFile[i].basedate = ''
            }
            if(req.data.uploadFile[i].StorageLocationFrom == undefined) {
                req.data.uploadFile[i].StorageLocationFrom = ''
            }
            if(req.data.uploadFile[i].StorageLocationTo == undefined) {
                req.data.uploadFile[i].StorageLocationTo = ''
            }
    

            var payload = {
                plant: req.data.uploadFile[i].plant,
                Material: req.data.uploadFile[i].Material,
                Quantity: req.data.uploadFile[i].Quantity,
                unit: req.data.uploadFile[i].unit,
                StorageLocationFrom: req.data.uploadFile[i].StorageLocationFrom,
                StorageLocationTo: req.data.uploadFile[i].StorageLocationTo,
                Recipient: req.data.uploadFile[i].Recipient,
                UnlPoint: req.data.uploadFile[i].UnlPoint,
                ProdOrder: req.data.uploadFile[i].ProdOrder,
                Linkage: req.data.uploadFile[i].Linkage,
                Costcenter: req.data.uploadFile[i].Costcenter,
                GLAccountcode: req.data.uploadFile[i].GLAccountcode,
                Text: req.data.uploadFile[i].Text,
                immflag: req.data.uploadFile[i].immflag,
                optflag: req.data.uploadFile[i].optflag,
                basedate: req.data.uploadFile[i].basedate,
                ordflag: req.data.uploadFile[i].ordflag
            }
            var response = await soapi.tx(req).post("/ZCDSEHPPB0097", payload);
            output.push(response);
        }
        return {
            "uploadFile":output
        }
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