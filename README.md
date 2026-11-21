# Positive-Edge-Triggered D Flip-Flop Using 2:1 Multiplexers in Verilog HDL

<h1 align="center">
  Design and Verification of Positive-Edge-Triggered D Flip-Flop Using 2:1 Multiplexers in Verilog HDL
</h1>

<p align="center">
  <b>Verilog HDL | ModelSim 2020.1 | GVim</b>
</p>

---

## 1. Project Overview

This project focuses on the design and functional verification of a **positive-edge-triggered D Flip-Flop using two 2:1 Multiplexers** in Verilog Hardware Description Language (HDL).

A D Flip-Flop is a sequential logic circuit that stores one bit of binary information. It transfers the input data to the output at a specific active clock edge and retains the stored value between clock transitions.

In this implementation, two 2:1 Multiplexers are connected in a master–slave configuration to realize a positive-edge-triggered D Flip-Flop.

The first multiplexer acts as the master latch, while the second multiplexer acts as the slave latch. The design also generates the complementary output Q_B.

The circuit is verified using a Verilog testbench that generates a clock signal and applies randomized data inputs. Functional simulation is performed using ModelSim 2020.1.

## 2. Objectives

- To understand the working principle of a D Flip-Flop.
- To design a 2:1 Multiplexer using Verilog HDL.
- To implement a D Flip-Flop using two 2:1 Multiplexers.
- To understand master–slave latch configuration.
- To implement positive-edge-triggered operation.
- To generate complementary outputs Q and Q_B.
- To develop a testbench for functional verification.
- To simulate and analyze the design using ModelSim.

## 3. Tools and Technologies Used

| Tool / Technology | Description |
|:---|:---|
| Verilog HDL | Hardware Description Language |
| ModelSim 2020.1 | Compilation and functional simulation |
| GVim | Verilog source-code editor |
| Windows / Linux | Development environment |

## 4. Repository Structure

```text
D-Flip-Flop-Using-2x1-Multiplexers/
│
├── dff_mux.v
├── dff_mux_tb.v
├── Waveform.png
└── README.md
```

| File Name | Description |
|:---|:---|
| `dff_mux.v` | Verilog design containing the 2:1 MUX and D Flip-Flop modules |
| `dff_mux_tb.v` | Testbench for functional verification |
| `Waveform.png` | ModelSim simulation waveform |
| `README.md` | Project documentation |

## 5. Theoretical Background

### 5.1 D Flip-Flop

A D Flip-Flop is a sequential logic circuit that stores one bit of binary information.

It has the following signals:

- D: Data input
- CLK: Clock input
- Q: Main output
- Q_B: Complementary output

The output Q follows the input D at the active clock edge and retains its previous value between active clock edges.

The complementary output is:

\[
Q_B=\overline{Q}
\]

### 5.2 D Flip-Flop Truth Table

For a positive-edge-triggered D Flip-Flop:

| Clock Condition | D | Q(next) | Q_B(next) |
|:---|:---:|:---:|:---:|
| Rising edge (0 → 1) | 0 | 0 | 1 |
| Rising edge (0 → 1) | 1 | 1 | 0 |
| No active edge | X | Q(previous) | Q_B(previous) |

Here, X represents either logic 0 or logic 1.

### 5.3 Characteristic Equation

The characteristic equation of a D Flip-Flop is:

\[
Q_{next}=D
\]

The complementary output is:

\[
Q_B=\overline{Q}
\]

The output changes according to the data input at the rising edge of the clock.

## 6. 2:1 Multiplexer

A 2:1 Multiplexer is a combinational circuit that selects one of two input signals based on a single select line.

It consists of:

- Two data inputs: I0 and I1
- One select input: S
- One output: Y

### 6.1 Selection Table

| Select (S) | Output (Y) |
|:---:|:---|
| 0 | I1 |
| 1 | I0 |

### 6.2 Boolean Expression

The output of a 2:1 Multiplexer is:

\[
Y=\overline{S}I_1+SI_0
\]

### 6.3 Verilog Implementation

The 2:1 Multiplexer is implemented using the conditional operator:

```verilog
assign Y=S?I[0]:I[1];
```

When S is logic HIGH, I0 is selected. When S is logic LOW, I1 is selected.

## 7. D Flip-Flop Implementation Using 2:1 Multiplexers

In this project, two 2:1 Multiplexers are connected in a master–slave configuration.

The first MUX acts as the master latch, and the second MUX acts as the slave latch.

### 7.1 Master Latch

The first multiplexer implements the master latch:

```verilog
mux2X1 dut1 ({D,Y}, clk, Y);
```

Its input connections are:

- I0 = Y (feedback)
- I1 = D (data input)
- Select = CLK

The master latch output equation is:

\[
Y=CLK\cdot Y+\overline{CLK}\cdot D
\]

Operation:

- When CLK = 0, the master latch is transparent and follows D.
- When CLK = 1, the master latch retains its previous value.

### 7.2 Slave Latch

The second multiplexer implements the slave latch:

```verilog
mux2X1 dut2 ({Q,Y}, clk, Q);
```

Its input connections are:

- I0 = Q (feedback)
- I1 = Y (master output)
- Select = CLK

The slave latch output equation is:

\[
Q=CLK\cdot Y+\overline{CLK}\cdot Q
\]

Operation:

- When CLK = 0, the slave latch retains its previous output.
- When CLK = 1, the slave latch follows the master output Y.

### 7.3 Positive-Edge-Triggered Operation

The master latch is transparent during the LOW clock level, while the slave latch is transparent during the HIGH clock level.

The operation follows these steps:

1. When CLK = 0, the master latch follows the input D, while the slave latch holds its previous output.
2. At the rising edge of the clock (0 → 1), the master latch holds the last input value.
3. The slave latch becomes transparent and transfers the stored master value to Q.
4. During the HIGH clock level, the master retains its value and the slave output remains stable.
5. At the falling edge, the slave closes and the master becomes transparent again.

Therefore, the master–slave configuration implements a **positive-edge-triggered D Flip-Flop**.

## 8. Verilog HDL Design

### 8.1 Source Code: `dff_mux.v`

```verilog
module DFF(D, clk, Q, Q_B);

input wire D;
input wire clk;
output wire Q,Q_B;

wire Y;

// for +ve edge trigger D-FF
mux2X1 dut1 ({D,Y}, clk, Y);
mux2X1 dut2 ({Q,Y}, clk, Q);

assign Q_B = ~Q;

endmodule


module mux2X1(I,S,Y);

input [1:0] I;
input S;
output Y;

assign Y=S?I[0]:I[1];

endmodule
```

### 8.2 Code Explanation

| Code Component | Description |
|:---|:---|
| `module DFF` | Defines the D Flip-Flop module |
| `input wire D` | Declares the data input |
| `input wire clk` | Declares the clock input |
| `output wire Q` | Declares the main output |
| `output wire Q_B` | Declares the complementary output |
| `wire Y` | Internal connection between master and slave MUXes |
| `mux2X1 dut1` | First MUX implementing the master latch |
| `mux2X1 dut2` | Second MUX implementing the slave latch |
| `assign Q_B = ~Q` | Generates the complementary output |
| `assign Y=S?I[0]:I[1]` | Implements the 2:1 Multiplexer |

## 9. Testbench Implementation

A testbench is developed to verify the functionality of the D Flip-Flop.

The testbench generates a clock signal using a forever loop and applies randomized data values using the Verilog system function `$urandom`.

The data input is updated after every 3 simulation time units, while the clock toggles after every 7 simulation time units.

The simulation is terminated after 200 simulation time units.

### 9.1 Testbench Code: `dff_mux_tb.v`

```verilog
`include "dff_mux.v"

module dff_tb;

reg D,clk;
wire Q,Q_B;

DFF dut(D,clk,Q,Q_B);

initial begin
    clk=0;
    forever #7 clk=~clk;
end

initial begin
    repeat(100) begin
        D=$urandom;
        #3;
    end
end

initial begin
    #200;
    $finish;
end

endmodule
```

### 9.2 Testbench Description

| Testbench Statement | Function |
|:---|:---|
| `include "dff_mux.v"` | Includes the D Flip-Flop design file |
| `dff_tb` | Declares the testbench module |
| `reg D,clk` | Declares data and clock stimulus signals |
| `wire Q,Q_B` | Declares output signals |
| `DFF dut(...)` | Instantiates the D Flip-Flop |
| `clk=0` | Initializes the clock signal |
| `forever #7 clk=~clk` | Generates a continuous clock signal |
| `repeat(100)` | Repeats the data-generation process 100 times |
| `$urandom` | Generates randomized data values |
| `#3` | Adds a delay of 3 simulation time units |
| `#200` | Sets the simulation termination time |
| `$finish` | Terminates the simulation |

## 10. ModelSim Simulation Setup

### 10.1 Simulation Commands

The following commands can be used in the ModelSim Transcript window:

```tcl
# compilation
vlog dff_mux_tb.v -l comp.log

# elaboration
vsim -voptargs=+acc dff_tb

# addwave
add wave sim:/dff_tb/dut/*

# run
run -all
```

### 10.2 Command Description

| Command | Function |
|:---|:---|
| `vlog` | Compiles the Verilog testbench |
| `-l comp.log` | Saves compilation messages in a log file |
| `vsim` | Loads the testbench for simulation |
| `-voptargs=+acc` | Enables access to internal design objects |
| `add wave` | Adds D Flip-Flop signals to the waveform window |
| `run -all` | Executes the simulation until completion |

## 11. Simulation Results

The D Flip-Flop design was simulated using ModelSim 2020.1. Randomized data input values were applied to verify the behaviour of the master–slave multiplexer-based circuit.

### 11.1 ModelSim Simulation Waveform

The following waveform shows the input signals D and CLK, along with the output signals Q and Q_B.

<p align="center">
  <img src="./Waveform.png"
       alt="Positive Edge Triggered D Flip-Flop ModelSim Waveform"
       width="900">
</p>

<p align="center">
  <b>Figure 1: ModelSim Simulation Waveform of Positive-Edge-Triggered D Flip-Flop Using 2:1 Multiplexers.</b>
</p>
### 11.2 Simulation Signal Analysis

| Signal | Description |
|:---|:---|
| `D` | Data input of the D Flip-Flop |
| `clk` | Clock signal |
| `Q` | Main output |
| `Q_B` | Complementary output of Q |
| `Y` | Internal master-latch output |

### 11.3 Simulation Observations

- The clock signal is generated continuously using a Verilog forever loop.
- The data input changes at randomized intervals.
- The first MUX operates as the master latch.
- The second MUX operates as the slave latch.
- The output Q updates at the rising edge of the clock.
- The complementary output Q_B follows the inverse of Q.
- The output retains its stored value between active clock edges.

## 12. Key Observations

- A 2:1 Multiplexer is implemented using a conditional operator.
- Two 2:1 Multiplexers are connected in a master–slave configuration.
- The design realizes a positive-edge-triggered D Flip-Flop.
- The master latch is transparent when the clock is LOW.
- The slave latch is transparent when the clock is HIGH.
- Randomized data inputs are generated using `$urandom`.
- ModelSim is used to observe and analyze the input and output waveforms.

## 13. Applications

The concepts demonstrated in this project are useful for understanding:

- Sequential logic design.
- Master–slave latch architecture.
- Flip-Flop implementation using multiplexers.
- Data storage and clock synchronization.
- Digital circuit timing.
- Verilog HDL design and functional verification.

## 14. Learning Outcomes

Through this project, I explored:

- Design of a 2:1 Multiplexer using Verilog HDL.
- Implementation of a D Flip-Flop using two multiplexers.
- Master–slave latch operation.
- Positive-edge-triggered clock behaviour.
- Complementary output generation.
- Randomized testbench stimulus generation.
- ModelSim compilation, simulation, and waveform analysis.

## 15. Conclusion

A positive-edge-triggered D Flip-Flop was designed and implemented using two 2:1 Multiplexers in Verilog HDL.

The two multiplexers operate in a master–slave configuration, providing positive-edge-triggered functionality. The complementary output Q_B is generated using an inverter.

A testbench was developed to generate clock signals and randomized data inputs. The design was simulated using ModelSim 2020.1 to analyze its sequential behaviour.

This project provided practical understanding of sequential logic design, multiplexer-based Flip-Flop implementation, master–slave architecture, and functional verification using Verilog HDL.

---

**Project Category:** Digital Design and Functional Verification

**Tools Used:** Verilog HDL | ModelSim 2020.1 | GVim
