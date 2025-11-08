# About requirements.txt.bak

**Why the .bak extension?**

This file contains Python ML dependencies (TensorFlow, scikit-learn) that were used for local model training experiments. They are **NOT needed** for the deployed static site.

## Static Site (jaspermatters.com)

The live site at jaspermatters.com is:
- Pure HTML + Tailwind CSS
- No Python runtime required
- Deployed via Netlify with `npm run build:css`

## Local ML Development (Not Deployed)

The requirements.txt.bak file is kept for reference if you want to:
- Train ML models locally
- Run Jupyter notebooks
- Experiment with job market intelligence features

## To Use Locally

```bash
# Only if you need ML features locally
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt.bak
```

## DO NOT

- ❌ Rename requirements.txt.bak → requirements.txt
- ❌ Commit requirements.txt to the repo
- ❌ Try to deploy Python dependencies to Netlify

**The static site works perfectly without any Python dependencies.**
