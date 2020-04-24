//
//  ViewController.swift
//  SampleTask2
//
//  Created by MALLI on 21/04/20.
//  Copyright © 2020 MALLI. All rights reserved.
//

import UIKit
import Toast_Swift

//class keyCell: UICollectionViewCell{
//
//    override init(frame:CGRect){
//        super.init(frame:frame)
//        backgroundColor = .red
//    }
//
////
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}


class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate{
    
    
    var style1:ToastStyle!
//    fileprivate let cellId = "cellId"
    
    var numbers = ["1","2","3","4","5","6","7","8","9","","0","×"]
    
    
    
    
    @IBOutlet weak var textField1: UITextField!
    
    @IBOutlet weak var textField2: UITextField!
    
    
    @IBOutlet weak var textField3: UITextField!
    
    
    @IBOutlet weak var textField4: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.register(keyCell.self, forCellWithReuseIdentifier: "cellId")

        self.textField1.delegate = self
        self.textField2.delegate = self
        self.textField3.delegate = self
        self.textField4.delegate = self

//        numberPad.delegate = self
//        numberPad.dataSource = self
//
        
        style1 = ToastStyle()
        style1.backgroundColor = .red
        style1.messageColor = .white
        ToastManager.shared.style = style1
        
//        textField1.addTarget(self, action: #selector(self.textFieldDidChangeSelection(_:)), for: UIControl.Event.editingChanged)
//        textField2.addTarget(self, action: #selector(self.textFieldDidChangeSelection(_:)), for: UIControl.Event.editingChanged)
//        textField3.addTarget(self, action: #selector(self.textFieldDidChangeSelection(_:)), for: UIControl.Event.editingChanged)
//        textField4.addTarget(self, action: #selector(self.textFieldDidChangeSelection(_:)), for: UIControl.Event.editingChanged)
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! KeyCell
        
        cell.digitsLabel.text = numbers[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var number = numbers[indexPath.row]
        if number == "×"{
            if textField1.isEditing == true{
                textField1.text = ""

            }
            if textField2.isEditing == true{
                textField2.text = ""
                
            }
            if textField3.isEditing == true{
                textField3.text = ""
                
            }
            if textField4.isEditing == true{
                textField4.text = ""
            }
            
        }else{
        if textField1.isEditing == true{
            textField1.text = number
            number = ""
        }
        if textField2.isEditing == true{
            textField2.text = number
            number = ""
        }
        if textField3.isEditing == true{
            textField3.text = number
            number = ""
        }
        if textField4.isEditing == true{
            textField4.text = number
        }
        }
//        if textField1.text?.count != 0{
//            textField2.text = number
//            if textField2.text?.count != 0{
//                self.textField3.text = number
//                if textField3.text?.count != 0{
//                    textField4.text = number
//
//                }else{
//                textField3.text = number
//                }
//            }else{
//                self.textField2.text = number
//            }
////
//
//        }else{
//            self.textField1.text = number
//        }
           }
     
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField1.becomeFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text
        
        if text?.utf16.count == 1{
            switch textField {
            case textField1:
                textField2.becomeFirstResponder()
            case textField2:
                textField3.becomeFirstResponder()
            case textField3:
                textField4.becomeFirstResponder()
            case textField4:
            textField4.resignFirstResponder()
            default:
                break
                    
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        var TFshouldBeginEdit:Bool!
        if textField == textField1{
            TFshouldBeginEdit = true
        }else if textField == textField2{
            if textField1.text!.count == 1{
                TFshouldBeginEdit = true
            }else{

                
                self.view.makeToast("Please Enter Previous Value", duration: 1.0, position: ToastPosition.center, style: style1, completion: nil)
                
                TFshouldBeginEdit = false
            }
        }else if textField == textField3{
            if textField2.text!.count == 1{
                TFshouldBeginEdit = true
            }else{

                
                self.view.makeToast("Please Enter Previous Value", duration: 1.0, position: ToastPosition.center, style: style1, completion: nil)
                
                TFshouldBeginEdit = false
            }
        }else if textField == textField4{
            if textField3.text!.count == 1{
                TFshouldBeginEdit = true
            }else{

                
                self.view.makeToast("Please Enter Previous Value", duration: 1.0, position: ToastPosition.center, style: style1, completion: nil)
                
                TFshouldBeginEdit = false
            }
        }
        return TFshouldBeginEdit
    }
    

//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        <#code#>
//    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        <#code#>
//    }
//
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
    var expectingCharacters:Bool!
    if textField == textField1 || textField == textField2 || textField == textField3 || textField == textField4{
        var charactersShouldbe = CharacterSet(charactersIn: "0123456789")
        var typingCharacters = CharacterSet(charactersIn: string)
        var characters = charactersShouldbe.isSuperset(of: typingCharacters)
        expectingCharacters = characters
        
        
        if characters == false{
            
            self.view.makeToast("OTP should only have Numerics", duration: 1.0, position: .center, style: style1, completion: nil)
        }
    }
        return expectingCharacters
    }
    
    
    @IBAction func resendOTPButton(_ sender: Any) {
        
        print("Resend OTP Button has been tapped")
        
        self.view.makeToast("OTP has been sent", duration: 1.0, position: .center, style: style1, completion: nil)
        
        textField1.text = ""
        textField2.text = ""
        textField3.text = ""
        textField4.text = ""
        textField1.becomeFirstResponder()
    }
    
    
    
    @IBAction func OTPSubmitButton(_ sender: Any) {
        
        if textField1.text?.count == 1 && textField2.text?.count == 1 && textField3.text?.count == 1 && textField4.text?.count == 1{
        print("Login to Account Button has been tapped")
            
            self.view.makeToast("Login to Account", duration: 1.0, position: .center, style: style1, completion: nil)
        }else{
            print("Please Enter your OTP")
            
            self.view.makeToast("Please Enter your OTP", duration: 1.0, position: .center, style: style1, completion: nil)
        }
    }
    
    


}

