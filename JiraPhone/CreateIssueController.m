//
//  CreateIssueController.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 1/10/11.
//  Copyright 2011 AMaslov. All rights reserved.
//
#import "CreateIssueController.h"
#import "MutableIssueDetailCell.h"
#import "Connector.h"
#import "Project.h"
#import "IssueType.h"


@implementation CreateIssueController
@synthesize mutableCell;
@synthesize project;
@synthesize delegate; 
@synthesize mutableLink;
@synthesize pickerViewArray = _pickerViewArray;
@synthesize groupArray=_groupArray;
@synthesize selectedIndex;
@synthesize newIssue;


#pragma mark -
#pragma mark Initialization

- (id)initForIssueInProject:(Project *)_project {
	// send nil, because we do not need it. 
	self.clearsSelectionOnViewWillAppear=NO;
	if (self = [super initForIssue: nil]) {
		self.project = _project;
		self.newIssue=[[Issue alloc] init];
		self.newIssue.project=_project.key;
		self.newIssue.reporter=[User loggedInUser].name;
	}
	return self;	
}

#pragma mark -
#pragma mark Actions

- (IBAction)cancelAction {
	[self dismissModalViewControllerAnimated:YES];
}

//on completion
- (IBAction)doneAction {
	 newIssue.reporter = [User loggedInUser].name; 
	 [Connector sharedConnector].delegate = self;
	 [[Connector sharedConnector] createIssue: newIssue];
	 //[newIssue release];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
	NSLog(@"Did End Editing");
	MutableIssueDetailCell *cell = (MutableIssueDetailCell *)[[textField superview] superview];
    UITableView *table = (UITableView *)[cell superview];
    NSIndexPath *textFieldIndexPath = [table indexPathForCell:cell];
	NSLog(@"Index Path Section: %d", textFieldIndexPath.section);
	NSLog(@"Index Path Row: %d", textFieldIndexPath.row);
	if (textFieldIndexPath.section==ISSUE_DATA_SECTION){
		if (textFieldIndexPath.row==ISSUE_SUMMARY_ROW){
			newIssue.summary=cell.textField.text;
		}
		if (textFieldIndexPath.row==ISSUE_DESCRIPTION_ROW){
			newIssue.description==cell.textField.text;
		}
	}
	
	if (textFieldIndexPath.section==ISSUE_MAN_SECTION){
		if (textFieldIndexPath.row==ISSUE_ASSIGNEE_ROW){
			newIssue.assignee=cell.textField.text;
		}
	}
}	

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if ([string isEqualToString:@"\n"])
	{
		[textField resignFirstResponder];
		return NO;
	}
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
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
	// only first category has 4 items, the last has 1 item
    return section == ISSUE_DATA_SECTION ? 4 : 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	// 	NSString *identifier;
	UITableViewCellStyle styleLink = UITableViewCellStyleValue2;
	//UITableViewCellStyle styleText = UITableViewCellStyleDefault;
	static NSString *idTextboxCell = @"idTextboxCell";
	static NSString *idLinkCell=@"idLinkCell";
	if (indexPath.section==ISSUE_MAN_SECTION)
	{
		if (indexPath.row==ISSUE_ASSIGNEE_ROW)
			
		{
			MutableIssueDetailCell *cell = (MutableIssueDetailCell *) [tableView dequeueReusableCellWithIdentifier:idTextboxCell];
			if (cell == nil) 
			{
				//cell=[[[MutableIssueDetailCell alloc]initWithStyle:styleText reuseIdentifier:idTextboxCell]autorelease];
				[[NSBundle mainBundle] loadNibNamed:@"MutableIssueDetailCell" owner:self options:nil];
				cell = mutableCell;
				cell.textField.delegate = self;
			}
			cell.title.text= [self titleForCellAtIndexPath:indexPath];
			return cell;
		}
		else {
			MutableIssueDetailCell *cell =(MutableIssueDetailCell *)[tableView dequeueReusableCellWithIdentifier:idTextboxCell];
			if (cell==nil) {
				[[NSBundle mainBundle] loadNibNamed:@"MutableIssueDetailCell" owner:self options:nil];
				cell = mutableCell;
			}
			cell.title.text = [self titleForCellAtIndexPath:indexPath];
			return cell;
		}
		
	}
	if (indexPath.section==ISSUE_DATA_SECTION)
	{
		switch (indexPath.row) {
			case ISSUE_SUMMARY_ROW: {
				MutableIssueDetailCell *cell = (MutableIssueDetailCell *) [tableView dequeueReusableCellWithIdentifier:idTextboxCell];
				if (cell == nil)
				{
					[[NSBundle mainBundle] loadNibNamed:@"MutableIssueDetailCell" owner:self options:nil];
					cell = mutableCell;
					cell.textField.delegate = self;
				}
				cell.title.text = [self titleForCellAtIndexPath:indexPath];
				return cell;
			}
				break;
			case ISSUE_DESCRIPTION_ROW: 
			{
				MutableIssueDetailCell *cell = (MutableIssueDetailCell *) [tableView dequeueReusableCellWithIdentifier:idTextboxCell];
				if (cell == nil)
				{
					//cell=[[[MutableIssueDetailCell alloc]initWithStyle:styleText reuseIdentifier:idTextboxCell]autorelease];
					[[NSBundle mainBundle] loadNibNamed:@"MutableIssueDetailCell" owner:self options:nil];
					cell = mutableCell;
					cell.textField.delegate = self;
				}
				cell.title.text = [self titleForCellAtIndexPath:indexPath];
				return cell;
			}
				break;
			case ISSUE_TYPE_ROW: 
			{
				LinkCell *cell = (LinkCell *) [tableView dequeueReusableCellWithIdentifier:idLinkCell];
				if (cell == nil)
				{
					cell=[[[LinkCell alloc]initWithStyle:styleLink reuseIdentifier:idLinkCell]autorelease];
				}
				cell.textLabel.text=[self titleForCellAtIndexPath:indexPath];
				if (newIssue.type!=nil)
					cell.detailTextLabel.text=newIssue.type.stringRepresentation;
				return cell;
			}
				break;
			case ISSUE_PRIORITY_ROW: 
			{
				LinkCell *cell = (LinkCell *) [tableView dequeueReusableCellWithIdentifier:idLinkCell];
				if (cell == nil)
				{
					cell=[[[LinkCell alloc]initWithStyle:styleLink reuseIdentifier:idLinkCell]autorelease];
				}
				cell.textLabel.text=[self titleForCellAtIndexPath:indexPath];
				if (newIssue.priority!=nil)
					cell.detailTextLabel.text=newIssue.type.stringRepresentation;
				return cell;
			}
				break;
			default:{
				MutableIssueDetailCell *cell =(MutableIssueDetailCell *)[tableView dequeueReusableCellWithIdentifier:idTextboxCell];
				if (cell==nil) {
					[[NSBundle mainBundle] loadNibNamed:@"MutableIssueDetailCell" owner:self options:nil];
					cell = mutableCell;
				}
				cell.title.text = [self titleForCellAtIndexPath:indexPath];
				return cell;
			}
				break;
		}
	}
	else {
		MutableIssueDetailCell *cell =(MutableIssueDetailCell *)[tableView dequeueReusableCellWithIdentifier:idTextboxCell];
		if (cell==nil) {
			[[NSBundle mainBundle] loadNibNamed:@"MutableIssueDetailCell" owner:self options:nil];
			cell = mutableCell;
			cell.textField.delegate = self;
		}
		cell.title.text = [self titleForCellAtIndexPath:indexPath];
		return cell;
	}
}

- (void)itemWasSelected:(NSNumber *)selectedIndexNumber {
	//Selection was made
	self.selectedIndex = [selectedIndexNumber intValue];
}



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
	UITableViewCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
	//selectedIndex=0;
	NSMutableString *str = [NSMutableString string];
	if (indexPath.section==ISSUE_DATA_SECTION) {
		switch (indexPath.row) {
			case ISSUE_TYPE_ROW: {
				[self.pickerViewArray removeAllObjects];
				//if (newIssue.type == NULL)
				//	selectedIndex=0;
				//else {
					selectedIndex=newIssue.type.number;
				//}
				self.pickerViewArray = [NSMutableArray arrayWithObjects:@"Bug", @"New Feature", @"Task", @"Improvement", nil];
				ActionSheetPicker *asp = [[ActionSheetPicker alloc]initForDataWithContainingView:self.view data:self.pickerViewArray selectedIndex:self.selectedIndex target:self action:@selector(itemWasSelected:)];    //initWithContainingView:self.view target:self action:@selector(itemWasSelected:)];
				[asp displayActionPickerWithView:self.view data:self.pickerViewArray selectedIndex:self.selectedIndex target:self action:@selector(itemWasSelected:)];
				//[asp showDataPicker];
				IssueType *t = [[IssueType alloc]init];
				t.number=selectedIndex+1;
				newIssue.type=t;
				[str appendFormat:@"%@", t.stringRepresentation];
				[t release];
				currentCell.detailTextLabel.text=str;
				[asp release];
				break;
			}
			case ISSUE_PRIORITY_ROW: {
				[self.pickerViewArray removeAllObjects];
				self.pickerViewArray = [NSMutableArray arrayWithObjects:@"Blocker", @"Critical", @"Major", @"Minor", @"Trivial", nil];
				//int indexSel=newIssue.priority.number;
				//if (newIssue.priority == NULL)
				//	selectedIndex=0;
				//else {
					selectedIndex=newIssue.priority.number;
				//}

				ActionSheetPicker *asp = [[ActionSheetPicker alloc]initForDataWithContainingView:self.view data:self.pickerViewArray selectedIndex:self.selectedIndex target:self action:@selector(itemWasSelected:)]; //initWithContainingView:self.view target:self action:@selector(itemWasSelected:)];
				[asp displayActionPickerWithView:self.view data:self.pickerViewArray selectedIndex:self.selectedIndex target:self action:@selector(itemWasSelected:)];
				Priority *p = [[Priority alloc]init];
				//[asp showDataPicker];
				p.number=selectedIndex+1;
				newIssue.priority=p;
				[str appendFormat:@"%@", p.stringRepresentation];
				[p release];
				currentCell.detailTextLabel.text=str;
				[asp release];
				break;
			}
		}
	}
	//	currentCell.detailTextLabel.text=str;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	//	self.mutableCell = nil;
	[super viewDidUnload];
}


- (void)dealloc {
	[project release];
	[newIssue release];
	//	[mutableCell release];
	[super dealloc];
	//  [mutableLink release];
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
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
														message:sf.faultString
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}
/*
 -(void)textFieldReturn:(id)sender {
 
 }
 */

@end

