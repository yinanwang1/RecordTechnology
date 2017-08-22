//
//  TLSpringFlowLayout.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2016/10/8.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit

let kScrollResistanceFactorDefault:Float = 900.0;

class TLSpringFlowLayout: UICollectionViewFlowLayout
{
    public var scrollResistanceFactor:Float = 0.0;
    public var dynamicAnimator:UIDynamicAnimator?;
    
    fileprivate var visibleIndexPathsSet:Set<IndexPath> = [];
    fileprivate var visibleHeaderAndFooterSet:Set<IndexPath> = [];
    fileprivate var latestDelta:Float = 0.0;
    fileprivate var interfaceOrientation:UIInterfaceOrientation = UIInterfaceOrientation.unknown;
    
    
    // MARK: - Lifecycle Methods
    
    override init() {
        super.init()
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    // MARK: - Override Methods
    
    override func prepare() {
        super.prepare()
        
        if self.interfaceOrientation != UIApplication.shared.statusBarOrientation {
            self.dynamicAnimator?.removeAllBehaviors()
            self.visibleIndexPathsSet = []
        }
        
        self.interfaceOrientation = UIApplication.shared.statusBarOrientation
        
        let rect = CGRect.init(origin: (self.collectionView?.bounds.origin)!, size: (self.collectionView?.frame.size)!)
        let visibleRect = rect.insetBy(dx: -100, dy: -100)
        
        let itemsInVisibleRectArray = super.layoutAttributesForElements(in: visibleRect)
        
        var itemsIndexPathsInVisibleRectSet:Set<NSIndexPath> = []
        for item in itemsInVisibleRectArray! {
            itemsIndexPathsInVisibleRectSet.insert(item.indexPath as NSIndexPath)
        }
        
        var noLongerVisibleBehaviours:[UIAttachmentBehavior] = []
        for behaviour in (self.dynamicAnimator?.behaviors)! {
            let item = (behaviour as! UIAttachmentBehavior).items.first as! UICollectionViewLayoutAttributes
            
            if (itemsIndexPathsInVisibleRectSet.contains(item.indexPath as NSIndexPath) == false) {
                noLongerVisibleBehaviours.append((behaviour as! UIAttachmentBehavior))
            }
        }
        
        
        for obj in noLongerVisibleBehaviours {
            self.dynamicAnimator?.removeBehavior(obj)
            let behavior = obj 
            let item = behavior.items.first as! UICollectionViewLayoutAttributes
            self.visibleIndexPathsSet.remove(item.indexPath)
            self.visibleHeaderAndFooterSet.remove(item.indexPath)
        }
        
        var newlyVisibleItems:[UICollectionViewLayoutAttributes] = []
        for item in itemsInVisibleRectArray! {
            
            var result = false
            
            
            if item.representedElementCategory == UICollectionElementCategory.cell {
                result = self.visibleIndexPathsSet.contains(item.indexPath)
            } else {
                result = (false == self.visibleHeaderAndFooterSet.contains(item.indexPath))
            }
            
            if !result {
                newlyVisibleItems.append(item)
            }
        }
        
        let touchLocation = collectionView?.panGestureRecognizer.location(in: collectionView)
        
        for item in newlyVisibleItems {
            var center = item.center
            let springBehaviour = UIAttachmentBehavior.init(item: item, attachedToAnchor: center)
            
            springBehaviour.length = 1.0
            springBehaviour.damping = 0.8
            springBehaviour.frequency = 1.0
            
            if !__CGPointEqualToPoint(CGPoint.zero, touchLocation!) {
                if scrollDirection == UICollectionViewScrollDirection.vertical {
                    let distanceFromTouch = fabsf(Float(touchLocation!.y) - Float(springBehaviour.anchorPoint.y))
                    
                    var scrollResistance:Float = 0.00
                    if 0.00 < scrollResistanceFactor {
                        scrollResistance = distanceFromTouch / scrollResistanceFactor
                    } else {
                        scrollResistance = distanceFromTouch / kScrollResistanceFactorDefault
                    }
                    
                    if 0 > latestDelta {
                        center.y += CGFloat(max(latestDelta, latestDelta * scrollResistance))
                    } else {
                        center.y += CGFloat(min(latestDelta, latestDelta * scrollResistance))
                    }
                    
                    item.center = center
                } else {
                    let distanceFromTouch = fabsf(Float(touchLocation!.x) - Float(springBehaviour.anchorPoint.x))
                    
                    var scrollResistance:Float = 0.00
                    if 0.00 < scrollResistanceFactor {
                        scrollResistance = distanceFromTouch / scrollResistanceFactor
                    } else {
                        scrollResistance = distanceFromTouch / kScrollResistanceFactorDefault
                    }
                    
                    if 0 > latestDelta {
                        center.x += CGFloat(max(latestDelta, latestDelta * scrollResistance))
                    } else {
                        center.x += CGFloat(min(latestDelta, latestDelta * scrollResistance))
                    }
                    
                    item.center = center
                }
            }
            
            self.dynamicAnimator?.addBehavior(springBehaviour)
            
            if item.representedElementCategory == UICollectionElementCategory.cell {
                self.visibleIndexPathsSet.insert(item.indexPath)
            } else {
                self.visibleHeaderAndFooterSet.insert(item.indexPath)
            }
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.dynamicAnimator?.items(in: rect) as! [UICollectionViewLayoutAttributes]?
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let dynamicLayoutAttributes = self.dynamicAnimator?.layoutAttributesForCell(at: indexPath)
        
        return (nil != self.dynamicAnimator) ? (dynamicLayoutAttributes) : (super.layoutAttributesForItem(at: indexPath));
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let scrollView = self.collectionView
        var delta:CGFloat = 0.0
        if UICollectionViewScrollDirection.vertical == self.scrollDirection {
            delta = newBounds.origin.y - (scrollView?.bounds.origin.y)!;
        } else {
            delta = newBounds.origin.x - (scrollView?.bounds.origin.x)!;
        }
        
        self.latestDelta = Float(delta)
        
        let touchLocation = self.collectionView?.panGestureRecognizer.location(in: self.collectionView)
        
        for springBehaviour in (self.dynamicAnimator?.behaviors)! {
            if UICollectionViewScrollDirection.vertical == self.scrollDirection {
                let distanceFromTouch = fabsf(Float(touchLocation!.y) - Float((springBehaviour as! UIAttachmentBehavior).anchorPoint.y))
                
                var scrollResistance:Float = 0.0
                if 0.0 < self.scrollResistanceFactor {
                    scrollResistance = distanceFromTouch / self.scrollResistanceFactor
                } else {
                    scrollResistance = distanceFromTouch / kScrollResistanceFactorDefault
                }
                
                let item:UICollectionViewLayoutAttributes = (springBehaviour as! UIAttachmentBehavior).items.first as! UICollectionViewLayoutAttributes
                var center = item.center
                if 0 > delta {
                    center.y += max(delta, CGFloat(Float(delta) * scrollResistance))
                } else {
                    center.y += min(delta, CGFloat(Float(delta) * scrollResistance))
                }
                
                item.center = center
                
                self.dynamicAnimator?.updateItem(usingCurrentState: item)
                
            } else {
                let distanceFromTouch = fabsf(Float(touchLocation!.x) - Float((springBehaviour as! UIAttachmentBehavior).anchorPoint.x))
                
                var scrollResistance:Float = 0.0
                if 0.0 < self.scrollResistanceFactor {
                    scrollResistance = distanceFromTouch / self.scrollResistanceFactor
                } else {
                    scrollResistance = distanceFromTouch / kScrollResistanceFactorDefault
                }
                
                let item:UICollectionViewLayoutAttributes = (springBehaviour as! UIAttachmentBehavior).items.first as! UICollectionViewLayoutAttributes
                var center = item.center
                if 0 > delta {
                    center.x += max(delta, CGFloat(Float(delta) * scrollResistance))
                } else {
                    center.x += min(delta, CGFloat(Float(delta) * scrollResistance))
                }
                
                item.center = center
                
                self.dynamicAnimator?.updateItem(usingCurrentState: item)
            }
        }
        
        
        return false
    }
    
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        
        for updateItem in updateItems {
            if UICollectionUpdateAction.insert == updateItem.updateAction {
                if ((self.dynamicAnimator?.layoutAttributesForCell(at: updateItem.indexPathAfterUpdate!)) != nil) {
                    return;
                }
                
                let attributes = UICollectionViewLayoutAttributes.init(forCellWith: updateItem.indexPathAfterUpdate!)
                
                let springBehaviour = UIAttachmentBehavior.init(item: attributes, attachedToAnchor: attributes.center)
                
                springBehaviour.length = 1.0
                springBehaviour.damping = 0.8
                springBehaviour.frequency = 1.0
                
                self.dynamicAnimator?.addBehavior(springBehaviour)
            }
        }
    }
    
    
    // MARK: - Initial Methods
    func setup() {
        self.dynamicAnimator = UIDynamicAnimator.init(collectionViewLayout: self)
    }
    
    
}
