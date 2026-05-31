\# Parameterized FIFO in Verilog



A parameterized synchronous FIFO implementation written in Verilog.



\## Features



\- Parameterizable data width

\- Parameterizable FIFO depth

\- Configurable address width using `$clog2`

\- Full and empty flag generation

\- Simultaneous read and write support

\- Circular buffer implementation using read and write pointers



\## Parameters



| Parameter | Description | Default |

|------------|------------|---------|

| DATA\_WIDTH | Width of each FIFO entry | 8 |

| DEPTH | Number of FIFO entries | 16 |



\## Ports



| Signal | Direction | Description |

|----------|----------|-------------|

| clk | Input | System clock |

| rst | Input | Synchronous reset |

| wr\_en | Input | Write enable |

| rd\_en | Input | Read enable |

| din | Input | Write data |

| dout | Output | Read data |

| full | Output | FIFO full flag |

| empty | Output | FIFO empty flag |



\## Directory Structure



```text

src/

└── FIFO\_parameterized.v

```



\## Future Improvements



\- Testbench

\- VHDL implementation

\- Pointer-wrap FIFO implementation

\- Formal verification

