//
//  ProjectActivityController.m
//  JiraPhone
//
//  Created by Matthew Gerrior on 3/19/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "ProjectActivityController.h"
#import "Project.h"
#import "User.h"

#define CONST_textLabelFontSize 17
#define CONST_detailLabelFontSize 15

static UIFont *titleFont;
static UIFont *summaryFont;

@implementation ProjectActivityController

@synthesize project;

- (id)initForProject:(Project *)_project {
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
	if ([entries count] == 0) {
		NSString *server = [[User loggedInUser].server stringByReplacingOccurrencesOfString:@"http://" withString:@""];
		NSString *path = [NSString stringWithFormat:@"http://%@:%@@%@/plugins/servlet/streams?key=JIRAPP&os_authType=basic",[User loggedInUser].name, [User loggedInUser].password, server];
		//NSString *path = [NSString stringWithFormat:@"http://matty:codejazz@98.219.42.123:5005/plugins/servlet/streams?key=JIRAPP&os_authType=basic"];
		NSLog(@"Path is: %@",path);
		[self parseXMLFileAtURL:path];
	}
}

- (void)parseXMLFileAtURL:(NSString *)URL {
	entries = [[NSMutableArray alloc] init];
	NSURL *xmlURL = [NSURL URLWithString:URL];
	rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	[rssParser setDelegate:self];
	[rssParser setShouldProcessNamespaces:NO];
	[rssParser setShouldReportNamespacePrefixes:NO];
	[rssParser setShouldResolveExternalEntities:NO];
	[rssParser parse];	
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
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
	if ([elementName isEqualToString:@"entry"]) {
		item = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		currentSummary = [[NSMutableString alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	[activityIndicator stopAnimating];
	UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:@"ERROR!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
	[errorAlert release];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"entry"]) {
		[item setObject:currentTitle forKey:@"title"];
		[item setObject:currentSummary forKey:@"summary"];
		[entries addObject:[item copy]];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if ([currentElement isEqualToString:@"title"]) {
		[currentTitle appendString:string];
	}
	else if ([currentElement isEqualToString:@"summary"]) {
		[currentSummary appendString:string];
	}
}

-(void)parserDidEndDocument:(NSXMLParser *)parser {
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
	
	theScanner = [NSScanner scannerWithString:html];
	while ([theScanner isAtEnd] == NO) {
		[theScanner scanUpToString:@"<" intoString:nil];
		[theScanner scanUpToString:@">" intoString:&text];
		html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
	}
	return html;
}

- (UIFont *)TitleFont {
	if (!titleFont) titleFont = [UIFont boldSystemFontOfSize:17];
	return titleFont;
}

- (UIFont *)SummaryFont {
	if (!summaryFont) summaryFont = [UIFont systemFontOfSize:15];
	return summaryFont;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.font = [self TitleFont];
		
		cell.detailTextLabel.numberOfLines = 0;
		cell.detailTextLabel.font = [self SummaryFont];
    }
	cell.textLabel.text = [self flattenHTML:[[entries objectAtIndex:indexPath.row] objectForKey:@"title"]];
	cell.detailTextLabel.text = [self flattenHTML:[[entries objectAtIndex:indexPath.row] objectForKey:@"summary"]];
    // Configure the cell...
    
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
	
	if (titleText && ![titleText isEqualToString:@""]) {
		titleSize = [titleText sizeWithFont:[self TitleFont] constrainedToSize:CGSizeMake(270.0f, 4000) lineBreakMode:UILineBreakModeWordWrap];
	}
	if (summaryText && ![summaryText isEqualToString:@""]) {
		summarySize = [summaryText sizeWithFont:[self SummaryFont] constrainedToSize:CGSizeMake(270.0f, 4000) lineBreakMode:UILineBreakModeWordWrap];
	}
	return titleSize.height + summarySize.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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

