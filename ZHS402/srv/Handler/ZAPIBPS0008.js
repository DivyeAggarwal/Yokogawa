var registerZAPIBPS0008Handler = function (that, cds) {
    
    that.on('READ', 'ZCDSEHMMC0012', async req => {
        const bupa = await cds.connect.to('ZSRVBHMM0008');
        const validFromIndex = null; 
        const validFrom = null;
        validFromIndex = req.query.SELECT.where.findIndex((filter) => filter && filter.ref && filter.ref.find((field) => field === "InputValidFrom"));
        if (validFromIndex >= 0) {
            validFrom = req.query.SELECT.where[mcode_idx + 2].val
        }
        return bupa.run(req.query).then(async (res) => {           
            for (let index = 0; index < res.length; index++) {
                const element = res[index];
                const aZTHBT003706 = await SELECT.from('ZAPIBPS0008.ZTHBT003706').where({ WERKS: { '=': element.plant }, E_TR_TYPE: { '!=': 'D' }, PARTS_QTY: { '!=': 0 }, EFFECT_D : { '<=': validFrom }, INVALID_D : { '>=': validFrom } });
                object.RoHS_info = await getROHSInfo(element.COMP_PART_NO);
                finalData.push(object);
            }
        });
    });
    that.on('READ', 'I_PlantStdVH', async req => {
        const bupa = await cds.connect.to('ZSRVBHMM0008');
        return bupa.run(req.query);
    });


    
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