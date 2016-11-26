module clmonitor;
// interface for fuzzing commandline executables

import std.parallelism;

/*
* GOALS
* 1. create parallelized interface
* 2. generalize with configurable interface (DSL) that's program specific and manually specified by the user
   */

void monitor(int n) {
    foreach (i; n) {
        // child processes spawned, scaled in waves the size of pool
    }
}
