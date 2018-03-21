
#import "GoogleCustomSearchAPIManager.h"
#import "ImageRecord.h"

static NSString * const kAFGoogleAPIKeyString = @"AIzaSyD-XxfKF4qd7csvJ8MSp1lpF_7VEoUjipY";
static NSString * const kAFGoogleAPIEngineIDString = @"017746813104603240835:zbicboq8iga";

//URL API Custom search
static NSString * const kAFGoogleAPIBaseURLString = @"https://www.googleapis.com/customsearch/v1";

static NSString *KEY_STANDARD_PRODUCT = @"product";
@implementation GoogleCustomSearchAPIManager
//SingleTon
+ (GoogleCustomSearchAPIManager *)shareInstance{
	static GoogleCustomSearchAPIManager *_instance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_instance = [[GoogleCustomSearchAPIManager alloc] init];
	});
	return _instance;
}

- (void)findImagesForQuery:(NSString *)query withOffset:(int)offset ompleteHandler:(CompleteHandler)handler{
	/*
	if (![query.lowercaseString isEqualToString:KEY_STANDARD_PRODUCT]) {
		query = [query stringByAppendingString:[NSString stringWithFormat:@" %@", KEY_STANDARD_PRODUCT]];
	}
	*/
	NSDictionary *params = @{
									@"key": kAFGoogleAPIKeyString,
									@"cx": kAFGoogleAPIEngineIDString,
									@"searchtype": @"image",
									@"fields" : @ "items",
									@"num" : @"10",
									@"start": [@(offset + 1) stringValue],
									@"q": query,
									@"exactTerms":@"product"
									};//@"filter":@1
	[self getRequestWithURL:kAFGoogleAPIBaseURLString params:params completeHandler:^(BOOL success, id result, NSError *error) {
		if ([result objectForKey:@"items"] == [NSNull null]) {
			handler(success, @[], error);
			return;
		}
		
		NSArray *jsonObjects = [result objectForKey:@"items"];
		NSLog(@"Found %lu objects...", (unsigned long)[jsonObjects count]);
		
		NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:jsonObjects.count];
		for (NSDictionary *jsonDict in jsonObjects) {
			ImageRecord *imageRecord = [[ImageRecord alloc] init];
			
			imageRecord.title = [jsonDict objectForKey:@"title"];
			imageRecord.details = [jsonDict objectForKey:@"displayLink"];
			
			imageRecord.thumbnailURL = [(NSArray *)[jsonDict valueForKeyPath:@"pagemap.cse_thumbnail.src"] firstObject];
			imageRecord.thumbnailSize = CGSizeMake([[(NSArray *)[jsonDict valueForKeyPath:@"pagemap.cse_thumbnail.width"] firstObject] floatValue], [[(NSArray *)[jsonDict valueForKeyPath:@"pagemap.cse_thumbnail.height"] firstObject] floatValue]);
			
			imageRecord.imageURL = [NSURL URLWithString:[(NSArray *)[jsonDict valueForKeyPath:@"pagemap.cse_image.src"] firstObject]];
			[imageArray addObject:imageRecord];
		}
		handler(success, imageArray, error);
		//handler(success, result, error);
	}];
}
@end
