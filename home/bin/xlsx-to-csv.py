#!/usr/bin/env python3
import pandas as pd
import sys
# read the excel file name from arguments
assert len(sys.argv) == 2, "Usage: xlsx-to-csv.py <excel_file>"
xcel_file = sys.argv[1]
df = pd.read_excel(xcel_file)
print(df)
df.to_csv(xcel_file.split('.')[0]+'.csv', index=False)
