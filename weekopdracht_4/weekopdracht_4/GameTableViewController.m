//
//  GameTableViewController.m
//  weekopdracht_4
//
//  Created by justin on 10/6/13.
//  Copyright (c) 2013 justin. All rights reserved.
//

#import "GameTableViewController.h"
#import "GameTableViewCell.h"
#import "WereldTableViewController.h"

@interface GameTableViewController () <UIAlertViewDelegate>

@end

@implementation GameTableViewController
@synthesize gameNames;
@synthesize filePath;

- (id)initWithStyle:(UITableViewStyle)style
{
    
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    gameNames = [[NSMutableArray alloc] init];
    filePath = @"objects.plist";
    
    NSString * path = [self givePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSArray * array = [[NSArray alloc] initWithContentsOfFile:path];
        self.gameNames = [array objectAtIndex:0];
    }
    
    [super viewDidLoad];
    
    UIBarButtonItem * button = [[UIBarButtonItem alloc] initWithTitle:@" Edit"  style:UIBarButtonItemStyleBordered target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = button;
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithTitle:@""  style:UIBarButtonItemStyleBordered target:self action:@selector(add)];
    self.navigationItem.leftBarButtonItem = leftButton;
    [self.navigationItem.leftBarButtonItem setEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [self.gameNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"gameTableCell";
    
    GameTableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[GameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.gameNames objectAtIndex:
                           [indexPath row]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (IBAction)edit
    {
        
        [self.tableView setEditing:!self.tableView.editing animated:YES];
        if(self.tableView.editing){
            [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
            [self.navigationItem.leftBarButtonItem setTitle:@"+"];
            [self.navigationItem.leftBarButtonItem setEnabled:YES];
        }else
        {
            [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
            [self.navigationItem.leftBarButtonItem setTitle:@""];
            [self.navigationItem.leftBarButtonItem setEnabled:NO];
        }
        [self save];
    }

- (IBAction)add
{
    //NSString *game = @"hoi";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Game:" message:@"Please enter a name for your new Game:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert addButtonWithTitle:@"Enter"];
    [alert show];
    
    //[self.gameNames addObject:game];
    
    
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        NSString *name = [alertView textFieldAtIndex:0].text;
        [self.gameNames addObject:name];
        [self.tableView reloadData];
    }
    
}

-(void)save
{
    NSMutableArray *save = [[NSMutableArray alloc] init];
    [save addObject:self.gameNames];
    [save writeToFile:[self givePath] atomically:YES];
}

/*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}*/


/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WereldTableViewController *detailViewController =
    [segue destinationViewController];
    
    NSIndexPath *myIndexPath = [self.tableView
                                indexPathForSelectedRow];
    
    detailViewController.werelden = [[NSMutableArray alloc]
                                           initWithObjects:
                                      [self.gameNames objectAtIndex: [myIndexPath row]],
                                           nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WereldTableViewController *test = [WereldTableViewController alloc];
    [self.navigationController pushViewController:test animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self.gameNames removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
    [tableView reloadData];
}

-(NSString *)givePath
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*docDir = [path objectAtIndex:0];
    return [docDir stringByAppendingPathComponent:filePath];
}


@end
