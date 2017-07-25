//
//  FirstViewController.m
//  StudyDrive
//
//  Created by Aico on 7/24/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstTableViewCell.h"
static NSString *const cellID = @"FirstTableViewCell";

@interface FirstViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView *_tableView;
    NSArray *_dataArray;
    NSArray *_arr;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 这样，ui的布局就会从导航条下面开始
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _dataArray = @[@"章节练习", @"顺序练习", @"随机练习", @"专项练习", @"仿真模拟考试"];
    _arr = @[@"我的错题", @"我的收藏", @"我的成绩", @"练习统计"];
    
    [self createTableView];
    [self createView];

}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createView {
    CGSize size = self.view.frame.size;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height-64-150, 300, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"················我的考试分析················";
    label.clipsToBounds = YES;
    [self.view addSubview:label];
    
    for(int i=0; i<4; i++) {
        CGFloat gap = (size.width - 240) / 5;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(gap+(gap+60)*i, size.height-64-100, 60, 60);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i+12]] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(gap+(gap+60)*i, size.height-100, 60, 20)];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.text = _arr[i];
        label2.font = [UIFont boldSystemFontOfSize:13];
        [self.view addSubview:label2];
        
    }
}


#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _dataArray.count;
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - tableView datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int row = indexPath.row;
    FirstTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] lastObject];
    }
    [cell.firstCellImage  setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", row+7]]];
    [cell.firstCellLabel setText:_dataArray[row]];
    
    return cell;
    
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
