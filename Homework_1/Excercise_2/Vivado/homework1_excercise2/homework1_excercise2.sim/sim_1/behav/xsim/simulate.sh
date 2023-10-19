#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2023.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Thu Oct 19 22:30:29 CEST 2023
# SW Build 3865809 on Sun May  7 15:04:56 MDT 2023
#
# IP Build 3864474 on Sun May  7 20:36:21 MDT 2023
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim full_system_tb_behav -key {Behavioral:sim_1:Functional:full_system_tb} -tclbatch full_system_tb.tcl -log simulate.log"
xsim full_system_tb_behav -key {Behavioral:sim_1:Functional:full_system_tb} -tclbatch full_system_tb.tcl -log simulate.log

