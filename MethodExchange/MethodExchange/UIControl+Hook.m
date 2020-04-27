//
//  UIControl+Hook.m
//  MethodExchange
//
//  Created by SandsLee on 2020/4/27.
//  Copyright © 2020 SandsLee. All rights reserved.
//

#import "UIControl+Hook.h"
#import <objc/runtime.h>

@implementation UIControl (Hook)

/**
 使用runtime实现Hook所有按钮的点击事件
 */
+ (void)load {
    Method rawM = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method newM = class_getInstanceMethod(self, @selector(sz_sendAction:to:forEvent:));
    method_exchangeImplementations(rawM, newM);
}

- (void)sz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    // hook到所有按钮的点击事件先打印参数信息(这里就可以进行其他操作了)
    NSLog(@"self: %@ -- action: %@ -- target: %@", self, NSStringFromSelector(action), target);
    
    // 再调回原方法的IMP
    [self sz_sendAction:action to:target forEvent:event];
}

@end
