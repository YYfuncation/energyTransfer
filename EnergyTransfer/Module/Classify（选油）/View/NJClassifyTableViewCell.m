//
//  NJClassifyTableViewCell.m
//  EnergyTransfer
//
//  Created by Liandi on 2019/2/14.
//  Copyright © 2019年 Liandi. All rights reserved.
//

#import "NJClassifyTableViewCell.h"
#import "Marco.h"

@interface NJClassifyTableViewCell ()

@property (nonatomic, strong) UIView *yellowView;

@end

@implementation NJClassifyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenW/3 - 10, 40)];
        self.name.textAlignment = NSTextAlignmentCenter;
        self.name.font = [UIFont systemFontOfSize:14];
        self.name.textColor = [UIColor blackColor];
        self.name.highlightedTextColor = [UIColor blackColor];
        [self.contentView addSubview:self.name];
        
        self.yellowView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 5, 30)];
        self.yellowView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.yellowView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor colorWithWhite:0 alpha:0.1];
    self.highlighted = selected;
    self.name.highlighted = selected;
    self.yellowView.hidden = !selected;
}

@end
