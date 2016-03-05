//
//  WLCEmotionStirngChangedImage.m
//  weibo
//
//  Created by 王 on 16/3/5.
//  Copyright © 2016年 WLChopSticks. All rights reserved.
//

#import "WLCEmotionStirngChangedImage.h"
#import "WLCEmotionLoad.h"
#import "WLCEmotionGroup.h"
#import "WLCEmotionModel.h"

@implementation WLCEmotionStirngChangedImage


+(NSAttributedString *)emotionStirngChangeToEmotionImage:(NSString *)text andFont:(UIFont *)font {

    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:text];
    
    //匹配表情字符串
    NSString *pattern = @"\\[.*?\\]";
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray *matchArray = [regular matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    
    //遍历所有匹配到的表情字符串
    int index = (int)matchArray.count - 1;
    for (int i = index; i >= 0; i--) {
        NSTextCheckingResult *result = matchArray[i];
        NSString *emotionStr = [text substringWithRange:result.range];
        
        WLCEmotionLoad *emotionL = [[WLCEmotionLoad alloc]init];
        NSArray *emotionArray = [emotionL loadEmotionFile];
        BOOL isFound = NO;
        for (WLCEmotionGroup *emotionGroup in emotionArray) {
            if (isFound) {
                break;
            }
            NSArray *emotions = emotionGroup.emoticons;
            for (WLCEmotionModel *emotionModel in emotions) {
                if ([emotionStr isEqualToString:emotionModel.chs]) {
                    //找到表情 将其替换成表情图片
                    isFound = YES;
                    
                    //1.通过模型取出图片地址并读取图片
                    UIImage *image = [UIImage imageNamed:emotionModel.imagePath];
                    //2.初始化富文本的附件,并将图片赋值给附件
                    NSTextAttachment *emotionAttach = [[NSTextAttachment alloc]init];
                    emotionAttach.image = image;
                    emotionAttach.bounds = CGRectMake(0, -4, font.lineHeight, font.lineHeight);
                    //3.将附件赋给富文本字符串
                    NSAttributedString *emotionAttr = [NSAttributedString attributedStringWithAttachment:emotionAttach];
                    [attrString replaceCharactersInRange:result.range withAttributedString:emotionAttr];
                    break;
                    
                    
                }
            }
        }
    }
    
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attrString.length)];
    
    return attrString.copy;


}


@end
