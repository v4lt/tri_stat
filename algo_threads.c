#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/time.h>

#include "algo_principal.h"
#include "appels_sequentiels.h"

void *comportement_thread(void *arg) {
    traitement((arguments_t *) arg);
    pthread_exit(NULL);
}

void algo_principal(int parallelism, int *tableau, int taille, char *arg, int stat)
{
    arguments_t *arguments;
    pthread_t *tids;
    int inf, sup;
    int erreur, i;
    void *status, *args_algo;

    struct timeval debut_programme;
    gettimeofday(&debut_programme, NULL);
    args_algo = initialisation(parallelism, tableau, taille, arg);

    tids = malloc(parallelism*sizeof(pthread_t));
    arguments = malloc(parallelism*sizeof(arguments_t));
    if ((tids == NULL) || (arguments == NULL)) {
        fprintf(stderr, "Impossible d'allouer les structures de gestion des "
                        "threads\n");
        exit(1);
    }

    inf = 0;
    sup = (taille-1) / parallelism;

    struct timeval creation_threads;
    gettimeofday(&creation_threads, NULL);
    for (i=0; i<parallelism; i++) {
        arguments[i].num = i;
        arguments[i].inf = inf;
        arguments[i].sup = sup;
        arguments[i].tableau = tableau;
        arguments[i].taille = taille;
        arguments[i].args_algo = args_algo;

        erreur = pthread_create(&tids[i], NULL, comportement_thread,
                                &arguments[i]);
        if (erreur != 0) {
            fprintf(stderr, "Erreur de creation du thread %d\n", i);
            exit(1);
        }
        inf = sup+1;
        sup = ((i+2)*(taille-1)) / parallelism;
    }

    struct timeval fin_creation_threads;
    gettimeofday(&fin_creation_threads, NULL);

    for (i=0; i<parallelism; i++)
         pthread_join(tids[i], &status);

    struct timeval tri_des_resultats;
    gettimeofday(&tri_des_resultats, NULL) ;
    traitement_resultats(parallelism, arguments);
    struct timeval fin_tri_des_resultats;
    gettimeofday(&fin_tri_des_resultats, NULL) ;

    free(arguments);
    free(tids);

    struct timeval fin_programme;
    gettimeofday(&fin_programme, NULL);

    double diff_debut_prog_creation_threads = creation_threads.tv_usec - debut_programme.tv_usec;
    double diff_creation_threads = fin_creation_threads.tv_usec - creation_threads.tv_usec;
    double diff_wait_end_of_threads = tri_des_resultats.tv_usec - fin_creation_threads.tv_usec;
    double diff_tri_resultats = fin_tri_des_resultats.tv_usec - tri_des_resultats.tv_usec;
    double diff_temps_destr_threads = fin_programme.tv_usec - fin_tri_des_resultats.tv_usec;
    double diff_temps_programme = fin_programme.tv_usec - debut_programme.tv_usec;
    if(stat)
    {
      printf("%d%s", parallelism, " " ); //Nombre thread
      //printf("%d%s", taille, " " ); //Taille vecteur
      printf("%lf%s", diff_debut_prog_creation_threads, " " );
      printf("%lf%s", diff_creation_threads, " ");
      printf("%lf%s", diff_wait_end_of_threads, " ");
      printf("%lf%s", diff_tri_resultats, " ");
      printf("%lf%s", diff_temps_destr_threads, " ");
      printf("%lf\n", diff_temps_programme);
    }
    else
    {
      printf("Temps entre le deb du prog et la creation des threads : %lf microseconde(s)\n", diff_debut_prog_creation_threads);
      printf("Temps pris par la creation des threads : %lf microseconde(s)\n", diff_creation_threads);
      printf("Temps pris par l'attente de la syncro : %lf microseconde(s)\n", diff_wait_end_of_threads);
      printf("Temps pris pour le tri des valeurs : %lf microseconde(s)\n", diff_tri_resultats);
      printf("Temps pris pour la destruction des threads : %lf microseconde(s)\n", diff_temps_destr_threads);
      printf("Temps pris pour le programme : %lf microseconde(s)\n", diff_temps_programme);
    }
}
