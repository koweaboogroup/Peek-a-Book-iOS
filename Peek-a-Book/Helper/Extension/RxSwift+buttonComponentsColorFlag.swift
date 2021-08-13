//
//  RxCocoa+buttonComponentsColorFlag.swift
//  Peek-a-Book
//
//  Created by Yossan Sandi Rahmadi on 06/08/21.
//

import RxSwift

extension Reactive where Base : UIButton {
   public var buttonComponentsColorFlag : Binder<Bool> {
        return Binder(self.base) { button, valid in
            button.tintColor = valid ? Constant.Color.primary1 : .lightGray
            button.setTitleColor(valid ? Constant.Color.primary1 : .lightGray, for: .normal)
        }
    }
}
