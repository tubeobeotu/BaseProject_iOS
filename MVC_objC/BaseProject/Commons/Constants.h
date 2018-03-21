

#ifndef Constants_h
#define Constants_h

//Value constant in app
#define SCALE_DOWN_SIZE_WIDTH_IMAGE 800

//Storyboard Name
#define MAIN_STORYBOARD_NAME		@"Main"

//Navigation Title
#define NAVIGATIONBAR_TITLE			@"Blast.ai"
#define CONFIDENT_TEXT				@"Confidence:"


typedef NS_ENUM (NSInteger, ResponseCode) {
    RESP_CODE_SUCCESS = 0,
    RESP_CODE_SUCCESS_VT = 200,
    RESP_CODE_UNKNOWN = -1,
    RESP_CODE_EXCEPTION = 2000,
    RESP_CODE_EXCEPTION_NO_INTERNET = 50,
    RESP_CODE_EXCEPTION_ERROR_SERVER = 61,
    RESP_CODE_EXCEPTION_UNKNOWN_SESSION = 70,
    RESP_CODE_EXCEPTION_EXPIRE_SESSION  = 71,
    RESP_CODE_REQUEST_INPROCESS  = 201
};

#endif /* Constants_h */

typedef enum : NSInteger{
	VisionDetectedType_Label,
	VisionDetectedType_Web,
	VisionDetectedType_Doccument,
	VisionDetectedType_Logo
}VisionDetectedType;


typedef enum : NSInteger{
    PA_FriendList_FB,
    PA_FriendList_GOOGLE,
    PA_FriendList_TWITTER
}PA_FriendList;
