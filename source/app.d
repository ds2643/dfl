// project entry point

import std.stdio;
import mutation;

void monitor(){
    // monitor program for failure
}

void watchNRuns(int n, int f, int a) {
    // subject the specified function to n cummulative mutations
    // prototype for template that allows for ? return type and multiple, variable arity
    for (int i = 0; i < n; ++i) {
        // mutate argument
        // monitor process
    }
    // return monitor result
}

void attemptNRuns (int n, int, f, int a, string target) {
    // run against command line application n times
    // loop
    // watch for failures
}

// commandline interface

void main(){
    // ..
}
