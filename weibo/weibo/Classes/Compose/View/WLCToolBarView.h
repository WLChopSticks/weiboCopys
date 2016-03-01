//
//  WLCToolBarView.h
//  weibo
//
//  Created by 王 on 16/3/1.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLCToolBarView;
@protocol toolBarViewDelegate <NSObject>

- (void)toolBarView: (WLCToolBarView *)toolBarView didClickToolBarButton: (UIButton *)toolBarBtn;

@end

typedef enum : NSUInteger {
    WLCComposeToolBarCamera = 100,
    WLCComposeToolBarPicture,
    WLCComposeToolBarMention,
    WLCComposeToolBarTrend,
    WLCComposeToolBarEmotion
} WLCToolBarButtonType;

@interface WLCToolBarView : UIView

@property (weak, nonatomic) id <toolBarViewDelegate> delegate;

@end
