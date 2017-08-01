//
//  BTTestSelfView.m
//  UnitTestDemoTests
//
//  Created by MacOS on 17/7/21.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "BTTestSelfView.h"
#import "BTTestSelfOptionView.h"

static CGFloat const defaultHeight = 50;

@interface BTTestSelfView ()

//!< 自测标题
@property (nonatomic,strong)UILabel *titleLab;

@end

@implementation BTTestSelfView
{
    BTTestSelfOptionView *_currentOptionView;//当前选中按钮
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {

    }
    return self;
}


- (void)setQuestion:(BTTestQuestionsItem *)question{

    _question = question;
    _currentOptionView = nil;

    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }

    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, CGRectGetWidth(self.bounds) - 20, 50)];
    [self addSubview:self.titleLab];

    CGFloat titleHeight = [self getOptionContentHeightWithContent:self.question.questionTitle].height;
    (defaultHeight > titleHeight) ? (titleHeight = defaultHeight) : titleHeight;
    CGRect frame = self.titleLab.frame;
    frame.size.height = titleHeight + 10;
    self.titleLab.frame = frame;
    self.titleLab.text = self.question.questionTitle;

    CGFloat optionY = 20 + CGRectGetMaxY(self.titleLab.bounds);
    CGFloat margin = 10;

    for (int i = 0; i < self.question.optionsArr.count; i++) {

        BTOptionItem *optionItem = self.question.optionsArr[i];

        CGSize size = [self getOptionContentHeightWithContent:optionItem.optionContent];

        defaultHeight > size.height ? (size.height = defaultHeight) : (size.height += 15);

        BTTestSelfOptionView *optionView =[[BTTestSelfOptionView alloc]initWithFrame:CGRectMake(0,optionY,self.frame.size.width,size.height + margin) BtnTitle:optionItem.option Content:optionItem.optionContent];
        [self addSubview:optionView];

        optionY = optionY + size.height + margin;

        optionView.tag = i ;

        optionView.isSelected = NO;

        optionView.btnClickBlock = ^(BTTestSelfOptionView *currentOption,UIButton *optionBtn){

            if ((_currentOptionView != nil && _currentOptionView.tag == currentOption.tag)) {
                if (_currentOptionView.isSelected) {
                    _currentOptionView.isSelected = NO;
                }else{
                    _currentOptionView.isSelected = YES;
                    _currentOptionView = currentOption;
                    self.selectBlock(self,optionBtn.titleLabel.text);
                }
            }else{
                _currentOptionView.isSelected = NO;
                if (optionBtn.selected) {
                    optionBtn.backgroundColor =[UIColor whiteColor];
                    [optionBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                    optionBtn.selected = NO;
                }else{
                    optionBtn.backgroundColor =[UIColor redColor];
                    [optionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    optionBtn.selected = YES;
                    _currentOptionView = currentOption;
                    self.selectBlock(self,optionBtn.titleLabel.text);
                }
            }
        };
    }

}


- (CGSize)getOptionContentHeightWithContent:(NSString *)content{
    
    CGSize size = [content boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.bounds),10000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;

    return size;
}


@end
