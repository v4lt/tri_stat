#!/bin/bash

echo -n '' > resultat/result100K.txt


for (( l = 0; l < 50; l++ )); do
  ./creer_vecteur -s 100000    > echantillons/data100K.txt
  for (( j = 1; j < 13; j++ )); do
    ./tri_threads -p $j -q -s -arg 100000 < echantillons/data100K.txt >> resultat/result100K.txt
  done
done
