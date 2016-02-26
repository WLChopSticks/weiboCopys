//
//  WLCPictureView.m
//  weibo
//
//  Created by 王 on 16/2/26.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCPictureView.h"
#import "WLCPictureViewCell.h"
#import "Masonry.h"

#define PICTURE_CELL @"pictureCell"
#define PICTURE_MARGIN 5

@interface WLCPictureView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) UILabel *label;

@end

@implementation WLCPictureView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = PICTURE_MARGIN;
    flowLayout.minimumInteritemSpacing = 0;
    if (self = [super initWithFrame:frame collectionViewLayout:flowLayout]) {
        
        [self decorateUI];
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[WLCPictureViewCell class] forCellWithReuseIdentifier:PICTURE_CELL];
    }
    
    return self;
}


- (void)decorateUI {
    
//    NSLog(@"%d",self.imageURLs.count);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    label.textColor = [UIColor whiteColor];
//    label.center = self.center;

    self.label = label;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_centerX);
                make.centerY.equalTo(self.mas_centerY);
            }];
}

- (void)setImageURLs:(NSArray *)imageURLs {
    _imageURLs = imageURLs;
    
    self.label.text = [NSString stringWithFormat:@"%ld",imageURLs.count];
    
    CGSize viewSize = [self calculatePictureSize];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(viewSize);
    }];
    
    [self reloadData];
    
}

//根据图片数量计算collectionvieww尺寸
- (CGSize)calculatePictureSize {
    //取出layout 用于计算图片打小
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    switch (self.imageURLs.count) {
        case 0:
            return CGSizeZero;
            break;
        case 1: {
            CGSize size = CGSizeMake(100, 100);
            layout.itemSize = size;
            return size;
            break;
        }
        case 4: {
            CGFloat pictureW = (ScreenWidth - 4 * PICTURE_MARGIN) / 3.0;
            layout.itemSize = CGSizeMake(pictureW, pictureW);
//            return CGSizeMake(pictureW, pictureW);
            return CGSizeMake(pictureW * 2 + 2 * PICTURE_MARGIN, pictureW * 2 + 2 * PICTURE_MARGIN);
            break;
        }
        default: {
            CGFloat pictureW = (ScreenWidth - 4 * PICTURE_MARGIN) / 3.0;
            layout.itemSize = CGSizeMake(pictureW, pictureW);
            CGFloat row = (self.imageURLs.count - 1) / 3 + 1;
            return CGSizeMake(ScreenWidth - 2 * PICTURE_MARGIN, (row * pictureW + (row + 1) * PICTURE_MARGIN));
            break;
        }
    }
}

#pragma -mark 显示图片的数据源方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageURLs.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WLCPictureViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PICTURE_CELL forIndexPath:indexPath];
//    cell.backgroundColor = randomColor;
    cell.imageURL = self.imageURLs[indexPath.item];

    
    
    return cell;
}


@end
