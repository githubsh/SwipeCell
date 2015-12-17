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
        self.cellHeight = 60;
        self.btnWidth = 50;
        self.btnTitles = nil;
        self.btnBgColors = nil;
    }
    
    return self;
}

@end



@interface WSSwipeCell()

@property (nonatomic, assign) BOOL isSwipeLeft;

@end

@implementation WSSwipeCell
@dynamic item;

- (void)cellDidLoad
{
    [super cellDidLoad];
    
    self.contentView.backgroundColor = [UIColor brownColor];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    img.image = [UIImage imageNamed:@"Card_Stack"];
    [self.contentView addSubview:img];
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10+40+10, 10, WSScreenWidth-60, 20)];
    titlelabel.text = @"titlelabel";
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:titlelabel];
    
    UILabel *detailTextlabel = [[UILabel alloc]initWithFrame:CGRectMake(10+40+10, 30, WSScreenWidth-60, 20)];
    detailTextlabel.text = @"detailTextlabel";
    detailTextlabel.textColor = [UIColor whiteColor];
    detailTextlabel.backgroundColor = [UIColor clearColor];
    detailTextlabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:detailTextlabel];
    
    UILabel *sep = [[UILabel alloc]initWithFrame:CGRectMake(5, 59.5, WSScreenWidth-5, 0.5)];
    sep.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:sep];

    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeftHandle:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.contentView addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRightHandle:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.contentView addGestureRecognizer:swipeRight];
}

- (BOOL)checkSwipeLeft
{
    NSInteger rows = [self.parentTableView numberOfRowsInSection:0];
    for (int i=0; i < rows; i++)
    {
        WSSwipeCell *cell = (WSSwipeCell *)[self.parentTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell &&
            [cell isKindOfClass:[WSSwipeCell class]] &&
            cell.contentView.frame.origin.x != 0)
        {
            return YES;
        }
    }
    
    return NO;
}

- (void)swipeLeftHandle:(UISwipeGestureRecognizer *)swipe
{
    if ([self checkSwipeLeft])
    {
        NSInteger rows = [self.parentTableView numberOfRowsInSection:0];
        for (int i=0; i < rows; i++)
        {
            WSSwipeCell *cell = (WSSwipeCell *)[self.parentTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (cell &&
                [cell isKindOfClass:[WSSwipeCell class]] &&
                cell.contentView.frame.origin.x != 0)
            {
                [cell swipeToRight];
            }
        }
        
    }
    else
    {
        CGFloat originX = self.contentView.frame.origin.x;
        if (originX == 0)
        {
            [self swipeToLeft];
        } else {
            [self swipeToRight];
        }
    }
}

- (void)swipeRightHandle:(UISwipeGestureRecognizer *)swipe
{
    WS(bself);
    
    if ([self checkSwipeLeft])
    {
        NSInteger rows = [self.parentTableView numberOfRowsInSection:0];
        for (int i=0; i < rows; i++)
        {
            WSSwipeCell *cell = (WSSwipeCell *)[self.parentTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (cell &&
                [cell isKindOfClass:[WSSwipeCell class]] &&
                cell.contentView.frame.origin.x != 0)
            {
                [cell swipeToRight];
            }
        }
    }
    else
    {
        CGFloat x = bself.contentView.frame.origin.x;
        CGFloat xOffset = 10;
        //  回弹效果
        [UIView animateWithDuration:0.2 animations:^{
            bself.contentView.frame = CGRectMake(x-xOffset, 0, bself.contentView.frame.size.width, bself.contentView.frame.size.height);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                bself.contentView.frame = CGRectMake(x, 0, bself.contentView.frame.size.width, bself.contentView.frame.size.height);
            } completion:nil];
        }];
    }
}

- (void)swipeToLeft
{
    WS(bself);
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
}

- (void)swipeToRight
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
    for (UIView *vv in [self.contentView.superview subviews]) {
        if (vv.tag>=1000) {
            [vv removeFromSuperview];
        }
    }
    
    for (int i=0; i < self.item.btnTitles.count; i++)
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(WSScreenWidth-self.item.btnWidth*(i+1), 0, self.item.btnWidth, self.item.cellHeight)];
        btn.backgroundColor = self.item.btnBgColors[i];
        [btn setTitle:self.item.btnTitles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.tag = 1000+i;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView.superview insertSubview:btn belowSubview:self.contentView];
    }
}

- (void)btnClick:(UIButton *)btn
{
    if (self.item.btnClick){
        self.item.btnClick(btn.titleLabel.text);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
