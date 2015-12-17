//
//  WSSwipeCell.m
//  SwipeCell
//
//  Created by Steven on 15/12/17.
//  Copyright © 2015年 Steven. All rights reserved.
//

#import "WSSwipeCell.h"
#import "Define.h"

@implementation WSSwipeItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 50;
        self.btnWidth = 50;
        self.btnTitles = nil;
        self.btnBgColors = nil;
    }
    
    return self;
}

@end



@interface WSSwipeCell()
@end

@implementation WSSwipeCell
@dynamic item;

- (void)cellDidLoad
{
    [super cellDidLoad];
    

    self.contentView.backgroundColor = [UIColor orangeColor];
    
    UILabel *aLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
    aLable.backgroundColor = [UIColor brownColor];
    aLable.text = @"aLabel";
    aLable.font = [UIFont systemFontOfSize:15];
    aLable.textColor = [UIColor whiteColor];
    aLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:aLable];
    
    UILabel *bLable = [[UILabel alloc]initWithFrame:CGRectMake(WSScreenWidth-80, 0, 80, 50)];
    bLable.backgroundColor = [UIColor brownColor];
    bLable.text = @"bLabel";
    bLable.font = [UIFont systemFontOfSize:15];
    bLable.textColor = [UIColor whiteColor];
    bLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:bLable];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeftHandle:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.contentView addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRightHandle:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.contentView addGestureRecognizer:swipeRight];
}

- (void)swipeLeftHandle:(UISwipeGestureRecognizer *)swipe
{
    WS(bself);
    
    BOOL isSwipeLeft = NO;
    NSInteger rows = [self.parentTableView numberOfRowsInSection:0];
    for (int i=0; i<rows; i++) {
        WSSwipeCell *cell = (WSSwipeCell *)[self.parentTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell &&
            cell.contentView.frame.origin.x != 0 &&
            [cell isKindOfClass:[WSSwipeCell class]] && [cell respondsToSelector:@selector(swipeRightHandle:)])
        {
            [cell swipeRightHandle:nil];
            isSwipeLeft = YES;
        }
    }
    
    if (!isSwipeLeft) {
        CGFloat originX = self.contentView.frame.origin.x;
        if (originX == 0)
        {
            [UIView animateWithDuration:self.item.btnTitles.count * 0.1 animations:^{
                bself.contentView.frame = CGRectMake(-self.item.btnWidth*self.item.btnTitles.count, 0, bself.contentView.frame.size.width, bself.contentView.frame.size.height);
            } completion:^(BOOL finished) {
                CGFloat x = bself.contentView.frame.origin.x;
                CGFloat xOffset = 3;
                //  回弹效果
                [UIView animateWithDuration:0.05 animations:^{
                    bself.contentView.frame = CGRectMake(x-xOffset, 0, bself.contentView.frame.size.width, bself.contentView.frame.size.height);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.05 animations:^{
                        bself.contentView.frame = CGRectMake(x, 0, bself.contentView.frame.size.width, bself.contentView.frame.size.height);
                    } completion:nil];
                }];
            }];
        } else {
            [self swipeRightHandle:nil];
        }
    }
}

- (void)swipeRightHandle:(UISwipeGestureRecognizer *)swipe
{
    WS(bself);
    [UIView animateWithDuration:self.item.btnTitles.count * 0.1 animations:^{
        bself.contentView.frame = CGRectMake(0, 0, bself.contentView.frame.size.width, bself.contentView.frame.size.height);
    } completion:nil];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    [self addBackBtns];
}

- (void)addBackBtns
{
    self.contentView.superview.backgroundColor = self.contentView.backgroundColor;

    for (int i=0; i < self.item.btnTitles.count; i++)
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(WSScreenWidth-self.item.btnWidth*(i+1), 0, self.item.btnWidth, self.item.cellHeight)];
        btn.backgroundColor = self.item.btnBgColors[i];
        [btn setTitle:self.item.btnTitles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView.superview insertSubview:btn belowSubview:self.contentView];
    }
}

- (void)btnClick:(UIButton *)btn
{
    if (self.item.btnClick)
    {
        self.item.btnClick(btn.titleLabel.text);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
