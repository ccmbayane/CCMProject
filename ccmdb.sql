CREATE TABLESPACE TBS_CCM DATAFILE 
  'TBS_CCM.DBF' SIZE 512M AUTOEXTEND ON NEXT 256M MAXSIZE 1024M
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

CREATE USER CCMDB
  IDENTIFIED BY CCMDB123
  DEFAULT TABLESPACE TBS_CCM
  TEMPORARY TABLESPACE TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;
  -- 9 System Privileges for CCMDB 
  GRANT CREATE PROCEDURE TO CCMDB;
  GRANT CREATE PUBLIC SYNONYM TO CCMDB;
  GRANT CREATE SEQUENCE TO CCMDB;
  GRANT CREATE SESSION TO CCMDB;
  GRANT CREATE SYNONYM TO CCMDB;
  GRANT CREATE TABLE TO CCMDB;
  GRANT CREATE TRIGGER TO CCMDB;
  GRANT CREATE TYPE TO CCMDB;
  GRANT CREATE VIEW TO CCMDB;
  -- 1 Tablespace Quota for CCMDB 
  ALTER USER CCMDB QUOTA UNLIMITED ON TBS_CCM;
  
connect CCMDB/CCMDB123


CREATE TABLE CCMDB.PROFILE
(
  ID   INTEGER                                  NOT NULL,
  NOM  VARCHAR2(70 CHAR)
)
TABLESPACE TBS_CCM
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


--  There is no statement for index CCMDB.SYS_C0018363.
--  The object is created when the parent object is created.

ALTER TABLE CCMDB.PROFILE ADD (
  PRIMARY KEY
  (ID)
  USING INDEX
    TABLESPACE TBS_CCM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          1M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
  ENABLE VALIDATE);

CREATE TABLE CCMDB.UTILISATEUR
(
  ID         INTEGER                            NOT NULL,
  NOM        VARCHAR2(70 CHAR),
  PRENOM     VARCHAR2(70 CHAR),
  LOGIN      VARCHAR2(70 CHAR),
  PASSWORD   VARCHAR2(70 CHAR),
  PROFILEID  INTEGER
)
TABLESPACE TBS_CCM
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


ALTER TABLE CCMDB.UTILISATEUR ADD (
  PRIMARY KEY
  (ID)
  USING INDEX
    TABLESPACE TBS_CCM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          1M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
  ENABLE VALIDATE,
  UNIQUE (NOM)
  USING INDEX
    TABLESPACE TBS_CCM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          1M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
  ENABLE VALIDATE,
  UNIQUE (PRENOM)
  USING INDEX
    TABLESPACE TBS_CCM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          1M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
  ENABLE VALIDATE,
  UNIQUE (LOGIN)
  USING INDEX
    TABLESPACE TBS_CCM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          1M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
  ENABLE VALIDATE,
  UNIQUE (PASSWORD)
  USING INDEX
    TABLESPACE TBS_CCM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          1M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE CCMDB.UTILISATEUR ADD (
  FOREIGN KEY (PROFILEID) 
  REFERENCES CCMDB.PROFILE (ID)
  ENABLE VALIDATE);


CREATE TABLE CCMDB.PRIVILEGE
(
  ID        INTEGER                             NOT NULL,
  TITLE     VARCHAR2(70 CHAR),
  ICON      VARCHAR2(70 CHAR),
  PATH      VARCHAR2(70 CHAR),
  ACTIVE    VARCHAR2(10 CHAR),
  PARENTID  INTEGER
)
TABLESPACE TBS_CCM
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


--  There is no statement for index CCMDB.SYS_C0018365.
--  The object is created when the parent object is created.

ALTER TABLE CCMDB.PRIVILEGE ADD (
  PRIMARY KEY
  (ID)
  USING INDEX
    TABLESPACE TBS_CCM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          1M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE CCMDB.PRIVILEGE ADD (
  FOREIGN KEY (PARENTID) 
  REFERENCES CCMDB.PRIVILEGE (ID)
  ENABLE VALIDATE);


CREATE TABLE CCMDB.PROFILE_PRIVILEGE
(
  PRIVILEGEID  INTEGER                          NOT NULL,
  PROFILEID    INTEGER                          NOT NULL
)
TABLESPACE TBS_CCM
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


--  There is no statement for index CCMDB.SYS_C0018379.
--  The object is created when the parent object is created.

ALTER TABLE CCMDB.PROFILE_PRIVILEGE ADD (
  PRIMARY KEY
  (PRIVILEGEID, PROFILEID)
  USING INDEX
    TABLESPACE TBS_CCM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          1M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE CCMDB.PROFILE_PRIVILEGE ADD (
  FOREIGN KEY (PRIVILEGEID) 
  REFERENCES CCMDB.PRIVILEGE (ID)
  ENABLE VALIDATE,
  FOREIGN KEY (PROFILEID) 
  REFERENCES CCMDB.PROFILE (ID)
  ENABLE VALIDATE);


CREATE TABLE CCMDB.FORM
(
  ID               INTEGER                      NOT NULL,
  CODE             VARCHAR2(20 CHAR),
  COUNT            VARCHAR2(20 CHAR),
  NEXT_BUTTON      VARCHAR2(20 CHAR),
  PREVIOUS_BUTTON  VARCHAR2(20 CHAR),
  DONE_BUTTON      VARCHAR2(20 CHAR),
  PRIVILEGEID      INTEGER
)
TABLESPACE TBS_CCM
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


--  There is no statement for index CCMDB.SYS_C0018383.
--  The object is created when the parent object is created.

ALTER TABLE CCMDB.FORM ADD (
  PRIMARY KEY
  (ID)
  USING INDEX
    TABLESPACE TBS_CCM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          1M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE CCMDB.FORM ADD (
  FOREIGN KEY (PRIVILEGEID) 
  REFERENCES CCMDB.PRIVILEGE (ID)
  ENABLE VALIDATE);


CREATE TABLE CCMDB.FORM_STEP
(
  ID      INTEGER                               NOT NULL,
  TITLE   VARCHAR2(20 CHAR),
  FORMID  INTEGER
)
TABLESPACE TBS_CCM
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


--  There is no statement for index CCMDB.SYS_C0018386.
--  The object is created when the parent object is created.

ALTER TABLE CCMDB.FORM_STEP ADD (
  PRIMARY KEY
  (ID)
  USING INDEX
    TABLESPACE TBS_CCM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          1M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE CCMDB.FORM_STEP ADD (
  FOREIGN KEY (FORMID) 
  REFERENCES CCMDB.FORM (ID)
  ENABLE VALIDATE);


CREATE TABLE CCMDB.FIELD
(
  ID           INTEGER                          NOT NULL,
  NAME         VARCHAR2(50 CHAR),
  TITLE        VARCHAR2(50 CHAR),
  PLACEHOLDER  VARCHAR2(50 CHAR),
  TYPE         VARCHAR2(50 CHAR),
  VALUE        VARCHAR2(50 CHAR),
  FORMSTEPID   INTEGER
)
TABLESPACE TBS_CCM
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


--  There is no statement for index CCMDB.SYS_C0018389.
--  The object is created when the parent object is created.

ALTER TABLE CCMDB.FIELD ADD (
  PRIMARY KEY
  (ID)
  USING INDEX
    TABLESPACE TBS_CCM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          1M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE CCMDB.FIELD ADD (
  FOREIGN KEY (FORMSTEPID) 
  REFERENCES CCMDB.FORM_STEP (ID)
  ENABLE VALIDATE);


CREATE TABLE CCMDB.FIELD_VALUES
(
  ID       INTEGER                              NOT NULL,
  VALUE    VARCHAR2(50 CHAR),
  SRC      VARCHAR2(50 CHAR),
  FIELDID  INTEGER
)
TABLESPACE TBS_CCM
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


--  There is no statement for index CCMDB.SYS_C0018471.
--  The object is created when the parent object is created.

ALTER TABLE CCMDB.FIELD_VALUES ADD (
  PRIMARY KEY
  (ID)
  USING INDEX
    TABLESPACE TBS_CCM
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          1M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
  ENABLE VALIDATE);

ALTER TABLE CCMDB.FIELD_VALUES ADD (
  FOREIGN KEY (FIELDID) 
  REFERENCES CCMDB.FIELD (ID)
  ENABLE VALIDATE);

SET DEFINE OFF;
Insert into CCMDB.PROFILE
   (ID, NOM)
 Values
   (1, 'Administrateur');
Insert into CCMDB.PROFILE
   (ID, NOM)
 Values
   (2, 'profile 2');
COMMIT;

Insert into CCMDB.PRIVILEGE
   (ID, TITLE, ICON, PATH, ACTIVE)
 Values
   (2, 'Carte d acteur', 'team', '/inscription/inscr', 'False');
Insert into CCMDB.PRIVILEGE
   (ID, TITLE, ACTIVE)
 Values
   (3, 'Other', 'False');
Insert into CCMDB.PRIVILEGE
   (ID, TITLE, ICON, PARENTID)
 Values
   (4, 'Submenu 1', 'False', 3);
Insert into CCMDB.PRIVILEGE
   (ID, TITLE, ICON, PARENTID)
 Values
   (5, 'Submenu 2', 'False', 3);
Insert into CCMDB.PRIVILEGE
   (ID, TITLE, PATH, ACTIVE)
 Values
   (6, 'register', '/inscription/register', 'False');
Insert into CCMDB.PRIVILEGE
   (ID, TITLE, ICON, PATH, ACTIVE, 
    PARENTID)
 Values
   (7, 'Submenu 3', 'mail1', 'path', 'False', 
    3);
Insert into CCMDB.PRIVILEGE
   (ID, TITLE, ICON, PATH, ACTIVE)
 Values
   (1, 'Autorisation de Tournage', 'mail', '/inscription', 'True');
COMMIT;

Insert into CCMDB.PROFILE_PRIVILEGE
   (PRIVILEGEID, PROFILEID)
 Values
   (1, 1);
Insert into CCMDB.PROFILE_PRIVILEGE
   (PRIVILEGEID, PROFILEID)
 Values
   (1, 2);
Insert into CCMDB.PROFILE_PRIVILEGE
   (PRIVILEGEID, PROFILEID)
 Values
   (2, 1);
Insert into CCMDB.PROFILE_PRIVILEGE
   (PRIVILEGEID, PROFILEID)
 Values
   (3, 1);
Insert into CCMDB.PROFILE_PRIVILEGE
   (PRIVILEGEID, PROFILEID)
 Values
   (3, 2);
COMMIT;
Insert into CCMDB.FORM
   (ID, CODE, COUNT, NEXT_BUTTON, PREVIOUS_BUTTON, 
    DONE_BUTTON)
 Values
   (2, 'registerSP', '2', 'next', 'previeus', 
    'Enregistrer');
Insert into CCMDB.FORM
   (ID, CODE, COUNT, NEXT_BUTTON, PREVIOUS_BUTTON, 
    DONE_BUTTON)
 Values
   (3, 'registerPP', '1', 'next', 'previeus', 
    'Enregistrer');
Insert into CCMDB.FORM
   (ID, CODE, COUNT, NEXT_BUTTON, PREVIOUS_BUTTON, 
    DONE_BUTTON, PRIVILEGEID)
 Values
   (1, 'register', '3', 'next', 'previeus', 
    'done', 1);
COMMIT;

Insert into CCMDB.FORM_STEP
   (ID, TITLE, FORMID)
 Values
   (4, 'Register SP 1', 2);
Insert into CCMDB.FORM_STEP
   (ID, TITLE, FORMID)
 Values
   (5, 'Register SP 2', 2);
Insert into CCMDB.FORM_STEP
   (ID, TITLE, FORMID)
 Values
   (6, 'Register PP', 3);
Insert into CCMDB.FORM_STEP
   (ID, TITLE, FORMID)
 Values
   (1, 'Step1', 1);
Insert into CCMDB.FORM_STEP
   (ID, TITLE, FORMID)
 Values
   (2, 'Step2', 1);
Insert into CCMDB.FORM_STEP
   (ID, TITLE, FORMID)
 Values
   (3, 'Step3', 1);
COMMIT;

Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (12, 'nomsp', 'Nom', 'Nom', 'text', 
    6);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (13, 'dateOctroi', 'Date d''octroi', 'Date d''octroi', 'date', 
    4);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (14, 'ville', 'Ville', 'Ville', 'select', 
    4);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (15, 'telephone', 'Telephone', 'Telephone', 'text', 
    5);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (16, 'rc', 'RC', 'RC', 'text', 
    5);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (17, 'password', 'Mot de passe', 'Mot de passe', 'password', 
    5);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (18, 'ville', 'Ville', 'Ville', 'select', 
    6);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (19, 'telephone', 'Telephone', 'Telephone', 'text', 
    6);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (20, 'password', 'Mot de passe', 'Mot de passe', 'password', 
    6);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (21, 'nompp', 'Nom de la SP', 'Nom de la SP', 'text', 
    4);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (22, 'dateNassance', 'Date de naissance', 'Date de naissance', 'date', 
    6);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (1, 'nom', 'nom', 'first name', 'text', 
    1);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (2, 'prenom', 'prenom', 'last name', 'text', 
    1);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (3, 'password', 'password', 'password', 'password', 
    1);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (4, 'email', 'email', 'Email', 'text', 
    1);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (5, 'file', 'fichier', 'upload file', 'file', 
    1);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (6, 'test1', 'test1', 'test 1', 'text', 
    2);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    VALUE, FORMSTEPID)
 Values
   (7, 'test2', 'test2', 'test 2', 'checkbox', 
    'test checkbox', 3);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (8, 'test21', 'test21', 'test21', 'text', 
    2);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (9, 'test22', 'test22', 'test22', 'text', 
    2);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (10, 'test31', 'test31', 'test31', 'text', 
    3);
Insert into CCMDB.FIELD
   (ID, NAME, TITLE, PLACEHOLDER, TYPE, 
    FORMSTEPID)
 Values
   (11, 'test32', 'test32', 'test32', 'file', 
    3);
COMMIT;

Insert into CCMDB.FIELD_VALUES
   (ID, VALUE, SRC, FIELDID)
 Values
   (1, 'RABAT', 'ville', 14);
Insert into CCMDB.FIELD_VALUES
   (ID, VALUE, SRC, FIELDID)
 Values
   (2, 'CASA', 'ville', 14);
Insert into CCMDB.FIELD_VALUES
   (ID, VALUE, SRC, FIELDID)
 Values
   (3, 'RABAT', 'ville', 18);
Insert into CCMDB.FIELD_VALUES
   (ID, VALUE, SRC, FIELDID)
 Values
   (4, 'CASA', 'ville', 18);
COMMIT;

Insert into CCMDB.UTILISATEUR
   (ID, NOM, PRENOM, LOGIN, PASSWORD, 
    PROFILEID)
 Values
   (1, 'elomari', 'elmustapha', 'elomari', 'elomari', 
    1);
Insert into CCMDB.UTILISATEUR
   (ID, NOM, PRENOM, LOGIN, PASSWORD, 
    PROFILEID)
 Values
   (2, 'Elansari', 'Khalid', 'elansri', '1234', 
    1);
Insert into CCMDB.UTILISATEUR
   (ID, NOM, PRENOM, LOGIN, PASSWORD, 
    PROFILEID)
 Values
   (3, 'Essati', 'Abdennasser', 'nasser', '12345', 
    1);
COMMIT;