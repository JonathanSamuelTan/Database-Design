USE JigitalclouN

-- 1
-- Display StaffId, StaffName, StaffGender, StaffSalary, and LongestPeriod 
-- (obtained from the maximum amount of rental duration of the handled transactions) for 
-- every staff who have a salary less than 15000000 and have handled rental transactions 
-- with customers younger than 20 years old.



-- 2
-- Display Location (obtained from LocationCityName, followed by a space and LocationCountryName), 
-- CheapestServerPrice (obtained from the ServerPriceIDR of the server with the lowest price located in each location) 
-- for every location that has a server using processor with clock speed faster than 3000 MHz. and is located at most 30 degrees 
-- from the equator (LocationLatitude must be at least -30 and at most 30).



-- 3
-- Display RentalID, MaxMemoryFrequency (obtained from the maximum MemoryFrequencyMHz followed by ' MHz'), 
-- TotalMemoryCapacity (obtained from the sum of MemoryCapacityGB followed by ' GB') for each rental transaction 
-- which occurs on the last quarter of 2020.
SELECT tr.RentalID, CONCAT(MAX(MemoryFrequency),'MHz') AS MaxMemoryFrequency, CONCAT(sum(MemoryCapacity), 'GB') AS 'TotalMemoryCapacity'
,SalesDate, ts.SalesID
FROM TrRental tr JOIN TrRentalDetail trd ON tr.RentalID = trd.RentalID
JOIN MsServer ms ON trd.ServerID = ms.ServerID 
JOIN MsMemory mm on mm.MemoryID = ms.MemoryID
JOIN TrSalesDetail tsd ON ms.ServerID = tsd.ServerID
JOIN TrSales ts ON tsd.SalesID= ts.SalesID
GROUP BY tr.RentalID, ts.SalesDate, ts.SalesID
HAVING DATEPART(QUARTER, ts.SalesDate) =4 AND YEAR(SalesDate) = 2020

-- SELECT tr.RentalID, CONCAT(MAX(MemoryFrequency),'MHz') AS MaxMemoryFrequency, CONCAT(sum(MemoryCapacity), 'GB'),
-- ts.SalesDate
-- FROM TrRental tr JOIN TrRentalDetail trd ON tr.RentalID = trd.RentalID
-- JOIN MsServer ms ON trd.ServerID = ms.ServerID 
-- JOIN MsMemory mm on mm.MemoryID = ms.MemoryID
-- JOIN TrSalesDetail tsd ON ms.ServerID = tsd.ServerID
-- JOIN TrSales ts ON tsd.SalesID= ts.SalesID
-- WHERE DATEPART(QUARTER, ts.SalesDate) =4
-- GROUP BY tr.RentalID, ts.SalesDate
--Ini versi yang pake where


SELECT SalesId,SalesDate
FROM TrSales


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
    TS.SalesID,
    MostExpensiveServerPriceOddYear.MostExpensiveServerPrice,
    CAST(((0.55 * MSP.ProcessorClockSpeed * MSP.ProcessorCores) + (MSM.MemoryFrequency * MSM.MemoryCapacity * 0.05)) / 143200 AS DECIMAL(18, 3)) AS HardwareRatingIndex
FROM (
    SELECT TOP 10
        TSD.ServerID,
        MAX(MSS.ServerPrice) AS MostExpensiveServerPrice
    FROM TrSalesDetail TSD
    JOIN MsServer MSS ON TSD.ServerID = MSS.ServerID
    JOIN TrSales TS ON TSD.SalesID = TS.SalesID
    WHERE YEAR(TS.SalesDate) % 2 = 1
    GROUP BY TSD.ServerID
    ORDER BY MostExpensiveServerPrice DESC
) AS MostExpensiveServerPriceOddYear
JOIN TrSalesDetail TSD ON MostExpensiveServerPriceOddYear.ServerID = TSD.ServerID
JOIN TrSales TS ON TSD.SalesID = TS.SalesID
JOIN MsServer MSS ON TSD.ServerID = MSS.ServerID
JOIN MsProcessor MSP ON MSS.ProcessorID = MSP.ProcessorID
JOIN MsMemory MSM ON MSS.MemoryID = MSM.MemoryID;



-- 6
-- Display ProcessorName (obtained from the first word of ProcessorName followed by a space and ProcessorModel), 
-- CoreCount (obtained from ProcessorCoreCount followed by ' core(s)', 
-- ProcessorPriceIDR for the most expensive processors among the ones having the same core count and is used in servers located 
-- in the northern hemisphere (LocationLatitude is starts from 0 up to 90). The result must not be duplicate.
-- (ALIAS SUBQUERY)

/* SUBQUERY
SELECT ProcessorID, ProcessorName, ProcessorCores, ProcessorPrice
FROM MsProcessor
WHERE CONCAT(ProcessorCores, '_', ProcessorPrice) IN (
  SELECT CONCAT(ProcessorCores, '_', MAX(ProcessorPrice))
  FROM MsProcessor
  GROUP BY ProcessorCores
);
*/

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