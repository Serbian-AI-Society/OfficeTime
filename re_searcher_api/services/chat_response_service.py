import json

from openai import OpenAI

from consts import openai_api_key
from core.document_retrival_service import get_document_citations
from core.system_prompts import get_citations_system_message, get_system_prompt, format_system_message
from services.sticky_notes_service import get_openai_functions, create_sticky_note

client = OpenAI(
    api_key=openai_api_key
)


def generate_chat_response(user_message_body):
    # 1. Extract user message
    user_message = user_message_body["conversation"][-1]["content"]
    document = user_message_body["active_document"]
    conversation = user_message_body["conversation"]

    response_message = ""
    sticky_note = None
    document_keyword = None

    # 2. Find relevant info from documents -> insert doc data into context
    citations = get_document_citations(user_message, document["filename"])
    conversation.append(format_system_message(get_citations_system_message(citations)))
    conversation.insert(0, format_system_message(get_system_prompt(document)))

    # 3. Call OpenAI API:
    #   -> Generate response with citation
    #   -> Address function: -> Add sticky note
    #                        -> List keywords for that document
    response = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=conversation,
        tools=get_openai_functions(),
        tool_choice="auto",
        max_tokens=500
    )

    # 3.5 Check for function calls
    first_choice = response.choices[0].message
    function_call = first_choice.tool_calls

    if function_call:
        function_name = function_call[0].function.name
        function_params = json.loads(function_call[0].function.arguments)

        print(f"Function called: {function_name}")
        if function_name == "create_sticky_note":
            sticky_note = create_sticky_note(function_params["title"], function_params["description"])
            response_message = "Beleška uspešno dodata!"
            conversation.append({"role": "assistant", "content": response_message})
            citations = []

    else:
        response_message = response.choices[0].message.content
        conversation.append({"role": "assistant", "content": response_message})

    # 4. Shorten the conversation
    conversation = shorten_conversation(conversation)

    # 5. Format response
    return format_response(conversation=conversation, assistant_response=response_message, new_sticky_note=sticky_note,
                           document_keywords=document_keyword, citations=citations)


def format_response(conversation, assistant_response, new_sticky_note, document_keywords, citations):
    return {
        "conversation": conversation,
        "assistant_response": assistant_response,
        "new_sticky_note": new_sticky_note,
        "document_keywords": document_keywords,
        "citations": citations
    }


def shorten_conversation(messages):
    messages = messages[-20:]
    return [message for message in messages if message.get("role") != "system"]
