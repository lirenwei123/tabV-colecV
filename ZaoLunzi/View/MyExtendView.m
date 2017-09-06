//
//  MyExtendView.m
//  initVC
//
//  Created by QianLong on 2017/9/5.
//  Copyright © 2017年 lrw. All rights reserved.
//

#import "MyExtendView.h"
#import "myBtn.h"
#import "snapViewController.h"

@implementation MyExtendView


-(void)setHidden:(BOOL)hidden{
    [super setHidden:hidden];
    __weak  typeof(self)  weakSelf = self;
    if (hidden) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }else{
        for (int i=0; i<6; i++) {
            myBtn *btn =[[myBtn alloc]initWithFrame:CGRectMake(10+110*(i%3), 10+40*(i/3), 100, 30) img:[UIImage imageNamed:@"1.jpg"] title:[NSString stringWithFormat:@"%d",i] touchEvent:^(myBtn *mybtn) {
                NSLog(@"----------%@:%@---%@",mybtn.lab.text,self.path,self.model);
                if (weakSelf.TouchBlock) {
                    weakSelf.TouchBlock(mybtn,weakSelf.model,weakSelf.path);
                }
                
            }andbtnType:i%4];
            
            [self addSubview:btn];
            
            
        }
        
    }
}
@end
