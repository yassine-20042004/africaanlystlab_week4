# FinTrust Digital Bank — Financial Intelligence & ML Support Solution

[![Python 3.10+](https://img.shields.io/badge/Python-3.10%2B-blue.svg)](https://www.python.org/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100%2B-green.svg)](https://fastapi.tiangolo.com/)
[![Docker](https://img.shields.io/badge/Docker-Containerized-blue.svg)](Dockerfile)
[![Tests](https://img.shields.io/badge/Pytest-24%20Passed%20(100%25)-success.svg)](tests/)
[![Phase](https://img.shields.io/badge/Phase-Week%204%20Test%2C%20Refine%20%26%20Present-brightgreen.svg)]()

Production-grade Machine Learning pipeline, predictive risk models, REST API inference service, grounded GenAI Customer Support Assistant, and Data Analytics solution for **FinTrust Digital Bank** (AnalystLab Africa Internship Project — Week 4 Final Submission).

---

## 🚀 Week 4 Final Deliverables & Track Highlights

1. **Data Analytics Track**: Advanced SQL analysis suite ([`sql/FinTrust_Week4_SQL_Analysis.sql`](sql/FinTrust_Week4_SQL_Analysis.sql)) with Window Functions and CTEs. Interactive Web Dashboard ([`reports/dashboard.html`](reports/dashboard.html)) communicating 5 business insights and validated analytical findings.
2. **Data Science Track**: 14-feature behavioural engineering pipeline. Trained and evaluated 4 classification algorithms. Selected **Class-Weighted Logistic Regression** as candidate model (**61.5% Recall**, **0.6730 ROC-AUC**).
3. **Machine Learning Engineering Track**: FastAPI REST API service (`src/api.py`) exposing `/health`, `/model-info`, and `/predict` endpoints. Full Docker containerization via [`Dockerfile`](Dockerfile) and [`docker-compose.yml`](docker-compose.yml).
4. **Generative AI Track**: Knowledge-grounded Customer Support Assistant (`src/assistant.py`) with zero-hallucination policy compliance and safety guardrails blocking credential exposure and unauthorized financial advice.
5. **Quality Assurance**: Automated Pytest suite with **24 unit and integration tests passing (100% success rate)** across data validation, pipeline reproducibility, REST API schemas, and assistant guardrails.
6. **Project Management & Presentation**: Complete Week 4 Final Project Report ([`docs/Week4_Full_Project_Report.md`](docs/Week4_Full_Project_Report.md)), Executive Summary ([`docs/Week4_Executive_Summary.md`](docs/Week4_Executive_Summary.md)), 5-10 minute Video Presentation Script ([`docs/Week4_Presentation_Script.md`](docs/Week4_Presentation_Script.md)), and Social Media Posts ([`docs/Social_Media_Posts.md`](docs/Social_Media_Posts.md)).

---

## 📁 Repository Directory Structure

```
fintrust-digital-bank-week4/
│
├── data/
│   ├── raw/                       # Raw customer & transaction CSV files
│   └── processed/                 # Cleaned feature matrix & model comparison CSVs
│
├── docs/                          # Week 4 Documentation & Presentation Deliverables
│   ├── Week4_Full_Project_Report.md
│   ├── Week4_Executive_Summary.md
│   ├── Week4_Presentation_Script.md
│   ├── Social_Media_Posts.md
│   └── Data_Quality_Report.md
│
├── models/                        # Serialized candidate risk model
│   └── candidate_model.pkl
│
├── reports/                       # Visualizations & Interactive Dashboards
│   ├── figures/                   # Model comparison, confusion matrix & feature importance
│   └── dashboard.html             # Interactive HTML Executive Web Dashboard
│
├── sql/                           # Production SQL Analysis Suite
│   ├── FinTrust_Week4_SQL_Analysis.sql
│   └── FinTrust_Week2_SQL_Analysis.sql
│
├── src/                           # Production Modular Engine
│   ├── __init__.py
│   ├── api.py                     # FastAPI REST API Service
│   ├── assistant.py               # Grounded GenAI Customer Support Assistant
│   ├── models.py                  # Multi-model evaluation & serialization
│   ├── pipeline.py                # End-to-End FinTrustMLPipeline Class
│   ├── preprocessing.py           # Feature Engineering & Column Transformer
│   └── validation.py              # Schema & Boundary Validation Suite
│
├── tests/                         # Pytest Test Suite (24 Passed)
│   ├── test_api.py                # REST API Endpoint Tests
│   ├── test_assistant.py          # GenAI Grounding & Safety Guardrail Tests
│   └── test_pipeline.py           # ML Pipeline & Schema Tests
│
├── Dockerfile                     # Docker containerization definition
├── docker-compose.yml             # Docker Compose service orchestration
├── README.md                      # Project Documentation
├── run_pipeline.py                # Master CLI Execution Script
└── requirements.txt               # Dependency Locking
```

---

## 🛠️ Quick Start & Reproducibility Guide

### 1. Installation
Ensure Python 3.10+ is installed, then install required dependencies:
```bash
pip install -r requirements.txt
```

### 2. Execute Automated Test Suite
Run the 24-test Pytest suite:
```bash
pytest -v
```

### 3. Run End-to-End Master Pipeline
Execute data validation, feature engineering, 4-model evaluation, figure generation, and candidate serialization:
```bash
python run_pipeline.py
```

### 4. Launch REST API Server (Uvicorn)
Start local FastAPI web server:
```bash
uvicorn src.api:app --reload --port 8000
```
Navigate to `http://127.0.0.1:8000/docs` in your browser for OpenAPI documentation.

### 5. Launch REST API via Docker Compose
Containerize and deploy via Docker:
```bash
docker-compose up --build
```
Verify container health at `http://localhost:8000/health`.

---

## 📊 Model Evaluation Summary

| Model | Accuracy | Precision | Recall | F1-Score | ROC-AUC | Status / Selection Rationale |
| :--- | :---: | :---: | :---: | :---: | :---: | :--- |
| **Logistic Regression (Class-Weighted)** | **62.4%** | **28.6%** | **61.5%** | **0.3903** | **0.6730** | **Selected Candidate** (Max Recall for risk detection) |
| Decision Tree Classifier | 63.6% | 28.6% | 57.5% | 0.3822 | 0.6354 | Evaluated Candidate |
| Random Forest Classifier | 77.3% | 35.7% | 20.0% | 0.2565 | 0.6487 | Evaluated Candidate (Misses 80% risk cases) |
| XGBoost Classifier | 66.8% | 28.3% | 45.1% | 0.3475 | 0.6390 | Evaluated Candidate |

---

## ⚠️ Educational Disclaimer
All customer profiles, transaction details, and risk review flags are **synthetic educational constructs** created for the AnalystLab Africa internship program. The `Risk_Review_Flag` target variable must not be presented as real-world financial fraud or commercial crime determination.
