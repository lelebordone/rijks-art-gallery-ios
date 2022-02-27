import UIKit

class ArtItemsListCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = String(describing: ArtItemsListCollectionViewCell.self)
    
    let artItemsListItemView = ArtItemsListItemView()
    
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
        contentView.addContentView(artItemsListItemView)
    }
}

// MARK: - UI Configuration
extension ArtItemsListCollectionViewCell {
    func configure(with model: ArtItemCompact) {
        artItemsListItemView.configure(with: model)
    }
}

struct ArtItemsListCollectionViewSection {
    var title: String
    var items: [ArtItemCompact]
}