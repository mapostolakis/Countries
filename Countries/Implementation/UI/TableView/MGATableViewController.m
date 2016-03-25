//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGATableViewController.h"

@interface MGATableViewController ()

@property (nonatomic, readwrite, weak) UITableView *tableView;
@property (nonatomic, readonly) id <UITableViewDataSource> dataSource;
@property (nonatomic, readonly) id <UITableViewDelegate> delegate;
@property (nonatomic, readonly) UITableViewStyle style;

@end

@implementation MGATableViewController

- (instancetype)initWithDataSource:(id <UITableViewDataSource>)dataSource
                          delegate:(id <UITableViewDelegate>)delegate
                             style:(UITableViewStyle)style
{
    self = [super init];
    if (self) {
        _dataSource = dataSource;
        _delegate = delegate;
        _style = style;
    }
    return self;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:self.style];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.dataSource = self.dataSource;
        view.delegate = self.delegate;
        view.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:view];
        _tableView = view;
    }
    return _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupConstraints];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.tableView.indexPathForSelectedRow) {
        [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
    }
}

- (void)setupConstraints
{
    UIView *tableView = self.tableView;

    NSDictionary *views = NSDictionaryOfVariableBindings(tableView);

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views]];
}

@end