//
//  ViewController.m
//  FishhookTest
//
//  Created by ios on 2020/11/14.
//

#import "ViewController.h"
#import "fishhook.h"

@interface ViewController ()

@end

@implementation ViewController

struct rebinding nslog;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"hello");
    
    //rebinding结构体
    
    
    //需要HOOK的函数名称，C字符串
    nslog.name = "NSLog";
    
    //将系统库函数所指向的符号，在运行时重新绑定到用户指定的函数地址
    nslog.replacement = myNslog;
    
    //将原系统库函数的真实地址赋值到用户指定的函数指针上
    nslog.replaced = (void*)&sys_nslog;
    
    //rebinding结构体数组
    struct rebinding rebs[1] = {nslog};
    
    rebind_symbols(rebs,1);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"点击了屏幕...");
}
//用户指定的函数指针
void(*sys_nslog)(NSString *format,...);
//新的nslog函数
void myNslog(NSString *format,...) {
    format = [format stringByAppendingString:@"勾上了"];
    sys_nslog(format);
}
@end
