import UIKit

class ArtItemsListHeaderView: UICollectionReusableView {
    // MARK: - Properties
    static let identifier = String(describing: ArtItemsListCollectionViewCell.self)
    
    private let titleLabel: UILabel = {
        let titleLabel = RijksTitleLabel(fontSize: 22, fontWeight: .bold)
        return titleLabel
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI Setup
    private func setupUI() {
        addContentViewWithCustomMargins(titleLabel, margins: .init(top: 0, left: 16, bottom: 0, right: 16))
    }
}

// MARK: - UI Configuration
extension ArtItemsListHeaderView {
    func configure(with title: String) {
        titleLabel.text = title
    }
}
