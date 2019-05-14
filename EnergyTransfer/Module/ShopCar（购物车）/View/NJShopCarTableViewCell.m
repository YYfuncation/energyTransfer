//
//  NJShopCarTableViewCell.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/12/3.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJShopCarTableViewCell.h"
#import "MBProgressHUD+LYHud.h"

@interface NJShopCarTableViewCell ()<UITextFieldDelegate>
@property (nonatomic,assign)NSInteger  addCount;
@property (nonatomic,assign)BOOL isHaveDian;
@end
@implementation NJShopCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.addCount = 1;
    /** 设置lab的边角*/
    [self setAddReduceBorderLayer];
    
    /** lab可以点击*/
    [self setReduceAndAddLabCanClick];
    
    self.delectBut.layer.borderWidth = 0.5;
    self.delectBut.layer.borderColor = [[UIColor blackColor]colorWithAlphaComponent:0.4].CGColor;
    self.centerNum.delegate = self;
    
//    self.centerNum.minimumFontSize = 8;
//    self.centerNum.adjustsFontSizeToFitWidth = YES;
    self.isHaveDian = YES;
    
}
#pragma mark - 设置lab的边角
-(void)setAddReduceBorderLayer{
    
    [self.labContentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.layer.borderWidth = 0.5;
        
        obj.layer.borderColor = [[UIColor blackColor]colorWithAlphaComponent:0.4].CGColor;
    }];
    
}
#pragma mark - lab可以点击
-(void)setReduceAndAddLabCanClick{
    
    self.leftReduce.userInteractionEnabled = YES;
    
    self.rightAdd.userInteractionEnabled = YES;
    
    self.img.userInteractionEnabled = YES;
    self.nameLab.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapLeft = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftClick:)];
    
    [self.leftReduce addGestureRecognizer:tapLeft];
    
    UITapGestureRecognizer *tapRight = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightClick:)];
    
    [self.rightAdd addGestureRecognizer:tapRight];
    
    UITapGestureRecognizer *tapImg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImgClick:)];
    
    [self.img addGestureRecognizer:tapImg];
    UITapGestureRecognizer *tapLab = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LabClick:)];
    
    [self.nameLab addGestureRecognizer:tapLab];
    
}
-(void)ImgClick:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(imgClick:)]) {
        [self.delegate imgClick:self];
    }
}
-(void)LabClick:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(LabClick:)]) {
        [self.delegate LabClick:self];
    }
}
#pragma mark - 手势事件  左边递减
-(void)leftClick:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(leftClick:number:)]) {
        [self.delegate leftClick:self number:self.centerNum.text.floatValue];
    }
}

#pragma mark - 手势事件  右边递增
-(void)rightClick:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(rightClick:number:)]) {
        [self.delegate rightClick:self number:self.centerNum.text.floatValue];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    //判断不能输入都为0
    if (textField.text.floatValue == 0) {
        [MBProgressHUD showWithString:@"您的输入格式不正确"];
    }
    if ([self.delegate respondsToSelector:@selector(centerNum:number:)]) {
        [self.delegate centerNum:self number:textField.text.floatValue];
    }
}
/**
 *  textField的代理方法，监听textField的文字改变
 *  textField.text是当前输入字符之前的textField中的text
 *
 *  @param textField textField
 *  @param range     当前光标的位置
 *  @param string    当前输入的字符
 *
 *  @return 是否允许改变
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /*
     * 不能输入.0-9以外的字符。
     * 设置输入框输入的内容格式
     * 只能有一个小数点
     * 小数点后最多能输入三位
     * 如果第一位是.则前面加上0.
     * 如果第一位是0则后面必须输入点，否则不能输入。
     */
    
    // 判断是否有小数点
    if ([textField.text containsString:@"."]) {
        self.isHaveDian = YES;
    }else{
        self.isHaveDian = NO;
    }
    
    if (string.length > 0) {
        
        //当前输入的字符
        unichar single = [string characterAtIndex:0];
        NSLog(@"single = %c",single);
        
        // 不能输入.0-9以外的字符
        if (!((single >= '0' && single <= '9') || single == '.'))
        {
            [MBProgressHUD showWithString:@"您的输入格式不正确"];
            return NO;
        }
        
        // 只能有一个小数点
        if (self.isHaveDian && single == '.') {
            [MBProgressHUD showWithString:@"最多只能输入一个小数点"];
            return NO;
        }
        
        // 如果第一位是.则前面加上0.
        if ((textField.text.length == 0) && (single == '.')) {
            textField.text = @"0";
        }
        
        // 如果第一位是0则后面必须输入点，否则不能输入。
        if ([textField.text hasPrefix:@"0"]) {
            if (textField.text.length > 1) {
                NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                if (![secondStr isEqualToString:@"."]) {
                    [MBProgressHUD showWithString:@"第二个字符需要是小数点"];
                    return NO;
                }
            }else{
                if (![string isEqualToString:@"."]) {
                    [MBProgressHUD showWithString:@"第二个字符需要是小数点"];
                    return NO;
                }
            }
        }
        
        // 小数点后最多能输入两位
        if (self.isHaveDian) {
            NSRange ran = [textField.text rangeOfString:@"."];
            // 由于range.location是NSUInteger类型的，所以这里不能通过(range.location - ran.location)>2来判断
            if (range.location > ran.location) {
                if ([textField.text pathExtension].length > 2) {
                    [MBProgressHUD showWithString:@"小数点后最多有三位小数"];
                    return NO;
                }
            }
        }
        
    }
    
    return YES;
}
@end
