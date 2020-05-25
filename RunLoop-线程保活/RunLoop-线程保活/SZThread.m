//
//  SZThread.m
//  RunLoop-线程保活
//
//  Created by SandsLee on 2020/4/28.
//  Copyright © 2020 SandsLee. All rights reserved.
//

#import "SZThread.h"

@implementation SZThread

// 监听线程销毁
- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
