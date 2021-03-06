/*
	RemoteServerInfo.h
	The interface definition of properties and methods for the RemoteServerInfo object.
	Generated by SudzC.com
*/

#import "Soap.h"
	
@class RemoteTimeInfo;

@interface RemoteServerInfo : SoapObject
{
	NSString* _baseUrl;
	NSDate* _buildDate;
	NSString* _buildNumber;
	NSString* _edition;
	RemoteTimeInfo* _serverTime;
	NSString* _version;
	
}
		
	@property (retain, nonatomic) NSString* baseUrl;
	@property (retain, nonatomic) NSDate* buildDate;
	@property (retain, nonatomic) NSString* buildNumber;
	@property (retain, nonatomic) NSString* edition;
	@property (retain, nonatomic) RemoteTimeInfo* serverTime;
	@property (retain, nonatomic) NSString* version;

	+ (RemoteServerInfo*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
