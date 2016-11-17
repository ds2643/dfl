**Note: This an an incomplete repository. This project is currently in a research phase. Please watch and check back later for updates.**

# dfl
A blackbox fuzz test tool.

Unit tests serve the purpose of verifying a function's behavior. However, unit tests often provide a false sense of security by covering only a small subset of functions' domains. At best, unit tests cover perceived edge cases, like null values, along with some arbitrarily selected inputs. Fuzz testing seeks to eliminate this bias through randomly sampling the domain of a function in an automated manner. While automation makes verification of *proper* behavior difficult and impractical, screening for *improper* behavior in the form of errors, crashes, and haltings is certainly possible. Thus, fuzz testing provides an additional layer of verification over typical unit tests initialized with arbitrary values.

Fuzz testing has existed for decades, with many variants available (e.g., whitebox, blackbox, etc.). This project seeks to provide a simple blackbox option written in the D systems language targeting projects written in the same language.

# Approach

For each function to be tested, the user provides a set of example inputs, which are then iteratively mutated. The mutated inputs are run through the function under observation for the occurance of unexpected behavior, like a crash.

At the heart of this project is the following challenge: How data of arbitrary type (user defined, standard, or derived) may be mutated in an unbiased, stochastic manner in a way that is guarenteed to sample the entire domain of possible values for that type.

In the simple case of function taking an integer as its single argument, the function behavior is monitored while fed a random sampling of all possible 32-bit integers.

# Current Standing

This project is under active development. The following points detail the roadmap for the project's near future:
1. Implement mutation function for floats. Is it possible to sample a domain of all possible floating point numbers?
2. Trickle up typing: If user defined or complex types are abstractions composed of primitive types, is a general algorithm possible that maintains the structural integrity of such a container while validly mutating its contents?
3. Ongoing building of tests as gross units of the tool are prototyped.
