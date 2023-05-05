//
//  main.m
//  A main module for starting Python projects under iOS.
//
//  Copyright (c) 2014 Russell Keith-Magee.
//  Released under the terms of the BSD license.
//  Based on an intial file provided as part of the Kivy project
//  Copyright (c) 2014 Russell Keith-Magee.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <Python/Python.h>
#include <dlfcn.h>

int main(int argc, char *argv[]) {
    int ret = 0;

    @autoreleasepool {

#if TARGET_IPHONE_SIMULATOR
        putenv("TARGET_IPHONE_SIMULATOR=1");
#else
        putenv("TARGET_IPHONE=1");
#endif

        NSString * resourcePath = [[NSBundle mainBundle] resourcePath];

        // Special environment to prefer .pyo, and don't write bytecode if .py are found
        // because the process will not have write attribute on the device.
        putenv("PYTHONOPTIMIZE=2");
        putenv("PYTHONDONTWRITEBYTECODE=1");
        putenv("PYTHONNOUSERSITE=1");

        NSString *python_path = [NSString stringWithFormat:@"PYTHONPATH=%@/app:%@/app_packages", resourcePath, resourcePath, nil];
        putenv((char *)[python_path UTF8String]);
        // putenv("PYTHONVERBOSE=1");

        Py_SetPythonHome((char *)[resourcePath UTF8String]);

        Py_Initialize();
        PySys_SetArgv(argc, argv);

        // If other modules are using thread, we need to initialize them before.
        PyEval_InitThreads();

        // Search and start main.py
        const char * prog = [[[NSBundle mainBundle] pathForResource:@"app/myapp/main" ofType:@"py"] cStringUsingEncoding:NSUTF8StringEncoding];
        FILE* fd = fopen(prog, "r");
        if (fd == NULL)
        {
            ret = 1;
            NSLog(@"Unable to open main.py, abort.");
        }
        else
        {
            ret = PyRun_SimpleFileEx(fd, prog, 1);
            if (ret != 0)
            {
                NSLog(@"Application quit abnormally!");
            }
        }
        Py_Finalize();
    }

    exit(ret);
    return ret;
}
