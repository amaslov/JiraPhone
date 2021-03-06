/*
	JIPRemoteProject.h
	The interface definition of properties and methods for the JIPRemoteProject object.
	Generated by SudzC.com
*/

#import "Soap.h"
	
@class JIPRemoteScheme;
@class JIPRemoteScheme;
@class JIPRemotePermissionScheme;
#import "JIPAbstractNamedRemoteEntity.h"
@class JIPAbstractNamedRemoteEntity;


@interface JIPRemoteProject : JIPAbstractNamedRemoteEntity
{
	NSString* _description;
	JIPRemoteScheme* _issueSecurityScheme;
	NSString* _key;
	NSString* _lead;
	JIPRemoteScheme* _notificationScheme;
	JIPRemotePermissionScheme* _permissionScheme;
	NSString* _projectUrl;
	NSString* _url;
	
}
		
	@property (retain, nonatomic) NSString* description;
	@property (retain, nonatomic) JIPRemoteScheme* issueSecurityScheme;
	@property (retain, nonatomic) NSString* key;
	@property (retain, nonatomic) NSString* lead;
	@property (retain, nonatomic) JIPRemoteScheme* notificationScheme;
	@property (retain, nonatomic) JIPRemotePermissionScheme* permissionScheme;
	@property (retain, nonatomic) NSString* projectUrl;
	@property (retain, nonatomic) NSString* url;

	+ (JIPRemoteProject*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
