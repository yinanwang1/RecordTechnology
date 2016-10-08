//
//  TLSpringFlowLayout.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2016/10/8.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit

let kScrollResistanceFactorDefault = 900.0;

class TLSpringFlowLayout: UICollectionViewFlowLayout
{
    public var scrollResistanceFactor:Double = 0.0;
    public var dynamicAnimator:UIDynamicAnimator?;
    
    fileprivate var visibleIndexPathsSet:Set<IndexPath> = [];
    fileprivate var visibleHeaderAndFooterSet:Set<IndexPath> = [];
    fileprivate var latestDelta:Double = 0.0;
    fileprivate var interfaceOrientation:UIInterfaceOrientation = UIInterfaceOrientation.unknown;
    
    
    // MARK: - Lifecycle Methods
    
    override init() {
        super.init()
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func prepare() {
        super.prepare()
        
        if interfaceOrientation != UIApplication.shared.statusBarOrientation {
            dynamicAnimator?.removeAllBehaviors()
//            visibleIndexPathsSet.
        }
    }
    
    
    // MARK: - Initial Methods
    func setup() {
        dynamicAnimator = UIDynamicAnimator.init(collectionViewLayout: self)
    }
    
    
}
