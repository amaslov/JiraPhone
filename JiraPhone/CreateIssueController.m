//
//  CreateIssueController.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 1/10/11.
//  Copyright 2011 AMaslov. All rights reserved.
//
#import "CreateIssueController.h"
#import "Issue.h"
#import "MutableIssueDetailCell.h"
#import "MutableIssueDetailLink.h"
#import "Connector.h"
#import "Project.h"
#import "IssueType.h"


@implementation CreateIssueController
@synthesize mutableCell;
@synthesize project;
@synthesize delegate; 
@synthesize mutableLink;
@synthesize pickerView;
@synthesize doneButton;
@synthesize dataArray;

#pragma mark -
#pragma mark Initialization

- (id)initForIssueInProject:(Project *)_project {
	// send nil, because we do not need it. 
	if (self = [super initForIssue: nil]) {
		self.project = _project;
	}
	return self;	
}

#pragma mark -
#pragma mark Actions

- (IBAction)cancelAction {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)doneAction {
	//TODO: think about creating this stuff in a cycle.
	MutableIssueDetailCell *cell;
	MutableIssueDetailLink *link;
	Issue *newIssue = [[Issue alloc] init];
	newIssue.project = project.key;
	
	// get issue summary value
	cell = (MutableIssueDetailCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow: ISSUE_SUMMARY_ROW inSection: ISSUE_DATA_SECTION]];
	newIssue.summary = cell.textField.text;
	
	// get issue type value
	cell = (MutableIssueDetailCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow: ISSUE_TYPE_ROW inSection: ISSUE_DATA_SECTION]];
	IssueType *t = [[IssueType alloc] init];
	t.number = [cell.textField.text intValue];
	newIssue.type = t;
	[t release];
	
	// get issue priority value
	cell = (MutableIssueDetailCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow: ISSUE_PRIORITY_ROW inSection: ISSUE_DATA_SECTION]];
	Priority *p = [[Priority alloc] init];
	p.number = [cell.textField.text intValue];
	newIssue.priority = p;
	[p release];
	
<<<<<<< HEAD
	//Issue status row
	cell = (MutableIssueDetailCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow: ISSUE_STATUS_ROW inSection: ISSUE_DATA_SECTION]];
	newIssue.reporter = [cell.textField.text isEqualToString:@""] ? nil : cell.textField.text;
	
=======
	//get issue affect versions value 
	//TODO implement versions support
	cell=(MutableIssueDetailCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:ISSUE_AFFECT_VERSIONS_ROW inSection:ISSUE_DATA_SECTION]];
	
	//get issue status value
	//TODO implement status support
	cell=(MutableIssueDetailCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:ISSUE_STATUS_ROW inSection:ISSUE_DATA_SECTION]];
	
	//get issue resolution value
	//TODO implement resolution support
	cell = (MutableIssueDetailCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:ISSUE_RESOLUTION_ROW inSection:ISSUE_DATA_SECTION]];
>>>>>>> dev

	// get issue assignee value
	link = (MutableIssueDetailLink *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow: ISSUE_ASSIGNEE_ROW inSection: ISSUE_MAN_SECTION]];
	//cell = (MutableIssueDetailCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow: ISSUE_ASSIGNEE_ROW inSection: ISSUE_MAN_SECTION]];
	//newIssue.assignee = [cell.textField.text isEqualToString:@""] ? nil : cell.textField.text;
	//newIssue.assignee = 
	// get issue reporter value
	//cell = (MutableIssueDetailCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow: ISSUE_REPORTER_ROW inSection: ISSUE_MAN_SECTION]];
	link = (MutableIssueDetailLink *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:ISSUE_REPORTER_ROW inSection: ISSUE_MAN_SECTION]];
	//newIssue.reporter = [cell.textField.text isEqualToString:@""] ? nil : cell.textField.text;
	
	[Connector sharedConnector].delegate = self;
	
	[[Connector sharedConnector] createIssue: newIssue];
	[newIssue release];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// customize navigation bar
	self.title = @"Create Issue";
	UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
	self.navigationItem.leftBarButtonItem = btn;
	[btn release];
	
	btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];
	self.navigationItem.rightBarButtonItem = btn;
	[btn release];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// only first category has 5 items, the last two's has 2 items in each
    return section == ISSUE_DATA_SECTION ? 3 : 2;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 	switch (indexPath.section) {
			static NSString *LinkIdentifier=@"MutableLink";
			static NSString *CellIdentifier=@"MutableCell";
		case (ISSUE_MAN_SECTION):
		{
				MutableIssueDetailLink *mLink = (MutableIssueDetailLink *)[tableView dequeueReusableCellWithIdentifier:LinkIdentifier];
			if (mLink==nil) 
			{
				[[NSBundle mainBundle] loadNibNamed:@"MutableIssueDetailLink" owner:self options:nil];
				mLink=mutableLink;
			}
			mLink.title.text=[self titleForCellAtIndexPath:indexPath];
			return mLink;
		}
			break;

		//case (ISSUE_DATE_SECTION):
		//{
			
		//}
		//	break;
		default:
		{
				MutableIssueDetailCell *mCell = (MutableIssueDetailCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (mCell == nil) 
			{
				[[NSBundle mainBundle] loadNibNamed:@"MutableIssueDetailCell" owner:self options:nil];
				mCell = mutableCell;
			}
			
			// Configure the cell...
			mCell.title.text = [self titleForCellAtIndexPath:indexPath];
			return mCell;
		}
			break;
	}
}	

/*	
	if (indexPath==[NSIndexPath indexPathForRow:ISSUE_ASSIGNEE_ROW inSection:ISSUE_MAN_SECTION])
	{
		MutableIssueDetailLink *mCell = (MutableIssueDetailLink *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (mCell==nil) 
		{
			[[NSBundle mainBundle] loadNibNamed:@"MutableIssueDetailLink" owner:self options:nil];
			mCell=mutableLink;
		}
		mCell.title.text=[self titleForCellAtIndexPath:indexPath];
		return mCell;
	}	
	else if (indexPath==[NSIndexPath indexPathForRow:ISSUE_REPORTER_ROW inSection:ISSUE_MAN_SECTION])
	{
		
		MutableIssueDetailLink *mCell = (MutableIssueDetailLink *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (mCell==nil) 
		{
			[[NSBundle mainBundle] loadNibNamed:@"MutableIssueDetailLink" owner:self options:nil];
			mCell=mutableLink;
		}
		mCell.title.text=[self titleForCellAtIndexPath:indexPath];
		return mCell;
	}
	else	
	{
		MutableIssueDetailCell *mCell = (MutableIssueDetailCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (mCell == nil) 
		{
			[[NSBundle mainBundle] loadNibNamed:@"MutableIssueDetailCell" owner:self options:nil];
			mCell = mutableCell;
		}
		
		// Configure the cell...
		mCell.title.text = [self titleForCellAtIndexPath:indexPath];
		return mCell;
	}
 */




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	self.mutableCell = nil;
	[super viewDidUnload];
}


- (void)dealloc {
	[project release];
	[mutableCell release];
    [super dealloc];
	[mutableLink release];
}

#pragma mark -
#pragma mark Connector delegate

- (void)didReceiveData:(id)result {
	if ([result isKindOfClass:[Issue class]]) {
		if ([delegate respondsToSelector:@selector(didCreateNewIssue:)]) {
			[delegate didCreateNewIssue:result];
		}
		[self dismissModalViewControllerAnimated:YES];
	}
}

- (void)didFailWithError:(id )error {
	if ([error isKindOfClass:[NSError class]]) {
		
	}
	else if ([error isKindOfClass:[SoapFault class]]) {
		SoapFault *sf = (SoapFault *)error;
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" 
														message:sf.faultString
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

-(void)textFieldReturn:(id)sender {
	
}


@end

