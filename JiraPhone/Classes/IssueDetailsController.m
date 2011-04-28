//
//  IssueDetailsController.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/20/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import "IssueDetailsController.h"
#import "Issue.h"
#import "IssueType.h"
#import "User.h"

@implementation IssueDetailsController

#pragma mark -
#pragma mark View lifecycle

- (id)initForIssue:(Issue *)_issue {
	if (self = [super initWithNibName:@"IssueDetailsController" bundle:nil]) {
		issue = [_issue retain];
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = issue.key;
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
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// only first category has 6 items, the last two have 2 items in each
    return section == ISSUE_DATA_SECTION ? 7 : 2;
}

- (NSString *)titleForCellAtIndexPath:(NSIndexPath *)indexPath {
	NSString *ret = nil;
    if (indexPath.section == ISSUE_DATA_SECTION) {
		switch (indexPath.row) {
			case ISSUE_TYPE_ROW:
				ret = @"Issue type: ";
				break;
			case ISSUE_PRIORITY_ROW:
				ret = @"Priority: ";
				break;
			case ISSUE_AFFECT_VERSIONS_ROW:
				ret = @"Affect versions: ";
				break;
			case ISSUE_STATUS_ROW:
				ret = @"Status: ";
				break;
			case ISSUE_DESCRIPTION_ROW:
				ret=@"Description: ";
				break;
			case ISSUE_RESOLUTION_ROW:
				ret = @"Resolution: ";
				break;
			case ISSUE_SUMMARY_ROW:
				ret = @"Summary: ";
				break;
			default:
				break;
		}
	}
	else if (indexPath.section == ISSUE_MAN_SECTION) {
		switch (indexPath.row) {
			case ISSUE_ASSIGNEE_ROW:
				ret = @"Assignee: ";
				break;
			case ISSUE_REPORTER_ROW:
				ret = @"Reporter: ";
				break;	
			default:
				break;
		}
	}
	else if (indexPath.section == ISSUE_DATE_SECTION) {
		switch (indexPath.row) {
			case ISSUE_CREATED_ROW:
				ret = @"Created: ";
				break;
			case ISSUE_UPDATED_ROW:
				ret = @"Updated: ";
				break;
			default:
				break;
		}
	}
	return ret;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.textLabel.numberOfLines = 0;
    }
    
    // Configure the cell...
	NSMutableString *str = [NSMutableString string];
	[str appendString: [self titleForCellAtIndexPath:indexPath]];
    if (indexPath.section == ISSUE_DATA_SECTION) {
		switch (indexPath.row) {
			case ISSUE_TYPE_ROW:
			{
				[str appendFormat:@"%@", issue.type.stringRepresentation];
				break;
			}
			case ISSUE_PRIORITY_ROW:
				[str appendFormat:@"%@", issue.priority.stringRepresentation];
				break;
			case ISSUE_AFFECT_VERSIONS_ROW:
				[str appendFormat:@"%@", @"todo"];
				break;
			case ISSUE_STATUS_ROW:
				[str appendFormat:@"%@", issue.status];
				break;
			case ISSUE_RESOLUTION_ROW:
				[str appendFormat:@"%@", issue.resolution? issue.resolution : @""];
				break;
			case ISSUE_SUMMARY_ROW:
				[str appendFormat:@"%@", issue.summary];
				break;
			case ISSUE_DESCRIPTION_ROW:
				[str appendFormat:@"%@", issue.description];
				break;
			default:
				break;
		}
	}
	else if (indexPath.section == ISSUE_MAN_SECTION) {
		switch (indexPath.row) {
			case ISSUE_ASSIGNEE_ROW:
				[str appendFormat:@"%@", issue.assignee];				
				break;
			case ISSUE_REPORTER_ROW:
				[str appendFormat:@"%@", issue.reporter];				
				break;	
			default:
				break;
		}
	}
	else if (indexPath.section == ISSUE_DATE_SECTION) {
		switch (indexPath.row) {
			case ISSUE_CREATED_ROW:
				[str appendFormat:@"%@", issue.created];				
				break;
			case ISSUE_UPDATED_ROW:
				[str appendFormat:@"%@", issue.updated];				
				break;	
			default:
				break;
		}
	}
	cell.textLabel.text = str;
    return cell;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
	 // ...
	 // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return [NSString stringWithFormat:@"Details:"];
		case 1:
			return [NSString stringWithFormat:@"Stakeholders:"];
		case 2:
			return [NSString stringWithFormat:@"Dates:"];
		default:
			return [NSString stringWithFormat:@"Category %d", section+1];
	}
}
#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	[super viewDidLoad];
}


- (void)dealloc {
	if(issue){[issue release]; issue = nil;}
    [super dealloc];
}

@end