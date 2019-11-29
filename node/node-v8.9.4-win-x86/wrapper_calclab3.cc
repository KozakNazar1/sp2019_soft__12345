/**********************************************************************
* N.Kozak // Lviv'2019 // example server NodeJS(LLNW)-Asm for pkt4 SP *
*                         file: wrapper_calclab3.js                   *
*                                                              files: *
*                                                         asmfile.asm *
*                                                 wrapper_calclab3.cc *
*                                                           server.js *
*                                                                     *
*                                                   *extended version *
***********************************************************************/
//#include <node.h>
#include <napi.h>
//#include <node_api.h>
#include <stdio.h>
//#include <stdlib.h>
//#include <conio.h>
//#include <string.h>
//#include <assert.h>

extern "C" long double __cdecl calcLab3(double b2, float c1, double d2, float e1, double f2); 
//extern "C" long double calcLab3(double b2, float c1, double d2, float e1, double f2); 

Napi::Number calc(const Napi::CallbackInfo& info) {
  Napi::Env env = info.Env();
  
  double b2;
  float c1;
  double d2;
  float e1;
  double f2;
  
  double temp_double;
  
  napi_get_value_double(env, info[0], &b2); // assert(napi_get_value_double(env, info[0], &b2) == napi_ok);

  napi_get_value_double(env, info[1], &temp_double); // assert(napi_get_value_double(env, info[1], &temp_double) == napi_ok);
  c1 = temp_double;
  
  napi_get_value_double(env, info[2], &d2); // assert(napi_get_value_double(env, info[2], &d2) == napi_ok);
  
  napi_get_value_double(env, info[3], &temp_double); // assert(napi_get_value_double(env, info[3], &temp_double) == napi_ok);
  e1 = temp_double;
  
  napi_get_value_double(env, info[4], &f2); // assert(napi_get_value_double(env, info[4], &f2) == napi_ok);
  
  
  return Napi::Number::New(env, (double)calcLab3(b2, c1, d2, e1, f2));
}

Napi::Object init(Napi::Env env, Napi::Object exports) {
    exports.Set(Napi::String::New(env, "calc"), Napi::Function::New(env, calc));
    return exports;
};

NODE_API_MODULE(hello_world, init);