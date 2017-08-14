//
//  TestSelectViewController.m
//  StudyDrive
//
//  Created by Aico on 7/27/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import "TestSelectViewController.h"
#import "TestSelectTableViewCell.h"
#import "TestSelectModel.h"
//#import "MyDataManager.h"
#import "AnswerViewController.h"

static NSString *cellID = @"TestSelectTableViewCell";

@interface TestSelectViewController ()<UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
}

@end

@implementation TestSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = self.myTitle;
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    [self.view addSubview:_tableView];
}

# pragma mark - tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"TestSelectTableViewCell";
    TestSelectTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    cell.numberLabel.layer.masksToBounds = YES;
    cell.numberLabel.layer.cornerRadius = 8;
    cell.titleLabel.text = @"hello";
    
    TestSelectModel *model = self.dataArray[indexPath.row];
    cell.numberLabel.text = model.pid;
    cell.titleLabel.text = model.pname;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[AnswerViewController alloc] init] animated:YES];
}


@end
