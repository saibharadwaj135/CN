#include<stdio.h>
#include<stdlib.h>
void main(){
	int i,n,r,a;
	printf("\n Enter the no.of packets");
	scanf("%d",&n);
	for(i=0;i<n;i++)
	{
		printf("\n packet sent is %d",i);
		r=rand()%2;
		if(r==1)
		{
			a=rand()%2;
			if(a==1){
				printf("\n Ack number :%d",i+1);
			}else{
				printf("\n No Ack number :%d",i+1);
			}
		}else{
			printf("\n time out resend");
			i--;
		}
	}
}
