CREATE TABLE Faculte							--%%good
(
  fac_id INT NOT NULL,
  fac_nom VARCHAR(64) NOT NULL,
  PRIMARY KEY (fac_id)
);

CREATE TABLE statut								--%%good
(
  statut_id INT NOT NULL,
  statut_nom VARCHAR(64) NOT NULL,
  PRIMARY KEY (statut_id)
);

CREATE TABLE campus								--%%good
(
  campus_id INT NOT NULL,
  campus_nom VARCHAR(64) NOT NULL,
  PRIMARY KEY (campus_id)
);

CREATE TABLE caracteristique					--%%good
(
  carac_id INT NOT NULL,
  carac_description VARCHAR(64) NOT NULL,
  PRIMARY KEY (carac_id)
);

CREATE TABLE fonction							
(
  fonc_id INT NOT NULL,
  fonc_detail VARCHAR(128) NOT NULL,
  temps_reservation INTERVAL NOT NULL,
  temps_avance INTERVAL NOT NULL,
  PRIMARY KEY (fonc_id)
);

CREATE TABLE privilege							--%%good
(
  priv_id INT NOT NULL,
  priv_desc VARCHAR(64) NOT NULL,
  PRIMARY KEY (priv_id)
);

CREATE TABLE statut_priv						--%%done
(
  priv_id INT NOT NULL,
  statut_id INT NOT NULL,
  PRIMARY KEY (priv_id, statut_id),
  FOREIGN KEY (priv_id) REFERENCES privilege(priv_id),
  FOREIGN KEY (statut_id) REFERENCES statut(statut_id)
);

CREATE TABLE fonc_priv							--%%DONE
(
  priv_id INT NOT NULL,
  fonc_id INT NOT NULL,
  PRIMARY KEY (priv_id, fonc_id),
  FOREIGN KEY (priv_id) REFERENCES privilege(priv_id),
  FOREIGN KEY (fonc_id) REFERENCES fonction(fonc_id)
);

CREATE TABLE departement						--%%good
(
  dep_id INT NOT NULL,
  dep_nom VARCHAR(64) NOT NULL,
  fac_id INT NOT NULL,
  PRIMARY KEY (dep_id, fac_id),
  FOREIGN KEY (fac_id) REFERENCES Faculte(fac_id)
);

CREATE TABLE pavillion							--%%good
(
  pav_id VARCHAR(3) NOT NULL,
  pav_nom VARCHAR(64) NOT NULL,
  campus_id INT NOT NULL,
  PRIMARY KEY (pav_id),
  FOREIGN KEY (campus_id) REFERENCES campus(campus_id)
);

CREATE TABLE membre							---%%DONE
(
  cip CHAR(8) NOT NULL,
  nom VARCHAR(64) NOT NULL,
  prenom VARCHAR(64) NOT NULL,
  email VARCHAR(64) NOT NULL,
  statut_id INT NOT NULL,
  dep_id INT NOT NULL,
  fac_id INT NOT NULL,
  PRIMARY KEY (cip),
  FOREIGN KEY (statut_id) REFERENCES statut(statut_id),
  FOREIGN KEY (dep_id, fac_id) REFERENCES departement(dep_id, fac_id)
);

CREATE TABLE classe								--%%good
(
  pav_id VARCHAR(3) NOT NULL,
  numero_local INT NOT NULL,
  capacite INT NOT NULL,
  fonc_id INT NOT NULL,
  parent_pav_id VARCHAR(3),
  parente_numero_local INT,
  notes_classe VARCHAR(64),
  PRIMARY KEY (pav_id, numero_local),
  FOREIGN KEY (pav_id) REFERENCES pavillion(pav_id),
  FOREIGN KEY (fonc_id) REFERENCES fonction(fonc_id),
  FOREIGN KEY (parent_pav_id, parente_numero_local) REFERENCES classe(pav_id, numero_local)
);

CREATE TABLE reservation							--%%DONE
(
  debut TIMESTAMP NOT NULL,
  fin TIMESTAMP NOT NULL,
  num_reservation SERIAL,
  cip CHAR(8) NOT NULL,
  numero_local INT NOT NULL,
  pav_id VARCHAR(3) NOT NULL,
  PRIMARY KEY (num_reservation),
  FOREIGN KEY (cip) REFERENCES membre(cip),
  FOREIGN KEY (numero_local, pav_id) REFERENCES classe(numero_local, pav_id)
);

CREATE TABLE journal
(
  temps TIMESTAMP NOT NULL,
  description VARCHAR(64) NOT NULL,
  num_reservation INT NOT NULL,
  PRIMARY KEY (num_reservation, cip),
  FOREIGN KEY (num_reservation) REFERENCES reservation(num_reservation)
);

CREATE TABLE caracterise										--%%DONE
(
  pav_id VARCHAR(3) NOT NULL,
  numero_local INT NOT NULL,
  carac_id INT NOT NULL,
  PRIMARY KEY (pav_id, numero_local, carac_id),
  FOREIGN KEY (pav_id, numero_local) REFERENCES classe(pav_id, numero_local),
  FOREIGN KEY (carac_id) REFERENCES caracteristique(carac_id)
);


-- %% Les fonctions des locaux
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0110, 'Salle de classe generale', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0111, 'Salle de classe specialisee', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0120, 'Salle de seminaire', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0121, 'Cubicules', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0210, 'Laboratoire informatique', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0211, 'Laboratoire denseignement specialise', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0212, 'Atelier', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0213, 'Salle de dessin', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0214, 'Atelier (civil)', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0215, 'Salle de musique', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0216, 'Atelier sur 2 etages, conjoint avec un autre local', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0217, 'Salle de conference', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0372, 'Salle de reunion', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0373, 'Salle dentrevue et de tests', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0510, 'Salle de lecture ou de consultation', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0620, 'Auditorium', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0625, 'Salle de concert', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0640, 'Salle daudience', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(0930, 'Salon de personnel', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(1030, 'Studio denregistrement', '4 hours', '7 days');
INSERT INTO fonction(fonc_id, fonc_detail, temps_reservation, temps_avance) VALUES(1260, 'Hall dentree', '4 hours', '7 days');

-- %% Liste des characteristiques des locaux

INSERT INTO caracteristique(carac_id, carac_description) VALUES(0, 'Connexion a internet');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(1, 'Tables fixes en U et chaises mobiles');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(2, 'Monoplaces');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(3, 'Tables fixes et chaises fixes');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(6, 'Tables pour 2 ou + et chaises mobiles');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(7, 'Tables mobiles et chaises mobiles');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(8, 'Tables hautes et chaises hautes');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(9, 'Tables fixes et chaises mobiles');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(11, 'Ecran');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(14, 'Retroprojecteur');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(15, ' Gradins');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(16, 'Fenêtres');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(17, '1 piano');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(18, '2 pianos');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(19, 'Autres instruments');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(20, 'Système de son');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(21, 'Salle réservée (spéciale)');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(22, 'Ordinateurs PC');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(23, 'Ordinateurs SUN pour génie électrique');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(25, 'Ordinateurs (oscillomètre et multimètre)');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(26, 'Ordinateurs modélisation des structures');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(27, 'Ordinateurs PC');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(28, 'Equipement pour microelectronique');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(29, 'Equipement pour genie electrique');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(30, 'Ordinateurs et equipement pour mecatroni');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(31, 'Equipement metrologie');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(32, 'Equipement de machinerie');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(33, 'Equipement de geologie');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(34, 'Equipement pour la caracterisation');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(35, 'Equipement pour la thermodynamique');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(36, 'Équipement pour génie civil');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(37, 'Television');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(38, 'VHS');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(39, 'Hauts parleurs');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(40, 'Micro');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(41, 'Magnetophone a cassette');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(42, 'Amplificateur audio');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(43, 'Local barre');
INSERT INTO caracteristique(carac_id, carac_description) VALUES(44, 'Prise reseau');

-- %% Liste des faculte

INSERT INTO faculte(fac_id, fac_nom) VALUES(0, 'Faculte de genie');
INSERT INTO faculte(fac_id, fac_nom) VALUES(1, 'Faculte de droit');
INSERT INTO faculte(fac_id, fac_nom) VALUES(2, 'Faculte de education');
INSERT INTO faculte(fac_id, fac_nom) VALUES(3, 'Faculte de gestion');
INSERT INTO faculte(fac_id, fac_nom) VALUES(4, 'Faculte de science');
INSERT INTO faculte(fac_id, fac_nom) VALUES(5, 'Faculte de sciences humaines');
INSERT INTO faculte(fac_id, fac_nom) VALUES(6, 'Faculte de sciences de lactivite physique');

-- %% Liste des departements

INSERT INTO departement(dep_id, fac_id, dep_nom) VALUES(0, 0, 'Genie électrique et Genie informatique');
INSERT INTO departement(dep_id, fac_id, dep_nom) VALUES(1, 0, 'Genie mecanique');
INSERT INTO departement(dep_id, fac_id, dep_nom) VALUES(2, 0, 'Genie biotechnologie');
INSERT INTO departement(dep_id, fac_id, dep_nom) VALUES(3, 0, 'Genie civil');

--Liste des campus

INSERT INTO campus(campus_id, campus_nom) VALUES(0, 'Campus ouest');
INSERT INTO campus(campus_id, campus_nom) VALUES(1, 'Campus est');
INSERT INTO campus(campus_id, campus_nom) VALUES(2, 'Campus de Longueuil');

-- Liste des pavillions

INSERT INTO pavillion(pav_id, pav_nom, campus_id) VALUES('A8', 'Albert-Leblanc', 0);
INSERT INTO pavillion(pav_id, pav_nom, campus_id) VALUES('A9', 'Albert-Leblanc', 0);
INSERT INTO pavillion(pav_id, pav_nom, campus_id) VALUES('J1', 'Centre sportif Yvon-Lamarche', 0);
INSERT INTO pavillion(pav_id, pav_nom, campus_id) VALUES('J2', 'Centre sportif Yvon-Lamarche', 0);
INSERT INTO pavillion(pav_id, pav_nom, campus_id) VALUES('B1', 'Georges Cabana', 0);
INSERT INTO pavillion(pav_id, pav_nom, campus_id) VALUES('B2', 'Georges Cabana', 0);
INSERT INTO pavillion(pav_id, pav_nom, campus_id) VALUES('B6', 'Irenee Picard', 0);
INSERT INTO pavillion(pav_id, pav_nom, campus_id) VALUES('C1', 'J-Armand Bombardier', 0);
INSERT INTO pavillion(pav_id, pav_nom, campus_id) VALUES('C2', 'J-Armand Bombardier', 0);
INSERT INTO pavillion(pav_id, pav_nom, campus_id) VALUES('F1', 'John-S-Bourque', 0);
INSERT INTO pavillion(pav_id, pav_nom, campus_id) VALUES('D6', 'Marie Victorin', 0);
INSERT INTO pavillion(pav_id, pav_nom,campus_id) VALUES('D7', 'Marie Victorin', 0);
INSERT INTO pavillion(pav_id, pav_nom, campus_id) VALUES('B5', 'Multifonctionnel', 0);
INSERT INTO pavillion(pav_id, pav_nom, campus_id) VALUES('A10', 'Recherche en sciences humaines et sociales', 0);
INSERT INTO pavillion(pav_id, pav_nom, campus_id) VALUES('D8', 'Sciences de la vie', 0);
INSERT INTO pavillion(pav_id, pav_nom, campus_id) VALUES('E5', 'Vie etudiante', 0);


-- Liste des classe
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 1007, 21, 0212, NULL, NULL, 'Grand');
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 2018, 10, 0212, NULL, NULL, 'Materiaux composites');
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 2055, 24, 0211, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 3014, 25, 0211, NULL, NULL, 'Laboratoire mecatronique');
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 3027, 15, 0211, NULL, NULL, 'Petit laboratoire de elect');
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 3016, 50, 0210, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 3018, 50, 0211, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 3024, 50, 0211, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 3035, 50, 0210, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 3041, 50, 0210, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 3007, 106, 0620, NULL, NULL, 'Avec console de multi-media');
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 3010, 30, 0211, NULL, NULL, 'Laboratoire de conception VLSI');
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 4016, 91, 0620, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 4018, 10, 0212, NULL, NULL, 'Metallurgie');
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 4019, 8, 0212, NULL, NULL, 'Laboratoire accessoire Atelier');
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 4021, 28, 0210, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 4023, 108, 0620, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 4030, 25, 0211, NULL, NULL, 'Equipement photoelasticite');
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 4028, 14, 0210, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 4008, 106, 0210, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 5012, 35, 0210, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 5026, 38, 0210, NULL, NULL, 'Ordinateurs');
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C1', 5028, 50, 0210, NULL, NULL, 'Ordinateurs');
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe)
VALUES('C2',1015, 21, 0211, NULL, NULL, 'Laboratoire dhydraulique');
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('C2',1042, 40, 0211, NULL, NULL, 'Laboratoire chimie-physique');
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('C2',2040, 10, 0212, 'C2', 1042, ' Laboratoire sans instrument');
--STOP--
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('C1',5001, 198, 0620, NULL, NULL, ' Avec console multi-média');
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('C1',5009, 50, 0111, NULL, NULL, 'Avec console multi-média');
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('C1',5006, 110, 0620, NULL, NULL, 'Avec console multi-média');
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('C2',0009, 100, 0214, NULL, NULL, 'Grand et équipé');  
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('C2',1004, 40, 0212, NULL, NULL, 'Atelier géologie équipement');
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('C2',2514, 57, 0212, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('D7',2018, 35, 0212, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('D7',3001, 22, 0212, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('D7',3002, 54, 0212, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('D7',3007, 45, 0212, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('D7',3009, 21, 0212, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('D7',3010, 50, 0212, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('D7',3011, 54, 0212, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('D7',3012, 44, 0212, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('D7',3013, 40, 0212, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('D7',3014, 48, 0212, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('D7',3015, 125, 0212, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('D7',3016, 45, 0212, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('D7',3017, 48, 0212, NULL, NULL, NULL);
INSERT INTO classe(pav_id, numero_local, capacite, fonc_id, parent_pav_id, parente_numero_local, notes_classe) 
VALUES('D7',3019, 35, 0212, NULL, NULL, NULL);

-- relation caracterise

INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',1007, 30);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',2018, 22);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',2055, 11);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',3014, 22);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',3027, 11);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',3016, 14);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',3018, 24);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',3024, 38);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',3035, 40);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',3041, 11);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',3007, 14);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',3010, 24);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',4016, 38);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',4018, 40);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',4019, 22);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',4021, 11);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',4023, 14);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',4030, 24);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',4028, 38);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',4008, 40);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',5012, 22);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',5026, 11);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',5028, 14);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C2',1042, 14);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C2',1015, 14);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C2',2040, 14);
--STOP

INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',4008, 24);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',4008, 38);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',4008, 40);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',4008, 11);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',5026, 11);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',5028, 14);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',5001, 40);
INSERT INTO caracterise(pav_id, numero_local, carac_id) VALUES('C1',5009, 38);

-- %%Liste des privileges

INSERT INTO privilege(priv_id, priv_desc) VALUES(0, 'reserve 24h avance');
INSERT INTO privilege(priv_id, priv_desc) VALUES(1, 'reservation lecture seulement');
INSERT INTO privilege(priv_id, priv_desc) VALUES(2, 'effacer autoriser');
INSERT INTO privilege(priv_id, priv_desc) VALUES(3, 'peut reserver nimporte quand');

-- %%Liste des status

INSERT INTO statut(statut_id, statut_nom) VALUES(0, 'Etudiant');
INSERT INTO statut(statut_id, statut_nom) VALUES(1, 'Enseignant');
INSERT INTO statut(statut_id, statut_nom) VALUES(2, 'Personnel de soutien');
INSERT INTO statut(statut_id, statut_nom) VALUES(3, 'Administrateur');

--%%Relation fonc_priv

INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(0, 0110);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(3, 0111);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(3, 0120);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(3, 0121);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(3, 0210);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(3, 0211);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(3, 0212);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(3, 0213);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(3, 0214);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(3, 0120);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(3, 0120);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(3, 0120);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(0, 0215);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(0, 0216);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(3, 0217);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(3, 0372);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(3, 0373);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(3, 0510);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(0, 0620);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(0, 0625);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(0, 0640);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(0, 0930);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(0, 1030);
INSERT INTO fonc_priv(priv_id, fonc_id) VALUES(0, 1260);



--%%Relation statut_priv

INSERT INTO statut_priv(priv_id, statut_id) VALUES(0, 0);
INSERT INTO statut_priv(priv_id, statut_id) VALUES(2, 0);
INSERT INTO statut_priv(priv_id, statut_id) VALUES(1, 2);
INSERT INTO statut_priv(priv_id, statut_id) VALUES(2, 1);
INSERT INTO statut_priv(priv_id, statut_id) VALUES(3, 1);
INSERT INTO statut_priv(priv_id, statut_id) VALUES(2, 3);
INSERT INTO statut_priv(priv_id, statut_id) VALUES(3, 3);


-- %%Liste de MEMBRE

INSERT INTO membre(cip, nom, prenom, email, statut_id, dep_id, fac_id) 
VALUES('krok1234','tremblay', 'racine', 'abc@usherbrooke.ca', 0, 0, 0);
INSERT INTO membre(cip, nom, prenom, email, statut_id, dep_id, fac_id) 
VALUES('juli4444','quatre', 'julie', 'jesaispas@usherbrooke.ca', 1, 3, 0);
INSERT INTO membre(cip, nom, prenom, email, statut_id, dep_id, fac_id) 
VALUES('lmao4321','ciao', 'bella', 'email@usherbrooke.ca', 2, 2, 0);
INSERT INTO membre(cip, nom, prenom, email, statut_id, dep_id, fac_id) 
VALUES('kekk8521','young', 'guy', 'non@usherbrooke.ca', 3, 3, 0);
INSERT INTO membre(cip, nom, prenom, email, statut_id, dep_id, fac_id) 
VALUES('booh8371','young', 'thibout', 'oui@usherbrooke.ca', 1, 2, 0);
INSERT INTO membre(cip, nom, prenom, email, statut_id, dep_id, fac_id) 
VALUES('crot8329','young', 'mike', 'ok@usherbrooke.ca', 2, 2, 0);


-- %Liste de reservations

INSERT INTO reservation(debut, fin, cip, numero_local, pav_id) 
VALUES('2020-05-09 12:00:00','2020-05-09 16:00:00', 'krok1234', 3018, 'C1');
INSERT INTO reservation(debut, fin, cip, numero_local, pav_id) 
VALUES('2020-05-09 12:00:00','2020-05-09 16:00:00', 'juli4444', 3016, 'C1');
INSERT INTO reservation(debut, fin, cip, numero_local, pav_id) 
VALUES('2020-05-09 12:00:00','2020-05-09 16:00:00', 'lmao4321', 3027, 'C1');
INSERT INTO reservation(debut, fin, cip, numero_local, pav_id) 
VALUES('2020-05-09 12:00:00','2020-05-09 16:00:00', 'kekk8521', 3041, 'C1');
INSERT INTO reservation(debut, fin, cip, numero_local, pav_id) 
VALUES('2020-05-09 12:00:00','2020-05-09 16:00:00', 'booh8371', 3007, 'C1');


-- TRIGGER MODIFICATION

CREATE FUNCTION enregistre_modification()
    RETURNS trigger
AS $BODY$
BEGIN
	INSERT INTO journal(temps, description, cip, num_reservation)
	VALUES(CURRENT_TIMESTAMP, 'Modification de reservation', NEW.CIP, NEW.num_reservation);
	RETURN NEW;
END;
$BODY$;
LANGUAGE 'plpgsql'

CREATE TRIGGER enregistre_modification_but
BEFORE UPDATE ON reservation
FOR EACH ROW
EXECUTE PROCEDURE enregistre_modification()

-- %%Creation de la table temps Journee

CREATE TABLE temps_journee(
	temps TIME NOT NULL
);

DO $$
DECLARE
debut TIME :='08:00';
fin TIME :='22:00';
temps_interval INTERVAL := '15 minutes';
BEGIN
	LOOP
		EXIT WHEN debut > fin;
		INSERT INTO temps_journee(temps) VALUES (debut);
		debut := debut + temps_interval;
	END LOOP;
END
$$;

-- %% Fonction qui retourne reservations																		----POUR VALIDE--------
CREATE OR REPLACE FUNCTION TABLEAU(horaire_debut TIMESTAMP, horaire_fin TIMESTAMP, horaire_categorie INT)
RETURNS TABLE(heure TIME, numero_local TEXT, reserver_par CHAR(8)) AS
$$
BEGIN
RETURN QUERY SELECT temps AS heure, CONCAT_WS('-',classe.pav_id, classe.numero_local) AS nom_local, cip
		FROM temps_journee 
		CROSS JOIN classe
		LEFT JOIN reservation ON temps BETWEEN reservation.debut::TIME AND reservation.fin::TIME 
					 					AND reservation.numero_local = classe.numero_local
										AND reservation.debut::DATE BETWEEN horaire_debut::DATE AND horaire_fin::DATE
		WHERE temps BETWEEN horaire_debut::TIME AND horaire_fin::TIME
		AND classe.fonc_id = horaire_categorie
		ORDER BY classe.numero_local, temps, cip;
END;
$$
LANGUAGE plpgsql;

-- %% Trigger d'insertion																						-------POUR VALIDE------

CREATE OR REPLACE FUNCTION verifie_insertion()
RETURNS trigger AS 
$$
DECLARE
	par_pav_id VARCHAR(3);
	par_num_local INT;
	curr_local INT;
	rec RECORD;
BEGIN
	IF NEW.debut::TIME NOT BETWEEN '8:00:00' AND '23:00:00' OR NEW.debut < now() THEN 
		RAISE EXCEPTION 'Hors de lhoraire'; 
	END IF;
	NEW.fin := NEW.fin - INTERVAL '1 second';
	--
	-- Check si le statut a le droit de reserver
	--
	IF NEW.cip IN
	(
		SELECT cip
		FROM membre
		INNER JOIN statut_priv ON membre.statut_id = statut_priv.statut_id
		WHERE statut_priv.priv_id = 1
	) THEN RAISE EXCEPTION 'Le statut ne permet pas la reservation';
	END IF;
	--
	-- Check si on peut reserver plus de 24 heures a lavance
	--
	IF NEW.debut - INTERVAL '1 day' > now() THEN
		IF NEW.cip NOT IN
		(
			SELECT cip
			FROM membre
			INNER JOIN statut_priv ON membre.statut_id = statut_priv.statut_id
			WHERE membre.statut_id = 3 OR membre.statut_id = 1
		)
		OR NEW.numero_local NOT IN
		(
			SELECT numero_local
			FROM classe
			INNER JOIN fonc_priv ON classe.fonc_id = fonc_priv.fonc_id
			WHERE fonc_priv.priv_id = 3
		)
		THEN RAISE EXCEPTION 'Ne peut reserver plus de 24 heures a lavance';
		END IF;
	END IF;
	
	--
	-- Check si le local a un parent
	--
	IF EXISTS 
		(
			SELECT * FROM classe
			WHERE pav_id = NEW.pav_id AND numero_local = NEW.numero_local AND parente_numero_local IS NOT NULL
		) AND (SELECT to_regclass('public.enfants')IS NULL) THEN
		RAISE NOTICE 'parent detected';
		SELECT parent_pav_id, parente_numero_local INTO par_pav_id, par_num_local
		FROM classe
		WHERE parent_pav_id = parent_pav_id AND parente_numero_local = parente_numero_local;
		RAISE NOTICE '% %', par_pav_id, par_num_local;
		curr_local := NEW.numero_local;
		INSERT INTO reservation(debut, fin, cip, numero_local, pav_id)
		VALUES(NEW.debut, NEW.fin, NEW.cip, par_num_local, par_pav_id); 
	END IF;
	-- 
	-- Check si le local est un parent
	--
	IF EXISTS 
		(
			SELECT *
			FROM classe
			WHERE parente_numero_local = NEW.numero_local AND parent_pav_id = NEW.pav_id
		) THEN
		RAISE NOTICE 'Ce local est un parent (%-%)', NEW.pav_id, NEW.numero_local;
		par_pav_id := NEW.pav_id;
		par_num_local := NEW.numero_local;
	
		IF (SELECT to_regclass('public.enfants')IS NOT NULL) THEN
			RAISE NOTICE 'Table deja cree';
			RETURN NEW;
		ELSE
			RAISE NOTICE 'Table creer';
			CREATE TABLE enfants();
						FOR rec in SELECT numero_local 
						FROM classe 
						WHERE parent_pav_id = par_pav_id AND parente_numero_local = par_num_local AND numero_local != NEW.numero_local
			LOOP
				RAISE NOTICE 'Reservation enfant %-%', NEW.pav_id, rec.numero_local;
				INSERT INTO reservation(debut, fin, cip, pav_id, numero_local)
				VALUES (NEW.debut, NEW.fin, NEW.cip, NEW.pav_id, rec.numero_local);
				RAISE NOTICE 'Reserve % Parent est %-%', rec.numero_local, par_pav_id, par_num_local;
			END LOOP;	
			DROP TABLE enfants;
			RAISE NOTICE 'Table supprimer';
			RETURN NEW;
		END IF;
	END IF;
	--
	-- Check s'il y a deja une reservation dans le chemin
	--
	IF EXISTS
		(
			SELECT num_reservation
			FROM reservation
			WHERE NEW.numero_local = reservation.numero_local AND 
			(NEW.debut BETWEEN reservation.debut AND reservation.fin 
			OR NEW.fin BETWEEN reservation.debut AND reservation.fin)
		) AND curr_local IS NULL
		THEN RAISE EXCEPTION 'Impossible de reserver';
	END IF;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER verifie_insertion_bit
BEFORE UPDATE ON reservation
FOR EACH ROW
EXECUTE PROCEDURE verifie_insertion()

-- %% Trigger de delete																						-------POUR VALIDE------

CREATE OR REPLACE FUNCTION public.enregistre_delete()
    RETURNS trigger
AS $BODY$
BEGIN
	DELETE FROM reservation WHERE cip = OLD.cip AND debut = OLD.debut;
		
	INSERT INTO journal(temps, description, cip, num_reservation)
	VALUES(CURRENT_TIMESTAMP, 'Suppression de reservation', OLD.cip, OLD.num_reservation);
	
	RETURN OLD;
END;
$BODY$
LANGUAGE plpgsql

CREATE TRIGGER enregistre_delete_adt
BEFORE UPDATE ON reservation
FOR EACH ROW
EXECUTE PROCEDURE enregistre_delete()




