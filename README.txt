1.Overall Introduction
(1) Use the script "build.sh" for testing the 7 samples in file "Sample", please execute the script on linux platform.
(2) First, you must apply for a academic licence of Gurobi(http://www.gurobi.com/) and register the license in your computer Linux system, Invoke the script using the sudo ./build.sh , where result information will be storaged in file "Sample". maybe you should modify context about some file path in the script file for correct execting the script file.
(3) If you want to modify code , please apply a academic licence of Gurobi and register the license in your computer Linux system. and configure pthread library on your linux platform.

2.SCLSAlgorithm Directory Structure
SCLSAlgorithm.zip/
|-- Debug/                         Directory storing the executable binary file. 
|-- Sample/                        Topology trace data
|   |     |-- demand.csv            soruce and destination node
|   |     |-- srlg.csv            	 SRLG information
|   |     |-- topo.csv              graph topology
|-- src/                         Code directory.
|     |-- lib/                   lib header file directory, which cannot be modified. No files can be added to this directory.    
|     |     |-- lib_io.h         Header file for reading and writing files, which cannot be modified.   
|     |     |-- lib_time.h       Header file for printing time, which cannot be modified.    
|     |-- CoSE                   CoSE algorithm 
|     |-- franz                  SCLS algorithm
|     |-- IP                     Integre programing(ILP,IQCP) programing 
|     |-- KSP                    KSP algorithm
|     |-- main.cpp                   main function 
|-- build.sh                     Script for abstract performance metric information from terminal output.
|-- readme.txt                   The file you are reading.
