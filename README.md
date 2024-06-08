# RE:searcher

Ovaj projekat se bavi razvojem inteligentnog asistenta. Njegova osnovna funkcija je da korisniku olakša pretragu informacija unutar njegovih dokumenata.

### Osobine alata:

- Otpremanje datoteka
- Formulisanje pitanja
- Kreiranje sažetih pregleda sadržaja
- Efikasno čuvanje korisnikovih beleški

### Cilj:

Cilj je omogućiti korisnicima jednostavno pretraživanje i upravljanje dokumentima, formulisanje pitanja, kreiranje beleški, generisanje paragrafa i definisanje tema i apstrakta dokumenata.

## Implementacija

Naš repozitorijum projekta se sastoji od dva direktorijuma: backend i frontend.

### Flutter - _re_searcher_ui_

Frontend naše aplikacije koristi Flutter za korisnički interfejs. Hostovan je na Microsoft Azure Cloud-u unutar Docker kontejnera radi lakše skalabilnosti i održavanja. Za efikasno upravljanje stanjima koristi se Bloc šablon. Zahvaljujući Flutteru, aplikacija može da radi na svim mobilnim i desktop operativnim sistemima, uključujući web. Aplikacija je strukturirana po principima clean architecture, koristeći GetIt paket za Dependency Injection i Bloc pattern za praćenje stanja.

### Flask - _re_searcher_api_

Backend naše aplikacije koristi Flask mikro-okvir. Omogućava efikasnu interakciju sa chat botom kroz segmente za obradu poruka, preuzimanje dokumenata i autentifikaciju. Koristi AWS servise, RAG model i Pinecone vector DB za precizno pretraživanje i upravljanje podacima, obezbeđujući relevantne informacije i sigurnu komunikaciju.

## Arhitektura rešenja i Dijagram slučajeva korišćenja

![](path-to-image)

### Arhitektura rešenja

### Dijagram slučajeva korišćenja

## Planirane Dodatne Funkcionalnosti:

- Uvezivanje više dokumenata
- Izvoz beleški u PDF
- Grupisanje dokumenta
- Prepoznavanje slika
- Glasovna komunikacija
- Navigacija kroz istoriju dokumenata
