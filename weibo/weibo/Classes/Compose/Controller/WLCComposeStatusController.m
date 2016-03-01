//
//  WLCComposeStatusController.m
//  weibo
//
//  Created by 王 on 16/2/29.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCComposeStatusController.h"
#import "WLCTextView.h"
#import "WLCTitleView.h"

@interface WLCComposeStatusController ()<UITextViewDelegate>

@property (weak, nonatomic) WLCTextView *textInputView;

@end

@implementation WLCComposeStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = randomColor;
    
    [self decorateUI];
    // Do any additional setup after loading the view.
    
    //进入界面,调出键盘
    [self.textInputView becomeFirstResponder];
}


#pragma -mark 布局
- (void)decorateUI {

    //navigationbar左右两端按钮
    UIBarButtonItem *returnBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(returnBtnClicking)];
    returnBtn.tintColor = [UIColor orangeColor];
    self.navigationItem.leftBarButtonItem = returnBtn;
    
    UIBarButtonItem *sendBtn = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendBtnClicking)];
    sendBtn.tintColor = [UIColor orangeColor];
    sendBtn.enabled = NO;
    self.navigationItem.rightBarButtonItem = sendBtn;
    
    //titleview
    WLCTitleView *titleView = [[WLCTitleView alloc]initWithFrame:CGRectMake(0, 0, 150, 35)];
    self.navigationItem.titleView = titleView;
    
    //输入文字textView
    WLCTextView *textView = [[WLCTextView alloc]init];
    textView.delegate = self;
    self.textInputView = textView;
    textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:textView];
    
    
    
    //约束
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(ScreenHeight * 0.5);
    }];
    
}


//返回按钮点击
- (void)returnBtnClicking {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendBtnClicking {
    NSLog(@"发送点击了");
}



#pragma -mark textView代理方法
-(void)textViewDidChange:(UITextView *)textView {
    //有文字输入时,提示label消失
    self.textInputView.tipLabel.hidden = !(textView.text.length == 0);
    
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
