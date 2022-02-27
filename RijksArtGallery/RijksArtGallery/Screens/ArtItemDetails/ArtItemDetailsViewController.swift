import UIKit

class ArtItemDetailsController: UIViewController {
    // MARK: - Properties
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let datingLabel: UILabel = {
        let label = RijksTitleLabel()
        return label
    }()
    
    private let artistsLabel: UILabel = {
        let label = RijksTitleLabel()
        return label
    }()
    
    private let materialsLabel: UILabel = {
        let label = RijksTitleLabel()
        return label
    }()
    
    private let mediumLabel: UILabel = {
        let label = RijksTitleLabel()
        return label
    }()
    
    private let productionPlacesLabel: UILabel = {
        let label = RijksTitleLabel()
        return label
    }()
    
    let viewModel: ArtItemDetailsViewModel
    
    // MARK: - Lifecycle
    init(viewModel: ArtItemDetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        title = viewModel.artItem.title
        
        view.addTopSafeContentView(containerStackView)
        
        setupDetailsLabels()
    }
    
    private func setupDetailsLabels() {
        let detailsContainerStackView = UIStackView()
        detailsContainerStackView.translatesAutoresizingMaskIntoConstraints = false
        detailsContainerStackView.spacing = 12
        detailsContainerStackView.distribution = .equalSpacing
        
        containerStackView.addArrangedSubview(detailsContainerStackView)
        
        let titlesStackView = UIStackView()
        titlesStackView.axis = .vertical
        titlesStackView.spacing = 4
        titlesStackView.alignment = .leading
        titlesStackView.distribution = .equalSpacing
        titlesStackView.translatesAutoresizingMaskIntoConstraints = false
        
        [titlesStackView, detailsContainerStackView].forEach { detailsContainerStackView.addArrangedSubview($0) }
        
        let labels = [datingLabel, artistsLabel, materialsLabel, mediumLabel, productionPlacesLabel]
        let artItem = viewModel.artItem
        
        labels.enumerated().forEach { (index, label) in
            // UI configuration
            let labelCase = ArtItemDetails.ArtItemDetailsLabels.allCases[index]
            let title = labelCase.title
            let titleLabel = RijksTitleLabel(fontWeight: .medium)
            titleLabel.text = title
            
            switch labelCase {
            case .dating:
                datingLabel.text = "\(artItem.dating.period)"
            case .artists:
                artistsLabel.text = artItem.principalMakersLabel
            case .materials:
                materialsLabel.text = artItem.materialsLabel
            case .medium:
                mediumLabel.text = artItem.physicalMedium
            case .productionPlaces:
                productionPlacesLabel.text = artItem.productionPlacesLabel
            }
            
            // UI setup
            titlesStackView.addArrangedSubview(titleLabel)
            labelsStackView.addArrangedSubview(label)
        }
    }
}
