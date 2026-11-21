 
<h1 align="center">
  Positive-Edge-Triggered D Flip-Flop Using 2:1 Multiplexers
</h1>

<p align="center">
  <b>Verilog HDL | ModelSim 2020.1 | GVim</b>
</p>

---

## 1. Project Overview

This project demonstrates the design and functional verification of a **positive-edge-triggered D Flip-Flop using two 2:1 multiplexers** in Verilog HDL.

The circuit is implemented using a master-slave configuration. The first multiplexer acts as the master stage, while the second multiplexer acts as the slave stage.

The output changes according to the input data at the positive edge of the clock signal. The design also provides a complementary output, Q_B.

## 2. Objectives

- To understand the operation of a D Flip-Flop.
- To implement a positive-edge-triggered D Flip-Flop using two 2:1 multiplexers.
- To understand the master-slave configuration.
- To verify the functionality using Verilog HDL.
- To simulate and analyze the output waveform using ModelSim 2020.1.

## 3. Tools and Technologies

| Tool | Purpose |
|---|---|
| Verilog HDL | RTL design |
| GVim | Code editing |
| ModelSim 2020.1 | Simulation and verification |
| GitHub | Project documentation and version control |

## 4. Repository Structure

```text
d-flip-flop-using-2x1-multiplexers-verilog/
│
├── dff_mux.v
├── dff_mux_tb.v
├── Waveform.png
└── README.md
```

## 5. What is a D Flip-Flop?

A D Flip-Flop is a sequential logic circuit that stores one bit of information.

It has:
- D: Data input
- CLK: Clock input
- Q: Normal output
- Q_B: Complementary output

In a positive-edge-triggered D Flip-Flop, the output captures the value of D at the rising edge of the clock.

The output remains unchanged between consecutive rising edges.

## 6. What is a 2:1 Multiplexer?

A 2:1 multiplexer is a combinational circuit that selects one of two input signals based on a select signal.

It consists of:
- Two data inputs: I0 and I1
- One select input: S
- One output: Y

### Truth Table

| Select (S) | Output (Y) |
|---|---|
| 0 | I1 |
| 1 | I0 |

### Boolean Expression

\[
Y = \overline{S}I_1 + SI_0
\]

## 7. Working Principle

The D Flip-Flop is implemented using two 2:1 multiplexers connected in a master-slave configuration.

### Master Stage

The first multiplexer acts as the master stage.

- When CLK = 0, the master stage follows the input D.
- When CLK = 1, the master stage holds its previous value.

### Slave Stage

The second multiplexer acts as the slave stage.

- When CLK = 0, the slave stage holds its previous output.
- When CLK = 1, the slave stage follows the master output.

### Positive-Edge Triggering

At the rising edge of the clock:

1. The master stage stops following the input and stores the last input value.
2. The slave stage becomes transparent.
3. The stored master value is transferred to the output Q.

Therefore, the output captures the input D at the positive edge of CLK.

## 8. D Flip-Flop Truth Table

| Clock Condition | D | Q(next) |
|---|---|---|
| Rising edge (↑) | 0 | 0 |
| Rising edge (↑) | 1 | 1 |
| No rising edge | X | Q(previous) |

Here, X represents a don't-care input.

### Characteristic Equation

\[
Q_{next}=D \quad \text{at the rising edge}
\]

## 9. Multiplexer Equations

The master-stage equation is:

\[
Y = \overline{CLK}D + CLK \cdot Y
\]

The slave-stage equation is:

\[
Q = CLK \cdot Y + \overline{CLK}\cdot Q
\]

The complementary output is:

\[
Q_B = \overline{Q}
\]

## 10. Verilog HDL Design Code

**File: `dff_mux.v`**

```verilog
module DFF(D, clk, Q, Q_B);

input wire D;
input wire clk;
output wire Q, Q_B;

wire Y;

// Master stage
mux2X1 dut1 ({D,Y}, clk, Y);

// Slave stage
mux2X1 dut2 ({Q,Y}, clk, Q);

// Complementary output
assign Q_B = ~Q;

endmodule


// 2:1 Multiplexer

module mux2X1(I,S,Y);

input [1:0] I;
input S;
output Y;

assign Y = S ? I[0] : I[1];

endmodule
```

## 11. Verilog Testbench

**File: `dff_mux_tb.v`**

```verilog
`include "dff_mux.v"

module dff_tb;

reg D, clk;
wire Q, Q_B;

// DUT instantiation
DFF dut(D, clk, Q, Q_B);

// Clock generation
initial begin
    clk = 0;
    forever #7 clk = ~clk;
end

// Randomized data input
initial begin
    repeat(100) begin
        D = $urandom;
        #3;
    end
end

// Simulation termination
initial begin
    #200;
    $finish;
end

endmodule
```

**Note:** The testbench uses randomized input data. The clock toggles every 7 simulation time units, and the simulation terminates after 200 simulation time units. Since no `timescale` directive is specified, these values are simulator time units rather than a guaranteed nanosecond scale.

## 12. ModelSim Simulation

The following commands can be used to compile and simulate the design.

### Step 1: Compile the Testbench

```tcl
vlog dff_mux_tb.v
```

### Step 2: Start Simulation

```tcl
vsim -voptargs=+acc dff_tb
```

### Step 3: Add Signals to Waveform

```tcl
add wave sim:/dff_tb/*
add wave sim:/dff_tb/dut/*
```

### Step 4: Run Simulation

```tcl
run -all
```

## 13. Simulation Results

The D Flip-Flop was simulated using ModelSim 2020.1. Randomized data input values were applied to verify the behaviour of the master-slave multiplexer-based circuit.

### 13.1 ModelSim Simulation Waveform

The following waveform shows the input signals D and CLK, along with the output signals Q and Q_B.

<p align="center">
  <img src="./Waveform.png"
       alt="Positive Edge Triggered D Flip-Flop ModelSim Waveform"
       width="900">
</p>

<p align="center">
  <b>Figure 1: ModelSim Simulation Waveform of Positive-Edge-Triggered D Flip-Flop Using 2:1 Multiplexers.</b>
</p>

### 13.2 Simulation Signal Analysis

| Signal | Description |
|---|---|
| D | Data input of the D Flip-Flop |
| clk | Clock signal |
| Q | Main output |
| Q_B | Complementary output of Q |

### 13.3 Expected Behaviour

- When the clock is LOW, the master stage follows the input data, while the slave stage holds its previous output.
- At the rising edge of the clock, the master stage stores the input value.
- The slave stage transfers the stored value to the output.
- The output Q remains unchanged until the next rising edge.
- The complementary output Q_B always represents the inverse of Q.

## 14. Applications

- Data storage elements
- Registers
- Counters
- Shift registers
- Sequential logic circuits
- Digital systems and processor architectures

## 15. Learning Outcomes

Through this project, I gained practical understanding of:

- D Flip-Flop operation and positive-edge triggering.
- Master-slave architecture using multiplexers.
- 2:1 multiplexer implementation in Verilog HDL.
- RTL design and testbench development.
- Clock generation and randomized input stimulus.
- Functional simulation and waveform analysis using ModelSim.

## 16. Conclusion

A positive-edge-triggered D Flip-Flop was successfully designed using two 2:1 multiplexers in Verilog HDL.

The master-slave configuration ensures that the output captures the input data only at the rising edge of the clock. The design was simulated using ModelSim 2020.1 with randomized input data to observe and understand its sequential behaviour.

---

<p align="center">
  <b>Designed and Simulated using Verilog HDL and ModelSim 2020.1</b>
</p>
