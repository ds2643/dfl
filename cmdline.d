module cmdline;
import mutation;
import std.stdio;
import std.process;

void monitorSerial(int iterations, string execPath, string arg0) {
    // TODO: add support for variadic arguments
    // TODO: test with simple inputs
    // TODO: break into functions
    int counter = 0;
    string[] cmdInput = [];
    cmdInput ~= execPath;
    cmdInput ~= arg0;
    while (iterations > counter) {
        auto logFile = File("errors.log", "w");
        auto pid = spawnProcess(cmdInput,
                                std.stdio.stdin,
                                std.stdio.stdout,
                                logFile);
        auto status = wait(pid);
        if (status != 0) {
            writeln("process with input ", arg0, "failed!");
        } else {
            writeln("process with input ", arg0, "succeeded!");
        }
        logFile.writeln(counter, ", ", arg0, ", ", status);
        logFile.close();
        // TODO: save logFile result in some data structure
    }
}

/*
   void monitorParallel {
        // TODO: likely requires intermediate reprepresentation
        string[string] results; // TODO: map well-formed inputs to exit code
        // TODO: use std.parallelism
}
*/

unittest {
    // TODO: write unit tests not dependent on the availability of executables
}
