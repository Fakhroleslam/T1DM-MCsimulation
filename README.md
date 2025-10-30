# T1DM-MCsimulation
**Optimal Discrete Control of Type 1 Diabetes and Validation through Monte-Carlo Simulation**

This repository contains the MATLAB/Simulink® codes and data accompanying the paper "A Personalized Bolus Advisor for Type 1 Diabetes: Stochastic Modeling, Discrete Insulin Optimization, and In-Silico Evaluation via Monte-Carlo Simulation" by Mohammad Fakhroleslam and Ramin Bozorgmehry Boozarjomehry. 

## Overview

The project implements a personalized bolus advisor (BA) for Type 1 Diabetes (T1D) patients on multiple daily injection (MDI) therapy.  
It integrates:
- A **nonlinear stochastic model** of insulin–glucose–FFA interactions  
- **Mixed-meal absorption** and **subcutaneous insulin injection** sub-models  
- **Monte Carlo simulations** to evaluate robustness under uncertainties in meals, insulin dosing, and physiological parameters  
- **Optimization routines** to compute optimal insulin injection schedules (not included in this repository)  

The repository provides the simulation framework used to generate the results presented in the paper, including stochastic evaluation based on Monte-Carlo simulations under optimal conditions.

## Repository Contents

| File | Description |
|------|-------------|
| `T1Dmodel.m` | Defines the nonlinear stochastic T1D model (insulin–glucose–FFA interactions). |
| `Mixed_Meal.m` | Implements the mixed-meal absorption sub-model (CHO, protein, FFA). |
| `InsulinInjection.m` | Implements the insulin injection sub-model for Lispro, Regular, and NPH types. |
| `HH.m` | A helper script for handling initial conditions in Simulink. |
| `T1DvirtualPatient.mdl` | Simulink model of the virtual T1D patient. |
| `T1DvirtualPatient.slxc` | Compiled Simulink cache file for faster simulation. |
| `U_opt.mat` | Pre-computed optimal insulin injection schedules (decision variables from optimization). |
| `MC_Simulations.m` | Runs Monte-Carlo simulations for the **normal daily diet** case. |
| `MC_PlotForPaper.m` | Generates the main figures used in the paper (Monte Carlo simulation results). |
| `MC_Simulations_UE_OE.m` | Runs Monte-Carlo simulations for **under-/over-eating** cases. |
| `MC_Plot_UE_OE.m` | Plots results for **under-eating (UE)** and **over-eating (OE)** scenarios. |

## Requirements
The codes have been successfully tested on MATLAB and Simulink version R2019b.

## Usage
1. Run `MC_Simulations.m` to generate and save simulation results for the normal daily diet.
2. Run `MC_PlotForPaper.m` to plot the figures presented in the paper for the normal daily diet.

OR 
1. Run `MC_Simulations_UE_OE.m` to generate and save simulation results for under- and over-eating daily diets.
2. Run `MC_Plot_UE_OE.m` to plot the figures presented in the paper for under- and over-eating daily diets.
