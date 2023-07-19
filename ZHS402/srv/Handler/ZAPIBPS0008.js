var registerZAPIBPS0008Handler = function (that, cds) {
    
    that.on('READ', 'ZCDSEHMMC0012', async req => {
        const bupa = await cds.connect.to('ZSRVBHMM0008');
        req.query.SELECT.columns = formatProdOrderColumns(req); 
        const validFromIndex = null; 
        const validFrom = null;
        validFromIndex = req.query.SELECT.where.findIndex((filter) => filter && filter.ref && filter.ref.find((field) => field === "InputValidFrom"));
        if (validFromIndex >= 0) {
            validFrom = req.query.SELECT.where[mcode_idx + 2].val
        }
        return bupa.run(req.query).then(async (res) => {           
            for (let index = 0; index < res.length; index++) {
                const element = res[index];
                element.SEQ_NO = ( index + 1 ).toString();
                const aZTHBT003706 = await SELECT.from('ZAPIBPS0008.ZTHBT003706').where({ WERKS: { '=': element.plant }, E_TR_TYPE: { '!=': 'D' }, PARTS_QTY: { '!=': 0 }, EFFECT_D : { '<=': validFrom }, INVALID_D : { '>=': validFrom } });
                if(aZTHBT003706.length > 0){
                    element.E_DOC_TYPE = aZTHBT003706[0].E_DOC_TYPE;
                    element.E_DOC_NO = aZTHBT003706[0].E_DOC_NO;
                    element.PS_GROUP_NO = aZTHBT003706[0].PS_GROUP_NO;
                    element.PS_ITEM_NO = aZTHBT003706[0].PS_ITEM_NO;
                    element.E_REV_NO = aZTHBT003706[0].E_REV_NO;
                    element.IDATS = aZTHBT003706[0].IDATS;
                    element.PS_SYMBOL = aZTHBT003706[0].PS_SYMBOL;
                    element.SFIX_DIGIT_PTN = aZTHBT003706[0].SFIX_DIGIT_PTN;
                    element.SFIX_PTN = aZTHBT003706[0].SFIX_PTN;
                    element.PROD_CARRER = aZTHBT003706[0].PROD_CARRER;
                    element.OPTION_PTN = aZTHBT003706[0].OPTION_PTN;
                    element.EFFECT_D = aZTHBT003706[0].EFFECT_D;
                    element.INVALID_D = aZTHBT003706[0].E_DOCINVALID_D_TYPE;
                    element.CREATED_ON = aZTHBT003706[0].CREATED_ON;
                    element.CHANGED_ON = aZTHBT003706[0].CHANGED_ON;
                    element.SELECT_SIGN = aZTHBT003706[0].SELECT_SIGN;
                    element.SAFETY_SIGN = aZTHBT003706[0].SAFETY_SIGN;
                    element.ANTIEXPLODE_SIGN = aZTHBT003706[0].ANTIEXPLODE_SIGN;
                    element.EMC_SIGN = aZTHBT003706[0].EMC_SIGN;
                    element.PED_SIGN = aZTHBT003706[0].PED_SIGN;
                    element.RADIO_SIGN = aZTHBT003706[0].RADIO_SIGN;
                    element.USE_NON_COMPLAINT = aZTHBT003706[0].USE_NON_COMPLAINT;
                    element.PS_NOTE = aZTHBT003706[0].PS_NOTE;
                    element.LEVEL = aZTHBT003706[0].LEVEL;
                    element.PARTS_QTY_UNIT = aZTHBT003706[0].PARTS_QTY_UNIT;
                    element.PARTS_QTY = aZTHBT003706[0].PARTS_QTY; 
                }
                object.RoHS_info = await getROHSInfo(element.COMP_PART_NO);
                finalData.push(object);
            }
        });
    });
    that.on('READ', 'I_PlantStdVH', async req => {
        const bupa = await cds.connect.to('ZSRVBHMM0008');
        return bupa.run(req.query);
    });


    function formatProdOrderColumns(req){
        var columns = []
        req.query.SELECT.columns.forEach(element => {
            if(["SEQ_NO","ComponentDescription", "ComponentMaterialType", "E_DOC_NO", "PS_GROUP_NO", "PS_ITEM_NO",  "E_REV_NO", 
            "IDATS", "PS_SYMBOL", "SFIX_DIGIT_PTN", "SFIX_PTN", "PROD_CARRER", "OPTION_PTN", "EFFECT_D", "INVALID_D", "CREATED_ON",
            "CHANGED_ON", "InputType", "SELECT_SIGN", "SAFETY_SIGN", "ANTIEXPLODE_SIGN", "RoHS_info", "EMC_SIGN", "PED_SIGN",
            "RADIO_SIGN", "USE_NON_COMPLAINT", "PS_NOTE", "InputTypeCode", "NoOutputRepScreen", "ExplosionType", "SummaryType","InputValidFrom",
            "OutputType", "RawMaterialOutputType", "RequirementQty", "AlternativeBOM", "LEVEL", "PARTS_QTY_UNIT", "InputFIle", "OutputFile"].indexOf(element.ref[0]) === -1){
                columns.push(element);
            }
        });
        return columns;
    }
    
async function getROHSInfo(COMP_PART_NO){
    // console.log(res);
    var sROHSInfo = "";          
    var aZTHBT0060 = await SELECT.from('ZHS402.ZTHBT0060').where({
        PARTS_NO: COMP_PART_NO
    });
    if(aZTHBT0060.length > 0){
        if(aZTHBT0060[0].FILEKNRN != " " && aZTHBT0060[0].R10_SELKOMOKUNO === "2:Y" &&
        (aZTHBT0060[0].R10_KOMOKUDATA_1 === " " || ZTHBT0060[0].R10_KOMOKUDATA_1 === "Except SPACE, NA, NR")){
            sROHSInfo = "10";
        }else if(aZTHBT0060[0].FILEKNRN != " " && aZTHBT0060[0].R6_SELKOMOKUNO === "2:Y" &&
        (aZTHBT0060[0].R6_KOMOKUDATA_1 === " " || ZTHBT0060[0].R6_KOMOKUDATA_1 === "Except SPACE, NA, NR")){
            sROHSInfo = "6";
        }else{
            sROHSInfo = "";
        }
    }
    
    return sROHSInfo; 
}
}

module.exports = registerZAPIBPS0008Handler;