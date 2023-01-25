sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/m/MessageBox",
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller, JSONModel,MessageBox) {
        "use strict";

        return Controller.extend("com.yokogawa.zhpsdraftinvoice.controller.DraftInvoiceDisplay", {
            onInit: function () {
            
            // var aitemInvoice = [];
            // var oDraftInvoiceData = new JSONModel();
			// oDraftInvoiceData.setData(aitemInvoice);
			// this.getView().setModel(oDraftInvoiceData, "oDraftInvoiceData");
            var oViewModel = new JSONModel({
				hasRequired: true,
				hasInputVisible: true,
				hasTextVisible: false,
				status: "Success",
				hasHarmonyVisible: true
			});
            this.getView().setModel(oViewModel, "appView");

            this.getOwnerComponent().getRouter().getRoute("RouteDraftInvoiceDisplay").attachMatched(this._onObjectMatched, this);

            },
            _onObjectMatched: function (oEvent) {
                var sPath = oEvent.getParameter("arguments").sPath;
                this.sPath = sPath;
                this.getInvoiceData();
               

            //    this._bindView("/"+sPath);
             
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
            getInvoiceData: function () {
                // this.busyDialog = new sap.m.BusyDialog({
                //     title: "Loading Data",
                //     text: "Retreiving Invoice"
                // });
                // this.busyDialog.open();
                var urlToRead = "/" + this.sPath;//'/ZTHBT0022';
                var filter = new sap.ui.model.Filter("InvoiceID", "EQ", "12345");
                var data1;
                this.getOwnerComponent().getModel().read(urlToRead, {
                    urlParameters: {
                        "$expand": "Resources,Expense,Material"
                    },
                    // filters: [filter],
                    method: "GET",
                    success: function (oData, response) {
                        console.log(oData);
                        var oDraftInvoiceData = new JSONModel([]);
					    oDraftInvoiceData.setData(oData);
					    this.getView().setModel(oDraftInvoiceData, "oDraftInvoiceData");
                        // this.getView().getModel("oDraftInvoiceData").setProperty('/', oData.results);
						//this.byId('idSolTeamTable').setModel(this.getView().getModel("oDraftInvoiceData"));
                    }.bind(this),
                    error: function (error) {

                    }.bind(this)


                });

            },
            onEditInvoice: function () {
                // this.getView().byId("idHoursText").setVisible(false);
                // this.getView().byId("idHoursInput").setVisible(true);
                this.getView().getModel("appView").setProperty("/hasInputVisible", false);
			    this.getView().getModel("appView").setProperty("/hasTextVisible", true);
            },
            onSaveChanges: function() {
                var that=this;
                var oInvoiceData = this.getView().getModel("oDraftInvoiceData").getData();
                if (oInvoiceData.Resources.results.length > 0) {
                    oInvoiceData.Resources.results.forEach(function (oResources) {
                        var sPath;
                        
                            sPath = "/ZTHBT0023(guid'" + oResources.ID + "')";
                        
                        that.getView().getModel().setProperty(sPath + "/Hours", oResources.Hours);
                        that.getView().getModel().setProperty(sPath + "/BillingAmount", oResources.BillingAmount);
    
                        
                    });
                }

                if (oInvoiceData.Expense.results.length > 0) {
                    oInvoiceData.Expense.results.forEach(function (oExpense) {
                        var sPath;
                        
                            sPath = "/ZTHBT0024(guid'" + oExpense.ID + "')";
                        
                        that.getView().getModel().setProperty(sPath + "/Note", oExpense.Note);
                        that.getView().getModel().setProperty(sPath + "/CalcType", oExpense.CalcType);
                        that.getView().getModel().setProperty(sPath + "/BillingAmount", oExpense.BillingAmount);
                        
                    });
                }
                if (oInvoiceData.Material.results.length > 0) {
                    oInvoiceData.Material.results.forEach(function (oMaterial) {
                        var sPath;
                        
                            sPath = "/ZTHBT0025(guid'" + oMaterial.ID + "')";
                        
                        that.getView().getModel().setProperty(sPath + "/MaterialDesc", oMaterial.MaterialDesc);
                        that.getView().getModel().setProperty(sPath + "/UnitPrice", oMaterial.UnitPrice);
                        that.getView().getModel().setProperty(sPath + "/Quan", oMaterial.Quan);
    
                        
                    });
                }

                // var sPath = "/ZTHBT0024('345345')";
					// }
                    var oDataModel = this.getView().getModel();
					// oDataModel.setProperty(sPath + "/CalcType", "-");
                    var oDataModel = this.getView().getModel();
                    if (oDataModel.hasPendingChanges()) {
                        oDataModel.submitChanges({
                            success: function (data) {
                                MessageBox.success("Invoice Saved Successfully");
                                this.getView().getModel("appView").setProperty("/hasInputVisible", true);
			                    this.getView().getModel("appView").setProperty("/hasTextVisible", false);
                                
                            }.bind(this),
                            error: function () {
                                this.busyDialog.close();  
                                MessageToast.show("Error while updating!");
                            }.bind(this),
                        });
                    }
            },
            onChangeCalcType: function (oEvent) {
                var oContext = oEvent.getSource().mBindingInfos.selectedKey.binding.oContext.sPath;
                var aSelectedCalcType = oEvent.getParameters().selectedItem.mProperties.key;
                var oDraftInvoiceData = this.getView().getModel("oDraftInvoiceData").getProperty(oContext);
                if (aSelectedCalcType === "1") {
                    oDraftInvoiceData.BillingAmount = oDraftInvoiceData.Amount;
                } else if (aSelectedCalcType === "2") {

                } else if (aSelectedCalcType === "3") {
                    
                } else if (aSelectedCalcType === "4") {
                    
                }
                this.getView().getModel("oDraftInvoiceData").refresh();
            },
            onChangeHours: function(oEvent) {
                var oContext = oEvent.getSource().getParent().getParent().getBindingContextPath();
                var oDraftInvoiceData = this.getView().getModel("oDraftInvoiceData").getProperty(oContext);
                var hours = oEvent.getSource().getValue();
                var oNewValue = oDraftInvoiceData.UnitPrice*hours;
                    oDraftInvoiceData.BillingAmount = oNewValue;
                // this.getView().getModel().setProperty(sPath + "/Hours", oResources.Hours);
            
                this.getView().getModel("oDraftInvoiceData").refresh();
            },
            onChangeAmount: function (oEvent) {
                var oContext = oEvent.getSource().getParent().getParent().getBindingContextPath();
                var oDraftInvoiceData = this.getView().getModel("oDraftInvoiceData").getProperty(oContext);
                var value = oEvent.getSource().getValue();
                var CalcType = oDraftInvoiceData.CalcType;
                var oAmount = oDraftInvoiceData.Amount;
                if (CalcType === "1") {
                    // oDraftInvoiceData.BillingAmount = oDraftInvoiceData.Amount;
                } else if (CalcType === "2") {
                    
                    var oPercentValue = ((oAmount*value) / 100).toFixed(2);
                    oDraftInvoiceData.BillingAmount = oPercentValue;
                } else if (CalcType === "3") {

                    oDraftInvoiceData.BillingAmount = oAmount + parseInt(value);
                } else if (CalcType === "4") {
                    oDraftInvoiceData.BillingAmount = parseInt(value);
                }
                this.getView().getModel("oDraftInvoiceData").refresh();
            },
            totalFormatter: function (results) {
                return results.length;
            },
            onPrintInvoice: function () {
                this.busyDialog = new sap.m.BusyDialog({
                    title: "Loading Data",
                    text: "Retreiving PDF"
                });
                this.busyDialog.open();
                var urlToRead = '/ZTHBT0022';
                var filter = new sap.ui.model.Filter("InvoiceID", "EQ", "12345");
                var that1 = this;
                //?$expand=to_Components
                var data1;
                this.getOwnerComponent()
                    .getModel()
                    .read(urlToRead, {
                        urlParameters: {
                            "$expand": "Resources,Expense,Material"
                        },
                        filters: [filter],
                        method: "GET",
                        success: function (oData, response) {
                            console.log(oData);
                            data1 = '<?xml version="1.0" encoding="utf-8"?>' +
                                '<data>' +
                                '<INVOICENO>' + oData.results[0].InvoiceID + '</INVOICENO>' +
                                '<INVOICEDATE>' + oData.results[0].InvDate + '</INVOICEDATE>' +
                                '<RESOURCE>';

                            for (let index in oData.results[0].Resources.results) {
                                let oResources = oData.results[0].Resources.results[index];
                                data1 = data1 + '<DATA>' +
                                    '<D_INVOICE>' + oResources.InvoiceID + '</D_INVOICE>' +
                                    '<YEARMONTH>' + oResources.YearMonth + '</YEARMONTH>' +
                                    '<EMPID>' + oResources.EmpID + '</EMPID>' +
                                    '<EMPNAME>' + oResources.EmpName + '</EMPNAME>' +
                                    '<GRADE>' + oResources.Grade + '</GRADE>' +
                                    '<BELONGS>' + oResources.Belongs + '</BELONGS>' +
                                    '<CURR>' + oResources.Curr + '</CURR>' +
                                    '<UNITPRICE>' + oResources.UnitPrice + '</UNITPRICE>' +
                                    '<HOURS>' + oResources.Hours + '</HOURS>' +
                                    '<BILLINGAMOUNT>' + oResources.BillingAmount + '</BILLINGAMOUNT>' +
                                    `</DATA>`;
                            }
                            data1 = data1 + '</RESOURCE>' + '<EXPENSE>';
                            for (let index in oData.results[0].Expense.results) {
                                let oExpense = oData.results[0].Expense.results[index];
                                data1 = data1 + '<DATA>' +
                                    '<NOTE>' + oExpense.Note + '</NOTE>' +
                                    '<BILLINGAMOUNT>' + oExpense.BillingAmount + '</BILLINGAMOUNT>' +
                                    `</DATA>`;
                            }
                            data1 = data1 + '</EXPENSE>' + '<MATERIAL>';
                            for (let index in oData.results[0].Material.results) {
                                let oExpense = oData.results[0].Material.results[index];
                                data1 = data1 + '<DATA>' +
                                    '<DESCRIPTION>' + oExpense.MaterialDesc + '</DESCRIPTION>' +
                                    '<UNITPRICE>' + oExpense.UnitPrice + '</UNITPRICE>' +
                                    '<QUANTITY>' + oExpense.Quan + '</QUANTITY>' +
                                    '<BILLINGAMOUNT>' + oExpense.BillingAmount + '</BILLINGAMOUNT>' +
                                    `</DATA>`;
                            }
                            data1 = data1 + '</MATERIAL>' + '</data>';
                            var encdata1 = btoa(data1);

                            var urlToRead = '/ZAdobeService' + '?xmlData=' + encdata1;
                            that1.getOwnerComponent().getModel("zcdsehbtc0001").read(urlToRead, {
                                urlParameters: {
                                    "xmlData": encdata1,
                                    "xdpTemplate": "HODraftDocumentForm/HODraft"
                                },
                                method: "GET",
                                success: function (data, response) {
                                    console.log(data);
                                    var decodedPdfContent = atob(data.results[0].pdfFile);
                                    var byteArray = new Uint8Array(decodedPdfContent.length);
                                    for (var i = 0; i < decodedPdfContent.length; i++) {
                                        byteArray[i] = decodedPdfContent.charCodeAt(i);
                                    }
                                    var blob = new Blob([byteArray.buffer], {
                                        type: 'application/pdf'
                                    });
                                    var _pdfurl = URL.createObjectURL(blob);
                                    if (!that1._PDFViewer) {
                                        that1._PDFViewer = new sap.m.PDFViewer({
                                            width: "auto",
                                            source: _pdfurl
                                        });
                                        jQuery.sap.addUrlWhitelist("blob"); // register blob url as whitelist
                                    }
                                    that1.busyDialog.close();
                                    that1._PDFViewer.open();
                                }
                            });
                        }
                    });

            }
        });
    });
