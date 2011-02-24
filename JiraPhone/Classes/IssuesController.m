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
@synthesize tableView;
@synthesize imageView;

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
    //[super viewDidLoad];
	self.title = project.name;
	
	//
	// Change the properties of the imageView and tableView
	//
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	tableView.rowHeight = 100;
	tableView.backgroundColor = [UIColor clearColor];
	imageView.image = [UIImage imageNamed:@"background.png"];
	
	//
	// Create a header view. Wrap it in a container.
	//
	
	UIView *containerView = [[[UIView alloc] initWithFrame:CGRectMake(0,0,300,60)] autorelease];
	UILabel *headerLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10,20,300,40)] autorelease];
	headerLabel.text = NSLocalizedString(@"Header for the table", @"");
	headerLabel.textColor = [UIColor whiteColor];
	headerLabel.shadowColor = [UIColor blackColor];
	headerLabel.shadowOffset = CGSizeMake(0,1);
	headerLabel.font = [UIFont boldSystemFontOfSize:22];
	headerLabel.backgroundColor = [UIColor clearColor];
	[containerView addSubview:headerLabel];
	self.tableView.tableHeaderView = containerView;
	
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
			// User wants to sort by updated date
			[issues sortUsingSelector:@selector(compareUpdatedDate:)];
			[self.tableView reloadData];
			break;
		case 1:
			// User wants to sort by issue key
			[issues sortUsingSelector:@selector(compareKey:)];
			[self.tableView reloadData];
			break;
		case 2:
			// User wants to sort by priority
			[issues sortUsingSelector:@selector(comparePriority:)];
			[self.tableView reloadData];
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
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	const NSInteger TOP_LABEL_TAG = 1001;
	const NSInteger BOTTOM_LABEL_TAG = 1002;
	const CGFloat LABEL_HEIGHT = 20;
	UILabel *topLabel;
	UILabel *bottomLabel;
	
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		//cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		UIImage *image = [UIImage imageNamed:@"priority_major.gif"];
		
		//
		// Create the label for the top row of text
		//
		topLabel = [[[UILabel alloc] initWithFrame:CGRectMake(image.size.width + 2.0 * cell.indentationWidth,
															  0.5 * (aTableView.rowHeight - 2 * LABEL_HEIGHT),
															  aTableView.bounds.size.width - image.size.width - 4.0*
															  cell.indentationWidth - 16,
															  LABEL_HEIGHT)] autorelease];
		[cell.contentView addSubview:topLabel];
		
		//
		// Configure the properties for the text that are the same on every row
		//
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
		
		//
		// Create the label for the bottom row of text
		//
		bottomLabel = [[[UILabel alloc] initWithFrame:CGRectMake(image.size.width + 2.0*cell.indentationWidth,
																 0.5 * (aTableView.rowHeight - 2 * LABEL_HEIGHT) + LABEL_HEIGHT,
																 aTableView.bounds.size.width - image.size.width - 4.0*cell.indentationWidth
																 - 16, LABEL_HEIGHT)] autorelease];
		[cell.contentView addSubview:bottomLabel];
		bottomLabel.tag = BOTTOM_LABEL_TAG;
		bottomLabel.backgroundColor = [UIColor clearColor];
		bottomLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
		bottomLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		bottomLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
		
		//
		// Create a background image view
		//
		cell.backgroundView = [[[UIImageView alloc] init] autorelease];
    }
	else {
		topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
		bottomLabel = (UILabel *)[cell viewWithTag:BOTTOM_LABEL_TAG];
	}

	
	// Configure the cell...
	Issue *issue = [issues objectAtIndex:indexPath.row];
    //cell.textLabel.text = issue.key;
	topLabel.text = [NSString stringWithFormat:@"Cell at row %ld", [indexPath row]];
	bottomLabel.text = [NSString stringWithFormat:@"Some other stuff.", [indexPath row]];
	
	UIImage *rowBackground;
	rowBackground = [UIImage imageNamed:@"rowBackground.png"];
	((UIImageView *)cell.backgroundView).image = rowBackground;
	//cell.text = issue.key;
	cell.image = [UIImage imageNamed:@"priority_major.gif"];
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
	[tableView release];
	[imageView release];
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

