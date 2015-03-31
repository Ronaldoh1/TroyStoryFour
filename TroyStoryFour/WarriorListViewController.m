//
//  ViewController.m
//  TroyStoryFour
//
//  Created by Ronald Hernandez on 3/31/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "WarriorListViewController.h"
#import "AppDelegate.h"

@interface WarriorListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property NSManagedObjectContext *context;
@property NSArray *warriors;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSString *tempStr;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;

@end

@implementation WarriorListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    self.context = appDelegate.managedObjectContext;
    [self loadPredicateWithFormat:nil];

}

-(void)loadPredicateWithFormat:(NSString *)format{


    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Warrior"];
    NSSortDescriptor *sortDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
      NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"prowess" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor2,sortDescriptor1, nil];
    request.predicate =[NSPredicate predicateWithFormat:format !=nil ? format: @"prowess =>5"];
    

    self.warriors = [self.context executeFetchRequest:request error:nil];
    [self.tableView reloadData];



}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.warriors.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    NSManagedObject *warrior = [self.warriors objectAtIndex:indexPath.row];
    cell.textLabel.text = [warrior valueForKey:@"name"];
    cell.detailTextLabel.text =[[warrior valueForKey:@"prowess"]stringValue];
    return cell;
}


- (IBAction)saveWarrior:(UITextField *)sender {

    [sender resignFirstResponder];
    NSManagedObject *newWarrior = [NSEntityDescription insertNewObjectForEntityForName:@"Warrior"inManagedObjectContext:self.context];
    [newWarrior setValue:sender.text forKey:@"name"];
    NSNumber *randInt = [NSNumber numberWithLong:arc4random() % 10];
    [newWarrior setValue:randInt forKey:@"prowess"];
    [self.context save:nil];
    [self loadPredicateWithFormat:nil];
  
}
- (IBAction)segmentedControl:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex== 0) {
        [self loadPredicateWithFormat:nil];
    }else{
        [self loadPredicateWithFormat:@"prowess < 5"];
    }

}


@end
