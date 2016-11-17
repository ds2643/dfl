module mutate.primitives;

// mutate arbitrary data
// overloaded mutation operation for primitive types
import std.stdio;
import std.random;
import std.traits;
import std.math;

/* PRIMITIVE TYPES */

bool mutate(bool a) {
    return (uniform(0,2) > 0);
}

byte mutate(byte a) {
    return cast(byte) uniform(0, 256);  // 8 bits
}

ubyte mutate(ubyte a) {
    return cast(ubyte) uniform(0, 256); // 8 bits
}

short mutate(short a) {
    return cast(short) uniform(0, 65536); // 16 bits
}

ushort mutate(ushort a) {
    return cast(ushort) uniform(0, 65536); // 16 bits
}

int mutate(int a) {
    return uniform!int(); // 32 bits
}

uint mutate(uint a) {
    return uniform!uint(); // 32 bits
}

long mutate(long a) {
    return uniform!long(); // 64 bits
}

ulong mutate(ulong a) {
    return uniform!ulong(); // 64 bits
}

char mutate(char a) {
    return uniform!char();
}

wchar mutate(wchar a) {
    return uniform!wchar();
}

dchar mutate(dchar a) {
    return uniform!dchar();
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

}

// TODO: randomly generate floats

/*
float mutate(float a) {
    return uniform!float(); // 32 bits
}

ifloat mutate(ifloat a) {

}

cfloat mutate(cfloat a) {

}

double mutate(double a) {
    return cast(long) uniform(0, 18446744073709551616);
}

idouble mutate(idouble a) {

}

cdouble mutate(cdouble a) {

}

real mutate(real a) {

}

ireal mutate(ireal a) {

}

creal mutate(creal a) {

}

unittest {
    // non-discrete numeric values and characters
    auto randFloat = mutate(cast(float) float.nan); // float
    assert(isFloatingPoint(mutate(1.0F)); // float

    assert(isSomeChar(mutate(0xFF))); // char

    auto randDchar = mutate(0x0000FFFF); // dchar
    assert(typeof(randDchar) == dchar);

    auto randWchar = mutate(0xFFFF); // wchar
    assert(typeof(randWchar) == wchar);

    // double double.nan
    // real real.nan
    // ifloat
    // idouble
    // ireal
    // cfloat
    // cdouble
    // creal
    // char
}
*/
