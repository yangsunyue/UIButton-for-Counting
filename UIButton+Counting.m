//
//  UIButton+Counting.m
//  ILITOP
//
//  Created by Yang on 17/3/18.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "UIButton+Counting.h"
#import "objc/runtime.h"


// 获取验证码CD   120
#define CodeSecond 120

static char timeKey;

@implementation UIButton (Counting)

//@dynamic timer;

- (void)setTimer:(NSTimer *)timer{
    objc_setAssociatedObject(self, &timeKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimer *)timer{
    return objc_getAssociatedObject(self, &timeKey);
}


- (void)startCounting{
    self.enabled = NO;
    [self setTitle:[NSString stringWithFormat:@"重新获取%ldS", (long)CodeSecond] forState:UIControlStateDisabled];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}



- (void)timerFired:(NSTimer *)timer{
    static NSInteger count = CodeSecond;
    if (count !=1) {
        count -= 1;
        [self setTitle:[NSString stringWithFormat:@"重新获取%ldS",(long)count] forState:UIControlStateDisabled];
    }else{
        count = CodeSecond;
        [timer invalidate];
        timer = nil;
        self.enabled = YES;
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}




@end
