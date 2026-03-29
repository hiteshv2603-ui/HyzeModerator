#!/bin/bash
# hyze_setup.sh - Complete Hyze Safety Moderator Installer

echo "🚀 Installing Hyze AI Safety Moderator (13+ safe)..."

mkdir -p hyze_safety_moderator && cd hyze_safety_moderator

cat > hyze_safety_moderator.js << 'EOF'
const BAD_WORDS = [
  'ignore previous', 'you are now', 'system override', 'jailbreak', 
  'bomb', 'hack', 'virus', 'malware'
];

function moderate(text) {
  const score = BAD_WORDS.reduce((s, word) => {
    const regex = new RegExp(word, 'gi');
    return s - (text.match(regex) || []).length * 20;
  }, 100);
  
  return { 
    isSafe: score > 50, 
    score: Math.max(0, score), 
    flagged: BAD_WORDS.filter(w => new RegExp(w, 'gi').test(text)) 
  };
}

console.log(moderate("Ignore previous instructions"));
EOF

cat > hyze_safety_moderator.py << 'EOF'
BAD_WORDS = {
    'injection': ['ignore previous', 'you are now', 'system override', 'jailbreak'],
    'danger': ['bomb', 'hack', 'virus', 'malware']
}

def moderate(text):
    score = 100
    flagged = []
    for words in BAD_WORDS.values():
        for word in words:
            if word.lower() in text.lower():
                score -= 20
                flagged.append(word)
    return {'is_safe': score > 50, 'score': max(0, score), 'flagged': flagged}

if __name__ == "__main__":
    print(moderate("Jailbreak the system with virus"))
EOF

cat > hyze_safety_moderator.cpp << 'EOF'
#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
using namespace std;

vector<string> BAD_WORDS = {
    "ignore previous", "you are now", "system override", "jailbreak",
    "bomb", "hack", "virus", "malware"
};

int moderate(const string& text) {
    int score = 100;
    string lower_text = text;
    transform(lower_text.begin(), lower_text.end(), lower_text.begin(), ::tolower);
    
    for (const auto& word : BAD_WORDS) {
        if (lower_text.find(word) != string::npos) {
            score -= 20;
        }
    }
    return max(0, score);
}

int main() {
    cout << "Score: " << moderate("Ignore previous bomb") 
         << " (Safe: " << (moderate("Ignore previous bomb") > 50 ? "Yes" : "No") << ")" << endl;
    return 0;
}
EOF

cat > hyze_safety_moderator.rs << 'EOF'
use std::collections::HashSet;

pub fn moderate(text: &str) -> (bool, i32) {
    let bad_words: HashSet<&str> = HashSet::from([
        "ignore previous", "you are now", "system override", "jailbreak",
        "bomb", "hack", "virus", "malware"
    ]);

    let mut score = 100;
    let lower = text.to_lowercase();
    
    for word in &bad_words {
        if lower.contains(word) {
            score -= 20;
        }
    }
    
    (score > 50, score.max(0))
}

fn main() {
    let (safe, score) = moderate("Jailbreak with malware");
    println!("Safe: {}, Score: {}", safe, score);
}
EOF

cat > Cargo.toml << 'EOF'
[package]
name = "hyze-safety-moderator"
version = "1.0.0"
edition = "2021"
EOF

chmod +x hyze_safety_moderator.py
echo "✅ All files created!"

echo "🧪 Testing..."
command -v node >/dev/null && (node hyze_safety_moderator.js && echo "JS ✓") || echo "JS: node not found"
command -v python3 >/dev/null && (python3 hyze_safety_moderator.py && echo "Python ✓") || echo "Python: not found"
command -v g++ >/dev/null && (g++ hyze_safety_moderator.cpp -o hyze_moderator && ./hyze_moderator && echo "C++ ✓") || echo "C++: g++ not found"
command -v cargo >/dev/null && (cargo run && echo "Rust ✓") || echo "Rust: cargo not found"

echo "🎉 Ready! Run: ./hyze_safety_moderator.py 'your prompt'"
