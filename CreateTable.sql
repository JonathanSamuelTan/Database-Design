CREATE DATABASE JigitalclouN
USE JigitalclouN


-- DROP TABLE
-- DROP TABLE TrRental
-- DROP TABLE TrSales
-- DROP TABLE TrSalesDetail
-- DROP TABLE TrRentalDetail
-- DROP TABLE MsServer
-- DROP TABLE MsLocation
-- DROP TABLE MsMemory
-- DROP TABLE MsProcessor
-- DROP TABLE MsStaff
-- DROP TABLE MsCustomer

-- CREATE TABLE
CREATE TABLE MsCustomer(
    CustomerID CHAR(9) PRIMARY KEY NOT NULL
    CONSTRAINT CHK_CustomerID CHECK(CustomerID LIKE 'JCN-C[3-7][1-2][0-9][0-9]'),
    CustomerName VARCHAR(50) NOT NULL,
    CustomerGender VARCHAR(10) NOT NULL
    CONSTRAINT CHK_CustomerGender CHECK(CustomerGender IN('Male','Female')),
    CustomerEmail varchar(50) NOT NULL,
    CustomerDOB DATE NOT NULL
    CONSTRAINT CHK_Age CHECK(DATEDIFF(year,CustomerDOB,GetDATE())>=15),
    CustomerPhone varchar(15) NOT NULL,
    CustomerAddress VARCHAR(255) NOT NULL
)

CREATE TABLE MsStaff(
    StaffID CHAR(9) PRIMARY KEY NOT NULL
    CONSTRAINT CHK_StaffID CHECK(StaffID LIKE 'JCN-S[3-7][1-2][0-9][0-9]'),
    StaffName VARCHAR(50) NOT NULL,
    StaffGender VARCHAR(10) NOT NULL
    CONSTRAINT CHK_StaffGender CHECK(StaffGender IN('Male','Female')),
    StaffEmail varchar(50) NOT NULL
    CONSTRAINT CHK_StaffEmail CHECK(StaffEmail LIKE '___@___.___'),
    StaffDOB DATE NOT NULL,
    StaffPhone varchar(15) NOT NULL,
    StaffAddress VARCHAR(255) NOT NULL,
    StaffSalary INT NOT NULL
    CONSTRAINT CHK_Staffsalary CHECK(StaffSalary > 3500000 AND StaffSalary < 20000000)
)

CREATE TABLE MsProcessor(
    ProcessorID CHAR(9) PRIMARY KEY NOT NULL
    CONSTRAINT CHK_ProcessorID CHECK(ProcessorID LIKE 'JCN-P[3-7][1-2][0-9][0-9]'),
    ProcessorName VARCHAR(50) NOT NULL,
    ProcessorModelCode CHAR(5) NOT NULL,
    ProcessorPrice INT NOT NULL,
    ProcessorClockSpeed INT NOT NULL
    CONSTRAINT CHK_ProcessorClockSpeed CHECK(ProcessorClockSpeed BETWEEN 1500 AND 6000),
    ProcessorCores INT NOT NULL
    CONSTRAINT CHK_ProcessorCores CHECK(ProcessorCores BETWEEN 1 AND 24)
)

CREATE TABLE MsMemory(
    MemoryID CHAR(9) PRIMARY KEY NOT NULL
    CONSTRAINT CHK_MemoryID CHECK(MemoryID LIKE 'JCN-M[3-7][1-2][0-9][0-9]'),
    MemoryName VARCHAR(50) NOT NULL,
    MemoryModelCode CHAR(5) NOT NULL,
    MemoryPrice INT NOT NULL,
    MemoryCapacity INT NOT NULL
    CONSTRAINT CHK_MemoryCapacity CHECK(MemoryCapacity BETWEEN 1 AND 256),
    MemoryFrequency INT NOT NULL
    CONSTRAINT CHK_MemoryFrequency CHECK(MemoryFrequency BETWEEN 1000 AND 5000)
)

CREATE TABLE MsLocation(
    LocationID CHAR(9) PRIMARY KEY NOT NULL
    CONSTRAINT CHK_LocationID CHECK(LocationID LIKE 'JCN-L[3-7][1-2][0-9][0-9]'),
    LocationCity VARCHAR(50) NOT NULL,
    LocationCountry VARCHAR(50) NOT NULL,
    LocationZIPCode INT NOT NULL,
    LocationLatitude DECIMAL(9,6) NOT NULL
    CONSTRAINT CHK_LocationLatitude CHECK(LocationLatitude BETWEEN -90 and 90),
    LocationLongitude DECIMAL(10,6) NOT NULL
    CONSTRAINT CHK_LocationLongitude CHECK(LocationLongitude BETWEEN -180 and 180),
)

CREATE TABLE MsServer(
    ServerID CHAR(9) PRIMARY KEY NOT NULL
    CONSTRAINT CHK_ServerID CHECK(ServerID LIKE 'JCN-V[3-7][1-2][0-9][0-9]'),
    MemoryID CHAR(9) NOT NULL,
    ServerPrice INT NOT NULL,
    LocationID CHAR(9) NOT NULL,
    ProcessorID CHAR(9) NOT NULL,
    FOREIGN KEY(MemoryID) REFERENCES MsMemory(MemoryID),
    FOREIGN KEY(LocationID) REFERENCES MsLocation(LocationID),
    FOREIGN KEY(ProcessorID) REFERENCES MsProcessor(ProcessorID)
)

CREATE TABLE TrRental(
    RentalID CHAR(9) PRIMARY KEY NOT NULL
    CONSTRAINT CHK_RentalID CHECK(RentalID LIKE 'JCN-R[3-7][1-2][0-9][0-9]'),
    CustomerID CHAR(9) NOT NULL,
    StaffID CHAR(9) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES MsCustomer(CustomerID),
    FOREIGN KEY (StaffID) REFERENCES MsStaff(StaffID),
)

CREATE TABLE TrSales(
    SalesID CHAR(9) PRIMARY KEY NOT NULL
    CONSTRAINT CHK_SalesID CHECK(SalesID LIKE 'JCN-S[3-7][1-2][0-9][0-9]'),
    CustomerID CHAR(9) NOT NULL,
    StaffID CHAR(9) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES MsCustomer(CustomerID),
    FOREIGN KEY (StaffID) REFERENCES MsStaff(StaffID),
)


CREATE TABLE TrRentalDetail(
    RentalDetailID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    RentalID CHAR(9) NOT NULL
    CONSTRAINT CHK_RentalIDDetail CHECK(RentalID LIKE 'JCN-R[3-7][1-2][0-9][0-9]'),
    ServerID CHAR(9) NOT NULL
    CONSTRAINT CHK_ServerIDDetail CHECK(ServerID LIKE 'JCN-V[3-7][1-2][0-9][0-9]'),
    StartDate DATE NOT NULL,
    RentalDuration INT NOT NULL,
    FOREIGN KEY (RentalID) REFERENCES TrRental(RentalID),
    FOREIGN KEY (ServerID) REFERENCES MsServer(ServerID),
)

CREATE TABLE TrSalesDetail(
    SalesDetailID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    SalesID CHAR(9) NOT NULL CHECK(SalesID LIKE 'JCN-S[3-7][1-2][0-9][0-9]'),
    ServerID CHAR(9) NOT NULL CHECK(ServerID LIKE 'JCN-V[3-7][1-2][0-9][0-9]'),
    SalesDate DATE NOT NULL,
    FOREIGN KEY (SalesID) REFERENCES TrSales(SalesID),
    FOREIGN KEY (ServerID) REFERENCES MsServer(ServerID),
)