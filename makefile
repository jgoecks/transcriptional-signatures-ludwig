DATA_DIRECTORY = .
GENE = CDKN2A
SCALED_DATASET = $(GENE)_scaled_dataset.tsv

# Create scaled dataset.
$(SCALED_DATASET):
	python prepare_data.py "$(DATA_DIRECTORY)/$(GENE)/X_matrix.tsv" "$(DATA_DIRECTORY)/$(GENE)/Y_matrix.tsv" $(SCALED_DATASET)

# Create final configuration file.
$(GENE)_final_config.yaml: create_input_features.py base_config.yaml
	python create_input_features.py "$(DATA_DIRECTORY)/$(GENE)/X_matrix.tsv" $(GENE)_input_features.yaml; cat $(GENE)_input_features.yaml base_config.yaml > $(GENE)_final_config.yaml

# Run a ludwig experiment using the scaled dataset. Results are placed into the $(GENE) directory.
ludwig-experiment: $(GENE)_final_config.yaml $(SCALED_DATASET)
	mkdir -p $(GENE) && pushd $(GENE) && ludwig experiment --dataset ../$(SCALED_DATASET) --config ../$(GENE)_final_config.yaml -rs 456

clean:
	rm $(GENE)_final_config.yaml $(GENE)_scaled_dataset.tsv

