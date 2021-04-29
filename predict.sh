#!/bin/sh

# expected to be used as follows:
# predict.sh [pred_data_set]

printf "doing pre-processing\n"

cat $1 | tr ";" "," > commas.csv

python2 csv2libsvm.py commas.csv libsvm.txt 11 True

printf "done with pre-processing\n"

python3 validation.py libsvm.txt
