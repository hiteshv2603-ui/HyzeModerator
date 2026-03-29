// hyze_safety_moderator.cpp - C++ Age 13+ Safety Scanner
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
    // Score: 40 (Safe: No)
    return 0;
}
