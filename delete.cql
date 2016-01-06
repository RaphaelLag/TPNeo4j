// Supprimer tous les noeuds et toutes les relations
MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r
//Suppriler les contraintes
DROP CONSTRAINT ON (ch:Cheval) ASSERT exists(ch.nom)
DROP CONSTRAINT ON ()-[part:PARTICIPE]-() ASSERT exists(part.classement)
DROP CONSTRAINT ON ()-[part:PARTICIPE]-() ASSERT exists(part.date)
