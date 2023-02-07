namespace external;

using {PUBLIC} from '../db/hana-model';

service PublicSynonymsService {

  entity Synonyms     as projection on PUBLIC.SYNONYMS;
  entity TableColumns as projection on PUBLIC.TABLE_COLUMNS;
  entity ViewColumns  as projection on PUBLIC.VIEW_COLUMNS;
  entity IndexColumns as projection on PUBLIC.INDEX_COLUMNS;
  entity M_TABLES as projection on PUBLIC.M_TABLES;

}