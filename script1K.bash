#!/bin/bash

printf "" > "resultat/result1K.txt"

#for (( j = 1; j < 13; j++ )); do
#  printf "" > resultat/result1K_$j.txt
#done

for (( l = 0; l < 50; l++ )); do
  ./creer_vecteur -s 1000    > echantillons/data1K.txt
  for (( j = 1; j < 13; j++ )); do
    ./tri_threads -p $j -q -s -arg 1000 < echantillons/data1K.txt >> resultat/result1K_$j.txt
  done
done

for (( i = 1; i < 13; i++)); do
  for ((j=1; j<8; j++)); do
    awk -v "col=$j" '{ if($col>0){total +=$col; n++ } } END { printf total/n >> "resultat/result1K.txt" }' resultat/result1K_$i.txt
    if [[ $j<7 ]]; then
      printf " " >> resultat/result1K.txt
    fi
  done
  echo "" >> resultat/result1K.txt
done
