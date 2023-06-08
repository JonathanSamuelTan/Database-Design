CREATE DATABASE JigitalclouN
USE JigitalclouN

/*
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
*/


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
    StaffSalary INT NOT NULL CHECK(StaffSalary > 3500000 AND StaffSalary < 20000000)
)

CREATE TABLE MsProcessor(
    ProcessorID CHAR(9) PRIMARY KEY NOT NULL CHECK(ProcessorID LIKE 'JCN-P[3-7][1-2][0-9][0-9]'),
    ProcessorName VARCHAR(50) NOT NULL,
    ProcessorModelCode VARCHAR(50) NOT NULL,
    ProcessorPrice INT NOT NULL,
    ProcessorClock INT NOT NULL CHECK(ProcessorClock BETWEEN 1500 AND 6000),
    ProcessorCoreCount INT NOT NULL CHECK(ProcessorCoreCount BETWEEN 1 AND 24)
)

CREATE TABLE MsMemory(
    MemoryID CHAR(9) PRIMARY KEY NOT NULL CHECK(MemoryID LIKE 'JCN-M[3-7][1-2][0-9][0-9]'),
    MemoryName VARCHAR(50) NOT NULL,
    MemoryModelCode VARCHAR(50) NOT NULL,
    MemoryPrice INT NOT NULL,
    MemoryCapacityGB INT NOT NULL  CHECK(MemoryCapacityGB BETWEEN 1 AND 256),
    MemoryFrequencyMHz INT NOT NULL CHECK(MemoryFrequencyMHz BETWEEN 1000 AND 5000)
)

CREATE TABLE MsLocation(
    LocationID CHAR(9) PRIMARY KEY NOT NULL CHECK(LocationID LIKE 'JCN-L[3-7][1-2][0-9][0-9]'),
    LocationCityName VARCHAR(50) NOT NULL,
    LocationCountryName VARCHAR(50) NOT NULL,
    LocationZIPCode INT NOT NULL,
    LocationLatitude DECIMAL(9,6) NOT NULL CHECK(LocationLatitude BETWEEN -90 and 90),
    LocationLongitude DECIMAL(10,6) NOT NULL CHECK(LocationLongitude BETWEEN -180 and 180),
    CONSTRAINT CK_LatitudePrecision CHECK (LocationLatitude LIKE '%.[0-9][0-9][0-9][0-9][0-9][0-9]'),
    CONSTRAINT CK_LongitudePrecision CHECK (LocationLongitude LIKE '%.[0-9][0-9][0-9][0-9][0-9][0-9]'),
)

CREATE TABLE MsServer(
    ServerID CHAR(9) PRIMARY KEY NOT NULL CHECK(ServerID LIKE 'JCN-V[3-7][1-2][0-9][0-9]'),
    MemoryID CHAR(9) NOT NULL,
    LocationID CHAR(9) NOT NULL,
    ProcessorID CHAR(9) NOT NULL,
    ServerPriceIDR INT NOT NULL,
    FOREIGN KEY(MemoryID) REFERENCES MsMemory(MemoryID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(LocationID) REFERENCES MsLocation(LocationID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(ProcessorID) REFERENCES MsProcessor(ProcessorID)
    ON UPDATE CASCADE ON DELETE CASCADE,
)

CREATE TABLE TrRental(
    RentalID CHAR(9) PRIMARY KEY NOT NULL CHECK(RentalID LIKE 'JCN-R[0-2][1-2][0-9][0-9]'),
    CustomerID CHAR(9) NOT NULL,
    StaffID CHAR(9) NOT NULL,
    StartDate DATE NOT NULL CHECK (StartDate >= '2012-01-01' AND StartDate <= GETDATE()),
    RentalDuration INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES MsCustomer(CustomerID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (StaffID) REFERENCES MsStaff(StaffID)
    ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE TrSales(
    SaleID CHAR(9) PRIMARY KEY NOT NULL CHECK(SaleID LIKE 'JCN-S[0-2][1-2][0-9][0-9]'),
    CustomerID CHAR(9) NOT NULL,
    StaffID CHAR(9) NOT NULL,
    SalesDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES MsCustomer(CustomerID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (StaffID) REFERENCES MsStaff(StaffID)
    ON UPDATE CASCADE ON DELETE CASCADE,
)


CREATE TABLE TrRentalDetail(
    RentalID CHAR(9) NOT NULL CHECK(RentalID LIKE 'JCN-R[0-2][1-2][0-9][0-9]'),
    ServerID CHAR(9) NOT NULL CHECK(ServerID LIKE 'JCN-V[3-7][1-2][0-9][0-9]'),
    PRIMARY KEY(RentalID,ServerID),
    FOREIGN KEY (RentalID) REFERENCES TrRental(RentalID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ServerID) REFERENCES MsServer(ServerID)
    ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE TrSalesDetail(
    SaleID CHAR(9) NOT NULL CHECK(SaleID LIKE 'JCN-S[0-2][1-2][0-9][0-9]'),
    ServerID CHAR(9) NOT NULL CHECK(ServerID LIKE 'JCN-V[3-7][1-2][0-9][0-9]'),
    PRIMARY KEY(SaleID,ServerID),
    FOREIGN KEY (SaleID) REFERENCES TrSales(SaleID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ServerID) REFERENCES MsServer(ServerID)
    ON UPDATE CASCADE ON DELETE CASCADE
)