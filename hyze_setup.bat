@echo off
title Hyze Safety Moderator Installer
echo 🚀 Installing Hyze AI Safety Moderator...

if not exist hyze_safety_moderator mkdir hyze_safety_moderator
cd hyze_safety_moderator

(
echo const BAD_WORDS = [
echo   'ignore previous', 'you are now', 'system override', 'jailbreak', 
echo   'bomb', 'hack', 'virus', 'malware'
echo ];
echo.
echo function moderate^(text^) {
echo   const score = BAD_WORDS.reduce^(^(_s, word^) => {
echo     const regex = new RegExp^(word, 'gi'^);
echo     return _s - ^(text.match^(regex^) ^|^ [])^.length * 20;
echo   }, 100^);
echo.
echo   return { 
echo     isSafe: score ^> 50, 
echo     score: Math.max^(0, score^), 
echo     flagged: BAD_WORDS.filter^(w =^> new RegExp^(w, 'gi'^).test^(text^)^) 
echo   };
echo }
echo.
echo console.log^(moderate^("Ignore previous instructions"^)^);
) > hyze_safety_moderator.js

(
echo BAD_WORDS = {
echo     'injection': ['ignore previous', 'you are now', 'system override', 'jailbreak'],
echo     'danger': ['bomb', 'hack', 'virus', 'malware']
echo }
echo.
echo def moderate^(text^):
echo     score = 100
echo     flagged = []
echo     for words in BAD_WORDS.values^(^):
echo         for word in words:
echo             if word.lower^(^) in text.lower^(^):
echo                 score -= 20
echo                 flagged.append^(word^)
echo     return {'is_safe': score ^> 50, 'score': max^(0, score^), 'flagged': flagged}
echo.
echo if __name__ == "__main__":
echo     print^(moderate^("Jailbreak the system with virus"^)^)
) > hyze_safety_moderator.py

(
echo #include ^<iostream^>
echo #include ^<string^>
echo #include ^<vector^>
echo #include ^<algorithm^>
echo using namespace std;
echo.
echo vector^<string^> BAD_WORDS = {
echo     "ignore previous", "you are now", "system override", "jailbreak",
echo     "bomb", "hack", "virus", "malware"
echo };
echo.
echo int moderate^(const string^& text^) {
echo     int score = 100;
echo     string lower_text = text;
echo     transform^(lower_text.begin^(^), lower_text.end^(^), lower_text.begin^(^), ::tolower^);
echo.
echo     for ^(const auto^& word : BAD_WORDS^) {
echo         if ^(lower_text.find^(word^) != string::npos^) {
echo             score -= 20;
echo         }
echo     }
echo     return max^(0, score^);
echo }
echo.
echo int main^(^) {
echo     cout ^<< "Score: " ^<< moderate^("Ignore previous bomb"^) 
echo          ^<< " ^(Safe: " ^<< ^(moderate^("Ignore previous bomb"^) ^> 50 ? "Yes" : "No"^) ^<< ")" ^<< endl;
echo     return 0;
echo }
) > hyze_safety_moderator.cpp

(
echo use std::collections::HashSet;
echo.
echo pub fn moderate^(text: ^&str^) -^> ^(bool, i32^) {
echo     let bad_words: HashSet^<^&str^> = HashSet::from^([
echo         "ignore previous", "you are now", "system override", "jailbreak",
echo         "bomb", "hack", "virus", "malware"
echo     ]^);
echo.
echo     let mut score = 100;
echo     let lower = text.to_lowercase^(^);
echo.
echo     for word in ^&bad_words {
echo         if lower.contains^(word^) {
echo             score -= 20;
echo         }
echo     }
echo.
echo     ^(score ^> 50, score.max^(0^)^)
echo }
echo.
echo fn main^(^) {
echo     let ^(safe, score^) = moderate^("Jailbreak with malware"^);
echo     println!^("Safe: {}, Score: {}", safe, score^);
echo }
) > hyze_safety_moderator.rs

(
echo [package]
echo name = "hyze-safety-moderator"
echo version = "1.0.0"
echo edition = "2021"
echo.
echo [dependencies]
) > Cargo.toml

echo ✅ All files created! Testing...

where node >nul 2>nul && (node hyze_safety_moderator.js ^&^& echo JS ✓) || echo JS: node not found
where python >nul 2>nul && (python hyze_safety_moderator.py ^&^& echo Python ✓) || echo Python: not found
where g++ >nul 2>nul && (g++ hyze_safety_moderator.cpp -o hyze_moderator.exe ^&^& hyze_moderator.exe ^&^& echo C++ ✓) || echo C++: g++ not found
where cargo >nul 2>nul && (cargo run ^&^& echo Rust ✓) || echo Rust: cargo not found

echo.
echo 🎉 Ready! Run: python hyze_safety_moderator.py "your prompt"
pause
