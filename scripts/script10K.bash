#!/bin/bash

echo -n '' > resultat/result10K.txt


for (( l = 0; l < 50; l++ )); do
  ./creer_vecteur -s 10000    > echantillons/data10K.txt
  for (( j = 1; j < 13; j++ )); do
    ./tri_threads -p $j -q -s -arg 10000 < echantillons/data10K.txt >> resultat/result10K.txt
  done
done
