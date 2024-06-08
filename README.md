# RE:searcher
## The Office Team

![Flask](https://img.shields.io/badge/flask-%23000.svg?style=for-the-badge&logo=flask&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![ChatGPT](https://img.shields.io/badge/chatGPT-74aa9c?style=for-the-badge&logo=openai&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)

Ovaj projekat se bavi razvojem **inteligentnog asistenta**. Njegova osnovna funkcija je da korisniku olakša pretragu informacija unutar ličnih dokumenata.

### Osobine alata:

- Otpremanje datoteka
- Formulisanje pitanja
- Kreiranje sažetih pregleda sadržaja
- Efikasno čuvanje korisnikovih beleški

### Cilj:

Cilj je omogućiti korisnicima jednostavno pretraživanje i upravljanje dokumentima, formulisanje pitanja, kreiranje beleški, generisanje paragrafa i definisanje tema i apstrakta dokumenata.

## Testiranje aplikacije
Aplikacija je podignuta na Cloud, tako da ju je moguće testirati bez pokretanja lokalno. Kako je backend podešen da se skalira na 0, moguće je da će prilikom prvog poziva biti potrebno nekoliko sekundi duže. 

[https://flutter-prep-ded99.web.app/home](https://flutter-prep-ded99.web.app/home)

## Implementacija

Naš repozitorijum projekta se sastoji od dva direktorijuma: **backend** i **frontend**.

### Flutter - _re_searcher_ui_

Frontend naše aplikacije koristi Flutter za korisnički interfejs. Hostovan je na Firebase-u. Za efikasno upravljanje stanjem aplikacije koristi se BLOC šablon. Zahvaljujući Flutteru, aplikacija može da radi na svim mobilnim i desktop platformama, kao i na webu.

### Flask - _re_searcher_api_

Backend naše aplikacije koristi Flask mikro-okvir. Omogućava efikasnu interakciju sa chat botom kroz segmente za obradu poruka, preuzimanje dokumenata i autentifikaciju. Koristi AWS servise, RAG model i Pinecone vector DB za precizno pretraživanje i upravljanje podacima, obezbeđujući relevantne informacije i sigurnu komunikaciju.

## Arhitektura rešenja i Dijagram slučajeva korišćenja

### Arhitektura rešenja

<image src="assets/project_architecture.jpg" alt="Arhitektura rešenja">

### Dijagram slučajeva korišćenja

<image src="assets/UseCase.png" alt="Image description">

## Izgled aplikacije

<image src="assets/showcase.gif" alt="Image description">

<image src="assets/Screenshot1.jpg" alt="Image description">

## Planirane dodatne funkcionalnosti:

- Uvezivanje više dokumenata
- Izvoz beleški u PDF format
- Grupisanje dokumenta
- Prepoznavanje slika
- Glasovna komunikacija
- Navigacija kroz istoriju dokumenata

## OfficeTime tim

Predstavljamo tim iza projekta **RE:searcher**!


Tara Pogančev | Vuk Čabrilo | Milan Popđurđev | Laslo Uri
--- | --- | --- | ---
<a href="https://www.linkedin.com/in/tara-pogancev/"><image src="re_searcher_ui/assets/tara.jpg" height="auto" width="100" style="border-radius:0%"></a>|<a href="https://www.linkedin.com/in/vuk-%C4%8Dabrilo-63b369207/"><image src="re_searcher_ui/assets/vuk.jpg" height="auto" width="100" style="border-radius:0%"></a> | <a href="https://www.linkedin.com/in/milan-pop%C4%91ur%C4%91ev/"><image src="re_searcher_ui/assets/milan.jpg" height="auto" width="100" style="border-radius:0%"></a> | <a href="https://www.linkedin.com/in/laslo-uri/"><image src="re_searcher_ui/assets/laslo.jpg" height="auto" width="100" style="border-radius:0%"></a>
<a href="https://www.linkedin.com/in/tara-pogancev/"><image src="assets/TeamMembers/TaraReal.png" height="auto" width="100" style="border-radius:0%"></a>|<a href="https://www.linkedin.com/in/vuk-%C4%8Dabrilo-63b369207/"><image src="assets/TeamMembers/VukReal.png" height="auto" width="100" style="border-radius:0%"></a> | <a href="https://www.linkedin.com/in/milan-pop%C4%91ur%C4%91ev/"><image src="assets/TeamMembers/MilanReal.png" height="auto" width="100" style="border-radius:0%"></a> | <a href="https://www.linkedin.com/in/laslo-uri/"><image src="assets/TeamMembers/LasloReal.png" height="auto" width="100" style="border-radius:0%"></a>

---
