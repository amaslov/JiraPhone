//
//  JiraPhoneAppDelegate.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 11/15/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import "JiraPhoneAppDelegate.h"
#import "LoginController.h"
#import <sqlite3.h>
#import "FMDatabase.h"

#define DATABASE_FILE_NAME	@"jiraCache.sqlite"

@interface JiraPhoneAppDelegate (Private)

+ (void)copyDBFileToDocumentsFolderIfNeeded;

@end


@implementation JiraPhoneAppDelegate

@synthesize window;
@synthesize viewController;

static FMDatabase *SHARED_DB = nil;
+ (FMDatabase *)sharedDB {
	if (!SHARED_DB) {
		[JiraPhoneAppDelegate allocAndOpenDatabase];
	}
	return SHARED_DB;
}

static NSMutableDictionary *priorityImageMap = nil;
+(UIImage *)getImageByPriority:(NSNumber *)_num {
	if (!priorityImageMap) {
		[JiraPhoneAppDelegate initializePriorityImageMap];
	}
	return [priorityImageMap objectForKey:_num];
}

+(void)initializePriorityImageMap {
	priorityImageMap = [[NSMutableDictionary alloc] initWithCapacity:5];
	[priorityImageMap setObject:[UIImage imageNamed:@"priority_blocker.gif"] forKey:[NSNumber numberWithInt:1]];
	[priorityImageMap setObject:[UIImage imageNamed:@"priority_critical.gif"] forKey:[NSNumber numberWithInt:2]];
	[priorityImageMap setObject:[UIImage imageNamed:@"priority_major.gif"] forKey:[NSNumber numberWithInt:3]];
	[priorityImageMap setObject:[UIImage imageNamed:@"priority_minor.gif"] forKey:[NSNumber numberWithInt:4]];
	[priorityImageMap setObject:[UIImage imageNamed:@"priority_trivial.gif"] forKey:[NSNumber numberWithInt:5]];
}

static NSMutableDictionary *priorityStringMap = nil;
+(NSString *)getStringByPriority:(NSNumber *)_num {
	if (!priorityStringMap) {
		[JiraPhoneAppDelegate initializePriorityStringMap];
	}
	return [priorityStringMap objectForKey:_num];
}

+(void)initializePriorityStringMap {
	priorityStringMap = [[NSMutableDictionary alloc] initWithCapacity:5];
	[priorityStringMap setObject:[NSString stringWithFormat:@"Blocker"] forKey:[NSNumber numberWithInt:1]];
	[priorityStringMap setObject:[NSString stringWithFormat:@"Critical"] forKey:[NSNumber numberWithInt:2]];
	[priorityStringMap setObject:[NSString stringWithFormat:@"Major"] forKey:[NSNumber numberWithInt:3]];
	[priorityStringMap setObject:[NSString stringWithFormat:@"Minor"] forKey:[NSNumber numberWithInt:4]];
	[priorityStringMap setObject:[NSString stringWithFormat:@"Trivial"] forKey:[NSNumber numberWithInt:5]];
}

static NSMutableDictionary *statusStringMap = nil;
+(NSString *)getStringByStatus:(NSNumber *)_num {
	if (!statusStringMap) {
		[JiraPhoneAppDelegate initializeStatusStringMap];
	}
	return [statusStringMap objectForKey:_num];
}

+(void)initializeStatusStringMap {
	statusStringMap = [[NSMutableDictionary alloc] initWithCapacity:6];
	[statusStringMap setObject:[NSString stringWithFormat:@"Open"] forKey:[NSNumber numberWithInt:1]];
	[statusStringMap setObject:[NSString stringWithFormat:@"In Progress"] forKey:[NSNumber numberWithInt:3]];
	[statusStringMap setObject:[NSString stringWithFormat:@"Reopened"] forKey:[NSNumber numberWithInt:4]];
	[statusStringMap setObject:[NSString stringWithFormat:@"Resolved"] forKey:[NSNumber numberWithInt:5]];
	[statusStringMap setObject:[NSString stringWithFormat:@"Closed"] forKey:[NSNumber numberWithInt:6]];
}

static NSMutableDictionary *statusImageMap = nil;
+(UIImage *)getImageByStatus:(NSNumber *)_num {
	if (!statusImageMap)
	{
		[JiraPhoneAppDelegate initializeStatusImageMap];
	}
	return [statusImageMap objectForKey:_num];
}

+(void) initializeStatusImageMap {
	statusImageMap = [[NSMutableDictionary alloc] initWithCapacity:6];
	[statusImageMap setObject:[UIImage imageNamed:@"status_open.gif"] forKey:[NSNumber numberWithInt:1]];
	[statusImageMap setObject:[UIImage imageNamed:@"status_inprogress.gif"] forKey:[NSNumber numberWithInt:3]];
	[statusImageMap setObject:[UIImage imageNamed:@"status_resolved.gif"] forKey:[NSNumber numberWithInt:5]];
	[statusImageMap setObject:[UIImage imageNamed:@"status_closed.gif"] forKey:[NSNumber numberWithInt:6]];
}
#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

    // Add the view controller's view to the window and display.
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [viewController release];
	[SHARED_DB release];
    [window release];
    [super dealloc];
}

#pragma mark -
#pragma mark Database
+ (void)allocAndOpenDatabase
{
	if (SHARED_DB)
	{
		NSLog(@"!!! there is already allocated db!");
		return;
	}
	
	[JiraPhoneAppDelegate copyDBFileToDocumentsFolderIfNeeded];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsFolder = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsFolder stringByAppendingPathComponent:DATABASE_FILE_NAME];
	
	
	SHARED_DB = [[FMDatabase databaseWithPath:writableDBPath] retain];	// allocating
	if (![SHARED_DB open])
		NSLog(@"Failed to open db.\n");
}

#pragma mark -
#pragma mark Private
+ (void)copyDBFileToDocumentsFolderIfNeeded
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsFolder = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsFolder stringByAppendingPathComponent:DATABASE_FILE_NAME];
	BOOL success;
	success = [fileManager fileExistsAtPath:writableDBPath];
	if (!success) 
	{
		NSError *error;
		NSString *defaultDBFilePath = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:DATABASE_FILE_NAME];
		success = [fileManager copyItemAtPath:defaultDBFilePath toPath:writableDBPath error:&error];
		if (!success)
			NSLog(@"Failed to copy db file into documents folder.\n");
	}
}


@end
