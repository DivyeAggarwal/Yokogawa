sap.ui.define([
    "sap/ui/core/mvc/Controller",
    'sap/ui/model/json/JSONModel',
    "sap/ui/core/Fragment",
    'sap/m/Token',
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller, JSONModel, Fragment, Token) {
        "use strict";

        return Controller.extend("com.yokogawa.zhmftendigitpartcreate.controller.TenDigitCreateInitial", {
            onInit: function () {
                var oModel = this.getOwnerComponent().getModel();
                this.getView().setModel(oModel);
                
                this.getView().bindElement("/ZSCREEN1()");
                this.oColModel = new JSONModel(sap.ui.require.toUrl("com/yokogawa/zhmftendigitpartcreate/model") + "/columnsModel.json");
                this._oInputMaterial = this.getView().byId("idMaterial");

                // this.getView().byId("idHeaderTypeField1").setValue("test");
                // this._oInputProjectDef = this.getView().byId("idProjectDef");
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
            onValueHelpRequested: function() {
                var aCols = this.oColModel.getData().cols;
    
                Fragment.load({
                    name: "com.yokogawa.zhmftendigitpartcreate.view.fragments.MaterialValueHelp",
                    controller: this
                }).then(function name(oFragment) {
                    this._oValueHelpDialog = oFragment;
                    this.getView().addDependent(this._oValueHelpDialog);
    
                    this._oValueHelpDialog.getTableAsync().then(function (oTable) {
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
    
                        this._oValueHelpDialog.update();
                    }.bind(this));
    
                    var oToken = new Token();
                    oToken.setKey(this._oInputMaterial.getSelectedKey());
                    oToken.setText(this._oInputMaterial.getValue());
                    this._oValueHelpDialog.setTokens([oToken]);
                    this._oValueHelpDialog.open();
                }.bind(this));
    
            },
            onValueHelpOkPress: function (oEvent) {
                var aTokens = oEvent.getParameter("tokens");
    
                if (aTokens.length > 0) {
                    this._oInputMaterial.setValue(aTokens[0].getKey());
                }
                this._oValueHelpDialog.close();
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
             }));
         },
 
         _filterTable: function (oFilter) {
             var oValueHelpDialog = this._oValueHelpDialog;
 
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
