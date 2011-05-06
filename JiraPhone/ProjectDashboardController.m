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
#import "IssuesController.h"
#import "IssueDetailsController.h"
#import "ActivityController.h"
#import "Priority.h"
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "JiraPhoneAppDelegate.h"
#import "CreateIssueController.h"

#define PROJECT_DETAILS_SECTION 0
#define DUE_ISSUES_SECTION 1
#define RECENT_ISSUES_SECTION 2
#define ISSUES_ASSIGNEE_SECTION 3
#define ISSUES_PRIORITY_SECTION 4
#define STATUS_SUMMARY_SECTION 5

#define PROJECT_ACTIVITY_BUTTON 0
#define PROJECT_CREATE_ISSUE 1
#define PROJECT_ISSUES_BUTTON 2

#define PROJECT_DESCRIPTION_CELL 0
#define PROJECT_LEAD_CELL 1
#define PROJECT_KEY_CELL 2

@implementation ProjectDashboardController
@synthesize project;

- (id)initForProject:(Project *)_project {
	// Initialize the screen for the given project
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

- (void)showIssuesList {
	IssuesController *issuesController = [[IssuesController alloc] initForProject:project];
	[self.navigationController pushViewController:issuesController animated:YES];
	[issuesController release];
}

- (void)showProjectsList {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)getUnresolvedByPriority {
	// Build the query to be execture
	NSString *queryString = [NSString stringWithFormat:@"select i.priority AS issuePriority, count(*) AS numIssues from issues i where i.project = \"%@\" GROUP BY i.priority", project.key];
	
	// Get the database
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	
	// Get the results of the query
	FMResultSet *rs = [db executeQuery:queryString];
	while ([rs next])
	{
		// Store each issue priority and the number of issues for the priority
		NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
		NSString *issuePriority = [rs stringForColumn:@"issuePriority"];
		NSInteger numIssues = [[rs stringForColumn:@"numIssues"] intValue];
		[item setObject:issuePriority forKey:@"issuePriority"];
		[item setObject:[NSNumber numberWithInt:numIssues] forKey:@"numIssues"];
		[unresolvedPriority addObject:item];
		[item release];
	}
	// Close the result set
	[rs close];
	
	// Output any errors that occur
	if ([db hadError]) {
		NSLog(@"db error: %@", [db lastErrorMessage]);
	}
	// Reload data in the table
	[self.tableView reloadData];
	
}

- (void)getUnresolvedByAssignee{
	// Build the query to be executed
	NSString *queryString = [NSString stringWithFormat:@"select i.assignee AS issueAssignee, count(*) AS numIssues from issues i where i.project = \"%@\" GROUP BY i.assignee", project.key];
	
	// Get the database
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	
	// Get the results of the query
	FMResultSet *rs = [db executeQuery:queryString];
	while ([rs next])
	{	
		// Store each user and the number of issues assigned to them that are unresolved
		NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
		NSString *issueAssignee = [rs stringForColumn:@"issueAssignee"];
		NSInteger numIssues = [[rs stringForColumn:@"numIssues"] intValue];
		if ([issueAssignee compare:[NSString stringWithFormat:@"(null)"]] == NSOrderedSame)
		{
			issueAssignee = [NSString stringWithFormat:@"unassigned"];
		}
		NSLog(@"%@ : %d", issueAssignee, numIssues);
		[item setObject:issueAssignee forKey:@"issueAssignee"];
		[item setObject:[NSNumber numberWithInt:numIssues] forKey:@"numIssues"];
		[unresolvedAssignee addObject:item];
		[item release];
	}
	// Close the result set
	[rs close];
	
	// Ouput any errors from the database
	if ([db hadError]) {
		NSLog(@"db error: %@", [db lastErrorMessage]);
	}
	
	// Reload the data in the table
	[self.tableView reloadData];
	
}

- (void)getStatusSummary {
	// Build the query to be executed
	NSString *queryString = [NSString stringWithFormat:@"select i.status AS issueStatus, count(*) AS numIssues from issues i where i.project = \"%@\" GROUP BY i.status", project.key];
	
	// Get the database
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	
	// Get the results from the query
	FMResultSet *rs = [db executeQuery:queryString];
	while ([rs next])
	{
		// For each status, store the number of issues that have that status
		NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
		NSString *issueStatus = [rs stringForColumn:@"issueStatus"];
		NSInteger numIssues = [[rs stringForColumn:@"numIssues"] intValue];
		[item setObject:issueStatus forKey:@"issueStatus"];
		[item setObject:[NSNumber numberWithInt:numIssues] forKey:@"numIssues"];
		[statusList addObject:item];
		[item release];
	}
	
	// Close the result set
	[rs close];
	
	// Output any errors from the database
	if ([db hadError]) {
		NSLog(@"db error: %@", [db lastErrorMessage]);
	}
	
	// Update the data in the table
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
	
	cachedIssues = FALSE;
	// Get the issues for the current project
	[connector getIssuesOfProject:project];
	if (!cachedIssues) {
		if (!activityIndicator) {
			activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
			activityIndicator.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
			[self.view addSubview:activityIndicator];
			[activityIndicator release];
		}
		[activityIndicator startAnimating];		
	}
	
	// Add an action button to view activity stream
	UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showActionSheet:)];
	self.navigationItem.rightBarButtonItem = btn;
	[btn release];
}

- (void)getStatisticsFromDB {
	// Get the number of unresolved issues for each user
	[self getUnresolvedByAssignee];
	
	// Get the number of unresolved issues for each user
	[self getUnresolvedByPriority];
	
	// Get the status summary
	[self getStatusSummary];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Depending on the section, return the appropriate size
	// based on the number of issues in that section.
	switch (section) {
		case PROJECT_DETAILS_SECTION:
			return 3;
		case DUE_ISSUES_SECTION:
			return [dueIssues count];
			break;
		case RECENT_ISSUES_SECTION:
			return [recentIssues count];
			break;
		case ISSUES_ASSIGNEE_SECTION:
			return [unresolvedAssignee count];
			break;
		case ISSUES_PRIORITY_SECTION:
			return [unresolvedPriority count];
			break;
		case STATUS_SUMMARY_SECTION:
			return [statusList count];
			break;
		default: 
			return 0;
			break;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	// Create a cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	// Create a date formatter for important issue dates
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"MM/dd/yyyy"];
	
	if (indexPath.section == PROJECT_DETAILS_SECTION) {
		switch (indexPath.row) {
			case PROJECT_DESCRIPTION_CELL:
				if ([project.description compare:@"(null)"] != NSOrderedSame) {
					cell.textLabel.text = [NSString stringWithFormat:@"Description: %@", project.description];
				}
				else {
					cell.textLabel.text = [NSString stringWithFormat:@"Description: No description available."];
				}
				break;
			case PROJECT_LEAD_CELL:
				cell.textLabel.text = [NSString stringWithFormat:@"Lead: %@", project.lead];
				break;
			case PROJECT_KEY_CELL:
				cell.textLabel.text = [NSString stringWithFormat:@"Key: %@", project.key];
				break;
			default:
				break;
		}
		cell.detailTextLabel.text = nil;
		cell.imageView.image = nil;
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	// If this is the due issues section...
	else if (indexPath.section == DUE_ISSUES_SECTION) {
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
			cell.imageView.image = [JiraPhoneAppDelegate getImageByPriority:[NSNumber numberWithInt:issue.priority.number]];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		else {
			cell.textLabel.text = [NSString stringWithFormat:@"Loading..."];
		}

	}
	else if (indexPath.section == RECENT_ISSUES_SECTION) {
		// Check if there are enough issues to populate the cell
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
			cell.imageView.image = [JiraPhoneAppDelegate getImageByPriority:[NSNumber numberWithInt:issue.priority.number]];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		else {
			cell.textLabel.text = [NSString stringWithFormat:@"Loading..."];
		}

	}
	else if (indexPath.section == ISSUES_ASSIGNEE_SECTION){
		// Get a username and the number of unresolved issues assigned to them
		NSString *name = [[unresolvedAssignee objectAtIndex:indexPath.row] objectForKey:@"issueAssignee"];
		NSInteger numIssues = [[[unresolvedAssignee objectAtIndex:indexPath.row] valueForKey:@"numIssues"] integerValue];
		// Fill in the cell details
		cell.textLabel.text = [NSString stringWithFormat:@"%@: %d",name, numIssues];
		cell.imageView.image = nil;
		cell.detailTextLabel.text = nil;
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	else if (indexPath.section == ISSUES_PRIORITY_SECTION){
		// Get a priority and the number of issues with that priority
		NSNumber *priority = [NSNumber numberWithInteger:[[[unresolvedPriority objectAtIndex:indexPath.row] objectForKey:@"issuePriority"] integerValue]];
		NSInteger numIssues = [[[unresolvedPriority objectAtIndex:indexPath.row] valueForKey:@"numIssues"] integerValue];
		// Populate the cell
		cell.textLabel.text = [NSString stringWithFormat:@"%@: %d", [JiraPhoneAppDelegate getStringByPriority:priority], numIssues];
		cell.imageView.image = [JiraPhoneAppDelegate getImageByPriority:priority];
		cell.detailTextLabel.text = nil;
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	else {
		// Get a status and the number of issues with that status
		NSNumber *status = [NSNumber numberWithInteger:[[[statusList objectAtIndex:indexPath.row] objectForKey:@"issueStatus"] integerValue]];
		NSInteger numIssues = [[[statusList objectAtIndex:indexPath.row] valueForKey:@"numIssues"] integerValue];
		// Populate the cell
		cell.textLabel.text = [NSString stringWithFormat:@"%@: %d", [JiraPhoneAppDelegate getStringByStatus:status], numIssues];
		cell.imageView.image = [JiraPhoneAppDelegate getImageByStatus:status];;
		cell.detailTextLabel.text = nil;
		cell.accessoryType = UITableViewCellAccessoryNone;
	}

	// Free up memory
	[dateFormat release];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == DUE_ISSUES_SECTION) {
		// If the user selects an issue, display the issue details
		IssueDetailsController *issueDetailsController = [[IssueDetailsController alloc] initForIssue:[dueIssues objectAtIndex:indexPath.row]];
		[self.navigationController pushViewController:issueDetailsController animated:YES];
		[issueDetailsController release];
	}
	else if (indexPath.section == RECENT_ISSUES_SECTION) {
		// If the user selects an issue, display the issue details
		IssueDetailsController *issueDetailsController = [[IssueDetailsController alloc] initForIssue:[recentIssues objectAtIndex:indexPath.row]];
		[self.navigationController pushViewController:issueDetailsController animated:YES];
		[issueDetailsController release];
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	// Return the header for the given section
	switch (section) {
		case PROJECT_DETAILS_SECTION:
			return [NSString stringWithFormat:@"Summary"];
		case DUE_ISSUES_SECTION:
			return [NSString stringWithFormat:@"Issues: Due"];
		case RECENT_ISSUES_SECTION:
			return [NSString stringWithFormat:@"Issues: Updated recently"];
		case ISSUES_ASSIGNEE_SECTION:
			return [NSString stringWithFormat:@"Unresolved: By Assignee"];
		case ISSUES_PRIORITY_SECTION:
			return [NSString stringWithFormat:@"Unresolved: By Priority"];
		case STATUS_SUMMARY_SECTION:
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
	// Free any allocated memory
	if(dueIssues){[dueIssues release]; dueIssues = nil;}
	if(recentIssues){[recentIssues release]; recentIssues = nil;}
	if(unresolvedAssignee){[unresolvedAssignee release]; unresolvedAssignee = nil;}
	if(unresolvedPriority){[unresolvedPriority release]; unresolvedPriority = nil;}
	if(statusList){[statusList release]; statusList = nil;}
    [super dealloc];
}

- (void)didReceiveData:(id)result {
	// Handle data from the connector
	
	// Stop the activity indicator
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
	else if (!recentIssues.count){
		// Store recent issues
		if ([result isKindOfClass:[NSArray class]]) {
			[recentIssues release];
			recentIssues = [result retain];
			[self.tableView reloadData];
		}
	}
	else {
		// Cache issues for the project
		if ([result isKindOfClass:[NSArray class]]) {
			[Issue cacheIssues:result ofProject:project];
			[self.tableView reloadData];
			cachedIssues = TRUE;
			[self getStatisticsFromDB];
		}
	}

}

- (void)didFailWithError:(NSError *)error {
	// Stop the activity indicator
	[activityIndicator stopAnimating];
	// Display error to the user
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message: [error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (IBAction)showActionSheet:(id)sender {
	// Show an action sheet with buttons for the user
	UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"View Activity Stream", @"Create Issue", @"View Issues List", nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[popupQuery showInView:self.view];
	[popupQuery release];
}



- (void)didCreateNewIssue:(Issue *)_issue {
	//TODO reload data
}


- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case PROJECT_ACTIVITY_BUTTON:
			// User wants to view activity stream
			[self showProjectActivityScreen];
			break;
		case PROJECT_CREATE_ISSUE:
		{   
			CreateIssueController *createIssueController = [[CreateIssueController alloc] initForIssueInProject: project];
			createIssueController.delegate = self;
			UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createIssueController];
			navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
			[self.navigationController presentModalViewController:navController animated:YES];
			[navController release];
			[createIssueController release];
		}
			break;
		case PROJECT_ISSUES_BUTTON:
			[self showIssuesList];
			break;
		default:
			break;
	}
}
@end
