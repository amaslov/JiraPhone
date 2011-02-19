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
#import "IssueDetailsController.h"
#import "CreateIssueController.h"

@implementation IssuesController
@synthesize project;

- (id)initForProject:(Project *)_project {
	if (self = [super init]) {
		self.project = _project;
	}
	return self;
}


#pragma mark -
#pragma mark View lifecycle

- (void)showCreateIssueScreen {
	CreateIssueController *createIssueController = [[CreateIssueController alloc] initForIssueInProject: project];
	createIssueController.delegate = self;
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createIssueController];
	navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	[self.navigationController presentModalViewController:navController animated:YES];
	[navController release];
	[createIssueController release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = project.name;
	
	// get list of cashed projects
	if (!issues) {
		issues = [[NSMutableArray alloc] init];
	}
	[Issue getCachedIssues:issues ofProject: project];
	
	// if there's no cashed issues show wait spinner
	if (!issues.count) {
		if (!activityIndicator) {
			activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
			activityIndicator.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
			[self.view addSubview:activityIndicator];
			[activityIndicator release];
		}
		[activityIndicator startAnimating];		
	}
	
	[self.tableView reloadData];
	
	// sync with server for list of issues for given project
	Connector *connector = [Connector sharedConnector];
	connector.delegate = self;
	[connector getIssuesOfProject:project];	
	
	// add + (create issue) button
	UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showActionSheet:)];
	self.navigationItem.rightBarButtonItem = btn;
	[btn release];
	
	//[issues sortUsingSelector:@selector(compareCreationDate:)];
	//[self.tableView reloadData];
}

- (IBAction)showActionSheet:(id)sender {
	UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Sorting Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Sort By Updated Date", @"Sort by Key", @"Sort by Priority", nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[popupQuery showInView:self.view];
	[popupQuery release];
}

- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 0:
			[self sortIssuesByDate];
			break;
		case 1:
			[self sortIssuesByKey];
			break;
		case 2:
			[self sortIssuesByPriority];
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

- (void)sortIssuesByDate {
	[issues sortUsingSelector:@selector(compareUpdatedDate:)];
	[self.tableView reloadData];
}

- (void)sortIssuesByKey {
	[issues sortUsingSelector:@selector(compareKey:)];
	[self.tableView reloadData];
}

- (void)sortIssuesByPriority {
	[issues sortUsingSelector:@selector(comparePriority:)];
	[self.tableView reloadData];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	Issue *issue = [issues objectAtIndex:indexPath.row];
    cell.textLabel.text = issue.key;
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
	[Connector sharedConnector].delegate = nil;
	[project release];
	[issues release];
    [super dealloc];
}

#pragma mark -
#pragma mark Connector delegate

- (void)didReceiveData:(id)result {
	[activityIndicator stopAnimating];
	if ([result isKindOfClass:[NSArray class]]) {
		[Issue cacheIssues:result ofProject: project];
		
		[issues release];
		issues = [result retain];
		[self.tableView reloadData];
	}
}

- (void)didFailWithError:(NSError *)error {
	[activityIndicator stopAnimating];
}

#pragma mark -
#pragma mark Create Issue delegate

- (void)didCreateNewIssue:(Issue *)_issue {
	[issues addObject:_issue];
	[self.tableView reloadData];
}
@end

