//
//  Debug.m
//  HDNetService
//
//  Created by 张达棣 on 14-11-4.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import "Debug.h"
#import <objc/runtime.h>
#include <vector>
#import "Debug.h"

using namespace iNetLib;

#ifdef	DEBUG

void IN_AssertFailLog(const char *File,int Line,const char *ConditionString)
{
    DebugLog(@"断言错误发生在 %s ( %d 行 ) : %s\n", File, Line, ConditionString);
    // throw an assertion exception (debug break)
    kill( getpid(), SIGINT ) ;
}

void DebugLog(NSString *FormatString,...) {
    va_list vl;
    va_start(vl, FormatString);
    auto Str=[[NSString alloc]initWithFormat:FormatString arguments:vl];
    auto UTF8Str=Str.UTF8String;
    
    printf("%s\n",UTF8Str);
    
    va_end(vl);
}


#else	// not DEBUG

void IN_AssertFailLog(const char *File,int Line,const char *ConditionString){}
void DebugLog(NSString *FormatString,...){}

#endif


#ifdef	DEBUG

static NSLock *PointerListLock=[[NSLock alloc]init];
static std::vector<const id __unsafe_unretained *> PointerList;
void iNetLib::ocWeakPointerCheck_Add(const id __unsafe_unretained *idPointer){
    [PointerListLock lock];
    auto pos=std::find(PointerList.begin(),PointerList.end(),idPointer);
    if(pos==PointerList.end()){
        PointerList.push_back(idPointer);
    }
    [PointerListLock unlock];
}
void iNetLib::ocWeakPointerCheck_Remove(const id __unsafe_unretained *idPointer){
    [PointerListLock lock];
    auto pos=std::find(PointerList.begin(),PointerList.end(),idPointer);
    if(pos!=PointerList.end()){
        PointerList.erase(pos);
    }
    [PointerListLock unlock];
}
static void ocWeakPointerCheck_Check(id __unsafe_unretained o,const char *ObjectDesc)
{
    [PointerListLock lock];
    for(auto p : PointerList){
        if(*p==o){
            IN_AssertFailLog(__FILE__, __LINE__, ObjectDesc);
        }
    }
    [PointerListLock unlock];
}

// 指针检测
#if		1

typedef void TYPE_Dealloc(id __unsafe_unretained self,SEL _cmd);
static void onDealloc(id __unsafe_unretained self,SEL _cmd);
static TYPE_Dealloc* ocWeakPointerCheck_HookDealloc(void){
    SEL d=sel_getUid("dealloc");
    auto m_dealloc=class_getInstanceMethod([NSObject class], d);
    return reinterpret_cast<TYPE_Dealloc*>(method_setImplementation(m_dealloc, reinterpret_cast<IMP>(&onDealloc)));
}

static TYPE_Dealloc* IMP_Dealloc=ocWeakPointerCheck_HookDealloc();
static void onDealloc(id __unsafe_unretained self,SEL _cmd){
    Class cls=[self class];
    auto ClassName=class_getName(cls);
    char TempStr[128];
    if(strlen(ClassName)>=80)
        ClassName="";
    sprintf(TempStr,"%s对象被释放，但是仍有指针存在",ClassName);
    IMP_Dealloc(self,_cmd);
    ocWeakPointerCheck_Check(self,TempStr);
}

#endif


#else	// not DEBUG


void iNetLib::ocWeakPointerCheck_Add(const id __unsafe_unretained *){}
void iNetLib::ocWeakPointerCheck_Remove(const id __unsafe_unretained *){}

#endif


cCheckedUnsafePointer::cCheckedUnsafePointer()
{
    ocWeakPointerCheck_Add(&fPointer);
}
cCheckedUnsafePointer::cCheckedUnsafePointer(id __unsafe_unretained p)
:fPointer(p)
{
    ocWeakPointerCheck_Add(&fPointer);
}
cCheckedUnsafePointer::~cCheckedUnsafePointer()
{
    ocWeakPointerCheck_Remove(&fPointer);
}


