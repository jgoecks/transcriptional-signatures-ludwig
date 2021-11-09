'''
Prepare data for use in Ludwig.
'''

import pandas as pd
import argparse
from sklearn.preprocessing import MinMaxScaler

if __name__ == "__main__":
    # Argument parsing.
    parser = argparse.ArgumentParser()
    parser.add_argument("x_matrix_file", help="X_matrix file")
    parser.add_argument("y_matrix_file", help="Y_matrix file")
    parser.add_argument("output_matrix_file", help="Output matrix file")
    args = parser.parse_args()


    # Read X, y matrics.
    X_df = pd.read_csv(args.x_matrix_file, delimiter="\t", header=0)
    y_df = pd.read_csv(args.y_matrix_file, delimiter="\t", header=0)

    # Set min-max range to [0,1] in X matrix and write out combined matrix.
    scaler = MinMaxScaler()
    X_df_genes = X_df.drop('SAMPLE_BARCODE', axis=1)
    scaled_X_df_genes = pd.DataFrame(scaler.fit_transform(X_df_genes), columns = X_df_genes.columns)
    concat_df = pd.concat([scaled_X_df_genes, y_df], axis=1, join="inner")
    concat_df.to_csv(args.output_matrix_file, sep="\t", index=False)

