// mutate arbitrary data
// overloaded mutation operation for primitive types
import std.stdio;
import std.random;
import std.traits;

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
    return cast(int) uniform(0, 4294967296); // 32 bits
}

uint mutate(uint a) {
    return castu(uint) uniform(0, 4294967296); // 32 bits
}

long mutate(long a) {
    return cast(long) uniform(0, 18446744073709551616); // 64 bits
}

ulong mutate(ulong a) {
    return cast(ulong) uniform(0, 18446744073709551616); // 64 bits
}

float mutate(float a) {
    return cast(float) uniform(0, 4294967296); // 32 bits
}

/*
ifloat mutate(ifloat a) {

}

cfloat mutate(cfloat a) {

}
*/

double mutate(double a) {
    return cast(long) uniform(0, 18446744073709551616);
}

/*
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

char mutate(char a) {

}

wchar mutate(wchar a) {

}

dchar mutate(dchar a) {

}
*/

unittest { // TODO: add values
    assert(isBoolean(mutate(true))); // boolean

    auto randByte = mutate(cast(byte) 0); // byte
    assert((typeof(randByte) == byte) && isSigned(randByte));

    auto randUbyte = mutate(cast(ubyte) 0); // ubyte
    assert((typeof(randUbyte) == ubyte) && isUnsigned(randUbyte));

    auto randShort = mutate(cast(short) 0); // short
    assert((typeof(randShort) == short) && isSigned(randShort));

    auto randUshort = mutate(cast(ushort) 0); // ushort
    assert((typeof(randUshort) == ushort) && isUnsigned(randUshort));

    auto randInt = mutate(cast(int) 0); // int
    assert(isIntegral(randInt) && isSigned(randInt));

    auto randUint = mutate(cast(uint) 0); // unit
    assert(isIntegral(randUint) && isUnsigned(randUint));

    auto randLong = mutate(cast(long) 0L); // long
    assert((typeof(randLong) == long) && isUnsigned(randLong));

    auto randUlong = mutate(cast(ulong) 0);// ulong
    assert((typeof(randUlong) == long) && isUnsigned(randUlong));

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

/* DERIVED DATA TYPES */

// pointer
// array
// strings (special case of arrays)
// associative array
// function
// delegate

/* USER DEFINED TYPES */

// alias
// enum
// struct
// union
// class

/* base types */
// https://dlang.org/spec/type.html

void main() {
    return 0;
}
