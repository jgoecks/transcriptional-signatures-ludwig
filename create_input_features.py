'''
Create input features YAML for Ludwig configuration.
'''

import yaml
import argparse
import pandas as pd


if __name__ == "__main__":
    # Argument parsing.
    parser = argparse.ArgumentParser()
    parser.add_argument("input_file", help="Input file")
    parser.add_argument("output_file", help="Output file")
    args = parser.parse_args()

    # Read features from input.
    feature_names = pd.read_csv(args.input_file, delimiter="\t", header=0, nrows=0).columns.tolist()

    # Define inputs.
    inputs = [{"name": c, "type": "numerical"} for c in feature_names[1:-1]]
    config = {
        "input_features": inputs
    }
    
    # Write config.
    with open(args.output_file, "w") as output_file:
        yaml.dump(config, output_file)    



