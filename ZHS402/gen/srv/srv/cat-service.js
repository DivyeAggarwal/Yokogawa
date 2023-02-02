// const cds = require('@sap/cds')
// const express = require("express");
// const axios = require("axios");
// const SapCfAxios = require("sap-cf-axios").default;
// const qs = require('querystring');
const SequenceHelper = require("./lib/SequenceHelper");
// const { SELECT, INSERT, UPDATE } = cds.ql
// const axios1 = SapCfAxios("dest-adsrestapi");

// module.exports = cds.service.impl(async (srv) => {
// 	const db = await cds.connect.to("db");
// 	const { ZTHBT0022 } = srv.entities;
// 	const { ZTHBT0027 } = srv.entities;
// 	const { ZCDSEHCSC0003 } = srv.entities;

// 	srv.on('READ', 'ZSCREEN1', readFunction);
// 	srv.on('READ', 'ZAdobeService', readAdobePDF);
	 
// 	// srv.on('READ', ZCDSEHCSC0003, async request => {
// 	// 	const service = await cds.connect.to('TimeSheetEntry');
// 	//  	return service.tx(request).run(request.query);
// 	//  });

// 	srv.before("CREATE", ZTHBT0022, async (context) => {
// 		const productId = new SequenceHelper({
// 			db: db,
// 			sequence: "INVOICE_ID",
// 			table: "ZTHBT0022",
// 			field: "ID"
// 		});

// 		context.data.ID = await productId.getNextNumber();
// 		var ID = context.data.ID;
// 		var currentYear = new Date().getFullYear();
// 		var convertedID = String(ID).padStart(5, "0");
// 		var InvoiceID = currentYear + "-" + convertedID;
// 		context.data.InvoiceID = InvoiceID;
// 	});

// 	srv.on('UpdatePOItem', async (req) => {	
// 		await UPSERT.into('ZHS402.ZTHBT0027').entries(req.data.input.update);
// 		for (let oDelete of req.data.input.delete) {  
// 			await DELETE.from(ZTHBT0027).where ({MBLNR:{'=':oDelete.MBLNR},ZEILE:{'=':oDelete.ZEILE},MJAHR:{'=':oDelete.MJAHR},SERNR:{'=':oDelete.SERNR}});
// 		}
// 		return {acknowledge:"Success", message: "Deleted " + req.data.input.delete.length + " entries \n" 
// 		+ "Updated " + req.data.input.update.length + " entries \n"  }
// 	});


// })

// const readFunction = async(req) => {
	
// 	const users = [{
// 		E_PARTS_NO: "",
//         YEOS_MNF_NO: "",
//         PCKG_CD: ""
// 	}]
// 	return users;
// 	// }
	
// };

// const readAdobePDF = async(req) => {
	
// 	if(req._query) {
// 	var xmlData = req._query.xmlData;
// 	var xdpTemplate = req._query.xdpTemplate;

// 	const responseCode = await axios({
// 		method: "POST",
// 		//url:"https://services.odata.org/V2/Northwind/Northwind.svc/Products",
// 		url:"https://global-dev-003.authentication.eu10.hana.ondemand.com/oauth/token",
// 		headers: { 
// 			'Authorization': 'Basic c2ItN2JmZjQxZDEtNWUwNC00MDhlLThiZjUtNzY1NTcxOWVhNWI2IWIxMTc2Njl8YWRzLXhzYXBwbmFtZSFiMTAyNDUyOlVyYkpCVWc4REcybndtaWNhYmU3ajZJdjZ1UT0=', 
// 			'Content-Type': 'application/x-www-form-urlencoded'
// 		  },
// 		data: {
// 			grant_type: "client_credentials"   
// 		  }
// 	});

// 	const token = "Bearer " + responseCode.data.access_token;
// 		const response = await axios({
// 			method: "POST",
// 			url:"https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2",
// 			params:{
// 				$format: "json"
// 			},
// 			data: {
// 				xdpTemplate: xdpTemplate,//"HODraftDocumentForm/HODraft",
// 				xmlData: xmlData,//"PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48ZGF0YT48SU5WT0lDRU5PPjEyMzQ1PC9JTlZPSUNFTk8+PFJFU09VUkNFPjxEX0lOVk9JQ0U+MTIzNDU8L0RfSU5WT0lDRT48WUVBUk1PTlRIPjIwMjI8L1lFQVJNT05USD48RU1QSUQ+MzQ1MzQ1PC9FTVBJRD48RU1QTkFNRT5EaXZ5ZTwvRU1QTkFNRT48R1JBREU+QzwvR1JBREU+PEJFTE9OR1M+ZGZkZjwvQkVMT05HUz48Q1VSUj5VU0Q8L0NVUlI+PFVOSVRQUklDRT4xMjA8L1VOSVRQUklDRT48SE9VUlM+ODwvSE9VUlM+PEJJTExJTkdBTU9VTlQ+MjAwMDA8L0JJTExJTkdBTU9VTlQ+PC9SRVNPVVJDRT48SU5WT0lDRURBVEU+MDItMDItMjAyMjwvSU5WT0lDRURBVEU+PC9kYXRhPg==",
// 				formType: "print",
// 				formLocale: "",
// 				taggedPdf: 1,
// 				embedFont: 0
// 			},
// 			headers: {
// 				Authorization: token,//"Bearer eyJhbGciOiJSUzI1NiIsImprdSI6Imh0dHBzOi8vZ2xvYmFsLWRldi0wMDMuYXV0aGVudGljYXRpb24uZXUxMC5oYW5hLm9uZGVtYW5kLmNvbS90b2tlbl9rZXlzIiwia2lkIjoiZGVmYXVsdC1qd3Qta2V5LS01NzYxMjk1NSIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI1MWJlNjI2YmUzMmY0M2FmYTk0MzcyYTk3ZTE1OTJkYSIsImV4dF9hdHRyIjp7ImVuaGFuY2VyIjoiWFNVQUEiLCJzdWJhY2NvdW50aWQiOiI1MWNiZDIyNi1jMzk5LTQ3NmEtOGQ0NS01NmM4ZjlmMDg0ODciLCJ6ZG4iOiJnbG9iYWwtZGV2LTAwMyIsInNlcnZpY2VpbnN0YW5jZWlkIjoiN2JmZjQxZDEtNWUwNC00MDhlLThiZjUtNzY1NTcxOWVhNWI2In0sInN1YiI6InNiLTdiZmY0MWQxLTVlMDQtNDA4ZS04YmY1LTc2NTU3MTllYTViNiFiMTE3NjY5fGFkcy14c2FwcG5hbWUhYjEwMjQ1MiIsImF1dGhvcml0aWVzIjpbInVhYS5yZXNvdXJjZSIsImFkcy14c2FwcG5hbWUhYjEwMjQ1Mi5UZW1wbGF0ZVN0b3JlQ2FsbGVyIiwiYWRzLXhzYXBwbmFtZSFiMTAyNDUyLkFEU0NhbGxlciJdLCJzY29wZSI6WyJ1YWEucmVzb3VyY2UiLCJhZHMteHNhcHBuYW1lIWIxMDI0NTIuVGVtcGxhdGVTdG9yZUNhbGxlciIsImFkcy14c2FwcG5hbWUhYjEwMjQ1Mi5BRFNDYWxsZXIiXSwiY2xpZW50X2lkIjoic2ItN2JmZjQxZDEtNWUwNC00MDhlLThiZjUtNzY1NTcxOWVhNWI2IWIxMTc2Njl8YWRzLXhzYXBwbmFtZSFiMTAyNDUyIiwiY2lkIjoic2ItN2JmZjQxZDEtNWUwNC00MDhlLThiZjUtNzY1NTcxOWVhNWI2IWIxMTc2Njl8YWRzLXhzYXBwbmFtZSFiMTAyNDUyIiwiYXpwIjoic2ItN2JmZjQxZDEtNWUwNC00MDhlLThiZjUtNzY1NTcxOWVhNWI2IWIxMTc2Njl8YWRzLXhzYXBwbmFtZSFiMTAyNDUyIiwiZ3JhbnRfdHlwZSI6ImNsaWVudF9jcmVkZW50aWFscyIsInJldl9zaWciOiIyODAwOTQzOCIsImlhdCI6MTY3MDkyOTQyOSwiZXhwIjoxNjcwOTcyNjI5LCJpc3MiOiJodHRwczovL2dsb2JhbC1kZXYtMDAzLmF1dGhlbnRpY2F0aW9uLmV1MTAuaGFuYS5vbmRlbWFuZC5jb20vb2F1dGgvdG9rZW4iLCJ6aWQiOiI1MWNiZDIyNi1jMzk5LTQ3NmEtOGQ0NS01NmM4ZjlmMDg0ODciLCJhdWQiOlsic2ItN2JmZjQxZDEtNWUwNC00MDhlLThiZjUtNzY1NTcxOWVhNWI2IWIxMTc2Njl8YWRzLXhzYXBwbmFtZSFiMTAyNDUyIiwidWFhIiwiYWRzLXhzYXBwbmFtZSFiMTAyNDUyIl19.xBIy7nfcAiNlk-q3jASMDyTDEyF3EMZ3QZpKJHAUA9_540hE2Lza-qlcbky_-sI8ORvxvL6FHNlG_ZLJT0DxTrnyq-ISHgr-EV2MCmpR2EmItUPn47tGr8wKrjjjq3NNHhfMSBqAjwJ8Uyg60hu6sYn_t4xldp3ovJt9LCpBuRJ0UaclJQOzedRz1m1UouUb9cYDPgDGtyJUiF37wMlsXznsHy2f_0CAennqdRJqE9g9ZNEd7Bf8LeEjC7NZQVlB_eUkF5jgtEB7G9t5hcKP4-eAZ4iSDbyhq32DfaDVeBjwaaqU3oIoasHGrrk1K-Ciad6_dCkHGO9KGCKs0Q5Vmw",
// 				accept: "application/json"
// 			}
// 		});
	
// 	const pdf = [{
// 		pdfFile: response.data.fileContent,
// 		Message: "Success"
// 	}]
// 	return pdf;
// 	} else {
// 		const pdf = [{
// 			pdfFile: "",
// 			Message: "No XML Data"
// 		}]
// 	}
	
// };

const cds = require('@sap/cds');
const { SELECT, INSERT, UPDATE } = cds.ql

module.exports = cds.service.impl(async function() {

    this.on('READ', 'AccountingIndicator', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    this.on('READ', 'I_StatisticalKeyFigureText', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    this.on('READ', 'ServiceOrderItem', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    this.on('READ', 'ServiceOrder', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    this.on('READ', 'InternalOrder', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    this.on('READ', 'ReceiverWBS', async req => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        return bupa.run(req.query);
    });
    
    this.on('READ', 'ZTHBT0019', async req => {
        const db = await cds.connect.to('db');
        var oData = await db.run(req.query);
        return oData;
    });


    this.on('UpdatePOItem', async (req) => {
        const bupa = await cds.connect.to('TimeSheetEntry');
        if(req.data.input.update.length > 0){	
        await UPSERT.into('ZHS402.ZTHBT0027').entries(req.data.input.update);
        }
        for (let oDelete of req.data.input.delete) {  
            await DELETE.from('ZHS402.ZTHBT0027').where ({MBLNR:{'=':oDelete.MBLNR},ZEILE:{'=':oDelete.ZEILE},MJAHR:{'=':oDelete.MJAHR},SERNR:{'=':oDelete.SERNR}});
        }
        return {acknowledge:"Success", message: "Deleted " + req.data.input.delete.length + " entries \n" 
        + "Updated " + req.data.input.update.length + " entries \n"  }
   });

   this.before('CREATE', 'ZTHBT0022', async (context) => {
    		const productId = new SequenceHelper({
    			db: db,
    			sequence: "INVOICE_ID",
    			table: "ZTHBT0022",
    			field: "ID"
    		});
    
    		context.data.ID = await productId.getNextNumber();
    		var ID = context.data.ID;
    		var currentYear = new Date().getFullYear();
    		var convertedID = String(ID).padStart(5, "0");
    		var InvoiceID = currentYear + "-" + convertedID;
    		context.data.InvoiceID = InvoiceID;
    	});

    this.after('CREATE', 'ZTHBT0033', async (context) => {
        var MSCODE = context.data.MSCODE;
        var PRODUCTCAREER = context.data.PRODUCTCAREER;
        var INSTRUMENTMODEL = context.data.INSTRUMENTMODEL;
        var PARTSNUMBER = context.data.PARTSNUMBER;
        var MODEL = context.data.MODEL;
        var PPLFLAG = context.data.PPLLAG;
        // var value = "";
        const mscode = await SELECT.from('ZHS402.ZTHBT0048').where({
            MSCODE: context.data.MSCODE,
            PRODUCTCAREER: context.data.PRODUCTCAREER,
            INSTRUMENTMODEL: context.data.INSTRUMENTMODEL,
            PARTSNUMBER: context.data.PARTSNUMBER,
            MODEL:context.data.MODEL,
        })
        // var value = await SELECT.from('ZHS402.ZTHBT0032').where({ MSCODE: { '=': MSCODE }, PRODUCTCAREER: { '=': PRODUCTCAREER }, INSTRUMENTMODEL: { '=': INSTRUMENTMODEL }, PARTSNUMBER: { '=': PARTSNUMBER }, -: { '=': MODEL } })
        if (mscode.length > 0) {
            return;
        } else {
            if (PPLFLAG == "X") {
                //PPL
                const mcodeId = new SequenceHelper({
                    db: db,
                    sequence: "MATERIALCODE_ID",
                    table: "ZTHBT0048",
                    field: "ID"
                });
                var ID = await mcodeId.getNextNumber();
                var convertedID = String(ID).padStart(9, "0");
                var MaterialCode = MODEL + "_" + convertedID;
                    var conversion = {
                        ID: ID,
                        MSCODE: MSCODE,
                        PRODUCTCAREER: PRODUCTCAREER,
                        INSTRUMENTMODEL: INSTRUMENTMODEL,
                        PARTSNUMBER: PARTSNUMBER,
                        MODEL: MODEL,
                        MATERIALCODE: MaterialCode,
                        TOKUCHUFLAG: ""
                    };
                    await UPSERT.into('ZHS402.ZTHBT0048').entries(conversion);
            }
            if (MSCODE) {
                const mcodeId = new SequenceHelper({
                    db: db,
                    sequence: "MATERIALCODE_ID",
                    table: "ZTHBT0048",
                    field: "ID"
                });
                var ID = await mcodeId.getNextNumber();
                var convertedID = String(ID).padStart(9, "0");

                let checkZ = MSCODE.includes('Z');
                if (checkZ == false) {
                    //Normal scenario
                    var MaterialCode = MODEL + "_F" + convertedID;
                    var conversion = {
                        ID: ID,
                        MSCODE: MSCODE,
                        PRODUCTCAREER: PRODUCTCAREER,
                        INSTRUMENTMODEL: INSTRUMENTMODEL,
                        PARTSNUMBER: PARTSNUMBER,
                        MODEL: MODEL,
                        MATERIALCODE: MaterialCode,
                        TOKUCHUFLAG: ""
                    };
                    await UPSERT.into('ZHS402.ZTHBT0048').entries(conversion);

                } else if (checkZ == true && INSTRUMENTMODEL === "" && PARTSNUMBER === "") {
                    //Tokuchu Product
                    var MaterialCode = MODEL + "_Z" + convertedID;
                    var conversion = {
                        ID: ID,
                        MSCODE: MSCODE,
                        PRODUCTCAREER: PRODUCTCAREER,
                        INSTRUMENTMODEL: INSTRUMENTMODEL,
                        PARTSNUMBER: PARTSNUMBER,
                        MODEL: MODEL,
                        MATERIALCODE: MaterialCode,
                        TOKUCHUFLAG: "X"
                    };
                    await UPSERT.into('ZHS402.ZTHBT0048').entries(conversion);
                } else if (checkZ == true && INSTRUMENTMODEL !== "" && PARTSNUMBER !== "") {
                    //Tokuchu Parts
                    var MaterialCode = PARTSNUMBER + "_" + convertedID;
                    var conversion = {
                        ID: ID,
                        MSCODE: MSCODE,
                        PRODUCTCAREER: PRODUCTCAREER,
                        INSTRUMENTMODEL: INSTRUMENTMODEL,
                        PARTSNUMBER: PARTSNUMBER,
                        MODEL: MODEL,
                        MATERIALCODE: MaterialCode,
                        TOKUCHUFLAG: "X"
                    };
                    await UPSERT.into('ZHS402.ZTHBT0048').entries(conversion);
                }
            }
        }
    });

//    this.on('CreateMaterialCode', async (req) => {
//     if(req.data.input.data.length > 0){	
//     await UPSERT.into('ZHS402.ZTHBT0033').entries(req.data.input.data);
//     }
//     var data = req.data.input.data;
//     var value = await SELECT.from('ZHS402.ZTHBT0032').where ({MSCODE:{'=':data.MSCODE},PRODUCTCAREER:{'=':data.PRODUCTCAREER},INSTRUMENTMODEL:{'=':data.INSTRUMENTMODEL},PARTSNUMBER:{'=':data.PARTSNUMBER},MODEL:{'=':data.MODEL}})
//     if(value){
//         return {acknowledge:"Error", message: "Data Already Exist"  }
//     } else {
//         if(data.PPLFlag == "X") {
//             //PPL
//         }
//         if(data.MSCODE) {
//             let checkZ = data.MSCODE.includes('Z');
//             if(checkZ == false) {
//                 //Normal
//             } else if(checkZ == true && data.INSTRUMENTMODEL === "" && data.PARTSNUMBER === "") {
//                 //Tokuchu Product
//             } else if (checkZ == true && data.INSTRUMENTMODEL !== "" && data.PARTSNUMBER !== "") {
//                 //Tokuchu Parts
//             }
//         }

//     }
//     for (let oDelete of req.data.input.delete) {  
//         await DELETE.from('ZHS402.ZTHBT0027').where ({MBLNR:{'=':oDelete.MBLNR},ZEILE:{'=':oDelete.ZEILE},MJAHR:{'=':oDelete.MJAHR},SERNR:{'=':oDelete.SERNR}});
//     }
//     return {acknowledge:"Success", message: "Deleted " + req.data.input.delete.length + " entries \n" 
//     + "Updated " + req.data.input.update.length + " entries \n"  }
// });

});