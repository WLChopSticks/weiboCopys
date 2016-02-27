//
//  WLCPictureViewCell.h
//  weibo
//
//  Created by 王 on 16/2/26.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCPictureViewCell : UICollectionViewCell

@property (strong, nonatomic) NSURL *imageURL;

@property (weak, nonatomic) UIImageView *imageView;

@end
