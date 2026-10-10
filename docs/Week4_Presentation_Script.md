# FinTrust Digital Bank — Individual Final Presentation Script & Slide Outline
## 5–10 Minute Recorded Presentation Guide

**Speaker**: Lead Data Scientist & ML Engineer  
**Project**: FinTrust Financial Intelligence & Digital Banking Support Solution  
**Lab**: AnalystLab Africa Experience Lab Internship — Week 4 Final Submission  
**Target Duration**: 7 minutes (within 5–10 minute requirement)  

---

## 📽️ SLIDE DECK STRUCTURE & SPEAKER SCRIPT

### SLIDE 1: Title & Introduction (0:00 - 0:30)
- **Slide Visual**: FinTrust Digital Bank logo, Project Title ("Financial Intelligence & Digital Banking Support Solution"), Presenter Name, AnalystLab Africa Internship.
- **Speaker Script**:
  > "Hello everyone! Welcome to my final presentation for the FinTrust Digital Bank project as part of the AnalystLab Africa Experience Lab Internship Programme. Today, I am excited to present our comprehensive financial intelligence, predictive risk modeling, containerized REST API, and knowledge-grounded support assistant."

---

### SLIDE 2: Section 1 — The FinTrust Problem (0:30 - 1:15)
- **Slide Visual**: FinTrust business challenges bulleted:
  - Rapid digital banking growth (12,000 transactions, 554.8M NGN volume).
  - Friction in mobile channels (5.80% failure rate).
  - Need to identify high-risk transactions while minimizing customer drop-off.
  - Requirement for safe, grounded AI customer support without policy hallucinations.
- **Speaker Script**:
  > "FinTrust Digital Bank faces a dual challenge: first, managing high transaction volume across diverse channels like Mobile and POS while maintaining low transaction failure rates. Second, identifying synthetic high-risk transactions without causing unnecessary friction for legitimate customers. Finally, FinTrust needed a safe customer support channel that answers routine policy questions accurately without inventing fees or exposing sensitive user credentials."

---

### SLIDE 3: Section 2 & 3 — Assigned Track & What Was Developed (1:15 - 2:15)
- **Slide Visual**: Multi-track architecture diagram showing:
  - **Data Analytics**: Advanced SQL CTE queries, 5 key business insights, interactive web dashboard.
  - **Data Science**: 14 engineered features, 4-model evaluation suite, candidate model selection.
  - **ML Engineering**: Modular Python pipeline, FastAPI REST service, Docker containerization.
  - **GenAI Track**: Grounded support assistant with security guardrails.
  - **Project Management**: Risk closure matrix & delivery tracking.
- **Speaker Script**:
  > "Although our lab spanned multiple tracks, I delivered an end-to-end integrated solution covering Data Analytics, Data Science, ML Engineering, and GenAI. Key highlights include an interactive HTML dashboard, 14 engineered behavioural features, a 4-model comparative study selecting Class-Weighted Logistic Regression, a dockerized FastAPI REST endpoint, and a zero-hallucination GenAI customer support assistant."

---

### SLIDE 4: Section 4 — Tools Used (2:15 - 2:45)
- **Slide Visual**: Logos / icons of technology stack:
  - **Languages & Frameworks**: Python 3.11, FastAPI, Pydantic v2, SQL.
  - **Data & ML**: Pandas, NumPy, Scikit-Learn, Joblib, XGBoost.
  - **Testing & Containerization**: Pytest, Docker, Docker Compose.
  - **Visualization & UI**: HTML5, Vanilla CSS, JavaScript, Power BI concepts.
- **Speaker Script**:
  > "We utilized a modern data science stack: Python 3.11, Pandas, NumPy, and Scikit-Learn for data modeling. For engineering and deployment, we used FastAPI, Pydantic v2, Pytest for automated unit testing, and Docker for containerization."

---

### SLIDE 5: Section 5 — Key Findings & Results (2:45 - 4:00)
- **Slide Visual**: Model comparison table and business insights:
  - Logistic Regression achieved **61.5% Recall** and **0.6730 ROC-AUC** (outperforming complex tree models on recall).
  - Mobile App channel accounts for 42.5% of volume but exhibits highest failure rate (5.80%).
  - Cross-border international transactions carry a 1.95x higher risk review flag rate (36.88% vs 18.88%).
- **Speaker Script**:
  > "Here are our primary findings. First, in model selection, tree ensembles like Random Forest achieved high overall accuracy (77.3%), but degraded recall to just 20.0%—missing 80% of risk cases! By applying class weighting to Logistic Regression, we achieved an optimal 61.5% Recall and 0.6730 ROC-AUC. On the analytics side, we discovered that cross-border transactions are nearly twice as likely to trigger risk reviews, and mobile transactions suffer from elevated failure rates."

---

### SLIDE 6: Section 6 & 7 — Testing, Validation & Improvements Made (4:00 - 5:15)
- **Slide Visual**: Iterative refinement flowchart:
  - $\text{Final Output} \to \text{Test} \to \text{Finding} \to \text{Refinement} \to \text{Re-test} \to \text{Final Result}$
  - **Pytest**: 24/24 unit & integration tests passing (100% pass rate).
  - **GenAI Refinement**: Corrected keyword precedence order so fee/limit guardrails fire before general transfer matching.
- **Speaker Script**:
  > "Testing and validation was a core requirement. We built a 24-test Pytest suite. During initial testing of our GenAI assistant, we found that fee inquiries containing the word 'transfer' were accidentally matching general transfer guidance. We refined the keyword parsing order so fee and limit guardrails evaluate first. Upon re-testing, all 24 tests passed with a 100% success rate!"

---

### SLIDE 7: Section 8 — Connection to Wider FinTrust Solution (5:15 - 6:00)
- **Slide Visual**: Integrated solution workflow diagram:
  - $\text{Customer/Transaction Data} \to \text{Analytics KPIs} \to \text{Risk Model} \to \text{FastAPI REST Service} \to \text{GenAI Support}$
- **Speaker Script**:
  > "How does this connect to the broader FinTrust bank solution? Customer and transaction data flow into analytical dashboards for operational oversight. Transactions are then streamed into our FastAPI service where our trained model scores risk in under 2 milliseconds. Simultaneously, customer support queries pass through our grounded GenAI assistant, creating an end-to-end ecosystem."

---

### SLIDE 8: Section 9 & 10 — Limitations & Lessons Learned (6:00 - 7:00)
- **Slide Visual**:
  - **Limitations**: Synthetic target variable (`Risk_Review_Flag`), prototype REST deployment, static knowledge base.
  - **Lessons Learned**:
    1. Metric alignment matters — optimize for Recall in fraud/risk detection, not accuracy alone.
    2. Guardrails must evaluate before general intent matching in conversational AI.
    3. Comprehensive automated testing ensures fast, reliable refactoring.
- **Speaker Script**:
  > "To conclude with limitations and lessons learned: `Risk_Review_Flag` is a synthetic educational target created for the internship lab, so this system is a prototype rather than a live commercial banking platform. Key lessons learned include prioritizing business-relevant metrics like Recall over raw accuracy, enforcing guardrails prior to general topic matching, and embedding unit testing from day one. Thank you so much for your time!"
