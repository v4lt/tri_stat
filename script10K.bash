#!/bin/bash

# Creation du fichier pour les moyennes d'execution
printf "" > "resultat/result10K.txt"

# Creation des fichiers pour les resultats de temps des tri
#for (( j = 1; j < 13; j++ )); do
#  printf "" > resultat/result10K_$j.txt
#done

# Execution du programme 50 fois pour avoir des echantillons de 50 executions dans chaque fichier de data
for (( l = 0; l < 50; l++ )); do

  # Creation des vecteurs contenant 10K valeurs
  ./creer_vecteur -s 10000    > echantillons/data10K.txt

  # Tri des valeurs un nombre different des threads et stockage des temps d'execution dans les fichiers de resultats
  for (( j = 1; j < 13; j++ )); do
    ./tri_threads -p $j -q -s -arg 10000 < echantillons/data10K.txt >> resultat/result10K_$j.txt
  done
done

# Traitement des resultats 
for (( i = 1; i < 13; i++)); do
  for ((j=1; j<8; j++)); do
    # Pour les valeurs positives on calcule les moyennes
    awk -v "col=$j" '{ if($col>0){total +=$col; n++ } } END { printf total/n >> "resultat/result10K.txt" }' resultat/result10K_$i.txt
    if [[ $j<7 ]]; then
      printf " " >> resultat/result10K.txt
    fi
  done
  echo "" >> resultat/result10K.txt
done
