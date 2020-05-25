//
//  ViewController.m
//  RunLoop线程保活封装
//
//  Created by SandsLee on 2020/4/29.
//  Copyright © 2020 SandsLee. All rights reserved.
//

#import "ViewController.h"
#import "SZPermanentThread.h"

@interface ViewController ()

@property (nonatomic, strong) SZPermanentThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个持久线程
    self.thread = [[SZPermanentThread alloc] init];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 在持久线程中执行任务
//    [self.thread excuteTask:^{
//        NSLog(@"%@ ---111---", [NSThread currentThread]);
//    }];
    __weak typeof(self) weakSelf = self;
    [self.thread excuteTask:@selector(test) target:weakSelf withObject:nil];
}


- (void)test {
    NSLog(@"%s --- %@", __func__, [NSThread currentThread]);
}

- (IBAction)stop:(UIButton *)sender {
    [self.thread stop];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
