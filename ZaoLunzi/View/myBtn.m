//
//  myBtn.m
//  initVC
//
//  Created by QianLong on 2017/9/5.
//  Copyright © 2017年 lrw. All rights reserved.
//

#import "myBtn.h"

@implementation myBtn

#define W frame.size.width
#define H frame.size.height
-(instancetype)initWithFrame:(CGRect)frame img:(UIImage *)img title:(NSString *)title touchEvent:(T)event andbtnType:(BTNTYPE)type{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W*0.5, H)];
        imgv.image = img;
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(W*0.5, 0, W*0.5, H)];
        lab.text  = title;
        lab.textAlignment = NSTextAlignmentCenter;
        _lab = lab;
        _imgv = imgv;
        if (type == BTNTYPELR) {
            [self addSubview:imgv];
            [self addSubview:lab];
            
        }
        if (type == BTNTYPEUD) {
            imgv.frame = CGRectMake(0, 0,W,H*0.5 );
            lab.frame = CGRectMake(0, H*0.5, W, H*0.5);
            [self addSubview:imgv];
            [self addSubview:lab];
        }
        if (type == BTNTYPEIMG) {
            imgv.frame = self.bounds;
            [self addSubview:imgv];
        }
        if (type == BTNTYPETEXT) {
            lab.frame = self.bounds;
            [self addSubview:lab];
        }
        
    }
    _touchEvent = event;
    return self;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_touchEvent) {
        _touchEvent(self);
    }
}

@end
