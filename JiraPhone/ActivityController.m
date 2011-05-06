//
//  ProjectActivityController.m
//  JiraPhone
//
//  Created by Matthew Gerrior on 3/19/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "ActivityController.h"
#import "Project.h"
#import "User.h"

#define CONST_textLabelFontSize 17
#define CONST_detailLabelFontSize 15

static UIFont *titleFont;
static UIFont *summaryFont;

@implementation ActivityController

@synthesize project;

- (id)initForProject:(Project *)_project {
	// Initialize the screen for the given project
	if (self = [super initWithStyle:UITableViewStylePlain]) {
		self.project = _project;
	}
	return self;
}


#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	// If we have no items to display...
	if ([entries count] == 0) {
		// Get the server that the user is logged into
		NSString *server = [[User loggedInUser].server stringByReplacingOccurrencesOfString:@"http://" withString:@""];
		// Construct the path
		NSString *path;
		if (project) {
			path = [NSString stringWithFormat:@"http://%@:%@@%@/plugins/servlet/streams?key=JIRAPP&os_authType=basic",[User loggedInUser].name, [User loggedInUser].password, server];
		}
		else {
			path = [NSString stringWithFormat:@"http://%@:%@@%@/plugins/servlet/streams?os_authType=basic",[User loggedInUser].name, [User loggedInUser].password, server];
		}
		// Parse the activity stream
		[self parseXMLFileAtURL:path];
	}
}

- (void)parseXMLFileAtURL:(NSString *)URL {
	// Initialize the items array
	entries = [[NSMutableArray alloc] init];
	// Create a URL object
	NSURL *xmlURL = [NSURL URLWithString:URL];
	// Create an rssParser and set appropriate settings
	rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	[rssParser setDelegate:self];
	[rssParser setShouldProcessNamespaces:NO];
	[rssParser setShouldReportNamespacePrefixes:NO];
	[rssParser setShouldResolveExternalEntities:NO];
	// Parse the XML file
	[rssParser parse];	
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	// Display the loading indicator
	if (!activityIndicator) {
		activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		activityIndicator.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
		[self.view addSubview:activityIndicator];
		[activityIndicator release];
	}
	[activityIndicator startAnimating];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	currentElement = [elementName copy];
	// If we find an entry, initialize the
	// information.
	if ([elementName isEqualToString:@"entry"]) {
		item = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		currentSummary = [[NSMutableString alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	// Display an error if there is a problem parsing
	// the activity stream.
	[activityIndicator stopAnimating];
	UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:@"ERROR!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
	[errorAlert release];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	// When we finish an element, store the details
	if ([elementName isEqualToString:@"entry"]) {
		[item setObject:currentTitle forKey:@"title"];
		[item setObject:currentSummary forKey:@"summary"];
		[entries addObject:[item copy]];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	// Build the title and summary for the
	// given entry
	if ([currentElement isEqualToString:@"title"]) {
		[currentTitle appendString:string];
	}
	else if ([currentElement isEqualToString:@"summary"]) {
		[currentSummary appendString:string];
	}
}

-(void)parserDidEndDocument:(NSXMLParser *)parser {
	// Reload the tableview and stop the
	// activity indicator
	[self.tableView reloadData];
	[activityIndicator stopAnimating];
}

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
    return [entries count];
}

- (NSString *)flattenHTML:(NSString *)html
{
	NSScanner *theScanner;
	NSString *text = nil;
	
	// Remove html from the input string
	theScanner = [NSScanner scannerWithString:html];
	while ([theScanner isAtEnd] == NO) {
		[theScanner scanUpToString:@"<" intoString:nil];
		[theScanner scanUpToString:@">" intoString:&text];
		html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
	}
	return html;
}

- (NSString *)replaceEscapes:(NSString *)_text {
	// Convert escape characters to human readable format
	_text = [_text stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
	_text = [_text stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
	_text = [_text stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
	_text = [_text stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
	_text = [_text stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
	return _text;
}

- (UIFont *)TitleFont {
	// Return the font for titles
	if (!titleFont) titleFont = [UIFont boldSystemFontOfSize:17];
	return titleFont;
}

- (UIFont *)SummaryFont {
	// Return the font for summaries
	if (!summaryFont) summaryFont = [UIFont systemFontOfSize:15];
	return summaryFont;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		
		// Set the details of the cell
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.font = [self TitleFont];
		cell.detailTextLabel.numberOfLines = 0;
		cell.detailTextLabel.font = [self SummaryFont];
    }
	
	// Get the title and summary of the current cell
	NSString *titleText = [[entries objectAtIndex:indexPath.row] objectForKey:@"title"];
	NSString *summaryText = [[entries objectAtIndex:indexPath.row] objectForKey:@"summary"];
	
	// If the title and summary are different
	if (![titleText isEqualToString:summaryText])
	{
		// Remove html from the text
		titleText = [self flattenHTML:titleText];
		summaryText = [self flattenHTML:summaryText];
		
		// Replace escape characters		
		titleText = [self replaceEscapes:titleText];
		summaryText = [self replaceEscapes:summaryText];
		
		// Fill in the cell
		cell.textLabel.text = titleText;
		cell.detailTextLabel.text = summaryText;
		cell.imageView.image = nil;
		cell.accessoryType = UITableViewCellAccessoryNone;
		
		return cell;
	}
	
	// Tidy up the title string
	titleText = [self flattenHTML:titleText];
	titleText = [self replaceEscapes:titleText];
	
	// Fill in the cell
	cell.textLabel.text = titleText;
	cell.detailTextLabel.text = nil;
	cell.imageView.image = nil;
	cell.accessoryType = UITableViewCellAccessoryNone;
    
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
	//selectedCellIndexPath = indexPath;
	//[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (int)heightOfCellWithTitle:(NSString *)titleText andSummary:(NSString *)summaryText {
	CGSize titleSize = {0, 0};
	CGSize summarySize = {0, 0};
	
	// Get the size needed to display the title
	if (titleText && ![titleText isEqualToString:@""]) {
		titleSize = [titleText sizeWithFont:[self TitleFont] constrainedToSize:CGSizeMake(270.0f, 4000) lineBreakMode:UILineBreakModeWordWrap];
	}
	// Get the size needed to display the summary
	if (summaryText && ![summaryText isEqualToString:@""] && ![summaryText isEqualToString:titleText]) {
		summarySize = [summaryText sizeWithFont:[self SummaryFont] constrainedToSize:CGSizeMake(270.0f, 4000) lineBreakMode:UILineBreakModeWordWrap];
	}
	return titleSize.height + summarySize.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	// Get the title and summary of the entry, and return
	// the height required to display them.
	NSString *titleText = [self flattenHTML:[[entries objectAtIndex:indexPath.row] objectForKey:@"title"]];
	NSString *summaryText = [self flattenHTML:[[entries objectAtIndex:indexPath.row] objectForKey:@"summary"]];
	int height = [self heightOfCellWithTitle:titleText andSummary:summaryText];
	return (height < 44 ? 44.0f : height);
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
	[currentElement release];
	[rssParser release];
	[entries release];
	[item release];
	[currentTitle release];
	[currentSummary release];
    [super dealloc];
}


@end

