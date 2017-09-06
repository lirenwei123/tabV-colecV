//
//  snapViewController.m
//  initVC
//
//  Created by QianLong on 2017/8/18.
//  Copyright © 2017年 lrw. All rights reserved.
//

#import "snapViewController.h"

@interface snapViewController ()

@end

@implementation snapViewController
- (IBAction)returnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setViewItem:(myCellModle *)viewItem{
    _viewItem = viewItem;
    if (_viewItem) {
        _titleLab.text = _viewItem.leftTitle;
        _L1.text = _viewItem.rightTitles[0];
        _L2.text = _viewItem.rightTitles[1];
        _L3.text = _viewItem.rightTitles[2];
        _L4.text = _viewItem.rightTitles[3];
        _L5.text = _viewItem.rightTitles[4];
        _L6.text = _viewItem.rightTitles[5];
        _L7.text = _viewItem.rightTitles[6];
        _L8.text = _viewItem.rightTitles[7];
        _L9.text = _viewItem.rightTitles[8];
        _L10.text = _viewItem.rightTitles[9];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
