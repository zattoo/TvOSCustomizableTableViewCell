//
//  TvOSCustomizableTableViewCell.swift
//  TvOSCustomizableTableViewCell
//
//  Created by David Cordero on 02.09.16.
//  Copyright © 2016 Zattoo, Inc. All rights reserved.
//

import UIKit
import ZattooGradientView


open class TvOSCustomizableTableViewCell: UITableViewCell {

    @IBInspectable public var cornerRadius: CGFloat = 5.0
    @IBInspectable public var focusedScaleFactor: CGFloat = 1.08
    @IBInspectable public var focusedShadowRadius: CGFloat = 10
    @IBInspectable public var focusedShadowOpacity: Float = 0.25
    @IBInspectable public var shadowColor: CGColor = UIColor.black.cgColor
    @IBInspectable public var shadowOffSetFocused: CGSize = CGSize(width: 0, height: 27)
    @IBInspectable public var animationDuration: TimeInterval = 0.1
    @IBInspectable public var gradientStartPoint: CGPoint = CGPoint(x: 1, y: 0)
    @IBInspectable public var gradientEndPoint: CGPoint = .zero
    
    @IBInspectable public var selectedBackgroundColor: UIColor = .clear {
        didSet { updateSelectedBackgroundColor() }
    }

    @IBInspectable public var focusedBackgroundColor: UIColor = .gray {
        didSet { updateBackgroundColor() }
    }

    @IBInspectable public var focusedBackgroundEndColor: UIColor? {
        didSet { updateBackgroundColor() }
    }

    @IBInspectable public var normalBackgroundColor: UIColor = .clear {
        didSet { updateBackgroundColor() }
    }

    @IBInspectable public var normalBackgroundEndColor: UIColor? {
        didSet { updateBackgroundColor() }
    }
    
    @IBInspectable public var focusedTitleColor: UIColor = .black {
        didSet { updateTitleColor() }
    }

    @IBInspectable public var normalTitleColor: UIColor = .black {
        didSet { updateTitleColor() }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override open func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({
            self.isFocused ? self.applyFocusedStyle() : self.applyUnfocusedStyle()
        }, completion: nil)
    }
    
    override open func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        super.pressesBegan(presses, with: event)
        UIView.animate(
            withDuration: animationDuration,
            animations: {
                [weak self] in
                guard let `self` = self else { return }
                self.transform = .identity
                self.layer.shadowOffset = CGSize(width: 0, height: 10)
        })
    }
    
    override open func pressesCancelled(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        guard isFocused else { return }
        super.pressesCancelled(presses, with: event)
        UIView.animate(
            withDuration: animationDuration,
            animations: {
                [weak self] in
                guard let `self` = self else { return }
                self.transform = CGAffineTransform(scaleX: self.focusedScaleFactor, y: self.focusedScaleFactor)
                self.layer.shadowOffset = self.shadowOffSetFocused
        })
    }
    
    override open func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        guard isFocused else { return }
        super.pressesEnded(presses, with: event)
        UIView.animate(
            withDuration: animationDuration,
            animations: {
                [weak self] in
                guard let `self` = self else { return }
                self.transform = CGAffineTransform(scaleX: self.focusedScaleFactor, y: self.focusedScaleFactor)
                self.layer.shadowOffset = self.shadowOffSetFocused
        })
    }
    
    open func applyFocusedStyle() {
        UIView.animate(
            withDuration: animationDuration,
            animations: {
                [weak self] in
                guard let `self` = self else { return }
                self.transform = CGAffineTransform(scaleX: self.focusedScaleFactor, y: self.focusedScaleFactor)
                self.clipsToBounds = false
                self.backgroundGradientView.colors = self.focusedGradientBackgroundColors
                self.selectedBackgroundView = self.selectedView(withColor: .clear)
                self.textLabel?.textColor = self.focusedTitleColor
            },
            completion: nil)
    }
    
    open func applyUnfocusedStyle() {
        UIView.animate(
            withDuration: animationDuration,
            animations: {
                [weak self] in
                guard let `self` = self else { return }
                self.clipsToBounds = true
                self.transform = .identity
                self.backgroundGradientView.colors = self.normalGradientBackgroundColors
                self.selectedBackgroundView = self.selectedView(withColor: self.selectedBackgroundColor)
                self.textLabel?.textColor = self.normalTitleColor
            },
            completion: nil)
    }
    
    // MARK: - Private
    
    private var focusedGradientBackgroundColors: [CGColor] {
        let endColor = focusedBackgroundEndColor ?? focusedBackgroundColor
        return [focusedBackgroundColor.cgColor, endColor.cgColor]
    }
    
    private var normalGradientBackgroundColors: [CGColor] {
        let endColor = normalBackgroundEndColor ?? normalBackgroundColor
        return [normalBackgroundColor.cgColor, endColor.cgColor]
    }
    
    private let backgroundGradientView = GradientView()
    
    private func setUpView() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        layer.shadowOpacity = focusedShadowOpacity
        layer.shadowRadius = focusedShadowRadius
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffSetFocused
        selectedBackgroundView = selectedView(withColor: .clear)
        textLabel?.textColor = normalTitleColor
        setUpBackgroundView()
    }
    
    private func setUpBackgroundView() {
        backgroundGradientView.frame = bounds
        backgroundGradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundGradientView.layer.cornerRadius = cornerRadius
        backgroundGradientView.startPoint = gradientStartPoint
        backgroundGradientView.endPoint = gradientEndPoint
        backgroundGradientView.colors = normalGradientBackgroundColors
        contentView.addSubview(backgroundGradientView)
        contentView.sendSubviewToBack(backgroundGradientView)
    }
    
    private func selectedView(withColor color: UIColor) -> UIView {
        let view = UIView()
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = color
        return view
    }
    
    private func updateSelectedBackgroundColor() {
        selectedBackgroundView = selectedView(withColor: isFocused ? selectedBackgroundColor : .clear)
    }
    
    private func updateBackgroundColor() {
        backgroundGradientView.colors = isFocused ? focusedGradientBackgroundColors : normalGradientBackgroundColors
    }
    
    private func updateTitleColor() {
        textLabel?.textColor = isFocused ? focusedTitleColor : normalTitleColor
    }
}
