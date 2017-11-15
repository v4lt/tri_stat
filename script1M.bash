#!/bin/bash

# Programme principal :

# Creation du fichier pour les moyennes d'execution
printf "" > "resultat/result1M.txt"

# Creation des fichiers pour les resultats de temps des tri
#for (( j = 1; j < 13; j++ )); do
#  printf "" > resultat/result1M_$j.txt
#done

# Execution du programme 50 fois pour avoir des echantillons de 50 executions dans chaque fichier de data
for (( l = 0; l < 50; l++ )); do

  # Creation des vecteurs contenant 1M valeurs
  ./creer_vecteur -s 1000000 > echantillons/data1M.txt

  # Tri des valeurs un nombre different des threads et stockage des temps d'execution dans les fichiers de resultats
  for (( j = 1; j < 13; j++ )); do
    ./tri_threads -p $j -q -s -arg 1000000 < echantillons/data1M.txt >> resultat/result1M_$j.txt
  done
done

# Traitement des resultats 
for (( i = 1; i < 13; i++)); do
  for ((j=1; j<8; j++)); do
    # Pour les valeurs positives on calcule les moyennes
    awk -v "col=$j" '{ if($col>0){total +=$col; n++ } } END { printf total/n >> "resultat/result1M.txt" }' resultat/result1M_$i.txt
    if [[ $j<7 ]]; then
      printf " " >> resultat/result1M.txt
    fi
  done
  echo "" >> resultat/result1M.txt
done
