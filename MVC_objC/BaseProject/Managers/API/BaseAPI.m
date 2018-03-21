
#import "BaseAPI.h"
#import "AFNetworking.h"

//Constant key
static NSString *BASE_URL = @"";
static NSTimeInterval TIME_OUT = 30;

@implementation BaseAPI
/*
+ (BaseAPI *)shareInstance{
	static BaseAPI *_instance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_instance = [[BaseAPI alloc] init];
	});
	return _instance;
}
*/

+ (void)postRequestWithURI:(NSString *)URI params:(NSDictionary *)params completeHandler:(CompleteHandler)completeHandler{
	NSString *apiURL = [NSString stringWithFormat:@"%@/%@", BASE_URL, URI];
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.responseSerializer = [AFJSONResponseSerializer serializer];
	manager.requestSerializer.timeoutInterval = TIME_OUT;
	[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

	[manager POST:apiURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		completeHandler(YES, responseObject, nil);
		} failure:^(NSURLSessionDataTask *operation, NSError *error) {
			completeHandler(NO, nil, error);
	}];
}

+ (void)getRequestWithURI:(NSString *)URI params:(NSDictionary *)params completeHandler:(CompleteHandler)completeHandler{
	NSString *apiURL = [NSString stringWithFormat:@"%@/%@", BASE_URL, URI];
    [BaseAPI getRequestWithInstantURI:apiURL params:params completeHandler:completeHandler];
}
+ (void)getRequestWithInstantURI:(NSString *)URI params:(NSDictionary *)params completeHandler:(CompleteHandler)completeHandler
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = TIME_OUT;
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:URI parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completeHandler(YES, responseObject, nil);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        completeHandler(NO, nil, error);
    }];
}
#pragma mark - Private API
//Private API - Only support full URL: Such as google vision API
- (void)postRequestWithURL:(NSString *)URL params:(NSDictionary *)params completeHandler:(CompleteHandler)completeHandler{
	
	AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	manager.requestSerializer.timeoutInterval = TIME_OUT;
	[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	[manager.requestSerializer setValue:[[NSBundle mainBundle] bundleIdentifier]forHTTPHeaderField:@"X-Ios-Bundle-Identifier"];

	
	[manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		completeHandler(YES, responseObject, nil);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		completeHandler(NO, nil, error);
	}];


}
- (void)getRequestWithURL:(NSString *)URL params:(NSDictionary *)params completeHandler:(CompleteHandler)completeHandler{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.responseSerializer = [AFJSONResponseSerializer serializer];
	manager.requestSerializer.timeoutInterval = TIME_OUT;
	[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	[manager GET:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		completeHandler(YES, responseObject, nil);
	} failure:^(NSURLSessionDataTask *operation, NSError *error) {
		completeHandler(NO, nil, error);
	}];
}


#pragma mark - Request with Progress

- (void)postRequestWithProgressFromURL:(NSString *)url params:(NSDictionary *)params progress:(ProgressHandler)progressHandler completeHandler:(CompleteHandler)completeHandler{
	NSString *apiURL = [NSString stringWithFormat:@"%@/%@", BASE_URL, url];
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.responseSerializer = [AFJSONResponseSerializer serializer];
	manager.requestSerializer.timeoutInterval = TIME_OUT;
	[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	//Call request
	[manager POST:apiURL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
		progressHandler(uploadProgress);
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		completeHandler(YES, responseObject, nil);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		completeHandler(NO, nil, error);
	}];
}

- (void)getRequestWithProgressFromURL:(NSString *)url params:(NSDictionary *)params progress:(ProgressHandler)progressHandler completeHandler:(CompleteHandler)completeHandler{
	NSString *apiURL = [NSString stringWithFormat:@"%@/%@", BASE_URL, url];
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.responseSerializer = [AFJSONResponseSerializer serializer];
	manager.requestSerializer.timeoutInterval = TIME_OUT;
	[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	//Call request
	[manager GET:apiURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
		progressHandler(downloadProgress);
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		completeHandler(YES, responseObject, nil);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		completeHandler(NO, nil, error);
	}];
}

@end
