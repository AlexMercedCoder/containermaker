# `alexmerced/spark40nb` Docker Image Documentation

## Overview

The `alexmerced/spark40nb` Docker image provides a cutting-edge environment for experimenting with **Apache Spark 4.0 (Preview)**. It includes Python 3.10, Java 17, and JupyterLab, along with a comprehensive suite of data engineering and data science libraries.

> **Note**: This image uses a Preview version of Apache Spark 4.0. It is intended for testing and development, not production.

## Features

- **Apache Spark 4.0.0-preview2**: The latest preview of the next major Spark version.
- **Java 17**: Required runtime for Spark 4.0.
- **Python 3.10**: Compatible Python environment.
- **JupyterLab**: Pre-installed for interactive development.
- **Extensive Libraries**: Includes `pyspark`, `ibis-framework`, `polars`, `dremio-simple-query`, and more.

## Quick Start

### Pull the Docker Image

```bash
docker pull alexmerced/spark40nb
```

### Run the Container

```bash
docker run -p 8888:8888 -p 4040:4040 -p 7077:7077 -p 8080:8080 -p 8081:8081 alexmerced/spark40nb
```

Access JupyterLab at `http://localhost:8888`.

### Access Spark Web UIs

- **Spark Master Web UI**: [http://localhost:8081](http://localhost:8081)
- **Spark Worker Web UI**: [http://localhost:7078](http://localhost:7078)
- **Spark Application UI**: [http://localhost:4040](http://localhost:4040)
