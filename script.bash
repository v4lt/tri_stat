#!/bin/bash

echo -n '' > resultat/result.txt

for (( i = 0; i < 10; i++ )); do
  ./creer_vecteur > echantillons/data$i.txt
done

for (( i = 0; i < 10; i++ )); do
  ./tri_threads -p 4 -q -s -arg 1000 < echantillons/data$i.txt >> resultat/result.txt
done
