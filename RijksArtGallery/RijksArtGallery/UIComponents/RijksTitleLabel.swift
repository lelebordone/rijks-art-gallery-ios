import UIKit

class RijksTitleLabel: UILabel {
    init(textAlignment: NSTextAlignment = .left,
         fontSize: CGFloat = 18,
         fontWeight: UIFont.Weight = .semibold) {
        super.init(frame: .zero)
        
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textColor = .label
        numberOfLines = 1
        lineBreakMode = .byTruncatingTail
    }
}

