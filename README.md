# AEM-3103-Final-Project-2024
This is the final project for the class AEM 3103 at the U of M, Twin Cities. This project was assigned to my team during the Spring 2024 Semester.

# Paper Airplane Numerical Study
Final Project: AEM 3103 Spring 2024

- By: Lani Calderon, Keenan Raby, Justin Lancisi
  
## Summary of Findings

When varying the velocities and gammas the impact on the range was indentified. Looking at the plotted data below, it was determined that the maximum values yielded the best range
possible for velocity compared to the minimum values. However, for the gamma plots, the nominal value was ideal compared to both the maximums and minimums. The nominal values are presumed to be the ideal for the paper airplane's flight.  
Reference the figures below as needed.

| Values  | Velocity    | Gamma  | 
| :-----: | :---------: | :----: | 
| Minimum |   2 m/s     | -0.5   |
| Nominal |  3.55 m/s   | -0.18  |
| Maximum |  7.5 m/s    |  0.4   |

We successfully implemented several numerical methods to analyze the flight performance of a paper airplane under different parameters and were able to study how the affected the overall glide characteristics


# Code Listing

[EqMotion](EqMotion.m)

This function solves for xdot based on the global variables of the given parameters for our scenario.

[PaperPlane](PaperPlane.m)

This is the main script that runs all of the graphing and computation needed for the project.

# Figures

## Fig. 1: Single Parameter Variation
![Alternative Text](./Figures/Parameters.png)

This figure compares the 2d trajectories of different velocities and different flight path angles and how they vary the height and range when you stray from nominal values (black lines).


## Fig. 2: Monte Carlo Simulation
![Alternative Text](./Figures/MonteCarlo.png)
![Alternative Text](./Figures/curvefit.png)

The MonteCarlo graph shows the resulting glide from 100 different iterations of random parameters from which you can visually extract the general behavior of the system under different conditions. 
Using the data obtained from the graph, an average was identified and was plotted with polyfit and polyval leading to the construction of fifth order polynomial slope showcasing the linearity of both Height and Range with respect to time. Range increases with time whereas height decreased with it. 

## Fig. 3: Time Derivatives
![Alternative Text](./Figures/derivatives.png)

This figure shows the time-derivative of both the height and range as a function of time, which is based on the Figure one curve fitting from the Monte Carlo Simulation.


## Graphical Animation
 ![2D Paper Airplane Flight Trajectory](./Figures/glider_trajectory.gif)

The animated GIF above shows the 2D trajectory with the found nominal values, as well as the scenario where V=7.5 m/s and Gam=+0.4 rad). The moving point depicts a 2D drawing of an airplane, drawn using SolidWorks.
