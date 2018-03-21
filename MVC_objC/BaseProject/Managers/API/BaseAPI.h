

#import <Foundation/Foundation.h>

typedef void (^CompleteHandler)(BOOL success, id result, NSError *error);
typedef void (^ProgressHandler)(NSProgress *progress);

@interface BaseAPI : NSObject{
	
}
//+ (BaseAPI *)shareInstance;

#pragma mark - API perform request from server
//MAIN API
+ (void)getRequestWithURI:(NSString *)URI params:(NSDictionary *)params completeHandler:(CompleteHandler)completeHandler;

+ (void)postRequestWithURI:(NSString *)URI params:(NSDictionary *)params completeHandler:(CompleteHandler)completeHandler;

+ (void)getRequestWithInstantURI:(NSString *)URI params:(NSDictionary *)params completeHandler:(CompleteHandler)completeHandler;
#pragma mark - Private API
//Private API - Only support full URL: Such as google vision API
- (void)postRequestWithURL:(NSString *)URL params:(NSDictionary *)params completeHandler:(CompleteHandler)completeHandler;
- (void)getRequestWithURL:(NSString *)URL params:(NSDictionary *)params completeHandler:(CompleteHandler)completeHandler;

@end
