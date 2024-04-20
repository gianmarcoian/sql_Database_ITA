SELECT Nome, Cognome, NumSaleAccedibili
FROM centro_sportivo.CLIENTE2 NATURAL JOIN centro_sportivo.CLIENTE1 JOIN centro_sportivo.ABBONAMENTO 
ON NumeroAbb=NumAbbonamento
WHERE NumSaleAccedibili IN (1,3);

SELECT Nome,Cognome
FROM centro_sportivo.CLIENTE2 NATURAL JOIN centro_sportivo.CLIENTE1 AS C1
JOIN centro_sportivo.ABBONAMENTO AS A
ON C1.NumeroAbb=A.NumAbbonamento
JOIN centro_sportivo.validoper AS V
ON V.NumeroAbb=A.NumAbbonamento
JOIN centro_sportivo.sala
ON NumeroSala=NumSala
NATURAL JOIN  centro_sportivo.salapesi
WHERE NumMacchinari = ( Select MAX(NumMacchinari) 
						FROM salapesi);
                        
                        
SELECT NumTessera, COUNT(*) AS 'Numero persone nate nel 1999'
FROM CLIENTE1
WHERE CF IN (
    SELECT CF
    FROM CLIENTE2
    WHERE DataNascita LIKE '1999%'
)
ORDER BY NumTessera ASC;


-- restituisce il numero di sale per ogni struttura nel centro sportivo, insieme al massimo numero di corsie tra tutte le piscine associate a ciascuna sala
SELECT S.CodiceStruttura, COUNT(*) AS 'NumeroSale', MAX(P.NumCorsie) AS 'MassimoCorsie'
FROM centro_sportivo.Sala AS S
LEFT JOIN centro_sportivo.Piscina AS P ON S.NumSala = P.NumSala
GROUP BY S.CodiceStruttura;



SELECT Nome,Cognome
FROM centro_sportivo.CLIENTE2 NATURAL JOIN centro_sportivo.CLIENTE1 AS C1
JOIN centro_sportivo.ABBONAMENTO AS A ON C1.NumeroAbb=A.NumAbbonamento
JOIN centro_sportivo.validoper AS V ON V.NumeroAbb=A.NumAbbonamento
JOIN centro_sportivo.sala ON NumeroSala=NumSala NATURAL JOIN centro_sportivo.salapesi
WHERE NumMacchinari = ( Select MAX(NumMacchinari) FROM salapesi);

