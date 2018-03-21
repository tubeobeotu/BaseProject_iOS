
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (DynamicSize)
- (float)expectedWidthWithHeight:(float)height font:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (float)expectedHeightWithWidth:(float)width font:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (NSString*)maximumStr;
@end
