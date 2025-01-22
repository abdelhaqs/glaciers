FROM python:3.9-slim

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && . $HOME/.cargo/env \
    && rustc --version \
    && cargo --version \
    && pip install --no-cache-dir \
        polars \
        glaciers \
        hypersync \
        requests \
        toml \
        pandas \
        nbformat \
        plotly \
        notebook

# Set the default command to bash
CMD ["bash"]
