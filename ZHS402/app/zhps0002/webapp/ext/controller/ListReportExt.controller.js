sap.ui.define(["sap/m/MessageBox"],
    function (
        MessageBox) {
        "use strict";
        return {
            onUpdate: function (oEvent) {

                var that = this;
                var oContexts = this.extensionAPI.getSelectedContexts();
                if (oContexts.length === 0) {
                    MessageBox.error("Please select Material Documents to update.");
                    return;
                }
                var updates = [];
                var deletes = [];
                oContexts.forEach(function (oContext, index) {
                    // if any Material Document, Material Doc. Year, Material Doc.Item  fields are not initial S/4 then delete from BTP check with 4 key 
                    let object = oContext.getObject();
                    if (object.Xmblnr) { //
                        deletes.push({
                            MBLNR: object.mblnr,
                            MJAHR: object.mjahr,
                            ZEILE: object.zeile,
                            SERNR: object.sernr
                        });
                    } else {
                        updates.push({
                            PBUKR: object.pbukr,
                            PSPHI: object.psphi,
                            PS_PSP_PNR: object.ps_psp_pnr,
                            MATNR: object.matnr,
                            ZZ1_MSCODE_PRD: object.zz1_mscode_prd,
                            IDNLF: object.idnlf,
                            MBLNR: object.mblnr,
                            ZEILE: object.zeile,
                            MJAHR: object.mjahr,
                            KDAUF: object.kdauf,
                            KDPOS: object.kdpos,
                            CPUDT_MKPF: object.cpudt,
                            ERFMG: object.erfmg,
                            ERFME: object.ERFME,
                            SERNR: object.sernr
                        });
                    }
                });
                var url_render = $.sap.getModulePath("com.yokogawa.zhps0002.zhps0002") + '/ZCDSEHBTC0005/UpdatePOItem';
                sap.ui.core.BusyIndicator.show(0);
                var data = {
                    input: {
                        update: updates,
                        delete: deletes
                    }
                };
                $.ajax({
                    url: url_render,
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify(data),
                    success: function (res) {
                        sap.ui.core.BusyIndicator.hide();
                        console.log(res);
                        MessageBox.success(res.message);
                        that.extensionAPI.rebindTable(true);
                    },
                    error: function (error) {
                        console.log(error);
                        sap.ui.core.BusyIndicator.hide();
                        MessageBox.error(JSON.stringify(error));
                    }
                });
            },
            onBeforeRebindTableExtension: function (oEvent) {
                this.byId("GridTable")._getSelectionPlugin().setSelectionMode("MultiToggle");
            }
        };
    });
