/*
 *  module provides template for mutating arbitrary data
 * TODO: fix support for char data
 */

module mutation;

import std.stdio;
import std.random;
import std.traits;
import std.math;
import std.algorithm.iteration;

// PRIMITIVE TYPES

auto mutate(bool value) {
    return (uniform(0,2) > 0);
}

auto mutate(T)(T value) if (isFloatingPoint!T) {
        // floating points cannot be generated with the uniform template like integral values
    if (is(T == float)) { return cast(T) uniform!uint(); }
    else if (is(T == real)) { return cast(T) uniform!long(); }
    else if (is(T == double)) { return cast(T) uniform!ulong(); }
    // TODO: add support for complex and imaginary floating point numbers
}

auto mutate(T)(T value) if (isIntegral!T) {
     return cast(T) uniform!T();
}

// DERIVED TYPES

auto mutate(T)(T[] value) {
    // array
    auto a = value.dup; // copy for safety TODO: don't make a copy if unnecessary
    int randomIndex = cast(int) uniform(0, a.length);
    a[randomIndex] = mutate!(T)(a[randomIndex]);
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
    bool booleanData = true;
    //assert(isBoolean(mutate!(booleanData))); // boolean
    assert(isBoolean!(typeof(mutate(booleanData)))); // boolean

    // TODO: extend to other integral types
    assert(isIntegral!(typeof(mutate(100))));

    //auto randByte = mutate!(byte)(cast(byte) 0); // byte
    //assert((typeof(randByte).stringof == "byte") && __traits(isSigned, randByte));

    //auto randUbyte = mutate!(ubyte)(cast(ubyte) 0); // ubyte
    //assert((typeof(randUbyte).stringof == "ubyte") && __traits(isUnsigned, randUbyte));

    auto shortData = cast(short) 0;
    auto mutatedShort = mutate(shortData);
    assert(is(typeof(mutatedShort) == short));

    auto ushortData = cast(ushort) 0;
    auto mutatedUShort = mutate(ushortData);
    assert(is(typeof(mutatedUShort) == ushort));

    auto intData = (cast(int) 0);
    auto mutatedInt = mutate(intData);
    assert(is(typeof(mutatedInt) == int));

    auto uIntData = (cast(uint) 0);
    auto mutatedUInt = mutate(uIntData);
    assert(is(typeof(mutatedUInt) == uint));

    auto longData = (cast(long) 0);
    auto mutatedLong = mutate(longData);
    assert(is(typeof(mutatedLong) == long));

    auto ulongData = (cast(ulong) 0);
    auto mutatedULong = mutate(ulongData);
    assert(is(typeof(mutatedULong) == ulong));

    /* TODO: CHAR OVERLOADS FAIL TO MATCH
    char charData = 0xFF;
    auto mutatedChar = mutate(charData);
    assert(is(typeof(mutatedChar) == char));

    dchar dcharData = 0x0000FFFF;
    auto mutatedDChar = mutate(dcharData); // dchar
    assert(is(dchar == typeof(mutatedDChar)));

    wchar wcharData = (cast(dchar) 'a');
    auto mutatedWChar = mutate(wcharData); // dchar
    assert(is(wchar == typeof(mutatedWChar)));
    */

    // non-discrete numeric values
    float floatData = float.min_normal;
    auto mutatedFloat = mutate(floatData);
    assert(is(typeof(mutatedFloat) == float));

    real realData = real.min_normal;
    auto mutatedReal = mutate(realData);
    assert(is(typeof(mutatedReal) == real));

    double doubleData = double.min_normal;
    auto mutatedDouble = mutate(doubleData);
    assert(is(typeof(mutatedDouble) == double));

    // derived data types

    int[] arrayData = [1, 2, 3, 4, 5];
    auto mutatedArray = mutate(arrayData);
    assert(is(typeof(mutatedArray) == typeof(arrayData)));

    int[int] aArrayData = [
        1 : 1,
        2 : 2,
        3 : 3
    ];
    auto mutatedAArray = mutate(aArrayData);
    assert(is(typeof(mutatedAArray) == typeof(aArrayData)));
}
