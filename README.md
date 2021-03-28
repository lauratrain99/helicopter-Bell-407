# helicopter-Bell-407
Keep track of the progress made on the Helicopter Class Project for the course Helicopters and other Aicrafts.


Fixed parameters:

- Flight altitude: 15,000 ft
- Mass: 2040 kg
- Rotational speed: 413 rpm
- Radius of the blades: 5.33 m

Nominal analysis, available at *analysis/nominal_analysis.m* :
- Blades: 4
- Constant chord distribution: 0.27 m
- Twist distribution: θ_0 + θ_t * x
    - slope per meter θ_{tw} = - 2 º/m
- NACA 0016 aerodynamic profile: 
    Cl = Cl_α * α
    - Cl_α = 6.05 
    Cd = Cd_0 + K * Cl^2
    - Cd_0 = 0.0076
    - K = 0.3/Cl_α^2

Run script in 