# --- Stage 1: Builder ---
FROM python:3.11-slim as builder
WORKDIR /app
# Install build dependencies (these will NOT be in the final image)
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    libpq-dev \
    libffi-dev \
    libssl-dev \
    curl
# Create a virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
# 1. Install CPU-only PyTorch (Huge savings)
RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
# 2. Install TensorFlow CPU
RUN pip install --no-cache-dir tensorflow-cpu
# 3. Install the rest of the stack
RUN pip install --no-cache-dir \
    jupyterlab notebook \
    pandas numpy matplotlib seaborn scikit-learn \
    xgboost lightgbm dask statsmodels plotly openpyxl \
    pyarrow sqlalchemy psycopg2-binary requests beautifulsoup4 lxml \
    duckdb polars pyspark dremio-simple-query boto3 s3fs minio dremioframe pypangolin dremio-cli \
    ibis-framework pyiceberg[gcsfs,adlfs,s3fs,sql-sqlite,sql-postgres,glue,hive] \
    getdaft[all] datafusion sqlframe[all]
# --- Stage 2: Final Runtime ---
FROM python:3.11-slim
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /home/pydata/work
# Install only strict runtime dependencies
# default-jre-headless is smaller than default-jre
RUN apt-get update && apt-get install -y --no-install-recommends \
    default-jre-headless \
    libopenblas0 \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*
# Copy the pre-built environment from the builder stage
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
# Setup User
RUN useradd -ms /bin/bash pydata && \
    chown -R pydata:pydata /home/pydata
USER pydata
EXPOSE 8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--NotebookApp.token=''"]