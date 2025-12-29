# `alexmerced/datanotebook` Docker Image Documentation
(alexmerced/slim-datanotebook is the same image but smaller)

## Overview

The `alexmerced/datanotebook` Docker image provides a robust Python environment for data engineering and data science. It is built on `python:3.11.14` and includes a comprehensive suite of libraries for working with data lakes, databases, and machine learning models.

## Features

- **Base Image**: `python:3.11.14`
- **User**: `pydata` (Home: `/home/pydata`, Work: `/home/pydata/work`)
- **JupyterLab**: Pre-installed and exposed on port `8888`.
- **Extensive Tooling**: Includes support for Apache Iceberg, Apache Spark, Dremio, and more.

## Included Libraries

### Data Engineering & Lakehouse
- **Apache Iceberg**: `pyiceberg[gcsfs,adlfs,s3fs,sql-sqlite,sql-postgres,glue,hive]`
- **Apache Spark**: `pyspark`
- **Dremio**: `dremio-simple-query`, `dremioframe`, `dremio-cli`
- **Query Engines**: `duckdb`, `datafusion`, `polars`, `ibis-framework`, `sqlframe`

### Data Science & ML
- **Core**: `pandas`, `numpy`, `scipy`
- **ML**: `scikit-learn`, `tensorflow`, `torch`, `xgboost`, `lightgbm`, `statsmodels`
- **Visualization**: `matplotlib`, `seaborn`, `plotly`

### Utilities
- **Connectors**: `boto3`, `s3fs`, `minio`, `sqlalchemy`, `psycopg2-binary`, `requests`
- **Formats**: `pyarrow`, `openpyxl`, `lxml`

## Quick Start

### Run the Container

```bash
docker run -p 8888:8888 -v $(pwd):/home/pydata/work alexmerced/datanotebook
```

Access JupyterLab at `http://localhost:8888`.
