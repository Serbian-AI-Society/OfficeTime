import json

from client import openai_client
from consts import openai_completions_model, suggestions_max_tokes

conversation_continuation_prompt_base = """
Ti si konverzacioni asistent koji pomaže korisniku da nastavi razgovor sa AI asistentom.
Na osnovu poslednjih nekoliko poruka izmedju coveka i AI asistenta, generiši relevantne poruke kojijma 
korisnik može da nastavi razgovor. Korisnik postavlja pitanja vezana za odredjeni dokument a AI daje informacije.

Neophodno je da generišeš tri veoma kratka, koncizna i relevantna pitanja koje korisnik može da upotrebi da bi 
nastavio konverzaciju.

Obavezno formatiraj izlaz kao validnu JSON listu String objekata!
Obavezno generisi odgovovor koji strogo prati sledeci sablon:
["Prvo pitanje?", "Drugo pitanje?", "Trece pitanje?"]

Ovo su prethodne razmenjene poruke izmedju coveka i AI-a:
"""


def extract_recent_messages(conversation):
    return json.dumps(conversation[-5:])


def get_conversation_continuation_prompt(recent_messages_json_string):
    return f"{conversation_continuation_prompt_base} {recent_messages_json_string}"


def generate_continuation_questions(conversation_context):
    conversation = extract_recent_messages(conversation_context)

    response = openai_client.completions.create(
        model=openai_completions_model,
        prompt=get_conversation_continuation_prompt(conversation),
        max_tokens=suggestions_max_tokes,
    )

    question_texts = response.choices[0].text

    try:
        continuation_questions = json.loads(question_texts)
    except json.JSONDecodeError:
        # Invalid JSON format
        continuation_questions = []

    return continuation_questions
