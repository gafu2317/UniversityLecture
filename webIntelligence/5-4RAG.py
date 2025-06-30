import wikipedia
import os
import google.generativeai as genai

# Gemini APIキーのセットアップ
genai.configure(api_key="AIzaSyDKlxe4hT8O7e8Je_lfZk5EjbI53ZI367Q") 

def get_gemini_response(prompt_text):
    """
    Gemini APIを呼び出して応答を取得する関数
    """
    try:
        # ここでGeminiのGenerativeModelを使ってAPIを呼び出します。
        model = genai.GenerativeModel('gemini-2.5-flash') # 使用するモデルを指定
        response = model.generate_content(prompt_text)
        return response.text

    except Exception as e:
        return f"Gemini API呼び出し中にエラーが発生しました: {e}\nAPIキーが正しく設定されているか確認してください。"

def rag_example(query):
    """
    RAGを利用して質問に回答する関数
    """
    wikipedia.set_lang("ja") # 日本語Wikipediaから取得

    try:
        # 1. Wikipediaから情報を取得
        print(f"外部情報取得中: '{query}'...")
        summary = wikipedia.summary(query, sentences=2) # 質問に関する要約文を2文取得
        print("取得した外部情報:\n", summary, "\n")

        # 2. 取得した情報と質問を組み合わせてプロンプトを作成
        prompt = f"以下の情報に基づいて質問に回答してください。\n\n情報: {summary}\n\n質問: {query}の現在の人口は何人ですか？（情報にない場合は一般的な知識から答えてください）"

        # 3. Geminiにプロンプトを渡して回答を取得
        print("Geminiに回答を要求中...")
        gemini_response = get_gemini_response(prompt)
        print("\nGeminiの回答:")
        print(gemini_response)

    except wikipedia.exceptions.PageError:
        print(f"Wikipediaで'{query}'に関する情報が見つかりませんでした。")
        print("外部情報なしで質問に回答を試みます。")
        prompt = f"質問: {query}の現在の人口は何人ですか？"
        gemini_response = get_gemini_response(prompt)
        print("\nGeminiの回答:")
        print(gemini_response)
    except wikipedia.exceptions.DisambiguationError as e:
        print(f"'{query}'には複数の候補があります。より具体的なクエリを試してください。候補: {e.options}")
    except Exception as e:
        print(f"エラーが発生しました: {e}")

if __name__ == "__main__":
    # ユーザーからの入力を受け付ける
    user_query = input("人口を聞きたい国を入力してください、外部情報を参照して回答します（例: フランス、日本）: ")
    rag_example(user_query)