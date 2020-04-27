//
//  NSMutableDictionary+Hook.m
//  MethodExchange
//
//  Created by SandsLee on 2020/4/27.
//  Copyright © 2020 SandsLee. All rights reserved.
//

#import "NSMutableDictionary+Hook.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (Hook)

/**
使用runtime实现Hook向可变字典中添加元素时自动进行key的非空检测(也可以实现key、value都检测)
*/
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{    
        // NSString、NSArray、NSMutableArray、NSMutableDictionary等都是类簇,所以自身的类型并不是self
        // 这里需要使用它们自身的本质类型才可以获取到对应方法
        Class cls = NSClassFromString(@"__NSDictionaryM");
        Method rawM = class_getInstanceMethod(cls, @selector(setObject:forKeyedSubscript:));
        Method newM = class_getInstanceMethod(cls, @selector(sz_setObject:forKeyedSubscript:));
        method_exchangeImplementations(rawM, newM);
    });
}

- (void)sz_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    // 如果key是nil,则直接return
    if (!key) {
        return;
    }
    // 再调回原方法的IMP
    [self sz_setObject:obj forKeyedSubscript:key];
}



@end
