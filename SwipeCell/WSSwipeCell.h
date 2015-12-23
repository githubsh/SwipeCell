//
//  WSSwipeCell.h
//  SwipeCell
//
//  Created by Steven on 15/12/17.
//  Copyright © 2015年 Steven. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface WSSwipeItem : RETableViewItem

@property (nonatomic,assign) CGFloat btnWidth;
@property (nonatomic,strong) NSArray *btnTitles;
@property (nonatomic,strong) NSArray *btnBgColors;
@property (nonatomic,strong) NSArray *btnWidths;
@property (nonatomic,strong) void (^btnClick)(NSString *btnTitle);

@end

@interface WSSwipeCell : RETableViewCell

@property (nonatomic,readwrite,strong) WSSwipeItem *item;

- (BOOL)checkSwipeLeft;
- (void)swipeToLeft;
- (void)swipeToRight;

@end
