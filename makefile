DATA_DIRECTORY = .
GENE = CDKN2A
SCALED_DATASET = $(GENE)_scaled_dataset.tsv

# Create scaled dataset.
$(SCALED_DATASET):
	python prepare_data.py "$(DATA_DIRECTORY)/$(GENE)/X_matrix.tsv" "$(DATA_DIRECTORY)/$(GENE)/Y_matrix.tsv" $(SCALED_DATASET)

# Create final configuration file.
final_config.yaml: create_input_features.py base_config.yaml
	python create_input_features.py "$(DATA_DIRECTORY)/$(GENE)/X_matrix.tsv" input_features.yaml; cat input_features.yaml base_config.yaml > final_config.yaml

# Run a ludwig experiment using the scaled dataset.
ludwig-experiment: final_config.yaml $(SCALED_DATASET)
	ludwig experiment --dataset $(SCALED_DATASET) --config_file final_config.yaml

clean:
	rm final_config.yaml *_scaled_dataset.tsv

