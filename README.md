# Parameterized FIFO in Verilog

A parameterized synchronous FIFO implementation written in Verilog.

## Features

- Parameterizable data width
- Parameterizable FIFO depth
- Address width automatically derived using `$clog2`
- Full and empty flag generation
- Simultaneous read and write support
- Circular buffer implementation using read and write pointers
- Synchronous reset

## Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| DATA_WIDTH | Width of each FIFO entry | 8 |
| DEPTH | Number of FIFO entries | 16 |

## Ports

| Signal | Direction | Description |
|---------|----------|-------------|
| clk | Input | System clock |
| rst | Input | Synchronous reset |
| wr_en | Input | Write enable |
| rd_en | Input | Read enable |
| din | Input | Input data |
| dout | Output | Output data |
| full | Output | FIFO full flag |
| empty | Output | FIFO empty flag |

## Architecture

The FIFO uses:

- A memory array for data storage
- Independent read and write pointers
- An occupancy counter for full/empty detection
- Circular addressing to support continuous operation

### Full Detection

```verilog
full = (count == DEPTH);
```

### Empty Detection

```verilog
empty = (count == 0);
```

### Simultaneous Read and Write

The design supports concurrent read and write operations. When both operations occur in the same clock cycle, FIFO occupancy remains unchanged.

## Directory Structure

```text
.
├── README.md
├── .gitignore
└── src
    └── FIFO_parameterized.v
```

## Example Configuration

```verilog
FIFO_parameterized #(
    .DATA_WIDTH(32),
    .DEPTH(64)
) u_fifo (
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .din(din),
    .dout(dout),
    .full(full),
    .empty(empty)
);
```

## Future Improvements

- Verilog testbench
- Self-checking testbench
- VHDL implementation
- Pointer-wrap FIFO implementation
- Asynchronous FIFO
- Formal verification

## Author

Divyansh Narayan
