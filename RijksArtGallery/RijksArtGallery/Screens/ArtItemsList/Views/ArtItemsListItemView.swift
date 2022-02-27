import UIKit

class ArtItemsListItemView: UIView {
    // MARK: - Properties
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 16, left: 16, bottom: 0, right: 16)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = RijksTitleLabel(fontSize: 17)
        return label
    }()
    
    private let subtitleLable: UILabel = {
        let label = RijksDescriptionLabel(fontSize: 13)
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
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray2.withAlphaComponent(0.2).cgColor
        layer.cornerRadius = 2
        
        addContentView(containerStackView)
        
        [headerStackView, UIView()].forEach { containerStackView.addArrangedSubview($0) }
        [titleLabel, subtitleLable].forEach { headerStackView.addArrangedSubview($0) }
    }
}

// MARK: - UI configuration
extension ArtItemsListItemView {
    func configure(with model: ArtItemCompact) {
        titleLabel.text = model.title
        subtitleLable.text = model.longTitle
    }
}
