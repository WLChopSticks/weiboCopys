//
//  WLCTitlePopMenuView.h
//  weibo
//
//  Created by 王 on 16/2/19.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLCTitlePopMenuView;
@protocol titlePopMenuViewDelegate <NSObject>

- (void)titlePopMenuView: (WLCTitlePopMenuView *)titlePopMenuView didClickBackImage:(UIView *)backImage;

@end

@interface WLCTitlePopMenuView : UIView

@property (weak, nonatomic) id<titlePopMenuViewDelegate> delegate;

@end
