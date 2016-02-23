//
//  WLCNewFeatureController.m
//  weibo
//
//  Created by 王 on 16/2/19.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCNewFeatureController.h"
#import "WLCOAuthController.h"

#define NEWFEATURE_IMAGECOUNT 4

@interface WLCNewFeatureController ()<UIScrollViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) UIPageControl *pageControl;
@property (weak, nonatomic) UIButton *enterBtn;

@end

@implementation WLCNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = randomColor;
    //设置scrollview
    [self decorateUI];
}


- (void)decorateUI {
    
    //设置滚动图片
    UIScrollView *newView = [[UIScrollView alloc]initWithFrame:ScreenBounds];
    newView.delegate = self;

    for (int i = 0; i < NEWFEATURE_IMAGECOUNT; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:ScreenBounds];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d",i + 1]];
        [newView addSubview:imageView];
        imageView.x = i * ScreenWidth;
        
        //给最后一个图片添加进入按钮
        if (i == NEWFEATURE_IMAGECOUNT - 1) {
            UIButton *enterBtn = [[UIButton alloc]init];
            self.enterBtn = enterBtn;
            [enterBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
            [enterBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
            [enterBtn setTitle:@"进入微博" forState:UIControlStateNormal];
            [enterBtn sizeToFit];
            enterBtn.centerX = ScreenWidth * 0.5;
            enterBtn.y = ScreenHeight * 0.75;
            [imageView addSubview:enterBtn];
            imageView.userInteractionEnabled = YES;
            [enterBtn addTarget:self action:@selector(enterBtnClicking) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
    }
    //设置滚动范围
    newView.contentSize = CGSizeMake(NEWFEATURE_IMAGECOUNT * ScreenWidth, ScreenHeight);
    newView.pagingEnabled = YES;
    newView.bounces = NO;
    newView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:newView];
    
    //设置pageControl
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    self.pageControl = pageControl;
    pageControl.centerX = self.view.centerX;
    pageControl.y = ScreenHeight * 0.9;
    pageControl.numberOfPages = NEWFEATURE_IMAGECOUNT;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:pageControl];
    
}

//监听scrollview的滑动,改变pagecontrol
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    self.pageControl.currentPage = scrollView.contentOffset.x / ScreenWidth;

}

//进入按钮点击事件
- (void)enterBtnClicking {
    NSLog(@"进入微博按钮点击");
    WLCOAuthController *oauthVC = [[WLCOAuthController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = oauthVC;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
