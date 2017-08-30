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

@interface AnswerViewController () {
AnswerScrollView *view;
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
    
    view = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) WithDataArray:array];
    [self.view addSubview:view];
    [self createToolBar];
    self.delegate = view;
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

- (void)clickToolBar:(UIButton *)btn {
    switch (btn.tag) {
        case 301:
        {}
            break;
            
        case 302:  // 查看答案
        {
            if ([view.hadAnsweredArray[view.currentPage] intValue] != 0) {
                return;
            } else {
                NSString *answer = ((AnswerModel *)view.dataArray[view.currentPage]).manswer;
                char an = [answer characterAtIndex:0];
                [view.hadAnsweredArray replaceObjectAtIndex:view.currentPage withObject:[NSString stringWithFormat:@"%d", an-'A'+1]];
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


@end
