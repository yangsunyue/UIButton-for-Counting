//
//  UIButton+Counting.h
//
//  Created by Yang on 17/3/18.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Counting)

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, copy) NSString *count;

- (void)startCounting;

@end
