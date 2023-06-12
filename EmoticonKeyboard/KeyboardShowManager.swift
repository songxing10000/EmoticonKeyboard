//
//  KeyboardShowManager.swift
//  NewProjTest
//
//  Created by mac on 2023/6/9.
//

import Foundation


class KeyboardShowManager  {
    static let shared = KeyboardShowManager()
    private init() {}
    enum KeyboardType {
        case none // 不显示键盘
        case system // 显示系统键盘
        case emoji // 显示表情键盘
    }
    var m_keyboardType = KeyboardType.system
    func showKeyboardViewInView(_ aView:UIView){
        vcView = aView
        addKeyboardNote()
        
        guard let window = keyWindow() else { return }
        window.addSubview(maskView)
        maskView.addSubview(keyboardView)
        keyboardView.m_textField.becomeFirstResponder()
    }
    lazy var keyboardView = {
       let view = KeyboardView()
       view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMaxXMinYCorner]
       view.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height + keyboardViewHeight, width: kScreenW, height: keyboardViewHeight)
       return view
   }()
   
   private lazy var maskView = {
       let view = UIView()
       view.frame = UIScreen.main.bounds
       view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapKeyboardMaskView))
       view.addGestureRecognizer(tapGesture)
       return view
   }()
   
    @objc func tapKeyboardMaskView(_ gesture: UITapGestureRecognizer) {
        // 获取手势在父视图中的位置
        let location = gesture.location(in: maskView)
        
        
        // 判断手势位置是否在目标视图内
        if CGRectContainsPoint(keyboardView.frame, location) {
            
            // 在输入框那个view里
        } else {
            // 点在蒙板上
            m_keyboardType = .none
            keyboardView.m_textField.endEditing(true)
        }
    }
    var vcView = UIView()
    private let keyboardViewHeight: CGFloat = 140

     func addKeyboardNote() {
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShowNotification),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHideNotification),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    @objc func keyboardWillShowNotification(_ noti: Notification) {
        
        // 获得软键盘的高
        let keyboardSize = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let keyboardHeight = keyboardSize?.height ?? 0.0
        
        guard let duration = noti.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        
        let safeBottom: CGFloat = keyWindow()?.safeAreaInsets.bottom ?? 0
        UIView.animate(withDuration: duration) {
            
            self.keyboardView.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - self.keyboardViewHeight - keyboardHeight, width: kScreenW, height: self.keyboardViewHeight)
            
            
            self.maskView.alpha = 1
            self.maskView.isHidden = false
        }
    }
    
    @objc func keyboardWillHideNotification(_ notification: Notification) {
        
        
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let keyboardHeight = keyboardSize?.height ?? 0.0
 
        
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }

            UIView.animate(withDuration: duration) {
                
                self.keyboardView.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height+self.keyboardViewHeight, width: kScreenW, height: self.keyboardViewHeight)
 
                self.maskView.alpha = 0.001
            } completion: { finish in
                self.maskView.isHidden = true
            }
        
    }
    
}
