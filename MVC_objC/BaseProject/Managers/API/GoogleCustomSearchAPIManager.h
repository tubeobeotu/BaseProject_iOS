
#import "BaseAPI.h"

@interface GoogleCustomSearchAPIManager : BaseAPI
+ (GoogleCustomSearchAPIManager *)shareInstance;

#pragma mark - Main API
- (void)findImagesForQuery:(NSString *)query withOffset:(int)offset ompleteHandler:(CompleteHandler)handler;

@end
