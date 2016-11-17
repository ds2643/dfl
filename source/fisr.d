module fisr;

import std.stdio;

float fisr(float n) {
    // in good code style, move these initializations locally to their point of use
    float x2 = n * 0.5F;
    float y = n;
    float threeHalves = 1.5F;
    long i = * cast(long*) &y;
    i = 0x5f3759df - ( i >> 1 );
    y = * cast(float*) &i;
    y = y * (1.5F - (x2 * y * y));
    return y;
}

void main() {
    write("n? ");
    float n;
    readf(" %s", &n);
    float result = fisr(n); // auto?
    writeln("Fast inverse square root of ", n, " is ", result);
}
