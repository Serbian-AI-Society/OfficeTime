import json
from client import openai_client
conversation_continuation_prompt_base = """
Ti si konverzacioni asistent koji pomaže korisniku da nastavi razgovor.
Na osnovu postojećeg konverzacionog konteksta, generišeš relevantna pitanja koja korisnik može da postavi.
Potrebno je samo da generišeš pitanja, ne i da odgovaraš na njih!

Neophodno je da generišeš tri veoma kratka, koncizna i relevantna pitanja koje korisnik može da upotrebi da bi nastavio konverzaciju.

Obavezno formatiraj izlaz kao JSON objekat!
Ovo je primer formata JSON objekta:
["pitanje br. 1, "pitanje br. 2, "pitanje br. 3"]
"""
def extract_topic(conversation):
    return json.dumps(conversation[-3:])

def conversation_continuation_prompt(text_for_analysis):
    return f"{conversation_continuation_prompt_base} {text_for_analysis}"

def generate_continuation_questions(conversation_context):
    conversation = json.loads(extract_topic(conversation_context))

    response = openai_client.completions.create(
        model="gpt-3.5-turbo-instruct",
        prompt=conversation_continuation_prompt(conversation),
        max_tokens=150,
    )

    question_texts = response.choices[0].text

    try:
        continuation_questions = json.loads(question_texts)
    except json.JSONDecodeError:
        continuation_questions = {"error": "Invalid JSON response"}

    return continuation_questions