//
//  ViewController.m
//  MethodExchange
//
//  Created by SandsLee on 2020/4/27.
//  Copyright © 2020 SandsLee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // test mutableArray
    NSObject *obj = nil;
    NSMutableArray *mArr = [NSMutableArray array];
    [mArr addObject:@"sands"];
    [mArr addObject:obj];
    NSLog(@"mArr: %@", mArr);
    
    // test mutableDictionary
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    mDict[@"name"] = @"sands";
    mDict[obj] = @10;
    NSLog(@"mDict: %@", mDict);
    
}

- (IBAction)buttonClicked1:(UIButton *)sender {
    NSLog(@"1 -- %s", __func__);
}

- (IBAction)buttonClicked2:(UIButton *)sender {
    NSLog(@"2 -- %s", __func__);
}

- (IBAction)buttonClicked3:(UIButton *)sender {
    NSLog(@"3 -- %s", __func__);
}

@end
