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

@interface AnswerViewController ()

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
    
    AnswerScrollView *view = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) WithDataArray:array];
    [self.view addSubview:view];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
