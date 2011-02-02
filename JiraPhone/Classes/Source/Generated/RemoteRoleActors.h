/*
	RemoteRoleActors.h
	The interface definition of properties and methods for the RemoteRoleActors object.
	Generated by SudzC.com
*/

#import "Soap.h"
	
@class RemoteProjectRole;
@class ArrayOf_tns1_RemoteRoleActor;
@class ArrayOf_tns1_RemoteUser;

@interface RemoteRoleActors : SoapObject
{
	RemoteProjectRole* _projectRole;
	ArrayOf_tns1_RemoteRoleActor* _roleActors;
	ArrayOf_tns1_RemoteUser* _users;
	
}
		
	@property (retain, nonatomic) RemoteProjectRole* projectRole;
	@property (retain, nonatomic) ArrayOf_tns1_RemoteRoleActor* roleActors;
	@property (retain, nonatomic) ArrayOf_tns1_RemoteUser* users;

	+ (RemoteRoleActors*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
