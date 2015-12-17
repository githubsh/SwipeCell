//
//  Define.m
//  SwipeCell
//
//  Created by Steven on 15/12/17.
//  Copyright © 2015年 Steven. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WSScreenWidth [UIScreen mainScreen].bounds.size.width
#define WSScreenHeight [UIScreen mainScreen].bounds.size.height

//  weak 对象
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define WO(obj,weakObj)  __weak __typeof(&*obj)weakObj = obj;