#!/usr/bin/env python

# Copyright (c) 2015 clowwindy
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


__all__ = ('UIKit', 'ObjCClass', 'objc_method', 'from_value', 'to_value',
           'NSObject', 'NSString', 'NSArray', 'NSDictionary',
           'UIResponder', 'UIScreen', 'UIView', 'UIViewController', 'UIWindow',
           'UINavigationController', 'UITableViewController')


from ctypes import cdll, c_int, c_void_p, util
from rubicon.objc import ObjCClass, objc_method
from rubicon.objc.core_foundation import from_value, to_value


UIKit = cdll.LoadLibrary(util.find_library('UIKit'))
UIKit.UIApplicationMain.restypes = (c_int, c_void_p, c_void_p,
                                    c_void_p)
UIKit.UIApplicationMain.restype = c_int


for item in __all__:
    if item not in globals():
        globals()[item] = ObjCClass(item)
