//
//  ViewController.m
//  ToDoList
//
//  Created by Kevin Lee on 10/13/13.
//  Copyright (c) 2013 Kevin Lee. All rights reserved.
//

#import "ViewController.h"
#import "EditableCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *savedEntries;

- (void)addTodoItem:sender;
@end

@implementation ViewController

NSString *const EDITABLE_CELL_REUSE_IDENTIFIER = @"EditableCell";
NSString *const PREFS_KEY = @"TodoItems";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"To Do List";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    self.savedEntries = [prefs mutableArrayValueForKey:PREFS_KEY];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UINib* cellNib = [UINib nibWithNibName:@"EditableCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:EDITABLE_CELL_REUSE_IDENTIFIER];
    [self.tableView reloadData];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self     action:@selector(addTodoItem:)];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing:editing animated:animated];
}

- (void)updateText: (NSString *)text forCell:(EditableCell*)cell {
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath != nil) {
        [self.savedEntries setObject:text atIndexedSubscript:indexPath.row];

        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:self.savedEntries forKey:PREFS_KEY];
        [prefs synchronize];
    }
}

- (void)scrollToCell:(EditableCell*)cell {
    CGPoint pointInTable = [cell convertPoint:cell.txtCellString.frame.origin toView:self.tableView];
    CGPoint contentOffset = self.tableView.contentOffset;
    
    contentOffset.y = (pointInTable.y - cell.txtCellString.inputAccessoryView.frame.size.height);
    
    [self.tableView setContentOffset:contentOffset animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.savedEntries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EditableCell *cell = [tableView dequeueReusableCellWithIdentifier:EDITABLE_CELL_REUSE_IDENTIFIER];
    
    // Configure the cell.
    cell.showsReorderControl = YES;
    cell.txtCellString.text = [self.savedEntries objectAtIndex:indexPath.row];
    cell.cellDelegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.savedEntries removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
} 

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    NSString *stringToMove = [self.savedEntries objectAtIndex:fromIndexPath.row];
    [self.savedEntries removeObjectAtIndex:fromIndexPath.row];
    [self.savedEntries insertObject:stringToMove atIndex:toIndexPath.row];
}
 
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
 

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    self.editing = YES;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    self.editing = NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)addTodoItem:sender {
    [self.savedEntries insertObject:@"<New>" atIndex:0];
    [self.tableView reloadData];
}
@end