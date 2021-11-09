# Steps for running a Ludwig experiment:

1. Copy or link X,y matrices to `<GENE>/` in this direcotry
1. Run Ludwig experiment: `make ludwig-experiment GENE=<GENE>` This will (1) create the needed configuration file for Ludwig; (2) prepare the data for the experiment by scaling it and combining the X and Y matrices; (3) run Ludwig on the prepared data using the configuration file.