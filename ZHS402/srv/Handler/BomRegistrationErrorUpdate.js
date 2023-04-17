
var registerBomRegisterError = function (that, cds) {
that.on('UpdateBOMStatus', async (req) => {
    var inserEntries = []; 
    for (let index = 0; index < req.data.input.update.length; index++) {
        const oInput = req.data.input.update[index];
        oInput.PROCESS_MODE = "P";
        
          const updateQuery =  UPDATE.entity('ZHS402.ZTHBT0057').data(oInput).where({ WERKS: { '=': oInput.WERKS }, E_DOC_NO: { '=': oInput.E_DOC_NO }, E_REV_NO: { '=': oInput.E_REV_NO }, PS_GROUP_NO: { '=': oInput.PS_GROUP_NO }, PS_ITEM_NO: { '=': oInput.PS_ITEM_NO }, MODEL: { '=': oInput.MODEL }, MATNR: { '=': oInput.MATNR }, SEQ_NO: { '=': oInput.SEQ_NO } }); //UPDATE('ZHS402.ZTHBT0027').with(oInput); 
          await srv.run(updateQuery);
        
    } 

    return {
        acknowledge: "Success", message: "Deleted " + req.data.input.delete.length + " entries \n"
            + "Updated " + req.data.input.update.length + " entries \n"
    }
});
}

module.exports = registerBomRegisterError;