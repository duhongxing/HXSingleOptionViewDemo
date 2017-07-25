//
//  BTTestSelfOptionView.m
//  UnitTestDemoTests
//
//  Created by MacOS on 17/7/21.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "BTTestSelfOptionView.h"
#import "SDAutoLayout.h"

static CGFloat const defaultHeight = 50;

@interface BTTestSelfOptionView ()

//选项按钮 eg:A/B/C/D
@property (nonatomic,strong)UIButton *optionBtn;

//选项内容 eg:刚刚毕业或将要毕业
@property (nonatomic,strong)UILabel *optionLab;

@end

@implementation BTTestSelfOptionView


- (instancetype)initWithFrame:(CGRect)frame BtnTitle:(NSString *)optionBtnTitle Content:(NSString *)optionContent{

    if (self = [super initWithFrame:frame]) {

        CGSize size = [self getOptionContentHeightWithContent:optionContent];
        size.height += 10;

        defaultHeight > size.height ? (size.height = defaultHeight) : size.height;

        CGRect newframe = self.frame;
        newframe.size.height = size.height;
        self.frame = newframe;

        self.optionBtnTitle = optionBtnTitle;
        self.optionLabText = optionContent;

        [self addMySubVies];

        UITapGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClickAction:)];
        [self addGestureRecognizer:tapGesture];
    }

    return self;
}


- (void)addMySubVies{
    
    _optionBtn =[UIButton new];
    _optionLab =[UILabel new];
    [self sd_addSubviews:@[_optionBtn,_optionLab]];;

    _optionBtn.sd_layout.leftSpaceToView(self,5).topSpaceToView(self,(self.height - 40)/2)
    .widthIs(40).heightIs(40);
    _optionBtn.layer.cornerRadius = _optionBtn.width/2;
    _optionBtn.layer.borderColor = [UIColor blueColor].CGColor;
    _optionBtn.layer.borderWidth = 1;
    [_optionBtn setTitle:self.optionBtnTitle forState:UIControlStateNormal];
    [_optionBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _optionBtn.titleLabel.font = [UIFont systemFontOfSize:17 weight:0.5];
    [_optionBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    _optionLab.sd_layout.leftSpaceToView(_optionBtn,5).topSpaceToView(self,5).widthIs(self.frame.size.width - 50).bottomSpaceToView(self,5);
    _optionLab.text = self.optionLabText;
    _optionLab.font = [UIFont systemFontOfSize:15];
    _optionLab.numberOfLines = 0;

}

- (void)setIsSelected:(BOOL)isSelected{
    if (!_isSelected) {
        _optionBtn.backgroundColor =[UIColor whiteColor];
        [_optionBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _optionBtn.selected = NO;
    }else{
        _optionBtn.backgroundColor =[UIColor redColor];
        [_optionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _optionBtn.selected = YES;
    }
}


#pragma mark - === event response ===

- (void)clickBtnAction:(UIButton *)btn{
    self.btnClickBlock(self,btn);
}

- (void)tapClickAction:(UITapGestureRecognizer *)gesture{
    self.btnClickBlock(self,_optionBtn);
}

#pragma mark - === private method ===

- (CGSize)getOptionContentHeightWithContent:(NSString *)content{
    CGSize size = [content boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 40,10000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    return size;
}

@end
