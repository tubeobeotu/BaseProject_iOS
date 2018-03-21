

#import "GoogleVisionAPIManager.h"
#import "AllCommon.h"


//Constant key
#define BASE_GOOGLE_VISION_API  @"https://vision.googleapis.com/v1/images:annotate?key="
#define GOOGLE_VISION_URL  @"https://vision.googleapis.com/v1/images:annotate?key="
#define API_KEY  @"AIzaSyC4QaQDXfvWnZFjPYhPum3nsSzGHGX6PXQ"
#define MAX_RESULT	15

//Detection Type
static NSString *DETECT_TYPE_LOGO		= @"LOGO_DETECTION";
static NSString *DETECT_TYPE_LABEL		= @"LABEL_DETECTION";
static NSString *DETECT_TYPE_WEB		= @"WEB_DETECTION";
static NSString *DETECT_TYPE_DOCCUMENT	= @"DOCUMENT_TEXT_DETECTION";
static NSString *DETECT_TYPE_TEXT		= @"TEXT_DETECTION";


@implementation GoogleVisionAPIManager

+ (GoogleVisionAPIManager *)shareInstance{
	static GoogleVisionAPIManager *_instance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_instance = [[GoogleVisionAPIManager alloc] init];
	});
	return _instance;
}

#pragma mark - Request API
//Main Function
- (void)requestDetectData:(NSString *)imageData completeHandler:(CompleteHandler)handler{
	NSString *apiURL = [NSString stringWithFormat:@"%@%@", BASE_GOOGLE_VISION_API, API_KEY];
	// Build our API request
	NSDictionary *params =
	@{@"requests":@[
				@{@"image":
					@{@"content":imageData},
				@"features":@[
						@{
							@"maxResults":@MAX_RESULT,
							@"type":DETECT_TYPE_LABEL
						  },
						@{
							@"maxResults":@MAX_RESULT,
							@"type":DETECT_TYPE_WEB
						  },
						@{
							@"maxResults":@MAX_RESULT,
							@"type":DETECT_TYPE_TEXT
							}
						]
				  }
				]
	  };
	//Call request
	[self postRequestWithURL:apiURL params:params completeHandler:^(BOOL success, id result, NSError *error) {
		handler(success, result, error);
	}];
}

#pragma mark - Util Return Params
- (NSDictionary *)paramsForGoogleVisionAPIFromData:(NSString *)imageData withDetectType:(NSArray *)types{
	NSMutableArray *requestArr = @[].mutableCopy;
	NSDictionary *imageDict = @{@"content":imageData};
	NSMutableArray *featureArr = @[].mutableCopy;
	for (NSString *type in types ) {
		NSDictionary *featureDict = @{@"type":type, @"maxResults":@MAX_RESULT};
		[featureArr addObject:featureDict];
	}
	[requestArr addObject:imageDict];
	[requestArr addObject:featureArr];
	return  @{@"requests":requestArr};
}

//Utils
- (NSString *)valueDectionFromVisionType:(VisionDetectedType)type{
	NSString *value;
	switch (type) {
		case VisionDetectedType_Label:
			value = @"LABEL_DETECTION";
			break;
		case VisionDetectedType_Web:
			value = @"WEB_DETECTION";
			break;
		case VisionDetectedType_Doccument:
			value = @"DOCUMENT_TEXT_DETECTION";
			break;
		case VisionDetectedType_Logo:
			value = @"LOGO_DETECTION";
			break;
		default:
			//Default
			value = @"LABEL_DETECTION";
			break;
	}
	return value;
}

@end
