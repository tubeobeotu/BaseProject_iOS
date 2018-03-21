

#ifndef AppColor_h
#define AppColor_h


#endif /* AppColor_h */

#define kNavigationBarTintColor							RGB(119, 119, 119)

#define AppColor_MainAppTintColor                       RGB(2, 127, 185)
#define AppColor_MainAppBackgroundColor                 RGB(233, 234, 236)

#define AppColor_TintBorderColor						RGB(51, 51, 51)

//Text Color
#define App_Color_MainTextBoldColor						[UIColor blackColor]
#define AppColor_MainTextColor                          RGB(102, 102, 102)
#define AppColor_HightLightTextColor					RGB(255, 150, 0)

//Chart Color
#define AppColor_NotProgressPersonalChartColor      RGB(25, 156, 210)// Chưa thực hiện
#define AppColor_SlowProgressPersonalChartColor     RGB(234, 105, 55)// Chậm tiến độ

#define AppColor_NotProgressShipperChartColor       RGB(2, 84, 185)
#define AppColor_SlowProgressShipperChartColor      RGB(253, 197, 26)

// Border for TextView
#define AppColor_BorderForView                      RGB(225, 229, 231)

// Border for button cancel
#define AppColor_BorderForCancelButton              RGB(233, 79, 81)
#define UIColorFromHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]
// Common Colors
#define CommonColor_Red UIColorFromHex(0xf05253)
#define CommonColor_Orange UIColorFromHex(0xfe9d3e)
#define CommonColor_Blue UIColorFromHex(0x129cdb)
#define CommonColor_DarkBlue UIColorFromHex(0x0380ba)
#define CommonColor_Purple UIColorFromHex(0x7c2691)
#define CommonColor_Green UIColorFromHex(0x22b291)
#define CommonColor_LightGreen UIColorFromHex(0x6fddd2)
#define CommonColor_Gray UIColorFromHex(0xb3b8be)
#define CommonColor_LightGray UIColorFromHex(0xcdd1da)
#define CommonColor_GreenTimeKeeping UIColorFromHex(0x449F01)
