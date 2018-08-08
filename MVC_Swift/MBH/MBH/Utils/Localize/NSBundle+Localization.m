#import "NSBundle+Localization.h"
#import <objc/runtime.h>
#import "BundleLocalization.h"

@implementation NSBundle (Localization)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        SEL originalSelector = @selector(localizedStringForKey:value:table:);
        SEL swizzledSelector = @selector(customLocaLizedStringForKey:value:table:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling

-(NSString*) customLocaLizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
{
    if(([NSBundle mainBundle] == self && ![tableName isEqualToString:@"QBImagePicker"]) || ([key isEqualToString:@"Cancel"]) || ([key isEqualToString:@"Done"]) || ([tableName isEqualToString:@"CameraUI"]) || ([key isEqualToString:@"RETAKE"]) || ([key isEqualToString:@"API_CANCEL_TITLE"]) || ([key isEqualToString:@"USE_PHOTO"]) || [tableName isEqualToString:@"PhotoLibraryServices"] || ([key isEqualToString:@"My Location"]))
    {

        if([key isEqualToString:@"My Location"])
        {
            key = @"key_my_location";
        }
        if([key isEqualToString:@"API_CANCEL_TITLE"])
        {
            key = @"cancel";
        }

        if([key isEqualToString:@"USE_PHOTO"])
        {
            key = @"USE PHOTO";
        }

        if([[BundleLocalization sharedInstance] checkCurrentLocalize])
        {
            if(([key isEqualToString:@"Cancel"]) || ([key isEqualToString:@"Done"]) || ([key isEqualToString:@"Done"]) || ([tableName isEqualToString:@"CameraUI"]) || ([tableName isEqualToString:@"PhotoLibrary"] || ([tableName isEqualToString:@"PhotoLibraryServices"])))
            {
                tableName = @"";
            }
            NSBundle* bundle = [BundleLocalization sharedInstance].localizationBundle;
            return [bundle customLocaLizedStringForKey:key value:value table:tableName];
        }
    }
    return [self customLocaLizedStringForKey:key value:value table:tableName];
}

@end

