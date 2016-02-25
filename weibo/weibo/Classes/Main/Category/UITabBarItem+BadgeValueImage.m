//
//  UITabBarItem+BadgeValueImage.m
//  weibo
//
//  Created by 王 on 16/2/25.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "UITabBarItem+BadgeValueImage.h"
#import <objc/runtime.h>


@implementation UITabBarItem (BadgeValueImage)

- (void)setBadgeImageName:(NSString *)badgeImageName {
    objc_setAssociatedObject(self, @"imageName", badgeImageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)badgeImageName {
    return objc_getAssociatedObject(self, @"imageName");
}

//替换系统方法
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class clas = [self class];
        
        SEL originalSel = @selector(setBadgeValue:);
        SEL newSel = @selector(wlc_setBadgeValue:);
        
        Method originalMethod = class_getInstanceMethod(clas, originalSel);
        Method newMethod = class_getInstanceMethod(clas, newSel);
        
        method_exchangeImplementations(originalMethod, newMethod);
        
//        BOOL result = class_addMethod(clas, originalSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
//        if (result) {
//            class_replaceMethod(clas, newSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, newMethod);
//        }
    });
}

//替换的方法
- (void)wlc_setBadgeValue: (NSString *)badgeValue {
    [self wlc_setBadgeValue:badgeValue];
    
    if (!badgeValue) {
        return;
    }
    
    //通过KVC拿到tabBarcontroller
    UITabBarController *target = [self valueForKeyPath:@"_target"];

    for (UIView *tabBarSubview in target.tabBar.subviews) {
        if ([tabBarSubview isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            for (UIView *tabBarBtnSubview in tabBarSubview.subviews) {
                if ([tabBarBtnSubview isKindOfClass:NSClassFromString(@"_UIBadgeView")]) {
                    for (UIView *badgeViewSubview in tabBarBtnSubview.subviews) {
                        if ([badgeViewSubview isKindOfClass:NSClassFromString(@"_UIBadgeBackground")]) {
                            //count的值就代码当前类身上成员变量的个数
                            unsigned int count;
                            
                            Ivar *vars = class_copyIvarList(NSClassFromString(@"_UIBadgeBackground"), &count);
                            for (int i = 0; i < count; i++) {
                                Ivar var = vars[i];
                                
                                //取var的名字
                                NSString *name = [NSString stringWithCString:ivar_getName(var) encoding:NSUTF8StringEncoding];
                                //取var的类型
//                                NSString *type = [NSString stringWithCString:ivar_getTypeEncoding(var) encoding:NSUTF8StringEncoding];
//                                NSLog(@"%@=====%@",name,type);
                                if ([name isEqualToString:@"_image"]) {
                                    [badgeViewSubview setValue:[UIImage imageNamed:self.badgeImageName] forKey:name];
                                }
                            }
                            free(vars);
                        }
                    }
                }
            }
        }
    }
    
}

@end
