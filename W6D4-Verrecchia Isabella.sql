#ESERCITAZIONE W6D4 -JOIN E SUBQUERY


#PAGINA 1
#punto 1 e 2
#esponi l'anagrafica dei prodotti e la loro categoria e sottocategoria
select * from dimproduct;
select * from dimproductcategory;

select D.EnglishProductName,D.ProductKey, SUB.EnglishProductSubcategoryName, CAT.EnglishProductCategoryName
from dimproduct D 
join dimproductsubcategory SUB on D.ProductSubcategoryKey=SUB.ProductCategoryKey
join dimproductcategory CAT on SUB.ProductCategoryKey=CAT.ProductCategoryKey;

#punto 3
#esponi l'elenco dei soli prodotti venduti
select * from factresellersales;
select D.EnglishProductName, F.SalesAmount 
from dimproduct D
join factresellersales F on D.ProductKey=F.ProductKey;

#punto 4 
#esponi l'elenco dei prodotti non venduti ma che sono stati completati
select D.EnglishProductName, D.FinishedGoodsFlag, F.SalesAmount
from dimproduct D
left join factresellersales F on D.ProductKey=F.ProductKey
where SalesOrderNumber is null
and D.FinishedGoodsFlag =1;

#punto 5 
#esponi l'elenco delle transazioni di vendita e il nome del prodotto venduto
select D.EnglishProductName, F.TotalProductCost, F.SalesAmount 
from factresellersales F
join dimproduct D on F.ProductKey=D.ProductKey;

#PAGINA 2
#punto 1 
#esponi lʼelenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto
select * from dimproductsubcategory;

select D.EnglishProductName,F.SalesAmount,SUB.EnglishProductSubcategoryName,CAT.EnglishProductCategoryName
from factresellersales F
join dimproduct D on F.ProductKey=D.ProductKey
join dimproductsubcategory SUB on D.ProductSubcategoryKey=SUB.ProductSubcategoryKey
join dimproductcategory CAT on SUB.ProductCategoryKey=CAT.ProductCategoryKey;

#punto 2 
#esplora la tabella DimReseller.
select * from dimreseller;

#punto 3 
#esponi in output lʼelenco dei reseller indicando, per ciascun reseller, anche la sua area geografica.
select R.ResellerKey, R.ResellerName, G.City
from dimreseller R
join dimgeography G on R.GeographyKey=G.GeographyKey;

#punto 4 
#esponi lʼelenco delle transazioni di vendita. Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate,
# UnitPrice, Quantity, TotalProductCost. Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto,
# il nome del reseller e lʼarea geografica.

select F.SalesOrderNumber, F.SalesOrderLineNumber, F.OrderDate, F.UnitPrice, F.OrderQuantity, F.TotalProductCost, F.SalesAmount, D.EnglishProductName,SUB.EnglishProductSubcategoryName,CAT.EnglishProductCategoryName, R.ResellerName, G.City
from factresellersales F
join dimproduct D on F.ProductKey=D.ProductKey
join dimproductsubcategory SUB on D.ProductSubcategoryKey=SUB.ProductSubcategoryKey
join dimproductcategory CAT on SUB.ProductCategoryKey=CAT.ProductCategoryKey
join dimreseller R on F.ResellerKey = R.ResellerKey
join dimgeography G on R.GeographyKey=G.GeographyKey;

