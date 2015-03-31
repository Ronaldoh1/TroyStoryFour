//
//  ViewController.m
//  TroyStoryFour
//
//  Created by Ronald Hernandez on 3/31/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "WarriorListViewController.h"

@interface WarriorListViewController ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation WarriorListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}

@end
