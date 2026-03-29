// hyze_safety_moderator.rs - Rust Age 13+ Safety Guard
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
    // Safe: false, Score: 40
}
