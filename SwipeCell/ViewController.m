//
//  ViewController.m
//  SwipeCell
//
//  Created by Steven on 15/12/17.
//  Copyright © 2015年 Steven. All rights reserved.
//

#import "ViewController.h"
#import "RETableViewManager.h"
#import "Define.h"
#import "WSSwipeCell.h"


@interface ViewController () <RETableViewManagerDelegate>
@property (nonatomic, strong) RETableViewManager *formManager;  //表单管理器
@property (nonatomic, strong) UITableView *formTable;           //表单表格
@end

@implementation ViewController

@synthesize formManager;
@synthesize formTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor whiteColor];
    
    formTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WSScreenWidth, WSScreenHeight-64-49) style:UITableViewStylePlain];
    formTable.showsVerticalScrollIndicator = NO;
    formTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    formTable.backgroundColor = [UIColor grayColor];
    [self.view addSubview:formTable];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapFormTable)];
    tap.numberOfTapsRequired = 1;
    [formTable addGestureRecognizer:tap];
    
    formManager = [[RETableViewManager alloc] initWithTableView:formTable];
    formManager.delegate = self;
    
    self.formManager[@"WSSwipeItem"] = @"WSSwipeCell";

    NSMutableArray *sectionArray = [NSMutableArray array];
    RETableViewSection *section0 = [RETableViewSection sectionWithHeaderTitle:@""];
    
    for (int i=0; i<10; i++)
    {
        WSSwipeItem *item = [[WSSwipeItem alloc]init];
        item.btnTitles = @[@"按钮1",@"按钮2"];//从右往左的 按钮文字
        item.btnBgColors = @[[UIColor redColor],[UIColor blueColor]];//从右往左的 按钮背景颜色
        item.btnClick = ^(NSString *btnTitle){
            NSLog(@"btnTitle=%@",btnTitle);
            if ([btnTitle isEqualToString:@"按钮1"]) {
                //do something
            }
            else if ([btnTitle isEqualToString:@"按钮2"]) {
                //do something
            }
        };
        [section0 addItem:item];
    }
    
    [sectionArray addObject:section0];
    [self.formManager replaceSectionsWithSectionsFromArray:sectionArray];
    [self.formTable reloadData];
}

#pragma mark - RETableViewManagerDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    return 0;
}

- (void)tapFormTable
{
    NSInteger rows = [formTable numberOfRowsInSection:0];
    for (int i=0; i<rows; i++) {
        WSSwipeCell *cell = (WSSwipeCell *)[formTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell &&
            [cell isKindOfClass:[WSSwipeCell class]] &&
            [cell respondsToSelector:@selector(swipeRightHandle:)])
        {
            [cell swipeRightHandle:nil];
        }
    }
}

@end
