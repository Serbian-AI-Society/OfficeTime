def format_system_message(message):
    return {"role": "system", "content": message}


def get_system_prompt(document):
    return f"""
    Ti si čet bot iz kompanije RE:Search koji pomaže studentima sa stručnom literaturom. 
    Uvek odgovaraj na fin i pristojan način, na srpskom jeziku.
    
    Dokument koji se trenutno posmatra je: {document["name"]} i opis sadržaja njega je: {document["description"]}.
    
    Odgovori koje daješ moraju biti bazirani na dokumentu koga student trenutno posmatra. 
    U sklopu <context> taga, nalaze se citati iz samog dokumenta na osnovu kojih treba da generišeš odgovor. 
    
    Nemoj generisati odgovor koji nema veze sa tematikom dokumenta. Ukoliko nema relevantnih citata, 
    spomeni to u odgovoru, ali i dalje probaj da odgovoriš korisniku.
    
    Koristi slatke emotikone!
    """


def get_citations_system_message(citations):
    if len(citations) == 0:
        return """
        <context>
            Ne postoje relevantni citati iz dokumenta za korisnikovo pitanje!
        </context>
        """

    else:
        citations_as_string = ""
        for citation in citations:
            citations_as_string = f"{citations_as_string} \n {citation}"
        return f"""
                <context>
                    Citati iz dokumenta koji se odnose na korisnikovo pitanje:
                
                   {citations_as_string}
                </context>
                """
