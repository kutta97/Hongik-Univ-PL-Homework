#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define M 1
const int G = 2;
const int B = 3;

void Randomize(void); // for initialize
int GetComSel(void);
int GetUsrSel(void);
int WhoWin(int a, int b);

int main(void) // start main
{
int com, usr; // delare int
int result;
int win = 0, same = 0;

Randomize();

while (1) // for while loop
{
usr = GetUsrSel();
com = GetComSel();

/* who win?*/
result = WhoWin(com, usr);

if (result == 1)
{
printf("you win \n");
win++;
}
if (result == -1)
{
printf("you lose \n");
break; // loop end
}
if (result == 0)
{
printf("draw \n");
same++;
}
}

printf("result : %d win, %d draw \n", win, same);
/* end main */
return 0;
}

void Randomize(void)
{
// set random by time
srand((int)time(NULL));
}

int GetComSel(void)
{
int sel = rand() % 3 + 1;
if (sel == 1)
{
printf("computer 1, ");
}
if (sel == 2)
{
printf("computer 2 ");
}
if (sel == 3)
{
printf("computer 3 ");
}

return sel;
}

int GetUsrSel(void)
{
int sel;
printf("rock 1, scissor 2, paper 3 : ");
scanf("%d", &sel);

if (sel == 1)
{
printf("you 1 ");
}
if (sel == 2)
{
printf("you 2 ");
}
if (sel == 3)
{
printf("you 3 ");
}

return sel;
}

int WhoWin(int s1, int s2)
{
if (s1 == s2)
{
return 0;
}
if (s1 % 3 == (s2 + 1) % 3)
{
return 1;
}
return -1;
}
