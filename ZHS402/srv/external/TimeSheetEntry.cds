/* checksum : b34d72358a8b9b47842d05b233a89eb0 */
@cds.external : true
@m.IsDefaultEntityContainer : 'true'
@sap.message.scope.supported : 'true'
@sap.supported.formats : 'atom json xlsx'
service TimeSheetEntry {};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Statistical Key Figure - Text'
entity TimeSheetEntry.I_StatisticalKeyFigureText {
  @sap.label : 'Language Key'
  key Language : String(2) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Controlling Area'
  key ControllingArea : String(4) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Statistical Key Figure'
  key StatisticalKeyFigure : String(6) not null;
  @sap.label : 'Statistical Key Figure Name'
  StatisticalKeyFigureName : String(40) null;
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'F4 for Accounting Indicator'
entity TimeSheetEntry.ZCDSEHCSC0003 {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Accounting Indicator'
  key AccountingIndicator : String(2) not null;
  @sap.label : 'Language'
  @sap.quickinfo : 'Language Key'
  key Language : String(2) not null;
  @sap.label : 'Description'
  @sap.quickinfo : 'Accounting Indicator Description'
  AcctIndDescription : String(25) null;
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'F4 for Service Order Item'
entity TimeSheetEntry.ZCDSEHCSC0005 {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Service Order'
  @sap.quickinfo : 'Transaction ID'
  key object_id : String(10) not null;
  @sap.display.format : 'NonNegative'
  @sap.label : 'Service Order Item'
  @sap.quickinfo : 'Shortened Item Number in Document'
  key number_int : String(6) not null;
  @sap.label : 'Item Description'
  @sap.quickinfo : 'Product Description'
  description_i : String(40) null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Accounting Indicator'
  ac_indicator : String(2) null;
  @sap.label : 'Internal Order'
  @sap.quickinfo : 'Object key'
  InternalOrder : String(70) null;
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'F4 for Service Order'
entity TimeSheetEntry.ZCDSEHCSC0006 {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Service Order'
  @sap.quickinfo : 'Transaction ID'
  key object_id : String(10) not null;
  @sap.label : 'Description'
  @sap.quickinfo : 'Transaction Description'
  description_h : String(40) null;
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Custom Entity for TimeSheet Data'
entity TimeSheetEntry.ZCDSEHPSB0030 {
  @sap.display.format : 'NonNegative'
  @sap.label : 'Personnel number'
  @sap.quickinfo : 'Personnel Number'
  key EMPLOYEENUMBER : String(8) not null;
  @sap.display.format : 'Date'
  @sap.label : 'Start Date'
  key WeekFirstDate : Date not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Counter'
  @sap.quickinfo : 'Counter for Records in Time Recording'
  key COUNTER : String(12) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Sender Cost Center'
  SEND_CCTR : String(10) null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Activity Type'
  ACTTYPE : String(6) null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Activity number'
  @sap.quickinfo : 'Activity Number'
  SERVICE : String(18) null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Receiver cost center'
  @sap.quickinfo : 'Receiver Cost Center'
  REC_CCTR : String(10) null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Receiver order'
  @sap.quickinfo : 'Receiver Order'
  REC_ORDER : String(12) null;
  WBS_ELEMENT : String(24) null;
  WBS_ELEMENT_DESC : String(24) null;
  @sap.display.format : 'Date'
  @sap.label : 'Date'
  day1_date : Date null;
  @sap.unit : 'UNIT'
  @sap.label : 'Hours'
  day1_CATSHOURS : Decimal(4, 2) null;
  @sap.display.format : 'Date'
  @sap.label : 'Date'
  day2_date : Date null;
  @sap.unit : 'UNIT'
  @sap.label : 'Hours'
  day2_CATSHOURS : Decimal(4, 2) null;
  @sap.display.format : 'Date'
  @sap.label : 'Date'
  day3_date : Date null;
  @sap.unit : 'UNIT'
  @sap.label : 'Hours'
  day3_CATSHOURS : Decimal(4, 2) null;
  @sap.display.format : 'Date'
  @sap.label : 'Date'
  day4_date : Date null;
  @sap.unit : 'UNIT'
  @sap.label : 'Hours'
  day4_CATSHOURS : Decimal(4, 2) null;
  @sap.display.format : 'Date'
  @sap.label : 'Date'
  day5_date : Date null;
  @sap.unit : 'UNIT'
  @sap.label : 'Hours'
  day5_CATSHOURS : Decimal(4, 2) null;
  @sap.display.format : 'Date'
  @sap.label : 'Date'
  day6_date : Date null;
  @sap.unit : 'UNIT'
  @sap.label : 'Hours'
  day6_CATSHOURS : Decimal(4, 2) null;
  @sap.display.format : 'Date'
  @sap.label : 'Date'
  day7_date : Date null;
  @sap.unit : 'UNIT'
  @sap.label : 'Hours'
  day7_CATSHOURS : Decimal(4, 2) null;
  @sap.label : 'Display Unit/Measure'
  @sap.quickinfo : 'Unit of Measure for Display'
  @sap.semantics : 'unit-of-measure'
  UNIT : String(3) null;
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Consumption View for Time Sheet Entry'
entity TimeSheetEntry.ZCDSEHPSC0004 {
  @sap.label : 'Email Address'
  key email_Address : String(241) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Global ID'
  @sap.quickinfo : 'Communication Identification/Number'
  globalID : String(30) null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Employee ID'
  @sap.quickinfo : 'Identification Number'
  EmployeeId : String(60) null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Employee Name'
  @sap.quickinfo : 'Employee''s Name (Sortable by LAST NAME FIRST NAME)'
  EmployeeName : String(30) null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Cost Center'
  CostCenter : String(10) null;
  @sap.label : 'Designation'
  @sap.quickinfo : 'Short Text of Position'
  Designation : String(25) null;
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'F4 for Receiver Order In Assignment'
entity TimeSheetEntry.ZCDSEHPSC0007 {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Internal Order'
  @sap.quickinfo : 'Order Number'
  key aufnr : String(12) not null;
  @sap.label : 'Internal Order Description'
  @sap.quickinfo : 'Description'
  ktext : String(40) null;
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'F4 for Receiver WBS in Assignemnt'
entity TimeSheetEntry.ZCDSEHPSC0008 {
  @sap.label : 'Project ID'
  key ProjectId : String(24) not null;
  @sap.label : 'Receiver WBS'
  key WBSId : String(24) not null;
  @sap.label : 'Receiver Project Description'
  @sap.quickinfo : 'PS: Short description (1st text line)'
  ProjectDesc : String(40) null;
};

