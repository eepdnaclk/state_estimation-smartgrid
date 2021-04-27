# state_estimation-smartgrid

This repo contains the code and relevant data for the state estimation work done by the smart grid research group at DEEE UOP. 

Research students: [Chaminda Bandara](https://scholar.google.com/citations?user=WwLxOJYAAAAJ&hl=en), [Dilini Almeida](https://scholar.google.com/citations?user=dzzvaeQAAAAJ&hl=en)<br>
Supervisors: Prof J.B Ekanayake, Dr. Roshan Godaliyadda, Dr. Parakrama Ekanayake

You can find the published paper [here](https://www.sciencedirect.com/science/article/abs/pii/S0142061519336518). Please email authors(or smart grid team) if you are unable to access the full paper. <br>
***As last resort** email to [Jameel Hassan (SG team)](mailto:jameel.hassan.2014.eng.pdn.ac.lk) or [Umar Marikkar (SG team)](mailto:umar.m.eng.pdn.ac.lk).*

## Description of research work

The work focuses on the problem of state estimation in the smart grid context. The main contributions of the paper are:
- An accurate reduction technique of the 3 phase 4 wire system.
  - The popularly used Kron's reduction assumes a zero neutral current which could be not the case (which is most often) due to unbalance in the system. Here, the neutral current is also taken into account for the reduced matrix. The work also shows that the novel reduction reduces to the Kron's reduction in the case of a zero neutral current. 
- An efficient Low Voltage-Linear State Estimation (LV-LSE) algorithm.
  - The LV-LSE algorithm aims to estimate the states of the network (ie:voltages) when the states of the network are not completely known. The algorithm is shown to work with as low as 60% smart meter data from the network. 

The results analyse the algorithm effectiveness also in the case of erroneous data by comparing the performance for varying degrees of errors in smart meter data. It also evaluates the algorithm for varying smart meter data loss rates to prove its effectiveness. 
