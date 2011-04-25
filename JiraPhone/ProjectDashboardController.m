//
//  ProjectDashboardController.m
//  JiraPhone
//
//  Created by Matthew Gerrior on 3/19/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "ProjectDashboardController.h"
#import "ProjectsController.h"
#import "Connector.h"
#import "Project.h"
#import "Issue.h"
#import "IssueDetailsController.h"
#import "ActivityController.h"
#import "Priority.h"
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "JiraPhoneAppDelegate.h"

@implementation ProjectDashboardController
@synthesize project;

- (id)initForProject:(Project *)_project {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		self.project = _project;
	}
	return self;
}

- (void)showProjectActivityScreen {
	// Show the rss activity stream for the project
	ActivityController *activityController = [[ActivityController alloc] initForProject:project];
	[self.navigationController pushViewController:activityController animated:YES];
	[activityController release];
}

- (void)showProjectsList {
	[self.navigationController popViewControllerAnimated:YES];
	//ProjectsController *projController = [[ProjectsController alloc] initWithNibName:@"ProjectsController" bundle:nil];
	//[self.navigationController pushViewController:projController animated:YES];
	//[projController release];
}

- (void)getUnresolvedByPriority:(NSMutableArray *)_unresolvedPriority ofProject:(Project *)_proj {
	
	NSString *queryString = [NSString stringWithFormat:@"select i.priority AS issuePriority, count(*) AS numIssues from issues i where i.project = \"%@\" GROUP BY i.priority", _proj.key];
	
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	FMResultSet *rs = [db executeQuery:queryString];
	while ([rs next])
	{
		NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
		NSString *issuePriority = [rs stringForColumn:@"issuePriority"];
		NSInteger numIssues = [[rs stringForColumn:@"numIssues"] intValue];
		NSLog(@"%@ : %d", issuePriority, numIssues);
		[item setObject:issuePriority forKey:@"issuePriority"];
		[item setObject:[NSNumber numberWithInt:numIssues] forKey:@"numIssues"];
		[unresolvedPriority addObject:item];
		[item release];
	}
	[rs close];
	
	// This section is for debugging
	/*
	queryString = [NSString stringWithFormat:@"select key, assignee from issues where project = \"%@\"", project.key];
	rs = [db executeQuery:queryString];
	while ([rs next]) {
		NSLog(@"Issue: %@ Assignee: %@", [rs stringForColumn:@"key"], [rs stringForColumn:@"assignee"] );
	}
	[rs close]; */
	if ([db hadError]) {
		NSLog(@"db error: %@", [db lastErrorMessage]);
	}
	[self.tableView reloadData];
	
}

- (void)getUnresolvedByAssignee:(NSMutableArray *)_unresolvedAssignee ofProject:(Project *)_proj {
	
	NSString *queryString = [NSString stringWithFormat:@"select u.name AS userName, count(*) AS numIssues from issues i, users u where i.project = \"%@\" and u.name = i.assignee GROUP BY u.name", _proj.key];
	
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	FMResultSet *rs = [db executeQuery:queryString];
	while ([rs next])
	{
		NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
		NSString *userName = [rs stringForColumn:@"userName"];
		NSInteger numIssues = [[rs stringForColumn:@"numIssues"] intValue];
		NSLog(@"%@ : %d", userName, numIssues);
		[item setObject:userName forKey:@"userName"];
		[item setObject:[NSNumber numberWithInt:numIssues] forKey:@"numIssues"];
		[unresolvedAssignee addObject:item];
		[item release];
	}
	[rs close];
	
	// This section is for debugging
	/*
	 queryString = [NSString stringWithFormat:@"select key, assignee from issues where project = \"%@\"", project.key];
	 rs = [db executeQuery:queryString];
	 while ([rs next]) {
	 NSLog(@"Issue: %@ Assignee: %@", [rs stringForColumn:@"key"], [rs stringForColumn:@"assignee"] );
	 }
	 [rs close]; */
	if ([db hadError]) {
		NSLog(@"db error: %@", [db lastErrorMessage]);
	}
	[self.tableView reloadData];
	
}

- (void)getStatusSummary {
	
	NSString *queryString = [NSString stringWithFormat:@"select i.status AS issueStatus, count(*) AS numIssues from issues i where i.project = \"%@\" GROUP BY i.status", project.key];
	
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	FMResultSet *rs = [db executeQuery:queryString];
	while ([rs next])
	{
		NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
		NSString *issueStatus = [rs stringForColumn:@"issueStatus"];
		NSInteger numIssues = [[rs stringForColumn:@"numIssues"] intValue];
		NSLog(@"%@ : %d", issueStatus, numIssues);
		[item setObject:issueStatus forKey:@"issueStatus"];
		[item setObject:[NSNumber numberWithInt:numIssues] forKey:@"numIssues"];
		[statusList addObject:item];
		[item release];
	}
	[rs close];
	
	// This section is for debugging
	/*
	 queryString = [NSString stringWithFormat:@"select key, assignee from issues where project = \"%@\"", project.key];
	 rs = [db executeQuery:queryString];
	 while ([rs next]) {
	 NSLog(@"Issue: %@ Assignee: %@", [rs stringForColumn:@"key"], [rs stringForColumn:@"assignee"] );
	 }
	 [rs close]; */
	if ([db hadError]) {
		NSLog(@"db error: %@", [db lastErrorMessage]);
	}
	[self.tableView reloadData];
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Set the title of the screen to the project name
	self.title = project.name;

	// Initialize list of due issues
	if (!dueIssues) {
		dueIssues = [[NSMutableArray alloc] init];
	}
	
	// Initialize list of recent issues
	if (!recentIssues) {
		recentIssues = [[NSMutableArray alloc] init];
	}
	
	// Initialize the count of unresolved issues by assignee
	if (!unresolvedAssignee) {
		unresolvedAssignee = [[NSMutableArray alloc] init];
	}
	
	// Initialize the count of unresolved issues by priority
	if (!unresolvedPriority) {
		unresolvedPriority = [[NSMutableArray alloc] init];
	}
	
	// Initialize the status summary
	if (!statusList) {
		statusList = [[NSMutableArray alloc] init];
	}
	
	// Sync with server
	Connector *connector = [Connector sharedConnector];
	connector.delegate = self;
	
	// Get issues from the server that are due
	[connector getDueIssuesForProject:project];
	
	// If there are no cached due issues, show wait spinner
	if (!dueIssues.count) {
		if (!activityIndicator) {
			activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
			activityIndicator.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
			[self.view addSubview:activityIndicator];
			[activityIndicator release];
		}
		[activityIndicator startAnimating];		
	}
	
	// Get issues from the server that have been updated recently
	[connector getRecentIssuesForProject:project];
	
	// If there are no cached recent issues, show wait spinner
	if (!recentIssues.count) {
		if (!activityIndicator) {
			activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
			activityIndicator.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
			[self.view addSubview:activityIndicator];
			[activityIndicator release];
		}
		[activityIndicator startAnimating];		
	}
	
	// Get the number of unresolved issues for each user
	[self getUnresolvedByAssignee:unresolvedAssignee ofProject:project];
	
	// Get the number of unresolved issues for each user
	[self getUnresolvedByPriority:unresolvedPriority ofProject:project];
	
	// Get the status summary
	[self getStatusSummary];
	
	// Add an action button to view activity stream
	UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showActionSheet:)];
	self.navigationItem.rightBarButtonItem = btn;
	[btn release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Depending on the section, return the appropriate size
	// based on the number of issues in that section. 
	if (section == 0) {
		return [dueIssues count];
	}
	else if (section == 1) {
		return [recentIssues count];
	}
	else if (section == 2) {
		return [unresolvedAssignee count];
	}
	else if (section == 3){
		return [unresolvedPriority count];
	}	
	else {
		return [statusList count];
	}

}

- (UIImage *)getImageByPriority:(Priority *)priority {
	// Depending on the issue priority, return the 
	// appropriate image.
	switch (priority.number) {
		case 1:
			return [UIImage imageNamed:@"priority_blocker.gif"];
		case 2:
			return [UIImage imageNamed:@"priority_critical.gif"];
		case 3:
			return [UIImage imageNamed:@"priority_major.gif"];
		case 4:
			return [UIImage imageNamed:@"priority_minor.gif"];
		case 5:
			return [UIImage imageNamed:@"priority_trivial.gif"];
		default:
			return nil;
	}
}

- (NSString *)getPriorityByInteger:(NSInteger)_number {
	switch (_number) {
		case 1:
			return @"Blocker";
		case 2:
			return @"Critical";
		case 3:
			return @"Major";
		case 4:
			return @"Minor";
		case 5:
			return @"Trivial";
		default:
			return nil;
	}
}

- (NSString *)getStatusByInteger:(NSInteger)_number {
	switch (_number) {
		case 1:
			return @"Open";
		case 3:
			return @"In Progress";
		case 5:
			return @"Resolved";
		case 6:
			return @"Closed";
		default:
			return nil;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	// Create a date formatter for important issue dates
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"MM/dd/yyyy"];
	
	// If this is the due issues section...
	if (indexPath.section == 0) {
		// Make sure there are enough issues to populate the cell
		if (dueIssues.count >= indexPath.row+1) {
			// Get the issue at the current row
			Issue *issue = [dueIssues objectAtIndex:indexPath.row];
			// Format the issue date to a more readable format
			NSString *dueDate = [dateFormat stringFromDate:issue.duedate];
			// Display issue details
			cell.textLabel.text = [NSString stringWithFormat:@"%@", issue.key];
			if (dueDate != nil) {
				cell.detailTextLabel.text = [NSString stringWithFormat:@"Due %@", dueDate];
			}
			cell.imageView.image = [self getImageByPriority:issue.priority];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		else {
			cell.textLabel.text = [NSString stringWithFormat:@"Loading..."];
		}

	}
	else if (indexPath.section == 1) {
		// Check if there is an issue here
		if (recentIssues.count >= indexPath.row+1) {
			// Get the issue that the cell will display
			Issue *issue = [recentIssues objectAtIndex:indexPath.row];
			// Format the updated date of the issue
			NSString *updatedDate = [dateFormat stringFromDate:issue.updated];
			// Display issue details
			cell.textLabel.text = [NSString stringWithFormat:@"%@", issue.key];
			if (updatedDate != nil) {
				cell.detailTextLabel.text = [NSString stringWithFormat:@"Updated: %@", updatedDate];
			}
			cell.imageView.image = [self getImageByPriority:issue.priority];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		else {
			cell.textLabel.text = [NSString stringWithFormat:@"Loading..."];
		}

	}
	else if (indexPath.section == 2){
		// Display a user and the number of unresolved issues assigned to them.
		NSString *name = [[unresolvedAssignee objectAtIndex:indexPath.row] objectForKey:@"userName"];
		if (name == nil)
		{
			name = [NSString stringWithFormat:@"Unassigned"];
		}
		NSInteger numIssues = [[[unresolvedAssignee objectAtIndex:indexPath.row] valueForKey:@"numIssues"] integerValue];
		cell.textLabel.text = [NSString stringWithFormat:@"%@: %d",name, numIssues];
		cell.imageView.image = nil;
		cell.detailTextLabel.text = nil;
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	else if (indexPath.section == 3){
		NSInteger priority = [[[unresolvedPriority objectAtIndex:indexPath.row] objectForKey:@"issuePriority"] integerValue];
		NSInteger numIssues = [[[unresolvedPriority objectAtIndex:indexPath.row] valueForKey:@"numIssues"] integerValue];
		cell.textLabel.text = [NSString stringWithFormat:@"%@: %d", [self getPriorityByInteger:priority], numIssues];
		cell.imageView.image = nil;
		cell.detailTextLabel.text = nil;
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	else {
		NSInteger status = [[[statusList objectAtIndex:indexPath.row] objectForKey:@"issueStatus"] integerValue];
		NSInteger numIssues = [[[statusList objectAtIndex:indexPath.row] valueForKey:@"numIssues"] integerValue];
		cell.textLabel.text = [NSString stringWithFormat:@"%@: %d", [self getStatusByInteger:status], numIssues];
		cell.imageView.image = nil;
		cell.detailTextLabel.text = nil;
		cell.accessoryType = UITableViewCellAccessoryNone;
	}

	[dateFormat release];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0 || indexPath.section == 1) {
		// If the user selects an issue, display the issue details
		IssueDetailsController *issueDetailsController = [[IssueDetailsController alloc] initForIssue:[dueIssues objectAtIndex:indexPath.row]];
		[self.navigationController pushViewController:issueDetailsController animated:YES];
		[issueDetailsController release];
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return [NSString stringWithFormat:@"Issues: Due"];
		case 1:
			return [NSString stringWithFormat:@"Issues: Updated recently"];
		case 2:
			return [NSString stringWithFormat:@"Unresolved: By Assignee"];
		case 3:
			return [NSString stringWithFormat:@"Unresolved: By Priority"];
		case 4:
			return [NSString stringWithFormat:@"Status Summary"];
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
	if(dueIssues){[dueIssues release]; dueIssues = nil;}
	if(recentIssues){[recentIssues release]; recentIssues = nil;}
	if(unresolvedAssignee){[unresolvedAssignee release]; unresolvedAssignee = nil;}
	if(unresolvedPriority){[unresolvedPriority release]; unresolvedPriority = nil;}
	if(statusList){[statusList release]; statusList = nil;}
    [super dealloc];
}

- (void)didReceiveData:(id)result {
	[activityIndicator stopAnimating];
	if (!dueIssues.count) {
		// If we have no due issues, store the issues
		// that are due
		if ([result isKindOfClass:[NSArray class]]) {
			[dueIssues release];
			dueIssues = [result retain];
			[self.tableView reloadData];
		}
	}
	else {
		// Store recent issues
		if ([result isKindOfClass:[NSArray class]]) {
			[recentIssues release];
			recentIssues = [result retain];
			[self.tableView reloadData];
		}
	}
}

- (void)didFailWithError:(NSError *)error {
	[activityIndicator stopAnimating];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message: [error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (IBAction)showActionSheet:(id)sender {
	UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"View Activity Stream", @"Change Project", nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[popupQuery showInView:self.view];
	[popupQuery release];
}

- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 0:
			// User wants to view activity stream
			[self showProjectActivityScreen];
			break;
		case 1:
			[self showProjectsList];
			break;
		default:
			break;
	}
}
@end
