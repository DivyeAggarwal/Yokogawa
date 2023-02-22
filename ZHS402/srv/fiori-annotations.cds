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
                CollectionPath : 'ReceiverWBS',
                Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PWBS,
                    ValueListProperty : 'WBSId'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'ProjectId'
                },
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PARENTWBSDESC,
                    ValueListProperty : 'ProjectDesc'
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
annotate ZCDSEHBTC0007.BOMDisplay with {
E_DOC_NO @UI.HiddenFilter: true;
}
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
// annotate ZCDSEHBTC0009.MakersList with @(
//    UI.SelectionVariant#One :
// {
//     Text: 'Makers List',
//     SelectOptions:
//     [
//         {
//             $Type : 'UI.SelectOptionType',
//             PropertyName : E_PARTS_NO
             
//         }
//     ]
// }
// ){
// };
annotate ZCDSEHBTC0009.ZTHBT0001 with @(
  UI.SelectionVariant #DigitPartList : {
    Text : '10 Digit Part List'
  }
);
annotate ZCDSEHBTC0009.DigitPartList with @(
  UI.SelectionVariant #DigitPartListTest : {
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

annotate ZCDSEHBTC0009.PackingList with @(
    UI : { 
        
        LineItem  : [
            { Value : PARTS_NO },
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
// annotate ZCDSEHBTC0007.BOMDisplay {
//     E_DOC_TYPE @(
//         @Common.ValueListWithFixedValues : true,
//         Common : {Text : {
//             $value                 : 'FE1',
//             ![@UI.TextArrangement] : #TextOnly
//         }}
//     );
// }


