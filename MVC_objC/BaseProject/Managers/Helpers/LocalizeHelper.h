

#import <Foundation/Foundation.h>

// Use "LocalizedString(key)" the same way you would use "NSLocalizedString(key,comment)"
#pragma mark - LocalizedString
#define LocalizedString(key) [[LocalizeHelper sharedLocalSystem] localizedStringForKey:(key)]

// "language" can be (for american english): "en", "en-US", "english". Analogous for other languages.
#define LocalizationSetLanguage(language) [[LocalizeHelper sharedLocalSystem] setLanguage:(language)]

@interface LocalizeHelper : NSObject

@property (strong, nonatomic) NSString *currentLanguage;

// a singleton:
+ (LocalizeHelper*) sharedLocalSystem;

// this gets the string localized:
- (NSString*) localizedStringForKey:(NSString*) key;

//set a new language:
- (void) setLanguage:(NSString*) lang;

- (NSString *)currentLanguage;

@end
