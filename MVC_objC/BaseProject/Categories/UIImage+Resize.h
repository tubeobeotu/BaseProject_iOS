


#import <UIKit/UIKit.h>

@interface UIImage (Resize)
+ (UIImage*)resizeImageByHeight:(UIImage*) sourceImage scaledHeight:(float) i_height;
+ (UIImage*)resizeImageByWidth: (UIImage*) sourceImage scaledToWidth: (float) i_width;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
@end
