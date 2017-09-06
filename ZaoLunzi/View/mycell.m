//
//  mycell.m
//  initVC
//
//  Created by lrw on 2016/12/22.
//  Copyright © 2016年 lrw. All rights reserved.
//

#import "mycell.h"
#import "myCocell.h"


@interface mycell ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
//
@property(nonatomic,assign)BOOL drag;
//
@property(nonatomic,assign)NSIndexPath *selectPath;
@end

@implementation mycell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UICollectionViewFlowLayout *layout1 =[[UICollectionViewFlowLayout alloc]init];
    layout1.itemSize=CGSizeMake(80, self.lab.bounds.size.height);
    layout1.scrollDirection= UICollectionViewScrollDirectionHorizontal;
    layout1.minimumLineSpacing=0;
    layout1.minimumInteritemSpacing = 0;
    self.rightV.collectionViewLayout=layout1;
    self.rightV.showsVerticalScrollIndicator = NO;
    self.rightV.showsHorizontalScrollIndicator = NO;
    self.rightV.delegate=self;
    self.rightV.dataSource=self;
    [self.rightV registerNib:[UINib nibWithNibName:NSStringFromClass([myCocell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"co"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labTouch:)];
    self.lab.userInteractionEnabled = YES;
    [self.lab addGestureRecognizer:tap];
    CGRect frame = self.extendV.frame;
    frame.size.height = 0;
    self.extendV.frame = frame;
    self.extendV.hidden = YES;
    _drag = NO;
}

+(instancetype)creatCell{
    return  [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self ) owner:nil options:nil].firstObject;
//    UINib *nib =[UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
//    return [nib instantiateWithOwner:nil options:nil].lastObject;
}

-(void)labTouch:(mycell*)cell{
    if (_PDStruct.mycellDelegatePerform5) {
        [_delegate labTouch:self];
    }
}

#pragma mark --collection view代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_PDStruct.mycellDelegatePerform1) {
        return [_delegate rowsCountWithmycell:self];
    }else{
    return 10;
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    myCocell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"co" forIndexPath:indexPath];
    if (_PDStruct.mycellDelegatePerform) {
        NSString *text = [_delegate titleWithmycell:self  rightVindexpath:indexPath];
        cell.coLab.text = text;
    }else{
        cell.coLab.text =[NSString stringWithFormat:@"%ld",(long)indexPath.item];
    }
    if (_PDStruct.mycellDelegatePerform4) {
        cell.coLab.backgroundColor = [_delegate mycellWithSetColabColr:self andCellIndexpath:self.indexPath];
        if (cell.coLab.backgroundColor == [UIColor blackColor]) {
            cell.coLab.textColor = [UIColor whiteColor];
        }else{
            cell.coLab.textColor = [UIColor blackColor];
        }
    }
    if (_PDStruct.mycellDelegatePerform6) {
        cell.btn.hidden = [_delegate mycellBtnIsHiddle:self];
    }
    return cell;
}
static int num = 0;
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_PDStruct.mycellDelegatePerform2) {
        [_delegate mycell:self DidSelectItemAtIndexPath:self.indexPath rightVindexPath:indexPath];
    }
    if (_selectPath == indexPath) {
        myCocell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        num++;
        if (cell.btn.isHidden == NO) {
            switch (num%3) {
                case 1:
                    [cell.btn setTitle:@"↓" forState:UIControlStateNormal];
                    break;
                case 2:
                    [cell.btn setTitle:@"→" forState:UIControlStateNormal];
                    break;
                case 0:
                    [cell.btn setTitle:@"↑" forState:UIControlStateNormal];
                    break;

                default:
                    break;
            }
                    }
    }else{
       num = 0;
      myCocell  *cell = [collectionView cellForItemAtIndexPath:indexPath];
        if (cell.btn.isHidden == NO) {
            [cell.btn setTitle:@"↑" forState:UIControlStateNormal];
        }
        if (!_selectPath) {
            _selectPath = indexPath;
            return;
        }
       cell = [collectionView cellForItemAtIndexPath:_selectPath];
        if (cell.btn.isHidden == NO) {
            [cell.btn setTitle:@"→" forState:UIControlStateNormal];
        }
        _selectPath = indexPath;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _drag = YES;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _drag = NO;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
        if (_PDStruct.mycellDelegatePerform3 && _drag ==YES ) {
            [_delegate mycellDidScrollWithContentOffsetX:scrollView.contentOffset.x];
        }
}

-(void)setDelegate:(id<mycellDelegate>)delegate{
    _delegate = delegate;
    if (_delegate) {
        _PDStruct.mycellDelegate = true;
        if ([_delegate respondsToSelector:@selector(titleWithmycell:rightVindexpath:)]) {
            _PDStruct.mycellDelegatePerform = true;
        }
        if ([_delegate respondsToSelector:@selector(rowsCountWithmycell:)]) {
            _PDStruct.mycellDelegatePerform1 = true;
        }
        if ([_delegate respondsToSelector:@selector(mycell: DidSelectItemAtIndexPath: rightVindexPath:)]) {
            _PDStruct.mycellDelegatePerform2 = true;
        }
        if ([_delegate respondsToSelector:@selector(mycellDidScrollWithContentOffsetX:)]) {
            _PDStruct.mycellDelegatePerform3 = true;
        }
        if ([_delegate respondsToSelector:@selector(mycellWithSetColabColr: andCellIndexpath:)]) {
            _PDStruct.mycellDelegatePerform4 = true;
        }
        if ([_delegate respondsToSelector:@selector(labTouch:)]) {
            _PDStruct.mycellDelegatePerform5 = true;
        }
        if ([_delegate respondsToSelector:@selector(mycellBtnIsHiddle:)]) {
           _PDStruct.mycellDelegatePerform6 = true;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
