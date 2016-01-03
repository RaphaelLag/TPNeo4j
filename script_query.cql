Match(m:Cheval)-[p:PARENTE{role:'Mère'}]->(e:Cheval) return m


//moyenne des gains par cheval
match(ch:Cheval)-[:EST_MONTE]->(co:Couple)
match(co)-[p:PARTICIPE]->(course:Course)
return ch.nom, avg(p.gain)
