module mutation_old;

// mutate arbitrary data
// overloaded mutation operation for primitive types
// contents: mutate() function, which is overloaded to work on any primitive or derived data

import std.stdio;
import std.random;
import std.traits;
import std.math;
import std.algorithm.iteration;

/* PRIMITIVE TYPES */

// ambiguity in cases of implicit type conversion may cause compilation errors. test to confirm expected behavior.

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
    return cast(float) uniform!uint();
}

real mutate(real a) {
    return cast(real) uniform!long(); // assumes 64 bits is largest size allowed by processor, but not accurate for x86 architecture
}

double mutate(double a) {
    return cast(double) uniform!ulong();
}

//float mutate(float a) {
//    union both {ulong input; float output;}
//    both val;
//    val.input = uniform!"[]"(ulong.min, ulong.max);
//    return val.output;
//}

//double mutate(double a) {
//    union both {ulong input; double output;}
//    both val;
//    val.input = uniform!"[]"(ulong.min, ulong.max);
//    return val.output;
//}

//real mutate(real a) {
//    union both {ulong input; real output;}
//    both val;
//    val.input = uniform!"[]"(ulong.min, ulong.max);
//    return val.output;
//}

unittest {
    // non-discrete numeric values
    auto randFloat = mutate(cast(float) float.min); // float
    assert(isFloatingPoint(mutate(1.0F)));

    auto randReal = mutate(cast(real) real.min); // real
    assert(typeof(randReal).stringof == "real");

    auto randDouble = mutate(cast(double) double.min); // double
    assert(typeof(randDouble).stringof == "double");
}

// extend approach to imaginary and complex versions of float, double, and real types

/*
ifloat mutate(ifloat a) {  }
cfloat mutate(cfloat a) {  }
idouble mutate(idouble a) {  }
cdouble mutate(cdouble a) {  }
ireal mutate(ireal a) {  }
creal mutate(creal a) {  }

unittest {
    // ifloat
    // idouble
    // ireal
    // cfloat
    // cdouble
    // creal
}
*/

/* DERIVED TYPES */

// pointers excluded as a valid datatype because of the danger of random pointer munipulation

/* static array */
// define for int, but generalize to other types after varifying proper behavior
// does this target both static and dynamic arrays?
int[] mutate(int[] a) {
    // takes and returns pointer to first element of array
    int randomIndex = cast(int) uniform(0, a.length); // randomly select locus for mutation within array
    a[randomIndex] = mutate(a[randomIndex]);
    return a;
}

// dynamic array

// association array
// must be templated... number of possible combinations large (no_types ** 2)
// prototype for int mapped to int

int[int] mutate(int[int] a) {
    // randomly choose a key and mutate its value
    auto allKeys = a.keys;
    int randomIndex = cast(int) uniform(0, a.length);
    int randomKey = allKeys[randomIndex];
    a[randomKey] = mutate(a[randomKey]);
    return a;
}


// string as immutible char array of static length

unittest {
    int randomLength = uniform(0,100); // static array of ints
    int[uniform(0, randomLength)] someStaticArray;
    someStaticArray = map!(a => uniform!int())(someStaticArray);
    auto someStaticArrayMutated = mutate(someStaticArray);
    assert(typeof(someStaticArrayMutated).stringof == ("int[" ~ (cast(string) randomLength) ~ "]"));

    // doing on a per primitive basis is too expensive: instead consider writing some kind of template

    // dynamic array
    // association array: int:int
    int[int] assArray;
    assArray[1] = 1;
    assArray[2] = 2;
    assArray[3] = 3;
    assert(typeOf(mutate(assArray)) == "int[int]" && (3 == assArray.keys.length));
    // string
}

//struct TODO: same interface as other functions?
auto mutate(T)(T a) {
    if(is(T == struct)) {
        auto copy = a.dup;
        auto fields = FieldNameTuple!T;
    }

    // choose randomly among contents
    // apply mutate(content)
    // return mutant struct
}

// mutation function overloading for classes using templates not supported. templates only effective if identity of type is known at compile time. the general direction here: support for derived data types, but not user defined data types. functions omitted for difficulty of mutation.

// https://dlang.org/spec/type.html
