//
//  BTTestSelfOptionView.h
//  UnitTestDemoTests
//
//  Created by MacOS on 17/7/21.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTTestSelfOptionView : UIView

//选项按钮标题
@property (nonatomic,copy)NSString *optionBtnTitle;

//选项内容
@property (nonatomic,copy)NSString *optionLabText;

//事件响应回调
@property (nonatomic,copy)void(^btnClickBlock)(BTTestSelfOptionView *,UIButton *);

//是否选中
@property (nonatomic,assign)BOOL isSelected;

/**
 初始化视图

 @param frame 框架大小
 @param optionBtnTitle 选项按钮标题
 @param optionContent 选项内容
 @return TestSelfOptionView 视图
 */
- (instancetype)initWithFrame:(CGRect)frame BtnTitle:(NSString *)optionBtnTitle Content:(NSString *)optionContent;


@end
