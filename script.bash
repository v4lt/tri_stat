#!/bin/bash

echo -n '' > resultat/result1K.txt
echo -n '' > resultat/result10K.txt
echo -n '' > resultat/result100K.txt
echo -n '' > resultat/result1M.txt

./creer_vecteur -s 1000    > echantillons/data1K.txt
./creer_vecteur -s 10000   > echantillons/data10K.txt
./creer_vecteur -s 100000  > echantillons/data100K.txt
./creer_vecteur -s 1000000 > echantillons/data1M.txt

for (( i = 0; i < 4; i++ )); do
  for (( j = 1; j < 13; j++ )); do
    if [[ $i -eq 0 ]]; then
      ./tri_threads -p $j -q -s -arg 1000 < echantillons/data1K.txt >> resultat/result1K.txt
    fi
    if [[ $i -eq 1 ]]; then
      ./tri_threads -p $j -q -s -arg 10000 < echantillons/data10K.txt >> resultat/result10K.txt
    fi
    if [[ $i -eq 2 ]]; then
      ./tri_threads -p $j -q -s -arg 100000 < echantillons/data100K.txt >> resultat/result100K.txt
    fi
    if [[ $i -eq 3 ]]; then
      ./tri_threads -p $j -q -s -arg 1000000 < echantillons/data1M.txt >> resultat/result1M.txt
    fi
  done
done
