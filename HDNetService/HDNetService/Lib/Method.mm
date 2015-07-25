//
//  Method.m
//  HDNetService
//
//  Created by 张达棣 on 14-11-4.
//  Copyright (c) 2014年 张达棣. All rights reserved.
//

#import "Method.h"

using namespace iNetLib;

#pragma mark -

@implementation INSelectorValue
{
    SEL selector;
}

@synthesize selector;

+(INSelectorValue*)sel:(SEL)sel
{
    auto r=[[INSelectorValue alloc]init];
    r->selector=sel;
    return r;
}


@end


#pragma mark -

ocNotifyListBase::ocNotifyListBase()
{
}
ocNotifyListBase::~ocNotifyListBase()
{
    for(auto p : fPointerList){
        if(p!=nullptr)
            p->Caller=nullptr;
    }
}

void ocNotifyListBase::AddPointer(ocNotifyPointer *Pointer)
{
    auto item=std::find(fPointerList.begin(), fPointerList.end(), Pointer);
    if(item!=fPointerList.end())
        return;	// 已经存在
    
    if(Pointer->Caller!=nullptr)
        Pointer->Caller->RemovePointer(Pointer);
    Pointer->Caller=this;
    fPointerList.push_back(Pointer);
}

void ocNotifyListBase::RemovePointer(ocNotifyPointer *Pointer)
{
    auto item=std::find(fPointerList.begin(), fPointerList.end(), Pointer);
    if(item==fPointerList.end())
        return;
    
    fPointerList.erase(item);
    Pointer->Caller=nullptr;
}

ocNotifyPointer::ocNotifyPointer(){
}

ocNotifyPointer::~ocNotifyPointer()
{
    if(Caller!=nullptr){
        Caller->RemovePointer(this);
    }
}
ocNotifyPointer::ocNotifyPointer(const ocNotifyPointer &Src)
{
    fObject=Src.fObject;
    fSelector=Src.fSelector;
    Receive(Src.Caller);
}
ocNotifyPointer& ocNotifyPointer::operator =(const ocNotifyPointer &Src)
{
    fObject=Src.fObject;
    fSelector=Src.fSelector;
    Receive(Src.Caller);
    return *this;
}
void ocNotifyPointer::Assigner::operator = (SEL Selector)
{
    if(Selector==nil){
        Owner->fObject=nil;
        Owner->fSelector=nil;
        return;
    }
    IN_ASSERT([Object respondsToSelector:Selector]);
    Owner->fSelector=Selector;
    Owner->fObject=Object;
}
ocNotifyPointer::Assigner ocNotifyPointer::operator [] (id Object)
{
    Assigner t{this,Object};
    return t;
}
ocNotifyPointer& ocNotifyPointer::operator =(_InvalidPointer *)
{
    fObject=nil;
    fSelector=nil;
    return *this;
}


void ocNotifyPointer::Receive(ocNotifyListBase *List)
{
    if(List!=nullptr){
        List->AddPointer(this);
    }
    else if(Caller!=nullptr){
        Caller->RemovePointer(this);
    }
}


