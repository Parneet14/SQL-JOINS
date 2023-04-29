/*1.	Sales Territory (Sales.SalesTerritory) and Currency Rate (Sales.CurrencyRate)
•	What is the sales performance of each sales territory in terms of the average currency rate and number of orders?*/

--1)Sales Territory (Sales.SalesTerritory) and Currency Rate (Sales.CurrencyRate)
Select Sales.SalesTerritory.Name,Sales.CurrencyRate.AverageRate, Count(Sales.SalesOrderHeader.SalesOrderNumber) "Number of Order"
from Sales.SalesTerritory
Left Join Sales.SalesOrderHeader
On Sales.SalesOrderHeader.TerritoryID=Sales.SalesTerritory.TerritoryID 
Left Join Sales.CurrencyRate
ON Sales.CurrencyRate.CurrencyRateID=Sales.SalesOrderHeader.CurrencyRateID
Group by Name,AverageRate Order by Name

/*2.	Special Offer (Sales.SpecialOffer) and Sales Order Header (Sales.SalesOrderHeader)
•	Identify the data flow between the two tables
•	Identify the business keys and how the tables will be connected
•	Produce SQL to join the two tables
"What are the details of sales orders that received discounts and what special offers were applied to these orders?"*/

--2) Special Offer (Sales.SpecialOffer) and Sales Order Header (Sales.SalesOrderHeader)
select  distinct Sales.SalesOrderHeader.SalesOrderNumber,
Sum(Sales.SalesOrderDetail.OrderQty) "Total number of items",
Sum(Sales.SpecialOffer.DiscountPct) "Total Discount",Sales.SpecialOffer.Description
from Sales.SalesOrderHeader
Left join sales.SalesOrderDetail 
on Sales.SalesOrderHeader.SalesOrderID=sales.SalesOrderDetail.SalesOrderID
left Join Sales.SpecialOfferProduct
On Sales.SalesOrderDetail.ProductID=Sales.SpecialOfferProduct.ProductID and Sales.SalesOrderDetail.SpecialOfferID=Sales.SpecialOfferProduct.SpecialOfferID
Inner Join Sales.SpecialOffer
On Sales.SpecialOfferProduct.SpecialofferID=Sales.Specialoffer.SpecialofferID
where Sales.SpecialOffer.DiscountPct!=0.00  
group by SalesOrderNumber,Description
order by SalesOrderNumber

/*3.	Store (Sales.Store) and Person Credit Card (Sales.PersonCreditCard)
•	Identify the data flow between the two tables
•	Identify the business keys and how the tables will be connected
•	Produce SQL to join the two tables
"What are the details of people who have credit cards associated with their business entity and which stores are they associated with?"*/

--3) Store (Sales.Store) and Person Credit Card (Sales.PersonCreditCard) 
--to check in which Store creditcard is used
 select sales.Store.Name,Person.BusinessEntity.BusinessEntityID,Person.person.FirstName, Person.Person.LastName,Sales.PersonCreditCard.CreditCardID 
  from sales.Store 
  Full  join Person.BusinessEntity 
  On Sales.Store.BusinessEntityID=Person.BusinessEntity.BusinessEntityID
  left Join Person.Person
  On Person.BusinessEntity.BusinessEntityID =Person.Person.BusinessEntityID
  iNNER Join Sales.PersonCreditCard
  On Person.person.BusinessEntityID=Sales.PersonCreditCard.BusinessEntityID
 
 /*4.	Currency (Sales.Currency) and Sales Person Quota History (Sales.SalesPersonQuotaHistory)
•	Identify the data flow between the two tables
•	Identify the business keys and how the tables will be connected
•	Produce SQL to join the two tables
"What are the sales quotas of salespersons who have placed orders in different currencies and what are the corresponding currency names?"*/


  --4)Currency (Sales.Currency) and Sales Person Quota History(Sales.SalesPersonQuotaHistory)
   select  Distinct Sales.SalesPersonQuotaHistory.SalesQuota,Sales.Currency.Name from Sales.SalesPersonQuotaHistory
 LEft Join Sales.SalesPerson
 ON
 Sales.SalesPersonQuotaHistory.BusinessEntityID=Sales.SalesPerson.BusinessEntityID
 LEFT Join Sales.SalesOrderHeader
 On Sales.SalesPerson.BusinessEntityID=Sales.SalesOrderHeader.SalesPersonID 
 lEFT joiN Sales.CurrencyRate
 On Sales.SalesOrderHeader.CurrencyRateID=Sales.CurrencyRate.CurrencyRateID
 Left Join Sales.Currency
 ON Sales.CurrencyRate.FromCurrencyCode=Sales.Currency.CurrencyCode

 --2nd method 
 select  Distinct Sales.SalesPersonQuotaHistory.SalesQuota,Sales.Currency.Name from Sales.Currency
  Inner Join Sales.CurrencyRate
 ON Sales.CurrencyRate.ToCurrencyCode=Sales.Currency.CurrencyCode
 Inner joiN Sales.SalesOrderHeader
 On Sales.SalesOrderHeader.CurrencyRateID=Sales.CurrencyRate.CurrencyRateID
 Inner Join Sales.SalesPerson
 On Sales.SalesPerson.BusinessEntityID=Sales.SalesOrderHeader.SalesPersonID 
 Inner Join Sales.SalesPersonQuotaHistory
 ON
 Sales.SalesPersonQuotaHistory.BusinessEntityID=Sales.SalesPerson.BusinessEntityID
 
/* 5.	Sales Territory History (Sales.SalesTerritoryHistory and Special Offer (Sales.SpecialOffer)
•	Identify the data flow between the two tables
•	Identify the business keys and how the tables will be connected
•	Produce SQL to join the two tables
What are the sales details of sales orders in territory 1 that have discounts and which products were discounted?"*/

--- 5)Sales Territory History (Sales.SalesTerritoryHistory and Special Offer (Sales.SpecialOffer)
select Sales.SalesTerritoryHistory.TerritoryID,Sales.SalesTerritory.Name,Sales.SpecialOfferProduct.ProductID,Sales.SpecialOffer.DiscountPct
from Sales.SalesTerritoryHistory
Left Join Sales.SalesTerritory
On Sales.SalesTerritoryHistory.TerritoryID=Sales.SalesTerritory.TerritoryID
Inner Join Sales.SalesOrderHeader
ON Sales.SalesTerritory.TerritoryID=Sales.SalesOrderHeader.TerritoryID
Left Join Sales.SalesOrderDetail
On Sales.SalesOrderHeader.SalesOrderID=Sales.SalesOrderDetail.SalesOrderID
Left Join Sales.SpecialOfferProduct
On Sales.SalesOrderDetail.SpecialOfferID=Sales.SpecialOfferProduct.SpecialOfferID
Left Join Sales.SpecialOffer
On Sales.SpecialOffer.SpecialOfferID=Sales.SpecialOfferProduct.SpecialOfferID
where Sales.SpecialOffer.DiscountPct!=0.00 and Sales.SalesTerritory.TerritoryID=1

/*6.	Sales Order Header (Sales.SalesOrderHeader) and Sales Person (Sales.SalesPerson)
•	Identify the data flow between the two tables
•	Identify the business keys and how the tables will be connected
•	Produce SQL to join the two tables
"What is the bonus and commission earned by each salesperson who has placed orders and how do they compare with each other?"*/

--6)Sales Order Header (Sales.SalesOrderHeader) and Sales Person (Sales.SalesPerson)
select Sales.SalesOrderHeader.SalesPersonID, Sum(Sales.SalesPerson.Bonus) "Total Bonus", Sum(Sales.SalesPerson.CommissionPct) "Commission%"
from Sales.SalesOrderHeader 
Inner Join Sales.SalesPerson
On Sales.SalesOrderHeader.SalesPersonID=Sales.SalesPerson.BusinessEntityID
group by Sales.SalesOrderHeader.SalesPersonID



