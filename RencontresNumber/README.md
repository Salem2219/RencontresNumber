# Rencontres Number (Counting partial derangements)

Given two numbers, n >= 0 and 0 <= k <= n, count the number of derangements with k fixed points.

Examples:

Input : n = 3, k = 0
Output : 2
Since k = 0, no point needs to be on its
original position. So derangements
are {3, 1, 2} and {2, 3, 1}

Input : n = 3, k = 1
Output : 3
Since k = 1, one point needs to be on its
original position. So partial derangements
are {1, 3, 2}, {3, 2, 1} and {2, 1, 3}

Input : n = 7, k = 2
Output : 924



The recurrence relation to find Rencontres Number Dn, k:

D(0, 0) = 1
D(0, 1) = 0
D(n+2, 0) = (n+1) * (D(n+1, 0) + D(n, 0))
D(n, k) = nCk * D(n-k, 0))

Given the two positive integer n and k. The task is find rencontres number D(n, k) for giver n and k.


# FSMD
Basic Finite State Machine with Datapath (FSMD) example to calculate the number of derangements with k fixed points. n,k are up to 14.

## Install

These examples use [ModelSim&reg; and Quartus&reg; Prime from Intel FPGA](http://fpgasoftware.intel.com/?edition=lite), [GIT](https://git-scm.com/download/win), [Visual Studio Code](https://code.visualstudio.com/download), make sure they are installed locally on your computer before proceeding.

## Usage

1. Grab a copy of this repository to your computer's local folder (i.e. C:\projects):

    ```sh
    $ cd projects
    $ git clone https://github.com/Salem22/RencontresNumber.git
    ```
2. Use Visual Studio Code (VSC) to edit and view the design files:

    ```sh
    $ cd RencontresNumber
    $ code .
    ```
    Click on the toplevel.vhd file in the left pane to view its contents.
    
3. From the VSC View menu, choose Terminal, in the VCS Terminal, create a "work" library:

    ```sh
    $ vlib work
    ```
    
4. Compile all the design units:

    ```sh
    $ vcom *.vhd
    ```
    
5. Simulate your design. For example, if n = 7, k = 2 then y = 924:

    ```sh
    $ vsim work.tb
    ```
