#! /usr/bin/env python3

"""
This script is used to get the tea substitution matrix path from the tea package
and copy it to the Data directory.
"""

import shutil
from pathlib import Path
from tea import get_matrix_path

# Get the matrix path from the tea package
matcha_path = get_matrix_path()
print(f"TEA substitution matrix path: {matcha_path}")

# Copy the matrix file to the Data directory
output_dir = Path(__file__).parent.parent / "Data"
output_path = output_dir / "matcha.out"
shutil.copy(matcha_path, output_path)
print(f"Copied to: {output_path}")
