

#import "UIViewController+Alert.h"
#import "AllCommon.h"
#import "LocalizeHelper.h"
@implementation UIViewController (Alert)

- (void)showAlertWithMessage:(NSString *)message{
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Ok" message:message preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
	
	[alert addAction:defaultAction];
	[self presentViewController:alert animated:YES completion:nil];
}
- (void)showErrorWithAlert:(NSString *)errorMessage{
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:LocalizedString(@"Error")
																   message:errorMessage
															preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:LocalizedString(@"Ok") style:UIAlertActionStyleDefault
														  handler:^(UIAlertAction * action) {}];
	[alert addAction:defaultAction];
	[self presentViewController:alert animated:YES completion:nil];
}
@end
