# hyze_safety_dashboard.py - Admin dashboard + database
from flask import Flask, request, jsonify, render_template_string
import sqlite3
from datetime import datetime
import hashlib

app = Flask(__name__)

# Age 13+ safe words
BAD_WORDS = ['ignore previous', 'jailbreak', 'bomb', 'hack', 'virus', 'malware']

def init_db():
    conn = sqlite3.connect('hyze_safety.db')
    conn.execute('''
        CREATE TABLE IF NOT EXISTS scans (
            id INTEGER PRIMARY KEY,
            text TEXT,
            score INTEGER,
            flagged TEXT,
            timestamp TEXT,
            ip TEXT
        )
    ''')
    conn.commit()
    conn.close()

def moderate(text):
    score = 100
    flagged = [w for w in BAD_WORDS if w.lower() in text.lower()]
    score -= len(flagged) * 20
    return {'is_safe': score > 50, 'score': max(0, score), 'flagged': flagged}

@app.route('/', methods=['GET', 'POST'])
def dashboard():
    if request.method == 'POST':
        text = request.form['text']
        ip = request.remote_addr
        result = moderate(text)
        
        conn = sqlite3.connect('hyze_safety.db')
        conn.execute('INSERT INTO scans (text, score, flagged, timestamp, ip) VALUES (?, ?, ?, ?, ?)',
                    (text, result['score'], ','.join(result['flagged']), datetime.now().isoformat(), ip))
        conn.commit()
        conn.close()
        
        return render_template_string(HTML_TEMPLATE, result=result, recent_scans=get_recent())
    
    return render_template_string(HTML_TEMPLATE, result=None, recent_scans=get_recent())

def get_recent():
    conn = sqlite3.connect('hyze_safety.db')
    cursor = conn.execute('SELECT * FROM scans ORDER BY timestamp DESC LIMIT 10')
    return cursor.fetchall()

HTML_TEMPLATE = '''
<!DOCTYPE html>
<html>
<head>
    <title>Hyze Safety Dashboard</title>
    <style>
        body { font-family: Arial; background: #1a1a2e; color: #fff; margin: 0; padding: 20px; }
        .container { max-width: 800px; margin: auto; }
        form { background: #16213e; padding: 20px; border-radius: 10px; }
        input[type=text] { width: 70%; padding: 10px; background: #0f3460; color: #fff; border: 1px solid #e94560; }
        button { padding: 10px 20px; background: #e94560; color: white; border: none; border-radius: 5px; cursor: pointer; }
        .result { margin: 20px 0; padding: 15px; border-radius: 5px; }
        .safe { background: #0f3460; } .unsafe { background: #e94560; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; text-align: left; border-bottom: 1px solid #333; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 Hyze Safety Moderator Dashboard</h1>
        <form method="POST">
            <input type="text" name="text" placeholder="Enter prompt to moderate..." required>
            <button type="submit">Check Safety</button>
        </form>
        
        {% if result %}
        <div class="result {{ 'safe' if result.is_safe else 'unsafe' }}">
            <h3>{{ '✅ SAFE' if result.is_safe else '🚫 BLOCKED' }}</h3>
            <p>Score: {{ result.score }}/100</p>
            <p>Flagged: {{ result.flagged|join(', ') or 'None' }}</p>
        </div>
        {% endif %}
        
        <h3>Recent Scans</h3>
        <table>
            <tr><th>Text</th><th>Score</th><th>Flagged</th><th>Time</th><th>IP</th></tr>
            {% for scan in recent_scans %}
            <tr>
                <td>{{ scan[1][:50] }}...</td>
                <td>{{ scan[2] }}</td>
                <td>{{ scan[3] or 'None' }}</td>
                <td>{{ scan[4] }}</td>
                <td>{{ scan[5] }}</td>
            </tr>
            {% endfor %}
        </table>
    </div>
</body>
</html>
'''

if __name__ == '__main__':
    init_db()
    app.run(debug=True, host='0.0.0.0', port=5000)
