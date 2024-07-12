-- SQL Create DB: Learn how to create a new database.
Create Database SampleDB

-- SQL Drop DB: Understand how to delete an existing database.
DROP DATABASE SampleDB

-- SQL Backup DB: Explore methods to backup your database.
BACKUP DATABASE SampleDB
TO DISK = 'D:\backups\SampleDB.bak';

Create table Persons
(
	PersonID int Primary key,
    LastName varchar(255),
    FirstName varchar(255),
    [Address] varchar(255),
    City varchar(255)
)

-- rename table name
Sp_rename 'Persons', 'Person'

-- rename column name
SP_RENAME 'Person.Address', 'Person.Person_Address', 'COLUMN'

-- Drop table
Drop Table Persons

-- Alter table add column
Alter table Persons
Add Country Varchar(100)

-- Alter table delete column
Alter table Persons
Drop column Country

-- Constrains
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255) NOT NULL,
    Age int
);

-- make column not nullable
ALTER TABLE Persons
ALTER COLUMN Age int Not NULL;

-- make column nullable
ALTER TABLE Persons
ALTER COLUMN Age int Not NULL;


-- use unique key constrain
CREATE TABLE Persons (
    ID int NOT NULL UNIQUE,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);


-- using constrains
CREATE TABLE Student (
    StdID int NOT NULL PRIMARY KEY Identity(1,1),
    RollNo int NOT NULL UNIQUE,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int check (Age<18),
	Gender varchar(10) default 'Male'
);

-- create index on table Student
Create index idx_StdID
on Student (StdID)

-- using foreign key constrains
ALTER TABLE Persons
ADD StdID int;

-- creating foreign key in table
ALTER TABLE Persons
ADD FOREIGN KEY (StdID) REFERENCES Student(StdID);

-- create view 1
Create view view_1 as
Select * from Student

Select * from view_1

--  drop the view 
Drop View view_1

