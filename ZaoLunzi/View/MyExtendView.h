//
//  MyExtendView.h
//  initVC
//
//  Created by QianLong on 2017/9/5.
//  Copyright © 2017年 lrw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myCellModle.h"


@class myBtn;

@interface MyExtendView : UIView
//
@property(nonatomic,strong) NSIndexPath* path;
//
@property(nonatomic,strong) myCellModle *model;

//
@property(nonatomic,strong) void(^TouchBlock)(myBtn*btn,myCellModle*model,NSIndexPath*path);
@end
