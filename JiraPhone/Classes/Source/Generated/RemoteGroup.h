/*
	RemoteGroup.h
	The interface definition of properties and methods for the RemoteGroup object.
	Generated by SudzC.com
*/

#import "Soap.h"
	
@class ArrayOf_tns1_RemoteUser;
#import "RemoteEntity.h"
@class RemoteEntity;


@interface RemoteGroup : RemoteEntity
{
	NSString* _name;
	ArrayOf_tns1_RemoteUser* _users;
	
}
		
	@property (retain, nonatomic) NSString* name;
	@property (retain, nonatomic) ArrayOf_tns1_RemoteUser* users;

	+ (RemoteGroup*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
