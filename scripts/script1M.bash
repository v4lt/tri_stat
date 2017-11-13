#!/bin/bash

echo -n '' > resultat/result1M.txt


for (( l = 0; l < 50; l++ )); do
  ./creer_vecteur -s 1000000    > echantillons/data1M.txt
  for (( j = 1; j < 13; j++ )); do
    ./tri_threads -p $j -q -s -arg 1000000 < echantillons/data1M.txt >> resultat/result1M.txt
  done
done
