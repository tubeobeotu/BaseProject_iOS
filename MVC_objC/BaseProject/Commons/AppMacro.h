
#import <Foundation/Foundation.h>
#ifndef AppMacro_h
#define AppMacro_h


#endif /* AppMacro_h */


#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \


#ifndef PPMacros_h
#define PPMacros_h

#define iOS8AndLater SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
#define iOS9AndLater SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")
#define iOS10AndLater SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")

#define AppDelegateAccessor ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define NEW_VC_FROM_NIB(Class, identifier) [[Class alloc] initWithNibName:identifier bundle:nil]
#define NEW_VC_FROM_STORYBOARD(storyboard, identifier) [[UIStoryboard storyboardWithName:storyboard bundle:nil] instantiateViewControllerWithIdentifier : identifier]
#define NEW_VC_WITH_IDENTIFIER(identifier) [[UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"] bundle:nil] instantiateViewControllerWithIdentifier : identifier]
#define AppendString(stringA, stringB) [NSString stringWithFormat:@"%@ %@", stringA, stringB]

#pragma - mark DEVICE INFORMATION

/** BOOL: Check iPhone type **/
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)736) < DBL_EPSILON)



/** String: Identifier **/
#define DEVICE_IDENTIFIER ((IS_IPAD) ? DEVICE_IPAD : (IS_IPHONE) ? DEVICE_IPHONE, DEVICE_SIMULATOR)

/** String: iPhone **/
#define DEVICE_IPHONE @"iPhone"

/** String: iPad **/
#define DEVICE_IPAD @"iPad"

/** String: Device Model **/
#define DEVICE_MODEL ([[UIDevice currentDevice] model])

/** String: Localized Device Model **/
#define DEVICE_MODEL_LOCALIZED ([[UIDevice currentDevice] localizedModel])

/** String: Device Name **/
#define DEVICE_NAME ([[UIDevice currentDevice] name])

/** Double: Device Orientation **/
#define DEVICE_ORIENTATION ([[UIDevice currentDevice] orientation])

/** String: Simulator **/
#define DEVICE_SIMULATOR @"Simulator"

/** String: Device Type **/
#define DEVICE_TYPE ([[UIDevice currentDevice] deviceType])

/** BOOL: Detect if device is an iPad **/
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** BOOL: Detect if device is an iPhone or iPod **/
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/** BOOL: IS_RETINA **/
#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)

/** BOOL: Detect if device is the Simulator **/
#define IS_SIMULATOR (TARGET_IPHONE_SIMULATOR)

#pragma - mark SYSTEM INFORMATION

/** String: System Name **/
#define SYSTEM_NAME ([[UIDevice currentDevice] systemName])

/** String: System Version **/
#define SYSTEM_VERSION ([[UIDevice currentDevice] systemVersion])

#pragma mark - SCREEN INFORMATION

/** Float: Portrait Screen Height **/
#define SCREEN_HEIGHT_PORTRAIT ([[UIScreen mainScreen] bounds].size.height)

/** Float: Portrait Screen Width **/
#define SCREEN_WIDTH_PORTRAIT ([[UIScreen mainScreen] bounds].size.width)

/** Float: Landscape Screen Height **/
#define SCREEN_HEIGHT_LANDSCAPE ([[UIScreen mainScreen] bounds].size.width)

/** Float: Landscape Screen Width **/
#define SCREEN_WIDTH_LANDSCAPE ([[UIScreen mainScreen] bounds].size.height)

/** CGRect: Portrait Screen Frame **/
#define SCREEN_FRAME_PORTRAIT (CGRectMake(0, 0, SCREEN_WIDTH_PORTRAIT, SCREEN_HEIGHT_PORTRAIT))

/** CGRect: Landscape Screen Frame **/
#define SCREEN_FRAME_LANDSCAPE (CGRectMake(0, 0, SCREEN_WIDTH_LANDSCAPE, SCREEN_HEIGHT_LANDSCAPE))

/** Float: Screen Scale **/
#define SCREEN_SCALE ([[UIScreen mainScreen] scale])

/** CGSize: Screen Size Portrait **/
#define SCREEN_SIZE_PORTRAIT (CGSizeMake(SCREEN_WIDTH_PORTRAIT * SCREEN_SCALE, SCREEN_HEIGHT_PORTRAIT * SCREEN_SCALE))

/** CGSize: Screen Size Landscape **/
#define SCREEN_SIZE_LANDSCAPE (CGSizeMake(SCREEN_WIDTH_LANDSCAPE * SCREEN_SCALE, SCREEN_HEIGHT_LANDSCAPE * SCREEN_SCALE))

#pragma mark - COLOR

/** UIColor: Color From Hex **/
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed : ((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green : ((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue : ((float)(rgbValue & 0xFF)) / 255.0 alpha : 1.0]

#define COLOR_FROM_HEX(rgbValue) (UIColorFromRGB(rgbValue))

/** UIColor: Color from RGB **/

#define RGB(r, g, b)[UIColor colorWithRed : r / 255.0 green : g / 255.0 blue : b / 255.0 alpha : 1.0]

#define IntToString(value)[NSString stringWithFormat:@"%ld", (long)value]

/** UIColor: Color from RGBA **/

#define COLOR_FROM_RGBA(r, g, b, a) ([UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a])

#define RGBA(r, g, b, a)[UIColor colorWithRed : r / 255.0 green : g / 255.0 blue : b / 255.0 alpha : a]

#pragma mark - DEGREES, RADIANS, MEASUREMENT UNITS CONVERTERS, SYSTEM VERSIONS

/** Degrees to Radian **/
#define DEGREES_TO_RADIANS(degrees) ((degrees) / 180.0 * M_PI)

/** Radians to Degrees **/
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

/** Miles to Kilometers **/
#define MILES_TO_KILOMETERS(miles) (miles * 1.60934)

/** Miles to Feets **/
#define MILES_TO_FEETS(miles) (miles * 5280)

#define NIL_IF_NULL(foo) ((foo == [NSNull null]) ? nil : foo)

#define NULL_IF_NIL(foo) ((foo == nil) ? [NSNull null] : foo)

#define EMPTY_IF_NIL(foo) ((foo == nil) ? @"" : foo)

#define EMPTY_IF_NULL(foo) ((foo == [NSNull null]) ? @"" : foo)

#define EMPTY_IF_NULL_OR_NIL(foo) ((foo == [NSNull null] || foo == nil) ? @"" : foo)

#define SYSTEM_VERSION_EQUAL_TO(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

#define SYSTEM_VERSION_GREATER_THAN(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#pragma mark - DLOG
//this app was used other Dlog
#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);
#else
# define DLog(...)
#endif
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);
#ifdef DEBUG
# define ULog(fmt, ...){ UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ## __VA_ARGS__] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show]; }
#else
# define ULog(...)
#endif

#define BoolValue(key)              [[NSUserDefaults standardUserDefaults] boolForKey:key]
#define SetBoolValue(value, key)    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key]
#define USER_DEFAULT                [NSUserDefaults standardUserDefaults]

#define LOGOUT                      @"Logout"



#endif
