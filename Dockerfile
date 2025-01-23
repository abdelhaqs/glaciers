FROM python:3.11-slim

# Install dependencies for Rust
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       curl \
       gcc \
       build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && . "$HOME/.cargo/env" \
    && rustc --version \
    && cargo --version

# Set environment variables for Rust
ENV PATH="/root/.cargo/bin:$PATH"

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip \
    && pip install --no-cache-dir \
       polars hypersync requests toml pandas nbformat plotly notebook

# Expose Jupyter Notebook port
EXPOSE 8888

# Set the working directory
WORKDIR /app

# Default command to run Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]