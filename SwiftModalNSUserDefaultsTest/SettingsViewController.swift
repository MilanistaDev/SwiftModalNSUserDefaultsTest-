//
//  SettingsViewController.swift
//  SwiftModalNSUserDefaultsTest
//
//  Created by 麻生 拓弥 on 2014/12/22.
//  Copyright (c) 2014年 Takuya Aso. All rights reserved.
//

import UIKit

// UITextFieldDelegate を追加
class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var switchBtn: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // デリゲートを設定
        self.textField.delegate = self;
        
        self.main_method()
    }

    // メインメソッド
    func main_method() {
        
        // インスタンス生成
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // すでに設定でテキストフィールドに入力されている場合
        if defaults.objectForKey("TextField_Status") != nil {
            
            // キーに登録されている文字列を抽出，表示
            var value_string = defaults.objectForKey("TextField_Status") as? String
            self.textField.text = value_string
        }
        
        // UISwitch の値(初回起動など区別)
        // 初回起動時
        if defaults.objectForKey("Switch_Status") == nil {
            self.switchBtn.on = false // 初回起動 or 未設定
        } else {
            // キーに保存されているBOOL値を抽出，表示
            var value_switch = defaults.boolForKey("Switch_Status")
            if value_switch  {
                self.switchBtn.on = true
            } else {
                self.switchBtn.on = false
            }
        }
        
        // 値が変化(ユーザが変更)したら呼ばれる
        // Storyboardとヒモ付けする際指定してるのでいらないっぽい
        // テキストフィールド Ver
        textField.addTarget(self, action: "textFieldAction:", forControlEvents: UIControlEvents.EditingDidEnd)
        self.view.addSubview(textField)
        
        // UISwitch Ver
        switchBtn.addTarget(self, action: "switchAction:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(switchBtn)
    }
    
    @IBAction func textFieldAction(sender: AnyObject) {
        
        // インスタンス生成
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // TextFiled_Status というキーに入力された文字列を保存
        defaults.setObject(textField.text, forKey: "TextField_Status")
        
        // 値をすぐに更新
        defaults.synchronize()
    }
    
    @IBAction func switchAction(sender: AnyObject) {
        
        // インスタンス生成
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // スイッチがオンかオフか
        if switchBtn.on {
            // Switch_Status というキーにスイッチの状態を保存する
            defaults.setBool(true, forKey: "Switch_Status")
        } else {
            // Switch_Status というキーにスイッチの状態を保存する
            defaults.setBool(false, forKey: "Switch_Status")
        }
        // 値をすぐに更新する
        defaults.synchronize()
    }
    
    // Back ボタンを押したときに元の画面に遷移
    @IBAction func backAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    // キーボードを閉じる
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true);
        return false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
