//
//  NSMutableArray+Hook.m
//  MethodExchange
//
//  Created by SandsLee on 2020/4/27.
//  Copyright © 2020 SandsLee. All rights reserved.
//

#import "NSMutableArray+Hook.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Hook)

/**
使用runtime实现Hook向数组中添加元素时自动进行非空检测
*/
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{    
        // NSMutableArray、NSMutableDictionary都是类簇,所以自身的类型并不是self
        // 这里需要使用它们自身的本质类型才可以获取到对应方法
        Class cls = NSClassFromString(@"__NSArrayM");
        Method rawM = class_getInstanceMethod(cls, @selector(insertObject:atIndex:));
        Method newM = class_getInstanceMethod(cls, @selector(sz_insertObject:atIndex:));
        method_exchangeImplementations(rawM, newM);
    });
}

- (void)sz_insertObject:(id)anObject atIndex:(NSUInteger)index {
    // 如果object是nil,则直接return
    if (anObject == nil) {
        return;
    }
    // 再调回原方法的IMP
    [self sz_insertObject:anObject atIndex:index];
}

@end
