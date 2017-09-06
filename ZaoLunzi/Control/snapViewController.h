//
//  snapViewController.h
//  initVC
//
//  Created by QianLong on 2017/8/18.
//  Copyright © 2017年 lrw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myCellModle.h"

@interface snapViewController : UIViewController
//
@property(nonatomic,strong) myCellModle *viewItem;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *L1;
@property (weak, nonatomic) IBOutlet UILabel *L2;
@property (weak, nonatomic) IBOutlet UILabel *L3;
@property (weak, nonatomic) IBOutlet UILabel *L4;
@property (weak, nonatomic) IBOutlet UILabel *L5;
@property (weak, nonatomic) IBOutlet UILabel *L6;
@property (weak, nonatomic) IBOutlet UILabel *L7;
@property (weak, nonatomic) IBOutlet UILabel *L9;
@property (weak, nonatomic) IBOutlet UILabel *L10;
@property (weak, nonatomic) IBOutlet UILabel *L8;
@end
