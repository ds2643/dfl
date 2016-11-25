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
    else if (__traits(isIntegral, value))  {
        return cast(T) uniform!T();
    }
    else if (__traits(isFloating, value)) {
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
    auto booleanData = true;
    assert(isBoolean(mutate!(bool)(booleanData))); // boolean
    /*
    auto randByte = mutate!(byte)(cast(byte) 0); // byte
    assert((typeof(randByte).stringof == "byte") && __traits(isSigned, randByte));

    auto randUbyte = mutate!(ubyte)(cast(ubyte) 0); // ubyte
    assert((typeof(randUbyte).stringof == "ubyte") && __traits(isUnsigned, randUbyte));

    auto randShort = mutate!(short)(cast(short) 0); // short
    assert((typeof(randShort).stringof == "short") && __traits(isSigned, randShort));

    auto randUshort = mutate!(ushort)(cast(ushort) 0); // ushort
    assert((typeof(randUshort).stringof == "ushort") && __traits(isUnsigned, randUshort));

    auto randInt = mutate!(int)(cast(int) 0); // int
    assert(__traits(isIntegral, randInt).stringof && __traits(isSigned, randInt));

    auto randUint = mutate!(uint)(cast(uint) 0); // unit
    assert(__traits(isIntegral, randUint).stringof && __traits(isUnsigned, randUint));

    auto randLong = mutate!(long)(cast(long) 0L); // long
    assert((typeof(randLong).stringof == "long") && __traits(isUnsigned, randLong));

    auto randUlong = mutate!(ulong)(cast(ulong) 0);// ulong
    assert((typeof(randUlong).stringof == "long") && __traits(isUnsigned, randUlong));

    char charData = 0xFF;
    assert(isSomeChar(mutate!(char)(charData))); // char

    char dcharData = 0x0000FFFF;
    auto randDchar = mutate!(dcha0xFFFFr)(dcharData); // dchar
    assert(typeof(randDchar).stringof == "dchar");

    wchar wcharData = 0xFFFF;
    auto randWchar = mutate!(typeof(wcharData))(wcharData); // wchar
    assert(typeof(randWchar).stringof == "wchar");

    // non-discrete numeric values
    auto randFloat = mutate!(cast(float) float.min_normal); // float... note that choice of min_normal property arbitrarily (for instance, over min_exp or .min_10_exp)
    assert(isFloatingPoint(mutate(1.0F)));

    auto randReal = mutate!(cast(real) real.min_normal); // real
    assert(typeof(randReal).stringof == "real");

    auto randDouble = mutate!(cast(double) double.min_normal); // double
    assert(typeof(randDouble).stringof == "double");

    // TODO: array
    // TODO: association array
    // TODO: association array
    */
}
