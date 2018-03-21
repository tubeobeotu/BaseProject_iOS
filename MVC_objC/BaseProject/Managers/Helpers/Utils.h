

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject
+ (Utils *)shareInstance;

//Util Images
+ (NSString *)base64EncodeImage:(UIImage *)originalImage ;

#pragma mark - SVProgress HUD
- (void)showHUD;
- (void)dissmissHUD;

#pragma mark - Util Float 
+ (NSString *)toPercentValueFrom:(float)value;

@end
