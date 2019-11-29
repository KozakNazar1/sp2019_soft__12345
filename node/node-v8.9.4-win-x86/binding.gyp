{
  "targets": [
    { 
      "cflags!": [ "-fno-exceptions" ],
      "cflags_cc!": [ "-fno-exceptions" ],
      "include_dirs" : [
        "<!@(node -p \"require('node-addon-api').include\")"
      ],
      "msbuild_settings": {"Link": {"ImageHasSafeExceptionHandlers": "false"}},
      "target_name": "wrapper_calclab3",
      "sources": [ "wrapper_calclab3.cc", "asmfile.asm"],
      'defines': [ 'NAPI_DISABLE_CPP_EXCEPTIONS' ]
    }
  ]
}