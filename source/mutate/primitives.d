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

/* NON-INTEGRAL NUMBERS */

float mutate(float a) {
    union both {ulong input; float output;}
    both val;
    val.input = uniform!"[]"(ulong.min, ulong.max);
    return val.output;
}

double mutate(double a) {
    union both {ulong input; double output;}
    both val;
    val.input = uniform!"[]"(ulong.min, ulong.max);
    return val.output;
}

real mutate(real a) {
    union both {ulong input; real output;}
    both val;
    val.input = uniform!"[]"(ulong.min, ulong.max);
    return val.output;
}

unittest {
    // non-discrete numeric values
    auto randFloat = mutate(cast(float) float.nan); // float
    assert(isFloatingPoint(mutate(1.0F))); // float

    // double
    // real
}

// extend approach to imaginary and complex versions of float, double, and real types

/*
ifloat mutate(ifloat a) {

}

cfloat mutate(cfloat a) {

}

}
idouble mutate(idouble a) {

}

cdouble mutate(cdouble a) {

}

ireal mutate(ireal a) {

}

creal mutate(creal a) {

}

unittest {
    // ifloat
    // idouble
    // ireal
    // cfloat
    // cdouble
    // creal
}
*/
