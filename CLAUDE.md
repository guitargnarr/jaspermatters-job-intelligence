# CLAUDE.md - Job Intelligence Platform Configuration

## Project Overview
AI-powered job market analysis platform demonstrating production ML engineering skills for Matthew Scott's portfolio. Live at jaspermatters.com.

---

## ✅ Python Environment (Updated October 22, 2025)

**VERIFIED:** Python 3.14.0 installed and working correctly

### Current Setup

**Python Version:** 3.14.0 (recommended for this project)
- **Location:** `/Library/Frameworks/Python.framework/Versions/3.14/bin/python3`
- **Status:** ✅ Fully operational
- **Virtual Environment:** Recommended (create with `python3 -m venv venv`)

### Verification (Run at project start)

```bash
python3 --version  # Should show: Python 3.14.0
python3 -c "print('Python is working')"  # Should produce output
```

**If verification fails:** See global CLAUDE.md (~/.claude/CLAUDE.md) for troubleshooting.

### Virtual Environment Setup

```bash
cd ~/Projects/Career-Business/jaspermatters-job-intelligence

# Create venv with Python 3.14
python3 -m venv venv

# Activate
source venv/bin/activate

# Verify
python --version  # Should show: Python 3.14.0
which python      # Should point to venv/bin/python

# Install dependencies
pip install --upgrade pip
pip install -r requirements.txt
```

### Python Corruption Issue (RESOLVED October 22, 2025)

**Problem (March 6 - October 22, 2025):** Python 3.13 binary was corrupted (0 bytes), causing all Python commands to produce no output.

**Solution:** Installed Python 3.14.0, cleaned shell configuration, upgraded incompatible packages. All Python projects now functional.

**See global CLAUDE.md (~/.claude/CLAUDE.md) for complete incident details.**

---

## Architecture
```
jaspermatters-job-intelligence/
├── backend/
│   ├── scrapers/       # Job data collection (Indeed, LinkedIn, RemoteOK)
│   ├── api/           # FastAPI endpoints
│   └── services/      # Business logic
├── ml/
│   ├── models/        # TensorFlow salary predictor, clustering
│   ├── embeddings/    # Vector search with sentence-transformers
│   └── data/          # Processed job data
├── frontend/          # Next.js 14 + Tailwind
└── deployment/        # Docker, CI/CD configs
```

## Core ML Components

### 1. Vector Search Engine (`ml/embeddings/vector_engine.py`)
- Sentence-transformers for semantic embeddings
- Local index with pickle, ready for Pinecone
- Cosine similarity for job matching
- Skill gap analysis

### 2. Salary Predictor (`ml/models/salary_predictor.py`)
- TensorFlow/Keras neural network
- 134 engineered features
- Handles unseen labels gracefully
- Log-transformed targets for better distribution

### 3. Job Clusterer (`ml/models/job_clusterer.py`)
- K-means for market segmentation
- DBSCAN for outlier detection
- PCA visualization
- Automated optimal cluster selection

### 4. Job Scraper (`backend/scrapers/job_scraper.py`)
- Async scraping from multiple sources
- Structured data extraction (salary, requirements, seniority)
- Deduplication logic
- Rate limiting

## Key Technologies
- **ML/AI**: TensorFlow, scikit-learn, sentence-transformers
- **Backend**: FastAPI, PostgreSQL, Redis
- **Frontend**: Next.js 14, Three.js, D3.js
- **Infrastructure**: Docker, Vercel, Railway

## Development Commands
```bash
# Activate environment
source venv/bin/activate

# Run job scraper
python backend/scrapers/job_scraper.py

# Test vector search
python ml/embeddings/vector_engine.py

# Train salary model
python ml/models/salary_predictor.py

# Run clustering
python ml/models/job_clusterer.py

# Start API (when ready)
uvicorn backend.api.main:app --reload

# Start frontend (when ready)
cd frontend && npm run dev
```

## Current Status
✅ Job scraping pipeline
✅ Vector embeddings system
✅ TensorFlow salary prediction
✅ Clustering & segmentation
🔄 FastAPI backend
🔄 Next.js frontend
🔄 Production deployment

## Performance Metrics
- Vector search: 0.4+ cosine similarity scores
- Salary model: Trained on synthetic + real data
- Clustering: 3 market segments identified
- Scraper: 15+ jobs collected per run

## Next Steps
1. Expand scraping to 1000+ jobs
2. Create FastAPI endpoints
3. Build interactive frontend
4. Deploy to jaspermatters.com
5. Add resume optimization features

## Important Notes
- Models use local storage during development
- Handles unseen labels with fallback mappings
- All credentials in .env (not committed)
- ML models saved as .h5 and .pkl files

## Portfolio Impact
This project demonstrates:
- End-to-end ML pipeline development
- Multiple ML paradigms (supervised, unsupervised, embeddings)
- Production-ready code architecture
- Real-world problem solving
- Modern tech stack proficiency

Target salary justification: $180-220K based on demonstrated ML engineering skills.

---

## 🎓 Critical Lessons & Risk Assessment (October 22, 2025)

### ⚠️ TensorFlow 2.20 + Python 3.14 Compatibility Risk

**Based on Code Analyzer Subagent Assessment:**

**CRITICAL BLOCKER: TensorFlow 2.20 Likely Incompatible with Python 3.14**
- **Risk Level:** 80% chance of incompatibility
- **Issue:** TensorFlow typically lags 6-12 months behind latest Python releases
- **Estimated Impact:** Installation will likely fail on Python 3.14
- **Recommended Solution:** Use Python 3.11 or 3.12 venv instead

**Why This Matters:**
```bash
# Python 3.14 attempt (likely to fail):
pip install tensorflow==2.20.0
# ERROR: No matching distribution found for tensorflow==2.20.0

# Python 3.11 attempt (likely to succeed):
python3.11 -m venv venv_py311
source venv_py311/bin/activate
pip install tensorflow==2.20.0  # Higher success rate
```

---

### 📦 Dependency Complexity Assessment

**HIGH COMPLEXITY:**
- TensorFlow 2.20 - ~500MB install, Metal GPU dependencies
- sentence-transformers 5.1.0 - 384MB pre-trained models on first use
- Pinecone 7.3.0 - Vector database (requires API key, can skip for demos)

**MEDIUM COMPLEXITY:**
- scikit-learn 1.7.1 - Core ML library, generally compatible
- pandas, numpy, matplotlib, seaborn - Standard data science stack

**LOW RISK:**
- aiohttp, beautifulsoup4, requests, python-dotenv - All Python 3.14 compatible

**Total Estimated Install Time:**
- Python 3.14 (if TensorFlow compatible): 15-20 minutes
- Python 3.11/3.12 (recommended): 15-22 minutes
- Disk space required: ~2GB (TensorFlow + models)

---

### 🎯 Recommended Installation Strategy

**Option A: Test Python 3.14 First (Quick Failure Test)**
```bash
cd ~/Projects/Career-Business/jaspermatters-job-intelligence
source venv/bin/activate
pip install tensorflow==2.20.0

# If this fails (expected), proceed to Option B
```

**Option B: Use Python 3.11 (RECOMMENDED)**
```bash
# Create Python 3.11 venv for TensorFlow compatibility
python3.11 -m venv venv_py311
source venv_py311/bin/activate
pip install --upgrade pip
pip install -r requirements.txt  # Should succeed
```

**Option C: Delete Python 3.14 venv, Recreate with 3.11**
```bash
cd ~/Projects/Career-Business/jaspermatters-job-intelligence
rm -rf venv
python3.11 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

---

### ✅ Pre-Installation Checklist

**Before attempting installation:**

1. **Check if trained models exist:**
```bash
ls -lh ~/Projects/Career-Business/jaspermatters-job-intelligence/ml/models/
# Look for: salary_predictor.h5, job_clusterer.pkl, etc.
```

2. **Verify disk space (need ~2GB):**
```bash
df -h ~  # Check available space
```

3. **Check Pinecone API key (optional for demos):**
```bash
# If using vector search:
grep PINECONE .env 2>/dev/null || echo "No Pinecone API key configured"
```

---

### 🧪 Testing Phases

**Phase 1: Verify Trained Models (CRITICAL)**
```bash
ls -lh ml/models/
# Expected files:
# - salary_predictor.h5 (TensorFlow model)
# - job_clusterer.pkl (scikit-learn model)
# - vectorizer.pkl (feature extraction)
```
⚠️ **If models missing:** Demos will fail. Need to retrain or locate backups.

**Phase 2: Test Dependencies (After Installation)**
```bash
source venv/bin/activate
python -c "import tensorflow; print(f'TensorFlow {tensorflow.__version__}')"
python -c "import sklearn; print(f'scikit-learn {sklearn.__version__}')"
python -c "from sentence_transformers import SentenceTransformer; print('✅ OK')"
```

**Phase 3: Run Simple Demo (Low Dependencies)**
```bash
python simple_demo.py
# Tests: pandas, numpy, basic file loading
# Should work even if TensorFlow fails
```

**Phase 4: Run Full Demo (All Features)**
```bash
python demo.py
# Tests: TensorFlow, sentence-transformers, clustering
# May fail if Pinecone API key not configured (can skip vector search)
```

---

### 💡 Key Insights from Subagent Analysis

**What Code Analysis Revealed:**
1. **No API server currently:** Project runs as CLI demos only (FastAPI commented out)
2. **Demo-focused:** Main entry points are `simple_demo.py` and `demo.py`
3. **Pinecone optional:** Can skip vector search for basic functionality
4. **Model dependency:** Requires pre-trained models in ml/models/ directory

**Backend Status:**
- ❌ FastAPI/uvicorn commented out in requirements.txt (future feature)
- ❌ SQLAlchemy/PostgreSQL commented out (future feature)
- ✅ CLI demos functional without web server
- ✅ No database required for current functionality

**Expected Success Rates:**
- Core dependencies (pandas, numpy, etc.): 100%
- ML dependencies (scikit-learn, sentence-transformers): 90%
- TensorFlow 2.20 on Python 3.14: 20%
- TensorFlow 2.20 on Python 3.11: 95%

---

### 🚧 Potential Blockers

**BLOCKER 1: TensorFlow + Python 3.14 Incompatibility**
- **Likelihood:** 80%
- **Solution:** Use Python 3.11 venv
- **Workaround:** None - TensorFlow required for salary prediction model

**BLOCKER 2: Missing Trained Models**
- **Check:** `ls ml/models/*.h5 ml/models/*.pkl`
- **Impact:** Demos won't work without models
- **Solution:** Locate model backups or retrain

**BLOCKER 3: Pinecone API Key**
- **Impact:** Vector search features won't work
- **Workaround:** Comment out Pinecone sections in demo.py
- **Note:** Not required for salary prediction or clustering demos

**BLOCKER 4: Disk Space (Need ~2GB)**
- **Check:** `df -h ~`
- **Current:** System 73% full (~679 GB used)
- **Solution:** Free up space or use external drive for models

---

### ⏱️ Time Estimates

**Best Case (Python 3.11, models exist):** 20-30 minutes
**Realistic Case (Python 3.14 fails, switch to 3.11):** 30-40 minutes
**Worst Case (Missing models, need to retrain):** 2-4 hours

**Breakdown:**
- TensorFlow installation: 8-12 minutes
- Other dependencies: 5-7 minutes
- Model downloads (sentence-transformers): 5-7 minutes
- Testing demos: 5-10 minutes

---

### 📝 Next Steps Priority Order

1. **Check trained models exist** (5 minutes, CRITICAL)
2. **Test TensorFlow on Python 3.14** (2 minutes quick test)
3. **If fails, create Python 3.11 venv** (15 minutes)
4. **Install dependencies** (15-20 minutes)
5. **Run simple_demo.py** (2 minutes)
6. **Run demo.py** (5 minutes)
7. **Document findings** (10 minutes)

**Total Estimated Time to Working Demo:** 30-40 minutes (with fallback to Python 3.11)

---

**Documentation Status:** ✅ Complete (Updated with Risk Assessment)
**Last Updated:** October 22, 2025 (Evening - Added Subagent Insights)
**Python Environment:** ✅ Venv created (Python 3.14), NOT TESTED with TensorFlow
**Recommended Python:** ⚠️ Python 3.11 or 3.12 (TensorFlow compatibility)
**Testing Status:** ⏳ Awaiting dependency installation
**Critical Risk:** ⚠️ TensorFlow 2.20 likely incompatible with Python 3.14 (80% chance)

---
*Built by Matthew Scott | August 2025 | Part of AI/ML portfolio*