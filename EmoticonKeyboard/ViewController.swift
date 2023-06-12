//
//  ViewController.swift
//  EmoticonKeyboard
//
//  Created by mac on 2023/6/12.
//

import UIKit

let kScreenW = UIScreen.main.bounds.width

public func keyWindow() -> UIWindow? {
    if #available(iOS 13, *) {
        return UIApplication.shared.windows.first { $0.isKeyWindow }
    } else {
        return UIApplication.shared.keyWindow
    }
}
public final class PlistLoader {
    
    public static func loadPlist(name: String) -> [String: Any]? {
        guard let path = Bundle(for: self).path(forResource: name, ofType: "plist") else {
            return nil
        }
        return NSDictionary(contentsOfFile: path) as? [String: Any]
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        m_bottomView.m_replayBtn.addTarget(self, action: #selector(clickBottomReplyBtn), for: .touchUpInside)
        view.addSubview(m_bottomView)
        let bH = 50.0 + (keyWindow()?.safeAreaInsets.bottom ?? 0)
        m_bottomView.snp.makeConstraints { (make) in
 
            make.height.equalTo(bH)
            make.bottom.left.right.equalToSuperview()
        }
    }
    @objc func clickBottomReplyBtn(_ btn: UIButton) {
        
        KeyboardShowManager.shared.showKeyboardViewInView(self.view)
        KeyboardShowManager.shared.keyboardView.m_publish.addTarget(self, action: #selector(clickKeyBoardViewPublickBtn), for: .touchUpInside)
        KeyboardShowManager.shared.keyboardView.m_exBtn.addTarget(self, action: #selector(clickKeyBoardViewExBtn), for: .touchUpInside)

    }
    private lazy var emojiKeyboard = {
        
        let ev = EmojiKeyboardView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 221))
        
        ev.m_deleteClosure = {[weak self] in
            
            let textView = KeyboardShowManager.shared.keyboardView.m_textField
            textView.deleteBackward()

        }
        ev.m_insertEmojClosure = {[weak self] emoj in
            let myTextView = KeyboardShowManager.shared.keyboardView.m_textField
            myTextView.insertText(emoj)
             
        }
        
        return ev
    }()
    @objc func clickKeyBoardViewExBtn(_ btn: UIButton) {
        let tv =  KeyboardShowManager.shared.keyboardView.m_textField
 
        if tv.inputView == emojiKeyboard {
            KeyboardShowManager.shared.m_keyboardType = .system
            tv.inputView = nil
        } else {
            KeyboardShowManager.shared.m_keyboardType = .emoji
            tv.inputView = emojiKeyboard
        }
        tv.reloadInputViews()
    }
    @objc func clickKeyBoardViewPublickBtn(_ btn: UIButton) {
        
        KeyboardShowManager.shared.keyboardView.m_textField.resignFirstResponder()
    }
    lazy var m_bottomView: PostDetailBottomView = {
        
        let line = PostDetailBottomView()
        
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(hex: 0xFFFFFF)
        
        return line
    }()
}

