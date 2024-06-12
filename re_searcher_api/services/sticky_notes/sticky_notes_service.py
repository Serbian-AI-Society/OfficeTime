from datetime import datetime


def get_openai_functions():
    return [
        {
            "type": "function",
            "function": {
                "name": "create_sticky_note",
                "description": "Napravi novu belešku baziranu na nekoj činjenici ili zanimljivosti. Pozvati samo kada "
                               "korisnik eksplicitno zatrazi kreiranje beleske.",
                "parameters": {
                    "type": "object",
                    "properties": {
                        "title": {
                            "type": "string",
                            "description": "Naziv beleške, kratak i sadržajan.",
                        },
                        "description": {
                            "type": "string",
                            "description": "Sadržaj beleške, informativna logicka celina, do 200 karaktera.",
                        },
                    },
                    "required": ["title", "description"],
                },
            }
        }
    ]


def create_sticky_note(title, description):
    current_time = datetime.now()
    formatted_time = current_time.strftime("%H:%M %d/%m/%y")
    return {"title": title, "description": description, "timestamp": formatted_time}
