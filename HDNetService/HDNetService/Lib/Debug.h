//
//  Debug.h
//  HDNetService
//
//  Created by 张达棣 on 14-11-4.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#ifndef __HDNetService__Lib__Debug__
#define __HDNetService__Lib__Debug__
//#import <HDNetService/DLog.h>

#ifdef	__OBJC__
#include <Foundation/Foundation.h>
#endif

#ifdef  __cplusplus

extern "C"{
#endif	// __cplusplus
    
    // IN_AssertFailLog
    //	断言错误,输出信息并中断程序
    // [in]File				源代码文件名,__FILE__宏
    // [in]Line				行号,__LINE__宏
    // [in]ConditionString	断言条件表达式字符串
    // [in]UserString		附加信息
    void IN_AssertFailLog(const char *File,int Line,const char *ConditionString);
    void DebugLog(NSString *FormatString,...) NS_FORMAT_FUNCTION(1,2);
    
    // IN_ASSERT
    //	断言宏
    //	当断言失败时，输出调试信息并暂停程序
    // _cond				判断条件
#ifdef DEBUG
#define IN_ASSERT(_cond_)		( (_cond_) ? ((void)0) : IN_AssertFailLog(__FILE__,__LINE__,#_cond_) )
#else
#define IN_ASSERT(_cond_)
#endif
    
#ifdef  __cplusplus
}	// extern "C"


namespace iNetLib{
    
    class cCheckedUnsafePointer
    {
        id __unsafe_unretained fPointer=nil;
    public:
        cCheckedUnsafePointer();
        cCheckedUnsafePointer(id __unsafe_unretained p);
        ~cCheckedUnsafePointer();
        
        cCheckedUnsafePointer& operator =(id __unsafe_unretained p){
            fPointer=p;
            return *this;
        }
        
        operator id ()const{	return fPointer;	}
    };
    
    
#ifdef	DEBUG
    typedef cCheckedUnsafePointer iWeakPointer;
#else
    typedef id __unsafe_unretained iWeakPointer;
#endif
    
    void ocWeakPointerCheck_Add(const id __unsafe_unretained *idPointer);
    void ocWeakPointerCheck_Remove(const id __unsafe_unretained *idPointer);
    
}
#endif	// __cplusplus



#endif /* defined(__MTLibrary__Debug__) */

