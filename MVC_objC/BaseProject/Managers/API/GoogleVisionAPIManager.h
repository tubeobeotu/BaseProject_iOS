

#import "BaseAPI.h"

@interface GoogleVisionAPIManager : BaseAPI
+ (GoogleVisionAPIManager *)shareInstance;

//Main API
- (void)requestDetectData:(NSString *)imageData completeHandler:(CompleteHandler)handler;

@end
