//
//  MessageInterceptor.h
//  TableViewPull
//
//  From http://stackoverflow.com/questions/3498158/intercept-obj-c-delegate-messages-within-a-subclass

#import <Foundation/Foundation.h>

@interface MessageInterceptor : NSObject {
    id __unsafe_unretained receiver;
    id __unsafe_unretained middleMan;
}
@property (unsafe_unretained) id receiver;
@property (unsafe_unretained) id middleMan;
@end
