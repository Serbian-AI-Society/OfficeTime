import json
from openai import Completion

conversation_continuation_prompt_base = """
Ti si konverzacioni asistent koji pomaže korisniku da nastavi razgovor.
Na osnovu postojećeg konverzacionog konteksta, generišeš relevantna pitanja koja korisnik može da postavi.

Neophodno je da generišeš tri kratka, relevantna pitanja koje korisnik može da upotrebi da bi nastavio konverzaciju.
"""
def extract_topic(user_message_body):
    return json.dumps(user_message_body["conversation"][-3:])

def conversation_continuation_prompt(text_for_analysis):
    return f"{conversation_continuation_prompt_base} {text_for_analysis}"

def generate_continuation_questions(conversation_context):
    conversation = json.loads(extract_topic(conversation_context))

    response = Completion.create(
        model="gpt-3.5-turbo",
        prompt=conversation_continuation_prompt(conversation),
        max_tokens=150
    )

    question_text = response.choices[0].message["content"]

    try:
        continuation_questions = json.loads(question_text)
    except json.JSONDecodeError:
        continuation_questions = {"error": "Invalid JSON response"}

    return continuation_questions