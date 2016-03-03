//
//  WLCEmotionListView.m
//  weibo
//
//  Created by 王 on 16/3/2.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCEmotionListView.h"
#import "WLCEmotionCell.h"

#define MAX_EMOTIONS_IN_PAGE 20
#define EMOTION_MARGIN 1
#define ID @"emotion"

@interface WLCEmotionListView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) UIPageControl *pageControl;
@property (weak, nonatomic) UICollectionView *emotionCollectionView;

@end

@implementation WLCEmotionListView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        [self decorateUI];
    }
    
    return self;
}

#pragma -mark 布局
- (void)decorateUI {
//    self.backgroundColor = randomColor;
    
    //添加表情页
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = EMOTION_MARGIN;
    layout.minimumInteritemSpacing = 0;
    CGFloat itemW = (ScreenWidth - 6 * EMOTION_MARGIN) / 7;
    layout.itemSize = CGSizeMake(itemW, itemW);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *emotionCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    self.emotionCollectionView = emotionCollectionView;
    //collectionView注册cell
    [self.emotionCollectionView registerClass:[WLCEmotionCell class] forCellWithReuseIdentifier:ID];
    
    
    
    emotionCollectionView.dataSource = self;
    emotionCollectionView.delegate = self;
    
    emotionCollectionView.showsHorizontalScrollIndicator = NO;
    emotionCollectionView.pagingEnabled = YES;
    [self addSubview:emotionCollectionView];
    
    
    
    //添加pageControl
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    self.pageControl = pageControl;
    pageControl.backgroundColor = randomColor;
    [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"_pageImage"];
    [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"_currentPageImage"];
    [self addSubview:pageControl];
    
    //约束
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(10);
    }];
    
    //表情页约束
    [emotionCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.pageControl.mas_top);
        
    }];
    
}

#pragma -mark 设置emotion模型时,计算需要有多少页
-(void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    
    NSInteger pageCount = (emotions.count + MAX_EMOTIONS_IN_PAGE - 1) / MAX_EMOTIONS_IN_PAGE;
    NSLog(@"%ld",pageCount);
    self.pageControl.numberOfPages = pageCount;
    
    [self.emotionCollectionView reloadData];
    
    if (pageCount != 0) {
        [self.emotionCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:self.toolBarButtonType] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
}

#pragma -mark 单个小表情在collectionView上显示
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.pageControl.numberOfPages;
//    return 3;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 21;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WLCEmotionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.imageName = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
    
    return cell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f",scrollView.contentOffset.x);
    self.pageControl.currentPage = (scrollView.contentOffset.x / 375);
}




@end






