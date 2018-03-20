# LoginSDK


发现两个优化的地方：
1、NSString *strBundle = [[NSBundle mainBundle] pathForResource:@"TJLoginSDK" ofType:@"bundle"];
  改为  NSString *strBundle = [[NSBundle mainBundle] pathForResource:@"LoginSDK" ofType:@"bundle"];
  
2、为了适配 iPhone X  免于帐号的 上边框 高亮不显示
    [self.userTF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(navTitle.mas_bottom).offset(backView.frame.size.height/IMAGE_HEIGHT *50);
        make.left.mas_equalTo(backView.mas_left).offset(backView.frame.size.width/IMAGE_WIDTH *25);
        make.right.mas_equalTo(backView.mas_right).offset(-(backView.frame.size.width/IMAGE_WIDTH *25));
        make.height.mas_equalTo(backView.frame.size.height/IMAGE_HEIGHT *100);
    }];
    
    改为：
     make.top.mas_equalTo(navTitle.mas_bottom).offset(backView.frame.size.height/IMAGE_HEIGHT *（50.5）);
     
     相应的 ：密码的也改为 30.5
     
     [self.passwordTF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userTF.mas_bottom).offset(backView.frame.size.height/IMAGE_HEIGHT *（30.5）);
        make.left.mas_equalTo(self.userTF.mas_left);
        make.right.mas_equalTo(self.userTF.mas_right);
        make.height.mas_equalTo(self.userTF.mas_height);
    }];
