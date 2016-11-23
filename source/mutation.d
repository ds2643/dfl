/*
 *  module provides template for mutating arbitrary data
 */

module mutation;

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
        else if (is(T == double)) { return cast(T) uniform!ulong(); }
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

auto mutate(T, U)(T[U] value) {
    // generalization to heterogenous association array
    auto a = value.dup; // copy to ensure safety TODO: don't make copy if unnecessary
    auto allKeys = a.keys;
    int randomIndex = cast(int) uniform(0, a.length);
    T randomKey = allKeys[randomIndex];
    a[randomKey] = mutate!(T)(randomKey);
    return a;
}

unittest {
    // test mutation of boolean and integral types
    assert(isBoolean(mutate(true))); // boolean

    auto randByte = mutate(cast(byte) 0); // byte
    assert((typeof(randByte).stringof == "byte") && isSigned(randByte));

    auto randUbyte = mutate(cast(ubyte) 0); // ubyte
    assert((typeof(randUbyte).stringof == "ubyte") && isUnsigned(randUbyte));

    auto randShort = mutate(cast(short) 0); // short
    assert((typeof(randShort).stringof == "short") && isSigned(randShort));

    auto randUshort = mutate(cast(ushort) 0); // ushort
    assert((typeof(randUshort).stringof == "ushort") && isUnsigned(randUshort));

    auto randInt = mutate(cast(int) 0); // int
    assert(isIntegral(randInt).stringof && isSigned(randInt));

    auto randUint = mutate(cast(uint) 0); // unit
    assert(isIntegral(randUint).stringof && isUnsigned(randUint));

    auto randLong = mutate(cast(long) 0L); // long
    assert((typeof(randLong).stringof == "long") && isUnsigned(randLong));

    auto randUlong = mutate(cast(ulong) 0);// ulong
    assert((typeof(randUlong).stringof == "long") && isUnsigned(randUlong));

    assert(isSomeChar(mutate(0xFF))); // char

    auto randDchar = mutate(0x0000FFFF); // dchar
    assert(typeof(randDchar).stringof == "dchar");

    auto randWchar = mutate(0xFFFF); // wchar
    assert(typeof(randWchar).stringof == "wchar");

    // non-discrete numeric values
    auto randFloat = mutate(cast(float) float.min); // float
    assert(isFloatingPoint(mutate(1.0F)));

    auto randReal = mutate(cast(real) real.min); // real
    assert(typeof(randReal).stringof == "real");

    auto randDouble = mutate(cast(double) double.min); // double
    assert(typeof(randDouble).stringof == "double");

    // TODO: array
    // TODO: association array
    // TODO: association array
}
