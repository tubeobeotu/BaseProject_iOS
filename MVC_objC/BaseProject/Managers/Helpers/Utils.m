
#import "Utils.h"
#import "UIImage+Resize.h"
#import "AllCommon.h"
#import "SVProgressHUD.h"


@implementation Utils
+ (Utils *)shareInstance{
	static Utils *_instance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_instance = [[Utils alloc] init];
		//[SVProgressHUD setBackgroundColor:[UIColor clearColor]];
	});
	return _instance;
}
#pragma mark - Util Image
//Convert Image to Base 64 data
+ (NSString *)base64EncodeImage:(UIImage *)originalImage {
	NSData *imagedata = UIImagePNGRepresentation(originalImage);
	// Resize the image if it exceeds the 2MB API limit
	if ([imagedata length] > 2097152) {
		UIImage *newImage = [UIImage resizeImageByWidth:originalImage scaledToWidth:SCALE_DOWN_SIZE_WIDTH_IMAGE];
		imagedata = UIImagePNGRepresentation(newImage);
	}
	NSString *base64String = [imagedata base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
	return base64String;
}

#pragma mark - SVProgress HUD
- (void)showHUD{
	[SVProgressHUD show];
}
- (void)dissmissHUD{
	[SVProgressHUD dismiss];
}

#pragma mark - Util Float
+ (NSString *)toPercentValueFrom:(float)value{
	if (value < 0) {
		return @"Un value";
	}
	if (value > 1) {
		return @"100%";
	}
	return [NSString stringWithFormat:@"%.2f%@", (value * 100), @"%"];
}
@end
