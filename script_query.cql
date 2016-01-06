CREATE INDEX ON :CHEVAL(nom);
CREATE INDEX ON :PARTICIPE(classement);

// Cette requête affiche les gains moyens remportés en courses de chaque cheval du haras
match(cheval:Cheval)-[:EST_MONTE]->(couple:Couple)
match(couple)-[p:PARTICIPE]->()
return cheval.nom as Cheval, avg(p.gain) as Moyenne

// Cette requête affiche le nom du cavalier ayant remporté le plus de victoires avec Houla ainsi que le nombre de victoires associé
//Ici, l'index sur la clé "nom" du label cheval permet d'accélérer l'accès aux chevaux nommés "Houla du Tornegat"). 
//Dans le cas où il n'y aurait pas d'index sur le nom du cheval, on devrait récupérer tous les noeuds de type cheval et comparer leur clé "nom" avec "Houla du Tornegat"
//De même avec l'index sur la clé "classement" de la relation "PARTICIPE".
match(cheval:Cheval{nom:"Houla du Tornegat"})-[:EST_MONTE]->(couple:Couple)
match(couple)-[:PARTICIPE{classement:1}]->()
match(cavalier:Cavalier)-[:MONTE]->(couple)
return cheval.nom as Cheval, cavalier.nom as Cavalier, count(*) as Nb_victoires
order by Nb_victoires desc
limit 1

// Cette requête affiche le nom des cavalières de chaque cheval
//L'index sur "classement" de la relation "PARTICIPE" permet de retrouver rapidement 
//les relations "PARTICIPE" dont la clé "classement" vaut 1 au lieu de parcourir 
//toutes les relations "PARTICIPE" et de comparer la valeur de "classement".
match(cheval:Cheval)-[:EST_MONTE]->(couple:Couple)
match(couple)-[:PARTICIPE{classement:1}]->()
match(cavalier:Cavalier)-[:MONTE]->(couple)
return cheval.nom as Cheval, extract(c IN filter(cav in collect(distinct cavalier) where cav.sexe = 'F')|c.nom ) as Cavalières

// Cette requête affiche le nom du cheval ayant remporté le gain le plus élevé dans une course ainsi que le nom de la course, les propriétaires, le box et le gain associé
match()-[p:PARTICIPE]->(:Course)
with MAX(p.gain) as gain_max
match(course:Course)-[par:PARTICIPE{gain:gain_max}]-(couple:Couple)
match(cheval:Cheval)-[:EST_MONTE]->(couple)
match(proprietaire:Propriétaire)-[:EST_PROPRIETAIRE_DE]->(cheval)
match(cheval)-[:OCCUPE]->(box:Box)
return cheval.nom as Cheval, par.gain as Gain_max, collect(proprietaire.nom) as Propriétaires, box as Emplacement_box, course.nom as Course

// Cette requête affiche le mâle et la femelle dont les produits (poulains) ont remporté le plus de victoires ainsi que la somme de ces victoires.
// Cela sert donc à trouver le couple de chevaux dont les produits sont les plus performants.
match(pere:Cheval)-[:PARENTE{role:'Père'}]->(cheval:Cheval)-->()-[:PARTICIPE{classement:1}]->()
match(mere:Cheval)-[:PARENTE{role:'Mère'}]->(cheval)
with pere as père, mere as mère, count(*) as nb_victoires
with collect(père) as pères, collect(mère) as mères, collect(nb_victoires) as counts, max(nb_victoires) as max_nb_victoires
with max_nb_victoires, extract(i IN range(0, size(counts)-1) | CASE WHEN counts[i] = max_nb_victoires then pères[i] else null end) AS père, extract(i IN range(0, size(counts)-1) | CASE WHEN counts[i] = max_nb_victoires then mères[i] else null end) AS mère
return filter(x in père where x is not null)[0] as Père, filter(x in mère where x is not null)[0] as Mère, max_nb_victoires
