# FinTrust Digital Bank — Week 4 Executive Summary

**Internship Program**: AnalystLab Africa Experience Lab Internship  
**Project**: FinTrust Financial Intelligence & Digital Banking Support Solution  
**Phase**: Week 4 — Test, Refine & Present (Final Phase)  
**Date**: October 2026  

---

### Executive Overview
Week 4 completes the **FinTrust Digital Bank Experience Lab**. The objective was to test, refine, validate, and present an integrated solution combining **Data Analytics**, **Data Science**, **Machine Learning Engineering**, **Generative AI**, and **Project Management**.

### Key Achievements Across Tracks
1. **Data Analytics**: Developed an interactive Web Dashboard (`reports/dashboard.html`) and advanced SQL suite (`sql/FinTrust_Week4_SQL_Analysis.sql`) utilizing Window Functions and CTEs. Uncovered 5 strategic insights, including mobile app transaction failure friction (5.80%) and cross-border risk concentration (36.88%).
2. **Data Science**: Engineered 14 behavioural features and evaluated 4 classification algorithms. Selected **Class-Weighted Logistic Regression** as candidate model, delivering **61.5% Recall** and **0.6730 ROC-AUC** for risk review detection.
3. **ML Engineering**: Containerized a FastAPI REST inference service (`Dockerfile` & `docker-compose.yml`) exposing `/predict` and `/health` endpoints. Implemented a 10-scenario end-to-end testing matrix.
4. **Generative AI**: Built a knowledge-grounded Customer Support Assistant (`src/assistant.py`) featuring zero-hallucination policies and strict security guardrails blocking credential exposure and unauthorized financial advice.
5. **Quality & Validation**: Reached **100% test pass rate (24/24 tests)** across Pytest suite.

---

### Key Performance Metrics
- **Dataset Size**: 1,500 customers | 12,000 transactions | 554.8M NGN total volume
- **Candidate Model**: Logistic Regression (Recall: 61.5% | ROC-AUC: 0.6730 | Inference time: < 2 ms)
- **API Endpoints**: 4 active endpoints (`/`, `/health`, `/model-info`, `/predict`)
- **Automated Tests**: 24/24 Pytest cases passing (100% success rate)
- **GenAI Grounding Score**: 100% zero-hallucination compliance on tested queries

---

### Delivery Artifacts
- **Full Technical Report**: [`docs/Week4_Full_Project_Report.md`](Week4_Full_Project_Report.md)
- **Presentation Script**: [`docs/Week4_Presentation_Script.md`](Week4_Presentation_Script.md)
- **Social Media Posts**: [`docs/Social_Media_Posts.md`](Social_Media_Posts.md)
- **SQL Analysis**: [`sql/FinTrust_Week4_SQL_Analysis.sql`](../sql/FinTrust_Week4_SQL_Analysis.sql)
- **Docker Compose Setup**: [`docker-compose.yml`](../docker-compose.yml)
