from openai import OpenAI

from consts import openai_api_key

client = OpenAI(
    api_key=openai_api_key
)

def generate_chat_response(user_message_body):
    # 1. Extract user message
    user_message = user_message_body["conversation"][-1]["content"]
    document = user_message_body["active_document"]
    conversation = user_message_body["conversation"]

    # 2. Find relevant info from documents -> insert doc data into context


    # 3. Call OpenAI API:
    #   -> Generate response with citation
    #   -> Address function: -> Add sticky note
    #                        -> List keywords for that document
    response = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=conversation
    )

    response_message = response.choices[0].message.content

    conversation.append({"role": "assistant", "content": response_message})

    # 4. Format response
    return format_response(conversation=conversation, assistant_response=response_message, new_sticky_note=None, document_keywords=None)



def format_response(conversation, assistant_response, new_sticky_note, document_keywords):
    return {
        "conversation": conversation,
        "assistant_response": assistant_response,
        "new_sticky_note": new_sticky_note,
        "document_keywords": document_keywords
    }