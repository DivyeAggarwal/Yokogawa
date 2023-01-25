sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    'sap/ui/model/Filter',
	'sap/ui/model/FilterOperator',
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller, JSONModel, Filter, FilterOperator) {
        "use strict";

        return Controller.extend("com.yokogawa.zhmftendigitpartcreate.controller.TenDigitCreate", {
            onInit: function () {
                this.getView().bindElement("/ZSCREEN1()");
                var oRouter = this.getOwnerComponent().getRouter();
			    oRouter.getRoute("RouteTenDigitCreate").attachPatternMatched(this._onObjectMatched, this);

            },
            onAfterRendering: function () {
                this.getView().byId("idMaterial1").setValue(this.Material);
            },
            _onObjectMatched: function (oEvent) {
                // this.busyDialog = new sap.m.BusyDialog();
                // this.busyDialog.open();
			    var oArgs = oEvent.getParameter("arguments");
                // this.getView().getModel().refresh(true);
                this.Material = oArgs.Material;
                this.MakerCode = oArgs.MakerCode;
                this.PackingCode = oArgs.PackingCode;
                
                this.getView().byId("idMaterial").setValue(this.Material);
                this.getView().byId("idMakerCode").setValue(this.MakerCode);
                this.getView().byId("idPackingCode").setValue(this.PackingCode);
                var oFilter = [];
                oFilter.push(new Filter({
                    filters: [
                        new Filter({
                            path: "PARTS_NO",
                            operator: FilterOperator.EQ,
                            value1: this.Material
                        }),
                        new Filter({
                            path: "PCKG_CD",
                            operator: FilterOperator.EQ,
                            value1: this.PackingCode
                        })
                    ],
                    and: true
                }));
                var oModel = this.getView().getModel();
                oModel.read("/ZTHBT0001", {
                    filters: oFilter,
                    success: function (data) {
                       var wbsModel = new sap.ui.model.json.JSONModel();
                        wbsModel.setData(data.results[0]);
                        var wbsStatusModel = new sap.ui.model.json.JSONModel();
                        // wbsStatusModel.setData(data.results[0].to_WbsWfStatus.results[0]);
                        // this.internalNumber = data.results[0].InternalNumber;
                        var wbsArray = data.results;
                        var reqType = this.reqType;
                        // var wbsArrayFilter = wbsArray.filter(function (wbs) {
                        //     return (wbs.request_type === reqType);
                        // });
                        this.getView().setModel(wbsModel, "wbsModel");
                        this.getView().setModel(wbsStatusModel, "wbsStatusModel"); 
                        this.getView().byId("idSubmitApproval").setValue(data.results[0].PCKG_TYPE);
                        this.getView().byId("idSubmitApproval").setValue(data.results[0].PCKG_STYLE);
                        this.getView().byId("idSubmitApproval").setValue(data.results[0].SUPPLY_STYLE);
                        this.getView().byId("idSubmitApproval").setValue(data.results[0].PCKG_UNIT_QTY);

                    this.busyDialog.close();
                    }.bind(this),
                    error: function () {
                        this.busyDialog.close();
                        MessageToast.show("Error in fetching project.");
                    }.bind(this),
                })
                
            },
            onPressGo: function() {
                var oMaterial = this.getView().byId("idMaterial").getValue();
                var oMakerCode = this.getView().byId("idMakerCode").getValue();
                var oPackingCode = this.getView().byId("idPackingCode").getValue();

                var partsNo = oMaterial.substring(0, 7) + "-" + oMakerCode.substring(0, 1) + oPackingCode;

                this.getOwnerComponent().getRouter().navTo("RouteTenDigitCreate", {
                    Material: oMaterial,
                    MakerCode: oMakerCode,
                    PackingCode: oPackingCode
                });
            },
            onValueHelpRequestedPackType: function() {
                var aCols = this.oColModel.getData().cols;
    
                Fragment.load({
                    name: "com.yokogawa.zhmftendigitpartcreate.view.fragments.PackingTypeValueHelp",
                    controller: this
                }).then(function name(oFragment) {
                    this._oValueHelpDialogPackType = oFragment;
                    this.getView().addDependent(this._oValueHelpDialogPackType);
    
                    this._oValueHelpDialogPackType.getTableAsync().then(function (oTable) {
                        oTable.setModel(this.oProductsModel);
                        oTable.setModel(this.oColModel, "columns");
    
                        if (oTable.bindRows) {
                            oTable.bindAggregation("rows", "/ZTHBT0005");
                        }
    
                        if (oTable.bindItems) {
                            oTable.bindAggregation("items", "/ZTHBT0005", function () {
                                return new ColumnListItem({
                                    cells: aCols.map(function (column) {
                                        return new Label({ text: "{" + column.template + "}" });
                                    })
                                });
                            });
                        }
    
                        this._oValueHelpDialogPackType.update();
                    }.bind(this));
    
                    var oToken = new Token();
                    oToken.setKey(this._oInputMaterial.getSelectedKey());
                    oToken.setText(this._oInputMaterial.getValue());
                    this._oValueHelpDialogPackType.setTokens([oToken]);
                    this._oValueHelpDialogPackType.open();
                }.bind(this));
    
            },
            onValueHelpOkPress: function (oEvent) {
                var aTokens = oEvent.getParameter("tokens");
    
                if (aTokens.length > 0) {
                    this._oInputMaterial.setValue(aTokens[0].getKey());
                }
                this._oValueHelpDialogPackType.close();
            },
            onFilterBarSearch: function (oEvent) {
                var aSelectionSet = oEvent.getParameter("selectionSet");
             var aFilters = aSelectionSet.reduce(function (aResult, oControl) {
                 if (oControl.getValue()) {
                     aResult.push(new Filter({
                         path: oControl.getName(),
                         operator: FilterOperator.Contains,
                         value1: oControl.getValue()
                     }));
                 }
 
                 return aResult;
             }, []);
 
 
             this._filterTable(new Filter({
                 filters: aFilters,
                 and: true
             }),this._oValueHelpDialogPackType);
         },
 
         _filterTable: function (oFilter, oValueHelp) {
             var oValueHelpDialog = oValueHelp;
 
             oValueHelpDialog.getTableAsync().then(function (oTable) {
                 if (oTable.bindRows) {
                     oTable.getBinding("rows").filter(oFilter);
                 }
 
                 if (oTable.bindItems) {
                     oTable.getBinding("items").filter(oFilter);
                 }
 
                 oValueHelpDialog.update();
             });
         },
        });
    });
