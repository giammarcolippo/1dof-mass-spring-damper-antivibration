# 1DOF Mass-Spring-Damper Anti-vibration System
Simulation and analysis of a 1DOF open-loop mass–spring–damper system for an industrial anti-vibration application (MATLAB & Simulink)

## Overview
Simulation and analysis of a 1-DOF open-loop mass–spring–damper system representing an **industrial anti-vibration support**.
The dynamic response is studied using MATLAB and Simulink under free vibration, step force, and harmonic excitation.

## Physical Model
The system consists of a rigid mass supported by a vertical antivibration element modeled with linear stiffness and viscous damping.
The support is mounted vertically and works mainly in compression.
The motion is described along the vertical direction with respect to the static equilibrium position.

**Figure 1 – 1-DOF Mass–Spring–Damper Model of an Industrial Anti-vibration Support**
![Industrial Anti-vibration Support MKC Model](figures/mkc_model.png)

## System Parameters
- Mass: **10 kg**
- Stiffness: **160 N/m**
- Damping ratios:
  - **ζ = 0.2** (under-damped)
  - **ζ = 1.0** (critically damped)
  - **ζ = 2.0** (over-damped)

## Governing Equation
The system dynamics are governed by the following second-order differential equation:

**m * x_ddot(t) + c * x_dot(t) + k * x(t) = F(t)**

where:
- **m** is the mass of the supported machine [kg]
- **c** is the damping coefficient of the antivibration support [Ns/m]
  - with **c = 2·ζ·m·ωₙ** (natural frequency **ωₙ = sqrt(k / m)**)
- **k** is the vertical stiffness of the support [N/m]
- **x(t)** is the vertical displacement of the mass with respect to the static equilibrium position [m]
- **F(t)** is the external excitation force applied to the system [N]

The equation describes the vibration of the mass around its static equilibrium position.
Gravity effects are accounted for through the static preload and are not explicitly included
in the dynamic equation.

## Excitation Cases and Parameters
### Free Response
- Initial displacement: 0.1 m
- Initial velocity: 0 m/s
- External force F(t): 0 N
 
### Step Excitation
**F(t) = F₀ · u(t)**

- Magnitude F₀: 5 N
- Step applied at t = 1 s
- Duration: full simulation
- Initial displacement: 0 m
- Initial velocity: 0 m/s

### Harmonic Force 
**F(t) = F₀ · sin(ωt)**

- Amplitude: 5 N
- Angular frequency: 1.5·ωₙ [rad/s]
- Initial displacement: 0 m
- Initial velocity: 0 m/s

#### Resonance and Transmissibility Analysis
Resonance analysis has been performed for educational purposes. 
For the under-damped system (ζ = 0.2), the amplitude peaks near the natural frequency (~3.98 rad/s), showing resonance under harmonic excitation.  
Higher damping ratios reduce the peak, illustrating the effect of damping on the system response.

## Tools Used
- MATLAB (post-processing)
- Simulink (dynamic system modeling)

## Repository Structure
### /matlab
- free_vibration.m
- step_excitation.m
- harmonic_excitation.m
### /simulink
- MKC_open_loop.slx
### /figures
- free_response.png
- step_response.png
- harmonic_response.png
- Open_Loop_MKC_System.png

## Results Preview
![Harmonic Force response & Transmissibility](figures/harmonic_response.png)
