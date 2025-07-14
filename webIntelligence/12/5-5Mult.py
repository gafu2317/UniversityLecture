import os
import google.generativeai as genai
from openai import OpenAI

# Gemini APIキーのセットアップ
genai.configure(api_key="AIzaSyDKlxe4hT8O7e8Je_lfZk5EjbI53ZI367Q") 

# OpenAI APIキーのセットアップ（直接設定）
client = OpenAI(api_key="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") 

def get_gemini_response(prompt_text):
    """
    Gemini APIを呼び出して応答を取得する関数
    """
    try:
        model = genai.GenerativeModel('gemini-1.5-flash')
        response = model.generate_content(prompt_text)
        return response.text
    except Exception as e:
        return f"Gemini API呼び出し中にエラーが発生しました: {e}"

def get_chatgpt_response(prompt_text):
    """
    ChatGPT APIを呼び出して応答を取得する関数
    """
    try:
        response = client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "user", "content": prompt_text}
            ],
            max_tokens=500,
            temperature=0.7
        )
        return response.choices[0].message.content
    except Exception as e:
        return f"ChatGPT API呼び出し中にエラーが発生しました: {e}"

def compare_ai_responses(query):
    """
    GeminiとChatGPTの両方に質問して回答を比較する関数
    """
    print(f"質問: {query}")
    print("=" * 50)
    
    # プロンプトを作成
    prompt = f"質問: {query}について詳しく教えてください。"
    
    # Geminiに質問
    print("🤖 Geminiの回答:")
    print("-" * 30)
    gemini_response = get_gemini_response(prompt)
    print(gemini_response)
    print()
    
    # ChatGPTに質問
    print("🤖 ChatGPTの回答:")
    print("-" * 30)
    chatgpt_response = get_chatgpt_response(prompt)
    print(chatgpt_response)
    print()
    
    print("=" * 50)
    print("回答比較完了")

if __name__ == "__main__":
    # ユーザーからの入力を受け付ける
    user_query = input("質問を入力してください（例: フランスの歴史、日本の文化）: ")
    compare_ai_responses(user_query)
