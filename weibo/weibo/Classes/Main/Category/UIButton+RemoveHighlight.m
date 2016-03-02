//
//  UIButton+RemoveHighlight.m
//  weibo
//
//  Created by 王 on 16/3/2.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "UIButton+RemoveHighlight.h"
#import <objc/runtime.h>

@implementation UIButton (RemoveHighlight)

-(void)setRemoveHighlight:(BOOL)removeHighlight {
    
    objc_setAssociatedObject(self, @"removeHightlight", @(removeHighlight), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)removeHighlight {
    
    return objc_getAssociatedObject(self, @"removeHightlight");
}

+(void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class classs = [self class];
        
        SEL originalSel = @selector(setHighlighted:);
        SEL newSel = @selector(wlc_setHighlighted:);
        
        Method originalMethod = class_getInstanceMethod(classs, originalSel);
        Method newMethod = class_getInstanceMethod(classs, newSel);
        
        method_exchangeImplementations(originalMethod, newMethod);
    });
    
}

-(void)wlc_setHighlighted:(BOOL)highlighted {
    //设置了这个值 才会取消高亮效果
    if (!self.removeHighlight) {
        [self wlc_setHighlighted:highlighted];
    }
}

@end
