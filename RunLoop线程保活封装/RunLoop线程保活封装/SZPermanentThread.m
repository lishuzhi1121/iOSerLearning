//
//  SZPermanentThread.m
//  RunLoop线程保活封装
//
//  Created by SandsLee on 2020/4/29.
//  Copyright © 2020 SandsLee. All rights reserved.
//

#import "SZPermanentThread.h"

#pragma mark - SZThread

@interface SZThread : NSThread

@end

@implementation SZThread
// 用于监听线程销毁
- (void)dealloc {
    NSLog(@"%s", __func__);
}
@end


#pragma mark - SZPermanentThread

@interface SZPermanentThread ()

/// 内部线程
@property (nonatomic, strong) SZThread *innerThread;

/// 是否应该保活
@property (nonatomic, assign) BOOL shouldKeepRunning;

@end

@implementation SZPermanentThread

#pragma mark - public

- (instancetype)init {
    if (self = [super init]) {
        // 默认自动保活
        self.shouldKeepRunning = YES;
        
        __weak typeof(self) weakSelf = self;
        // 创建线程
        self.innerThread = [[SZThread alloc] initWithBlock:^{
            // OC 保活代码如下:
//            [[NSRunLoop currentRunLoop] addPort:[NSPort new] forMode:NSDefaultRunLoopMode];
//            while (weakSelf && weakSelf.shouldKeepRunning) {
//                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//            }
            
            // C 语言 API 实现如下:
            // 添加source
            CFRunLoopSourceContext context = {0}; // 这个结构体一定要初始化,否则可能会奔溃（坏内存访问）
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            CFRelease(source);
            // 启动 第3个参数 returnAfterSourceHandled: 表示执行完source之后是否退出当前runloop
            // 这里我们希望线程保活,所以不要退出,传false
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
        }];
        
        
        
        
        // 自动启动
        [self.innerThread start];
    }
    return self;
}


- (void)excuteTask:(void (^)(void))taskBlock {
    if (!self.innerThread || !taskBlock) return;
    
    [self performSelector:@selector(__excuteTask:) onThread:self.innerThread withObject:taskBlock waitUntilDone:NO];
}

- (void)excuteTask:(SEL)task target:(id)target withObject:(id)object {
    if (!self.innerThread || !target) return;
    
    [target performSelector:task onThread:self.innerThread withObject:object waitUntilDone:NO];
}


- (void)stop {
    if (!self.innerThread) return;
    
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}


#pragma mark - private

- (void)__excuteTask:(void (^)(void))taskBlock {
    taskBlock();
}


- (void)__stop {
    self.shouldKeepRunning = NO;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}


- (void)dealloc {
    NSLog(@"%s", __func__);
    
    [self stop];
}


@end
