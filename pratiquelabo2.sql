-- Query 3 Le numéro de commande et la date de la commande des commandes du client numéro 10 
-- dont le numéro de commande est supérieur à 2.

SELECT nocommande, datecommande
FROM laboratoire2.commande
WHERE nocommande > 2;

-- Query 4 Les numéros d’article et la description des articles dont le prix unitaire est entre
-- $10 et $20

SELECT noarticle, description, prixunitaire
FROM laboratoire2.article
WHERE prixunitaire BETWEEN 10 AND 20;

-- Le numéro de client, numéro de téléphone du client et numéro de commande pour
-- les commandes faites le 2019-01-06.

SELECT nocommande, notelephone, laboratoire2.client.noclient
FROM laboratoire2.commande
INNER JOIN laboratoire2.client ON laboratoire2.client.noclient = laboratoire2.commande.noclient
WHERE datecommande = '2019-01-06';

-- Query 6 Les numéros d’article commandés au moins une fois par le client numéro 10 après
--le 2019-01-06.

SELECT noarticle
FROM laboratoire2.lignecommande
INNER JOIN laboratoire2.commande ON laboratoire2.commande.nocommande = laboratoire2.lignecommande.nocommande
WHERE noclient = 10 AND laboratoire2.commande.datecommande > '2019-01-06' AND laboratoire2.lignecommande.quantite >= 1
GROUP BY noarticle;

-- Query 7 Les numéros de livraisons correspondant aux commandes faites par le client numéro 10.

SELECT nolivraison
FROM laboratoire2.detaillivraison
INNER JOIN laboratoire2.commande ON laboratoire2.commande.nocommande = laboratoire2.detaillivraison.nocommande
WHERE noclient = 10
GROUP BY nolivraison;

-- Query 8 Les numéros de livraisons correspondant aux commandes faites par le client "Luc Sansom"

SELECT nolivraison
FROM laboratoire2.detaillivraison
INNER JOIN laboratoire2.commande ON laboratoire2.commande.nocommande = laboratoire2.detaillivraison.nocommande
INNER JOIN laboratoire2.client ON laboratoire2.commande.noclient = laboratoire2.client.noclient
WHERE nomclient = 'Luc Sansom'
GROUP BY nolivraison;

-- Query 9 Les numéros de client, nom du client des clients qui n’ont pas placé de commande
-- au mois de mai de l’année 2019.

SELECT noclient, nomclient
FROM laboratoire2.client
WHERE noclient NOT IN
					(
						SELECT client.noclient
						FROM laboratoire2.client
						INNER JOIN laboratoire2.commande ON laboratoire2.commande.noclient = laboratoire2.client.noclient
						WHERE datecommande BETWEEN '2019-05-01' AND '2019-05-31'
					)
					
-- Query 10 Les numéros de client, nom du client des clients qui ont placé de commande au
-- mois de mai de l’année 2019.

SELECT client.noclient, nomclient
FROM laboratoire2.client
INNER JOIN laboratoire2.commande ON commande.noclient = client.noclient
WHERE datecommande BETWEEN '2019-05-01' AND '2019-05-31';

-- Query 11 Les numéros d’article qui apparaissent dans toutes les commandes.

SELECT noarticle
FROM laboratoire2.lignecommande
GROUP BY noarticle
HAVING COUNT(*) = 
				(
					SELECT COUNT(*)
					FROM laboratoire2.commande
				);
				

-- Query 12 Les numéros d’article et sa description qui apparaissent dans toutes les commandes du client 10.

SELECT lignecommande.noarticle, description
FROM laboratoire2.lignecommande
INNER JOIN laboratoire2.commande ON commande.nocommande = lignecommande.nocommande
INNER JOIN laboratoire2.article ON article.noarticle = lignecommande.noarticle
WHERE commande.noclient = 10
GROUP BY lignecommande.noarticle, article.description
HAVING COUNT(*) = 
(
	SELECT COUNT(*)
	FROM laboratoire2.commande
	WHERE noclient = 10
);

-- Query 15 Les articles dont le prix est supérieur à la moyenne

SELECT *
FROM laboratoire2.article
GROUP BY noarticle
HAVING prixunitaire > (SELECT AVG(prixunitaire) FROM laboratoire2.article);	

-- Query 16 Le montant total de la commande numéro 1 avant et après la taxe de 15%.

--SELECT SUM(prixunitaire*quantite) AS avant_taxe, SUM(prixunitaire*quantite)*1.15 AS apres_taxe
--FROM laboratoire2.article
--INNER JOIN laboratoire2.lignecommande ON lignecommande.noarticle = article.noarticle
--WHERE nocommande = 1;
			

					
