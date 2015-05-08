//
//  ViewController.m
//  TestFileManager
//
//  Created by Jian HU on 15/3/27.
//  Copyright (c) 2015年 Wujunqiu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Test FileManager";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dirHome];
    [self dirDoc];
    [self dirLib];
    [self dirCache];
    [self dirPerference];
    [self dirTmp];
    [self createDir];
    [self createDirUnderCaches];
    [self writeFileToUnderDocuments];
    [self writeFileToUnderCaches];
    [self readFileUnderDocuments];
    [self readFileUnderCaches];
    [self fileAttriutes];

    
    UIButton *deletUnderDocuments = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [deletUnderDocuments setTitle:@"删除underdocuments文件夹下的文件" forState:UIControlStateNormal];
    deletUnderDocuments.frame = CGRectMake((self.view.frame.size.width - 50)/2, 100, 50, 50);
    [deletUnderDocuments addTarget:self action:@selector(deleteFileUnderDocuments) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deletUnderDocuments];
    
}


- (void)deleteFileUnderDocuments{
    [self deleteUnderDocumentsFile];
    [self deleteUnderDocument];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  获取应用沙盒的根路径
 */
- (void)dirHome{
    NSString *dirHome = NSHomeDirectory();
    NSLog(@"app_home:%@",dirHome);
    
    // app_home:/Users/jianhu/Library/Developer/CoreSimulator/Devices/1F5B03DB-3ACE-44DD-880E-AC505F1D682B/data/Containers/Data/Application/B38E598C-D7A4-4328-BE91-A887891125B6
}


/**
 *  获取Documents目录路径
 */
- (NSString *)dirDoc{
    //在根目录下找Documents目录
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = path[0];
    NSLog(@"app_home_doc:%@",documentDirectory);
    return documentDirectory;
    
    //NSHomeDirectory()/Documents
    //app_home_doc:/Users/jianhu/Library/Developer/CoreSimulator/Devices/1F5B03DB-3ACE-44DD-880E-AC505F1D682B/data/Containers/Data/Application/B38E598C-D7A4-4328-BE91-A887891125B6/Documents
}


/**
 *  获取Library目录路径
 */

- (NSString *)dirLib{
    //在根目录下找Library目录
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *librayDirectory = path[0];
    NSLog(@"app_home_lib:%@",librayDirectory);
    return librayDirectory;
    
    //NSHomeDirectory()/Library
    //app_home_lib:/Users/jianhu/Library/Developer/CoreSimulator/Devices/1F5B03DB-3ACE-44DD-880E-AC505F1D682B/data/Containers/Data/Application/B38E598C-D7A4-4328-BE91-A887891125B6/Library
}


/**
 *  获取Tmp目录路径
 */

- (void)dirTmp{
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSLog(@"app_home_tmp:%@",tmpDirectory);
}


/**
 *  获取Cache目录路径
 */

- (NSString *)dirCache{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = path[0];
    NSLog(@"app_home_lib_cache:%@",cachePath);
    return cachePath;
    //app_home_lib_cache:Users/jianhu/Library/Developer/CoreSimulator/Devices/1F5B03DB-3ACE-44DD-880E-AC505F1D682B/data/Containers/Data/Application/B8697093-59B1-4C3C-AE53-303BDA130B90/Library/Caches
}


/**
 *  获取Preference目录路径
 */

- (void)dirPerference{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES);
    NSString *preferencePath = path[0];
    NSLog(@"app_home_lib_preference:%@",preferencePath);
    //该目录下没有文件夹
   
}

#pragma mark - CreateDir 
/**
 * Documents目录下创建新文件夹underDocuments
 */

- (void)createDir{
    NSString *testDirectory = [[self dirDoc]stringByAppendingPathComponent:@"underDocuments"];
    BOOL res = [[NSFileManager defaultManager]createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        NSLog(@"创建文件夹成功");
        NSLog(@"%@",testDirectory);
    }else{
        NSLog(@"创建文件夹失败");
    }
}

/**
 *  NSHomeDirectory()/Library/Caches下创建新文件夹
 */

- (void)createDirUnderCaches{
    NSString *directoryUnderCache = [[self dirCache]stringByAppendingPathComponent:@"underCaches"];
    BOOL res = [[NSFileManager defaultManager]createDirectoryAtPath:directoryUnderCache withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        NSLog(@"创建文件夹成功");
        NSLog(@"%@",directoryUnderCache);
    }else{
         NSLog(@"创建文件夹失败");
    }
}


#pragma mark - Write Data to File

/**
 *  写数据到Documents目录下新创建的文件夹underDocuments
 */

- (void)writeFileToUnderDocuments{
    //获取underDocuments文件夹目录的路径
    NSString *underDocumentsPath = [[self dirDoc]stringByAppendingPathComponent:@"underDocuments"];
    NSString *filePath = [underDocumentsPath stringByAppendingPathComponent:@"underDocumentsFile.txt"];
    NSString *writeContent = @"要写入的数据";
    BOOL res = [writeContent writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (res) {
        NSLog(@"数据写入成功");
        NSLog(@"filePath:%@",filePath);
    }else{
        NSLog(@"数据写入失败");
    }
}

/**
 *  写数据到Library/Caches目录下新创建的文件夹underCaches
 */
- (void)writeFileToUnderCaches{
    NSString *underCachesPath = [[self dirCache]stringByAppendingPathComponent:@"underCaches"];
    NSString *filePath = [underCachesPath stringByAppendingPathComponent:@"cachesFile.txt"];
    NSString *writeContent = @"要写入的数据";
    BOOL res = [writeContent writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (res) {
        NSLog(@"数据写入成功");
        NSLog(@"CachesfilePath:%@",filePath);
    }else{
       NSLog(@"数据写入失败");
    }
}

#pragma mark - Read File Data

/**
 *  读取写入underDocuments文件夹下的文件
 */
- (void)readFileUnderDocuments{
    //根据写入documents的路径读取文件
    NSString *underDocumentsPath = [[self dirDoc]stringByAppendingPathComponent:@"underDocuments"];
    NSString *filePath = [underDocumentsPath stringByAppendingPathComponent:@"underDocumentsFile.txt"];
    
    NSString *writeContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"underDocuments文件读取成功 %@",writeContent);
}

/**
 *  读取写入underCaches文件夹下的文件
 */
- (void)readFileUnderCaches{
    //根据写入documents的路径读取文件
    NSString *underCachesPath = [[self dirCache]stringByAppendingPathComponent:@"underCaches"];
    NSString *filePath = [underCachesPath stringByAppendingPathComponent:@"cachesFile.txt"];
    
    NSString *writeContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"underCaches文件读取成功 %@",writeContent);
}

#pragma mark - 删除文件

/**
 *  删除underDocuments文件夹下得文件
 *  删除之前判断该路径下是否存在文件
 */
- (void)deleteUnderDocumentsFile{
    
    NSString *underDocumentsPath = [[self dirDoc]stringByAppendingPathComponent:@"underDocuments"];
    NSString *filePath = [underDocumentsPath stringByAppendingPathComponent:@"underDocumentsFile.exe"];
   
    NSFileManager *manger = [NSFileManager defaultManager];
    if ([manger fileExistsAtPath:filePath]) {
        [manger removeItemAtPath:filePath error:nil];
        
        NSLog(@"文件是否存在:%@",[manger isExecutableFileAtPath:filePath]?@"YES":@"NO");
    }else{
        NSLog(@"");
    }
    
}


/**
 *  删除underCaches文件夹下得文件
 *  删除之前判断该路径下是否存在文件
 */
- (void)deleteUnderCachesFile{
    NSString *underCachesPath = [[self dirCache]stringByAppendingPathComponent:@"underCaches"];
    NSString *filePath = [underCachesPath stringByAppendingPathComponent:@"cachesFile.txt"];
    NSFileManager *manger = [NSFileManager defaultManager];
    if ([manger fileExistsAtPath:filePath]) {
        [manger removeItemAtPath:filePath error:nil];
        NSLog(@"文件是否存在:%@",[manger isExecutableFileAtPath:filePath]?@"YES":@"NO");
    }else{
        NSLog(@"该路径下不存在文件");
    }
}

/**
 *  删除underDocument文件夹
 */
- (void)deleteUnderDocument{
    NSString *underDocPath = [[self dirDoc]stringByAppendingPathComponent:@"underDocuments"];
    NSFileManager *manger = [NSFileManager defaultManager];
    if ([manger fileExistsAtPath:underDocPath]) {
        [manger removeItemAtPath:underDocPath error:nil];
        BOOL isExit = [manger isExecutableFileAtPath:underDocPath];
        NSLog(@"文件夹是否存在%d",isExit);
    }else{
        NSLog(@"不存在该文件夹®");
    }
}


#pragma mark - 文件属性

/**
 *  获取文件属性
 */
-(void)fileAttriutes{

    NSString *testDirectory = [[self dirDoc] stringByAppendingPathComponent:@"underDocuments"];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"underDocumentsFile.txt"];
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:testPath error:nil];
    id key, value;
    NSArray *keys = [fileAttributes allKeys];
    int count = (int)[keys count];
    for (int i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [fileAttributes objectForKey: key];
        NSLog (@"Key: %@ for value: %@", key, value);
    }
}

@end
