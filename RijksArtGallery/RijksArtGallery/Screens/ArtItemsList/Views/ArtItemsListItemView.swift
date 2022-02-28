import UIKit

class ArtItemsListItemView: UIView {
    // MARK: - Properties
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .equalSpacing
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
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray4.withAlphaComponent(0.1)
        return imageView
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
        
        let imageContainer = UIView()
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.backgroundColor = .systemGray4.withAlphaComponent(0.2)
        imageContainer.addContentViewCentered(imageView)
        
        [headerStackView, imageContainer].forEach { containerStackView.addArrangedSubview($0) }
        [titleLabel, subtitleLable].forEach { headerStackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            imageContainer.widthAnchor.constraint(equalTo: widthAnchor),
            imageContainer.heightAnchor.constraint(equalTo: imageContainer.widthAnchor)
        ])
    }
}

// MARK: - UI configuration
extension ArtItemsListItemView {
    func configure(with model: ArtItemCompact,
                   imageCache: RijksCache<String, UIImage>,
                   cellSize: CGSize) {
        titleLabel.text = model.title
        subtitleLable.text = model.longTitle
        
        // Setting the initial placeholder image
        let imageSize = CGSize(width: cellSize.width,
                               height: cellSize.width)
        let placeholderImage = PlaceholderImages.artItemListThumbnail.scaledPreservingAspectRatio(targetSize: imageSize)
        imageView.image = placeholderImage
        
        imageView.loadImage(from: model.webImage.url,
                            imageCache: imageCache,
                            placeholderID: PlaceholderImages.artItemListThumbnailID) { image in
            image.scaledPreservingAspectRatio(targetSize: imageSize)
        }
    }
}
