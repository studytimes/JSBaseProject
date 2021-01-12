//
//  DefineRequest.h
//  BaseProject
//
//  Created by Anpai on 2017/10/15.
//

#ifndef DefineRequest_h
#define DefineRequest_h

#if DEBUG

// 1开发 999正式
    #define SERVER_ADDRESS_SWITCH    (1)

#else

    #define NSLog(...)
    #define SERVER_ADDRESS_SWITCH    (999)

#endif

//请求地址参数配
#if (SERVER_ADDRESS_SWITCH == 1)

    #define BASEURL    @"http://116.255.245.140:8431/"

//      #define BASEURL @"http://192.168.10.216:8431/"

#elif (SERVER_ADDRESS_SWITCH == 999)

    #define BASEURL    @"http://app.szontap.com/"

#endif

#define VERSION_CODE @"1.0.0"
#define JSEventHandleName @"JSxfkHandle"
#define DEVICENETWORK @"phonedevicenetwork"


#endif /* DefineRequest_h */
