sap.ui.define([
    "sap/ui/core/mvc/Controller"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller) {
        "use strict";

        return Controller.extend("com.yokogawa.zhpsdraftinvoice.controller.DraftInvoiceList", {
            onInit: function () {

            },
             /**
	        * Event handle for on selection change
	        * @param {sap.ui.base.Event} oEvent oEvent core event base object
	        */	
              onSelectList: function(oEvent){

                var oRouter = sap.ui.core.UIComponent.getRouterFor(this);
                
                var aSelectedPaths = oEvent.getSource().getSelectedContextPaths();
                var sSelectedPath = aSelectedPaths[0];
                var oDataModel = this.getView().getModel();


                oRouter.navTo("RouteDraftInvoiceDisplay", {
                    sPath : sSelectedPath.substr(1)                                             
                },true);

            },
            onCreate: function () {
                if (!this._oInvoiceHistoryDailogFragment) {
                    // load asynchronous XML fragment
                    this._oInvoiceHistoryDailogFragment = sap.ui.xmlfragment("InvoiceHistorySelectionDialog",
                        "com.yokogawa.zhpsdraftinvoice.view.fragments.InvoiceCreateDialog", this);
                    this.getView().addDependent(this._oInvoiceHistoryDailogFragment);
                }
                // this._onInitializeSalesRateEditDialog(oModelData);
                this._oInvoiceHistoryDailogFragment.open();
                // this.getOwnerComponent().getRouter().navTo("RouteSalesRateRegistration");
            },
            onCreateInvoice: function () {
                this.getOwnerComponent().getRouter().navTo("RouteDraftInvoiceCreate");
            },
        });
    });
