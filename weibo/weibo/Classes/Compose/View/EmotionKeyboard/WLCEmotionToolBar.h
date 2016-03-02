//
//  WLCEmotionToolBar.h
//  weibo
//
//  Created by 王 on 16/3/2.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WLCEmotionToolBarButtonTypeRecent,
    WLCEmotionToolBarButtonTypeDefault,
    WLCEmotionToolBarButtonTypeEmoji,
    WLCEmotionToolBarButtonTypeLxh
} WLCEmotionToolBarButtonType;

@class WLCEmotionToolBar;
@protocol emotionToolBarDelegate <NSObject>

- (void)emotionToolBar: (WLCEmotionToolBar *)emotionToolBar buttonClickWithType: (WLCEmotionToolBarButtonType)type;

@end

@interface WLCEmotionToolBar : UIView

@property (weak, nonatomic) id<emotionToolBarDelegate> delegate;

@end
