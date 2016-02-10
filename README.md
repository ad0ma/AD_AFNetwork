# AD_AFNetwork
基于新版AFNetworking的简单封装包含四个常用功能

    NSString *URLString = @"http://example.com";
    NSDictionary *parameters = @{@"foo": @"bar", @"baz": @[@1, @2, @3]};
    
    //GET方式获取网络数据
    [ADRequestManager GET:URLString success:^(id response) {
        NSLog(@"%@",response);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    //POST方式获取网络数据
    [ADRequestManager POST:URLString params:parameters success:^(id response) {
        NSLog(@"%@",response);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    //服务器上传图片
    UIImage *uploadImage = [UIImage imageNamed:@"image"];
    UIProgressView *progress = [[UIProgressView alloc] init];
    
    [ADRequestManager UPLOADIMAGE:URLString params:parameters progressView:progress uploadImage:uploadImage imageName:@"imageName" success:^(id response) {
        NSLog(@"%@",response);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    //网络监听
    [ADRequestManager MonitorNetwork:^(NSString *status) {
        NSLog(@"%@",status);
    }];
