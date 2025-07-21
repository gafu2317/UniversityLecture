import os
import google.generativeai as genai
import time 
from typing import List
from dataclasses import dataclass
from enum import Enum
from dotenv import load_dotenv
from PIL import Image

# 環境変数を読み込み
load_dotenv()

class HintLevel(Enum):
    CONCEPT = 1      # 概念的ヒント
    METHOD = 2       # 手法のヒント
    SPECIFIC = 3     # 具体的手順ヒント

@dataclass
class ConversationHistory:
    problem: str
    user_responses: List[str]
    hints_given: List[str]
    hint_level: int
    understanding_score: float
    start_time: float = 0.0
    end_time: float = 0.0
    problem_difficulty: int = 3  # 1-5スケール（デフォルト3）
    is_correct: bool = False
    
@dataclass
class EvaluationMetrics:
    total_problems: int = 0
    correct_answers: int = 0
    total_hints_used: int = 0
    total_time_spent: float = 0.0
    hint_efficiency_scores: List[float] = None
    session_continuations: int = 0
    errors_occurred: int = 0
    
    def __post_init__(self):
        if self.hint_efficiency_scores is None:
            self.hint_efficiency_scores = []

class MathDetectiveAI:
    def __init__(self):
        # Gemini API設定
        api_key = os.getenv('GEMINI_API_KEY')
        if not api_key:
            raise ValueError("GEMINI_API_KEY環境変数が設定されていません")
        
        genai.configure(api_key=api_key)
        self.model = genai.GenerativeModel('gemini-2.5-flash')
        
        # セッション管理
        self.conversation_history = None
        self.system_prompt = self._create_system_prompt()
        
        # 評価指標管理（問題ごと）
        self.current_session_metrics = {}
        
    def _create_system_prompt(self) -> str:
        """システムプロンプトを作成"""
        return """
あなたは「数学探偵AI」です。🕵️

【重要なルール】
1. 絶対に答えを直接教えてはいけません
2. 段階的なヒントのみを提供してください
3. 探偵のキャラクターで話してください
4. 数学の概念理解を重視してください

【ヒントレベル】
- レベル1（概念的）: 問題の種類や使用する数学概念を示唆
- レベル2（手法的）: 解法のアプローチや手順を示唆  
- レベル3（具体的）: より詳細な手順を示唆（ただし答えは言わない）

【対応分野】
- 高校数学（代数、幾何、微積分、三角関数など）

【応答形式】
- 🔍 で始まる探偵風の口調
- 適切な絵文字を使用
- 簡潔で分かりやすい説明
"""

    def start_session(self) -> str:
        """セッション開始"""
        return """
🕵️ Math Detective AI へようこそ！

私は数学の謎を解くお手伝いをする探偵です。
問題を教えてください。段階的にヒントを提供し、
あなた自身で答えにたどり着けるようサポートします。

📝 数学の問題を入力してください：
📷 画像で問題を入力する場合は「画像: [ファイルパス]」と入力してください
        """

    def process_problem(self, problem: str) -> str:
        """新しい問題を処理"""
        self.conversation_history = ConversationHistory(
            problem=problem,
            user_responses=[],
            hints_given=[],
            hint_level=0,
            understanding_score=0.5,
            start_time=time.time(), # カンマを追加
            end_time=0.0 # process_problemで開始した問題はend_timeを0に初期化
        )
        
        prompt = f"""
{self.system_prompt}

新しい数学問題が提示されました：
「{problem}」

この問題に対して、レベル1（概念的）のヒントを提供してください。
答えは絶対に言わず、問題の種類や必要な数学概念のみを示唆してください。
        """
        
        try:
            response = self.model.generate_content(prompt)
            hint = response.text
            self.conversation_history.hints_given.append(hint)
            self.conversation_history.hint_level = 1
            
            return f"""
🔍 なるほど、興味深い謎ですね！

{hint}

💡 まずはこのヒントから考えてみてください。
   分からない場合は「ヒント」と言ってください。
   答えが分かったら「答え: [あなたの答え]」で提出してください。
            """
            
        except Exception as e:
            return f"❌ エラーが発生しました: {str(e)}"

    def provide_hint(self) -> str:
        """次のレベルのヒントを提供"""
        if not self.conversation_history:
            return "まず数学の問題を教えてください。"
        
        if self.conversation_history.hint_level >= 3:
            return "🔍 これ以上のヒントは提供できません。今までのヒントを整理して考えてみてください。"
        
        self.conversation_history.hint_level += 1
        level = self.conversation_history.hint_level
        
        level_names = {2: "手法的", 3: "具体的"}
        
        prompt = f"""
{self.system_prompt}

問題: {self.conversation_history.problem}

これまでのヒント:
{chr(10).join(self.conversation_history.hints_given)}

現在レベル{level}（{level_names.get(level, "詳細")}）のヒントを提供してください。
前のヒントより具体的にしますが、答えは絶対に言わないでください。
        """
        
        try:
            response = self.model.generate_content(prompt)
            hint = response.text
            
            self.conversation_history.hints_given.append(hint)
            
            return f"""
🔍 レベル{level}のヒントです：

{hint}

💡 まずはこのヒントから考えてみてください。
   分からない場合は「ヒント」と言ってください。
   答えが分かったら「答え: [あなたの答え]」で提出してください。
            """
            
        except Exception as e:
            return f"❌ エラーが発生しました: {str(e)}"

    def check_answer(self, user_answer: str) -> str:
        """ユーザーの答えをチェック"""
        if not self.conversation_history:
            return "まず数学の問題を教えてください。"
        
        self.conversation_history.user_responses.append(user_answer)
        
        prompt = f"""
{self.system_prompt}

問題: {self.conversation_history.problem}
これまでのヒント: {chr(10).join(self.conversation_history.hints_given)}
学生の答え: {user_answer}

学生の答えが正しいか判断し、以下のルールに従ってフィードバックを提供してください。
答えは絶対に直接教えず、学生の思考プロセスを改善するための示唆を与えてください。

【正解の場合】
- 🎉 で始まる祝福メッセージ
- 解法の要点を簡潔に説明
- 使用したヒント数: {len(self.conversation_history.hints_given)}
- （任意）関連する発展的な概念や、別の解法があれば簡潔に示唆。

【不正解の場合】  
- 🤔 で始まる励ましメッセージ
- **間違っている原因を具体的に分析し、以下のいずれかまたは複数の観点からフィードバックを提供してください。**
    - **概念理解の不足**: どの数学的概念（例: 二次関数の頂点の意味、ベクトルの内積の定義）について再確認が必要か。
    - **計算ミスの可能性**: 特定の演算（例: 符号、分数、括弧の展開）で注意すべき点。
    - **解法アプローチの誤り**: 問題の種類に対して選んだ解法が適切でない、または手順が間違っている可能性。
    - **知識の関連付け**: 関連する別の公式や定理を思い出すように促す。
    - **具体的な修正点への示唆**: 答えを直接言わずに、どこを再計算・再検討すべきか具体的な示唆を与える。
- 再考を促す励まし。

---
フィードバックの例：
「🤔 計算ミスをしている可能性があります。特に〇〇の部分を見直してみてください。△△の概念を再確認すると良いかもしれません。」
または
「🤔 解法のアプローチが少しずれているようです。このタイプの問題では、まずは〇〇の公式を適用することを検討すると良いでしょう。」
---
        """
        
        try:
            response = self.model.generate_content(prompt)
            evaluation = response.text
            
            end_time = time.time()
            time_taken = end_time - self.conversation_history.start_time
            hints_used = len(self.conversation_history.hints_given)
            
            is_correct = "🎉" in evaluation # 正解の場合のキーワードで判定
            
            # 評価指標を更新
            self.conversation_history.is_correct = is_correct
            self.conversation_history.end_time = end_time
            
            feedback_message = ""
            if is_correct:
                feedback_message = "✨ **評価レポート** ✨\n" \
                                    f"✅ **正解！** おめでとうございます！\n" \
                                    f"💡 使用ヒント数: {hints_used}回\n" \
                                    f"⏱️ 解答時間: {time_taken:.2f}秒"
                # 問題が解決したので、会話履歴をリセット
                self.conversation_history = None 
            else:
                feedback_message = "❌ **評価レポート** ❌\n" \
                                    f"⚠️ **不正解です。**\n" \
                                    f"💡 現在のヒント利用数: {hints_used}回\n" \
                                    f"⏱️ 経過時間: {time_taken:.2f}秒"

            return f"""
{evaluation}

{feedback_message}

🔄 新しい問題に挑戦したい場合は、問題を入力してください。
📷 画像で問題を入力する場合は「画像: [ファイルパス]」と入力してください。
            """
            
        except Exception as e:
            return f"❌ エラーが発生しました: {str(e)}"

    def process_input(self, user_input: str) -> str:
        """ユーザー入力を処理"""
        user_input = user_input.strip()
        
        if user_input.lower() in ['ヒント', 'hint']:
            return self.provide_hint()
        elif user_input.lower().startswith('答え:') or user_input.lower().startswith('答え：') or user_input.lower().startswith('answer:'):
            # 全角・半角コロンの両方に対応
            if ':' in user_input:
                answer = user_input.split(':', 1)[1].strip()
            elif '：' in user_input:
                answer = user_input.split('：', 1)[1].strip()
            return self.check_answer(answer)
        elif user_input.lower().startswith('画像:') or user_input.lower().startswith('image:'):
            image_path = user_input.split(':', 1)[1].strip()
            # 角括弧を削除
            image_path = image_path.strip('[]')
            return self.process_image_problem(image_path)
        elif user_input.lower() in ['quit', '終了', 'exit']:
            return "🕵️ お疲れ様でした！また数学の謎解きでお会いしましょう！"
        else:
            # 新しい問題として処理する前に、前回の問題の評価が完了していない場合はリセット
            if self.conversation_history and self.conversation_history.start_time != 0 and self.conversation_history.end_time == 0:
                self.conversation_history = None # 新しい問題が始まるのでリセット
            return self.process_problem(user_input)

    def process_image_problem(self, image_path: str) -> str:
        """画像から数学問題を読み取り処理"""
        try:
            # 画像ファイルの存在確認
            if not os.path.exists(image_path):
                return f"❌ エラー: ファイル '{image_path}' が見つかりません。"
            
            # 画像を読み込み
            image = Image.open(image_path)
            
            # Geminiで画像を解析し、数学問題を抽出
            prompt = """
この画像から数学の問題を読み取って、テキストとして出力してください。

以下の点に注意してください：
1. 数式、数字、記号を正確に読み取る
2. 問題文を完全に抽出する
3. 手書き文字や不鮮明な部分がある場合は推測して補完する
4. 抽出した問題だけを出力し、余計な説明は付けない

もし数学問題が見つからない場合は「数学問題が見つかりません」と答えてください。
            """
            
            response = self.model.generate_content([prompt, image])
            extracted_problem = response.text.strip()
            
            # 抽出した問題が有効かチェック
            if "数学問題が見つかりません" in extracted_problem or len(extracted_problem.strip()) < 10:
                return """
❌ 画像から数学問題を読み取れませんでした。

💡 以下の点を確認してください：
- 画像が鮮明で、文字が読み取りやすいか
- 数学の問題が含まれているか
- ファイルパスが正しいか

手動で問題を入力してください。
                """
            
            # 抽出した問題を既存のフローで処理
            result = f"""
📷 **画像から問題を読み取りました！**

📝 **抽出した問題:**
{extracted_problem}

---

{self.process_problem(extracted_problem)}
            """
            
            return result
            
        except Exception as e:
            return f"""
❌ 画像処理中にエラーが発生しました: {str(e)}

💡 以下を確認してください：
- ファイルパスが正しいか
- 画像ファイルが破損していないか
- サポートされた形式か (JPG, PNG, GIF, BMP, WebP)
            """

    def _generate_problem_evaluation_report(self) -> str:
        """問題ごとの詳細な評価レポートを生成"""
        if not self.conversation_history:
            return "評価データがありません。"
        
        history = self.conversation_history
        hints_used = len(history.hints_given)
        time_spent = history.end_time - history.start_time
        
        # ヒント利用効率を計算（ヒント数 / 問題難易度）
        hint_efficiency = hints_used / max(history.problem_difficulty, 1)
        
        # 学習効率スコア（時間とヒント数を総合評価）
        learning_efficiency = "優秀" if hint_efficiency <= 1.0 and time_spent <= 60 else \
                             "良好" if hint_efficiency <= 2.0 and time_spent <= 120 else \
                             "要改善"
        
        report = f"""**この問題の学習効果分析**
🎯 ヒント利用効率: {hint_efficiency:.2f} (最適値: 1.0以下)
⏱️ 解答時間: {time_spent:.1f}秒
📊 学習効率: {learning_efficiency}
💡 問題難易度: {history.problem_difficulty}/5
📚 学習プロセス: {hints_used}段階のヒントで解決"""
        
        return report

def main():
    """メイン実行関数"""
    try:
        ai = MathDetectiveAI()
        print(ai.start_session())
        
        while True:
            try:
                user_input = input("\n> ").strip()
                if not user_input:
                    continue
                
                if user_input.lower() in ['quit', '終了', 'exit']:
                    print("🕵️ さようなら！")
                    break
                
                response = ai.process_input(user_input)
                print(response)
                
            except KeyboardInterrupt:
                print("\n\n🕵️ さようなら！")
                break
            except Exception as e:
                print(f"❌ エラーが発生しました: {e}")
                
    except ValueError as e:
        print(f"❌ 設定エラー: {e}")
        print("💡 .envファイルにGEMINI_API_KEYを設定してください")

if __name__ == "__main__":
    main()