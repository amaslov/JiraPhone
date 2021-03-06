/*
	AbstractNamedRemoteEntity.h
	The interface definition of properties and methods for the AbstractNamedRemoteEntity object.
	Generated by SudzC.com
*/

#import "Soap.h"
	
#import "AbstractRemoteEntity.h"
@class AbstractRemoteEntity;


@interface AbstractNamedRemoteEntity : AbstractRemoteEntity
{
	NSString* _name;
	
}
		
	@property (retain, nonatomic) NSString* name;

	+ (AbstractNamedRemoteEntity*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
