//
//  TableViewController.m
//  Note
//
//  Created by key on 2018/5/26.
//  Copyright © 2018年 key. All rights reserved.
//

#import "TableViewController.h"
#import "TableModel.h"

@interface TableViewController ()

@property (nonatomic, strong) NSMutableArray <TableModel *> * dataArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.dataArray = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSArray * classArray = @[@"LogicViewController"];
        
        for (NSInteger index = 0; index < classArray.count; index ++) {
            TableModel * model = [TableModel new];
            model.className = classArray[index];
            model.title = classArray[index];
            [self.dataArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"identifier_cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataArray.count > indexPath.row ? self.dataArray[indexPath.row].title : @"";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TableModel * model = self.dataArray.count > indexPath.row ? self.dataArray[indexPath.row] : nil;
    if (!model) return;
    
    UIViewController * targetVC = [[NSClassFromString(model.className) alloc] init];
    [self.navigationController pushViewController:targetVC animated:YES];
}


@end
