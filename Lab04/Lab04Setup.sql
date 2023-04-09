CREATE TABLE Records (
    RecordIndex int,
    RecordValue int,
    Primary Key (RecordIndex)
);

CREATE TABLE Lock_Table (
    Record int,
    LockType varchar(20),
    LockOwner int,
    Primary Key (Record),
    Foreign Key (Record) References Records(RecordIndex)
);

-- This table act as the temp buffer, all the elements get deleted after each commit

CREATE TABLE Temp_Table (
    TimeStampID int, --1
    RecordIndex int, --2
    OldValue int, --3
    NewValue int, --4
    TransactionID int, --5
    previousTimeStampID int, --6
    TheAction varchar(20), --7
    Primary Key (TimeStampID),
    Foreign Key (RecordIndex) References Records(RecordIndex)
);

drop table Log_Table;

CREATE TABLE Log_Table (
    TimeStampID int, --1
    RecordIndex int, --2
    OldValue int, --3
    NewValue int, --4
    TransactionID int, --5
    previousTimeStampID int, --6
    TheAction varchar(20), --7
    Primary Key (TimeStampID),
    Foreign Key (RecordIndex) References Records(RecordIndex)
);


INSERT INTO Records VALUES (1, 1);
INSERT INTO Records VALUES (2, 2);
INSERT INTO Records VALUES (3, 3);
INSERT INTO Records VALUES (4, 4);
INSERT INTO Records VALUES (5, 5);
INSERT INTO Records VALUES (6, 6);
INSERT INTO Records VALUES (7, 7);
INSERT INTO Records VALUES (8, 8);
INSERT INTO Records VALUES (9, 9);
INSERT INTO Records VALUES (10, 10);

COMMIT;