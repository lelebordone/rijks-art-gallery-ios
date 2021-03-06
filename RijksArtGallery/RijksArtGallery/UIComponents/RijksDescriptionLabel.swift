import UIKit

class RijksDescriptionLabel: UILabel {
    init(textAlignment: NSTextAlignment = .left,
         fontSize: CGFloat = 14,
         fontWeight: UIFont.Weight = .regular,
         textColor: UIColor = .secondaryLabel) {
        super.init(frame: .zero)
        
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.textColor = textColor
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
    
        numberOfLines = 1
        lineBreakMode = .byTruncatingTail
    }
}

