//
//  ViewController.m
//  Interview01-Class
//
//  Created by 李树志 on 2020/4/12.
//  Copyright © 2020 李树志. All rights reserved.
//

#import "ViewController.h"
#import "SZPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TODO: 面试题：下面的方法代码是否可以编译通过？方法调用是否会报错，为什么？如果正常输出结果是什么？
    /**
     首先，下面的代码编译正常，方法调用不会报错，原因分析如下：
         1、personCls 是一个指向 SZPerson 类对象的指针，obj 则是指向 personCls 这个指针的指针；
         2、testLog 是一个对象方法，根据类的结构定义，它的实现是存储在 SZPerson 这个类对象里的；
         3、我们知道如果通过SZPerson的实例对象（SZPerson *person = [[SZPerson alloc] init];）
            去调用testLog显然是正常的，对象的本质则是一个结构体（person则是指向结构体的指针），包含isa、成员变量
            等信息，其调用过程实际上是通过实例对象person指向的结构体里的isa指针找到其类对象，从而找到对应方法实现进行调用；
         4、实例对象person指向的结构体第一个成员就是isa，isa这个成员的地址就是结构体的地址，所以person指针实际上就是
            指向这个isa；
         5、也就是说person指针指向isa指针，isa指针指向SZPerson这个类对象，那么这不就是跟下面的代码本质上是一样的嘛？
            obj指针（类比为person指针）指向personCls指针，personCls指针（类比为isa指针）指向SZPerson类对象；
         6、所以既然person对象能正常调用testLog，那么这里的obj指针也肯定能找到testLog方法并正常调用，这是完全合理的。
     
     其次，我们来分析一下调用之后的输出结果是什么：
         1、我们知道如果通过SZPerson的实例对象（SZPerson *person = [[SZPerson alloc] init];）去
            调用testLog方法，则在其方法内部会去访问_name这个成员变量（self.name 实际上就是 self->_name），那么它是
            如何找到这个_name的呢？其实它是通过self指针指向的结构体（person对象结构体）地址偏移8个字节（因为isa指针占8个
            字节,并且person结构体里就一个_name,所以isa的地址和_name的地址是连着的）来找的；
         2、上面所说的self指针是指当前调用方法的对象，或者说消息接收者，其实就是person对象，那么同理，如果是obj调用
            testLog方法，调用对象就是obj；
         3、既然使用obj调用testLog方法当前调用对象就是obj，那么在访问self.name的时候就相当于是obj->_name，而找_name的
            本质又是通过地址偏移来的，所以此时就相当于访问了将obj指针指向的地址再偏移8个字节所对应地址空间的内容；
         4、此外，我们还知道像 id personCls、void *obj 这些其实是局部变量，而局部变量是存储在栈区的，并且根据栈的特性，
            这些局部变量存储时是由高地址（栈底）向低地址（栈顶）分配的，越先定义，地址越高，比如：personCls地址如果是0x07ffffa8
            则obj的内存地址是0x07ffffa0，以此类推；
         5、那么此时我们就知道了访问 obj->_name 就是要找obj指针指向的地址再偏移8个字节，obj指针指向的地址其实就是personCls，
            那么将personCls的地址再偏移8个字节是啥呢？它前面没有定义局部变量了啊；
         6、真的是这样吗？乍一看似乎还真是！可是别忘了前面还有一句 [super viewDidLoad]; 呢，根据runtime源码，这一句其实就
                   struct objc_super {
                        id receiver;
                        Class super_class;
                   }; // objc_super 结构体定义
            相当于  objc_msgSendSuper(objc_super *super, SEL op); 这一段代码，原来这里还隐藏着一个结构体变量的定义，
            这个结构体变量其实也是一个局部变量，所以它在栈区的地址就应该是连着personCls的，并且结构体内存地址是连续的，所以
            personCls的地址再偏移8个字节（其实就是去掉自身）刚好是这个 objc_super 结构体的地址，自然也就是它第一个成员的
            地址，所以obj->_name访问到的应该是这个super里的id receiver;
         7、根据runtime源码注释，这个receiver其实就是ViewController这个class的实例，那其实就是这里的self,所以最后的
            输出应该是当前self对象。
     
     最后，做个补充：如果在personCls前面我们再显式定义一个变量，那么输出结果又如何呢？
        1、如果定义的变量刚好占8个字节（比如NSString *，NSObject *指针），那么最后就会输出所定义的变量值，这一点比较好理解了；
        2、如果定义的变量类型占用的不是8个字节（如果是结构体则针对第一个成员来说），那么程序就会crash了，原因则是因为obj指针
           指向的地址便宜8个字节之后再读取8个字节的时候发现内存中数据错误了，此时则会报 EXC_BAD_ACCESS 的错误。
     */
    
//    NSString *a = @"sands";
//    int age = 18; // 定义变量类型不是8个字节则会crash

    id personCls = [SZPerson class];
    void *obj = &personCls;
    [(__bridge id)obj testLog];
}


@end
