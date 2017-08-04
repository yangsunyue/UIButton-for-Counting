//
//  UIButton+Counting.m
//
//  Created by Yang on 17/3/18.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "UIButton+Counting.h"
#import "objc/runtime.h"


// 获取验证码CD   120
#define CodeSecond 120

static char timeKey;

static char countKey;

static NSInteger defaultCount = CodeSecond;

@implementation UIButton (Counting)


- (void)setTimer:(NSTimer *)timer{
    objc_setAssociatedObject(self, &timeKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimer *)timer{
    return objc_getAssociatedObject(self, &timeKey);
}

- (NSString *)count{
    return objc_getAssociatedObject(self, &countKey);
}

- (void)setCount:(NSString *)count{
    objc_setAssociatedObject(self, &countKey, count, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)startCounting{
    self.enabled = NO;
    [self setTitle:[NSString stringWithFormat:@"重新获取%ldS", (long)CodeSecond] forState:UIControlStateDisabled];
    self.count = [NSString stringWithFormat:@"%ld", defaultCount];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}



- (void)timerFired:(NSTimer *)timer{
    NSInteger timeCount = [self.count integerValue];
    if (timeCount !=1) {
        timeCount -= 1;
        [self setTitle:[NSString stringWithFormat:@"重新获取%ldS",(long)timeCount] forState:UIControlStateDisabled];
        self.count = [NSString stringWithFormat:@"%ld", timeCount];
    }else{
        timeCount = CodeSecond;
        self.count = [NSString stringWithFormat:@"%ld", timeCount];
        [timer invalidate];
        timer = nil;
        self.enabled = YES;
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (void)dealloc{
    self.count = [NSString stringWithFormat:@"%ld", defaultCount];
    NSLog(@"dealloc ----  %@", self.count);
    [self.timer invalidate];
    self.timer = nil;
}

@end
