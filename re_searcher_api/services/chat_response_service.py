"""
file: chat_response_service
description: This package contains methods that handle response coming from the AWS instance
"""

from openai import OpenAI

from consts import openai_api_key
from core.document_retrival_service import get_document_citations

client = OpenAI(
    api_key=openai_api_key
)

"""
name: generate_chat_response
params: user message body JSON
description: This method processes the response JSON from the AWS instance, extracts the relevant data and calls the OpenAI API
"""


def generate_chat_response(user_message_body):
    # 1. Extract user message
    user_message = user_message_body["conversation"][-1]["content"]
    document_name = user_message_body["active_document"]["filename"]
    conversation = user_message_body["conversation"]

    # 2. Find relevant info from documents -> insert doc data into context
    citations = get_document_citations(user_message, document_name)

    # 3. Call OpenAI API:
    #   -> Generate response with citation
    #   -> Address function: -> Add sticky note
    #                        -> List keywords for that document
    response = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=conversation,
        max_tokens=500
    )

    # 3.5 Check for function calls

    response_message = response.choices[0].message.content

    conversation.append({"role": "assistant", "content": response_message})

    # 4. Shorten the conversation
    conversation = shorten_conversation(conversation)

    # 5. Format response
    return format_response(conversation=conversation, assistant_response=response_message, new_sticky_note=None,
                           document_keywords=None, citations=citations)


"""
name: format_response
params: 
    conversation -> user data body JSON subarray containing conversation roles
    assistant_response -> OpanAI API call return value based on the  
    new_sticky_note -> returns object of type StickyNote in case user explicitly demands a sticky note to be created
    document_keywords -> returns object of type DocKeywords in case user explicitly demands keyword extraction from the repsonse
    citations -> user data body JSON subarray containing document citation done by bedrock
description: response returns a key map containing conversational elements
"""


def format_response(conversation, assistant_response, new_sticky_note, document_keywords, citations):
    return {
        "conversation": conversation,
        "assistant_response": assistant_response,
        "new_sticky_note": new_sticky_note,
        "document_keywords": document_keywords,
        "citations": citations
    }


"""
name: shorten_conversation
params: messages list
description: shortens the messages list by retaining the last 20 elements.
In case list is shorter than 20 elements, it will display the whole list.
"""


def shorten_conversation(messages):
    messages = messages[-20:]
    return [message for message in messages if message.get("role") != "system"]
