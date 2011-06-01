//
//  IssuesController.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/16/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import "IssuesController.h"
#import "Project.h"
#import "Connector.h"
#import "Issue.h"
#import "Filter.h"
#import "IssueDetailsController.h"
#import "CreateIssueController.h"
#import "JiraPhoneAppDelegate.h"

#define SORT_UPDATED_BUTTON 0
#define SORT_KEY_BUTTON 1
#define SORT_PRIORITY_BUTTON 2
#define CREATE_ISSUE_BUTTON 3

@implementation IssuesController
@synthesize project;
@synthesize filter;
@synthesize jql;

- (id)initForProject:(Project *)_project {
	// Initialize screen for a project
	if (self = [super init]) {
		self.project = _project;
	}
	return self;
}
- (id)initForFilter:(Filter *)_filter {
	// Initialize screen for a filter
	if (self = [super init]) {
		self.filter = _filter;
	}
	return self;
}
- (id)initForJql:(NSString *)_jql {
	// Initialize screen for a jql search
	if (self = [super init]) {
		self.jql = _jql;
	}
	return self;
}


#pragma mark -
#pragma mark View lifecycle

- (void)showCreateIssueScreen {
	// Present the create issues screen to the user
	CreateIssueController *createIssueController = [[CreateIssueController alloc] initForIssueInProject: project];
	createIssueController.delegate = self;
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createIssueController];
	navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	[self.navigationController presentModalViewController:navController animated:YES];
	[navController release];
	[createIssueController release];
}

- (void)viewDidLoad {
    //[super viewDidLoad];
	
	// Set the title of the view
	if (project) {
		self.title = project.name;
	}
	else if (filter) {
		self.title = filter.name;
	}
	else {
		self.title = @"Issues";
	}

	
	// If there are no issues, initialize the array
	if (!issues) {
		issues = [[NSMutableArray alloc] init];
	}
	
	// If we are loading the issue list for a project,
	// get cached issues
	if (project) {
		[Issue getCachedIssues:issues ofProject: project];
	}
	
	// if there's no cached issues show wait spinner
	if (!issues.count) {
		if (!activityIndicator) {
			activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
			activityIndicator.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
			[self.view addSubview:activityIndicator];
			[activityIndicator release];
		}
		[activityIndicator startAnimating];		
	}
	
	// Reload data in the table
	[self.tableView reloadData];
	
	// Sync with server
	Connector *connector = [Connector sharedConnector];
	connector.delegate = self;
	
	if (project) {
		// Get the issues for the current project
		[connector getIssuesOfProject:project];
	}
	else if (filter) {
		// Get the issues returned by the current filter
		[connector getIssuesFromFilter:filter.ID];
	}
	else {
		[connector getIssuesFromJql:jql];
	}
	
	// add + (create issue) button
	UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showActionSheet:)];
	self.navigationItem.rightBarButtonItem = btn;
	[btn release];

}

- (IBAction)showActionSheet:(id)sender {
	// Present sorting options to the user
	UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Sorting Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Sort By Updated Date", @"Sort by Key", @"Sort by Priority", @"Create Issue", nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[popupQuery showInView:self.view];
	[popupQuery release];
}

- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case SORT_UPDATED_BUTTON:
			// User wants to sort by updated date
			[issues sortUsingSelector:@selector(compareUpdatedDate:)];
			[self.tableView reloadData];
			break;
		case SORT_KEY_BUTTON:
			// User wants to sort by issue key
			[issues sortUsingSelector:@selector(compareKey:)];
			[self.tableView reloadData];
			break;
		case SORT_PRIORITY_BUTTON:
			// User wants to sort by priority
			[issues sortUsingSelector:@selector(comparePriority:)];
			[self.tableView reloadData];
			break;
		case CREATE_ISSUE_BUTTON:
			// User wants to create an issue
			[self showCreateIssueScreen];
			break;
		default:
			break;
	}
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return issues.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
	
	// Create a cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}

	
	// Configure the cell...
	
	// Get the issue that will be displayed
	Issue *issue = [issues objectAtIndex:indexPath.row];
	
	// Fill in the cell with details from the issue
	cell.imageView.image = [JiraPhoneAppDelegate getImageByPriority:[NSNumber numberWithInt:issue.priority.number]];
	cell.textLabel.text = [NSString stringWithFormat:@"%@", issue.key];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", issue.summary];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
	// If the user selects an issue, display the issue details
	IssueDetailsController *issueDetailsController = [[IssueDetailsController alloc] initForIssue:[issues objectAtIndex:indexPath.row]];
	[self.navigationController pushViewController:issueDetailsController animated:YES];
	[issueDetailsController release];
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
}


- (void)dealloc {
	// Free up memory
	[Connector sharedConnector].delegate = nil;
	[project release];
	[issues release];
    [super dealloc];
}

#pragma mark -
#pragma mark Connector delegate

- (void)didReceiveData:(id)result {
	// Stop the activity indicator
	[activityIndicator stopAnimating];
	
	// Store issues returned from connector
	if ([result isKindOfClass:[NSArray class]]) {
		for (Issue *issue in result)
		{
			NSLog(@"%@", issue.key);
		}
		if (!filter)
		{
			[Issue cacheIssues:result ofProject: project];
		}
		[issues release];
		issues = [result retain];
		// Reload data in the table
		[self.tableView reloadData];
	}
}

- (void)didFailWithError:(NSError *)error {
	// Stop the activity indicator
	[activityIndicator stopAnimating];
	
	// Display an error to the user
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message: [error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

#pragma mark -
#pragma mark Create Issue delegate

- (void)didCreateNewIssue:(Issue *)_issue {
	// If the user created an issue, add it to the list
	[issues addObject:_issue];
	[self.tableView reloadData];
}
@end

