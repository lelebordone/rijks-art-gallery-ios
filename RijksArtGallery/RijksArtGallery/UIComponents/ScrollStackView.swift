import UIKit

enum ScrollStackViewDirection {
    case vertical
    case horizontal
}

class ScrollStackView: UIScrollView {
    var scrollStackDirection: ScrollStackViewDirection
    let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.isLayoutMarginsRelativeArrangement = true
        return stackview
    }()

    convenience init(scrollStackDirection: ScrollStackViewDirection = .vertical) {
        self.init()
        self.scrollStackDirection = scrollStackDirection
        setupUI()
    }

    private init() {
        self.scrollStackDirection = .vertical
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        self.scrollStackDirection = .vertical
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addContentView(stackView)
        setupScrollDirection()
        setupScrollCenter()
    }

    private func setupScrollDirection() {
        switch scrollStackDirection {
        case .vertical:
            stackView.axis = .vertical
            stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        case .horizontal:
            stackView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        }
    }

    private func setupScrollCenter() {
        guard let superv = superview else { return }
        centerYAnchor.constraint(equalTo: superv.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: superv.centerXAnchor).isActive = true
    }
}
