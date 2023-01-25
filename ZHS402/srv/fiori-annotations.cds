using ZCDSEHBTC0001 from './cat-service';
using ZCDSEHBTC0002 from './cat-service';
using ZCDSEHBTC0003 from './cat-service';
using { CatalogService.ZCDSEHCSC0003 as ZCDSEHCSC0003} from './cat-service';


annotate ZCDSEHBTC0001.ZSCREEN1 @(Capabilities : {
    // SearchRestrictions : {
    //     $Type      : 'Capabilities.SearchRestrictionsType',
    //     Searchable : true
    // },
    Insertable         : true,
    Deletable          : true,
    Updatable          : true
});

annotate ZCDSEHBTC0001.ZTHBT0005 @(Capabilities : {
    // SearchRestrictions : {
    //     $Type      : 'Capabilities.SearchRestrictionsType',
    //     Searchable : true
    // },
    Insertable         : true,
    Deletable          : true,
    Updatable          : true
});
annotate ZCDSEHBTC0001.ZTHBT0005 {
    E_PARTS_NO      @sap.insertable:true;
  E_PARTS_NO      @sap.updatable:true ;
  E_PARTS_NO      @sap.Label:'ddaad' ;
}
annotate  ZCDSEHBTC0003.ZTHBT0020 with @(
    UI: {
        HeaderInfo: {
            TypeName: '',
            TypeNamePlural: 'Task Code',
            Title: { Value: ZTcode },
            Description: { Value: ZTcds }
        },
        SelectionFields: [ ZTcode,ZTcds,ZObject,Kokrs ],
        LineItem: [
            { Value: ZTcode },
            { Value: ZTcds },
            { Value: ZObject },
            { Value: Kokrs }             
        ],
        Facets: [
            {
                $Type: 'UI.CollectionFacet',
                Label: 'Task Code',
                Facets: [
                    {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#MainTC', Label: 'Task Code'}
                ]
            }
        ],        
        FieldGroup#MainTC: {
            Data: [
                { Value: ZTcode },
                { Value: ZTcds },
                { Value: ZObject },
                { Value: Kokrs }               
            ]
        }
    }
);

        

annotate ZCDSEHBTC0003.ZTHBT0019 {
    @(Common : {
           Label        : 'Accounting Indicator',
            ValueList    : {
                CollectionPath : 'ZCDSEHCSC0003',
                Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : BEMOT,
                    ValueListProperty : 'AccountingIndicator'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'AcctIndDescription'
                }
                ]
            }
        })
        BEMOT;
}

annotate ZCDSEHBTC0003.ZTHBT0019 with @odata.draft.enabled;

annotate  ZCDSEHBTC0003.ZTHBT0019 with @(
    UI: {
        HeaderInfo: {
            TypeName: '',
            TypeNamePlural: 'Assignments',
            Title: { Value: ZPname },
            Description: { Value: ZPname }
        },
        SelectionFields: [ Kokrs,ZPname,ZPfdt,ZPtdt,Werks ],
        LineItem: [
            { Value: ZPname },
            { Value: ZPfdt },
            { Value: ZPtdt },
            { Value: Werks },
            { Value: Stagr },
            { Value: Posid },
            { Value: EAUFNR },
            { Value: Kokrs },
            { Value: Arbpl },
            { Value: ZTcode.ZTcode },
            { Value: SKostl },
            { Value: EKostl },
            { Value: LStar },
            { Value: BEMOT },
            { Value: ObjectId },
            { Value: Kostl },
            { Value: ZCrtOn },
            { Value: ZCrtBy },
            { Value: ZChnOn },
            { Value: ZChnBy },
            { Value: Begda },
            { Value: Endda },
            { Value: Zests },
            { Value: Zpsts }            
        ],
        Facets: [
            {
                $Type: 'UI.CollectionFacet',
                Label: 'Assignment Details',
                Facets: [
                    {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#MainAs', Label: 'Assignment'}
                ]
            }
        ],        
        FieldGroup#MainAs: {
            Data: [
               { Value: ZPname },
            { Value: ZPfdt },
            { Value: ZPtdt },
            { Value: Werks },
            { Value: Stagr },
            { Value: Posid },
            { Value: EAUFNR },
            { Value: Kokrs },
            { Value: Arbpl },
            { Value: ZTcode.ZTcode },
            { Value: SKostl },
            { Value: EKostl },
            { Value: LStar },
            { Value: BEMOT },
            { Value: ObjectId },
            { Value: Kostl },
            { Value: ZCrtOn },
            { Value: ZCrtBy },
            { Value: ZChnOn },
            { Value: ZChnBy },
            { Value: Begda },
            { Value: Endda },
            { Value: Zests },
            { Value: Zpsts }                
            ]
        }
    }
){
    
};

annotate ZCDSEHBTC0002.ZTHBT0022 with @(
    UI : { 
        SelectionFields  : [
            InvoiceID,CompanyCode,ProjectID
        ],
        LineItem  : [
            { Value : InvoiceID },
            { Value : CompanyCode }, 
            { Value : ProjectID },
            { Value : InvDate }                                   
        ],
     }
){
    InvoiceID @( title: 'Invoice ID' );    
    CompanyCode @( title: 'Company Code' );
    ProjectID @( title: 'Project Definition' );
    InvDate @( title: 'Invoice Date' )
};




