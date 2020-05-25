//
//  ViewController.m
//  Interview02-performSelector
//
//  Created by SandsLee on 2020/5/2.
//  Copyright © 2020 SandsLee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test1];
//    [self test2];
//    [self test3];
    [self test4];
}

// 面试题：以下test方法输出的结果是什么？主要是test4

- (void)test1 {
    NSLog(@"1");
    [self performSelector:@selector(task) withObject:nil];
    NSLog(@"3");
}

- (void)test2 {
    NSLog(@"1");
    [self performSelector:@selector(task) withObject:nil afterDelay:.0];
    NSLog(@"3");
}

- (void)test3 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"1");
        [self performSelector:@selector(task) withObject:nil];
        NSLog(@"3");
    });
}

- (void)test4 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"1");
        /*
         This method sets up a timer to perform the aSelector message on the current thread’s run loop. The timer is configured to run in the default mode (NSDefaultRunLoopMode). When the timer fires, the thread attempts to dequeue the message from the run loop and perform the selector. It succeeds if the run loop is running and in the default mode; otherwise, the timer waits until the run loop is in the default mode.
         */
        // 该方法相当于是往当前线程的runloop中添加了一个NSTimer,所以要依赖runloop的
        // 运行timer才能启动,而子线程默认是没有runloop的,虽然`performSelector:withObject:afterDelay:`方法
        // 的底层获取了当前线程的runloop,但是并没有启动,所以我们需要手动开启runloop.
        [self performSelector:@selector(task) withObject:nil afterDelay:.0];
        // 想要让上面的代码有效,则需要开启runloop
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//        [[NSRunLoop currentRunLoop] run];
        
        NSLog(@"3");
    });
}

- (void)task {
    NSLog(@"2");
}

@end
