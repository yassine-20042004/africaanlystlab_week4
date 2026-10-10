# ==============================================================================
# FinTrust Digital Bank — Production Risk Inference REST API Service
# Dockerfile for FastAPI Containerization
# ==============================================================================

FROM python:3.11-slim

# Prevent Python from writing .pyc files and buffer stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy dependency definition and install Python requirements
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy application source code, models, data and tests
COPY src/ ./src/
COPY models/ ./models/
COPY data/ ./data/
COPY sql/ ./sql/
COPY reports/ ./reports/
COPY tests/ ./tests/
COPY run_pipeline.py .

# Expose port 8000 for FastAPI REST service
EXPOSE 8000

# Health check to monitor container health status
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8000/health || exit 1

# Launch uvicorn web server
CMD ["uvicorn", "src.api:app", "--host", "0.0.0.0", "--port", "8000"]
