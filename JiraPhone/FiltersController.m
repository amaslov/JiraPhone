//
//  FiltersController.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 3/25/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "FiltersController.h"
#import "Connector.h"
#import "Issue.h"


@implementation FiltersController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return filters.count + 1; // +1 for search cell
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)didReceiveData:(id)result {
	[activityIndicator stopAnimating];
	// Store the filters retrieved from the server
	if ([result isKindOfClass:[NSArray class]]) {		
		[filters release];
		filters = [result retain];
		// Reload the data in the table
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

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Initialize the filter list
	if (!filters) {
		filters = [[NSMutableArray alloc] init];
	}
	
	// Get filters from the database
	[Filter getCachedFilters:filters];
	
	// If there are no cached filters, show the activity indicator
	if (!filters.count) {
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
	
	// Sync with the server
	Connector *connector = [Connector sharedConnector];
	connector.delegate = self;
	
	// Get filters from the server
	[connector getFavouriteFilters];
	
	// Reload data in the table
	[self.tableView reloadData];
}


- (void)viewDidUnload {
	Connector *conn = [Connector sharedConnector];
	conn.delegate = nil;
	[super viewDidUnload];
}


- (void)dealloc {
	[Connector sharedConnector].delegate = nil;
    [super dealloc];
}

@end
