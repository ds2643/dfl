/*
* defines a grammar used to parse specifications of well-formed data structures
*/

module parser;

import pegged.grammar;

 // TODO expand grammar

mixin(grammar(`
Data:
    Expression < Integer / String
    String     < [A-Za-z]+
    Float      < [0-9]+&.?][0-9]*?
    Integer    < [0-9]+
            `));
