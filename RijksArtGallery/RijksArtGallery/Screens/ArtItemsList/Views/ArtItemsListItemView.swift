import UIKit

class ArtItemsListItemView: UIView {
    // MARK: - Properties
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = RijksTitleLabel()
        return label
    }()
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: UI setup
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addContentView(containerStackView)
        
        containerStackView.addArrangedSubview(titleLabel)
    }
}

// MARK: - UI configuration
extension ArtItemsListItemView {
    func configure(with model: ArtItemCompact) {
        titleLabel.text = model.title
    }
}
