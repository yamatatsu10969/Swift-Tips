//
//  EmailTextField.swift
//  mommy
//
//  Created by Tatsuya Yamamoto on 2019/9/26.
//  Copyright © 2019 Pengagon. All rights reserved.
//

import UIKit

class EmailTextField: AppTextField {
  
  var error: String? {
    get {
      return validateSelf()
    }
  }
  
  func validateSelf() -> String? {
    guard let text = self.text else {
      return EmailError.empty.errorDescription
    }
    guard text.count > 0 else {
      return EmailError.empty.errorDescription
    }
    guard isValidEmail(text) else {
      return EmailError.format.errorDescription
    }
    return nil
  }
  
  func isValidEmail(_ string: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    let result = emailTest.evaluate(with: string)
    return result
  }
}

enum EmailError: Error {
  case empty
  case format
}

extension EmailError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .empty:
      return "メールアドレスを入力してください。"
    case .format:
      return "正しいメールアドレスを入力してください"
    }
  }
}
