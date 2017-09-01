//
//  AnswerViewController.m
//  StudyDrive
//
//  Created by Aico on 8/14/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnswerScrollView.h"
#import "MyDataManager.h"
#import "AnswerModel.h"
#import "SelectModelView.h"
#import "SheetView.h"

@interface AnswerViewController () <SheetViewDelegate> {
    AnswerScrollView *_answerScrollView;
    SelectModelView *modelView;
    SheetView *_sheetView;
}

@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSArray *array = [MyDataManager getData:answer];
    for (int i=0; i<array.count-1; i++) {
        AnswerModel *model = array[i];
        if ([model.pid intValue] == _number+1) {
            [arr addObject:model];
        }
    }
    
    _answerScrollView = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) WithDataArray:array];
    self.delegate = _answerScrollView;
    
    [self.view addSubview:_answerScrollView];
    [self createToolBar];
    [self createModelView];
    [self createSheetView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 底部工具栏
- (void)createToolBar {
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-60-64, self.view.frame.size.width, 60)];
    barView.backgroundColor = [UIColor whiteColor];
    
    NSArray *arr = @[@"1111", @"查看答案", @"收藏本体"];
    CGFloat btnWidth = 36;
    
    for (int i=0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat gap = ((self.view.frame.size.width-btnWidth*3)/4) * (i+1) + (btnWidth * i);
        btn.frame = CGRectMake(gap, 0, btnWidth, btnWidth);
        btn.tag = 301+i;
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",   16+i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-2.png", 16+i]] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(clickToolBar:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(btn.frame.origin.x-15, btnWidth, btnWidth+30, 18)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = arr[i];
        label.font = [UIFont systemFontOfSize:14];
        [barView addSubview:btn];
        [barView addSubview:label];
    }
    [self.view addSubview:barView];
}

//
- (void)createModelView {
    modelView = [[SelectModelView alloc] initWithFrame:self.view.frame addTouch:^(SelectModel model) {
        NSLog(@"当前模式：%d", model);
    }];
    [self.view addSubview:modelView];
    modelView.hidden = YES;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"答题模式" style:UIBarButtonItemStylePlain target:self action:@selector(modelChange:)];
    self.navigationItem.rightBarButtonItem = item;
}

//
- (void)createSheetView {
    _sheetView = [[SheetView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-20) WithSuperView:self.view AndQuestionsCount:100];
    [self.view addSubview:_sheetView];
    _sheetView.delegate = self;
}

- (void)modelChange:(UIBarButtonItem *)item {
    [UIView animateWithDuration:0.3 animations:^{
        modelView.hidden = NO;
    }];
}

- (void)clickToolBar:(UIButton *)btn {
    switch (btn.tag) {
        case 301:
        {
            [UIView animateWithDuration:0.3 animations:^{
                _sheetView.frame = CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80);
                _sheetView -> _backView.alpha = 0.8;
            }];
        }
            break;
            
        case 302:  // 查看答案
        {
            if ([_answerScrollView.hadAnsweredArray[_answerScrollView.currentPage] intValue] != 0) {
                return;
            } else {
                NSString *answer = ((AnswerModel *)_answerScrollView.dataArray[_answerScrollView.currentPage]).manswer;
                char an = [answer characterAtIndex:0];
                [_answerScrollView.hadAnsweredArray replaceObjectAtIndex:_answerScrollView.currentPage withObject:[NSString stringWithFormat:@"%d", an-'A'+1]];
                [self.delegate refreshMainTableData];
            }
        }
            break;
            
        case 303:
        {}
            break;
            
        default:
            break;
    }
}

#pragma maks - delegate
- (void)sheetViewClick:(int)index {
    UIScrollView *scroll = _answerScrollView -> _scrollView;
    scroll.contentOffset = CGPointMake((index-1)*scroll.frame.size.width, 0);
    [scroll.delegate scrollViewDidEndDecelerating:scroll];
}

@end
