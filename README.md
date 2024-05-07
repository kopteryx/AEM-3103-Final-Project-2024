# AEM-3103-Final-Project-2024
This is the final project for the class AEM 3103 at the U of M, Twin Cities. This project was assigned to my team during the Spring 2024 Semester.

# Paper Airplane Numerical Study
Final Project: AEM 3103 Spring 2024

- By: Lani Calderon, Keenan Raby, Justin Lancisi
  
## Summary of Findings

When varying the velocities and gammas the impact on the range was identified. Looking at the plotted data below, it was determined that the maximum values yielded the best range
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

This function solves for xdot based on the global variables of the given parameters for our scenario based on the fourth-order equations of motion associated with the paper airplane in our experiment.

[PaperPlane](PaperPlane.m)

This is the main script that runs all of the graphing and computation needed for the project including the eqMotion.m script. It outputs 4 graphs each time it is run with new random values.

# Figures

## Fig. 1: Single Parameter Variation
![Alternative Text](./Figures/Parameters.png)

This figure compares the 2D trajectories of different velocities and different flight path angles, where only one variable is changed each time. This then displays how these changes vary both the height and range when you stray from the nominal values that were found (black lines). 44

Utilizing both the ode23 (runge-kutta method of numerical analysis) and the called-upon EqMotion.m function, the height vs range graphs were constructed by feeding the ode23 and EqMotion the varying gammas and velocities and the constants (range, height, and time) and extracting the range and height components of the ode function to graph against each other.


## Fig. 2: Monte Carlo Simulation
![Alternative Text](./Figures/MonteCarlo.png)
![Alternative Text](./Figures/curvefit.png)

The MonteCarlo graph shows the resulting glide from 100 different iterations of random parameters from which you can visually extract the general behavior of the system under different conditions. 

Using the data obtained from the graph, an average was identified and was plotted with polyfit and polyval leading to the construction of fifth-order polynomial slope showcasing the linearity of both height and range with respect to time. Range increases with time whereas height decreases with it. 

While calculating and plotting the lines of the MonteCarlo, the sums of the ranges, heights, and time were recorded, being divided by the total iterations (in our case, 100) to supply us with an average for the 3 components. By using polyfit to extract a 5th order polynomial of the range and height plugging it into the polyval function evaluating the polynomial at each time interval. Plotting the polyval of height and range vs time produced beautiful linear graphs.

## Fig. 3: Time Derivatives
![Alternative Text](./Figures/derivatives.png)

This figure shows the time-derivative of both the height and range as a function of time, which is based on the Figure one curve fitting from the Monte Carlo Simulation.
The process of obtaining and graphing the time derivatives vs time was done through the built-in derivative approximation function, diff. Taking the 'diff' of both the polyval of range and height dividing it by the diff of time produces drdt (the derivative of range with respect to time) and dhdt (the derivative of height with respect to time). These values will be plotted against time to create the drdt and dhdt vs time.


## Graphical Animation
 ![2D Paper Airplane Flight Trajectory](./Figures/glider_trajectory.gif)

The animated GIF above shows the 2D trajectory with the found nominal values, as well as the scenario where V=7.5 m/s and Gam=+0.4 rad. The moving point depicts a 2D drawing of the glider used to collect the data, designed using SolidWorks.
