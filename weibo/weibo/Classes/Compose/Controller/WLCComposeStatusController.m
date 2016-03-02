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
#import "WLCToolBarView.h"
#import "WLCComposePhotoView.h"
#import "WLCEmotionKeyboard.h"

@interface WLCComposeStatusController ()<UITextViewDelegate,toolBarViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) WLCTextView *textInputView;
@property (weak, nonatomic) WLCToolBarView *toolBar;
@property (weak, nonatomic) WLCComposePhotoView *photoView;
@property (weak, nonatomic) WLCEmotionKeyboard *emotionKeyboard;
//判断是否点击了表情键盘
@property (assign, nonatomic) BOOL UsingEmotionKeyboard;

@end

@implementation WLCComposeStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = randomColor;
    
    [self decorateUI];
    // Do any additional setup after loading the view.
    
    //进入界面,调出键盘
    [self.view becomeFirstResponder];
    
    //检测键盘frame的变化
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardFramHasChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
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
    textView.alwaysBounceVertical = YES;
    textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:textView];
    
    //设置照片View
    WLCComposePhotoView *photoView = [[WLCComposePhotoView alloc]init];
    self.photoView = photoView;
    [self.view addSubview:photoView];
    
    //设置toolBar
    WLCToolBarView *toolBar = [[WLCToolBarView alloc]init];
    self.toolBar = toolBar;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    
    
    
    
    //约束
    //textView约束
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(ScreenHeight);
    }];
    
    //toolBar约束
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(30);
    }];
    
    //photoView约束
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(toolBar.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(0);
    }];
    
}


//返回按钮点击
- (void)returnBtnClicking {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendBtnClicking {
    NSLog(@"发送点击了");
    NSLog(@"%@",self.photoView.imageArray);
    
}



#pragma -mark textView代理方法
- (void)textViewDidChange:(UITextView *)textView {
    //有文字输入时,提示label消失
    self.textInputView.tipLabel.hidden = !(textView.text.length == 0);
    
    self.navigationItem.rightBarButtonItem.enabled = !(textView.text.length == 0);
    
}

#pragma -mark toolBar代理方法
- (void)toolBarView:(WLCToolBarView *)toolBarView didClickToolBarButton:(UIButton *)toolBarBtn {
    
    switch (toolBarBtn.tag) {
        case WLCComposeToolBarCamera: {

            //调出相机
            //并提前判断相机是否可用,以免崩溃
            BOOL result = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
            if (result) {
                [self chooseImageWithType:UIImagePickerControllerSourceTypeCamera];
            }else {
                NSLog(@"相机不可用");
            }
            
            NSLog(@"%lu",(unsigned long)WLCComposeToolBarCamera);
            break;
        }
        case WLCComposeToolBarPicture: {
            
            //调出系统图片
            BOOL result = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
            if (result) {
                if (self.photoView.imageArray.count < 9) {
                    [self chooseImageWithType:UIImagePickerControllerSourceTypePhotoLibrary];
                } else {
                    NSLog(@"图片已满");
                }
                
            } else {
                NSLog(@"相册不可用");
            }
            
            NSLog(@"%lu",(unsigned long)WLCComposeToolBarPicture);
            break;
        }
        case WLCComposeToolBarMention:
            NSLog(@"%lu",(unsigned long)WLCComposeToolBarMention);
            break;
        case WLCComposeToolBarTrend:
            NSLog(@"%lu",(unsigned long)WLCComposeToolBarTrend);
            break;
        case WLCComposeToolBarEmotion: {
            NSLog(@"%lu",(unsigned long)WLCComposeToolBarEmotion);
            [self changeEmotionKeyboard];
            break;
        }
            
        default:
            break;
    }
}

//选择相册或者照相机的方法
- (void)chooseImageWithType: (UIImagePickerControllerSourceType)type {
    
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc]init];
    pickerVC.sourceType = type;
    pickerVC.delegate = self;
    
    [self presentViewController:pickerVC animated:YES completion:nil];
}

//切换表情键盘
- (void)changeEmotionKeyboard {
    
    if (!self.UsingEmotionKeyboard) {
        WLCEmotionKeyboard *emotionKeyboard = [[WLCEmotionKeyboard alloc]init];
        self.emotionKeyboard = emotionKeyboard;
        self.textInputView.inputView = emotionKeyboard;
        self.UsingEmotionKeyboard = YES;
    } else {
        self.textInputView.inputView = nil;
        [self.emotionKeyboard removeFromSuperview];
        self.UsingEmotionKeyboard = NO;
    }
    [self.textInputView endEditing:YES];
    [self.textInputView becomeFirstResponder];
    
    
}

#pragma -mark 键盘呼出代理方法
//收到键盘弹出通知
- (void)keyboardFramHasChanged:(NSNotification *)notice {
    
    
    NSDictionary *userInfo = notice.userInfo;
//    NSLog(@"%@",userInfo);
    
    
    CGRect rect = [[userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat offsetY = -ScreenHeight + rect.origin.y;
    
    [self.toolBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(offsetY);
    }];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:9 initialSpringVelocity:5 options:0 animations:^{
        
        if (offsetY >= 0) {
            self.photoView.alpha = 1;
            
        } else {
            self.photoView.alpha = 0;
            
            
            //设置一个让键盘消失按钮
            UIButton *endEditBtn = [[UIButton alloc]initWithFrame:CGRectMake(300, 350, 50, 30)];
            [endEditBtn setTitle:@"完成" forState:UIControlStateNormal];
            [endEditBtn addTarget:self action:@selector(endEditBtnClicking:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:endEditBtn];

        }
        
        
        [self.view layoutIfNeeded];

    } completion:nil];


    
}

#pragma -mark 选取图片代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"%@",info);
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    NSLog(@"%@11",image);
   
    [self.photoView addImageToPhotoView:image];
    [picker dismissViewControllerAnimated:YES completion:^{

    }];
    
}


#pragma -mark 收起键盘代理方法
- (void)endEditBtnClicking: (UIButton *)sender {
    [self.textInputView endEditing:YES];
    [sender removeFromSuperview];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.textInputView endEditing:YES];
    
}

//移除通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//懒加载
-(WLCEmotionKeyboard *)emotionKeyboard {
    if (_emotionKeyboard == nil) {
        _emotionKeyboard = [[WLCEmotionKeyboard alloc]init];
    }
    return _emotionKeyboard;
}





@end
