//
//  SearchController.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 1/10/11.
//  Copyright 2011 AMaslov. All rights reserved.
//
#import "SearchController.h"
#import "Connector.h"
#import "Issue.h"
#import "IssueDetailsController.h"
#import "JiraPhoneAppDelegate.h"

@implementation SearchController
@synthesize searchCell;
@synthesize project;

#pragma mark -
#pragma mark View lifecycle

- (id)initForProject:(Project *)_project {
	if (self = [super init]) {
		self.project = _project;
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// customize nav bar
	self.title = @"Issue Search";
	UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
	self.navigationItem.leftBarButtonItem = btn;
	[btn release];
	
	Connector *conn = [Connector sharedConnector];
	conn.delegate = self;
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
    return results.count + 1; // +1 for search cell
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
      
    UITableViewCell *cell;
    
	if (indexPath.row == 0) {
		static NSString *SearchCellIdentifier = @"SearchCell";
		SearchCell *sCell = (SearchCell *)[tableView dequeueReusableCellWithIdentifier:SearchCellIdentifier];
		if (sCell == nil) {
			[[NSBundle mainBundle] loadNibNamed:@"SearchCell" owner:self options:nil];
			sCell = searchCell;
		}

		// configure search cell

		cell = sCell;
	}	
	else {
		static NSString *CellIdentifier = @"Cell";
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		}
		
		// configure result cell
		Issue *issue = [results objectAtIndex:indexPath.row - 1];
		cell.textLabel.text = issue.summary;
		cell.detailTextLabel.text = issue.description;
		cell.imageView.image = [JiraPhoneAppDelegate getImageByPriority:[NSNumber numberWithInt:issue.priority.number]];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
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

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// do not select search cell
	if (indexPath.row == 0) {
		return nil;
	}
	return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Issue *issue = [results objectAtIndex:indexPath.row-1];
	IssueDetailsController *issueDetailsController = [[IssueDetailsController alloc] initForIssue:issue];
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
	Connector *conn = [Connector sharedConnector];
	conn.delegate = nil;

	self.searchCell = nil;
	[super viewDidUnload];
}


- (void)dealloc {
	[project release]; 
	[Connector sharedConnector].delegate = nil;
	[searchCell release];
    [super dealloc];
}

#pragma mark -
#pragma mark Actions
- (IBAction)cancelAction {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Connector delegate

- (void)didReceiveData:(id)result {
	[activityIndicator stopAnimating];
	if ([result isKindOfClass:[NSArray class]]) {		
		[results release];
		results = [result retain];
		[self.tableView reloadData];
	}
}

- (void)didFailWithError:(NSError *)error {
	[activityIndicator stopAnimating];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message: [error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

#pragma mark -
#pragma mark UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	// show wait spinner
	if (!activityIndicator) {
		activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		activityIndicator.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
		[self.view addSubview:activityIndicator];
		[activityIndicator release];
	}
	[activityIndicator startAnimating];
	
	UISearchBar *sb = (UISearchBar *)[searchCell viewWithTag:102];
	[sb resignFirstResponder];
	
	// search
	[[Connector sharedConnector] getIssuesOfProject: project fromTextSearch: searchBar.text];
}
@end

