// Supprimer tous les noeuds et toutes les relations
MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r

// Contraintes
CREATE CONSTRAINT ON (ch:Cheval) ASSERT exists(ch.nom)
CREATE CONSTRAINT ON ()-[part:PARTICIPE]-() ASSERT exists(part.classement)
CREATE CONSTRAINT ON ()-[part:PARTICIPE]-() ASSERT exists(part.date)

// Cavaliers
CREATE (Ingrid:Cavalier {nom:'Hurbain', prenom:'Ingrid', sexe:'F', naissance:1993, niveau:5}) 
CREATE (Raphaël:Cavalier {nom:'Laguerre', prenom:'Raphaël', sexe:'M', niveau:7}) 
CREATE (Emma:Cavalier:Propriétaire {nom:'Spalart', prenom:'Emma', sexe:'F', niveau:3}) 

// Chevaux
CREATE (Bonica:Cheval {nom:'Bonica du Teilleul', sexe:'F', naissance:1989, robe:'Bai', race:'Poney Français de Selle'}) 
CREATE (Gala:Cheval {nom:'Gala de Montiège', sexe:'M', naissance:1994, robe:'Gris Rouanné', race:'Poney Français de Selle'}) 
CREATE (Lami:Cheval {nom:'Lami des Herbages', sexe:'H', naissance:1999, robe:'Bai', race:'Poney'}) 
CREATE (Houla:Cheval {nom:'Houla du Tornegat', sexe:'F', naissance:1995, robe:'Alezan', race:'Poney Français de Selle'}) 
CREATE (Jack:Cheval {nom:'Jack de Frontenay', sexe:'H', naissance:1997, robe:'Gris', race:'Demi-Sang Arabe'}) 
CREATE (Horspair:Cheval {nom:'Hors pair', sexe:'M', naissance:1995, robe:'Bai', race:'Poney Français de Selle'})
CREATE (Pyriet:Cheval {nom:'Pyriet des Fontaines', sexe:'F', naissance:2003, robe:'Bai', race:'Selle Français'}) 

// Propriétaires
CREATE (Marc:Propriétaire {nom:'Dupont', prenom:'Marc', sexe:'M', adresse:'123 rue du Pont', téléphone:'0123456789'}) 
CREATE (Agnès:Propriétaire {nom:'Dupuis', prenom:'Agnès', sexe:'F', adresse:'456 rue du Puis', téléphone:'0987654321'}) 
CREATE (Théo:Propriétaire {nom:'Durand', prenom:'Théo', sexe:'M', adresse:'789 rue du Rand', téléphone:'0192837465'})

// Courses
CREATE (Diane:Course {nom:'Prix de Diane', hippodrome:'Chantilly', type:'Galop'})
CREATE (Arc:Course {nom:"Prix de l'Arc de Triomphe", hippodrome:'Longchamp', type:'Galop'})
CREATE (Amérique:Course {nom:"Prix d'Amérique", hippodrome:'Vincennes', type:'Trot'})
CREATE (Cornulier:Course {nom:'Prix de Cornulier', hippodrome:'Vincennes', type:'Trot'})

// Boxes
CREATE (b1:Box {batiment:'A', rangee:1, numero:1})
CREATE (b2:Box {batiment:'A', rangee:1, numero:2})
CREATE (b3:Box {batiment:'A', rangee:2, numero:1})
CREATE (b4:Box {batiment:'A', rangee:2, numero:2})
CREATE (b5:Box {batiment:'B', rangee:1, numero:1})
CREATE (b6:Box {batiment:'B', rangee:1, numero:2})
CREATE (b7:Box {batiment:'B', rangee:1, numero:3})

// Couples
CREATE (IngridJack:Couple)
CREATE (IngridHoula:Couple)
CREATE (RaphaelHoula:Couple)
CREATE (RaphaelGala:Couple)
CREATE (EmmaHoula:Couple)
CREATE (EmmaBonica:Couple)

// Relations de parenté entre les chevaux
CREATE (Bonica)-[:PARENTE {role:'Mère'}]->(Houla)
CREATE (Bonica)-[:PARENTE {role:'Mère'}]->(Lami)
CREATE (Bonica)-[:PARENTE {role:'Mère'}]->(Jack)
CREATE (Bonica)-[:PARENTE {role:'Mère'}]->(Pyriet)
CREATE (Gala)-[:PARENTE {role:'Père'}]->(Houla)
CREATE (Gala)-[:PARENTE {role:'Père'}]->(Lami)
CREATE (Horspair)-[:PARENTE {role:'Père'}]->(Jack)
CREATE (Horspair)-[:PARENTE {role:'Père'}]->(Pyriet)

// Relations de possession d'un cheval par un propriétaire 
CREATE (Marc)-[:EST_PROPRIETAIRE_DE]->(Bonica)
CREATE (Marc)-[:EST_PROPRIETAIRE_DE]->(Jack)
CREATE (Marc)-[:EST_PROPRIETAIRE_DE]->(Gala)
CREATE (Agnès)-[:EST_PROPRIETAIRE_DE]->(Lami)
CREATE (Marc)-[:EST_PROPRIETAIRE_DE]->(Lami)
CREATE (Théo)-[:EST_PROPRIETAIRE_DE]->(Pyriet)
CREATE (Théo)-[:EST_PROPRIETAIRE_DE]->(Horspair)
CREATE (Théo)-[:EST_PROPRIETAIRE_DE]->(Lami)
CREATE (Théo)-[:EST_PROPRIETAIRE_DE]->(Houla)
CREATE (Emma)-[:EST_PROPRIETAIRE_DE]->(Houla)

// Relations d'occupation d'un box par un cheval
CREATE (Bonica)-[:OCCUPE]->(b1)
CREATE (Gala)-[:OCCUPE]->(b2)
CREATE (Lami)-[:OCCUPE]->(b3)
CREATE (Houla)-[:OCCUPE]->(b4)
CREATE (Jack)-[:OCCUPE]->(b5)
CREATE (Horspair)-[:OCCUPE]->(b6)
CREATE (Pyriet)-[:OCCUPE]->(b7)

// Relations d'appartenance d'un cavalier à un couple 
CREATE (Ingrid)-[:MONTE]->(IngridJack)
CREATE (Ingrid)-[:MONTE]->(IngridHoula)
CREATE (Raphaël)-[:MONTE]->(RaphaelGala)
CREATE (Raphaël)-[:MONTE]->(RaphaelHoula)
CREATE (Emma)-[:MONTE]->(EmmaHoula)
CREATE (Emma)-[:MONTE]->(EmmaBonica)

// Relations d'appartenance d'un cheval à un couple 
CREATE (Jack)-[:EST_MONTE]->(IngridJack)
CREATE (Houla)-[:EST_MONTE]->(IngridHoula)
CREATE (Gala)-[:EST_MONTE]->(RaphaelGala)
CREATE (Houla)-[:EST_MONTE]->(RaphaelHoula)
CREATE (Houla)-[:EST_MONTE]->(EmmaHoula)
CREATE (Bonica)-[:EST_MONTE]->(EmmaBonica)

// Relations de participation d'un couple à une course
CREATE (IngridJack)-[:PARTICIPE {classement:1, gain:571400, date:2015}]->(Diane)
CREATE (RaphaelHoula)-[:PARTICIPE {classement:1, gain:2857000, date:2014}]->(Arc)
CREATE (RaphaelHoula)-[:PARTICIPE {classement:1, gain:315000, date:2015}]->(Cornulier)
CREATE (EmmaHoula)-[:PARTICIPE {classement:1, gain:315000, date:2013}]->(Diane)
CREATE (IngridHoula)-[:PARTICIPE {classement:1, gain:114300, date:2014}]->(Diane)
CREATE (RaphaelGala)-[:PARTICIPE {classement:2, gain:228600, date:2015}]->(Diane)
CREATE (EmmaBonica)-[:PARTICIPE {classement:2, gain:1143000, date:2014}]->(Arc)
CREATE (EmmaHoula)-[:PARTICIPE {classement:3, gain:114300, date:2015}]->(Diane)
CREATE (IngridJack)-[:PARTICIPE {classement:3, gain:571500, date:2014}]->(Arc)
