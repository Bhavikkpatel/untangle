from flask import Flask
from flask import request
from flask_cors import CORS
from flask import jsonify
from transformers import PegasusForConditionalGeneration, AutoTokenizer


tokenizer = AutoTokenizer.from_pretrained("google/pegasus-xsum")
type(tokenizer)

model = PegasusForConditionalGeneration.from_pretrained("google/pegasus-xsum")

def summarizeText(text):
    tokens = tokenizer(text, truncation=True, padding="longest", return_tensors="pt")
    summary = model.generate(**tokens)
    response = tokenizer.decode(summary[0], skip_special_tokens=True)
    return response

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})
@app.route('/', methods=["GET"])
def index():
    return "hello world"

@app.route('/summarize', methods=["POST"])
def summarize():
    data = request.form['query']
    ans = summarizeText(data) 
    # print('incoming')
    # res = {"summary" : "‘Fire and Ice’ is a short poem by Robert Frost. In this poem, the poet refers to two predictions of how the world will end. Some say it will end in fire whereas others say it will end in ice. According to the poet ‘fire’ stands for desire, greed, avarice or lust. The more you try to satisfy them, the more they grow. There is no end to it."}
    return jsonify(ans)

if(__name__ == "__main__"):
    app.run(debug=True)