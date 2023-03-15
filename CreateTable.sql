CREATE DATABASE JigitalclouN
USE JigitalclouN

-- CREATE TABLE
CREATE TABLE MsCustomer(
    CustomerID CHAR(9) PRIMARY KEY NOT NULL CHECK(CustomerID LIKE 'JCN-C[3-7][1-2][0-9][0-9]'),
    CustomerName VARCHAR(50) NOT NULL,
    CustomerGender VARCHAR(10) NOT NULL CHECK(CustomerGender IN('Male','Female')),
    CustomerEmail varchar(50) NOT NULL,
    CustomerDOB DATE NOT NULL CHECK(DATEDIFF(year,CustomerDOB,GetDATE())>=15),
    CustomerPhone varchar(15) NOT NULL,
    CustomerAddress VARCHAR(255) NOT NULL
)

CREATE TABLE MsStaff(
    StaffID CHAR(9) PRIMARY KEY NOT NULL CHECK(StaffID LIKE 'JCN-S[3-7][1-2][0-9][0-9]'),
    StaffName VARCHAR(50) NOT NULL,
    StaffGender VARCHAR(10) NOT NULL CHECK(StaffGender IN('Male','Female')),
    StaffEmail varchar(50) NOT NULL CHECK(StaffEmail LIKE '___@___.___'),
    StaffDOB DATE NOT NULL,
    StaffPhone varchar(15) NOT NULL,
    StaffAddress VARCHAR(255) NOT NULL,
    StaffSalary INT NOT NULL
    CONSTRAINT CHK_Staffsalary CHECK(StaffSalary > 3500000 AND StaffSalary < 20000000)
)

CREATE TABLE MsProcessor(
    ProcessorID CHAR(9) PRIMARY KEY NOT NULL CHECK(ProcessorID LIKE 'JCN-P[3-7][1-2][0-9][0-9]'),
    ProcessorName VARCHAR(50) NOT NULL,
    ProcessorModelCode VARCHAR(50) NOT NULL,
    ProcessorPrice INT NOT NULL,
    ProcessorClockSpeed INT NOT NULL
    CONSTRAINT CHK_ProcessorClockSpeed CHECK(ProcessorClockSpeed BETWEEN 1500 AND 6000),
    ProcessorCores INT NOT NULL
    CONSTRAINT CHK_ProcessorCores CHECK(ProcessorCores BETWEEN 1 AND 24)
)

CREATE TABLE MsMemory(
    MemoryID CHAR(9) PRIMARY KEY NOT NULL CHECK(MemoryID LIKE 'JCN-M[3-7][1-2][0-9][0-9]'),
    MemoryName VARCHAR(50) NOT NULL,
    MemoryModelCode VARCHAR(50) NOT NULL,
    MemoryPrice INT NOT NULL,
    MemoryCapacity INT NOT NULL  CHECK(MemoryCapacity BETWEEN 1 AND 256),
    MemoryFrequency INT NOT NULL CHECK(MemoryFrequency BETWEEN 1000 AND 5000)
)

CREATE TABLE MsLocation(
    LocationID CHAR(9) PRIMARY KEY NOT NULL CHECK(LocationID LIKE 'JCN-L[3-7][1-2][0-9][0-9]'),
    LocationCity VARCHAR(50) NOT NULL,
    LocationCountry VARCHAR(50) NOT NULL,
    LocationZIPCode INT NOT NULL,
    LocationLatitude DECIMAL(9,6) NOT NULL CHECK(LocationLatitude BETWEEN -90 and 90),
    LocationLongitude DECIMAL(10,6) NOT NULL CHECK(LocationLongitude BETWEEN -180 and 180),
    CONSTRAINT CK_LatitudePrecision CHECK (LocationLatitude LIKE '%.[0-9][0-9][0-9][0-9][0-9][0-9]' OR LocationLatitude LIKE '%.[0-9][0-9][0-9][0-9][0-9][0-9]'),
    CONSTRAINT CK_LongitudePrecision CHECK (LocationLongitude LIKE '%.[0-9][0-9][0-9][0-9][0-9][0-9]' OR LocationLongitude LIKE '%.[0-9][0-9][0-9][0-9][0-9][0-9]'),
)

CREATE TABLE MsServer(
    ServerID CHAR(9) PRIMARY KEY NOT NULL CHECK(ServerID LIKE 'JCN-V[3-7][1-2][0-9][0-9]'),
    MemoryID CHAR(9) NOT NULL,
    LocationID CHAR(9) NOT NULL,
    ProcessorID CHAR(9) NOT NULL,
    ServerPrice INT NOT NULL,
    FOREIGN KEY(MemoryID) REFERENCES MsMemory(MemoryID),
    FOREIGN KEY(LocationID) REFERENCES MsLocation(LocationID),
    FOREIGN KEY(ProcessorID) REFERENCES MsProcessor(ProcessorID)
)

CREATE TABLE TrRental(
    RentalID CHAR(9) PRIMARY KEY NOT NULL CHECK(RentalID LIKE 'JCN-R[0-2][1-2][0-9][0-9]'),
    CustomerID CHAR(9) NOT NULL,
    StaffID CHAR(9) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES MsCustomer(CustomerID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (StaffID) REFERENCES MsStaff(StaffID)
    ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE TrSales(
    SalesID CHAR(9) PRIMARY KEY NOT NULL CHECK(SalesID LIKE 'JCN-S[0-2][1-2][0-9][0-9]'),
    CustomerID CHAR(9) NOT NULL,
    StaffID CHAR(9) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES MsCustomer(CustomerID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (StaffID) REFERENCES MsStaff(StaffID)
    ON UPDATE CASCADE ON DELETE CASCADE,
)


CREATE TABLE TrRentalDetail(
    RentalID CHAR(9) NOT NULL CHECK(RentalID LIKE 'JCN-R[0-2][1-2][0-9][0-9]'),
    ServerID CHAR(9) NOT NULL CHECK(ServerID LIKE 'JCN-V[3-7][1-2][0-9][0-9]'),
    StartDate DATE NOT NULL,
    RentalDuration INT NOT NULL,
    PRIMARY KEY(RentalID,ServerID),
    FOREIGN KEY (RentalID) REFERENCES TrRental(RentalID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ServerID) REFERENCES MsServer(ServerID)
    ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE TrSalesDetail(
    SalesID CHAR(9) NOT NULL CHECK(SalesID LIKE 'JCN-S[0-2][1-2][0-9][0-9]'),
    ServerID CHAR(9) NOT NULL CHECK(ServerID LIKE 'JCN-V[3-7][1-2][0-9][0-9]'),
    SalesDate DATE NOT NULL,
    PRIMARY KEY(SalesID,ServerID),
    FOREIGN KEY (SalesID) REFERENCES TrSales(SalesID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ServerID) REFERENCES MsServer(ServerID)
    ON UPDATE CASCADE ON DELETE CASCADE
)

-- DROP TABLE
DROP TABLE TrSalesDetail
DROP TABLE TrRentalDetail
DROP TABLE TrRental
DROP TABLE TrSales
DROP TABLE MsStaff
DROP TABLE MsCustomer
DROP TABLE MsServer
DROP TABLE MsLocation
DROP TABLE MsMemory
DROP TABLE MsProcessor


-- SELECT *
-- SELECT * FROM TrRental
-- SELECT * FROM TrSales
-- SELECT * FROM TrSalesDetail
-- SELECT * FROM TrRentalDetail
--SELECT * FROM MsServer
--SELECT * FROM MsLocation
--SELECT * FROM MsMemory
--SELECT * FROM MsProcessor
--SELECT * FROM MsStaff
--SELECT * FROM MsCustomer

-- INSERT INTO MASTER TABLE

INSERT INTO MsCustomer VALUES('JCN-C3101','Budi Budiman','Male','Budi_B@gmail.com','2000-12-31','085775001112','Jl. Melati 31 Jakarta Pusat')
INSERT INTO MsCustomer VALUES()
INSERT INTO MsCustomer VALUES()
INSERT INTO MsCustomer VALUES()
INSERT INTO MsCustomer VALUES()
INSERT INTO MsCustomer VALUES()
INSERT INTO MsCustomer VALUES()
INSERT INTO MsCustomer VALUES()
INSERT INTO MsCustomer VALUES()
INSERT INTO MsCustomer VALUES()

-- email staff harus @JCN.com
INSERT INTO MsStaff VALUES('JCN-S3101','Muhammad Ali','Male','Ali@JCN.com','2003-10-31','085819500111','Jl. Surya Kencana 01 Jakarta Barat','5000000')
INSERT INTO MsStaff VALUES()
INSERT INTO MsStaff VALUES()
INSERT INTO MsStaff VALUES()
INSERT INTO MsStaff VALUES()
INSERT INTO MsStaff VALUES()
INSERT INTO MsStaff VALUES()
INSERT INTO MsStaff VALUES()
INSERT INTO MsStaff VALUES()
INSERT INTO MsStaff VALUES()

INSERT INTO MsMemory VALUES('JCN-M3101','Hyperion HX7500','HY7500','1500000','16','3200')
INSERT INTO MsMemory VALUES()
INSERT INTO MsMemory VALUES()
INSERT INTO MsMemory VALUES()
INSERT INTO MsMemory VALUES()
INSERT INTO MsMemory VALUES()
INSERT INTO MsMemory VALUES()
INSERT INTO MsMemory VALUES()
INSERT INTO MsMemory VALUES()
INSERT INTO MsMemory VALUES()

INSERT INTO MsProcessor VALUES('JCN-P3101','Intel Xeon Platinum 8380','BX807098380','142000000','2800','24')
INSERT INTO MsProcessor VALUES()
INSERT INTO MsProcessor VALUES()
INSERT INTO MsProcessor VALUES()
INSERT INTO MsProcessor VALUES()
INSERT INTO MsProcessor VALUES()
INSERT INTO MsProcessor VALUES()
INSERT INTO MsProcessor VALUES()
INSERT INTO MsProcessor VALUES()
INSERT INTO MsProcessor VALUES()

INSERT INTO MsLocation VALUES('JCN-L3101','New York City','United States','10001','40.712776','-74.005974')
INSERT INTO MsLocation VALUES()
INSERT INTO MsLocation VALUES()
INSERT INTO MsLocation VALUES()
INSERT INTO MsLocation VALUES()
INSERT INTO MsLocation VALUES()
INSERT INTO MsLocation VALUES()
INSERT INTO MsLocation VALUES()
INSERT INTO MsLocation VALUES()
INSERT INTO MsLocation VALUES()

INSERT INTO MsServer VALUES('JCN-V3101','JCN-M3101','JCN-L3101','JCN-P3101','100000000')
INSERT INTO MsServer VALUES()
INSERT INTO MsServer VALUES()
INSERT INTO MsServer VALUES()
INSERT INTO MsServer VALUES()
INSERT INTO MsServer VALUES()
INSERT INTO MsServer VALUES()
INSERT INTO MsServer VALUES()
INSERT INTO MsServer VALUES()
INSERT INTO MsServer VALUES()

-- INSERT INTO TRANSACTION TABLE
--Tes git KENNY
--tes git kenny 2