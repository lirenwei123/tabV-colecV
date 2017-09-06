//
//  mycell.h
//  initVC
//
//  Created by lrw on 2016/12/22.
//  Copyright © 2016年 lrw. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "MyExtendView.h"

//typedef void (^cellBlock)(NSIndexPath* path);
@class mycell;
@protocol mycellDelegate <NSObject>
@required
-(NSString *)titleWithmycell:(mycell*)cell rightVindexpath:(NSIndexPath*)indexPath;
-(NSInteger)rowsCountWithmycell:(mycell*)cell;
-(void)mycell:(mycell*)cell DidSelectItemAtIndexPath:(NSIndexPath*)indexPath  rightVindexPath:(NSIndexPath*)Rindexpath;
-(void)mycellDidScrollWithContentOffsetX:(CGFloat)Offsetx;
-(UIColor *)mycellWithSetColabColr:(mycell*)cell andCellIndexpath:(NSIndexPath*)path;
-(void)labTouch:(mycell*)cell;
-(BOOL)mycellBtnIsHiddle:(mycell*)cell;

@end

typedef  struct delegateSelector{
    BOOL mycellDelegate;
    BOOL mycellDelegatePerform;
    BOOL mycellDelegatePerform1;
    BOOL mycellDelegatePerform2;
    BOOL mycellDelegatePerform3;
    BOOL mycellDelegatePerform4;
    BOOL mycellDelegatePerform5;
    BOOL mycellDelegatePerform6;
}delePD ;

@interface mycell : UITableViewCell





@property (weak, nonatomic) IBOutlet MyExtendView *extendV;
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (weak, nonatomic) IBOutlet UICollectionView *rightV;
//
//
@property(nonatomic,assign)delePD PDStruct;
//
@property(nonatomic,weak) id <mycellDelegate>delegate;
//
@property(nonatomic,assign)NSIndexPath* indexPath;


+(instancetype)creatCell;


    @end


