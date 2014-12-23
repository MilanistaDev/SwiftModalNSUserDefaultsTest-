//
//  ViewController.swift
//  SwiftModalNSUserDefaultsTest
//
//  Created by 麻生 拓弥 on 2014/12/22.
//  Copyright (c) 2014年 Takuya Aso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stringLabel: UILabel!
    @IBOutlet weak var boolLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load関数で表示
        self.load()
    }
    
    // 設定画面から戻ったときに load 関数を呼ぶ
    override func viewWillAppear(animated: Bool) {
        
        // load関数で表示
        self.load()
    }
    
    func load() {
        
        // インスタンス生成
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // すでに設定でテキストフィールドに入力されている場合
        if defaults.objectForKey("TextField_Status") != nil {
            
            // キーに登録されている文字列を抽出，表示
            var value_string = defaults.objectForKey("TextField_Status") as? String
            self.stringLabel.text = value_string
        } else {
            self.stringLabel.text = "NO DATA" // 初回起動 or 未設定
        }
        
        // UISwitch の値(初回起動など区別)
        // 初回起動時
        if defaults.objectForKey("Switch_Status") == nil {
            self.boolLabel.text = "NO DATA" // 初回起動 or 未設定
        } else {
            // キーに保存されているBOOL値を抽出，表示
            var value_switch = defaults.boolForKey("Switch_Status")
            if value_switch  {
                self.boolLabel.text = "YES"
            } else {
                self.boolLabel.text = "NO"
            }
        }
    }
    
    // Settings ボタンが押されたとき modal_segue1 の遷移
    @IBAction func settingsAction(sender: AnyObject) {
        
        performSegueWithIdentifier("modal_segue1", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

