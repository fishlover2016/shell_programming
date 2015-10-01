#!/bin/sh
ps aux|awk '{print $1" "$2" "$8}'|sed '1d'|sort -t ' ' -k1,1 -k3,3 -k2,2n|awk 'BEGIN{k=0}{a[k]=$1;b[k]=$2;c[k]=$3;k++;}END{for(i=0;i<k;i++){if(i==0){printf("%s\n\t%s ( %s",a[i],c[i],b[i]);}else if(a[i]==a[i-1]){if(c[i]==c[i-1]){printf(" %s",b[i]);}else{printf(" )\n\t%s ( %s",c[i],b[i]);}}else{printf(" )\n%s\n\t%s ( %s",a[i],c[i],b[i]);}if(i==k-1)printf(" )\n");}}'
