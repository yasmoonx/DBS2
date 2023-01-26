db.kunde.deleteMany({})
db.auftrag.deleteMany({})
db.auftrag.insertOne(
 { "auftragsnummer" : 1234,
 "kosten" : 6000,
 "beschreibung" : "Entwicklung Onlineshop",
 "jahr" : 2021 });
db.auftrag.insertOne(
 { "auftragsnummer" : 1217,
 "kosten" : 300,
 "beschreibung" : "Installation Webserver",
 "jahr" : 2020 });
db.auftrag.insertOne(
 { "auftragsnummer" : 1218,
 "kosten" : 500,
 "beschreibung" : "Cloud Integration",
 "jahr" : 2020 });

db.auftrag.insertOne(
 { "auftragsnummer" : 1222,
 "kosten" : 2000,
 "beschreibung" : "Optimierung Infrastruktur",
 "jahr" : 2021 });

db.auftrag.insertOne(
 { "auftragsnummer" : 1224,
 "kosten" : 3000,
 "beschreibung" : "Optimierung Infrastruktur",
 "jahr" : 2021 });
db.kunde.insertOne(
 { "name": "Müller",
 "adresse": "Obere Laube 10 78462 Konstanz",
 "auftraege": [{
 "kosten": 6000,
 "details": new DBRef("auftrag", db.auftrag.findOne({
 "auftragsnummer": 1234})._id)},
 {
 "kosten": 300,
 "details": new DBRef("auftrag", db.auftrag.findOne({
 "auftragsnummer": 1217})._id)} ] });
db.kunde.insertOne(
 { "name": "Maier",
 "adresse": "Seestrasse 10 78462 Konstanz",
 "auftraege": [{
 "kosten": 500,
 "details": new DBRef("auftrag", db.auftrag.findOne({
 "auftragsnummer": 1218})._id)
 },
 {
 "kosten": 2000,
 "details": new DBRef("auftrag", db.auftrag.findOne({
 "auftragsnummer": 1222})._id)}] });
db.kunde.insertOne(
 { "name": "Kunz",
 "adresse": "Seestrasse 1 78462 Konstanz",
 "auftraege": [{
 "kosten": 3000,
 "details": new DBRef("auftrag", db.auftrag.findOne({
 "auftragsnummer": 1224})._id)}] });
 
 //a Ermittle alle Aufträge in 2021 über "Entwicklung Onlineshop" oder "Installation Webserver".
 db.auftrag.find({"jahr": 2021,$or:[{"beschreibung":"Entwicklung Onlineshop"},
     {"beschreibung": "Installation Webserver"}]});
 
 
 //b Welche Aufträge wurden 2021 beauftragt? Es soll hier nur die Auftragsbeschreibungen ausgegeben werden, 
 //z.B. "Entwicklung Onlineshop" oder"Installation Server".
 db.auftrag.find({"jahr": 2021},{"_id":0,"beschreibung":1});
 
 
 //c Ermittle alle Kundennamen, die bereits einen Auftrag mit mind. 5000 Euro beauftragt haben.
 db.kunde.find({"auftraege.kosten": {$gte:5000}},{"name": 1});
 
 
 //d Welcher Kunde hat den Auftrag mit Auftragsnummer 1222 beauftragt?
 db.kunde.find({"auftraege.details.$ref": "auftrag","auftraege.details.$id":db.auftrag.findOne({
     "auftragsnummer":1222 })._id},{"name":1});
 
 
 //e Wie viele Kosten haben die einzelnen Kunden insgesamt beauftragt?
 db.kunde.aggregate([{"$project":{"name":"$name","kosten_gesamt": {"$sum":"$auftraege.kosten"}}}]);
 
 
 //f In welchem Jahr hat die Firma an Entwicklung von Onlineshops am meisten Geld
//eingenommen? Es soll ausschliesslich das Jahr und die Summe ausgegeben
//werden.
db.auftrag.aggregate([
{"$match": {"beschreibung": "Entwicklung Onlineshop"}},
{"$project": {"jahr": "$jahr", "summe":{"$sum": "$kosten"}}},
{"$sort":{"summe":-1}},
{"$limit":1}]);
 
 
//g An welchen Aufträgen hat die Firma im Jahr 2021 wie viel Geld eingenommen? Die
//Aufträge sind in „beschreibung“ gespeichert
db.auftrag.aggregate([
{"$match": {"jahr":2021}},
{"$group": {"_id": "$beschreibung", "summe":{"$sum":"$kosten"}}}]);

 
 
 
 
 
 