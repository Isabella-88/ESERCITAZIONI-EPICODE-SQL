#ESERCITAZIONE W7D1 - AGGREGAZIONI

#PAGINA 1
#PUNTO 1
#Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. Quali considerazioni/ragionamenti è necessario che tu faccia?
#affinchè un campo sia chiave primaria sono necessarie due condizioni fondamentali: ongi record deve essere univoco e nn nullo.
#verifico che non ci siano valori nulli
SELECT COUNT(*) AS ValoriNulli
FROM dimproduct
WHERE ProductKey IS NULL;

#verifico che non ci siano valori ripetuti
SELECT COUNT(DISTINCT ProductKey) AS ValoriDistintiChiave, COUNT(ProductKey) AS TotProductKey
FROM dimproduct;

#PUNTO 2
#Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.
SELECT COUNT(*) AS ValoriNulli
FROM factresellersales
WHERE SalesOrderNumber IS NULL OR SalesOrderLineNumber IS NULL;

#PUNTO 3 
#Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.
SELECT COUNT(SalesOrderLineNumber) AS NumeroTransazioni, OrderDate
FROM factresellersales
WHERE OrderDate >= '2020-01-01'
GROUP BY OrderDate
ORDER BY OrderDate DESC;

#PUNTO 4
#Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity) e il prezzo medio di 
#vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) a partire dal 1 Gennaio 2020. Il result set deve esporre pertanto il nome del prodotto, 
#il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. I campi in output devono essere parlanti!

SELECT D.EnglishProductName AS NomeProdotto, SUM(R.SalesAmount) AS FatturatoTotale, SUM(R.OrderQuantity) AS QuantitaVenduta, AVG(R.UnitPrice) AS PrezzoMedioVendita
FROM dimproduct D
JOIN factresellersales R ON R.ProductKey = D.ProductKey
WHERE OrderDate >= '2020-01-01'
GROUP BY D.EnglishProductName;

#PAGINA 2
#PUNTO 1
#Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta (FactResellerSales.OrderQuantity) per Categoria prodotto (DimProductCategory). 
# Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. I campi in output devono essere parlanti!

SELECT C.EnglishProductCategoryName AS NomeProdotto, SUM(R.SalesAmount) AS FatturatoTotale, SUM(R.OrderQuantity) AS QuantitaVenduta
FROM dimproduct D
JOIN factresellersales R ON R.ProductKey = D.ProductKey
JOIN dimproductsubcategory S on D.ProductSubcategoryKey=S.ProductSubcategoryKey
JOIN dimproductcategory C on S.ProductCategoryKey=C.ProductCategoryKey
GROUP BY C.EnglishProductCategoryName;

#PUNTO 2
#Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. Il result set deve esporre lʼelenco delle città 
#con fatturato realizzato superiore a 60K.

SELECT G.City, SUM(F.SalesAmount) AS FatturatoTot
FROM dimreseller R
JOIN dimgeography G ON R.GeographyKey=G.GeographyKey
JOIN factresellersales F ON R.ResellerKey = F.ResellerKey
WHERE F.OrderDate >= '2020-01-01'
GROUP BY G.City
HAVING SUM(F.SalesAmount) > 60000;
