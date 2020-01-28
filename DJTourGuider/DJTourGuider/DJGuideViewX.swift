//
//  DJGuideViewX.swift
//  DJGuideViewPOC
//
//  Created by D2k on 20/04/19.
//  Copyright © 2019 Dilip Jangid. All rights reserved.
//

import Foundation
import UIKit

//
//  TourGuide.swift
//  ELS

// MARK: - Extension
public extension UIView {
    
    // MARK: - Custom Methods
    public func addUserGuideWith(components: [(Componenet: UIView, location: TourGuideLocation, message: String)]) {
        var array = components
        var itemIndex = 0
        //        UIView.animate(withDuration: 0.2) {
        //            self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        //        }
        
        var isActionDone = false {
            didSet {
                //                UIView.animate(withDuration: 0.2) {
                //                    self.transform = .identity
                //                }
                
                if isActionDone {
                    itemIndex += 1
                    guard itemIndex < components.count else {
                        return
                    }
                    
                    let colors = TourColors(textColor: .red, textBGColor: .black, buttonBGColor: .orange, buttonTintColor: .black, circleColor: .orange)
                    let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                    let button = UIButton(type: .system) as UIButton
                    let tailView = UIView()
                    let triangleView = TriangleView()
                    drawContainerView(containerView: containerView, colors: colors)
                    drawLabel(message: array[itemIndex].message, label: label, colors: colors, containerView: containerView)
                    drawTailView(tailView: tailView, colors: colors, triangleView: triangleView, direction: array[itemIndex].location)
                    drawOKButton(button: button, colors: colors, isLast: false) { (_) in
                        isActionDone = true
                    }
                    self.addConstraintsToLabelAndButton(label: label, button: button, tailView: tailView, containerView: containerView, location: array[itemIndex].location, leadingAnchorInPercent: 0, component: components[itemIndex].Componenet)
                } else {
                    
                }
            }
        }
        
        let colors = TourColors(textColor: .red, textBGColor: .black, buttonBGColor: .orange, buttonTintColor: .black, circleColor: .orange)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let button = UIButton(type: .system) as UIButton
        let tailView = UIView()
        let triangleView = TriangleView()
        drawContainerView(containerView: containerView, colors: colors)
        drawLabel(message: array[itemIndex].message, label: label, colors: colors, containerView: containerView)
        drawTailView(tailView: tailView, colors: colors, triangleView: triangleView, direction: array[itemIndex].location)
        drawOKButton(button: button, colors: colors, isLast: false) { (_) in
            isActionDone = true
        }
        self.addConstraintsToLabelAndButton(label: label, button: button, tailView: tailView, containerView: containerView, location: array[itemIndex].location, leadingAnchorInPercent: 0, component: components[itemIndex].Componenet)
    }
    
    /// This method adds a tour view to your object of UIView
    ///
    /// - Parameters:
    ///   - message: Message to show
    ///   - location: Direction in which tour view will apears
    ///   - colors: Colors to Tour View, it's optional
    ///   - VC: Provide Self
    ///   - isLast: If it is True than SKIP Button will be removed from ViewController
    ///   - callBack: It return True always after OK button clicked, Developer may perform aditional task.
    public func addUserGuideWith(message: String, location: TourGuideLocation, isLast:Bool = false, leadingAnchorInPercent: CGFloat = 0, callBack:@escaping(_ isOKTapped: Bool)->Void) {
        
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }
        var isActionDone = false {
            didSet {
                UIView.animate(withDuration: 0.2) {
                    self.transform = .identity
                }
                
                if isActionDone {
                    callBack(true)
                } else {
                    callBack(false)
                }
            }
        }
        //        UIColor(hex: "3b5998")
        let colors = TourColors(textColor: .red, textBGColor: .black, buttonBGColor: .orange, buttonTintColor: .black, circleColor: .orange)
        //        let colors = TourColors(textColor: UIColor(hex: "231F20") , textBGColor: UIColor(hex: "E6E7E8"), buttonBGColor: .orange, buttonTintColor: .white, circleColor: .orange)
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let button = UIButton(type: .system) as UIButton
        //        let tailView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        //        let triangleView = TriangleView(frame: tailView.bounds)
        let tailView = UIView()
        let triangleView = TriangleView()
        drawContainerView(containerView: containerView, colors: colors)
        drawLabel(message: message, label: label, colors: colors, containerView: containerView)
        drawTailView(tailView: tailView, colors: colors, triangleView: triangleView, direction: location)
        drawOKButton(button: button, colors: colors, isLast: isLast) { (_) in
            isActionDone = true 
        }
        self.addConstraintsToLabelAndButton(label: label, button: button, tailView: tailView, containerView: containerView, location: location, leadingAnchorInPercent: leadingAnchorInPercent)
    }
    
    func drawContainerView(containerView: UIView, colors:TourColors){
        containerView.tag = 1003
        containerView.backgroundColor = colors.textBGColor
        containerView.layer.cornerRadius = 10
        
        //        let bgView = UIView()
        //        bgView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        //        bgView.tag = 999
        //        bgView.frame = CGRect(x: 0, y: 0, width: Screen.ScreenWidth, height: Screen.ScreenHeight)
        //        rootVC().view.addSubview(bgView)
        rootVC().view.addSubview(containerView)
        //        rootVC().view.insertSubview(containerView, at: 1)
    }
    
    private func drawLabel(message:String, label:UILabel, colors:TourColors, containerView:UIView) {
        label.tag = 1001
        label.textColor =  colors.textColor
        label.text = message
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = colors.textBGColor
        containerView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
        label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
    }
    
    func drawTailView(tailView:UIView, colors:TourColors, triangleView:TriangleView, direction: TourGuideLocation) {
        var width = 0
        var height = 0
        if direction == TourGuideLocation.Bottom || direction == TourGuideLocation.Top {
            //            width = direction == .Top ? 10 : 20
            //            height = direction == .Top ? 10 : 20
            width = 20
            height = 15
        } else {
            //            width = direction == .MiddleLeft || direction == .MiddleRight ? 10 : 20
            //            height = direction == .CenterBottom || direction == .CenterTop ? 10 : 20
            
            width = 10
            height = 20
        }
        
        tailView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        tailView.tag = 1004
        tailView.backgroundColor = .clear
        triangleView.frame = tailView.frame
        triangleView.needleColor = colors.textBGColor!
        triangleView.backgroundColor = .clear
        tailView.addSubview(triangleView)
        rootVC().view.addSubview(tailView)
        tailView.translatesAutoresizingMaskIntoConstraints = false
        triangleView.direction = direction
        
        let widthConstraint = NSLayoutConstraint(item: tailView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: CGFloat(width))
        let heightConstraint = NSLayoutConstraint(item: tailView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: CGFloat(height))
        NSLayoutConstraint.activate([widthConstraint, heightConstraint])
    }
    
    func drawOKButton(button:UIButton, colors:TourColors, isLast:Bool, callBack:@escaping(Bool)->Void) {
        button.tag = 1002
        button.backgroundColor = UIColor.clear
        //        button.setTitle("OK!", for: .normal)
        button.setTitleColor(colors.buttonTintColor, for: .normal)
        button.addAction(for: .touchUpInside) {
            self.didTappedOk(isLast: isLast, callBack: { (isActionDone) in
                callBack(isActionDone)
            })
        }
        button.layer.cornerRadius = 5
        button.frame = rootVC().view.frame
        button.center = rootVC().view.center
        rootVC().view.addSubview(button)
        //        UIDevice.vibrate()
        //        let generator = UIImpactFeedbackGenerator(style: .light)
        //        generator.impactOccurred()
    }
    
    func addConstraintsToLabelAndButton(label:UILabel, button:UIButton, tailView:UIView, containerView:UIView, location:TourGuideLocation, leadingAnchorInPercent: CGFloat, component: UIView) {
        label.translatesAutoresizingMaskIntoConstraints = false
        tailView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        switch location {
        case .MiddleLeft:
            tailView.trailingAnchor.constraint(equalTo: component.leadingAnchor, constant: -8).isActive = true
            tailView.centerYAnchor.constraint(equalTo: component.centerYAnchor).isActive = true
            
            containerView.trailingAnchor.constraint(equalTo: tailView.leadingAnchor).isActive = true
            containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
            containerView.centerYAnchor.constraint(equalTo: component.centerYAnchor).isActive = true
            
        case .MiddleRight:
            tailView.leadingAnchor.constraint(equalTo: component.trailingAnchor, constant: 8).isActive = true
            tailView.centerYAnchor.constraint(equalTo: component.centerYAnchor).isActive = true
            
            containerView.leadingAnchor.constraint(equalTo: tailView.trailingAnchor).isActive = true
            containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
            containerView.centerYAnchor.constraint(equalTo: component.centerYAnchor).isActive = true
            
            /*case .CenterTop:
             let labelWidth = getLabelFrameCGSize(label: label).width
             tailView.bottomAnchor.constraint(equalTo: component.topAnchor).isActive = true
             tailView.centerXAnchor.constraint(equalTo: component.centerXAnchor).isActive = true
             containerView.bottomAnchor.constraint(equalTo: tailView.topAnchor).isActive = true
             containerView.centerXAnchor.constraint(equalTo: tailView.centerXAnchor).isActive = true
             
             if labelWidth > rootVC().view.frame.width * 0.8 {
             containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
             containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
             } else if component.center.x <= rootVC().view.center.x {
             if labelWidth > component.frame.width * 0.8 {
             containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
             }
             } else {
             if labelWidth > component.frame.width * 0.8 {
             containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
             }
             }
             
             //            Running Code with simple Center alignment of container view
             //            tailView.bottomAnchor.constraint(equalTo: component.topAnchor, constant: -8).isActive = true
             //            tailView.centerXAnchor.constraint(equalTo: component.centerXAnchor).isActive = true
             //
             //            containerView.bottomAnchor.constraint(equalTo: tailView.topAnchor).isActive = true
             //            containerView.centerXAnchor.constraint(equalTo: tailView.centerXAnchor).isActive = true
             
             case .CenterBottom:
             //            tailView.frame.origin.y = component.frame.height + 8
             //            tailView.center.x = component.center.x
             ////            tailView.frame.origin.x = component.frame.origin.x + component.frame.width/2 - 10
             //
             //            containerView.frame.origin.y = tailView.frame.origin.y + tailView.frame.height
             //            containerView.center.x = tailView.center.x
             //            rootVC().view.addSubview(tailView)
             //            rootVC().view.addSubview(containerView)
             let labelWidth = getLabelFrameCGSize(label: label).width
             tailView.topAnchor.constraint(equalTo: component.bottomAnchor, constant: 8).isActive = true
             tailView.centerXAnchor.constraint(equalTo: component.centerXAnchor).isActive = true
             containerView.topAnchor.constraint(equalTo: tailView.bottomAnchor).isActive = true
             containerView.centerXAnchor.constraint(equalTo: tailView.centerXAnchor).isActive = true
             
             
             if labelWidth > rootVC().view.frame.width * 0.8 {
             containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
             containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
             } else if component.center.x <= rootVC().view.center.x {
             if labelWidth > component.frame.width * 0.8 {
             containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
             }
             } else {
             if labelWidth > component.frame.width * 0.8 {
             containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
             }
             }*/
            
        case .Top:
            let labelWidth = getLabelFrameCGSize(label: label).width
            tailView.bottomAnchor.constraint(equalTo: component.topAnchor, constant: -8).isActive = true
            containerView.bottomAnchor.constraint(equalTo: tailView.topAnchor).isActive = true
            
            if labelWidth > rootVC().view.frame.width * 0.8 {
                containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
                containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
                tailView.centerXAnchor.constraint(equalTo: component.centerXAnchor).isActive = true
            } else if component.center.x <= rootVC().view.center.x {
                if hasSpace(component, labelWidth) {
                    containerView.leadingAnchor.constraint(equalTo: component.leadingAnchor).isActive = true
                    tailView.leadingAnchor.constraint(equalTo: component.leadingAnchor, constant: 8).isActive = true
                } else {
                    containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
                    tailView.centerXAnchor.constraint(equalTo: component.centerXAnchor).isActive = true
                }
            } else {
                if hasSpace(component, labelWidth) {
                    containerView.trailingAnchor.constraint(equalTo: component.trailingAnchor).isActive = true
                    tailView.trailingAnchor.constraint(equalTo: component.trailingAnchor, constant: -8).isActive = true
                } else {
                    containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
                    tailView.centerXAnchor.constraint(equalTo: component.centerXAnchor).isActive = true
                }
            }
            
        case .Bottom:
            
            let labelWidth = getLabelFrameCGSize(label: label).width
            tailView.topAnchor.constraint(equalTo: component.bottomAnchor, constant: 8).isActive = true
            containerView.topAnchor.constraint(equalTo: tailView.bottomAnchor).isActive = true
            
            if labelWidth > rootVC().view.frame.width * 0.8 {
                containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
                containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
                tailView.centerXAnchor.constraint(equalTo: component.centerXAnchor).isActive = true
            } else if component.center.x <= rootVC().view.center.x {
                if hasSpace(component, labelWidth) {
                    containerView.leadingAnchor.constraint(equalTo: component.leadingAnchor).isActive = true
                    tailView.leadingAnchor.constraint(equalTo: component.leadingAnchor, constant: 8).isActive = true
                } else {
                    containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
                    tailView.centerXAnchor.constraint(equalTo: component.centerXAnchor).isActive = true
                }
            } else {
                if hasSpace(component, labelWidth) {
                    containerView.trailingAnchor.constraint(equalTo: component.trailingAnchor).isActive = true
                    tailView.trailingAnchor.constraint(equalTo: component.trailingAnchor, constant: -8).isActive = true
                } else {
                    containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
                    tailView.centerXAnchor.constraint(equalTo: component.centerXAnchor).isActive = true
                }
            }
            
            /*let labelWidth = getLabelFrameCGSize(label: label).width
             tailView.topAnchor.constraint(equalTo: component.bottomAnchor, constant: 8).isActive = true
             tailView.centerXAnchor.constraint(equalTo: component.centerXAnchor).isActive = true
             containerView.topAnchor.constraint(equalTo: tailView.bottomAnchor).isActive = true
             
             if labelWidth > rootVC().view.frame.width * 0.8 {
             containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
             containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
             } else if component.center.x == rootVC().view.center.x {
             let margin = (rootVC().view.frame.width - labelWidth) / 2
             containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: margin).isActive = true
             } else if component.center.x < rootVC().view.center.x {
             containerView.leadingAnchor.constraint(equalTo: component.leadingAnchor, constant: 0).isActive = true
             } else {
             containerView.trailingAnchor.constraint(equalTo: component.trailingAnchor, constant: 0).isActive = true
             }*/
            
            //            } else if component.center.x <= rootVC().view.center.x {
            //                //                 containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
            //                if labelWidth > component.frame.width * 0.8 {
            //                    containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
            //                } else { // 07/19
            //
            //                }
            //            } else {
            //                if labelWidth > component.frame.width * 0.8 {
            //                    containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
            //                }
            //            }
        }
    }
    
    func hasSpace(_ component: UIView, _ labelWidth: CGFloat) -> Bool {
        let a = rootVC().view.frame.width
        let b = component.frame.minX
        var availableWidth = CGFloat(0)
        if component.center.x <= rootVC().view.center.x  {
            availableWidth = a - b
        } else {
            availableWidth = component.frame.maxX
        }
        
        if availableWidth > labelWidth {
            return true
        } else {
            return false
        }
        
    }
    
    func addConstraintsToLabelAndButton(label:UILabel, button:UIButton, tailView:UIView, containerView:UIView, location:TourGuideLocation, leadingAnchorInPercent: CGFloat) {
        label.translatesAutoresizingMaskIntoConstraints = false
        tailView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        switch location {
        case .MiddleLeft:
            tailView.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: -8).isActive = true
            tailView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
            containerView.trailingAnchor.constraint(equalTo: tailView.leadingAnchor).isActive = true
            containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
        case .MiddleRight:
            tailView.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8).isActive = true
            tailView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
            containerView.leadingAnchor.constraint(equalTo: tailView.trailingAnchor).isActive = true
            containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
            /*case .CenterTop:
             let labelWidth = getLabelFrameCGSize(label: label).width
             tailView.bottomAnchor.constraint(equalTo: self.topAnchor).isActive = true
             tailView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
             containerView.bottomAnchor.constraint(equalTo: tailView.topAnchor).isActive = true
             containerView.centerXAnchor.constraint(equalTo: tailView.centerXAnchor).isActive = true
             
             if labelWidth > rootVC().view.frame.width * 0.8 {
             containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
             containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
             } else if self.center.x <= rootVC().view.center.x {
             if labelWidth > self.frame.width * 0.8 {
             containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
             }
             } else {
             if labelWidth > self.frame.width * 0.8 {
             containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
             }
             }
             
             //            Running Code with simple Center alignment of container view
             //            tailView.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -8).isActive = true
             //            tailView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
             //
             //            containerView.bottomAnchor.constraint(equalTo: tailView.topAnchor).isActive = true
             //            containerView.centerXAnchor.constraint(equalTo: tailView.centerXAnchor).isActive = true
             
             case .CenterBottom:
             //            tailView.frame.origin.y = self.frame.height + 8
             //            tailView.center.x = self.center.x
             ////            tailView.frame.origin.x = self.frame.origin.x + self.frame.width/2 - 10
             //
             //            containerView.frame.origin.y = tailView.frame.origin.y + tailView.frame.height
             //            containerView.center.x = tailView.center.x
             //            rootVC().view.addSubview(tailView)
             //            rootVC().view.addSubview(containerView)
             let labelWidth = getLabelFrameCGSize(label: label).width
             tailView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 8).isActive = true
             tailView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
             containerView.topAnchor.constraint(equalTo: tailView.bottomAnchor).isActive = true
             containerView.centerXAnchor.constraint(equalTo: tailView.centerXAnchor).isActive = true
             
             
             if labelWidth > rootVC().view.frame.width * 0.8 {
             containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
             containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
             } else if self.center.x <= rootVC().view.center.x {
             if labelWidth > self.frame.width * 0.8 {
             containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
             }
             } else {
             if labelWidth > self.frame.width * 0.8 {
             containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
             }
             }
             */
        case .Top:
            let labelWidth = getLabelFrameCGSize(label: label).width
            tailView.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -8).isActive = true
            tailView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
            containerView.bottomAnchor.constraint(equalTo: tailView.topAnchor).isActive = true
            
            if labelWidth > rootVC().view.frame.width * 0.8 {
                containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
                containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
            } else if self.center.x <= rootVC().view.center.x {
                if labelWidth > self.frame.width * 0.8 {
                    containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
                }
            } else {
                if labelWidth > self.frame.width * 0.8 {
                    containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
                }
            }
            
        case .Bottom:
            let labelWidth = getLabelFrameCGSize(label: label).width
            tailView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 8).isActive = true
            tailView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: getLeadingAnchorValue(value: leadingAnchorInPercent)).isActive = true
            containerView.topAnchor.constraint(equalTo: tailView.bottomAnchor).isActive = true
            
            if labelWidth > rootVC().view.frame.width * 0.8 {
                containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
                containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
            } else if self.center.x <= rootVC().view.center.x {
                //                 containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
                if labelWidth > self.frame.width * 0.8 {
                    containerView.leadingAnchor.constraint(equalTo: rootVC().view.leadingAnchor, constant: 16).isActive = true
                } else { // 07/19
                    
                }
            } else {
                if labelWidth > self.frame.width * 0.8 {
                    containerView.trailingAnchor.constraint(equalTo: rootVC().view.trailingAnchor, constant: -16).isActive = true
                }
            }
        }
    }
    
    @available(iOS 11.0, *)
    func addSkipButton(callBack:@escaping()->Void) {
        let skipButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 60))
        skipButton.tag = 1005
        //        skipButton.layer.zPosition = 1//.greatestFiniteMagnitude
        skipButton.transform = CGAffineTransform(translationX: 1, y: 76) // for animation
        
        //        let window = UIApplication.shared.keyWindow!
        //        window.addSubview(skipButton);
        
        rootVC().view.addSubview(skipButton)
        skipButton.backgroundColor = UIColor.red
        skipButton.setTitle("SKIP", for: .normal)
        skipButton.setTitleColor(.white, for: .normal)
        
        skipButton.addAction(for: .touchUpInside) {
            self.didTappedSkip {
                self.rootVC().view.viewWithTag(1001)?.removeFromSuperview()
                self.rootVC().view.viewWithTag(1002)?.removeFromSuperview()
                self.rootVC().view.viewWithTag(1003)?.removeFromSuperview()
                self.rootVC().view.viewWithTag(1004)?.removeFromSuperview()
                self.rootVC().view.viewWithTag(1005)?.removeFromSuperview()
                callBack()
            }
        }
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            skipButton.bottomAnchor.constraint(equalTo: self.rootVC().view.bottomAnchor, constant: -16 - self.safeAreaInsets.bottom).isActive = true
        } else {
            // Fallback on earlier versions
            skipButton.bottomAnchor.constraint(equalTo: self.rootVC().view.bottomAnchor, constant: -16).isActive = true
        }
        skipButton.trailingAnchor.constraint(equalTo: self.rootVC().view.trailingAnchor, constant: -16).isActive = true
        let widthConstraint = NSLayoutConstraint(item: skipButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        NSLayoutConstraint.activate([widthConstraint])
        
        //        self.rootVC().view.bringSubview(toFront: skipButton)
        //        self.rootVC().view.insertSubview(skipButton, at: 1)
        
        // animation after constraint
        UIView.animate(withDuration: 0.8, delay: 2.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            skipButton.transform = .identity
        }) { (isDone) in
            // do the rest
        }
    }
    
    // MARK: - Utility Methods
    
    func getLabelFrameCGSize(label:UILabel)->CGSize {
        return label.intrinsicContentSize
    }
    
    func getViewFrameCGSize(view:UIView)->CGSize {
        return view.intrinsicContentSize
    }
    
    func rootVC()-> UIViewController {
        //        if let currentVC = UIApplication.shared.windows[0].rootViewController!.presentedViewController {
        //            return currentVC
        //        } else {
        //            return UIApplication.shared.windows[0].rootViewController!
        //        }
        
        if let topViewController = UIApplication.shared.windows[0].rootViewController?.children.last {
            return topViewController
        } else {
            return UIApplication.shared.windows[0].rootViewController!
        }
    }
    
    /*func rootVC() -> UIViewController {
     if let navigationController = getNavigationController() {
     return navigationController.children.last!
     } else if let rootController = UIApplication.shared.keyWindow?.rootViewController {
     var currentVC = rootController
     while(rootController.presentedViewController != nil) {
     currentVC = rootController.presentedViewController!
     }
     return currentVC
     } else if let topViewController = UIApplication.shared.windows[0].rootViewController?.children.last {
     return topViewController
     } else {
     return UIApplication.shared.windows[0].rootViewController!
     }
     }*/
    
    func getNavigationController() -> UINavigationController? {
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController {
            return navigationController as? UINavigationController
        }
        return nil
    }
    
    
    
    func getLeadingAnchorValue(value: CGFloat)-> CGFloat {
        return self.frame.width * (value/100)
    }
    
    //    func removeUserGuide(){
    //        let subViews = rootVC().view.subviews
    //        for view in subViews {
    //            switch view.tag {
    //            case 1001, 1002, 1003, 1004, 1005:
    //                view.removeFromSuperview()
    //            default:
    //                break
    //            }
    //        }
    //    }
    
    // MARK: - @objc func
    func didTappedOk(isLast:Bool, callBack:@escaping(Bool)->Void) {
        let subViews = rootVC().view.subviews
        for view in subViews {
            switch view.tag {
            case 999, 1001, 1002, 1003, 1004:
                view.layer.opacity = 0.3
                UIView.animate(withDuration: 0.14, animations: {
                    view.layer.opacity = 0
                    view.transform = CGAffineTransform(scaleX: 2, y: 2)
                }) { (_) in
                    view.transform = .identity
                    view.removeFromSuperview()
                }
            case 1005:
                if isLast {
                    //                    let window = UIApplication.shared.keyWindow!
                    //                    window.viewWithTag(1005)?.removeFromSuperview()
                    view.layer.opacity = 0.3
                    UIView.animate(withDuration: 0.14, animations: {
                        view.layer.opacity = 0
                        view.transform = CGAffineTransform(scaleX: 2, y: 2)
                    }) { (_) in
                        view.transform = .identity
                        view.removeFromSuperview()
                    }
                }
            default:
                break
            }
        }
        if isLast {
            let window = UIApplication.shared.keyWindow!
            window.viewWithTag(1005)?.removeFromSuperview()
        }
        callBack(true)
    }
    
    @objc public func didTappedSkip(callBack:@escaping()->Void) {
        let subViews = rootVC().view.subviews
        for view in subViews {
            switch view.tag {
            case 999, 1001, 1002, 1003, 1004:
                view.layer.opacity = 0.3
                UIView.animate(withDuration: 0.14, animations: {
                    view.layer.opacity = 0
                    view.transform = CGAffineTransform(scaleX: 2, y: 2)
                }) { (_) in
                    view.transform = .identity
                    view.removeFromSuperview()
                }
            default:
                break
            }
        }
        callBack()
    }
}

public struct TourColors {
    var textColor:UIColor?
    var textBGColor:UIColor?
    var buttonBGColor:UIColor?
    var buttonTintColor:UIColor?
    var circleColor:UIColor?
    
    init(textColor:UIColor, textBGColor:UIColor, buttonBGColor:UIColor, buttonTintColor:UIColor, circleColor:UIColor) {
        self.textColor = textColor
        self.textBGColor = textBGColor
        self.buttonBGColor = buttonBGColor
        self.buttonTintColor = buttonTintColor
        self.circleColor = circleColor
    }
}

public enum TourGuideLocation: Int {
    //    case CenterTop = 0
    //    case CenterBottom
    case MiddleLeft = 0
    case MiddleRight
    case Top
    case Bottom
}

@IBDesignable
public class TriangleView: UIView {
    
    @IBInspectable var needleColor: UIColor = UIColor(red: 18/255.0, green: 112/255.0, blue: 178/255.0, alpha: 1.0)
    @IBInspectable var isRightArrow: Bool = false
    var direction: TourGuideLocation = TourGuideLocation.MiddleLeft
    @IBInspectable var needleValue: CGFloat = 00 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK:- UIView Draw method
    override public func draw(_ rect: CGRect) {
        layer.sublayers = []
        drawNeedle()
    }
    
    public func drawNeedle() {
        // 1
        let triangleLayer = CAShapeLayer()
        //        let shadowLayer = CAShapeLayer()
        
        // 2
        triangleLayer.frame = bounds
        //        shadowLayer.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y + 5, width: bounds.width, height: bounds.height)
        
        // 3
        let needlePath = UIBezierPath()
        //        if isRightArrow {
        //            needlePath.move(to: CGPoint(x: 0, y: self.bounds.height))
        //            needlePath.addLine(to: CGPoint(x: self.bounds.width * 0.5, y: 0))
        //            needlePath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        //            needlePath.close()
        //        } else {
        //            //isLeftArrow
        //            needlePath.move(to: CGPoint(x: 0, y: 0))
        //            needlePath.addLine(to: CGPoint(x: self.bounds.width * 0.5, y: self.bounds.height))
        //            needlePath.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        //            needlePath.close()
        //        }
        
        switch direction {
        case .Top: //CenterTop
            needlePath.move(to: CGPoint(x: 0, y: 0))
            needlePath.addLine(to: CGPoint(x: self.bounds.width * 0.5, y: self.bounds.height))
            needlePath.addLine(to: CGPoint(x: self.bounds.width, y: 0))
            needlePath.close()
            break
        case .Bottom: //CenterBottom
            needlePath.move(to: CGPoint(x: 0, y: self.bounds.height))
            needlePath.addLine(to: CGPoint(x: self.bounds.width * 0.5, y: 0))
            needlePath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
            needlePath.close()
            break
        case .MiddleLeft:
            needlePath.move(to: CGPoint(x: 0, y: 0))
            needlePath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height * 0.5))
            needlePath.addLine(to: CGPoint(x: 0, y: self.bounds.height))
            needlePath.close()
            break
        case .MiddleRight:
            needlePath.move(to: CGPoint(x: self.bounds.width, y: 0))
            needlePath.addLine(to: CGPoint(x: 0, y: self.bounds.height * 0.5))
            needlePath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
            needlePath.close()
            break
        }
        // 4
        triangleLayer.path = needlePath.cgPath
        //        shadowLayer.path = needlePath.cgPath
        
        // 5
        triangleLayer.fillColor = needleColor.cgColor
        triangleLayer.strokeColor = needleColor.cgColor
        //        shadowLayer.fillColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
        
        // 6
        //        layer.addSublayer(shadowLayer)
        layer.addSublayer(triangleLayer)
    }
}

extension UIControl {
    public func addAction(for controlEvents: UIControl.Event, _ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

class ClosureSleeve {
    let closure: ()->()
    
    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc public func invoke () {
        closure()
    }
}

extension UIColor {
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha:1)
    }
    
    convenience init(hex: String, alpha: CGFloat) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = String(hexWithoutSymbol.dropFirst())
        }
        
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt:UInt32 = 0x0
        scanner.scanHexInt32(&hexInt)
        
        var r:UInt32!, g:UInt32!, b:UInt32!
        switch (hexWithoutSymbol.count) {
        case 3: // #RGB
            r = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            g = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            b = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
            break;
        case 6: // #RRGGBB
            r = (hexInt >> 16) & 0xff
            g = (hexInt >> 8) & 0xff
            b = hexInt & 0xff
            break;
        default:
            // TODO:ERROR
            break;
        }
        
        self.init(
            red: (CGFloat(r)/255),
            green: (CGFloat(g)/255),
            blue: (CGFloat(b)/255),
            alpha:alpha)
    }
}
