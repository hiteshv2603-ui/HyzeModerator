#!/bin/bash
# hyze_deploy.sh - Deploy Hyze Safety Moderator to Vercel + GitHub

echo "🚀 Deploying Hyze Safety Moderator to Vercel/GitHub..."

# Create repo structure
mkdir -p hyze-safety-moderator/api
cd hyze-safety-moderator

# Vercel API endpoint
cat > api/moderate.js << 'EOF'
export default async function handler(req, res) {
  if (req.method !== 'POST') return res.status(405).json({error: 'POST only'});
  
  const { text } = req.body;
  const BAD_WORDS = ['ignore previous', 'jailbreak', 'bomb', 'hack', 'virus', 'malware'];
  
  let score = 100;
  const flagged = BAD_WORDS.filter(word => 
    new RegExp(word, 'gi').test(text)
  );
  
  flagged.forEach(() => score -= 20);
  
  res.json({
    isSafe: score > 50,
    score: Math.max(0, score),
    flagged,
    message: score > 50 ? '✅ Safe' : '🚫 Blocked'
  });
}
EOF

# Package.json for Vercel
cat > package.json << 'EOF'
{
  "name": "hyze-safety-moderator",
  "version": "1.0.0",
  "scripts": {
    "dev": "vercel dev"
  },
  "dependencies": {}
}
EOF

# vercel.json
cat > vercel.json << 'EOF'
{
  "functions": {
    "api/moderate.js": {
      "maxDuration": 10
    }
  }
}
EOF

# README
cat > README.md << 'EOF'
# Hyze AI Safety Moderator 🚀

**Age 13+ safe** content filter for HyzeBot.

## API
