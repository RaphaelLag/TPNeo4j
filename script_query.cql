Match(p:Cheval)-[:PARENTE{role:'Père'}]->(e1:Cheval)-->(:Couple)-[:PARTICIPE{classement:1}]->()
Match(m:Cheval)-[:PARENTE{role:'Mère'}]->(e1)
With p as père, m as mère, count(*) as nb_victoires
With collect(père) as pères, collect(mère) as mères, collect(nb_victoires) as counts, max(nb_victoires) as max_nb_victoires
With max_nb_victoires, extract(i IN range(0, size(counts)-1) | CASE WHEN counts[i] = max_nb_victoires then pères[i] else null end) AS père, extract(i IN range(0, size(counts)-1) | CASE WHEN counts[i] = max_nb_victoires then mères[i] else null end) AS mère
Return filter(x in père where x is not null)[0] , filter(x in mère where x is not null)[0], max_nb_victoires;


//moyenne des gains par cheval
match(ch:Cheval)-[:EST_MONTE]->(co:Couple)
match(co)-[p:PARTICIPE]->(course:Course)
return ch.nom, avg(p.gain)



//pour chaque cheval, affiche le cavalier avec lequel il a remporté le plus de 1e prix
//TODO: manque le cavalier dans le return

match(ch:Cheval)-[:EST_MONTE]->(co:Couple)
match(co)-[p:PARTICIPE{prix:1}]->(course:Course)
match(ca:Cavalier)-[m:MONTE]->(co)
WITH ch.nom AS cheval, ca.nom AS cavalier, count(*) AS nb_victoire
WITH cheval, max(nb_victoire) AS max_victoire
return cheval, max_victoire

//pour Houla, affiche le cavalier avec lequel il a remporté le plus de 1e prix
match(ch:Cheval{nom:"Houla du Tornegat"})-[:EST_MONTE]->(co:Couple)
match(co)-[p:PARTICIPE{classement:1}]->(course:Course)
match(ca:Cavalier)-[m:MONTE]->(co)
return ch.nom AS cheval, ca.nom AS cavalier, count(*) AS nb_victoire
order by nb_victoire DESC
Limit 1


//Affiche pour chaque cheval les noms des ses cavalières 
match(ch:Cheval)-[:EST_MONTE]->(co:Couple)
match(co)-[p:PARTICIPE{classement:1}]->(course:Course)
match(ca:Cavalier)-[m:MONTE]->(co)
return ch.nom AS cheval, extract(cav IN filter(c in collect(distinct ca) where c.sexe = 'F')|cav.nom ) AS cavaliers
