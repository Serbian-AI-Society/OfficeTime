from datetime import datetime


def get_openai_functions():
    return [
        {
            "type": "function",
            "function": {
                "name": "create_sticky_note",
                "description": "Create a new note based on the subject user has requested.",
                "parameters": {
                    "type": "object",
                    "properties": {
                        "title": {
                            "type": "string",
                            "description": "Title of the note, short and concise",
                        },
                        "description": {
                            "type": "string",
                            "description": "Content of the note.",
                        },
                    },
                    "required": ["location", "format"],
                },
            }
        }
    ]


def create_sticky_note(title, description):
    current_time = datetime.now()
    formatted_time = current_time.strftime("%H:%M %d/%m/%y")
    return {"title": title, "description": description, "timestamp": formatted_time}
