using ZCDSEHBTC0001 from './cat-service';
using ZCDSEHBTC0002 from './cat-service';
using ZCDSEHBTC0003 from './cat-service';
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
            { Value: ZPFDT },
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
            { Value: COSTCENTERNAME}                
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
annotate ZCDSEHBTC0007.BOMDisplay with @(
    UI : { 
        SelectionFields  : [
            E_DOC_TYPE,WERKS,E_DOC_NO,E_REV_NO,PS_GROUP_NO
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
// annotate ZCDSEHBTC0007.BOMDisplay with {
// E_DOC_NO @UI.HiddenFilter: true;
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
annotate ZCDSEHBTC0007.BOMDisplay {
    @Common.ValueListWithFixedValues : true
    @(Common : {
        Label     : 'Doc Type',
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Doc_Type',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : E_DOC_TYPE,
                    ValueListProperty : 'DOC_TYPE'
                }
            ]
        }
    })
    E_DOC_TYPE;
}
annotate ZCDSEHBTC0007.BOMDisplay @(Capabilities.FilterRestrictions : {
   FilterExpressionRestrictions : [
        {
            Property : E_DOC_TYPE,
            AllowedExpressions : 'SingleValue'
        }
    ]
});
annotate ZCDSEHBTC0007.BOMDisplay with {
    @Common.FilterDefaultValue : 'FE0'
    E_DOC_TYPE
};
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
            { Value : SUPPLY_STYLE_N }                                       
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
    E_PARTS_NO      @title : 'Material Number';
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
                Target: 'ZTHBT0010@UI.LineItem'
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
                Target: 'ZTHBT0014@UI.LineItem'
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
annotate ZCDSEHBTC0012.materialWhereUsed with @(
    UI : { 
        SelectionFields  : [
            WERKS,
            MATNR_COM,MMSTD
        ],
        LineItem  : [
            { Value : WERKS }, 
            { Value : MATNR_COM },
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
            { Value : LEVEL_BOM },
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
annotate ZCDSEHBTC0013.ZTHBT0059 with @(
    UI : { 
        SelectionFields  : [
            ZWBS_ELEMENT
        ],
        LineItem  : [
            { Value : ZWBS_ELEMENT },
            { Value : ZFG_INVOICE_ID },
            { Value : ZSD_MAIN_SONUM }, 
            { Value : ZSD_SO_DEBIT_NUM },
            { Value : ZSD_INV_SUBMIT_DATE },
            { Value : ZSD_GROSS_VALUE },
            { Value : ZSD_BILLING_DATE },
            { Value : ZSD_DEBIT_DOC_DATE },
            { Value : ZSD_DEBIT_NET_VALUE },
            { Value : ZSD_STATUS },
            { Value : ZSD_ERROR },                                        
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