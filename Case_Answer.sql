USE JigitalclouN

-- 1
-- Display StaffId, StaffName, StaffGender, StaffSalary, and LongestPeriod 
-- (obtained from the maximum amount of rental duration of the handled transactions) for 
-- every staff who have a salary less than 15000000 and have handled rental transactions 
-- with customers younger than 20 years old.
SELECT Sf.StaffID, Sf.StaffName, Sf.StaffGender, Sf.StaffSalary,
	MAX(Rd.RentalDuration) AS LongestPeriod
FROM MsStaff AS Sf
	JOIN TrRental AS Rd ON Sf.StaffID = Rd.StaffID
	JOIN MsCustomer AS Ct ON Rd.CustomerID = Ct.CustomerID
WHERE Sf.StaffSalary < 15000000
	AND DATEDIFF(year, Ct.CustomerDOB, GETDATE()) < 20
GROUP BY Sf.StaffID, Sf.StaffName, Sf.StaffGender, Sf.StaffSalary


-- 2
-- Display Location (obtained from LocationCityName, followed by a space and LocationCountryName), 
-- CheapestServerPrice (obtained from the ServerPriceIDR of the server with the lowest price located in each location) 
-- for every location that has a server using processor with clock speed faster than 3000 MHz. and is located at most 30 degrees 
-- from the equator (LocationLatitude must be at least -30 and at most 30).

SELECT
CONCAT (LocationCity,' ', LocationCountry) AS 'Location',
MIN (ServerPrice) AS 'Cheapest Server Price'
FROM MsLocation
JOIN MsServer ON MsLocation.LocationID = MsServer. LocationID
JOIN MsProcessor ON MsServer.ProcessorID = MsProcessor.ProcessorID
WHERE ProcessorClockSpeed > 3000
AND LocationLatitude between -30 and 30
GROUP BY Locationcity, LocationCountry


-- 3
-- Display RentalID, MaxMemoryFrequency (obtained from the maximum MemoryFrequencyMHz followed by ' MHz'), 
-- TotalMemoryCapacity (obtained from the sum of MemoryCapacityGB followed by ' GB') for each rental transaction 
-- which occurs on the last quarter of 2020.

SELECT  tr.RentalID, 
        CONCAT(MAX(MemoryFrequency),' MHz') AS 'MaxMemoryFrequency',
        CONCAT(sum(MemoryCapacity), ' GB') AS 'TotalMemoryCapacity'
FROM TrRental tr 
JOIN TrRentalDetail trd ON tr.RentalID = trd.RentalID
JOIN MsServer ms ON trd.ServerID = ms.ServerID 
JOIN MsMemory mm on mm.MemoryID = ms.MemoryID
WHERE DATEPART(QUARTER, tr.StartDate) =4 AND YEAR(tr.StartDate) = 2020
GROUP BY tr.RentalID

-- 4
-- Display SaleID, ServerCount (obtained from the number of servers in each transaction), AverageServerPrice 
-- (obtained from the average of ServerPriceIDR divided by 1000000 followed by ' million(s) IDR'), for each sale transaction 
-- occurring in 2016 until 2020 and has AverageServerPrice of more than 50000000.

SELECT  S.SalesID,
        Count(SD.ServerID) as 'ServerCount',
        CONCAT(CAST(AVG(ServerPrice)/1000000.0 as DECIMAL(18,1)),' million(s) IDR') as 'AverageServerPrice'
FROM TrSales S JOIN
TrSalesDetail SD on S.SalesID = SD.SalesID JOIN
MsServer SV on SD.ServerID = SV.ServerID
GROUP BY S.SalesID, SalesDate
HAVING 
AVG(ServerPrice) > 50000000
AND
YEAR(S.SalesDate) between 2016 and 2020 

-- 5
-- Display SaleID, MostExpensiveServerPrice (obtained from the most expensive server price in the transaction), 
-- HardwareRatingIndex (obtained from ((0.55 * ProcessorClock * ProcessorCoreCount) + (MemoryFrequency * MemoryCapacityGB * 0.05)) / 143200) 
-- formatted to 3 decimal places) for the sale transactions which has server listed in the top 10 most expensive servers which occurs in odd years.
-- (ALIAS SUBQUERY)

SELECT
  Distinct s.SalesID,
  top_servers.MostExpensiveServerPrice,
  CAST(((0.55 * p.ProcessorClockSpeed * p.ProcessorCores) + (m.MemoryFrequency * m.MemoryCapacity * 0.05)) / 143200 as decimal(18,3)) AS 'HardwareRatingIndex'
FROM
  TrSales s JOIN 
  TrSalesDetail sd ON s.SalesID = sd.SalesID
  JOIN (
    SELECT TOP 10
      srv.ServerID,
      srv.ProcessorID,
      srv.MemoryID,
      srv.ServerPrice AS MostExpensiveServerPrice,
      ts.SalesDate
    FROM
      MsServer srv
      JOIN TrSalesDetail tsd ON srv.ServerID = tsd.ServerID
      JOIN TrSales ts ON tsd.SalesID = ts.SalesID
    WHERE
      YEAR(ts.SalesDate) % 2 !=0
    ORDER BY
      srv.ServerPrice DESC
  ) top_servers ON sd.ServerID = top_servers.ServerID
  JOIN MsProcessor p ON top_servers.ProcessorID = p.ProcessorID
  JOIN MsMemory m ON top_servers.MemoryID = m.MemoryID

-- 6
-- Display ProcessorName (obtained from the first word of ProcessorName followed by a space and ProcessorModel), 
-- CoreCount (obtained from ProcessorCoreCount followed by ' core(s)', 
-- ProcessorPriceIDR for the most expensive processors among the ones having the same core count and is used in servers located 
-- in the northern hemisphere (LocationLatitude is starts from 0 up to 90). The result must not be duplicate.
-- (ALIAS SUBQUERY)

SELECT  CONCAT( LEFT(ExpensiveProcessor.ProcessorName,1),'  ', ExpensiveProcessor.ProcessorModelCode ) as 'ProcessorName',
        CONCAT( ExpensiveProcessor.ProcessorCores, ' core(s)') as 'CoreCount',
        ExpensiveProcessor.ProcessorPrice as 'ProcessorPriceIDR'
FROM (
    SELECT ProcessorID, ProcessorName, ProcessorCores, ProcessorPrice, ProcessorModelCode
    FROM MsProcessor
    WHERE CONCAT(ProcessorCores, '_', ProcessorPrice) IN (
    SELECT CONCAT(ProcessorCores, '_', MAX(ProcessorPrice))
    FROM MsProcessor
    GROUP BY ProcessorCores
    ) 
    
    and

    ProcessorID IN(
        SELECT ProcessorID
        FROM MsServer S
        JOIN MsLocation L on S.LocationID = L.LocationID
        WHERE L.LocationLatitude between 0 and 90
    )

) AS [ExpensiveProcessor];

--7
-- Display HiddenCustomerName (obtained from the first letter of CustomerName followed by '***** *****'), 
-- CurrentPurchaseAmount (obtained from the amount of sale transactions made), CountedPurchaseAmount 
-- (obtained from the amount of sale transactions made), RewardPointsGiven (obtained from the total spending 
-- (counted from the sum of ServerPriceIDR for all transactions made) of the customer divided by 1000000 followed by ' point(s)'), 
-- for each customer who is in the top 10 customer with most spending in server purchasing (sale transactions) in 2015 until 2019 period.
-- (ALIAS SUBQUERY)



-- 8
-- Display StaffName (obtained from 'Staff ' followed by the first word of StaffName), StaffEmail (obtained from replacing part after the '@' in StaffEmail 
-- with 'jigitalcloun.net'), StaffAddress, StaffSalary (obtained from StaffSalary divided by 10000000 followed by ' million(s) IDR'), 
-- TotalValue (obtained from the sum of (ServerPriceIDR / 120 * RentalDuration)) for every staff who have a salary below the average staff salary and 
-- has a TotalValue more than 10000000. (ALIAS SUBQUERY)



-- 9
-- Create a view named ‘ServerRentalDurationView’ to display Server (obtained from Replacing 'JCN-V' in ServerID with 'No. '), 
-- TotalRentalDuration (Obtained from the total rental duration on the server followed by ' month(s)'), MaxSingleRentalDuration 
-- (Obtained from the maximum rental duration on the server followed by ' month(s)') for all servers located in the southern hemisphere 
-- (Latitude is below 0 down to -90) which have more than 50 months of total rental duration.



-- 10
-- Create a view named ‘SoldProcessorPerformanceView’ to display SaleID, MinEffectiveClock 
-- (obtained from the minimum value of ProcessorClockMHZ * ProcessorCoreCount * 0.675, displayed with 1 decimal places followed by ' MHz'), 
-- MaxEffectiveClock (obtained from the maximum value of ProcessorClockMHZ * ProcessorCoreCount * 0.675, displayed with 1 decimal places followed by ' MHz') 
-- for every rental transaction that rents a server using a processor with a core count of a power of 2 and that has a MinEffectiveClock of at least 10000.

CREATE VIEW SoldProcessorPerformanceView AS
SELECT TS.SalesID, 
	MIN(CAST(MP.ProcessorClockSpeed * MP.ProcessorCores * 0.675 AS DECIMAL(10, 1))) AS MinEffectiveClock,
	MAX(CAST(MP.ProcessorClockSpeed * MP.ProcessorCores * 0.675 AS DECIMAL(10, 1))) AS MaxEffectiveClock
FROM TrSales AS TS
	JOIN TrSalesDetail AS TSD ON TS.SalesID = TSD.SalesID
	JOIN MsServer AS MS ON TSD.ServerID = MS.ServerID
	JOIN MsProcessor AS MP ON MS.ProcessorID = MP.ProcessorID
WHERE MP.ProcessorCores & (MP.ProcessorCores - 1) = 0
GROUP BY TS.SalesID
HAVING MIN(CAST(MP.ProcessorClockSpeed * MP.ProcessorCores * 0.675 AS DECIMAL(10, 1))) >= 10000

SELECT * 
FROM SoldProcessorPerformanceView