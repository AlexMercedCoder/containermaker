# `alexmerced/slim-datanotebook` Docker Image Documentation

## Overview

The `alexmerced/slim-datanotebook` Docker image is an **optimized, lightweight** version of the datanotebook environment. It uses a multi-stage build process based on `python:3.11-slim` to significantly reduce image size while retaining essential data engineering and data science capabilities. Dependencies are explicitly pinned to ensure stability and compatibility, especially for the Apache Iceberg ecosystem.

## Features

- **Base Image**: `python:3.11-slim` (Multi-stage build)
- **Optimized Size**: Significantly smaller than the standard image.
- **Stability**: Critical dependencies (fsspec, s3fs, etc.) are pinned to prevent conflicts.
- **CPU-Optimized**: Includes CPU-only versions of ML libraries (PyTorch, TensorFlow) to save space.
- **User**: `pydata` (Home: `/home/pydata`, Work: `/home/pydata/work`)

## Included Libraries

### Data Engineering & Lakehouse (Pinned for Stability)
- **Apache Iceberg**: `pyiceberg` (with gcsfs, adlfs, s3fs, sql, glue support)
- **Apache Spark**: `pyspark`
- **Dremio**: `dremio-simple-query`, `dremioframe`, `dremio-cli`
- **Filesystem**: `fsspec`, `s3fs`, `gcsfs`, `adlfs` (Pinned versions)
- **Query Engines**: `duckdb`, `datafusion`, `polars`, `ibis-framework`

### Data Science & ML
- **Core**: `pandas`, `numpy`, `scikit-learn`
- **ML (CPU)**: `pytorch-cpu`, `tensorflow-cpu`, `xgboost`, `lightgbm`
- **Visualization**: `matplotlib`, `seaborn`, `plotly`

## Quick Start

### Run the Container

```bash
docker run -p 8888:8888 -v $(pwd):/home/pydata/work alexmerced/slim-datanotebook
```

Access JupyterLab at `http://localhost:8888`.
