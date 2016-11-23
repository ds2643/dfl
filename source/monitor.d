// monitor process to keep track of abnormal behavior

module monitor;

import core.stdc.signal; // signal.h
import core.thread; // run batch of processes

/*
* AIM: run each instance of the unit tests as a thread. save outcomes in association list.
* 1. leverage D's multithreading capabilities
* 2. converge on writing to a single data structure
* 3. outcome data measures signals of signal.h
*/
