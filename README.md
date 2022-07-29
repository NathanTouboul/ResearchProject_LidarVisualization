# Research Project: Navigation Integrity of Autonomous Vehicle with Lidar-based localization 


For a quick overview of this project, you can find a slide presentation [here](documents/project_presentation.pdf).

This project revolves around the Lidar-based localization of autonomous vehicles. The goal is to ensure navigation integrity and safety in an area with low GNSS availability (Chicago downtown here). So, a Velodyne’s Puck lidar sensor is used to compensate for IMU drift. 

<p align=center>
<img src=documents/diagram_state_street.JPG height=150>
<img src=documents/velodyne.JPG height=150>
</p>
<p align=center>
<em>Chicago State Street and Velodyne's Lidar</em>
</p>

<p align=center>
<img src=documents/complexity_localization.JPG height=150>
</p>
<p align=center>
<em>The complexity of landmark detection and identification</em>
</p>


The interesting twist in this project is the use of the Error Correction Codes domain to ensure landmark identification against the misassociation problem (basically we want to identify which object, trees in this case, was detected). I researched the implementation of  Hamming and BCH codes for this objective.


<p align=center>
<img src=documents/code_based_localization.JPG height=150>
</p>
<p align=center>
<em>Code Based Localization</em>
</p>

I established a Misdetection Error Model to quantify the Probability of Hazardously Misleading Information. I also was able to derive precise σ and 3σ probabilities of tree misdetection, considering the noise parameters of the vehicle, the sensor, and the landmarks. You can find all the code for the calculation and the visualization in this repo.


<p align=center>
<img src=documents/3_sigma_tree.jpg height=150>
<img src=documents/trapz_sections.jpg  height=150>
</p>
<p align=center>
<em>Sections of detection depending on the probability of detection </em>
</p>





