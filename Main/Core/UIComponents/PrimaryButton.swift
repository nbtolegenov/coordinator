//
//  PrimaryButton.swift
//  Coordinator
//
//  Created by Nurlan Tolegenov on 8/21/20.
//  Copyright © 2020 Nurlan Tolegenov. All rights reserved.
//

import UIKit

final class PrimaryButton: UIButton {
    override var intrinsicContentSize: CGSize {
        CGSize(width: super.intrinsicContentSize.width, height: 56)
    }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.transform = self.isHighlighted ? .init(scaleX: 0.95, y: 0.95) : .identity
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup() {
        assert(buttonType == .custom, "buttonType of PrimaryButton must be .custom")
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 12
        setTitleColor(.label, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
    }
}
