//
//  WLCComposeView.m
//  weibo
//
//  Created by 王 on 16/2/29.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCComposeView.h"
#import "UIImage+ImageEffects.h"
#import "WLCComposeBtn.h"
#import "WLCComposeBtnModel.h"
#import "POP.h"
#import "WLCComposeStatusController.h"
#import "WLCNavigationController.h"

#define COMPOSEBUTTON_WIDTH 80
#define COMPOSEBUTTON_HEIGHT 110

@interface WLCComposeView ()

@property (strong, nonatomic) NSArray *composeBtnNameAndImage;
@property (strong, nonatomic) NSMutableArray *menuBtns;

@end

@implementation WLCComposeView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.frame = ScreenBounds;
        //布局
        [self decorateUI];
    }
    
    return self;
}

#pragma -mark 布局
- (void)decorateUI {
    
    //背景
    UIImage *image = [self currentScreenImage];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [self addSubview:imageView];
    
    //上部文字图片
    UIImageView *wordImage = [[UIImageView alloc]init];
    wordImage.image = [UIImage imageNamed:@"compose_slogan"];
    [wordImage sizeToFit];
    wordImage.centerX = ScreenWidth * 0.5;
    wordImage.centerY = ScreenHeight * 0.3;
    [self addSubview:wordImage];
    
    
    //按钮
    [self addMenuButton];
}

- (void)addMenuButton {
    
    CGFloat maxCol = 3;
    CGFloat margin = (ScreenWidth - maxCol * COMPOSEBUTTON_WIDTH) / (maxCol + 1);
    
    for (int i = 0; i < 6; i++) {
        
        NSDictionary *btnDict = self.composeBtnNameAndImage[i];
        WLCComposeBtnModel *composeBtnModel = [WLCComposeBtnModel composeBtnModelWithDict:btnDict];
        CGFloat btnY = i / 3 * (COMPOSEBUTTON_HEIGHT) + ScreenHeight;

        CGFloat btnX = (i % 3 + 1) * margin + i % 3 * COMPOSEBUTTON_WIDTH;
        
        WLCComposeBtn *btn = [[WLCComposeBtn alloc]initWithFrame:CGRectMake(btnX, btnY, COMPOSEBUTTON_WIDTH, COMPOSEBUTTON_HEIGHT)];
        [btn setTitle:composeBtnModel.title forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:composeBtnModel.icon] forState:UIControlStateNormal];
        
        btn.tag = i + 1000;
        [btn addTarget:self action:@selector(menuButtonClicking:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        [self.menuBtns addObject:btn];
    }
    
}

//menu按钮被点击时执行动画及跳转
- (void)menuButtonClicking: (UIButton *)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.menuBtns enumerateObjectsUsingBlock:^(WLCComposeBtn *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (sender == obj) {
                sender.transform = CGAffineTransformMakeScale(2.0, 2.0);
                sender.alpha = 0.1;
            } else {
                obj.transform = CGAffineTransformMakeScale(0.5, 0.5);
                obj.alpha = 0.1;
            }
        }];
        
    } completion:^(BOOL finished) {
        
        switch (sender.tag) {
            case 1000: {
                NSLog(@"文字");
                WLCComposeStatusController *composeStatusVC = [[WLCComposeStatusController alloc]init];
                [self.tabBarVC presentViewController:[[WLCNavigationController alloc]initWithRootViewController:composeStatusVC] animated:YES completion:nil];
                [self removeFromSuperview];
                break;
            }
                
            default:
                NSLog(@"其他");
                break;
        }
//
//        
        [UIView animateWithDuration:0.25 animations:^{
            [self.menuBtns enumerateObjectsUsingBlock:^(WLCComposeBtn *obj, NSUInteger idx, BOOL *stop) {
                obj.transform = CGAffineTransformIdentity;
                obj.alpha = 1;
            }];
        }];
//
//        
        
        
        
    }];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    //将数组中数据反转
    NSArray *tem = [self.menuBtns reverseObjectEnumerator].allObjects;
    
    [tem enumerateObjectsUsingBlock:^(WLCComposeBtn *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(obj.centerX, obj.centerY + 350)];
        animation.springSpeed = 12;
        animation.springBounciness = 10;
        animation.beginTime = CACurrentMediaTime() + idx * 0.025;
        [obj pop_addAnimation:animation forKey:nil];
    }];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}


//截图获取图片磨砂效果
- (UIImage *)currentScreenImage {
    UIGraphicsBeginImageContext(ScreenBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIApplication sharedApplication].keyWindow.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image applyLightEffect];
}

//按钮的动画效果
- (void)showAnimation {

    [self.menuBtns enumerateObjectsUsingBlock:^(WLCComposeBtn *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(obj.centerX, obj.centerY - 350)];
        animation.springSpeed = 12;
        animation.springBounciness = 10;
        animation.beginTime = CACurrentMediaTime() + idx * 0.025;
        [obj pop_addAnimation:animation forKey:nil];
    }];
    
}

//懒加载
-(NSArray *)composeBtnNameAndImage {
    if (_composeBtnNameAndImage == nil) {
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"ComposeBtnNameAndImage.plist" ofType:nil];
        NSArray *arrTem = [NSArray arrayWithContentsOfFile:path];
        _composeBtnNameAndImage = arrTem;
    }
    
    return _composeBtnNameAndImage;
}

-(NSMutableArray *)menuBtns {
    if (_menuBtns == nil) {
        _menuBtns = [NSMutableArray array];
    }
    return _menuBtns;
}

@end
