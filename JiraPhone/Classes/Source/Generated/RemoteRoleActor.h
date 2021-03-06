/*
	RemoteRoleActor.h
	The interface definition of properties and methods for the RemoteRoleActor object.
	Generated by SudzC.com
*/

#import "Soap.h"
	
@class RemoteProjectRole;
@class ArrayOf_tns1_RemoteUser;

@interface RemoteRoleActor : SoapObject
{
	NSString* _descriptor;
	NSString* _parameter;
	RemoteProjectRole* _projectRole;
	NSString* _type;
	ArrayOf_tns1_RemoteUser* _users;
	
}
		
	@property (retain, nonatomic) NSString* descriptor;
	@property (retain, nonatomic) NSString* parameter;
	@property (retain, nonatomic) RemoteProjectRole* projectRole;
	@property (retain, nonatomic) NSString* type;
	@property (retain, nonatomic) ArrayOf_tns1_RemoteUser* users;

	+ (RemoteRoleActor*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
