using ZCDSEHBTC0001 from './cat-service';
using ZCDSEHBTC0002 from './cat-service';
using ZCDSEHBTC0003 from './cat-service';
using ZAPIBPS0001 from './cat-service';

using { CatalogService.ZCDSEHCSC0003 as ZCDSEHCSC0003} from './cat-service';


// annotate ZCDSEHBTC0001.ZSCREEN1 @(Capabilities : {
//     // SearchRestrictions : {
//     //     $Type      : 'Capabilities.SearchRestrictionsType',
//     //     Searchable : true
//     // },
//     Insertable         : true,
//     Deletable          : true,
//     Updatable          : true
// });

// annotate ZCDSEHBTC0001.ZTHBT0005 @(Capabilities : {
//     // SearchRestrictions : {
//     //     $Type      : 'Capabilities.SearchRestrictionsType',
//     //     Searchable : true
//     // },
//     Insertable         : true,
//     Deletable          : true,
//     Updatable          : true
// });
// annotate ZCDSEHBTC0001.ZTHBT0005 {
//     E_PARTS_NO      @sap.insertable:true;
//   E_PARTS_NO      @sap.updatable:true ;
//   E_PARTS_NO      @sap.Label:'ddaad' ;
// }
annotate  ZCDSEHBTC0003.ZTHBT0020 with @(
    UI: {
        HeaderInfo: {
            TypeName: '',
            TypeNamePlural: 'Task Code',
            Title: { Value: ZTCODE },
            Description: { Value: ZTCDS }
        },
        SelectionFields: [ ZTCODE,ZTCDS,ZOBJECT,KOKRS ],
        LineItem: [
            { Value: ZTCODE },
            { Value: ZTCDS },
            { Value: ZOBJECT },
            { Value: KOKRS }             
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
                { Value: ZTCODE },
                { Value: ZTCDS },
                { Value: ZOBJECT },
                { Value: KOKRS }               
            ]
        }
    }
);

        

annotate ZCDSEHBTC0003.ZTHBT0019 {
    @(Common : {
            Label        : 'Accounting Indicator',
            ValueListForValidation: '',
            ValueList    : {
                CollectionPath : 'AccountingIndicator',
                Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : BEMOT,
                    ValueListProperty : 'AccountingIndicator'
                },
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ACINDICATORDESC,
                    ValueListProperty : 'AcctIndDescription'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Language'
                }
                ]
            }
        })
        BEMOT;
     @(Common : {
           Label        : 'Statistical Key Figure',
            ValueList    : {
                CollectionPath : 'I_StatisticalKeyFigureText',
                Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : STAGR,
                    ValueListProperty : 'StatisticalKeyFigure'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'StatisticalKeyFigureName'
                }
                ]
            }
        })
        STAGR;
         @(Common : {
           Label        : 'Service Order',
            ValueList    : {
                CollectionPath : 'ServiceOrder',
                Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : OBJECT_ID,
                    ValueListProperty : 'object_id'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description_h'
                }
                ]
            }
        })
        OBJECT_ID;
         @(Common : {
           Label        : 'Internal Order',
            ValueList    : {
                CollectionPath : 'InternalOrder',
                Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : EAUFNR,
                    ValueListProperty : 'aufnr'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'ktext'
                }
                ]
            }
        })
        EAUFNR;
        @(Common : {
           Label        : 'Receiver WBS',
            ValueList    : {
                CollectionPath : 'ReceiverWBS',
                Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : RWBS,
                    ValueListProperty : 'WBSId'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'ProjectId'
                },
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : RWBSDESC,
                    ValueListProperty : 'ProjectDesc'
                }
                ]
            }
        })
        RWBS;
         @(Common : {
           Label        : 'Parent WBS',
            ValueList    : {
                CollectionPath : 'ParentWBS',
                Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PWBS,
                    ValueListProperty : 'ParentWBS'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'ReceiverProjDesc'
                },
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PARENTWBSDESC,
                    ValueListProperty : 'ParentProjDesc'
                },
                {
                    $Type             : 'Common.ValueListParameterIn',
                    ValueListProperty : 'ReceiverWBS',
                    LocalDataProperty : RWBS,
                }
                ]
            }
        })
        PWBS;
        @(Common : {
           Label        : 'Service Order Item',
            ValueList    : {
                CollectionPath : 'ServiceOrderItem',
                Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : OBJECT_ID,
                    ValueListProperty : 'object_id'
                },
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : SERVICEORDERITEM,
                    ValueListProperty : 'number_int'
                },
                {
                    $Type             : 'Common.ValueListParameterOut',
                    LocalDataProperty : SERVORDERITEMDESC,
                    ValueListProperty : 'description_i'
                },
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : EAUFNR,
                    ValueListProperty : 'InternalOrder'
                },
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : BEMOT,
                    ValueListProperty : 'ac_indicator'
                }
                ]
            }
        })
        SERVICEORDERITEM;
        @(Common : {
           Label        : 'Receiver Cost Center',
            ValueList    : {
                CollectionPath : 'ReceiverCostCenter',
                Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : EKOSTL,
                    ValueListProperty : 'CostCenter'
                },
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : COSTCENTERNAME,
                    ValueListProperty : 'CostCenterName'
                }
                ]
            }
        })
        EKOSTL;
         @(Common : {
           Label        : 'Task Codes',
            ValueList    : {
                CollectionPath : 'ZTHBT0020',
                Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ZTCODE_ZTCODE,
                    ValueListProperty : 'ZTCODE'
                },
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ZTCDS,
                    ValueListProperty : 'ZTCDS'
                }
                ]
            }
        })
        ZTCODE;
}


annotate  ZCDSEHBTC0003.ZTHBT0019 with @(
    UI: {
        HeaderInfo: {
            TypeName: '',
            TypeNamePlural: 'Assignments',
            Title: { Value: ZPNAME },
            Description: { Value: ZPNAME }
        },
        SelectionFields: [ ZPNAME,ZPFDT,ZPTDT ],
        LineItem: [
            { Value: ZPNAME },
            { Value: ZPFDT },
            { Value: ZPTDT },
            { Value: STAGR },
            { Value: EAUFNR },
            { Value: ZTCODE.ZTCODE },
            { Value: EKOSTL },
            { Value: BEMOT },
            { Value: OBJECT_ID},
            { Value: BEGDA },
            { Value: ENDDA },
            { Value: ZESTA },
            { Value: ZPSTS } ,
            { Value: COSTCENTERNAME}           
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
               { Value: ZPNAME },
            { Value: ZPFDT},
            { Value: ZPTDT },
            { Value: STAGR },
            { Value: EAUFNR },
            { Value: ZTCODE.ZTCODE },
            { Value: EAUFNR },
            { Value: BEMOT },
            { Value: OBJECT_ID },
            { Value: BEGDA },
            { Value: EKOSTL },
            { Value: ZESTA },
            { Value: ZPSTS },
            { Value: COSTCENTERNAME,![@Common.FieldControl] : #ReadOnly},
            { Value: ACINDICATORDESC,![@Common.FieldControl] : #ReadOnly},
            { Value: SERVICEORDERITEM,![@Common.FieldControl] : #ReadOnly},
            { Value: SERVORDERITEMDESC,![@Common.FieldControl] : #ReadOnly},
            { Value: PARENTWBSDESC,![@Common.FieldControl] : #ReadOnly},
            { Value: RWBSDESC,![@Common.FieldControl] : #ReadOnly},
            { Value: ZTCODE.ZTCDS,![@Common.FieldControl] : #ReadOnly},
            { Value: ENDDA},
            { Value: ZPS_IDENTIFIER}          
            ]
        }
    }
){
    
};

annotate ZCDSEHBTC0002.ZTHBT0022 with @(
    UI : { 
        SelectionFields  : [
            INVOICEID,COMPANYCODE,PROJECTID
        ],
        LineItem  : [
            { Value : INVOICEID },
            { Value : COMPANYCODE }, 
            { Value : PROJECTID },
            { Value : INVDATE }                                   
        ],
     }
){
    INVOICEID @( title: 'Invoice ID' );    
    COMPANYCODE @( title: 'Company Code' );
    PROJECTID @( title: 'Project Definition' );
    INVDATE @( title: 'Invoice Date' )
};
//Labels
annotate ZSRVBHPS0008Service.ZCDSEHPSC0005 with {
    mblnr       @title : 'Material Document';
    mjahr       @title : 'Material Doc. Year';
    zeile       @title : 'Material Doc.Item';
    pspnr       @title : 'WBS Element';
    sernr       @title : 'Serial Number';
    posid       @title : 'WBS Element';
    pbukr       @title : 'Company code';
    matnr       @title : 'Material';
    erfmg       @title : 'Quantity';
    kdauf       @title : 'Sales Order';
    kdpos       @title : 'Sales order item';
    cpudt       @title : 'Entry Date';
    ERFME       @title : 'Unit of entry';
    ebeln       @title : 'Purchase Order';
    ebelp       @title : 'PO Item';
    smbln       @title : 'Material Document';
    smblp       @title : 'Material Doc.Item';
    sjahr       @title : 'Material Doc.Year';
    zz1_mscode_prd       @title : 'MS Code';
    idnlf       @title : 'Supplier Mat. No.';
    obknr       @title : 'Object list number';
    Xmblnr       @title : 'Reversal Material Document';
    xmjahr       @title : 'Reversal Material Doc.Item';
    xzeile       @title : 'Reversal Material Doc.Year';
    cpsphi       @title : 'WBS Element Short';
    cps_psp_pnr       @title : 'WBS Element Long';
    psphi       @title : 'Current number of the appropriate project';
    ps_psp_pnr       @title : 'Work Breakdown Structure Element (Stock Identifier)';
}
// hidden fields
annotate ZSRVBHPS0008Service.ZCDSEHPSC0005 with {
    posid       @UI.Hidden;
    ps_psp_pnr  @UI.Hidden;
    smbln       @UI.Hidden;
    smblp       @UI.Hidden;
    sjahr       @UI.Hidden;
    obknr       @UI.Hidden;
    pspnr       @UI.Hidden;
    psphi       @UI.Hidden;
}
// List report 
annotate ZSRVBHPS0008Service.ZCDSEHPSC0005 with @(UI : {
    HeaderInfo      : {
        TypeName       : 'Create Purchase Item Record',
        TypeNamePlural : 'Create Purchase Item Records',
        Title          : {Value : 'Create Purchase Item Record'},
        Description    : {Value : 'Create Purchase Item Record'}
    },
    SelectionFields : [
        pbukr,
        cpsphi,
        cps_psp_pnr,
        zz1_mscode_prd,
        cpudt
    ],
    LineItem        : [
        {Value : mblnr },
        {Value : mjahr },
        {Value : zeile },
        {Value : sernr },
        {Value : pbukr },
        {Value : matnr },
        {Value : erfmg },
        {Value : kdauf },
        {Value : kdpos },
        {Value : cpudt },
        {Value : ERFME },
        {Value : ebeln },
        {Value : ebelp },
        {Value : zz1_mscode_prd },
        {Value : idnlf },
        {Value : Xmblnr },
        {Value : xmjahr },
        {Value : xzeile },
        {Value : cpsphi },
        {Value : cps_psp_pnr }
    ],
}) {

};
//Valuehelp
annotate ZSRVBHPS0008Service.ZCDSEHPSC0005 {
    @(Common : {
        Label     : 'Company code',
        ValueList : {
            CollectionPath : 'ZCDSEHPSB0004',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : pbukr,
                    ValueListProperty : 'CompanyCode'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'CompanyCodeDesc'
                }
            ]
        }
    })
    pbukr;
    @(Common : {
        Label     : 'WBS element',
        ValueList : {
            CollectionPath : 'ZCDSEHPSB0038',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : cps_psp_pnr,
                    ValueListProperty : 'cps_psp_pnr'
                }
            ]
        }
    })
    cps_psp_pnr;
    @(Common : {
        Label     : 'Project Definition',
        ValueList : {
            CollectionPath : 'ZCDSEHPSB0037',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : cpsphi,
                    ValueListProperty : 'cpsphi'
                }
            ]
        }
    })
    cpsphi;
    @(Common : {
        Label     : 'MS Code',
        ValueList : {
            CollectionPath : 'ZCDSEHSDB0013',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : zz1_mscode_prd,
                    ValueListProperty : 'zz1_mscode_prd'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'matnr'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'mtart'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'atwrt'
                }
            ]
        }
    })
    zz1_mscode_prd;
}
annotate ZCDSEHBTC0007.BOMDisplay with {
            E_REV_NO  @title : 'Document Revision';
            PS_GROUP_NO  @title : 'Group Number';
}
annotate ZCDSEHBTC0007.BOMDisplay with @(
    UI : { 
        SelectionFields  : [
            WERKS,E_DOC_NO,E_REV_NO,PS_GROUP_NO
        ],
        LineItem  : [
            { Value : E_DOC_TYPE },
            { Value : E_DOC_NO }, 
            { Value : E_REV_NO },
            { Value : PS_GROUP_NO },
            { Value : FORMALIZE_DATE },
            { Value : CREATION_DATE }                                         
        ],
     }
){
};
annotate ZCDSEHBTC0007.BOMDisplay with @(Capabilities : {
    FilterRestrictions : {
        $Type              : 'Capabilities.FilterRestrictionsType',
        RequiredProperties : [
            WERKS,
            E_DOC_NO
        ],
    }
});
// annotate ZCDSEHBTC0007.BOMDisplay with {
// E_DOC_TYPE @UI.HiddenFilter: true;
// }
// annotate ZCDSEHBTC0007.BOMDisplay with {
//     WERKS @(
//            Common.ValueList : {
//             Label           : 'Consequence',
//             CollectionPath  : 'VL_SH_H_T001',
//             SearchSupported : false,
//             Parameters      : [
//                 {
//                     $Type             : 'Common.ValueListParameterInOut',
//                     ValueListProperty : 'BUKRS',
//                     LocalDataProperty : WERKS,
//                     ![@Common.Label] : 'tPlant',
//                 },
//                 {
//                     $Type             : 'Common.ValueListParameterDisplayOnly',
//                     ValueListProperty : 'BUTXT'
                 
//                 }    
//             ]
//         });
// };

annotate ZCDSEHBTC0007.BOMDisplay {
    @(Common : {
        Label     : 'Plant',
        ValueList : {
            CollectionPath : 'VL_SH_H_T001',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : WERKS,
                    ValueListProperty : 'BUKRS'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'BUTXT'
                }
            ]
        }
    })
    WERKS;
}

annotate ZCDSEHBTC0007.BOMDisplay {
    @(Common : {
        Label     : 'Document number',
        ValueList : {
            Label: 'DOC Type/Doc No',
            CollectionPath : 'DOC_NO_HELP',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : E_DOC_NO,
                    ValueListProperty : 'E_DOC_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_REV_NO'
                }
                ,
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MEDAI_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'YEOS_MODEL_GROUP'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'FZ2_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'REV_SBJCT'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MODIFY_CAUSE_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'APPLY_DATE_N'
                }


            ]
        },
        ValueList #MainModel : {
            Label: 'Main Model/FZ2 No',
            CollectionPath : 'MAIN_MODEL_HELP',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : E_DOC_NO,
                    ValueListProperty : 'FZ2_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'YEOS_MODEL_GROUP'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_REV_NO'
                }
                ,
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MEDAI_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'REV_SBJCT'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MODIFY_CAUSE_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'APPLY_DATE_N'
                }
            ]
        }
    })
    E_DOC_NO;
}

annotate ZCDSEHBTC0007.DOC_NO_HELP with @(
    UI : { 
        SelectionFields  : [
            E_DOC_TYPE,E_DOC_NO
        ],
        LineItem  : [
            { Value : E_DOC_TYPE },
            { Value : E_DOC_NO }, 
            { Value : E_REV_NO },
            { Value : E_DOC_N },
            { Value : MEDAI_TYPE },
            { Value : YEOS_MODEL_GROUP },
            { Value : FZ2_NO },
            { Value : REV_SBJCT },
            { Value : MODIFY_CAUSE_N },
            { Value : APPLY_DATE_N },                                        
        ],
     }
){
};
annotate ZCDSEHBTC0007.MAIN_MODEL_HELP with @(
    UI : { 
        SelectionFields  : [
            FZ2_NO,YEOS_MODEL_GROUP
        ],
        LineItem  : [
            { Value : E_DOC_TYPE },
            { Value : E_DOC_NO }, 
            { Value : E_REV_NO },
            { Value : E_DOC_N },
            { Value : MEDAI_TYPE },
            { Value : YEOS_MODEL_GROUP },
            { Value : FZ2_NO },
            { Value : REV_SBJCT },
            { Value : MODIFY_CAUSE_N },
            { Value : APPLY_DATE_N },                                        
        ],
     }
){
};
annotate ZCDSEHBTC0007.DOC_NO_HELP with {
E_REV_NO @UI.HiddenFilter: true;
E_DOC_N @UI.HiddenFilter: true;
MEDAI_TYPE @UI.HiddenFilter: true;
YEOS_MODEL_GROUP @UI.HiddenFilter: true;
FZ2_NO @UI.HiddenFilter: true;
REV_SBJCT @UI.HiddenFilter: true;
MODIFY_CAUSE_N @UI.HiddenFilter: true;
APPLY_DATE_N @UI.HiddenFilter: true;
}



annotate ZCDSEHBTC0007.MAIN_MODEL_HELP with {
E_REV_NO @UI.HiddenFilter: true;
E_DOC_N @UI.HiddenFilter: true;
MEDAI_TYPE @UI.HiddenFilter: true;
E_DOC_NO @UI.HiddenFilter: true;
E_DOC_TYPE @UI.HiddenFilter: true;
REV_SBJCT @UI.HiddenFilter: true;
MODIFY_CAUSE_N @UI.HiddenFilter: true;
APPLY_DATE_N @UI.HiddenFilter: true;
}

////Formalize
annotate ZCDSEHBTC0007.Formalize with @(
    UI : { 
        SelectionFields  : [
            WERKS,E_DOC_NO
        ],
        LineItem  : [
            { Value : E_DOC_TYPE },
            { Value : E_DOC_NO }, 
            { Value : E_REV_NO },
            { Value : PS_GROUP_NO },
            { Value : FORMALIZE_DATE },
            { Value : CREATION_DATE }                                         
        ],
     }
){
};
annotate ZCDSEHBTC0007.Formalize with @(Capabilities : {
    FilterRestrictions : {
        $Type              : 'Capabilities.FilterRestrictionsType',
        RequiredProperties : [
            WERKS,
            E_DOC_NO
        ],
    }
});
// annotate ZCDSEHBTC0007.BOMDisplay with {
// E_DOC_TYPE @UI.HiddenFilter: true;
// }
// annotate ZCDSEHBTC0007.BOMDisplay with {
//     WERKS @(
//            Common.ValueList : {
//             Label           : 'Consequence',
//             CollectionPath  : 'VL_SH_H_T001',
//             SearchSupported : false,
//             Parameters      : [
//                 {
//                     $Type             : 'Common.ValueListParameterInOut',
//                     ValueListProperty : 'BUKRS',
//                     LocalDataProperty : WERKS,
//                     ![@Common.Label] : 'tPlant',
//                 },
//                 {
//                     $Type             : 'Common.ValueListParameterDisplayOnly',
//                     ValueListProperty : 'BUTXT'
                 
//                 }    
//             ]
//         });
// };

annotate ZCDSEHBTC0007.Formalize {
    @(Common : {
        Label     : 'Plant',
        ValueList : {
            CollectionPath : 'VL_SH_H_T001',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : WERKS,
                    ValueListProperty : 'BUKRS'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'BUTXT'
                }
            ]
        }
    })
    WERKS;
}

annotate ZCDSEHBTC0007.Formalize {
    @(Common : {
        Label     : 'Document number',
        ValueList : {
            Label: 'DOC Type/Doc No',
            CollectionPath : 'DOC_NO_HELP',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : E_DOC_NO,
                    ValueListProperty : 'E_DOC_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_REV_NO'
                }
                ,
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MEDAI_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'YEOS_MODEL_GROUP'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'FZ2_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'REV_SBJCT'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MODIFY_CAUSE_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'APPLY_DATE_N'
                }


            ]
        },
        ValueList #MainModel : {
            Label: 'Main Model/FZ2 No',
            CollectionPath : 'MAIN_MODEL_HELP',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : E_DOC_NO,
                    ValueListProperty : 'FZ2_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'YEOS_MODEL_GROUP'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_REV_NO'
                }
                ,
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MEDAI_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'REV_SBJCT'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MODIFY_CAUSE_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'APPLY_DATE_N'
                }
            ]
        }
    })
    E_DOC_NO;
}

// annotate ZCDSEHBTC0007.BOMDisplay {
//     @Common.ValueListWithFixedValues : true
//     @(Common : {
//         Label     : 'Doc Type',
//         ValueList : {
//             $Type : 'Common.ValueListType',
//             CollectionPath : 'Doc_Type',
//             Parameters     : [
//                 {
//                     $Type             : 'Common.ValueListParameterInOut',
//                     LocalDataProperty : E_DOC_TYPE,
//                     ValueListProperty : 'DOC_TYPE'
//                 }
//             ]
//         }
//     })
//     E_DOC_TYPE;
// }
// annotate ZCDSEHBTC0007.BOMDisplay @(Capabilities.FilterRestrictions : {
//    FilterExpressionRestrictions : [
//         {
//             Property : E_DOC_TYPE,
//             AllowedExpressions : 'SingleValue'
//         }
//     ]
// });
// annotate ZCDSEHBTC0007.BOMDisplay with {
//     @Common.FilterDefaultValue : 'FE0'
//     E_DOC_TYPE
// };
annotate ZCDSEHBTC0009.MakersList with @(
  UI.SelectionPresentationVariant #makerlist : {
    Text : 'Maker List',
    SelectionVariant : { 
        Text : 'MakerList',
        SelectOptions : [
            {
                $Type : 'UI.SelectOptionType',
                PropertyName : E_PARTS_NO,
            }
        ]
    },
    PresentationVariant : {
        SortOrder : [
            {
                Property : E_PARTS_NO,
                Descending : false
            }
        ]
    }
  }
);

annotate ZCDSEHBTC0009.DigitPartList with @(
  UI.SelectionVariant #DigitPartList : {
    Text : '10 Digit Part List'
  }
);

annotate ZCDSEHBTC0009.PackingList with @(
  UI.SelectionVariant #PackingList : {
    Text : 'PackingList'
  }
);
annotate ZCDSEHBTC0009.DigitPartList with @(Capabilities : {
    FilterRestrictions : {
        $Type              : 'Capabilities.FilterRestrictionsType',
        RequiredProperties : [
            E_PARTS_NO,
            
        ],
    }
});

annotate ZCDSEHBTC0009.MakersList with @(
    UI : { 
        SelectionFields  : [
            E_PARTS_NO
        ],
        LineItem  : [
            { Value : E_PARTS_NO },
            { Value : SOURCE_CD }, 
            { Value : YEOS_MNF_NO },
            { Value : DATA_ST },
            { Value : YEOS_MNF_MODEL },
            { Value : YEOS_MNF_N }                                         
        ],
     }
){
};
annotate ZCDSEHBTC0009.DigitPartList with @(
    UI : { 
        SelectionFields  : [
            E_PARTS_NO
        ],
        LineItem  : [
            { Value : E_PARTS_NO },
            { Value : MATERIALDESC },
            { Value : SOURCE_CD }, 
            { Value : YEOS_MNF_NO }                                        
        ],
     }
){
};

annotate ZCDSEHBTC0009.PackingList with @(
    UI : { 
        
        LineItem  : [
            { Value : E_PARTS_NO },
            { Value : PCKG_CD }, 
            { Value : PCKG_TYPE },
            { Value : PCKG_STYLE },
            { Value : SUPPLY_STYLE },
            { Value : PCKG_TYPE_N }, 
            { Value : PCKG_STYLE_N }, 
            { Value : SUPPLY_STYLE_N },
            { Value : PCKG_UNIT_QTY }                                       
        ],
     }
){
};
annotate ZCDSEHBTC0009.ZTHBT0001 with @(
    UI : { 
        SelectionFields  : [
            E_PARTS_NO
        ]
     }
){
};
annotate ZCDSEHBTC0009.DigitPartList {
    @(Common : {
        Label     : 'Material',
        ValueList : {
            CollectionPath : 'MaterialInput',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : E_PARTS_NO,
                    ValueListProperty : 'E_PARTS_NO'
                }
            ]
        }
    })
    E_PARTS_NO;
}
annotate ZCDSEHBTC0009.ZTHBT0001 {
    @(Common : {
        Label     : 'Material',
        ValueList : {
            CollectionPath : 'MaterialInput',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : E_PARTS_NO,
                    ValueListProperty : 'E_PARTS_NO'
                }
            ]
        }
    })
    E_PARTS_NO;
}
// annotate ZCDSEHBTC0009.ZTHBT0001 with @(
//   Capabilities.InsertRestrictions : {
//     Insertable : false,
//   }
// );
annotate ZCDSEHBTC0009.DigitPartList @(Capabilities : {
    SearchRestrictions : {
        $Type      : 'Capabilities.SearchRestrictionsType',
        Searchable : false
    },
    InsertRestrictions : {
        $Type : 'Capabilities.InsertRestrictionsType',
        Insertable: false
    },
    DeleteRestrictions : {
        $Type : 'Capabilities.DeleteRestrictionsType',
        Deletable: false
    }
});
annotate ZCDSEHBTC0009.ZTHBT0001 @(Capabilities : {
    SearchRestrictions : {
        $Type      : 'Capabilities.SearchRestrictionsType',
        Searchable : false
    },
    InsertRestrictions : {
        $Type : 'Capabilities.InsertRestrictionsType',
        Insertable: false
    },
    DeleteRestrictions : {
        $Type : 'Capabilities.DeleteRestrictionsType',
        Deletable: false
    }
});
annotate ZCDSEHBTC0009.ZTHBT0001 with @(
    UI.UpdateHidden : true,
    UI.DeleteHidden : true
);
annotate ZCDSEHBTC0009.MakersList with @(
    UI.UpdateHidden : true,
    UI.DeleteHidden : true
);
annotate ZCDSEHBTC0009.DigitPartList with @(
    UI.UpdateHidden : true,
    UI.DeleteHidden : true
);
annotate ZCDSEHBTC0009.PackingList with @(
    UI.UpdateHidden : true,
    UI.DeleteHidden : true
);

//Labels
annotate ZCDSEHBTC0009.ZTHBT0001 with {
    PARTS_NO        @title : 'Parts  Number';
    E_PARTS_NO      @title : 'Material Number';
    SOURCE_CD       @title : 'Source  Code';
    YEOS_MNF_NO     @title : 'Maker Model Number';
    YEOS_MNF_MODEL  @title : 'Maker Model Name';
    PCKG_CD         @title : 'Packing Code';
    IND_DEMAND_SIGN @title : 'Ind Demand Sign';
}

annotate ZCDSEHBTC0009.ZTHBT0002 with {
    PCKG_TYPE    @title : 'Packing Type';
    PCKG_STYLE   @title : 'Packing Style';
    PCKG_STYLE_N @title : 'Packing Style Name';
}

annotate ZCDSEHBTC0009.ZTHBT0003 with {
    PCKG_TYPE   @title : 'Packing Type';
    PCKG_TYPE_N @title : 'Packing Type Name';
}

annotate ZCDSEHBTC0009.ZTHBT0004 with {
    PCKG_TYPE      @title : 'Packing Type';
    SUPPLY_STYLE   @title : 'Supply Style';
    SUPPLY_STYLE_N @title : 'Supply Style Name';
}

annotate ZCDSEHBTC0009.ZTHBT0005 with {
    E_PARTS_NO      @title : 'Material Name';
    PCKG_CD       @title : 'Packing Code';
    PCKG_TYPE     @title : 'Packing Type';
    PCKG_STYLE    @title : 'Packing Style';
    SUPPLY_STYLE  @title : 'Supply Style';
    PCKG_UNIT_QTY @title : 'Number of storage';
    PARTS_UNIT    @title : 'Parts Unit';
}

annotate ZCDSEHBTC0009.ZTHBT0006 with {
    E_PARTS_NO        @title : 'Material Number';
    E_PARTS_N         @title : 'Parts Name';
    PARTS_TYPE        @title : 'Parts Type';
    RCMND_CLASS       @title : 'Rcmnd Class';
    MOUNT_TYPE        @title : 'Mount Type';
    SAFETY_SIGN       @title : 'Safety Sign';
    ANTIEXPLODE_SIGN  @title : 'Antiexplode Sign';
    RADIO_SIGN        @title : 'Radio Sign';
    USE_NON_COMPLAINT @title : 'Use non complaint product Sign';
    EMC_SIGN          @title : 'Emc Sign';
    PED_SIGN          @title : 'Ped Sign';
    PARTS_UNIT        @title : 'Parts Unit';
    CLASS3_NAME       @title : 'Class Name';
    PRODUCT_TYPE      @title : 'Product Type';
}

annotate ZCDSEHBTC0009.ZTHBT0007 with {
    E_PARTS_NO         @title : 'Material Number';
    SOURCE_CD          @title : 'Source Code';
    DATA_ST            @title : 'Data status';
    YEOS_MNF_NO        @title : 'Maker Model Number';
    YEOS_MNF_MODEL     @title : 'Maker Model Name';
    Y_LEVEL            @title : 'level';
    PARTS_NO_EXT_SIGN  @title : 'Parts No ext sign';
    MASS               @title : 'Mass';
    INVESTIGATION_UNIT @title : 'Investigation Unit';
}

annotate ZCDSEHBTC0009.ZTHBT0015 with {
    PARTS_TYPE        @title : 'Parts Type';
    PARTS_TYPE_N      @title : 'Parts Type Name';
    PARTS_TYPE_ABB_N  @title : 'Parts Type Abb Name';
    PARTS_NO_EXT_SIGN @title : 'Parts No ext sign';
}
 
annotate ZCDSEHBTC0009.TenDigitsPartsFilter @(Capabilities.FilterRestrictions : {
   FilterExpressionRestrictions : [
        {
            Property : Product,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : YEOS_MNF_NO,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : PCKG_CD,
            AllowedExpressions : 'SingleValue'
        }
    ]
});

annotate ZCDSEHBTC0009.TenDigitsPartsFilter {

    @(Common : {
        Label     : 'Material',
        ValueList : {
            CollectionPath : 'A_ProductDescription',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Product,
                    ValueListProperty : 'Product'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'ProductDescription'
                },	
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Language'
                }
            ]
        }
    })
    Product;
}
annotate ZCDSEHBTC0009.TenDigitsParts {
	    @(Common : {
	        Label     : 'Packing Type',
	        ValueList : {
	            CollectionPath : 'ZTHBT0003',
	            Parameters     : [
	                {
	                    $Type             : 'Common.ValueListParameterInOut',
	                    LocalDataProperty : PCKG_TYPE,
	                    ValueListProperty : 'PCKG_TYPE'
	                },
	                {
	                    $Type             : 'Common.ValueListParameterDisplayOnly',
	                    ValueListProperty : 'PCKG_TYPE_N'
	                }
	            ]
	        }
	    })
	    PCKG_TYPE;
	}
	annotate ZCDSEHBTC0009.TenDigitsParts {
	    @(Common : {
	        Label     : 'Packing Style',
	        ValueList : {
	            CollectionPath : 'ZTHBT0002',
	            Parameters     : [
	                {
	                    $Type             : 'Common.ValueListParameterInOut',
	                    LocalDataProperty : PCKG_STYLE,
	                    ValueListProperty : 'PCKG_STYLE'
	                },
	                {
	                    $Type             : 'Common.ValueListParameterDisplayOnly',
	                    ValueListProperty : 'PCKG_STYLE_N'
	                },
	                {
	                    $Type             : 'Common.ValueListParameterIn',
	                    ValueListProperty : 'PCKG_TYPE',
	                    LocalDataProperty : PCKG_TYPE
	                }
	            ]
	        }
	    })
	    PCKG_STYLE;
	}
	annotate ZCDSEHBTC0009.TenDigitsParts {
	    @(Common : {
	        Label     : 'Supply Style',
	        ValueList : {
	            CollectionPath : 'ZTHBT0004',
	            Parameters     : [
	                {
	                    $Type             : 'Common.ValueListParameterInOut',
	                    LocalDataProperty : SUPPLY_STYLE,
	                    ValueListProperty : 'SUPPLY_STYLE'
	                },
	                {
	                    $Type             : 'Common.ValueListParameterDisplayOnly',
	                    ValueListProperty : 'SUPPLY_STYLE_N'
	                },
	                {
	                    $Type             : 'Common.ValueListParameterIn',
	                    ValueListProperty : 'PCKG_TYPE',
	                    LocalDataProperty :  PCKG_TYPE
	                }
	            ]
	        }
	    })
	    SUPPLY_STYLE;
}

annotate ZCDSEHBTC0007.DATAFE0 with @(
  UI.SelectionVariant #tab1 : {
    Text : 'Parts Structure Specification'
  }
);
annotate  ZCDSEHBTC0007.DATAFE0 with @(
    UI: {
        HeaderInfo: {
            TypeName: '',
            TypeNamePlural: 'Parts Structure Specification',
            Title: { Value: E_DOC_NO },
            Description: { Value: E_DOC_NO }
        },
        SelectionFields  : [
            E_DOC_TYPE,WERKS,E_DOC_NO,E_REV_NO,PS_GROUP_NO
        ],
        LineItem: [
            { Value: E_DOC_NO },
            { Value: E_REV_NO },
            { Value: PS_GROUP_NO }          
        ],
        Facets: [
            {
                $Type: 'UI.ReferenceFacet',
                Label: 'Parts Structure Specification',
                Target: '@UI.FieldGroup#MainAs'
            },
            {
                $Type: 'UI.ReferenceFacet',
                Label: 'Details',
                Target: 'ZTHBT0010/@UI.LineItem'
            }
        ],        
        FieldGroup#MainAs: {
            Data: [
               { Value: E_DOC_NO },
            { Value: E_REV_NO },
            { Value: PS_GROUP_NO }              
            ]
        }
    }
){
    
};


annotate ZCDSEHBTC0007.DATAFE1 with @(
  UI.SelectionVariant #tab2 : {
    Text : 'Parts Structure Specification'
  }
);
annotate  ZCDSEHBTC0007.DATAFE1 with @(
    UI: {
        HeaderInfo: {
            TypeName: '',
            TypeNamePlural: 'Parts Structure Tr',
            Title: { Value: E_DOC_NO },
            Description: { Value: E_DOC_NO }
        },
        SelectionFields  : [
            E_DOC_TYPE,WERKS,E_DOC_NO,E_REV_NO,PS_GROUP_NO
        ],
        LineItem: [
            { Value: E_DOC_NO },
            { Value: E_REV_NO },
            { Value: PS_GROUP_NO }          
        ],
        Facets: [
            {
                $Type: 'UI.ReferenceFacet',
                Label: 'General Information',
                Target: '@UI.FieldGroup#MainAs'
            },
            {
                $Type: 'UI.ReferenceFacet',
                Label: 'Details',
                Target: 'ZTHBT0014/@UI.LineItem'
            }
        ],        
        FieldGroup#MainAs: {
            Data: [
               { Value: E_DOC_NO },
            { Value: E_REV_NO },
            { Value: PS_GROUP_NO }              
            ]
        }
    }
){
    
};

annotate ZCDSEHBTC0007.ZTHBT0010 with @(
    Identification      : [
        {Value : E_DOC_NO}
    ],
    UI : { 
        LineItem  : [
            { Value : PS_GROUP_NO },
            { Value : PS_ITEM_NO },
            { Value : E_TR_TYPE },
            { Value : E_PART_NO },
            { Value : PARTS_NO_EXT_SIGN },
            { Value : PARTS_QTY },
            { Value : PARTS_QTY_UNIT },
            { Value : SELECT_SIGN },
            { Value : PARTS_USE_RATIO },
            { Value : OR_SIGN },
            { Value : SFIX_PTN },
            { Value : OPTION_PTN },
            { Value : MODEL1 },
            { Value : SFIX_DIGIT_PTN },
            { Value : PROD_CARRER },  
            { Value : PS_SYMBOL },
            { Value : PS_NOTE }                                     
        ],
     }
){
};
// annotate ZCDSEHBTC0007.ZTHBT0010 with @(
//     UI : { 
//         LineItem  : [
//             { Value : SFIX_PTN },
//             { Value : OPTION_PTN },
//             { Value : MODEL1 },
//             { Value : SFIX_DIGIT_PTN },
//             { Value : PROD_CAREER_FROM },  
//             { Value : PS_SYMBOL },
//             { Value : PS_NOTE }                                     
//         ],
//      }
// ){
// };

annotate ZCDSEHBTC0007.ZTHBT0014 with @(
    Identification      : [
        {Value : E_DOC_NO}
    ],
    UI : { 
        LineItem  : [
            { Value : PS_GROUP_NO },
            { Value : PS_ITEM_NO },
            { Value : E_TR_TYPE },
            { Value : PARENT_PARTS_NO },
            { Value : PARTS_NO_EXT_SIGN },
            { Value : E_PART_NO },
            { Value : SELECT_SIGN },
            { Value : PARTS_USE_RATIO },                                     
            { Value : PS_SYMBOL },
            { Value : PS_NOTE },
        ],
     }
){
};
// annotate ZCDSEHBTC0009.DigitPartList with @(
//   UI.SelectionVariant #DigitPartList : {
//     Text : '10 Digit Part List'
//   }
// );
annotate ZCDSEHBTC0012.materialWhereUsedMaster with @(
    UI : { 
        SelectionFields  : [
            WERKS,
            MATNR_COM,MMSTD
        ],
        LineItem  : [
            { Value : WERKS }, 
            { Value : MATNR_COM },
            { Value : MAKTX_COM },
            { Value : MATNR },
            { Value : MATNR },
            { Value : MTART_COM },
            { Value : POTX1_0 }, 
            { Value : POSNR },
            { Value : POTX1_19 },
            { Value : MOD_CODE },
            { Value : MAKTX },
            { Value : ZZ1_MSCODE_PRD }, 
            { Value : MTART },
            { Value : EMENG },
            { Value : BMEIN },
            { Value : ASM },
            { Value : POTX1_22 }, 
            { Value : SCHGT },
            { Value : POTX1_24 },
            { Value : ARBPL },
            { Value : VGW01 },
            { Value : VGE01 }, 
            { Value : SEARCH_FROM },
            { Value : SCHGT_TO },
            { Value : BESKZ_TO }, 
            { Value : SOBSL_TO },
            { Value : LVORM_TO },
            { Value : WERKS_FROM },
            { Value : UMLGO },
            { Value : SCHGT_FROM }, 
            { Value : BESKZ_FROM },
            { Value : SOBSL_FROM },
            { Value : SOBSL_FROM },
            { Value : BSTME },
            { Value : MEINS }, 
            { Value : MESSAGE }                                                
        ],
     }
){
};

annotate ZCDSEHBTC0012.materialWhereUsed with @(
    UI : { 
        SelectionFields  : [
            WERKS,
            MATNR_COM,MMSTD
        ],
        LineItem  : [
            { Value : WERKS }, 
            { Value : MATNR_COM },
            { Value : MAKTX_COM },
            { Value : MATNR },
            { Value : MATNR },
            { Value : MTART_COM },
            { Value : POTX1_0 }, 
            { Value : POSNR },
            { Value : SORTF },
            { Value : POTX1_19 },
            { Value : MOD_CODE },
            { Value : MAKTX },
            { Value : ZZ1_MSCODE_PRD }, 
            { Value : MTART },
            { Value : EMENG },
            { Value : BMEIN },
            { Value : ASM },
            { Value : POTX1_22 }, 
            { Value : SCHGT },
            { Value : POTX1_24 },
            { Value : ARBPL },
            { Value : VGW01 },
            { Value : VGE01 }, 
            { Value : VMSTD },
            { Value : SEARCH_FROM },
            { Value : SCHGT_TO },
            { Value : BESKZ_TO }, 
            { Value : SOBSL_TO },
            { Value : LVORM_TO },
            { Value : WERKS_FROM },
            { Value : UMLGO },
            { Value : SCHGT_FROM }, 
            { Value : BESKZ_FROM },
            { Value : SOBSL_FROM },
            { Value : SOBSL_FROM },
            { Value : BSTME },
            { Value : LVORM_FROM },  
            { Value : MEINS }
                                                          
        ],
     }
){
};

annotate ZCDSEHBTC0012.materialWhereUsed with @(Capabilities : {
    FilterRestrictions : {
        $Type              : 'Capabilities.FilterRestrictionsType',
        RequiredProperties : [
            WERKS,
            MATNR_COM,
            MMSTD
        ],
    }
});

annotate ZCDSEHBTC0012.materialWhereUsed with @(
  UI.SelectionVariant #List1 : {
    Text : ''
  }
);

annotate ZCDSEHBTC0012.materialWhereUsedMaster with @(
  UI.SelectionVariant #List2 : {
    Text : ''
  }
);

annotate ZCDSEHBTC0012.materialWhereUsed {
    @(Common : {
        Label     : 'Component Material',
        ValueList : {
            CollectionPath : 'A_ProductPlant',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : MATNR_COM,
                    ValueListProperty : 'Product'
                },
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : WERKS,
                    ValueListProperty : 'Plant'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Plant'
                }
            ]
        }
    })
    MATNR_COM;
}
annotate ZCDSEHBTC0012.materialWhereUsed {
    @(Common : {
        Label     : 'Plant',
        ValueList : {
            CollectionPath : 'VL_SH_H_T001',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : WERKS,
                    ValueListProperty : 'BUKRS'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'BUTXT'
                }
            ]
        }
    })
    WERKS;
}

annotate ZCDSEHBTC0013.ZCDSEBPS0014 @(Capabilities : {
    SearchRestrictions : {
        $Type      : 'Capabilities.SearchRestrictionsType',
        Searchable : false
    },
    // InsertRestrictions : {
    //     $Type : 'Capabilities.InsertRestrictionsType',
    //     Insertable: false
    // },
    DeleteRestrictions : {
        $Type : 'Capabilities.DeleteRestrictionsType',
        Deletable: false
    }
});
annotate ZCDSEHBTC0013.ZCDSEBPS0014 with @(
    UI.UpdateHidden : true,
    UI.DeleteHidden : true,
    UI.CreateHidden : true,
);
annotate ZCDSEHBTC0013.ZCDSEBPS0014 with {
ZSD_GRPSUPP @UI.HiddenFilter: true;
ZSD_STATUS @UI.HiddenFilter: true;
}
annotate ZCDSEHBTC0013.ZCDSEBPS0014 with @(
    
    UI : { 
        SelectionFields  : [
            ZWBS_ELEMENT,ZSD_INV_SUBMIT_DATE
        ],
        LineItem  : [
            { Value : ZWBS_ELEMENT },
            { Value : ZFG_INVOICE_ID },
            { Value : ZSD_MILESTONE },
            { Value : ZSD_MAIN_SONUM }, 
            { Value : ZSD_SO_DEBIT_NUM },
            { Value : ZSD_INV_SUBMIT_DATE },
            { Value : ZSD_GROSS_VALUE },
            { Value : ZSD_BILLING_DATE },
            { Value : ZSD_PRICING_DATE },
            { Value : ZSD_DEBIT_DOC_DATE },
            { Value : ZSD_DEBIT_NET_VALUE },   
            { Value : ZSD_ACTUAL_DATE },
            { Value : ZSD_BILLINGPLAN_VALUE },
            { Value : ZSD_STATUS },
            { Value : ZSD_ERROR }                                     
        ],
     }
){
};
annotate ZCDSEHBTC0012.materialWhereUsed with {
            WERKS  @title : 'Plant';
            MATNR_COM  @title : 'Component Material';
            MATNR  @title : 'Material';
            MAKTX_COM  @title : 'Component Description';
            MTART_COM  @title : 'Material Type of Component';
            POTX1_0  @title : 'Doc No';
            POSNR  @title : 'Page';
            SORTF  @title : 'Line';
            POTX1_19  @title : 'Rev';
            MOD_CODE  @title : 'Model / Module';
            MAKTX  @title : 'Material Description';
            ZZ1_MSCODE_PRD  @title : 'MS code';
            MTART  @title : 'Material Type';
            EMENG  @title : 'BOM QTY';
            BMEIN  @title : 'Unit';
            ASM  @title : 'ASM';
            POTX1_22  @title : 'Select';
            SCHGT  @title : 'Bulk';
            POTX1_24  @title : 'ITEM';
            ARBPL  @title : 'Work Center';
            VGW01  @title : 'L/T';
            VGE01  @title : 'L/T Unit';
            VMSTD  @title : 'Sales Stop';
            LEVEL_BOM  @title : 'Level (in multi-level BOM explosions)';
            SEARCH_FROM  @title : 'Search From';
            SCHGT_TO  @title : 'Bulk (To)';
            BESKZ_TO  @title : 'Proc (To)';
            SOBSL_TO  @title : 'SProc (To)';
            LVORM_TO  @title : 'DLT (To)';
            WERKS_FROM  @title : 'Plant (From)';
            UMLGO  @title : 'Str (From)';
            SCHGT_FROM  @title : 'Bulk (From)';
            BESKZ_FROM  @title : 'Proc (From)';
            SOBSL_FROM  @title : 'SProc (From)';
            LVORM_FROM  @title : 'DLT (From)';
            BSTME  @title : 'Arrange Type (From)';
            MEINS  @title : 'Arrange Unit';
            MMSTD  @title : 'Valid from';
            MESSAGE  @title : 'Message';
            LIST_TYPE         @title : 'Where Used List Type';
            MASTER_DATA          @title : 'Other Master Data';
    
}

annotate ZCDSEHBTC0011.ManBOMUpload {
	    @(Common : {
	        Label     : 'Plant',
	        ValueList : {
	        CollectionPath : 'VL_SH_H_T001',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Plant,
                    ValueListProperty : 'BUKRS'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'BUTXT'
                }
            ]
	        }
	    })
	    Plant;
}
annotate ZCDSEHBTC0011.ManBOMUpload {
	    @(Common : {
	        Label     : 'ExecutionSchedule',
	        ValueList : {
	        CollectionPath : 'ZTHBT0018',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ExecutionSchedule,
                    ValueListProperty : 'APPLY_DATE_CD'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'APPLY_DATE_N'
                }
            ]
	        }
	    })
	    ExecutionSchedule;
}
annotate ZCDSEHBTC0011.ManBOMUpload {
	    @(Common : {
	        Label     : 'RevisionReason',
	        ValueList : {
	        CollectionPath : 'ZTHBT0017',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : RevisionReason,
                    ValueListProperty : 'MODIFY_CAUSE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MODIFY_CAUSE_N'
                }
            ]
	        }
	    })
	    RevisionReason;
}

annotate  ZCDSEHBTC0011.ManBOMUpload with @(
    UI: {
        HeaderInfo: {
            TypeName: 'Manufacture BOM Upload',
            TypeNamePlural: 'Manufacture BOM Upload'
        },
        SelectionFields: [ Plant,MainModel,FZ2No,MainModelName,ApprovedDate,Title,ExecutionSchedule,RevisionReason ]
    }
);

annotate ZCDSEHBTC0011.ManBOMUpload @(Capabilities.FilterRestrictions : {
   FilterExpressionRestrictions : [
        {
            Property : Plant,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : MainModel,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : FZ2No,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : MainModelName,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : ApprovedDate,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : OperationDept,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : Title,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : ExecutionSchedule,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : RevisionReason,
            AllowedExpressions : 'SingleValue'
        }
    ]
});

annotate ZCDSEHBTC0016.ZTHBT0057 {
    @(Common : {
        Label     : 'Document number',
        ValueList : {
            Label: 'DOC Type/Doc No',
            CollectionPath : 'DOC_NO_HELP',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : E_DOC_NO,
                    ValueListProperty : 'E_DOC_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_REV_NO'
                }
                ,
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MEDAI_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'YEOS_MODEL_GROUP'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'FZ2_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'REV_SBJCT'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MODIFY_CAUSE_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'APPLY_DATE_N'
                }


            ]
        },
        ValueList #MainModel : {
            Label: 'Main Model/FZ2 No',
            CollectionPath : 'MAIN_MODEL_HELP',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : E_DOC_NO,
                    ValueListProperty : 'FZ2_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'YEOS_MODEL_GROUP'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_REV_NO'
                }
                ,
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MEDAI_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'REV_SBJCT'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MODIFY_CAUSE_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'APPLY_DATE_N'
                }
            ]
        }
    })
    E_DOC_NO;
}
annotate ZCDSEHBTC0016.processData with @(
    
    UI : { 
        SelectionFields  : [
            WERKS,E_DOC_NO,FORMALIZE_DATE,MATNR
        ],
        LineItem  : [
            { Value : WERKS },
            { Value : E_DOC_NO },
            { Value : E_REV_NO }, 
            { Value : PS_GROUP_NO },
            { Value : PS_ITEM_NO },
            { Value : SEQ_NO },
            { Value : MATNR },
            { Value : MODEL },
            { Value : FORMALIZE_DATE },   
            { Value : ERROR_MSG }                                    
        ],
     }
){
};
annotate ZCDSEHBTC0016.ZTHBT0057 with @(
    
    UI : { 
        SelectionFields  : [
            WERKS,E_DOC_NO,FORMALIZE_DATE,MATNR
        ],
        LineItem  : [
            { Value : WERKS },
            { Value : E_DOC_NO },
            { Value : E_REV_NO }, 
            { Value : PS_GROUP_NO },
            { Value : PS_ITEM_NO },
            { Value : SEQ_NO },
            { Value : MATNR },
            { Value : MODEL },
            { Value : FORMALIZE_DATE },   
            { Value : ERROR_MSG }                                    
        ],
     }
){
};
annotate ZCDSEHBTC0016.ZTHBT0057 {
    @(Common : {
        Label     : 'Plant',
        ValueList : {
            CollectionPath : 'VL_SH_H_T001',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : WERKS,
                    ValueListProperty : 'BUKRS'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'BUTXT'
                }
            ]
        }
    })
    WERKS;
}

annotate ZCDSEHBTC0016.ZTHBT0057 with @(
    UI.UpdateHidden : true,
    UI.DeleteHidden : true,
    UI.CreateHidden : true,
);
annotate ZCDSEHBTC0007.specificationChange with @(Capabilities : {
    FilterRestrictions : {
        $Type              : 'Capabilities.FilterRestrictionsType',
        RequiredProperties : [
            WERKS
        ],
    }
});
annotate ZCDSEHBTC0007.specificationChange @(Capabilities.FilterRestrictions : {
   FilterExpressionRestrictions : [
        {
            Property : WERKS,
            AllowedExpressions : 'SingleValue'
        }
    ]
});
annotate ZCDSEHBTC0007.specificationChange with {
    E_PART_NO       @title : 'Design Parts';
    COMP_PART_NO       @title : 'Production Parts';
}
annotate ZCDSEHBTC0007.specificationChange {
    @(Common : {
        Label     : 'Document number',
        ValueList : {
            Label: 'DOC Type/Doc No',
            CollectionPath : 'DOC_NO_HELP',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : E_DOC_NO,
                    ValueListProperty : 'E_DOC_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_REV_NO'
                }
                ,
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MEDAI_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'YEOS_MODEL_GROUP'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'FZ2_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'REV_SBJCT'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MODIFY_CAUSE_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'APPLY_DATE_N'
                }


            ]
        },
        ValueList #MainModel : {
            Label: 'Main Model/FZ2 No',
            CollectionPath : 'MAIN_MODEL_HELP',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : E_DOC_NO,
                    ValueListProperty : 'FZ2_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'YEOS_MODEL_GROUP'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_REV_NO'
                }
                ,
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MEDAI_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'REV_SBJCT'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MODIFY_CAUSE_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'APPLY_DATE_N'
                }
            ]
        }
    })
    E_DOC_NO;
}
annotate ZCDSEHBTC0007.specificationChange with {
    TEN_DIGIT_SIGN          @(
        UI.Hidden : {$edmJson : {$Eq : [{$Path : 'SELECT_SIGN'}, '1']}}
    );
    TEN_DIGIT_SIGN @(
        FieldControl : 1
    );
//    TEN_DIGIT_SIGN @readonly;
//    E_PART_NO      @(
//         Common : {
//             FieldControl    : {$edmJson: {$If: [{$Eq: [{$Path: 'PARTS_QTY'}, 't']}, 1, 7]}}
//         }
//     );
    
   SELECT_SIGN      @(
        Common : {
            FieldControl    : #ReadOnly
        }
    );
}

annotate ZCDSEHBTC0007.specificationChange @(Capabilities : {
    Insertable : false,
    Deletable  : false,
    Updatable  : true,
});
annotate ZCDSEHBTC0007.specificationChange with @(
    
    UI : { 
        UpdateHidden        : false,
        DeleteHidden        : true,
        CreateHidden        : false,

        SelectionFields  : [
            WERKS,E_DOC_NO,E_PART_NO,COMP_PART_NO
        ],
        LineItem  : [
            { Value : WERKS },
            { Value : E_DOC_NO },
            { Value : E_REV_NO }, 
            { Value : PS_GROUP_NO },
            { Value : PS_ITEM_NO },
            { Value : E_PART_NO },
            { Value : TEN_DIGIT_SIGN },
            { Value : COMP_PART_NO },
            { Value : PARTS_QTY },
            { Value : PARTS_QTY_UNIT },
            { Value : SELECT_SIGN },   
            { Value : EFFECT_D },
            { Value : INVALID_D },
            { Value : E_TR_TYPE }                                  
        ],
        
        Facets: [
            {
                $Type: 'UI.ReferenceFacet',
                Label: 'Parts Structure Specification',
                Target: '@UI.FieldGroup#MainAs'
                
            }
        ],        
        FieldGroup #MainAs: {
            $Type : 'UI.FieldGroupType',
            Data: [
               { Value: TEN_DIGIT_SIGN },
            
            {
                $Type : 'UI.DataField',
                Value : E_PART_NO,
                ![@Common.FieldControl] : { $edmJson : {$If : [ { $Eq : [ { $Path : 'TEN_DIGIT_SIGN'}, '0' ]}, 3, 1 ]}}
            },
            { Value: SELECT_SIGN },
            { Value: PARTS_QTY },
            { Value: EFFECT_D }              
            ]
        }
     }
){
};

annotate ZCDSEHBTC0007.specificationChange {
    @(Common : {
        Label     : 'Plant',
        ValueList : {
            CollectionPath : 'VL_SH_H_T001',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : WERKS,
                    ValueListProperty : 'BUKRS'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'BUTXT'
                }
            ]
        }
    })
    WERKS;
}
annotate ZCDSEHBTC0009.DigitPartList with {
MATERIALDESC @UI.HiddenFilter: true;
SOURCE_CD @UI.HiddenFilter: true;
PARTS_NO @UI.HiddenFilter: true;
YEOS_MNF_NO @UI.HiddenFilter: true;
}
annotate ZCDSEHBTC0007.specificationChange {
    @(Common : {
        Label     : 'Production Parts',
        ValueList : {
            CollectionPath : 'ZTHBT0001',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : COMP_PART_NO,
                    ValueListProperty : 'PARTS_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : E_PART_NO,
                    ValueListProperty : 'E_PARTS_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_PARTS_NO'
                }
            ]
        }
    })
    COMP_PART_NO;
}
/////Specification change Dummy
annotate ZCDSEHBTC0007.specificationChangeMessage with @(Capabilities : {
    FilterRestrictions : {
        $Type              : 'Capabilities.FilterRestrictionsType',
        RequiredProperties : [
            WERKS
        ],
    }
});
annotate ZCDSEHBTC0007.specificationChangeMessage @(Capabilities.FilterRestrictions : {
   FilterExpressionRestrictions : [
        {
            Property : WERKS,
            AllowedExpressions : 'SingleValue'
        }
    ]
});
annotate ZCDSEHBTC0007.specificationChangeMessage with @(
    
    UI : { 
        UpdateHidden        : false,
        DeleteHidden        : true,
        CreateHidden        : false,

        SelectionFields  : [
            WERKS,E_DOC_NO,E_PART_NO,COMP_PART_NO
        ],
        LineItem  : [
            { Value : WERKS },
            { Value : E_DOC_NO },
            { Value : E_REV_NO }, 
            { Value : PS_GROUP_NO },
            { Value : PS_ITEM_NO },
            { Value : E_PART_NO },
            { Value : TEN_DIGIT_SIGN },
            { Value : COMP_PART_NO },
            { Value : PARTS_QTY },
            { Value : PARTS_QTY_UNIT },
            { Value : SELECT_SIGN },   
            { Value : EFFECT_D },
            { Value : INVALID_D },
            { Value : E_TR_TYPE }                                  
        ],
        
        Facets: [
            {
                $Type: 'UI.ReferenceFacet',
                Label: 'Parts Structure Specification',
                Target: '@UI.FieldGroup#MainAs'
                
            }
        ],        
        FieldGroup #MainAs: {
            $Type : 'UI.FieldGroupType',
            Data: [
               { Value: TEN_DIGIT_SIGN },
            
            {
                $Type : 'UI.DataField',
                Value : E_PART_NO,
                ![@Common.FieldControl] : { $edmJson : {$If : [ { $Eq : [ { $Path : 'TEN_DIGIT_SIGN'}, '0' ]}, 3, 1 ]}}
            },
            { Value: SELECT_SIGN },
            { Value: PARTS_QTY },
            { Value: EFFECT_D }              
            ]
        }
     }
){
};
annotate ZCDSEHBTC0007.specificationChangeMessage with {
    E_PART_NO       @title : 'Design Parts';
    COMP_PART_NO       @title : 'Production Parts';
}
annotate ZCDSEHBTC0007.specificationChangeMessage {
    @(Common : {
        Label     : 'Document number',
        ValueList : {
            Label: 'DOC Type/Doc No',
            CollectionPath : 'DOC_NO_HELP',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : E_DOC_NO,
                    ValueListProperty : 'E_DOC_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_REV_NO'
                }
                ,
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MEDAI_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'YEOS_MODEL_GROUP'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'FZ2_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'REV_SBJCT'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MODIFY_CAUSE_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'APPLY_DATE_N'
                }


            ]
        },
        ValueList #MainModel : {
            Label: 'Main Model/FZ2 No',
            CollectionPath : 'MAIN_MODEL_HELP',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : E_DOC_NO,
                    ValueListProperty : 'FZ2_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'YEOS_MODEL_GROUP'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_REV_NO'
                }
                ,
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MEDAI_TYPE'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_DOC_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'REV_SBJCT'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MODIFY_CAUSE_N'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'APPLY_DATE_N'
                }
            ]
        }
    })
    E_DOC_NO;
}


annotate ZCDSEHBTC0007.specificationChangeMessage @(Capabilities : {
    Insertable : false,
    Deletable  : false,
    Updatable  : true,
});


annotate ZCDSEHBTC0007.specificationChangeMessage {
    @(Common : {
        Label     : 'Plant',
        ValueList : {
            CollectionPath : 'VL_SH_H_T001',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : WERKS,
                    ValueListProperty : 'BUKRS'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'BUTXT'
                }
            ]
        }
    })
    WERKS;
}

annotate ZCDSEHBTC0007.specificationChangeMessage {
    @(Common : {
        Label     : 'Production Parts',
        ValueList : {
            CollectionPath : 'ZTHBT0001',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : COMP_PART_NO,
                    ValueListProperty : 'PARTS_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : E_PART_NO,
                    ValueListProperty : 'E_PARTS_NO'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'E_PARTS_NO'
                }
            ]
        }
    })
    COMP_PART_NO;
}
// annotate ZAPIBPS0001.ZCDSEBPS0003{
     
//          @(Common : {
//            Label        : 'Parent WBS',
//             ValueList    : {
//                 CollectionPath : 'ParentWBS',
//                 Parameters     : [
//                 {
//                     $Type             : 'Common.ValueListParameterInOut',
//                     LocalDataProperty : PWBS,
//                     ValueListProperty : 'ParentWBS'
//                 },
//                 {
//                     $Type             : 'Common.ValueListParameterDisplayOnly',
//                     ValueListProperty : 'ReceiverProjDesc'
//                 },
//                 {
//                     $Type             : 'Common.ValueListParameterInOut',
//                     LocalDataProperty : PARENTWBSDESC,
//                     ValueListProperty : 'ParentProjDesc'
//                 },
//                 {
//                     $Type             : 'Common.ValueListParameterIn',
//                     ValueListProperty : 'ReceiverWBS',
//                     LocalDataProperty : RWBS,
//                 }
//                 ]
//             }
//         })
//         PWBS;
// }


annotate  ZAPIBPS0001.ZCDSEBPS0003 with @(
    UI: {
        HeaderInfo: {
            TypeName: '',
            TypeNamePlural: 'Cabinets',
            Title: { Value: ZCABNUM },
            Description: { Value: ZDESCRIP }
        },

        SelectionFields: [ PBUKR,PS_PSPNR,ZDONUM ],
        LineItem: [
            { $Type: 'UI.DataFieldForAction', Action: 'ZAPIBPS0001.pgi', Label: 'Post Good Issue'},
            { Value: PS_PSPNR },
            { Value: ProjDesc },
            { Value: ZDONUM },
            { Value: ZSHTP },
            { Value: CustomerFullName },
            { Value: ProjectManager },
            { Value: ZCABNUM },
            { Value: ZMSCODE },
            { Value: ZQTY },
            { Value: ZUT } ,
            { Value: ZDESCRIP }  
        ],
        Facets: [
            {
                $Type: 'UI.CollectionFacet',
                Label: 'Cabinets',
                Facets: [
                    {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#MainAs', Label: 'Cabinet'}
                ]
            }
        ],        
        FieldGroup#MainAs: {
            Data: [
              { Value: PS_PSPNR,![@Common.FieldControl] : #ReadOnly },
            { Value: ProjDesc,![@Common.FieldControl] : #ReadOnly },
            { Value: ZDONUM,![@Common.FieldControl] : #ReadOnly },
            { Value: ZSHTP,![@Common.FieldControl] : #ReadOnly },
            { Value: CustomerFullName,![@Common.FieldControl] : #ReadOnly },
            { Value: ProjectManager,![@Common.FieldControl] : #ReadOnly },
            { Value: ZCABNUM,![@Common.FieldControl] : #ReadOnly },
            { Value: ZMSCODE,![@Common.FieldControl] : #ReadOnly },
            { Value: ZQTY,![@Common.FieldControl] : #ReadOnly },
            { Value: ZUT,![@Common.FieldControl] : #ReadOnly }           
            ]
        }
    }
){
    
};
annotate ZAPIBPS0001.ZCDSEBPS0003 {
    @(Common : {
        ValueList : {
            CollectionPath : 'ZCDSEBPS0002',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PS_PSPNR,
                    ValueListProperty : 'ProjectId'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'ProjDesc'
                }
            ]
        }
    })
    PS_PSPNR;
    @(Common : {
        ValueList : {
            CollectionPath : 'ZTHBT0055',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : PBUKR,
                    ValueListProperty : 'PBUKR'
                },
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : PS_PSPNR,
                    ValueListProperty : 'PS_PSPNR'
                },
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ZDONUM,
                    ValueListProperty : 'ZDONUM'
                }
            ]
        }
    })
    ZDONUM;
}


annotate  ZAPIBPS0002.ZCDSEBPS0004 with @(
    UI: {
        DeleteHidden        : true,
        PresentationVariant #DSM:{
            Visualizations:['@UI.LineItem'],
            Text : 'Display By SAP Material'
        },
        HeaderInfo: {
            TypeName: '',
            TypeNamePlural: 'Project Goods Management',
            Title: { Value: 'Project Goods Management' },
            Description: { Value: 'Project Goods Management' }
        },

        SelectionFields: [ PBUKR,PSPHI,PS_PSP_PNR,ZZ1_MSCODE_PRD],
        LineItem: [ {$Type: 'UI.DataFieldForAction', Action: 'ZAPIBPS0002.updateDiffSM', Label: 'Save Reason For Difference'},
             { Value: PBUKR},
            { Value: PSPHI },
            { Value: PS_PSP_PNR },
            { Value: ZZ1_MSCODE_PRD },
            { Value: IDNLF },
            { Value: MATNR },
            { Value: ERFMG },
            { Value: ERFME },
            { Value: USEDQTY },
            { Value: ZUT } ,
            { Value: CONFIRM_STATUS, Criticality : Criticality } ,
            { Value: REASON_DIFF,![@Common.FieldControl]: #Mandatory }   
        ],
        Facets: [
            {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#MainAs', Label: 'Details'},
            {$Type: 'UI.ReferenceFacet',Label: 'Received Quantities',Target: '_ReceivedQuantities/@UI.LineItem'},
            {$Type: 'UI.ReferenceFacet',Label: 'Used Quantities',Target: '_UsedQuantities/@UI.LineItem'}
        ],        
        FieldGroup#MainAs: {
            Data: [
              { Value: PBUKR,![@Common.FieldControl] : #ReadOnly },
            { Value: PSPHI,![@Common.FieldControl] : #ReadOnly },
            { Value: PS_PSP_PNR,![@Common.FieldControl] : #ReadOnly },
            { Value: ZZ1_MSCODE_PRD,![@Common.FieldControl] : #ReadOnly },
            { Value: IDNLF,![@Common.FieldControl] : #ReadOnly },
            { Value: MATNR,![@Common.FieldControl] : #ReadOnly },
            { Value: ERFMG,![@Common.FieldControl] : #ReadOnly },
            { Value: ERFME,![@Common.FieldControl] : #ReadOnly },
            { Value: USEDQTY,![@Common.FieldControl] : #ReadOnly },
            { Value: ZUT,![@Common.FieldControl] : #ReadOnly } ,
            { Value: CONFIRM_STATUS,![@Common.FieldControl] : #ReadOnly } ,
            { Value: REASON_DIFF,![@Common.FieldControl] : #Mandatory }           
            ]
        }
    }
){
    PBUKR @title: 'Company Code' ;
    PSPHI @title: 'Project Definition';
    PS_PSP_PNR @title: 'WBS Element';
    ZZ1_MSCODE_PRD @title: 'MS Code';
    IDNLF @title: 'Vendor Material Code';
    MATNR @title: 'SAP Material';
    ERFMG @title: 'Recieved Quantity';
    ERFME @title: 'Unit';
    USEDQTY @title: 'Used Quantity';
    ZUT @title: 'Unit';
    CONFIRM_STATUS @title: 'Confirm Status';
    REASON_DIFF @title: 'Reason for Difference';
};

annotate ZAPIBPS0002.ZCDSEBPS0004 {
    @(Common : {
        ValueList : {
            CollectionPath : 'ZCDSEBPS0015',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PSPHI,
                    ValueListProperty : 'ProjectId'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'ProjDesc'
                }
            ]
        }
    })
    PSPHI;
    @(Common : {
        ValueList : {
            CollectionPath : 'Project',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PS_PSP_PNR,
                    ValueListProperty : 'wbsElementExt'
                },
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : PSPHI,
                    ValueListProperty : 'projectId'
                },
            ]
        }
    })
    PS_PSP_PNR;
    @(Common : {
        ValueList : {
            CollectionPath : 'ZCDSEBPS0011',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : PBUKR,
                    ValueListProperty : 'PBUKR'
                },
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : PSPHI,
                    ValueListProperty : 'PSPHI'
                },
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : PS_PSP_PNR,
                    ValueListProperty : 'PS_PSP_PNR'
                },
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ZZ1_MSCODE_PRD,
                    ValueListProperty : 'ZZ1_MSCODE_PRD'
                }
            ]
        }
    })
    ZZ1_MSCODE_PRD;
}
annotate ZAPIBPS0002.ZCDSEBPS0004 with @(Capabilities : {
    FilterRestrictions : {
        $Type              : 'Capabilities.FilterRestrictionsType',
        RequiredProperties : [
            PBUKR
        ],
    }
});


annotate  ZAPIBPS0002.ZCDSEBPS0009 with @(
    UI: {
        PresentationVariant:{
            Visualizations:['@UI.LineItem']
        },
        HeaderInfo: {
            TypeName: '',
            TypeNamePlural: 'Received Quantities',
            Title: { Value: 'Received Quantities' },
            Description: { Value: 'Received Quantities' }
        },
        LineItem: [
            { Value: PBUKR },
            { Value: PSPHI },
            { Value: PS_PSP_PNR },
            { Value: ZZ1_MSCODE_PRD },
            { Value: MATNR },
            { Value: ERFMG },
            { Value: ERFME },
            { Value: KDAUF },
            { Value: KDPOS }   
        ],
        Facets: [
            {
                $Type: 'UI.CollectionFacet',
                Label: 'Project Goods Management',
                Facets: [
                    {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#MainAs1', Label: 'Details'}
                ]
            }
        ],        
        FieldGroup#MainAs1: {
            Data: [
              { Value: PBUKR,![@Common.FieldControl] : #ReadOnly },
            { Value: PSPHI,![@Common.FieldControl] : #ReadOnly },
            { Value: PS_PSP_PNR,![@Common.FieldControl] : #ReadOnly },
            { Value: ZZ1_MSCODE_PRD,![@Common.FieldControl] : #ReadOnly },
            { Value: MATNR,![@Common.FieldControl] : #ReadOnly },
            { Value: ERFMG,![@Common.FieldControl] : #ReadOnly },
            { Value: ERFME,![@Common.FieldControl] : #ReadOnly },
            { Value: KDAUF,![@Common.FieldControl] : #ReadOnly },
            { Value: KDPOS,![@Common.FieldControl] : #ReadOnly }          
            ]
        }
    }
){
    PBUKR @title: 'Company Code';
    PSPHI @title: 'Project Definition';
    PS_PSP_PNR @title: 'WBS Element';
    ZZ1_MSCODE_PRD @title: 'MS Code';
    MATNR @title: 'SAP Material';
    ERFMG @title: 'Recieved Quantity';
    ERFME @title: 'Unit';
    KDAUF @title: 'Sales Order';
    KDPOS @title: 'Sales Order Item';
};

annotate  ZAPIBPS0002.ZCDSEBPS0010 with @(
    UI: {
        PresentationVariant:{
            Visualizations:['@UI.LineItem']
        },
        HeaderInfo: {
            TypeName: '',
            TypeNamePlural: 'Used Quantities',
            Title: { Value: 'Used Quantities' },
            Description: { Value: 'Used Quantities' }
        },
        LineItem: [
            { Value: PBUKR },
            { Value: PS_PSPNR },
            { Value: PS_POSNR },
            { Value: ZCABNUM },
            { Value: MATNR },
            { Value: USEDQTY },
            { Value: ZUT },
            { Value: ZCABNUM }
        ],
        Facets: [
            {
                $Type: 'UI.CollectionFacet',
                Label: 'Project Goods Management',
                Facets: [
                    {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#MainAs1', Label: 'Details'}
                ]
            }
        ],        
        FieldGroup#MainAs1: {
            Data: [
              { Value: PBUKR,![@Common.FieldControl] : #ReadOnly },
            { Value: PS_PSPNR,![@Common.FieldControl] : #ReadOnly },
            { Value: PS_POSNR,![@Common.FieldControl] : #ReadOnly },
            { Value: ZMSCODE,![@Common.FieldControl] : #ReadOnly },
            { Value: MATNR,![@Common.FieldControl] : #ReadOnly },
            { Value: USEDQTY,![@Common.FieldControl] : #ReadOnly },
            { Value: ZUT,![@Common.FieldControl] : #ReadOnly },
            { Value: ZCABNUM,![@Common.FieldControl] : #ReadOnly }         
            ]
        }
    }
){
    PBUKR @title: 'Company Code';
    PS_PSPNR @title: 'Project Definition';
    PS_POSNR @title: 'WBS Element';
    ZMSCODE @title: 'MS Code';
    MATNR @title: 'SAP Material';
    USEDQTY @title: 'Used Quantity';
    ZUT @title: 'Unit';
    ZCABNUM @title: 'Cabinet Number';
};

annotate  ZAPIBPS0002.ZCDSEBPS0011 with @(
    UI: {
        DeleteHidden        : true,
        PresentationVariant #DC:{
            Visualizations:['@UI.LineItem'],
            Text : 'Display By Component'
        },
        HeaderInfo: {
            TypeName: '',
            TypeNamePlural: 'Project Goods Management',
            Title: { Value: 'Project Goods Management' },
            Description: { Value: 'Project Goods Management' }
        },

        SelectionFields: [ PBUKR,PSPHI,PS_PSP_PNR,ZZ1_MSCODE_PRD],
        LineItem: [ { $Type: 'UI.DataFieldForAction', Action: 'ZAPIBPS0002.updateDiff', Label: 'Save Reason For Difference'},
             { Value: PBUKR},
            { Value: PSPHI },
            { Value: PS_PSP_PNR },
            { Value: ZZ1_MSCODE_PRD },
            { Value: IDNLF },
            { Value: MATNR },
            { Value: SERNR },
            { Value: ERFMG },
            { Value: ERFME },
            { Value: USEDQTY },
            { Value: ZUT } ,
            { Value: CONFIRM_STATUS, Criticality : Criticality } ,
            { Value: REASON_DIFF,![@Common.FieldControl]: #Mandatory }   
        ],
        Facets: [
            {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#MainAs', Label: 'Details'},
            {$Type: 'UI.ReferenceFacet',Label: 'Received Quantities',Target: '_ReceivedQuantities/@UI.LineItem'},
            {$Type: 'UI.ReferenceFacet',Label: 'Used Quantities',Target: '_UsedQuantities/@UI.LineItem'}
        ],        
        FieldGroup#MainAs: {
            Data: [
              { Value: PBUKR,![@Common.FieldControl] : #ReadOnly },
            { Value: PSPHI,![@Common.FieldControl] : #ReadOnly },
            { Value: PS_PSP_PNR,![@Common.FieldControl] : #ReadOnly },
            { Value: ZZ1_MSCODE_PRD,![@Common.FieldControl] : #ReadOnly },
            { Value: IDNLF,![@Common.FieldControl] : #ReadOnly },
            { Value: MATNR,![@Common.FieldControl] : #ReadOnly },
            { Value: SERNR,![@Common.FieldControl] : #ReadOnly },
            { Value: ERFMG,![@Common.FieldControl] : #ReadOnly },
            { Value: ERFME,![@Common.FieldControl] : #ReadOnly },
            { Value: USEDQTY,![@Common.FieldControl] : #ReadOnly },
            { Value: ZUT,![@Common.FieldControl] : #ReadOnly } ,
            { Value: CONFIRM_STATUS,![@Common.FieldControl] : #ReadOnly } ,
            { Value: REASON_DIFF,![@Common.FieldControl] : #Mandatory }           
            ]
        }
    }
){
    PBUKR @title: 'Company Code';
    PSPHI @title: 'Project Definition';
    PS_PSP_PNR @title: 'WBS Element';
    ZZ1_MSCODE_PRD @title: 'MS Code';
    IDNLF @title: 'Vendor Material Code';
    MATNR @title: 'SAP Material';
    SERNR @title: 'Serial Number';
    ERFMG @title: 'Recieved Quantity';
    ERFME @title: 'Unit';
    USEDQTY @title: 'Used Quantity';
    ZUT @title: 'Unit';
    CONFIRM_STATUS @title: 'Confirm Status';
    REASON_DIFF @title: 'Reason for Difference';
};
annotate ZAPIBPS0002.ZCDSEBPS0011 {
    @(Common : {
        ValueList : {
            CollectionPath : 'ZCDSEBPS0015',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PSPHI,
                    ValueListProperty : 'ProjectId'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'ProjDesc'
                }
            ]
        }
    })
    PSPHI;
    @(Common : {
        ValueList : {
            CollectionPath : 'Project',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PS_PSP_PNR,
                    ValueListProperty : 'wbsElementExt'
                },
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : PSPHI,
                    ValueListProperty : 'projectId'
                },
            ]
        }
    })
    PS_PSP_PNR;
    @(Common : {
        ValueList : {
            CollectionPath : 'ZCDSEBPS0011',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : PBUKR,
                    ValueListProperty : 'PBUKR'
                },
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : PSPHI,
                    ValueListProperty : 'PSPHI'
                },
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : PS_PSP_PNR,
                    ValueListProperty : 'PS_PSP_PNR'
                },
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ZZ1_MSCODE_PRD,
                    ValueListProperty : 'ZZ1_MSCODE_PRD'
                }
            ]
        }
    })
    ZZ1_MSCODE_PRD;
}
annotate ZAPIBPS0002.ZCDSEBPS0011 with @(Capabilities : {
    FilterRestrictions : {
        $Type              : 'Capabilities.FilterRestrictionsType',
        RequiredProperties : [
            PBUKR
        ],
    }
});

annotate ZAPIBPS0001.ZCDSEBPS0013 with {
    ZDONUM  @title : 'DO Number';
}
annotate ZAPIBPS0001.ZCDSEBPS0013 @(Capabilities.FilterRestrictions : {
   FilterExpressionRestrictions : [
        {
            Property : PS_PSPNR,
            AllowedExpressions : 'SingleValue'
        }
    ]
});
annotate ZAPIBPS0001.ZCDSEBPS0013 @(Capabilities : {
    SearchRestrictions : {
        $Type      : 'Capabilities.SearchRestrictionsType',
        Searchable : false
    },
    InsertRestrictions : {
        $Type : 'Capabilities.InsertRestrictionsType',
        Insertable: false
    },
    DeleteRestrictions : {
        $Type : 'Capabilities.DeleteRestrictionsType',
        Deletable: false
    }
});
annotate ZAPIBPS0001.ZCDSEBPS0013 with @(
    
    UI : { 
        SelectionFields  : [
            PBUKR,PS_PSPNR,ZDONUM
        ],
        LineItem  : [
            { Value : ZDONUM },
            { Value : ZDOITEM },
            { Value : ZSHPSTAT }, 
            { Value : ZSHTP },
            { Value : MATNR },
            { Value : ZMSCODE },
            { Value : ZVMCODE },
            { Value : ZQTY },
            { Value : ZDESCRIP },  
            { Value : ZDOPDATE },
            { Value : CustomerFullName },  
            { Value : ZCONTACTTEL },
            { Value : ZSHPNAME1 },
            { Value : ZSHPNAME2 },
            { Value : ZSHPNAME3 },
            { Value : ZSHPNAME4 },
             { Value : PS_PSPNR }, 
             { Value : PBUKR }                                 
        ],
     }
){
};
annotate ZAPIBPS0001.ZCDSEBPS0013 with @(Capabilities : {
    FilterRestrictions : {
        $Type              : 'Capabilities.FilterRestrictionsType',
        RequiredProperties : [
            PBUKR,
            PS_PSPNR,
            ZDONUM
        ],
    }
});

annotate ZAPIBPS0001.ZCDSEBPS0013 {
    @(Common : {
        Label     : 'Company Code',
        ValueList : {
            CollectionPath : 'ZTHBT0055',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PBUKR,
                    ValueListProperty : 'PBUKR'
                }
            ]
        }
    })
    PBUKR;
}
annotate ZAPIBPS0001.ZCDSEBPS0013 {
    @(Common : {
        Label     : 'Project Definition',
        ValueList : {
            CollectionPath : 'ZTHBT0055',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PS_PSPNR,
                    ValueListProperty : 'PS_PSPNR'
                }
            ]
        }
    })
    PS_PSPNR;
}
annotate ZAPIBPS0001.ZCDSEBPS0013 {
    @(Common : {
        Label     : 'Do Number',
        ValueList : {
            CollectionPath : 'ZTHBT0055',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ZDONUM,
                    ValueListProperty : 'ZDONUM'
                }
            ]
        }
    })
    ZDONUM;
}
annotate ZAPIBPS0001.ZCDSEBPS0013 with {
ZSHPSTAT @UI.HiddenFilter: true;
}
annotate ZAPIBPS0001.ZCDSEBPS0013 with {
    @Common.FilterDefaultValue : '6W00'
    PBUKR
};


annotate  ZAPIBPS0004.ZCDSEBPS0012 with @(
    UI: {
        DeleteHidden        : true,
        CreateHidden        : true,
        SelectionVariant #CAB:{
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
                {
                    $Type : 'UI.SelectOptionType',
                    PropertyName : ZZ1_MSCODE,
                    Ranges : [
                        {
                            $Type : 'UI.SelectionRangeType',
                            Option : #EQ,
                            Low : '010',
                            High : '',
                            Sign:#I
                        }
                    ]
                }
            ],
            Text : 'Only Cabinet or Loose Items'
        },
        SelectionVariant #ALL:{
            $Type : 'UI.SelectionVariantType',
            Text : 'Include All item'
        },
        HeaderInfo: {
            TypeName: '',
            TypeNamePlural: 'Cabinet Component & Shipping Status',
            Title: { Value: 'Cabinet Component & Shipping Status' },
            Description: { Value: 'Cabinet Component & Shipping Status' }
        },

        SelectionFields: [ PBUKR,PS_PSPNR,PS_POSNR,ZDOPDATE,ZSHPSTAT],
        LineItem: [ { $Type: 'UI.DataFieldForAction', Action: 'ZAPIBPS0004.DeleteSet', Label: 'Delete',InvocationGrouping : #ChangeSet},
            { $Type: 'UI.DataFieldForAction', Action: 'ZAPIBPS0004.split', Label: 'Split',InvocationGrouping : #ChangeSet},
            { $Type: 'UI.DataFieldForAction', Action: 'ZAPIBPS0004.copy', Label: 'Copy'},
            { $Type: 'UI.DataFieldForAction', Action: 'ZAPIBPS0004.paste', Label: 'Paste',InvocationGrouping : #ChangeSet},
            { $Type: 'UI.DataFieldForAction', Action: 'ZAPIBPS0004.DOCreate', Label: 'DO Create', InvocationGrouping : #ChangeSet},
            { $Type: 'UI.DataFieldForAction', Action: 'ZAPIBPS0004.MassEdit', Label: 'MassEdit',InvocationGrouping : #ChangeSet},  
            { Value: PBUKR },
            { Value: PS_PSPNR },
            { Value: ZMSCODE},
            { Value: PS_POSNR },
            { Value: MATNR },
            { Value: ZZ1_MSCODE },
            { Value: ZIDEX },
            { Value: ZVMCODE },
            { Value: ZQTY},
            { Value: ZUT},
            { Value: ZDESCRIP },
            { Value: ZSER },
            { Value: ZSHTP },
            { Value: ZSHPNAME1},
            { Value: ZSHPNAME2 },
            { Value: ZSHPNAME3},
            { Value: ZSHPNAME4},
            { Value: ZCONTACTTEL },
            { Value: ZDELNOTE1},
            { Value: ZDELNOTE2},
            { Value: ZDONUM},
            { Value: ZDOITEM},
            { Value: ZDOPDATE },
            { Value: ZDOADATE },
            { Value: ZDELFLAG},
            { Value: ZSHPSTAT},
            { Value: PostalCode},
            { Value: Region},
            { Value: City},
            { Value: StreetName},
            { Value: TelephoneNumber1},
            { Value: BusinessPartnerName3},
            { Value: BusinessPartnerName4},
            { Value: StreetPrefixName},
            { Value: AdditionalStreetPrefixName},
            { Value: CRITICALITY, Criticality : CRITICALITY},
            { Value: REMARKS}

        ],
        Facets: [
            {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#MainAs', Label: 'Details'}
        ],        
        FieldGroup#MainAs: {
            Data: [
              { Value: ZCABNUM,![@Common.FieldControl] : #ReadOnly },
            { Value: PBUKR,![@Common.FieldControl] : #ReadOnly },
            { Value: PS_PSPNR,![@Common.FieldControl] : #ReadOnly },
            { Value: ZMSCODE,![@Common.FieldControl] : #ReadOnly },
            { Value: PS_POSNR,![@Common.FieldControl] : #ReadOnly },
            { Value: MATNR,![@Common.FieldControl] : #ReadOnly },
            { Value: ZZ1_MSCODE,![@Common.FieldControl] : #ReadOnly },
            { Value: ZIDEX,![@Common.FieldControl] : #ReadOnly },
            { Value: ZVMCODE,![@Common.FieldControl] : #ReadOnly },
            { Value: ZQTY,![@Common.FieldControl] : #ReadOnly },
            { Value: ZUT,![@Common.FieldControl] : #ReadOnly },
            { Value: ZDESCRIP ,![@Common.FieldControl] : #ReadOnly },
            { Value: ZSER },
            { Value: ZSHTP },
            { Value: ZSHPNAME1},
            { Value: ZSHPNAME2  },
            { Value: ZSHPNAME3 },
            { Value: ZSHPNAME4 },
            { Value: ZCONTACTTEL },
            { Value: ZDELNOTE1 },
            { Value: ZDELNOTE2 },
            { Value: ZDONUM},
            { Value: ZDOITEM,![@Common.FieldControl] : #ReadOnly },
            { Value: ZDOPDATE  },
            { Value: ZDOADATE ,![@Common.FieldControl] : #ReadOnly },
            { Value: ZDELFLAG,![@Common.FieldControl] : #ReadOnly },
            { Value: ZSHPSTAT,![@Common.FieldControl] : #ReadOnly },
            { Value: PostalCode,![@Common.FieldControl] : #ReadOnly },
            { Value: Region,![@Common.FieldControl] : #ReadOnly },
            { Value: City,![@Common.FieldControl] : #ReadOnly },
            { Value: StreetName,![@Common.FieldControl] : #ReadOnly },
            { Value: TelephoneNumber1,![@Common.FieldControl] : #ReadOnly },
            { Value: BusinessPartnerName3,![@Common.FieldControl] : #ReadOnly },
            { Value: BusinessPartnerName4,![@Common.FieldControl] : #ReadOnly },
            { Value: StreetPrefixName,![@Common.FieldControl] : #ReadOnly },
            { Value: AdditionalStreetPrefixName,![@Common.FieldControl] : #ReadOnly },
            { Value: CRITICALITY,![@Common.FieldControl] : #ReadOnly },
            { Value: REMARKS,![@Common.FieldControl] : #ReadOnly }
         
            ]
        }
    }
){
    
            PBUKR @title: 'Company code' ;
            PS_PSPNR @title: 'Project Definition';
            PS_POSNR @title: 'WBS Element';
            MATNR @title: 'SAP Material';
            ZZ1_MSCODE @title: 'Material Type code';
            ZIDEX @title: 'Material type code description';
            ZCABNUM @title: 'Cabinet number';
            ZMSCODE @title: 'MS Code';
            ZVMCODE @title: 'Vendor Material Code';
            ZQTY @title: 'Quantity';
            ZUT @title: 'UNIT';
            ZDESCRIP @title: 'Material Description';			
            ZSER @title: 'Serial Number';
            ZSHTP @title: 'Ship-to-Party';	
            name1 @title: 'Name1';
            name2 @title: 'Name2';
            BusinessPartnerName3 @title: 'Name3';
            BusinessPartnerName4 @title: 'Name4';
            PostalCode @title: 'Postal Code';
            Region @title: 'Region';
            City @title: 'City';
            StreetName @title: 'Street1';
            StreetPrefixName @title: 'Street2';
            AdditionalStreetPrefixName @title: 'Street3';
            TelephoneNumber1 @title: 'Telephone';
            ZDONUM @title: 'Do number';
            ZDOITEM @title: 'Do number Item';
            ZDOADATE @title: 'DO Actual date';
            ZSHPSTAT @title: 'Shipping status';
            ZSHPNAME1 @title: 'Contact Ship to Name1';
            ZSHPNAME2 @title: 'Contact Ship to Name2';
            ZSHPNAME3 @title: 'Contact Ship to Name3';
            ZSHPNAME4 @title: 'Contact Ship to Name4';
            ZCONTACTTEL @title: 'Contact ship to telephone';	
            ZDOPDATE @title: 'DO plan date';
            ZDELNOTE1 @title: 'Delivery notes 1';
            ZDELNOTE2 @title: 'Delivery notes 2';	
            ZDELFLAG @title: 'Deletion flag';
            CRITICALITY @title: 'Confirm status';
            REMARKS @title: 'Remark';
};
annotate ZAPIBPS0004.ZCDSEBPS0012 with @(Capabilities : {
    FilterRestrictions : {
        $Type              : 'Capabilities.FilterRestrictionsType',
        RequiredProperties : [
            PBUKR,
            PS_PSPNR
        ],
    }
});


annotate ZCAPIH0018.ZCDSEHPPB0085 @(Capabilities.FilterRestrictions : {
   FilterExpressionRestrictions : [
        {
            Property : plt_issfrm,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : plant_issto,
            AllowedExpressions : 'SingleValue'
        }
    ]
});


annotate ZCAPIH0018.ZCDSEHPPB0085 {
    @(Common : {
        Label     : 'Material',
        ValueList : {
            CollectionPath : 'I_MaterialStdVH',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : material,
                    ValueListProperty : 'Material'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Material_Text'
                }
            ]
        }
    })
    material;
    @(Common : {
        Label     : 'Plant Issued From',
        ValueList : {
            CollectionPath : 'I_PlantStdVH',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : plt_issfrm,
                    ValueListProperty : 'Plant'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'PlantName'
                }
            ]
        }
    })
    plt_issfrm;
    @(Common : {
        Label     : 'Plant Issued To',
        ValueList : {
            CollectionPath : 'I_PlantStdVH',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : plant_issto,
                    ValueListProperty : 'Plant'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'PlantName'
                }
            ]
        }
    })
    plant_issto;
    @(Common : {
        Label     : 'Storage Location From',
        ValueList : {
            CollectionPath : 'I_StorageLocationStdVH',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : sloc_issfrm,
                    ValueListProperty : 'StorageLocation'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'StorageLocationName'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Plant'
                }
            ]
        }
    })
    sloc_issfrm;
    @(Common : {
        Label     : 'Storage Location To',
        ValueList : {
            CollectionPath : 'I_StorageLocationStdVH',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : sloc_issto,
                    ValueListProperty : 'StorageLocation'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'StorageLocationName'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Plant'
                }
            ]
        }
    })
    sloc_issto;
}

annotate ZAPIBPS0004.ZCDSEBPS0012 {
    @(Common : {
        ValueList : {
            CollectionPath : 'ZCDSEBPS0015',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PS_PSPNR,
                    ValueListProperty : 'ProjectId'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'ProjDesc'
                }
            ]
        }
    })
    PS_PSPNR;
    @(Common : {
        ValueList : {
            CollectionPath : 'Project',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PS_POSNR,
                    ValueListProperty : 'wbsElementExt'
                },
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : PS_PSPNR,
                    ValueListProperty : 'projectId'
                },
            ]
        }
    })
    PS_POSNR;
    @(Common : {
        ValueList : {
            CollectionPath : 'ZCDSEBPS0016',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : PBUKR,
                    ValueListProperty : 'PBUKR'
                },
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : PS_PSPNR,
                    ValueListProperty : 'PSPHI'
                },
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : MATNR,
                    ValueListProperty : 'MATNR'
                },
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ZSER,
                    ValueListProperty : 'SERNR'
                }
            ]
        }
    })
    ZSER;
    @(Common : {
        ValueList : {
            CollectionPath : 'Customer',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ZSHTP,
                    ValueListProperty : 'Customer'
                },
                {
                    $Type             : 'Common.ValueListParameterOut',
                    LocalDataProperty : name1,
                    ValueListProperty : 'name1'
                },
                {
                    $Type             : 'Common.ValueListParameterOut',
                    LocalDataProperty : name2,
                    ValueListProperty : 'name2'
                },
                {
                    $Type             : 'Common.ValueListParameterOut',
                    LocalDataProperty : PostalCode,
                    ValueListProperty : 'PostalCode'
                },
                {
                    $Type             : 'Common.ValueListParameterOut',
                    LocalDataProperty : Region,
                    ValueListProperty : 'Region'
                },
                {
                    $Type             : 'Common.ValueListParameterOut',
                    LocalDataProperty : City,
                    ValueListProperty : 'City'
                },
                {
                    $Type             : 'Common.ValueListParameterOut',
                    LocalDataProperty : StreetName,
                    ValueListProperty : 'StreetName'
                },
                {
                    $Type             : 'Common.ValueListParameterOut',
                    LocalDataProperty : TelephoneNumber1,
                    ValueListProperty : 'TelephoneNumber1'
                },
                {
                    $Type             : 'Common.ValueListParameterOut',
                    LocalDataProperty : BusinessPartnerName3,
                    ValueListProperty : 'BusinessPartnerName3'
                },
                {
                    $Type             : 'Common.ValueListParameterOut',
                    LocalDataProperty : BusinessPartnerName4,
                    ValueListProperty : 'BusinessPartnerName4'
                },
                {
                    $Type             : 'Common.ValueListParameterOut',
                    LocalDataProperty : StreetPrefixName,
                    ValueListProperty : 'StreetPrefixName'
                },
                {
                    $Type             : 'Common.ValueListParameterOut',
                    LocalDataProperty : AdditionalStreetPrefixName,
                    ValueListProperty : 'AdditionalStreetPrefixName'
                }
            ]
        }
    })
    ZSHTP;
};
annotate ZCAPIH0019.CompletionGoodsReceipt {
    @(Common : {
        Label     : 'Plant',
        ValueList : {
            CollectionPath : 'VL_SH_H_T001',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Plant,
                    ValueListProperty : 'BUKRS'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'BUTXT'
                }
            ]
        }
    })
    Plant;
}

annotate  YAPIARD.yentard with @(
    UI: {
        
        HeaderInfo: {
            TypeName: '',
            TypeNamePlural: 'Cabinet Component & Shipping Status',
            Title: { Value: 'Cabinet Component & Shipping Status' },
            Description: { Value: 'Cabinet Component & Shipping Status' }
        },

        SelectionFields: [ name],
        LineItem: [ 
            { Value: name },
            {Value: DOB}
        ],
        Facets: [
            {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#MainAs', Label: 'Details'}
        ],        
        FieldGroup#MainAs: {
            Data: [
              { Value: name },
              { Value: DOB}
            ]
        }
    }
){
            name @title: 'Name';
            DOB @title: 'Date Of Birth';
}



//Valuehelp
annotate ZCDSEHBTC0014.ZCDSEHPPP0004 {  
    @(Common : {
        Label     : 'Material',
        ValueList : {
            CollectionPath : 'I_MaterialStdVH',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : matnr,
                    ValueListProperty : 'Material'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Material_Text'
                } 
            ]
        }
    })
    matnr; 
    @(Common : {
        Label     : 'Storage Location',
        ValueList : {
            CollectionPath : 'I_StorageLocationStdVH',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Storgloc,
                    ValueListProperty : 'StorageLocation'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'StorageLocationName'
                } ,
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Plant'
                } 
            ]
        }
    })
    Storgloc; 
    @(Common : {
        Label     : 'Storage Location',
        ValueList : {
            CollectionPath : 'I_StorageLocationStdVH',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : lgort,
                    ValueListProperty : 'StorageLocation'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'StorageLocationName'
                } ,
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Plant'
                } 
            ]
        }
    })
    lgort; 
    @(Common : {
        Label     : 'Plant',
        ValueList : {
            CollectionPath : 'I_PlantStdVH',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Plant,
                    ValueListProperty : 'Plant'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'PlantName'
                } 
            ]
        }
    })
    Plant; 
    @(Common : {
        Label     : 'Sales Document',
        ValueList : {
            CollectionPath : 'I_SalesDocumentBasic',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : vbeln,
                    ValueListProperty : 'SalesDocument'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'SDDocumentCategory'
                } ,
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'SalesDocumentType'
                } ,
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'SalesOffice'
                } ,
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'SoldToParty'
                } 
            ]
        }
    })
    vbeln; 
}

annotate ZCDSEHBTC0014.ZCDSEHPPP0004 @(Capabilities.FilterRestrictions : {
   FilterExpressionRestrictions : [
        {
            Property : Plant,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : Storgloc,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : MScode,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : matnr,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : serno,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : Msalesord,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : Msalesorditm,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : compno,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : PlannedOrder,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : ProductionOrder,
            AllowedExpressions : 'SingleValue'
         }
    ]
});

annotate  ZCDSEHBTC0014.ZCDSEHPPP0004 with @(
    UI: {
        LineItem: [
            { Value: matnr, ![@Common.Label] : 'Mat. No. (Avail. Stock)' },
            { Value: salesdocument, ![@Common.Label] : 'Sales Order' },
            { Value: item , ![@Common.Label] : 'Sales Order Item'},
            { Value: compponentno, ![@Common.Label] : 'COMP' } ,
            { Value: Storgloc , ![@Common.Label] : 'Storage Location'} ,
            { Value: UnrestrictedUseStock , ![@Common.Label] : 'Unrestricted-Use Stock'} ,
            { Value: BlockedStock , ![@Common.Label] : 'Blocked Stock'} ,
            { Value: Reservstock , ![@Common.Label] : 'Reserved Stock'} ,
            { Value: srlnm , ![@Common.Label] : 'Serial'} ,
            { Value: OrderType , ![@Common.Label] : 'Sales Order Type' } ,
            { Value: MaterialType, ![@Common.Label] : 'Material Type' } ,
            { Value: Msalesord , ![@Common.Label] : 'MS Code of Main Sales Order'} ,
            { Value: MScode , ![@Common.Label] : 'MS Code (Avail.stock)'} ,
            { Value: Msalesord, ![@Common.Label] : 'Main Sales Order' } ,
            { Value: Msalesorditm, ![@Common.Label] : 'Main Sales Order Item' } ,
            { Value: compno , ![@Common.Label] : 'Main COMP'} ,
            { Value: matnr , ![@Common.Label] : 'Main Material'  } ,
            { Value: SerialNumber , ![@Common.Label] : 'Main Serial' }             
        ]
    }
);


annotate ZAPIBPS0006.ZCDSEHPPB0081 @(Capabilities.FilterRestrictions : {
   FilterExpressionRestrictions : [
        {
            Property : plant,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : mscode,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : saleorder,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : saleorderitm,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : qty,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : material,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : outofstock_dt,
            AllowedExpressions : 'SingleValue'
        }
    ]
});

annotate  ZAPIBPS0006.ZCDSEHPPB0081 with @(
    UI: {
        LineItem: [
            { Value: mscode, ![@Common.Label] : 'MS Code' },
            { Value: material, ![@Common.Label] : 'Material' },
            { Value: material_type , ![@Common.Label] : 'Material Type'},
            { Value: avail_after, ![@Common.Label] : 'Available (After)' } ,
            { Value: avail_befor , ![@Common.Label] : 'Available (Before)'} ,
            { Value: actual , ![@Common.Label] : 'Actual'} ,
            { Value: planned_gr , ![@Common.Label] : 'Planned GR'} ,
            { Value: planned_gi , ![@Common.Label] : 'Planned GI'} ,
            { Value: reserved , ![@Common.Label] : 'Reserved'} ,
            { Value: outofstock_dt , ![@Common.Label] : 'Date (out of stock)' } ,
            { Value: qty, ![@Common.Label] : 'Qty (Out of stock)' } ,
            { Value: totalplanned_gi , ![@Common.Label] : 'Total Planned GI'} ,
            { Value: totalres , ![@Common.Label] : 'Total reserved'}           
        ]
    }
);

//Valuehelp
annotate ZAPIBPS0007.IndividualIssue {  
    @(Common : {
        Label     : 'Material',
        ValueList : {
            CollectionPath : 'I_MaterialStdVH',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Material,
                    ValueListProperty : 'Material'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Material_Text'
                } 
            ]
        }
    })
    Material; 
    @(Common : {
        Label     : 'Storage Location From',
        ValueList : {
            CollectionPath : 'I_StorageLocationStdVH',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : StorageLocationFrom,
                    ValueListProperty : 'StorageLocation'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'StorageLocationName'
                }
            ]
        }
    })
    StorageLocationFrom; 
    @(Common : {
        Label     : 'Storage Location To',
        ValueList : {
            CollectionPath : 'I_StorageLocationStdVH',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : StorageLocationTo,
                    ValueListProperty : 'StorageLocation'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'StorageLocationName'
                }
            ]
        }
    })
    StorageLocationTo; 
    @(Common : {
        Label     : 'Plant',
        ValueList : {
            CollectionPath : 'I_PlantStdVH',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : plant,
                    ValueListProperty : 'Plant'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'PlantName'
                } 
            ]
        }
    })
    plant; 
    @(Common : {
        Label     : 'GL Account',
        ValueList : {
            CollectionPath : 'I_GLAccountStdVH',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : GLAccountcode,
                    ValueListProperty : 'GLAccount'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'GLAccount_Text'
                }
            ]
        }
    })
    GLAccountcode; 
    @(Common : {
        Label     : 'Production Order',
        ValueList : {
            CollectionPath : 'I_ProductionOrderStdVH',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ProdOrder,
                    ValueListProperty : 'ProductionOrder'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'OrderDescription'
                }
            ]
        }
    })
    ProdOrder; 
    @(Common : {
        Label     : 'Cost Center',
        ValueList : {
            CollectionPath : 'I_CostCenterStdVH',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Costcenter,
                    ValueListProperty : 'CostCenter'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'CostCenter_Text'
                }
            ]
        }
    })
    Costcenter; 
}

//Valuehelp
annotate ZCDSEHBTC0015.OrderPartInformation {  
    @(Common : {
        Label     : 'By-Order Category',
        ValueList : {
            CollectionPath : 'ZCDSEHMMB0043',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : vagrp,
                    ValueListProperty : 'Fevor'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Txt'
                } 
            ]
        }
    })
    vagrp; 
    @(Common : {
        Label     : 'MRP controller',
        ValueList : {
            CollectionPath : 'ZCDSEHMMB0044',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : dispo,
                    ValueListProperty : 'dispo'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'dispo'
                }
            ]
        }
    })
    dispo; 
    @(Common : {
        Label     : 'Planned Order',
        ValueList : {
            CollectionPath : 'ZCDSEHMMB0045',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : plnum,
                    ValueListProperty : 'plnum'
                }
            ]
        }
    })
    plnum; 
    @(Common : {
        Label     : 'Plant',
        ValueList : {
            CollectionPath : 'I_PlantStdVH',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : plwrk,
                    ValueListProperty : 'Plant'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'PlantName'
                } 
            ]
        }
    })
    plwrk; 
    
}

//9994 BOM Explosion
annotate ZAPIBPS0008.ZCDSEHMMC0012 @(Capabilities.FilterRestrictions : {
   FilterExpressionRestrictions : [
        {
            Property : InputType,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : InputTypeCode,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : plant,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : Material,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : MaterialType,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : lgpro,
            AllowedExpressions : 'SingleValue'
        }
    ]
});
annotate ZAPIBPS0007.IndividualIssue {
    @Common.ValueListWithFixedValues : true
    @(Common : {
        Label     : 'Input Field',
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'InputField',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Inputfield,
                    ValueListProperty : 'InputFieldDesc'
                }
            ]
        }
    })
    Inputfield;
}

annotate ZAPIBPS0007.IndividualIssue {
    @Common.ValueListWithFixedValues : true
    @(Common : {
        Label     : 'Option',
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'option',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : option,
                    ValueListProperty : 'optionDesc'
                }
            ]
        }
    })
    option;
}
annotate ZAPIBPS0007.IndividualIssue {
    @Common.ValueListWithFixedValues : true
    @(Common : {
        Label     : 'Order Transfer',
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'OrderTransfer',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : OrderTransfer,
                    ValueListProperty : 'OrderTransferDesc'
                }
            ]
        }
    })
    OrderTransfer;
}


//Production Order Status List zhpp0005 8727
//Cancelled Order List
annotate ZAPIBPS0011.ZCDSEHPPC0013 with @(UI : {
    HeaderInfo : {
        $Type             :  'UI.HeaderInfoType',
        TypeName          : 'Cancelled Production Order',
        TypeNamePlural    : 'Cancelled Production Order'
    },
    LineItem #CancellOrderList : {
        $value : [
            {
                $Type : 'UI.DataField',
                Value : dwerk
            },
            {
                $Type : 'UI.DataField',
                Value : dispo
            },
            {
                $Type : 'UI.DataField',
                Value : arbpl
            },
            {
                $Type : 'UI.DataField',
                Value : aufnr
            },
            {
                $Type : 'UI.DataField',
                Value : Total_val
            },
            {
                $Type : 'UI.DataField',
                Value : currencycode
            },
            {
                $Type : 'UI.DataField',
                Value : dauat
            },
            {
                $Type : 'UI.DataField',
                Value : matnr
            },
            {
                $Type : 'UI.DataField',
                Value : maktx
            },
            {
                $Type : 'UI.DataField',
                Value : kdauf
            },
            {
                $Type : 'UI.DataField',
                Value : kdpos
            },
            {
                $Type : 'UI.DataField',
                Value : zz1_linkagenumber_sdi
            },
            {
                $Type : 'UI.DataField',
                Value : gamng
            },
            {
                $Type : 'UI.DataField',
                Value : gmein
            },
            {
                $Type : 'UI.DataField',
                Value : txt04
            },
            {
                $Type : 'UI.DataField',
                Value : gamng
            }
        ]
    }
}){    
    Total_val @( title: 'Total Value in CO Currency' );
    matnr @( title: 'Order Material' );
    gmein @( title: 'Common unit of measure for all order items' );
    txt04 @( title: 'System status' );
    STATUS @( title: 'Production status' );
};

annotate ZAPIBPS0011.ZCDSEHPPC0013 with @(
  UI.SelectionPresentationVariant #CancellOrderList : {
    Text : 'Planned Order status List',
    SelectionVariant : { 
        Text : 'CancellOrderList',
        SelectOptions : [
            {
                $Type : 'UI.SelectOptionType',
                PropertyName : dwerk,
            }
        ]
    },
    PresentationVariant : {
        SortOrder : [
            {
                Property : dwerk,
                Descending : false
            }
        ],
        Visualizations : ['@UI.LineItem#CancellOrderList']
    }
  }
);

//Production Order Status List zhpp0005 8727
//Production Order Operation List
annotate ZAPIBPS0011.ZCDSEHPPC0012 with @(UI : {
    HeaderInfo : {
        $Type             :  'UI.HeaderInfoType',
        TypeName          : 'Production Order Operation List',
        TypeNamePlural    : 'Production Order Operation List'
    },
    LineItem #ProductionOrderOperationList : {
        $value : [
            {
                $Type : 'UI.DataField',
                Value : aufnr
            },
            {
                $Type : 'UI.DataField',
                Value : vornr
            },
            {
                $Type : 'UI.DataField',
                Value : arbpl
            },
            {
                $Type : 'UI.DataField',
                Value : ktext
            },
            {
                $Type : 'UI.DataField',
                Value : ltxa1
            },
            {
                $Type : 'UI.DataField',
                Value : steus
            },
            {
                $Type : 'UI.DataField',
                Value : qlkapar
            },
            {
                $Type : 'UI.DataField',
                Value : mgvrg
            },
            {
                $Type : 'UI.DataField',
                Value : meinh
            },
            {
                $Type : 'UI.DataField',
                Value : isdd
            },
            {
                $Type : 'UI.DataField',
                Value : ierd
            },
            {
                $Type : 'UI.DataField',
                Value : txt04
            },
            {
                $Type : 'UI.DataField',
                Value : rueck
            },
            {
                $Type : 'UI.DataField',
                Value : kostv
            },
            {
                $Type : 'UI.DataField',
                Value : ebeln
            },
            {
                $Type : 'UI.DataField',
                Value : ism03
            },
            {
                $Type : 'UI.DataField',
                Value : ile03
            },
            {
                $Type : 'UI.DataField',
                Value : ism04
            },
            {
                $Type : 'UI.DataField',
                Value : ile04
            },
            {
                $Type : 'UI.DataField',
                Value : ism05
            },
            {
                $Type : 'UI.DataField',
                Value : ile05
            }
        ]
    }
}){    
    aufnr @( title: 'Production Order' );
    vornr @( title: 'Operation' );
    arbpl @( title: 'Work Center' );
    ktext @( title: 'Work Center Text' );
    ltxa1 @( title: 'Operation Text' );
    steus @( title: 'Control Key' );
    qlkapar @( title: 'Capacity Category' );
    mgvrg @( title: 'Operation Qty' );
    meinh @( title: 'Operation UoM' );
    isdd @( title: 'Actual Start Date' );
    ierd @( title: 'Actual Finish' );
    txt04 @( title: 'System status' );
    rueck @( title: 'Confirmation No.' );
    kostv @( title: 'Cost Center' );
    ebeln @( title: 'PO' );
    ism03 @( title: 'Set up' );
    ile03 @( title: 'Base Unit' );
    ism04 @( title: 'Machine' );
    ile04 @( title: 'Base Unit' );
    ism05 @( title: 'Labor' );
    ile05 @( title: 'Base Unit' );
};

annotate ZAPIBPS0011.ZCDSEHPPC0012 with @(
  UI.SelectionPresentationVariant #ProductionOrderOperationList : {
    Text : 'Production Order Operation List',
    SelectionVariant : { 
        Text : 'ProductionOrderOperationList',
        SelectOptions : [
            {
                $Type : 'UI.SelectOptionType',
                PropertyName : aufnr,
            }
        ]
    },
    PresentationVariant : {
        SortOrder : [
            {
                Property : aufnr,
                Descending : false
            }
        ],
        Visualizations : ['@UI.LineItem#ProductionOrderOperationList']
    }
  }
);

//Production Order Status List zhpp0005 8727
//Planned Order Component list
annotate ZAPIBPS0011.ZCDSEHPPC0023 with @(UI : {
    HeaderInfo : {
        $Type             :  'UI.HeaderInfoType',
        TypeName          : 'Planned Order Component list',
        TypeNamePlural    : 'Planned Order Component list'
    },
    LineItem #PlannedOrderComponentlist : {
        $value : [
            {
                $Type : 'UI.DataField',
                Value : aufnr
            },
            {
                $Type : 'UI.DataField',
                Value : plnum
            },
            {
                $Type : 'UI.DataField',
                Value : matnr
            },
            // {
            //     $Type : 'UI.DataField',
            //     Value : zz1_mscode_prd
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Value : comp_part
            // },
            {
                $Type : 'UI.DataField',
                Value : maktx
            },
            {
                $Type : 'UI.DataField',
                Value : posnr_rma
            },
            {
                $Type : 'UI.DataField',
                Value : bdter
            },
            {
                $Type : 'UI.DataField',
                Value : bdmng
            },
            {
                $Type : 'UI.DataField',
                Value : meins
            },
            {
                $Type : 'UI.DataField',
                Value : werks
            },
            {
                $Type : 'UI.DataField',
                Value : lgort
            },
            {
                $Type : 'UI.DataField',
                Value : dismm
            },
            {
                $Type : 'UI.DataField',
                Value : beskz
            },
            {
                $Type : 'UI.DataField',
                Value : sobsl
            },
            {
                $Type : 'UI.DataField',
                Value : schgt
            },
            {
                $Type : 'UI.DataField',
                Value : rgekz
            },
            {
                $Type : 'UI.DataField',
                Value : stprs
            },
            {
                $Type : 'UI.DataField',
                Value : peinh
            }
        ]
    }
}){    
    aufnr @( title: 'Production Order' );
    plnum @( title: 'Planned Order' );
    matnr @( title: 'Material' );
    // zz1_mscode_prd @( title: 'MS Code' );
    // comp_part @( title: 'Component Material' );
    maktx @( title: 'Material text' );
    posnr_rma @( title: 'BOM Item' );
    bdter @( title: 'Requirement date' );
    bdmng @( title: 'Req QTY' );
    meins @( title: 'Base Unit' );
    werks @( title: 'Plant' );
    lgort @( title: 'Storage Location' );
    dismm @( title: 'MRP type' );
    beskz @( title: 'Procurement type' );
    sobsl @( title: 'Special Procurement type' );
    schgt @( title: 'Bulk' );
    rgekz @( title: 'Back flush' );
    stprs @( title: 'Standard Price' );
    peinh @( title: 'Price Unit' );
};

annotate ZAPIBPS0011.ZCDSEHPPC0023 with @(
  UI.SelectionPresentationVariant #PlannedOrderComponentlist : {
    Text : 'Planned Order Component list',
    SelectionVariant : { 
        Text : 'PlannedOrderComponentlist',
        SelectOptions : [
            {
                $Type : 'UI.SelectOptionType',
                PropertyName : aufnr,
            }
        ]
    },
    PresentationVariant : {
        SortOrder : [
            {
                Property : aufnr,
                Descending : false
            }
        ],
        Visualizations : ['@UI.LineItem#PlannedOrderComponentlist']
    }
  }
);


//Production Order Status List zhpp0005 8727
//Production Order Component list
annotate ZAPIBPS0011.ZCDSEHPPC0011 with @(UI : {
    HeaderInfo : {
        $Type             :  'UI.HeaderInfoType',
        TypeName          : 'Production Order Component list',
        TypeNamePlural    : 'Production Order Component list'
    },
    LineItem #ProductionOrderComponentlist : {
        $value : [
            {
                $Type : 'UI.DataField',
                Value : aufnr
            },
            {
                $Type : 'UI.DataField',
                Value : plnum
            },
            {
                $Type : 'UI.DataField',
                Value : matnr
            },
            {
                $Type : 'UI.DataField',
                Value : zz1_mscode_prd
            },
            {
                $Type : 'UI.DataField',
                Value : comp_part
            },
            {
                $Type : 'UI.DataField',
                Value : maktx
            },
            {
                $Type : 'UI.DataField',
                Value : posnr
            },
            {
                $Type : 'UI.DataField',
                Value : bdter
            },
            {
                $Type : 'UI.DataField',
                Value : bdmng
            },
            {
                $Type : 'UI.DataField',
                Value : meins
            },
            {
                $Type : 'UI.DataField',
                Value : werks
            },
            {
                $Type : 'UI.DataField',
                Value : lgort
            },
            {
                $Type : 'UI.DataField',
                Value : dismm
            },
            {
                $Type : 'UI.DataField',
                Value : beskz
            },
            {
                $Type : 'UI.DataField',
                Value : sobsl
            },
            {
                $Type : 'UI.DataField',
                Value : schgt
            },
            {
                $Type : 'UI.DataField',
                Value : rgekz
            },
            {
                $Type : 'UI.DataField',
                Value : stprs
            },
            {
                $Type : 'UI.DataField',
                Value : peinh
            }
        ]
    }
}){    
    aufnr @( title: 'Production Order' );
    plnum @( title: 'Planned Order' );
    matnr @( title: 'Material' );
    zz1_mscode_prd @( title: 'MS Code' );
    comp_part @( title: 'Component Material' );
    maktx @( title: 'Material text' );
    posnr @( title: 'BOM Item' );
    bdter @( title: 'Requirement date' );
    bdmng @( title: 'Req QTY' );
    meins @( title: 'Base Unit' );
    werks @( title: 'Plant' );
    lgort @( title: 'Storage Location' );
    dismm @( title: 'MRP type' );
    beskz @( title: 'Procurement type' );
    sobsl @( title: 'Special Procurement type' );
    schgt @( title: 'Bulk' );
    rgekz @( title: 'Back flush' );
    stprs @( title: 'Standard Price' );
    peinh @( title: 'Price Unit' );
};

annotate ZAPIBPS0011.ZCDSEHPPC0011 with @(
  UI.SelectionPresentationVariant #ProductionOrderComponentlist : {
    Text : 'Production Order Component list',
    SelectionVariant : { 
        Text : 'ProductionOrderComponentlist',
        SelectOptions : [
            {
                $Type : 'UI.SelectOptionType',
                PropertyName : aufnr,
            }
        ]
    },
    PresentationVariant : {
        SortOrder : [
            {
                Property : aufnr,
                Descending : false
            }
        ]
    }
  }
);

//Production Order Status List zhpp0005 8727
//Production Order status List
annotate ZAPIBPS0011.ZCDSEHPPC0010 with @(UI : {
    HeaderInfo : {
        $Type             :  'UI.HeaderInfoType',
        TypeName          : 'Production Order status List',
        TypeNamePlural    : 'Production Order status List'
    },
    LineItem #ProductionOrderstatusList : {
        $value : [
            {
                $Type : 'UI.DataField',
                Value : porder
            },
            {
                $Type : 'UI.DataField',
                Value : plnum
            },
            {
                $Type : 'UI.DataField',
                Value : matnr
            },
            {
                $Type : 'UI.DataField',
                Value : maktx
            },
            {
                $Type : 'UI.DataField',
                Value : ZZG_PRINTED_REV
            },
            {
                $Type : 'UI.DataField',
                Value : ZPRINT
            },
            {
                $Type : 'UI.DataField',
                Value : zz1_mscode_prd
            },
            {
                $Type : 'UI.DataField',
                Value : dauat
            },
            {
                $Type : 'UI.DataField',
                Value : mrpcontrol
            },
            {
                $Type : 'UI.DataField',
                Value : fevor
            },
            {
                $Type : 'UI.DataField',
                Value : plant
            },
            {
                $Type : 'UI.DataField',
                Value : gamng
            },
            {
                $Type : 'UI.DataField',
                Value : gmein
            },
            {
                $Type : 'UI.DataField',
                Value : gstrs
            },
            {
                $Type : 'UI.DataField',
                Value : gltrs
            },
            {
                $Type : 'UI.DataField',
                Value : gltrp
            },
            {
                $Type : 'UI.DataField',
                Value : txt30
            },
            {
                $Type : 'UI.DataField',
                Value : verid
            },
            {
                $Type : 'UI.DataField',
                Value : serialnumber
            },
            {
                $Type : 'UI.DataField',
                Value : rmanr
            },
            {
                $Type : 'UI.DataField',
                Value : posnr_rma
            },
            {
                $Type : 'UI.DataField',
                Value : compponentno
            },
            {
                $Type : 'UI.DataField',
                Value : zz1_linkagenumber_sdi
            },
            {
                $Type : 'UI.DataField',
                Value : projn
            },
            {
                $Type : 'UI.DataField',
                Value : Leveling_g
            },
            {
                $Type : 'UI.DataField',
                Value : work_centre
            },
            {
                $Type : 'UI.DataField',
                Value : PRDSTNO
            },
            {
                $Type : 'UI.DataField',
                Value : SLTApproved
            },
            {
                $Type : 'UI.DataField',
                Value : Tokuchu_no
            },
            {
                $Type : 'UI.DataField',
                Value : XJ_no
            },
            {
                $Type : 'UI.DataField',
                Value : Neuclear
            },
            {
                $Type : 'UI.DataField',
                Value : Tokuchu_part_dt
            },
            {
                $Type : 'UI.DataField',
                Value : comb_no
            },
            {
                $Type : 'UI.DataField',
                Value : zz1_routindic_plt
            },
            {
                $Type : 'UI.DataField',
                Value : comb_ind
            },
            {
                $Type : 'UI.DataField',
                Value : IM_no
            },
            {
                $Type : 'UI.DataField',
                Value : aprio
            },
            {
                $Type : 'UI.DataField',
                Value : traf_ord
            },
            {
                $Type : 'UI.DataField',
                Value : traf_cc
            },
            {
                $Type : 'UI.DataField',
                Value : trf_linkage
            },
            {
                $Type : 'UI.DataField',
                Value : pkkey
            },
            {
                $Type : 'UI.DataField',
                Value : BTYPECAT
            },
            {
                $Type : 'UI.DataField',
                Value : BTYPEORDER
            },
            {
                $Type : 'UI.DataField',
                Value : BTYPEITEM
            },
            {
                $Type : 'UI.DataField',
                Value : AUFNR
            },
            {
                $Type : 'UI.DataField',
                Value : txt04
            },
            {
                $Type : 'UI.DataField',
                Value : memo1
            },
            {
                $Type : 'UI.DataField',
                Value : memo2
            },
            {
                $Type : 'UI.DataField',
                Value : memo3
            }
        ]
    }
}){    
    matnr @( title: 'Material' );  
    maktx @( title: 'Material text' );  
    fevor @( title: 'Production Supervisor' );  
    gamng @( title: 'Order Qty.' );  
    gmein @( title: 'Base Unit' );  
    gstrs @( title: 'Scheduled Start Date' );  
    gltrs @( title: 'Scheduled Finish Date' );  
    gltrp @( title: 'Basic Finish Date' );  
    serialnumber @( title: 'Serial' );  
    txt30 @( title: 'System status' );  
    compponentno @( title: 'COMP' );  
    zz1_routindic_plt @( title: 'Usage of routing' );  
    Tokuchu_no @( title: 'Tokuchu No.' );  
    XJ_no @( title: 'XJ No.' );  
    Neuclear @( title: 'Nuclear' );  
    Tokuchu_part_dt @( title: 'Tokuchu parts due date ' );  
    comb_ind @( title: 'Combination Flag' );  
    comb_no @( title: 'Combination No. ' );  
    IM_no @( title: 'IM' );  
    txt04 @( title: 'B-Type Parent Prod Order Status' );  
    aprio @( title: 'Order Transfer status' );  
    traf_ord @( title: 'Order Transfer ' );  
    traf_cc @( title: 'Transfer cost center' );  
    // zz1_linkagenumber_sdi @( title: 'Transfer Linkage' );  
    BTYPECAT @( title: 'B Type Category' );  
    PRDSTNO  @( title: 'B Type Prod. Start No' );  
    BTYPEITEM @( title: 'B Type start No. Item' );  
    BTYPESTATUS @( title: 'B-Type Parent Prod Order Status' );  
    AUFNR @( title: 'B-Type Parent Prod Order' );  
    memo1 @( title: 'Manufacturing memo1' );  
    memo2 @( title: 'Manufacturing memo2' );  
    memo3 @( title: 'Manufacturing memo3' );  
};

annotate ZAPIBPS0011.ZCDSEHPPC0010 with @(
  UI.SelectionPresentationVariant #ProductionOrderstatusList : {
    Text : 'Production Order status List',
    SelectionVariant : { 
        Text : 'ProductionOrderstatusList',
        SelectOptions : [
            {
                $Type : 'UI.SelectOptionType',
                PropertyName : porder,
            }
        ]
    },
    PresentationVariant : {
        SortOrder : [
            {
                Property : porder,
                Descending : false
            }
        ],
        Visualizations : ['@UI.LineItem#ProductionOrderstatusList']
    }
  }
);

//Production Order Status List zhpp0005 8727
//Planned Order status List
annotate ZAPIBPS0011.ZCDSEHPPC0014 with @(UI : {
    HeaderInfo : {
        $Type             :  'UI.HeaderInfoType',
        TypeName          : 'Planned Order status List',
        TypeNamePlural    : 'Planned Order status List'
    },
    LineItem #PlannedOrderstatusList : {
        $value : [
            {
                $Type : 'UI.DataField',
                Value : aufnr
            },
            {
                $Type : 'UI.DataField',
                Value : plnum
            },
            {
                $Type : 'UI.DataField',
                Value : matnr
            },
            {
                $Type : 'UI.DataField',
                Value : maktx
            },
            {
                $Type : 'UI.DataField',
                Value : ZZG_PRINTED_REV
            },
            {
                $Type : 'UI.DataField',
                Value : ZPRINT
            },
            {
                $Type : 'UI.DataField',
                Value : zz1_mscode_prd
            },
            {
                $Type : 'UI.DataField',
                Value : ordertype
            },
            {
                $Type : 'UI.DataField',
                Value : dispo
            },
            {
                $Type : 'UI.DataField',
                Value : plgrp
            },
            {
                $Type : 'UI.DataField',
                Value : pwwrk
            },
            {
                $Type : 'UI.DataField',
                Value : gsmng
            },
            {
                $Type : 'UI.DataField',
                Value : meins
            },
            {
                $Type : 'UI.DataField',
                Value : gstrs
            },
            {
                $Type : 'UI.DataField',
                Value : gltrs
            },
            {
                $Type : 'UI.DataField',
                Value : pedtr
            },
            // {
            //     $Type : 'UI.DataField',
            //     Value : txt30
            // },
            {
                $Type : 'UI.DataField',
                Value : verid
            },
            {
                $Type : 'UI.DataField',
                Value : serialnumber
            },
            {
                $Type : 'UI.DataField',
                Value : kdauf
            },
            {
                $Type : 'UI.DataField',
                Value : kdpos
            },
            {
                $Type : 'UI.DataField',
                Value : compponentno
            },
            {
                $Type : 'UI.DataField',
                Value : zz1_linkagenumber_sdi
            },
            // {
            //     $Type : 'UI.DataField',
            //     Value : projn
            // },
            {
                $Type : 'UI.DataField',
                Value : Leveling_g
            },
            {
                $Type : 'UI.DataField',
                Value : work_centre
            },
            {
                $Type : 'UI.DataField',
                Value : PRDSTNO
            },
            {
                $Type : 'UI.DataField',
                Value : SLTApproved
            },
            {
                $Type : 'UI.DataField',
                Value : Tokuchu_no
            },
            {
                $Type : 'UI.DataField',
                Value : XJ_no
            },
            {
                $Type : 'UI.DataField',
                Value : Neuclear
            },
            {
                $Type : 'UI.DataField',
                Value : Tokuchu_part_dt
            },
            {
                $Type : 'UI.DataField',
                Value : comb_no
            },
            {
                $Type : 'UI.DataField',
                Value : zz1_routindic_plt
            },
            {
                $Type : 'UI.DataField',
                Value : comb_ind
            },
            {
                $Type : 'UI.DataField',
                Value : IM_no
            },
            // {
            //     $Type : 'UI.DataField',
            //     Value : aprio
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Value : traf_ord
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Value : traf_cc
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Value : trf_linkage
            // },
            {
                $Type : 'UI.DataField',
                Value : pkkey
            },
            {
                $Type : 'UI.DataField',
                Value : BTYPECAT
            },
            {
                $Type : 'UI.DataField',
                Value : BTYPEORDER
            },
            {
                $Type : 'UI.DataField',
                Value : BTYPEITEM
            },
            {
                $Type : 'UI.DataField',
                Value : AUFNR
            },
            // {
            //     $Type : 'UI.DataField',
            //     Value : txt04
            // },
            {
                $Type : 'UI.DataField',
                Value : memo1
            },
            {
                $Type : 'UI.DataField',
                Value : memo2
            },
            {
                $Type : 'UI.DataField',
                Value : memo3
            }
        ]
    }
}){    
    aufnr @( title: 'Production Order' );  
    matnr @( title: 'Material' );  
    maktx @( title: 'Material text' );  
    // fevor @( title: 'Production Supervisor' );  
    // gamng @( title: 'Order Qty.' );  
    // gmein @( title: 'Base Unit' );  
    gstrs @( title: 'Scheduled Start Date' );  
    gltrs @( title: 'Scheduled Finish Date' );  
    // gltrp @( title: 'Basic Finish Date' );  
    serialnumber @( title: 'Serial' );  
    // txt30 @( title: 'System status' );  
    compponentno @( title: 'COMP' );  
    zz1_routindic_plt @( title: 'Usage of routing' );  
    Tokuchu_no @( title: 'Tokuchu No.' );  
    XJ_no @( title: 'XJ No.' );  
    Neuclear @( title: 'Nuclear' );  
    Tokuchu_part_dt @( title: 'Tokuchu parts due date ' );  
    comb_ind @( title: 'Combination Flag' );  
    comb_no @( title: 'Combination No. ' );  
    IM_no @( title: 'IM' );  
    // txt04 @( title: 'B-Type Parent Prod Order Status' );  
    // aprio @( title: 'Order Transfer status' );  
    // traf_ord @( title: 'Order Transfer ' );  
    // traf_cc @( title: 'Transfer cost center' );  
    // zz1_linkagenumber_sdi @( title: 'Transfer Linkage' );  
    BTYPECAT @( title: 'B Type Category' );  
    PRDSTNO  @( title: 'B Type Prod. Start No' );  
    BTYPEITEM @( title: 'B Type start No. Item' );  
    BTYPESTATUS @( title: 'B-Type Parent Prod Order Status' );  
    AUFNR @( title: 'B-Type Parent Prod Order' );  
    memo1 @( title: 'Manufacturing memo1' );  
    memo2 @( title: 'Manufacturing memo2' );  
    memo3 @( title: 'Manufacturing memo3' );  
};

annotate ZAPIBPS0011.ZCDSEHPPC0014 with @(
  UI.SelectionPresentationVariant #PlannedOrderstatusList : {
    Text : 'Planned Order status List',
    SelectionVariant : { 
        Text : 'PlannedOrderstatusList',
        SelectOptions : [
            {
                $Type : 'UI.SelectOptionType',
                PropertyName : plnum,
            }
        ]
    },
    PresentationVariant : {
        SortOrder : [
            {
                Property : plnum,
                Descending : false
            }
        ],
        Visualizations : ['@UI.LineItem#PlannedOrderstatusList']
    }
  }
);



annotate ZAPIBPS0012.ZAPIBPS0012Report with @(    
    UI : { 
        SelectionFields  : [
            Plant ,StorageLocation,PlannedCountDate,PostingDate,PhysInvDoc
        ],
        LineItem  : [
            { Value : PhysInvDoc },
            { Value : STATUS },
            { Value : MTYPE }, 
            { Value : CLASS },
            { Value : MNO },
            { Value : MESSAGE }  ,
            { Value : SCHEDULED_BY }  ,
            { Value : SCHEDULED_DATE }  ,
            { Value : PROCESSED_DATE }                              
        ],
     }
){    
    PhysInvDoc @( title: 'Physical Inventory Document' );  
    Plant @( title: 'Plant' );  
    StorageLocation @( title: 'Storage Location' );  
    PlannedCountDate @( title: 'Planned Date of Inventory Count' );  
    PostingDate @( title: 'Posting Date' );  
    STATUS @( title: 'Status' );  
    MTYPE @( title: 'Message Type' );  
    CLASS @( title: 'Message Class' );  
    MNO @( title: 'Message No' );    
    MESSAGE @( title: 'Message' );    
    SCHEDULED_BY @( title: 'Scheduled By' );    
    SCHEDULED_DATE @( title: 'Scheduled Date' );    
    PROCESSED_DATE @( title: 'Processed Date' );    
};

annotate ZAPIBPS0012.ZAPIBPS0012Report {
    Plant @mandatory;
    StorageLocation @mandatory;
    PlannedCountDate @mandatory;
    PostingDate @mandatory; 
}
annotate ZAPIBPS0012.ZAPIBPS0012Report {
     @(Common : {
        Label        : 'Plant',
        ValueList    : {
            CollectionPath : 'ZAPIBPS0012_PlantStdVH',
            Parameters     : [
            {
                $Type             : 'Common.ValueListParameterInOut',
                LocalDataProperty : Plant,
                ValueListProperty : 'Plant'
            },
            {
                $Type             : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'PlantName'
            }
            ]
        }
    })
    Plant;
    
     @(Common : {
        Label        : 'Sotage Location',
        ValueList    : {
            CollectionPath : 'ZAPIBPS0012_StorageLocationStdVH',
            Parameters     : [
            {
                $Type             : 'Common.ValueListParameterInOut',
                LocalDataProperty : Plant,
                ValueListProperty : 'Plant'
            },
            {
                $Type             : 'Common.ValueListParameterInOut',
                LocalDataProperty : StorageLocation,
                ValueListProperty : 'StorageLocation'
            },
            {
                $Type             : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'StorageLocationName'
            }
            ]
        }
    })
    StorageLocation;
}


annotate ZAPIBPS0012.ZAPIBPS0012Report @(Capabilities.FilterRestrictions : {
   FilterExpressionRestrictions : [
        {
            Property : PostingDate,
            AllowedExpressions : 'SingleValue'
        },
        {
            Property : PlannedCountDate,
            AllowedExpressions : 'SingleValue'
        }
    ]
});