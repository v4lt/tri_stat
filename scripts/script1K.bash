#!/bin/bash

echo -n '' > resultat/result1K.txt


for (( l = 0; l < 50; l++ )); do
  ./creer_vecteur -s 1000    > echantillons/data1K.txt
  for (( j = 1; j < 13; j++ )); do
    ./tri_threads -p $j -q -s -arg 1000 < echantillons/data1K.txt >> resultat/result1K.txt
  done
done
