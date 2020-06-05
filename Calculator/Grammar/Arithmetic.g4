//  Arithmetic.g4
//  Calculator
//
//  Created by Dmytro Anokhin on 26/05/2020.
//  Copyright © 2020 Dmytro Anokhin. All rights reserved.

grammar Arithmetic;


root : expression EOF ;

expression
    : expression (MULT | DIV) expression
    | expression (PLUS | MINUS) expression
    | (PLUS | MINUS)* number
    ;

number : NUMBER ;

NUMBER : ('0' .. '9') + ('.' ('0' .. '9') +)? ;

PLUS  : '+' ;
MINUS : '-' ;
MULT  : '×' ;
DIV   : '÷' ;

WS : [ \r\n\t] + -> skip ;
