# Inductor-Design-Using-Neural-Network
_**ABSTRACT:** Due to evolution of the modern industry, systems are becoming more complex, and hence engineering design process has become a complex task, and hence the idea of a design assistant that can predict design variables based on knowledge base is required. In the given report, the documentation of the design project for the development of the C-core Inductor is presented which is based on the knowledge base. Our team goal was to design the Neural Network (NN) which can give the dimensions and other important parameters for the Inductor Design, according to the user requirements. The inputs and outputs of the NN are kept fixed, and the inputs to the NN will be from JESS system, and output of the NN which are the dimensions and other important parameters of the design is returned to the JESS for the constraint and the user satisfaction._

# User Manual
To begin with, first, we need to create the dataset for the training of the NN, so let us see how it can be done, so for that the file named as Data_gen.m is used for the creation of the dataset.
1) Data_gen.m
In this code, N_ex variable is used to fix the number of data examples to generate for the training and the testing of the NN. You can vary it according to the number of datasets you want. Later, some constant values are defined, and then the random generator of the various parameters are defined. In the next section, the data is created where the while loop is there which is calling functions given in the code which is used to calculate the Inductance. And there also we have for loop for deciding the area of the winding based on the current capacity. Later in the code the data is stored in the csv files. At last, the functions are defined which are self-explanatory.
2) NN.m
In this code the training and the testing of the NN. First, the data is read to the variables, then there is training of the network. The data is divided into the 40/30/30 ratio for the training, validating and the testing of the NN. We can locally store the trained model into local drive which we had done, and it is named as c_core_net_Final.mat.
3) NN_JESS.m
In this code the stored NN is loaded back here to test it on the inputs which will be provided by JESS as their output. Here as the TEAM-1 defined the inductance as fixed to mH unit, and our NN is trained based on the MLT system, so we need to convert it to the MLT, so we used the multiplier for that. And the outputs of NN are just stored back in the csv file which will be assessed back by the JESS for satisfaction.

# System Design Flow
          ![image](https://user-images.githubusercontent.com/49090662/115591917-a3b5cd80-a2a0-11eb-90e2-1a7be8a1416b.png)
