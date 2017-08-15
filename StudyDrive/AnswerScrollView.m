//
//  AnswerScrollView.m
//  StudyDrive
//
//  Created by Aico on 8/12/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import "AnswerScrollView.h"
#import "AnswerTableViewCell.h"
#define SIZE self.frame.size
static NSString *const REUSEMAINCELLID = @"mainTableCell";
static NSString *cellID = @"AnswerTableViewCell";

@interface AnswerScrollView()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>{

}
@end

@implementation AnswerScrollView {
    UIScrollView *_scrollView;
    UITableView *_leftTableView;
    UITableView *_rightTableView;
    UITableView *_mainTableView;
    NSArray *_dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame WithDataArray:(NSArray *)array {
    
    self = [super initWithFrame:frame];
    if (self) {
        _dataArray = [[NSArray alloc] initWithArray:array];
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.delegate = self;
        _leftTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _mainTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _rightTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        [_mainTableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
        [_leftTableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
        [_rightTableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
        
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        if (_currentPage || _dataArray.count > 1) {
            _scrollView.contentSize = CGSizeMake(SIZE.width * 2, 0);
        }
        
        [self createView];
    }
    return self;
    
}

- (void)createView {
    _leftTableView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    _mainTableView.frame = CGRectMake(SIZE.width, 0, SIZE.width, SIZE.height);
    _leftTableView.frame = CGRectMake(2 * SIZE.width, 0, SIZE.width, SIZE.height);
    [_scrollView addSubview:_leftTableView];
    [_scrollView addSubview:_mainTableView];
    [_scrollView addSubview:_rightTableView];
    [self addSubview:_scrollView];
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 100)];
    view.backgroundColor = [UIColor redColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.numberLabel.text = [NSString stringWithFormat:@"%c", (char)('A' + indexPath.row)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.numberLabel.hidden = YES;
    cell.numberImage.hidden = NO;
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint currentOffset = scrollView.contentOffset;
    int page = (int)(currentOffset.x / SIZE.width);
    if (page < _dataArray.count-1) {
        _scrollView.contentSize = CGSizeMake(currentOffset.x+SIZE.width*2, 0);
        _mainTableView.frame = CGRectMake(currentOffset.x, 0, SIZE.width, SIZE.height);
        _leftTableView.frame = CGRectMake(currentOffset.x - SIZE.width, 0, SIZE.width, SIZE.height);
        _rightTableView.frame = CGRectMake(currentOffset.x + SIZE.width, 0, SIZE.width, SIZE.height);
    }
}

@end
