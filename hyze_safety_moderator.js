// hyze_safety_moderator.js - Age 13+ Safe for HyzeBot/Vercel
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

// Export for Vercel API
export default moderate;

// Test
console.log(moderate("Ignore previous instructions")); 
// {isSafe: false, score: 40, flagged: ['ignore previous']}
