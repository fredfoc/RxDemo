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
    }
}

