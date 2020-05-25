//
//  SZPermanentThread.h
//  RunLoop线程保活封装
//
//  Created by SandsLee on 2020/4/29.
//  Copyright © 2020 SandsLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SZPermanentThread : NSObject

/// 在创建的永久线程中执行任务
/// @param taskBlock 任务
- (void)excuteTask:(void (^)(void))taskBlock;

/// 在创建的永久线程中执行任务
/// @param task 任务/方法
/// @param target 执行对象
/// @param object 参数
- (void)excuteTask:(SEL)task target:(id)target withObject:(id _Nullable)object;

/// 停止创建的永久线程
- (void)stop;

@end

NS_ASSUME_NONNULL_END
