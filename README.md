**Note: This an an incomplete repository. This project is currently in a research phase. Please watch and check back later for updates.**

# dfl
A blackbox fuzz test tool.

Unit tests serve the purpose of verifying a function's behavior. However, unit tests often provide a false sense of security by covering only a small subset of functions' domains. At best, unit tests cover perceived edge cases, like null values, along with some arbitrarily selected inputs. Fuzz testing seeks to eliminate this bias through randomly sampling the domain of a function in an automated manner. While automation makes verification of *proper* behavior difficult and impractical, screening for *improper* behavior in the form of errors, crashes, and haltings is certainly possible. Thus, fuzz testing provides an additional layer of verification over typical unit tests initialized with arbitrary values.

Fuzz testing has existed for decades, with many variants available (e.g., whitebox, blackbox, etc.). This project seeks to provide a simple blackbox option written in the D systems language targeting projects written in the same language.

## Approach
For each function to be tested, the user provides a set of example inputs, which are then iteratively mutated. The mutated inputs are run through the function under observation for the occurance of unexpected behavior, like a crash.

At the heart of this project is the following challenge: How data of arbitrary type (user defined, standard, or derived) may be mutated in an unbiased, stochastic manner in a way that is guarenteed to sample the entire domain of possible values for that type.

In the simple case of function taking an integer as its single argument, the function behavior is monitored while fed a random sampling of all possible 32-bit integers.

## Directions
The central to the tool is a mutation template for randomly mutating data of both primitive and derived types. This tool might be applied with several front ends. Firstly, a simple command line fuzzer with the appropriate domain specific language interface (for specifying a well formed input) might leverage independence of trial runs to run waves of parallelized processes. Secondly, a unit test framework might leverage a domain specific language of decorators to gtenerate test cases in an automated manner. Lastly, a genetic algorithm could be build over these two that leaves a simple parallel model for message passing concurrency as a feedback loop is built. This final approach requires some cost function to be specifed (e.g., what constitutes program failure?).

## Current Standing
This project is under active development. The following points detail the roadmap for the project's near future:
1. fix support for chars in mutation template 2. deploy commandline interface, genetic algorithm for feedback, and metaprogramming unit test generator
