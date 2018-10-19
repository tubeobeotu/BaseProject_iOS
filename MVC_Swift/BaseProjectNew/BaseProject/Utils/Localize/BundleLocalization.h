#import <Foundation/Foundation.h>
#import "NSBundle+Localization.h"

@interface BundleLocalization : NSObject

+ (BundleLocalization*) sharedInstance;

// get/set application language
@property (strong, nonatomic) NSString* language;

// get selected localization bundle
@property (weak, readonly) NSBundle* localizationBundle;
@property (strong, nonatomic) NSArray *languages;
- (BOOL)checkCurrentLocalize;
@end
