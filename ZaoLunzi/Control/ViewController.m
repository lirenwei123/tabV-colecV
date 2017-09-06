//
//  ViewController.m
//  initVC
//
//  Created by lrw on 2016/12/22.
//  Copyright © 2016年 lrw. All rights reserved.
//

#import "ViewController.h"
#import "mycell.h"
#import "myCellModle.h"
#import "snapViewController.h"
#import "colorViewController.h"
#import <objc/runtime.h>
#import "myBtn.h"


const void * KEY = @"key";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,mycellDelegate>
/*          */
@property(nonatomic,strong)UITableView *tabv;
/*          */
@property(nonatomic,strong)mycell *headerV;

//
@property(nonatomic,strong) NSMutableArray <myCellModle*>*cellItems;
//
@property(nonatomic,strong) myCellModle * titleItem;
//
@property(nonatomic,assign)CGPoint initOffset;

//
@property(nonatomic,strong) UIButton *hf;
//
@property(nonatomic,assign)NSInteger selectRow;
//
@property(nonatomic,assign)BOOL isSelected;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _initOffset = CGPointZero;
    _selectRow = -1;
    _isSelected = NO;
    [self setUI];
       
    }

-(void)setUI{
    [self.view insertSubview:self.tabv atIndex:0];
    
}
-(UIView *)tabvHeader{
    if (_headerV) {
        return _headerV;
    }
    _headerV = [mycell creatCell];
    _headerV.frame = CGRectMake(0, 0, 0, 60);
    _headerV.lab.text= self.titleItem.leftTitle;
    _headerV.lab.backgroundColor = [UIColor cyanColor];
    _headerV.delegate = self;
    //    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDuration:6];
//    [UIView setAnimationRepeatCount:MAXFLOAT];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    [UIView setAnimationTransition:(UIViewAnimationTransitionFlipFromLeft) forView:_headerV cache:NO];
//    [UIView commitAnimations];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor =[UIColor whiteColor];
    btn.frame = CGRectMake(5, 25, 40, 40);
    [btn setTitle:@"换肤" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    __weak typeof(self) weakSelf = self;
    void (^btnBlock)(UIButton *) = ^(UIButton *sender){
        colorViewController *colorVC  =  [[colorViewController alloc]initWithSelectColor:^(UIColor *color) {
            weakSelf.hf.backgroundColor = color;
            [weakSelf.tabv reloadData];
            for (mycell *cell in weakSelf.tabv.visibleCells) {
                cell.rightV.contentOffset = weakSelf.initOffset;
            }
        }];
        
        [self presentViewController:colorVC animated:YES completion:nil];
    };
    [self.view addSubview:btn];
    _hf = btn;
    objc_setAssociatedObject(btn, KEY, btnBlock, OBJC_ASSOCIATION_COPY);
    
//    [UIView animateWithDuration:3 animations:^{
//        _headerV.alpha=0.1;
//    } completion:^(BOOL finished) {
//       [UIView animateWithDuration:3 animations:^{
//           _headerV.alpha=1;
//           CATransition *tra =[CATransition animation];
//           tra.duration=6;
//           tra.type=@"suckEffect";
//           tra.repeatCount = 1000;
//           [_headerV.layer addAnimation:tra forKey:nil];
//
//          
//       }];    }];
    return _headerV;
   }
-(void)btnClick:(UIButton *)sender{
    
    void (^btnBlock)(UIButton *)  =  objc_getAssociatedObject(sender, KEY);
    if (btnBlock) {
        btnBlock(sender);
    }
   
}

-(UITableView *)tabv{
    if (!_tabv) {
        CGRect rect =CGRectMake(0, 70, 414, 700);
        _tabv =[[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
        _tabv.separatorStyle= UITableViewCellSeparatorStyleNone;
        _tabv.showsVerticalScrollIndicator = YES;
        _tabv.delegate=self;
        _tabv.dataSource=self;
            }
    return _tabv;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellItems.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    mycell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell =[mycell creatCell];
        }
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    myCellModle *cellItem = self.cellItems[indexPath.row];
    cell.lab.text= cellItem.leftTitle;
    if (indexPath.row == _selectRow&& _isSelected == YES) {
        cell.lab.backgroundColor = [UIColor greenColor];
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = cell.extendV.frame;
            frame.size.height = 110;
            cell.extendV.frame = frame;
            cell.extendV.hidden = NO;
            cell.extendV.path = indexPath;
            cell.extendV.model = cellItem;
            __weak typeof(self) weakSelf = self;
            [cell.extendV setTouchBlock:^(myBtn*btn,myCellModle*model,NSIndexPath*path){
                snapViewController *snap = [[snapViewController alloc]init];
                [weakSelf presentViewController:snap animated:YES completion:nil];
                snap.viewItem = model;
                snap.title = btn.lab.text;
            }];
        }];
    }else{
        
        cell.lab.backgroundColor = _hf.backgroundColor;
            CGRect frame = cell.extendV.frame;
            frame.size.height = 0;
            cell.extendV.frame = frame;
            cell.extendV.hidden = YES;

    }
    if (cell.lab.backgroundColor == [UIColor blackColor]) {
        cell.lab.textColor = [UIColor whiteColor];
    }else{
       cell.lab.textColor = [UIColor blackColor];
    }
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.rightV.contentOffset = _initOffset;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self setViewModelWithIndexPath:indexPath andRindexPath:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _selectRow &&_isSelected ==YES) {
        return 150;
        
    }
    return 40;
}


-(void)setViewModelWithIndexPath:(NSIndexPath*)indexpath  andRindexPath:( NSIndexPath* _Nullable )RindexPath{
//        myCellModle *cellItem = self.cellItems[indexpath.row-1];
//        snapViewController *snap = [[snapViewController alloc]init];
//        [self presentViewController:snap animated:YES completion:nil];
//        snap.viewItem = cellItem;//这里顺序一定不能反。要先呈现出控制器，才能加载里面的XIB控件
    
    if (_selectRow !=indexpath.row ) {
        _selectRow  = indexpath.row;
        _isSelected = YES;
    }else{
        if (_isSelected == YES) {
            //收拢
            _isSelected = NO;
        }else{
            //展开
            _isSelected = YES;
        }
    }
    [self.tabv reloadData];
    [self setTabOffset:_initOffset];
   }

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self tabvHeader];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
#pragma mark-- delegate
-(NSString *)titleWithmycell:(mycell *)cell rightVindexpath:(NSIndexPath *)indexPath {
    if (cell== _headerV) {
        return self.titleItem.rightTitles[indexPath.row];
    }else{
    myCellModle *cellItem = self.cellItems[cell.indexPath.row];
    return  cellItem.rightTitles[indexPath.row];
    }
    return @" ";
}
-(NSInteger)rowsCountWithmycell:(mycell *)cell{
    myCellModle *m = nil;
    if (cell == _headerV) {
        m = self.titleItem;
    }else{
    m = self.cellItems[cell.indexPath.row];
    }
    return m.rightTitles.count;
}
-(void)mycell:(mycell*)cell DidSelectItemAtIndexPath:(NSIndexPath *)indexPath rightVindexPath:(NSIndexPath *)Rindexpath{
    if (cell == _headerV) {
        //做排序处理
        _isSelected = NO;
        _titleItem.leftTitle = @"回到默认排序";
        _cellItems =  [[self.cellItems reverseObjectEnumerator]allObjects] ;
        [self.tabv reloadData];
        [self setTabOffset:_initOffset];
        
    }else{
        
        [self setViewModelWithIndexPath:indexPath andRindexPath:Rindexpath];
    }
    
}
-(void)mycellDidScrollWithContentOffsetX:(CGFloat)Offsetx{
    _initOffset = CGPointMake(Offsetx, 0);
    [self setTabOffset:_initOffset];
}
-(void)setTabOffset:(CGPoint)offset{
    for (mycell *cell in self.tabv.visibleCells) {
        cell.rightV.contentOffset = offset;
    }
    _headerV.rightV.contentOffset = offset;
}
-(UIColor *)mycellWithSetColabColr:(mycell *)cell andCellIndexpath:(NSIndexPath *)path{
    if (cell == _headerV) {
        return [UIColor cyanColor];
    }
    if (path.row == _selectRow&&_isSelected == YES) {
        return [UIColor greenColor];
    }
    return _hf.backgroundColor;
}
-(void)labTouch:(mycell*)cell{
    if (cell == _headerV) {
        _isSelected = NO;
        _titleItem.leftTitle = @"名称";
        _cellItems = nil;
        [self.tabv reloadData];
        [self setTabOffset:_initOffset];
    }
}

-(BOOL)mycellBtnIsHiddle:(mycell *)cell{
    if (cell == _headerV) {
        return NO;
    }
    return YES;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    for (mycell *cell in self.tabv.visibleCells) {
        cell.rightV.contentOffset = _initOffset;
    }

}


-(NSMutableArray<myCellModle *> *)cellItems{
    if (!_cellItems) {
        _cellItems = @[].mutableCopy;
        for (int i=0; i<30; i++) {
            myCellModle *model = [[myCellModle alloc]init];
            model.leftTitle = [NSString stringWithFormat:@"%c",i+65];
            for (int j=0; j<10; j++) {
                [model.rightTitles addObject:[NSString stringWithFormat:@"%c%d",i+65,j]];
            }
            [_cellItems addObject:model];
        }
    }
    return _cellItems;
}
-(myCellModle *)titleItem{
    if (!_titleItem) {
        _titleItem = [[myCellModle alloc]init];
        _titleItem.leftTitle =  @"名称";
        [_titleItem.rightTitles addObject:@"范冰冰"];
        [_titleItem.rightTitles addObject:@"李晨"];
        [_titleItem.rightTitles addObject:@"李易峰"];
        [_titleItem.rightTitles addObject:@"白浅"];
        [_titleItem.rightTitles addObject:@"成都"];
        [_titleItem.rightTitles addObject:@"重庆"];
        [_titleItem.rightTitles addObject:@"无锡"];
        [_titleItem.rightTitles addObject:@"常州"];
        [_titleItem.rightTitles addObject:@"苏州"];
        [_titleItem.rightTitles addObject:@"广州"];
    }
    return _titleItem;
}


@end
