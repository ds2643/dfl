/*
 *  module provides template for mutating arbitrary data
 */

module mutationtemplated;

import std.stdio;
import std.random;
import std.traits;
import std.math;
import std.algorithm.iteration;

// PRIMITIVE TYPES

auto mutate(T)(T value){
    // integral and floating point numbers and characters
    if(is(T == bool)) {
        return (uniform(0,2) > 0);
    }
    else if (isIntegral(value))  {
        return cast(T) uniform!T();
    }
    else if (isFloating(value)) {
        // floating points cannot be generated with the uniform template like integral values
        if (is(T == float)) { return cast(T) uniform!uint(); }
        else if (is(T == real)) { return cast(T) uniform!long(); }
        else if (is(T == double)) {return cast(T) uniform!ulong(); }
        // TODO: add logic for complex and imaginary variants
    }
    // TODO: provide catch all case
}

// DERIVED TYPES

auto mutate(T)(T[] value) {
    // array
    auto a = value.dup; // copy for safety TODO: don't make a copy if unnecessary
    int randomIndex = cast(int) uniform(0, a.length);
    a[randomIndex] = mutate!(T)(a[randomIndex]);
    return a;
}

auto mutate(T)(T[T] value) {
    // homogenous association array TODO generalize to heterogenous association array
    auto a = value.dup; // copy to ensure safety TODO: don't make copy if unnecessary
    auto allKeys = a.keys;
    int randomIndex = cast(int) uniform(0, a.length);
    T randomKey = allKeys[randomIndex];
    a[randomKey] = mutate!(T)(randomKey);
    return a;
}

/* TODO extend association list to heterogeny
auto mutate(T, U)(T[U] value) {
    // homogenous association array TODO generalize to heterogenous association array
    auto a = value.dup; // copy to ensure safety TODO: don't make copy if unnecessary
    auto allKeys = a.keys;
    int randomIndex = cast(int) uniform(0, a.length);
    T randomKey = allKeys[randomIndex];
    a[randomKey] = mutate!(T)(randomKey);
    return a;
}
*/

unittest {

}
