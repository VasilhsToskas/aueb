#include "p3180219-p3180111-pizza2.h"
#include <pthread.h>
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include <time.h>


pthread_mutex_t lock;
pthread_cond_t cond;
pthread_mutex_t lock1;
pthread_cond_t cond1;
pthread_mutex_t lock2;
pthread_cond_t cond2;
int cooks=Ncook;
int ovens=Noven;
int deliverades=Ndeliverer;
struct timespec* tstart;
struct timespec* tend;
struct timespec* krywmastart;
struct timespec* krywmaend;

unsigned int* S;

void *order(void *x){
int id=*(int *)x;
clock_gettime(CLOCK_REALTIME,&(tstart[id-1]));


int rc;
int rc1;
rc=pthread_mutex_lock(&lock);
while(cooks==0){
rc=pthread_cond_wait(&cond,&lock);
}
cooks--;
rc=pthread_mutex_unlock(&lock);



unsigned int kappa;
unsigned int temp= *S*id;
 kappa=rand_r(&(temp));
sleep(Tprep*(kappa%(Torderhigh-Torderlow)+1));
rc1=pthread_mutex_lock(&lock1);
while(ovens==0){
rc1=pthread_cond_wait(&cond1,&lock1);
}
ovens--;
cooks++;
rc = pthread_cond_signal(&cond);
rc1=pthread_mutex_unlock(&lock1);




sleep(Tbake);
clock_gettime(CLOCK_REALTIME,&(krywmastart[id-1]));




rc1 = pthread_mutex_lock(&lock2);
while(deliverades==0){
rc1=pthread_cond_wait(&cond2,&lock2);
}
deliverades--;
ovens++;
rc1= pthread_cond_signal(&cond1);
rc1=pthread_mutex_unlock(&lock2);




temp=temp*id;
 unsigned int keepo=rand_r(&(temp));
sleep(keepo%(Thigh-Tlow)+Tlow);
clock_gettime(CLOCK_REALTIME,&(krywmaend[id-1]));
clock_gettime(CLOCK_REALTIME,&(tend[id-1]));
rc1=pthread_mutex_lock(&lock1);
printf("H paraggelia me arithmo %d paradothhke se %lu lepta kai krywne gia %lu lepta\n",id,tend[id-1].tv_sec-tstart[id-1].tv_sec,krywmaend[id-1].tv_sec-krywmastart[id-1].tv_sec);
rc1=pthread_mutex_unlock(&lock1);
sleep(keepo%(Thigh-Tlow)+Tlow);
deliverades++;
rc1= pthread_cond_signal(&cond2);
pthread_exit(NULL);
}



int main(int argc , const char* argv[]){


if (argc !=3 ){
printf("Wrong number of arguments\n");
exit(0);
}
int rc;
int Ncust=atoi(argv[1]);
unsigned int Seed=atoi(argv[2]);
S=&Seed;
struct timespec s[Ncust];
struct timespec e[Ncust];
struct timespec krywmas[Ncust];
struct timespec krywmae[Ncust];
krywmastart=krywmas;
krywmaend=krywmae;
tstart=s;
tend=e;

pthread_t threads[Ncust];
int id[Ncust];



for (int i=0;i<Ncust;i++){
unsigned int kappa;
unsigned int temp= *S+i+1;
 kappa=rand_r(&(temp));
id[i]=i+1;
rc=pthread_create(&threads[i],NULL,order,&id[i]);
sleep(kappa%(Torderhigh-Torderlow)+1);

if(rc!=0){
printf("ERROR:return code from pthread_create()  is %d\n",rc);
exit(-1);}
}
for (int i=0;i<Ncust;i++){
pthread_join(threads[i],NULL);
}




int max=-1;
double avg;
long int time ;
for (int i=0;i<Ncust;i++){
time=tend[i].tv_sec-tstart[i].tv_sec;
avg+=time;
if (max<time){max=time;}
}


avg=avg/Ncust;
printf("Megistos xronos paradoshs: %d\n",max);
printf("Mesos xronos paradoshs: %.1f \n",avg);

max=-1;
avg=0;
for (int i=0;i<Ncust;i++){
time=krywmae[i].tv_sec-krywmas[i].tv_sec;
avg+=time;
if (max<time){max=time;}
}

avg=avg/Ncust;
printf("Megistos xronos krywmatos: %d\n",max);
printf("Mesos xronos krywmatos: %.1f \n",avg);

pthread_mutex_destroy(&lock);
pthread_cond_destroy(&cond);
return 0;

}

