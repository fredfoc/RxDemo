//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by fauquette fred on 18/10/16.
//  Copyright © 2016 Agilys. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    enum MyError: Error {
        case subjectError
    }
    
    private let disposeBag = DisposeBag()
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var waitLabel: UILabel!
    @IBOutlet weak var tapMeButton: UIButton!
    
    private var tapOnButton:Observable<String>?
    
    private var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let subject = PublishSubject<String>()
        subject
            .subscribe(onNext: { (value) in print("value is \(value)") },
                       onError: { error in print("error")},
                       onCompleted: { print("completed")},
                       onDisposed: { print("disposed")})
            .addDisposableTo(disposeBag)
        
        subject.onNext("start")
        
        
        subject
            .map { (value) -> String in
                return "value is \(value)"
            }
            .bindTo(myLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        tapMeButton.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self] () in
                self?.count += 1
                if let count = self?.count {
                    if count == 10 {
                        subject.onError(MyError.subjectError)
                    } else {
                        subject.onNext("value : \(count)")
                    }
                    print("tap : \(count)")
                }
                
                },
                       onError: nil,
                       onCompleted: nil,
                       onDisposed: nil)
            .addDisposableTo(disposeBag)
        
    }
}

