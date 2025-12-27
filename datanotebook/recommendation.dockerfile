# --- Stage 1: Builder ---
FROM python:3.11-slim as builder
WORKDIR /app
# Install build dependencies
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

# 1. Install "Pickiest" Dependencies FIRST (Data Engineering Stack)
# We pin standard versions known to work together for Iceberg/Dremio/Spark
RUN pip install --no-cache-dir \
    "fsspec>=2023.1.0,<2024.1.0" \
    "s3fs>=2023.1.0,<2024.1.0" \
    "gcsfs>=2023.1.0,<2024.1.0" \
    "adlfs>=2023.1.0,<2024.1.0" \
    "dask[dataframe]<2024.3.0" \
    "getdaft<0.2.20" \
    pyiceberg[gcsfs,adlfs,s3fs,sql-sqlite,sql-postgres,glue,hive] \
    pyspark dremio-simple-query minio dremioframe pypangolin dremio-cli \
    ibis-framework \
    boto3 requests beautifulsoup4 lxml pyarrow sqlalchemy psycopg2-binary duckdb polars datafusion sqlframe

# 2. Install ML Libraries (CPU Only)
# Installing these separately avoids the solver trying to align them with the DE stack
RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
RUN pip install --no-cache-dir tensorflow-cpu

# 3. Install General Data Science & Viz
RUN pip install --no-cache-dir \
    jupyterlab notebook \
    pandas numpy matplotlib seaborn scikit-learn \
    xgboost lightgbm statsmodels plotly openpyxl

# --- Stage 2: Final Runtime ---
FROM python:3.11-slim
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /home/pydata/work

# Install runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    default-jre-headless \
    libopenblas0 \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN useradd -ms /bin/bash pydata && \
    chown -R pydata:pydata /home/pydata
USER pydata
EXPOSE 8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--NotebookApp.token=''"]