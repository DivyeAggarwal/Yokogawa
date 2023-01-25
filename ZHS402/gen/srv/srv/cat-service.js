// const cds = require('@sap/cds')
// const express = require("express");
// const axios = require("axios");
// const SapCfAxios = require("sap-cf-axios").default;
// const qs = require('querystring');
// const SequenceHelper = require("./lib/SequenceHelper");
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

    const bupa = await cds.connect.to('TimeSheetEntry');

    this.on('READ', 'ZCDSEHCSC0003', async req => {
        return bupa.run(req.query);
    });
    this.on('UpdatePOItem', async (req) => {
        if(req.data.input.update.length > 0){	
        await UPSERT.into('ZHS402.ZTHBT0027').entries(req.data.input.update);
        }
        for (let oDelete of req.data.input.delete) {  
            await DELETE.from('ZHS402.ZTHBT0027').where ({MBLNR:{'=':oDelete.MBLNR},ZEILE:{'=':oDelete.ZEILE},MJAHR:{'=':oDelete.MJAHR},SERNR:{'=':oDelete.SERNR}});
        }
        return {acknowledge:"Success", message: "Deleted " + req.data.input.delete.length + " entries \n" 
        + "Updated " + req.data.input.update.length + " entries \n"  }
   });

});