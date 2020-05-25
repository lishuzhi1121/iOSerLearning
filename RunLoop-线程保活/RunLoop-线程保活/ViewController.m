//
//  ViewController.m
//  RunLoop-线程保活
//
//  Created by SandsLee on 2020/4/28.
//  Copyright © 2020 SandsLee. All rights reserved.
//

#import "ViewController.h"
#import "SZThread.h"

@interface ViewController ()

@property (nonatomic, strong) NSThread *thread;
@property (nonatomic, assign) BOOL shouldKeepRunning;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shouldKeepRunning = YES;
    
    __weak typeof(self) weakSelf = self;
    // 创建thread
    self.thread = [[SZThread alloc] initWithBlock:^{
        // thread启动后立即执行该block
        NSLog(@"%@ -- start --", [NSThread currentThread]);
        
        // 使用runloop实现线程保活
        // 想要当前runloop保持运行之前得先往runloop中至少添加一个source、timer或者observer
        // If no input sources or timers are attached to the run loop, this method exits immediately;
        [[NSRunLoop currentRunLoop] addPort:[NSPort new] forMode:NSDefaultRunLoopMode];
        // 运行runloop - 直接使用run运行则会导致该runloop无法停止
        //  it runs the receiver in the NSDefaultRunLoopMode by repeatedly invoking runMode:beforeDate:. In other words, this method effectively begins an infinite loop that processes data from the run loop’s input sources and timers.
//        [[NSRunLoop currentRunLoop] run];
        // 这里一定要先判断weakSelf是否存在,因为在dealloc中调用stop时这个weakSelf可能会被提前清理
        while (weakSelf && weakSelf.shouldKeepRunning) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        
        NSLog(@"%@ -- end --", [NSThread currentThread]);
    }];
    
    [self.thread start];
}

- (IBAction)stopThread:(UIButton *)sender {
    if (!self.thread) return;
    // 这里 waitUntilDone: 一定要使用YES,等待执行完成,因为该方法可能在 dealloc 中调用,
    // 如果不等待执行完成可能会导致坏内存访问
    [self performSelector:@selector(stop) onThread:self.thread withObject:nil waitUntilDone:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.thread) return;
    // 在创建的线程中执行任务
    [self performSelector:@selector(runJob) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)runJob {
    NSLog(@"%s -- %@", __func__, [NSThread currentThread]);
}

- (void)stop {
    self.shouldKeepRunning = NO;
    // 停止runloop
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"%@ -- stoped --", [NSThread currentThread]);
    // 线程置空
    self.thread = nil;
}


- (void)dealloc {
    NSLog(@"%s", __func__);
    
    [self stopThread:nil];
}


@end
