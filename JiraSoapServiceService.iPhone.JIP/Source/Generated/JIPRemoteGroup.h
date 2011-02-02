/*
	JIPRemoteGroup.h
	The interface definition of properties and methods for the JIPRemoteGroup object.
	Generated by SudzC.com
*/

#import "Soap.h"
	
@class JIPArrayOf_tns1_RemoteUser;
#import "JIPRemoteEntity.h"
@class JIPRemoteEntity;


@interface JIPRemoteGroup : JIPRemoteEntity
{
	NSString* _name;
	JIPArrayOf_tns1_RemoteUser* _users;
	
}
		
	@property (retain, nonatomic) NSString* name;
	@property (retain, nonatomic) JIPArrayOf_tns1_RemoteUser* users;

	+ (JIPRemoteGroup*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
