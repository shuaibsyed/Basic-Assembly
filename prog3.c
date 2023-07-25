#include <stdio.h>

/* (c) Larry Herman, 2023.  You are allowed to use this code yourself, but
   not to provide it to anyone else. */

int number= 0;
int base= 0;
int result= 0;

static int num_digits(int n, int base);

int main(void) {
  scanf("%d", &number);
  scanf("%d", &base);

  result= num_digits(number, base);

  printf("%d\n", result);

  return 0;
}

static int num_digits(int n, int base) {
  int ans;

  ans= 0;

  if (base <= 0)
    ans= -1;
  else {
    if (n < 0)
      n= -n;

    if (base == 1)
      ans= n;
    else
      if (n < base)
        ans= 1;
      else ans= 1 + num_digits(n / base, base);
  }

  return ans;
}
