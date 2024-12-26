# Glaciers

Glaciers is tool for batch decoding EVM (Ethereum Virtual Machine) raw logs and traces files (traces support coming soon), producing respective decoded tables. It matches raw log and traces entries with ABI event and function signatures, adding context — what each field or value represents and type casting.

## Features
- Batch decode EVM event logs files from multiple contracts using an ABI database.
- Batch decode Polars DataFrames in Python or Rust.
- Decode multiple logs from single topic0 DataFrame in Python or Rust.

## Quick Start
### Rust Installation
Library Mode
```toml
# Cargo.toml
[dependencies]
glaciers = "[Choose your version]"
```
```rust
use glaciers::decoder;
use glaciers::abi_reader;

async fn main() -> {
    abi_reader::read_abis_topic0(TOPIC0_FILE_PATH, ABIS_FOLDER_PATH);
    decoder::process_log_files(RAW_LOGS_FOLDER_PATH, TOPIC0_FILE_PATH).await;
}
```
### Python Installation

Glaciers can also be installed as a python package:

```bash
# Clone the repository for example files:
git clone https://github.com/yulesa/glaciers
# Navigate to the project python module folder
cd glaciers/crates/python
# Install Glaciers using pip
pip install glaciers
# Run the end-to-end example
python e2e_example.py
```
For other instalations, visit the [Installation](./docs/installation.md) guide.
## Usage examples

Some initial ABIs, a abi_df database (only events), and a raw log file are provided as examples.

1. Add new ABIs to the abi_database folder. New ABIs need to be json files and have the file name as a valid contract address.
2. Add raw logs parquet files to the logs folder. File name needs to have 'logs'. Logs schemas need to have: topic0, topic1, topic2, topic3, data.
3. Compile and Run using rust, or run the python e2e_example file.

## Schemas

Glaciers will repeat the same schema you have for your input files.
Input files must contain:

    - ('topic0', Binary)
    - ('topic1', Binary)
    - ('topic2', Binary)
    - ('topic3', Binary)
    - ('data', Binary)

The following columns will be added to your original table:

    Decoded Log Schema, and example:
    - ('full_signature', String): event Transfer(address indexed from, address indexed to, uint256 value)
    - ('name', String): Transfer
    - ('anonymous', Boolean): False
    - ('event_values', String): '[Address(0xeed...), Address(0x7a2...), Uint(3151936770479715624, 256)]'
    - ('event_keys', String): '["from", "to", "value"]'
    - ('event_json', String): [{"name":"from","index":0,"value_type":"address","value":"0xeEDfF72A683058F8FF531e8c98575f920430FdC5"}...]

## Roadmap

Visit [Roadmap](./docs/roadmap.md) guide.

