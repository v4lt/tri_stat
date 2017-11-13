#!/bin/bash
printf "" > "resultat/result100K.txt"

#for (( j = 1; j < 13; j++ )); do
#  printf "" > resultat/result100K_$j.txt
#done

for (( l = 0; l < 50; l++ )); do
  ./creer_vecteur -s 100000    > echantillons/data100K.txt
  for (( j = 1; j < 13; j++ )); do
    ./tri_threads -p $j -q -s -arg 100000 < echantillons/data100K.txt >> resultat/result100K_$j.txt
  done
done

for (( i = 1; i < 13; i++)); do
  for ((j=1; j<8; j++)); do
    awk -v "col=$j" '{ if($col>0){total +=$col; n++ } } END { printf total/n >> "resultat/result100K.txt" }' resultat/result100K_$i.txt
    if [[ $j<7 ]]; then
      printf " " >> resultat/result100K.txt
    fi
  done
  echo "" >> resultat/result100K.txt
done
