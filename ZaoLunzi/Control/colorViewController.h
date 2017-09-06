//
//  colorViewController.h
//  initVC
//
//  Created by QianLong on 2017/8/18.
//  Copyright © 2017年 lrw. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef  void(^touch)(UIColor *color);

@interface colorViewController : UIViewController

-(instancetype)initWithSelectColor:(touch)touch;

@end
