# state_estimation-smartgrid

## State Estimation
This repo contains the code and relevant data for the state estimation work done by the smart grid research group at DEEE UOP. 

Research students: [Chaminda Bandara](https://scholar.google.com/citations?user=WwLxOJYAAAAJ&hl=en), [Dilini Almeida](https://scholar.google.com/citations?user=dzzvaeQAAAAJ&hl=en)<br>
Supervisors: [Prof J.B Ekanayake](http://eng.pdn.ac.lk/deee/academic-staff/prof.jb.ekanayake/index.html#home), [Dr. Roshan Godaliyadda](http://eng.pdn.ac.lk/deee/staff/academic/dr.gmri.godaliyadda/profile.php), [Dr. Parakrama Ekanayake](http://eng.pdn.ac.lk/deee/staff/academic/dr.mpb.ekanayake/profile.php)

You can find the published paper [here](https://www.sciencedirect.com/science/article/abs/pii/S0142061519336518). Please email authors(or smart grid team) if you are unable to access the full paper. <br>

## Description of research work

The work focuses on the problem of state estimation in the smart grid context. The main contributions of the paper are:
- An accurate reduction technique of the 3 phase 4 wire system.
  - The popularly used Kron's reduction assumes a zero neutral current which could be not the case (which is most often) due to unbalance in the system. Here, the neutral current is also taken into account for the reduced matrix. The work also shows that the novel reduction reduces to the Kron's reduction in the case of a zero neutral current. 
- An efficient Low Voltage-Linear State Estimation (LV-LSE) algorithm.
  - The LV-LSE algorithm aims to estimate the states of the network (ie:voltages) when the states of the network are not completely known. The algorithm is shown to work with as low as 60% smart meter data from the network. 

The results analyse the algorithm effectiveness also in the case of erroneous data by comparing the performance for varying degrees of errors in smart meter data. It also evaluates the algorithm for varying smart meter data loss rates to prove its effectiveness. 

## The network used in the research
The research findings are validated by simulating on an actual existing network in [Dehiwala, Sri Lanka](https://www.google.com/maps/place/Lotus+Grove/@6.8453557,79.8783252,15z/data=!4m5!3m4!1s0x0:0xa5e9d2a4922d6c45!8m2!3d6.8453557!4d79.8783252). The netowrk is called the Lotus Grove network- which is the name of the region. The schematic of the network is shown below.

<img src="Lotus Grove.png" alt="Lotus Grove" width="750" height="600"/>
<!-- ![random](<https://github.com/eepdnaclk/state_estimation-smartgrid/blob/main/Lotus Grove.png> "Lotus Grove Network") -->


## Running the code

The main script to run is *Error_with_length.m*<br>
This runs the state estimation algorithm and compares the performance by varying lengths of the network. The performance is compared against the State-of-the-art(SOTA) reduction technique *Kron_reduc.m*.
Do explore the others. 
