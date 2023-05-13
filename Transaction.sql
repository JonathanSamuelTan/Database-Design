USE JigitalclouN

-- insert into transaction table
INSERT INTO TrRental VALUES('JCN-R0101','JCN-C3111','JCN-S4112','2012-01-12',32)
INSERT INTO TrRental VALUES('JCN-R0102','JCN-C6101','JCN-S3101','2012-02-01',12)
INSERT INTO TrRental VALUES('JCN-R0103','JCN-C3101','JCN-S6112','2013-02-28',24)
INSERT INTO TrRental VALUES('JCN-R0104','JCN-C3103','JCN-S7112','2013-03-14',48)
INSERT INTO TrRental VALUES('JCN-R0105','JCN-C5111','JCN-S3201','2014-12-12',12)
INSERT INTO TrRental VALUES('JCN-R0106','JCN-C6111','JCN-S5112','2014-09-12',27)
INSERT INTO TrRental VALUES('JCN-R0107','JCN-C4201','JCN-S3201','2015-04-09',60)
INSERT INTO TrRental VALUES('JCN-R0108','JCN-C3201','JCN-S4201','2015-07-12',12)
INSERT INTO TrRental VALUES('JCN-R0109','JCN-C5101','JCN-S5201','2016-10-09',24)
INSERT INTO TrRental VALUES('JCN-R0110','JCN-C3101','JCN-S6201','2016-05-29',30)
INSERT INTO TrRental VALUES('JCN-R0111','JCN-C5101','JCN-S7201','2017-08-17',45)
INSERT INTO TrRental VALUES('JCN-R0112','JCN-C6101','JCN-S3201','2017-01-31',12)
INSERT INTO TrRental VALUES('JCN-R0113','JCN-C5101','JCN-S4112','2018-05-09',36)
INSERT INTO TrRental VALUES('JCN-R0114','JCN-C7201','JCN-S3101','2018-05-02',10)
INSERT INTO TrRental VALUES('JCN-R0115','JCN-C5111','JCN-S4112','2019-11-11',6)


INSERT INTO TrSales VALUES('JCN-S0101','JCN-C3111','JCN-S4112','2015-01-12')
INSERT INTO TrSales VALUES('JCN-S0102','JCN-C6101','JCN-S3101','2015-08-01')
INSERT INTO TrSales VALUES('JCN-S0103','JCN-C3101','JCN-S6112','2021-06-25')
INSERT INTO TrSales VALUES('JCN-S0104','JCN-C3103','JCN-S7112','2021-11-03')
INSERT INTO TrSales VALUES('JCN-S0105','JCN-C5111','JCN-S3201','2012-07-21')
INSERT INTO TrSales VALUES('JCN-S0106','JCN-C6111','JCN-S5112','2013-06-30')
INSERT INTO TrSales VALUES('JCN-S0107','JCN-C4201','JCN-S3201','2021-01-12')
INSERT INTO TrSales VALUES('JCN-S0108','JCN-C3201','JCN-S4201','2022-10-10')
INSERT INTO TrSales VALUES('JCN-S0109','JCN-C5101','JCN-S5201','2017-09-13')
INSERT INTO TrSales VALUES('JCN-S0110','JCN-C3101','JCN-S6201','2021-01-12')
INSERT INTO TrSales VALUES('JCN-S0111','JCN-C5101','JCN-S7201','2023-01-10')
INSERT INTO TrSales VALUES('JCN-S0112','JCN-C6101','JCN-S3201','2020-10-10')
INSERT INTO TrSales VALUES('JCN-S0113','JCN-C5101','JCN-S4112','2013-01-21')
INSERT INTO TrSales VALUES('JCN-S0114','JCN-C7201','JCN-S3101','2021-05-17')
INSERT INTO TrSales VALUES('JCN-S0115','JCN-C5111','JCN-S4112','2021-09-02')


-- insert into transaction detail table
INSERT INTO TrRentalDetail VALUES('JCN-R0101','JCN-V3101')
INSERT INTO TrRentalDetail VALUES('JCN-R0101','JCN-V3102')
INSERT INTO TrRentalDetail VALUES('JCN-R0102','JCN-V3103')
INSERT INTO TrRentalDetail VALUES('JCN-R0102','JCN-V3104')
INSERT INTO TrRentalDetail VALUES('JCN-R0103','JCN-V3105')
INSERT INTO TrRentalDetail VALUES('JCN-R0103','JCN-V3106')
INSERT INTO TrRentalDetail VALUES('JCN-R0104','JCN-V3107')
INSERT INTO TrRentalDetail VALUES('JCN-R0104','JCN-V3108')
INSERT INTO TrRentalDetail VALUES('JCN-R0105','JCN-V3109')
INSERT INTO TrRentalDetail VALUES('JCN-R0105','JCN-V3110')
INSERT INTO TrRentalDetail VALUES('JCN-R0106','JCN-V3101')
INSERT INTO TrRentalDetail VALUES('JCN-R0106','JCN-V3102')
INSERT INTO TrRentalDetail VALUES('JCN-R0107','JCN-V3103')
INSERT INTO TrRentalDetail VALUES('JCN-R0107','JCN-V3104')
INSERT INTO TrRentalDetail VALUES('JCN-R0108','JCN-V3105')
INSERT INTO TrRentalDetail VALUES('JCN-R0108','JCN-V3106')
INSERT INTO TrRentalDetail VALUES('JCN-R0109','JCN-V3107')
INSERT INTO TrRentalDetail VALUES('JCN-R0109','JCN-V3108')
INSERT INTO TrRentalDetail VALUES('JCN-R0110','JCN-V3109')
INSERT INTO TrRentalDetail VALUES('JCN-R0111','JCN-V3110')
INSERT INTO TrRentalDetail VALUES('JCN-R0112','JCN-V3101')
INSERT INTO TrRentalDetail VALUES('JCN-R0113','JCN-V3102')
INSERT INTO TrRentalDetail VALUES('JCN-R0114','JCN-V3103')
INSERT INTO TrRentalDetail VALUES('JCN-R0115','JCN-V3104')
INSERT INTO TrRentalDetail VALUES('JCN-R0115','JCN-V3105')

INSERT INTO TrSalesDetail VALUES('JCN-S0101','JCN-V3110')
INSERT INTO TrSalesDetail VALUES('JCN-S0101','JCN-V3109')
INSERT INTO TrSalesDetail VALUES('JCN-S0102','JCN-V3108')
INSERT INTO TrSalesDetail VALUES('JCN-S0102','JCN-V3107')
INSERT INTO TrSalesDetail VALUES('JCN-S0103','JCN-V3106')
INSERT INTO TrSalesDetail VALUES('JCN-S0103','JCN-V3105')
INSERT INTO TrSalesDetail VALUES('JCN-S0104','JCN-V3104')
INSERT INTO TrSalesDetail VALUES('JCN-S0104','JCN-V3103')
INSERT INTO TrSalesDetail VALUES('JCN-S0105','JCN-V3102')
INSERT INTO TrSalesDetail VALUES('JCN-S0105','JCN-V3101')
INSERT INTO TrSalesDetail VALUES('JCN-S0106','JCN-V3110')
INSERT INTO TrSalesDetail VALUES('JCN-S0106','JCN-V3109')
INSERT INTO TrSalesDetail VALUES('JCN-S0107','JCN-V3108')
INSERT INTO TrSalesDetail VALUES('JCN-S0107','JCN-V3107')
INSERT INTO TrSalesDetail VALUES('JCN-S0108','JCN-V3106')
INSERT INTO TrSalesDetail VALUES('JCN-S0108','JCN-V3105')
INSERT INTO TrSalesDetail VALUES('JCN-S0109','JCN-V3104')
INSERT INTO TrSalesDetail VALUES('JCN-S0109','JCN-V3103')
INSERT INTO TrSalesDetail VALUES('JCN-S0110','JCN-V3102')
INSERT INTO TrSalesDetail VALUES('JCN-S0111','JCN-V3101')
INSERT INTO TrSalesDetail VALUES('JCN-S0112','JCN-V3110')
INSERT INTO TrSalesDetail VALUES('JCN-S0113','JCN-V3109')
INSERT INTO TrSalesDetail VALUES('JCN-S0114','JCN-V3108')
INSERT INTO TrSalesDetail VALUES('JCN-S0115','JCN-V3107')
INSERT INTO TrSalesDetail VALUES('JCN-S0115','JCN-V3106')

/*
SELECT * FROM TrRental
SELECT * FROM TrSales
SELECT * FROM TrRentalDetail
SELECT * FROM TrSalesDetail
*/