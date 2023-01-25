using ZCDSEHBTC0001 as service from '../../srv/cat-service';
// annotate ZCDSEHBTC0001.ZSCREEN1 with {
//    E_PARTS_NO @(Common : {
//     //show text, not id for mitigation in the context of risks
//     Text            : E_PARTS_NO,
//     TextArrangement : #TextOnly,
//     ValueList       : {
//     Label          : 'Materials',
//     CollectionPath : 'ZCDSEHBT0001',
//     SearchSupported: true,
//     Parameters     : [
//        {
//        $Type : 'Common.ValueListParameterInOut',
//        LocalDataProperty : E_PARTS_NO,
//        ValueListProperty : 'E_PARTS_NO'
//        },
//        {
//        $Type : 'Common.ValueListParameterDisplayOnly',
//        ValueListProperty : 'YEOS_MNF_NO'
//        }
//     ]
//     }
//   });
//  }

annotate ZCDSEHBTC0001.ZSCREEN1 {
    @(
        Common: {
            ValueList : {
                Label          : '{i18n>Material}',
                CollectionPath : 'ZTHBT0005',
                SearchSupported: true,
                Parameters     : [
                    {
                        $Type             : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'E_PARTS_NO',
                        LocalDataProperty : E_PARTS_NO
                    },
                    {
                        $Type             : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'YEOS_MNF_NO'
                    },
                    {
                        $Type             : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'PCKG_CD'
                    }
                ]
            }
        }
    )
    E_PARTS_NO;
};

annotate ZCDSEHBTC0001.ZSCREEN1 {
    @(
        Common: {
            ValueList : {
                Label          : '{i18n>YEOS_MNF_NO}',
                CollectionPath : 'ZTHBT0005',
                SearchSupported: true,
                Parameters     : [
                    {
                        $Type             : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'YEOS_MNF_NO',
                        LocalDataProperty : YEOS_MNF_NO
                    },
                  //   {
                  //   $Type             : 'Common.ValueListParameterOut',
                  //   ValueListProperty : 'YEOS_MNF_NO',
                  //   LocalDataProperty : YEOS_MNF_NO
                   
                  //   },
                    {
                        $Type             : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'E_PARTS_NO'
                    },
                    {
                        $Type             : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'PCKG_CD'
                    }
                ]
            }
        }
    )
    YEOS_MNF_NO;
};
annotate ZCDSEHBTC0001.ZSCREEN1 {
    @(
        Common: {
            ValueList : {
                Label          : '{i18n>Packing Code}',
                CollectionPath : 'ZTHBT0005',
                SearchSupported: true,
                Parameters     : [
                    {
                        $Type             : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'PCKG_CD',
                        LocalDataProperty : PCKG_CD
                    },
                    {
                        $Type             : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'YEOS_MNF_NO'
                    },
                    {
                        $Type             : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'E_PARTS_NO'
                    }
                ]
            }
        }
    )
    PCKG_CD;
};