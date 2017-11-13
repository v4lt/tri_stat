#!/bin/bash

printf "" > "resultat/result10K.txt"

#for (( j = 1; j < 13; j++ )); do
#  printf "" > resultat/result10K_$j.txt
#done

for (( l = 0; l < 50; l++ )); do
  ./creer_vecteur -s 10000    > echantillons/data10K.txt
  for (( j = 1; j < 13; j++ )); do
    ./tri_threads -p $j -q -s -arg 10000 < echantillons/data10K.txt >> resultat/result10K_$j.txt
  done
done

for (( i = 1; i < 13; i++)); do
  for ((j=1; j<8; j++)); do
    awk -v "col=$j" '{ if($col>0){total +=$col; n++ } } END { printf total/n >> "resultat/result10K.txt" }' resultat/result10K_$i.txt
    if [[ $j<7 ]]; then
      printf " " >> resultat/result10K.txt
    fi
  done
  echo "" >> resultat/result10K.txt
done
