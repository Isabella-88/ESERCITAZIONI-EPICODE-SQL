#ESERCITAZIONE W6D1- SELECT

# PAGINA 1
# punto 1 e 2
# Connettiti al db aziendale o esegui il restore del db. Esplora la tabelle dei prodotti DimProduct
select * from dimproduct;

# punto 3
#Interroga la tabella dei prodotti DimProduct ed esponi in output i campi ProductKey, ProductAlternateKey, EnglishProductName, 
#Color, StandardCost, FinishedGoodsFlag. Il result set deve essere parlante per cui assegna un alias se lo ritieni opportuno.
select ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag as FGF from dimproduct;

#punto 4
#Partendo dalla query scritta nel passaggio precedente, esponi in output i soli prodotti finiti cioè quelli per cui il campo FinishedGoodsFlag è uguale a 1.
select ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag as FGF 
from dimproduct 
where FinishedGoodsFlag='1';

#punto 5
#Scrivi una nuova query al fine di esporre in output i prodotti il cui codice modello ProductAlternateKey comincia con FR oppure BK. 
#Il result set deve contenere il codice prodotto (ProductKey), il modello, il nome del prodotto, il costo standard (StandardCost) e il prezzo di listino (ListPrice).
select ProductKey, ProductAlternateKey, EnglishProductName, StandardCost, ModelName, ListPrice 
from dimproduct 
where ProductAlternateKey like 'FR%' or ProductAlternateKey like 'BK%';

# PAGINA 2
# punto 1
#Arricchisci il risultato della query scritta nel passaggio precedente del Markup applicato dallʼazienda (ListPrice - StandardCost)
select ProductKey, ProductAlternateKey, EnglishProductName, StandardCost, ModelName, ListPrice, ListPrice - StandardCost as Markup 
from dimproduct 
where ProductAlternateKey like 'FR%' or ProductAlternateKey like 'BK%';

#punto 2
#Scrivi unʼaltra query al fine di esporre lʼelenco dei prodotti finiti il cui prezzo di listino è compreso tra 1000 e 2000.
select ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, ListPrice, FinishedGoodsFlag as FGF 
from dimproduct 
where FinishedGoodsFlag='1' and (ListPrice between 1000 and 2000);

#punto 3
#Esplora la tabella degli impiegati aziendali (DimEmployee)
select * from dimemployee;

#punto 4
#Esponi, interrogando la tabella degli impiegati aziendali, lʼelenco dei soli agenti. Gli agenti sono i dipendenti per i quali il campo SalespersonFlag è uguale a 1.
select EmployeeKey, FirstName, LastName, SalespersonFlag 
from dimemployee 
where SalespersonFlag='1';

#punto 5
#Interroga la tabella delle vendite FactResellerSales). Esponi in output lʼelenco delle transazioni registrate a partire dal 1 gennaio 2020
# dei soli codici prodotto: 597, 598, 477, 214. Calcola per ciascuna transazione il profitto (SalesAmount - TotalProductCost).
select * from factresellersales;
select OrderDate, ProductKey, OrderQuantity, UnitPrice, SalesAmount-TotalProductCost as profitto 
from factresellersales 
where OrderDate > 2020-01-01 and ProductKey in (597, 598, 477, 214);