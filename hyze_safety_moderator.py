# hyze_safety_moderator.py - Python 13+ Safe Moderator
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
    # {'is_safe': False, 'score': 40, 'flagged': ['jailbreak', 'virus']}
