

#import <UIKit/UIKit.h>
typedef struct{
    CGFloat width;
    CGFloat height;
}Scale;
CG_INLINE Scale
ScaleMake(CGFloat width, CGFloat height)
{
    Scale scale;
    scale.width = width;
    scale.height = height;
    return scale;
}
@interface UIImage (CropImage)
+ (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect scale:(Scale)scale;
@end
