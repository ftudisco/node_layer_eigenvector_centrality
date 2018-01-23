Matlab codes used to implement and test the power iteration for 3rd order tensors described in the paper

		"Node and layer eigenvector centralities for multiplex networks" 

by F. Arrigo, A. Gautier, and F. Tudisco. 

To run, the codes require the toolbox "tprod" by Jason Farquhar available at:
https://uk.mathworks.com/matlabcentral/fileexchange/16275-tprod-arbitary-tensor-products-between-n-d-arrays#functions_tab

The folder contains:
PowerT2.m        - function implementing the power method described in the manuscript.
nozerolayer.m    - function that removes empty layers from a 3rd order tensor
isim_new.m       - function that computes the intersection similarity between two ranking vectors 
		   (thanks to Christine Klymko for a previous version of this code)
eig_each_layer.m - function that computes the eigenvector associated to the leading eigenvalue of the adjacency matrix of each layer

script_vary_ab.m - SCRIPT requiring input variable "Atensor" containing the 3rd order tensor. 
		   It display spaghetti plots showing the evolution of the rankings as the parameters vary
fig_scatter1.m   - SCRIPT requiring input variable "Atensor" containing the 3rd order tensor.
		   It returns a figure containing the scatter plot between any two of the measures listed in the paper
fig_isim1.m      - SCRIPT requiring input variable "Atensor" containing the 3rd order tensor.
 		   It returns a figure containing the plot of the evolution of the intersection similarity between the 
		   proposed f-eigenvector centrality measure for nodes and the other measures tested in the reference paper.

Last modified: 07/04/17 by Francesca Arrigo 

>> Reference:
>> "Node and layer eigenvector centralities for multiplex networks", (submitted)
>>  F. Arrigo (http://arrigofrancesca.wixsite.com/farrigo), 
>>  A. Gautier (http://www.ml.uni-saarland.de/people/gautier.htm), and 
>>  F. Tudisco (http://personal.strath.ac.uk/f.tudisco) 


