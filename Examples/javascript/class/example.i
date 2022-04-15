/* File : example.i */
%module example

%include <std_string.i>
// %include <std_vector.i>

%{
#include "example.h"
%}

%define SWIG_INCLUDE(file) 
%include file
%enddef

%define SWIG_MY_INCLUDE(file)
%include file
%{
#include "file"
%}
%enddef

// /* Let's just grab the original header file here */
// // %include "example.h"

%typemap(in) (const char *fmt, ...) {
    $1 = "%s"; /* Fix format string to %s */
    $2 = (void *) PyString_AsString($input); /* Get string argument */
};



%typemap(in) MyClass * %{
    xlalalla
%}

namespace myns { namespace mysubns {

int my_printf(const char *fmt, ...);

}}

int my_printf(const char *fmt, ...);

%insert("header") %{
#include <myheader111.h>
%}



SWIG_MY_INCLUDE(Shape.h)

SWIG_INCLUDE(example.h)

class MyClass {
public:
    void foo();
    int m_a;
};

void myClassFoo(MyClass * aa);

// %extend(MyClass) {
//     %ignore(foo)
// }

// %insert("header") %{
// #include <myheader222.h>
// %}

// %begin %{
// // Hello World
// %}

// %inline %{
// /* Create a new vector */ 
// Vector *new_Vector() {
//     return (Vector *) malloc(sizeof(Vector));
// }
// %}



// A typemap defining how to return an argument by appending it to the result 
%typemap(argout) double *outvalue {
    Tcl_Obj *o = Tcl_NewDoubleObj($1);
    Tcl_ListObjAppendElement(interp, $result, o);
}
// A typemap telling SWIG to ignore an argument for input
// However, we still need to pass a pointer to the C function 

%typemap(in, numinputs=0) double *outvalue (double temp) {
    $1 = &temp; 
}
// Now a function returning two values
int mypow(double a, double b, double *outvalue) {
    if ((a < 0) || (b < 0)) return -1; *outvalue = pow(a, b);
    return 0;
};

// %typemap(memberin) int myvalue[4] {
//     //cjh my memberin
//      memmove($1, $input, 4*sizeof(int));
// }

// class MyMemberInTestClass {
//     public:
//     void myMemberInTest(int myvalue[4]);


// };

typedef struct {
    MY_UNICODE value[512];
} TEST_STRUCTURE;

%typemap(memberin) MY_UNICODE [512] {
    if(UTF8ToMyUnicode($1, $input) != 0) {
        return NULL;
    }
}

%typemap(memberout) MY_UNICODE [512] {
    if(MyUnicodeToUTF8($1, $input) != 0) {
        return NULL;
    }
}  

int UTF8ToMyUnicode(char *utf8, MY_UNICODE *unicode);
int MyUnicodeToUTF8(MY_UNICODE *unicode, char *utf8);

void myTestStructure(TEST_STRUCTURE* p);

%include <arrays_javascript.i>
%inline %{
    extern int FiddleSticks[3];
%}

