#import "NSString+DynamicSize.h"
#define maxLengthSubStr 99

@implementation NSString (DynamicSize)

- (float)expectedWidthWithHeight:(float)height font:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode {
    CGSize maximumLabelSize = CGSizeMake(MAXFLOAT, height);
    //+++ This is deprecated
    //CGSize expectedLabelSize = [self sizeWithFont:font constrainedToSize:maximumLabelSize lineBreakMode:lineBreakMode];
    
    CGRect expectedLabelSize = [self boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
    return expectedLabelSize.size.width;
}

- (float)expectedHeightWithWidth:(float)width font:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode {
    CGSize maximumLabelSize = CGSizeMake(width, MAXFLOAT);
    
    //+++ This Deprecate
    //CGSize expectedLabelSize = [self sizeWithFont:font constrainedToSize:maximumLabelSize lineBreakMode:lineBreakMode];

    CGRect expectedLabelSize = [self boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
    
    return expectedLabelSize.size.height;
}

- (NSString*)maximumStr{

    if(self.length > maxLengthSubStr){
        NSRange range;
        range.location = 0;
        range.length = 96;
        
        NSString* subStr = [self substringWithRange:range];
        return [NSString stringWithFormat:@"%@...",subStr];
    }
    return self;
}
@end
