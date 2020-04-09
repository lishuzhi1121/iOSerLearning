头条 饿了么
--

1. View 的firstResponed 是什么概念
2. Flutter原理
3. 二叉树非递归方式便利深度
4. SEL 是如何找到IMP的
5. Intialize 是什么时候执行的
6. 为什么内存释放了访问会崩溃
7. swift的struct与class的区别
8. weak和assign区别
9. 栈为啥那么小
10. 栈溢出会导致什么
11. 优化http请求时间
12. 什么是http
13. 什么是栈溢出
14. http协议是什么
15. 优化http协议

其他杂项
--

1、二叉树,遍历方式
2、自动释放池 与 runloop +

  1. 通知observer run loop被触发
  2. 如果有timers事件的话，通知observer
  3. 如果有source0要处理的话，通知observer
  4. 触发所有的准备完毕的source0
  5. 如果当前是主线程的runloop，并且主线程有事儿，跳到第9步
  6. 通知Observer runloop将进入sleep状态
  7. mach进入sleep和监听状态
  8. 通知observer，runloop被woke up
  9. 如果runloop是被唤醒，CFRUNLOOP_WAKEUP_FOR_WAKEUP
  10. 如果用户定义的timer被触发，处理event并重启RunLoop
  11. 如果dispatchPort，处理主线程
  12. 如果一个source1被触发，__CFRunLoopDoSource1
  13. 继续循环或通知observer runloop将要exited

3、刷一些算法题，时间复杂度，空间复杂度

看下多线程
看下socket与网络3次握手 4次
看下flutter
看下tensorflow

alloc init

https的原理 为什么安全 握手过程

事件响应链 

响应view意外的事件

深浅copy

.LLVM与Clang的区别. AST语法树

反斜对角打印，取数组第n大的值，three sum

编译过程

预处理，生产中间码（clang）,生产机器码链接动态库

SideTable
https://blog.csdn.net/u013378438/article/details/82790332

内省方法 ：
 是否遵循特定的协议，以及是否可以响应特定的消息 iskindof class 

class、objc_getClass、object_getclass

隐式动画 & 显示动画
 显示 present的时候，设置颜色的时候，，显示：coreanimation里面的。关键帧，补间动画（和flutter的一样的）

什么是离屏渲染，gpu 
https://zhuanlan.zhihu.com/p/72653360

imageName & imageWithContentsOfFile区别

如果GPU的刷新率超过了iOS屏幕60Hz刷新率是什么现象，怎么解决

路由方案：

中间层、协议&&运行时、urlPath

如何设计一个git diff

OC怎么实现多继承？怎么面向切面(类似于swift的protocol，runtime埋点)

Clang实现代码混淆

崩溃捕捉原理
appdelegate 捕捉上报， 包括 uncautch exception 和 信号中断

app启动过程, 启动优化

	•	加载可执行文件。（App里的所有.o文件）
	•	加载动态链接库，进行rebase指针调整和bind符号绑定。 （xcode run加个参数可以看库加载时间）
	•	ObjC的runtime初始化。 包括：ObjC相关Class的注册、category注册、selector唯一性检查等
	•	初始化。 包括：执行+load()方法、用attribute((constructor))修饰的函数的调用、创建C++静态全局变量

main()

首屏渲染完成后（从self.window.rootViewController执行完成到didFinishLaunchWithOptions方法作用域结束

减少依赖不必要的库，不管是动态库还是静态库；如果可以的话，把动态库改造成静态库；如果必须依赖动态库，则把多个非系统的动态库合并成一个动态库；
检查下framework应当设为optional或required，如果该framework在当前App支持的所有iOS系统版本都存在，那么就设为required，否则就设为optional，因为`optional``会有些额外的检查；
合并或者删减一些OC类和函数；关于清理项目中没用到的类，使用工具AppCode代码检查功能，查到当前项目中没有用到的类（也可以用根据linkmap文件来分析，但是准确度不算很高）。
删减一些无用的静态变量，
删减没有被调用到或者已经废弃的方法。
将不必须在+load方法中做的事情延迟到+initialize中，尽量不要用C++虚函数(创建虚函数表有开销)
类和方法名不要太长：iOS每个类和方法名都在__cstring段里都存了相应的字符串值，所以类和方法名的长短也是对可执行文件大小是有影响的；因还是object-c的动态特性，因为需要通过类/方法名反射找到这个类/方法进行调用，object-c对象模型会把类/方法名字符串都保存下来；
用dispatch_once()代替所有的 attribute((constructor)) 函数、C++静态对象初始化、ObjC的+load函数；
在设计师可接受的范围内压缩图片的大小，会有意外收获。压缩图片为什么能加快启动速度呢？因为启动的时候大大小小的图片加载个十来二十个是很正常的，图片小了，IO操作量就小了，启动当然就会快了，比较靠谱的压缩算法是TinyPNG。

沙盒目录:
Document：保存应用运行时生成的需要持久化的数据，iTunes会自动备份该目录，苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录。
tmp：保存应用运行时所需的临时数据，使用完毕后再将相应的文件从该目录删除。应用没有运行时，系统也有可能会清除该目录下的文件，iTunes不会同步该目录，iPhone重启时，该目录下的文件会丢失。
Library：存储程序的默认设置和其他状态信息，iTunes会自动备份该目录。
Library/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除。一般存放体积比较大，不是特别重要的资源。
Library/Preferences：保存应用的所有偏好设置，iOS的Settings（设置）应用会在该目录中查找应用的设置信息，iTunes会自动备份该目录。

MD5、Sha1、Sha256
charles抓包过程？不使用charles，4G网络如何抓包
深搜 广搜 ***
GCD 实现原理： 底层线程池，系统管理，同步队列任务，调用一个线程，用完放回去，后面的任务等待，异步不需要等待，所以可以调用其它线程，一起执行队列里面的人任务。

卡顿：cAdisplaylayer runloop状态

1、 自我介绍
姓名，部门， 主要从事工作（分享sdk，pm，推送sdk，支付sdk 等)，代码质量管理工作（单元测试，内存，静态代码规范，自动发布ci系统），移动端新兴技术都有跟(flutter,coreml) 

2、你擅长什么
模块化，接口设计，架构，业务能力， 流程化管理和测试，  第三方平台交互， flutter

RunTime
运行时，核心是消息传递，调用时 找isa -> methodlist -> sel -> imp

分类增加属性
方法添加和替换
json解析
解耦 （这边的业务）

排序/算法复杂度 （需要知道快排、桶排序等经典排序算法）

http https tcp

栈为什么那么小


业务层面
--

1、读写锁、gcd_barriar（这玩意儿老被问）NSOperation

* 在没有写操作的时候, 可以任意的并发读取
* 在所有读操作完成后, 才进行写操作, 但是写操作不可以并发, 且在写操作过程中, 不能读取
* 在写操作完成后, 又可以任意的并发读取了
* gcd_barriar_async: 之前添加的任务完成后才会继续执行，但是不回阻塞后面的代码
* gcd_barriar_sync：之前添加的任务完成后才会继续执行

2、 日志服务设计架构

1、日志管理类：
写入与缓存
分片管理
重试机制
发送（sending）
线程安全控制：锁 和 2片内存（如果正在发送，则开辟另一片区域存下写入的日志，发送完成后合并日志）

2、日志类型处理
debug日志，崩溃日志，正常业务日志

3、日志发送类
sendLog:(id)logs —> Manager
manager通过代理通知 日志可以发送
回调日志发送状态（失败重试）
返回最终结果，失败写会，锁释放等

3、 路由深度理解，模块化开发 ++  看看mvvm
1、URLPath && 外部路由和内部模块路由 && runtime自动发现（我理解可以协议runtime，但是可能有性能问题）

4、 缓存设计
1、内存缓存，数量，容量，时间周期限制， lru原则
2、磁盘缓存
3、管理类，请求 ，如果缓存没有，请求服务器，写入缓存

5、http 链路与 TCP 

6、断点续传：Range

7、https://www.jianshu.com/p/30b82f1e61a9 傻逼直播

8、回溯算法和贪心算法
