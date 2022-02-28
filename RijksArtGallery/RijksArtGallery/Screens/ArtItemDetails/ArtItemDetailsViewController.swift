import UIKit

class ArtItemDetailsViewController: UIViewController {
    // MARK: - Properties
    private let containerScrollStack: ScrollStackView = {
        let scrollStack = ScrollStackView()
        scrollStack.stackView.axis = .vertical
        scrollStack.stackView.spacing = 24
        scrollStack.stackView.isLayoutMarginsRelativeArrangement = true
        scrollStack.stackView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        scrollStack.stackView.translatesAutoresizingMaskIntoConstraints = false
        return scrollStack
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
        let label = RijksDescriptionLabel()
        return label
    }()
    
    private let artistsLabel: UILabel = {
        let label = RijksDescriptionLabel()
        return label
    }()
    
    private let materialsLabel: UILabel = {
        let label = RijksDescriptionLabel()
        return label
    }()
    
    private let mediumLabel: UILabel = {
        let label = RijksDescriptionLabel()
        return label
    }()
    
    private let productionPlacesLabel: UILabel = {
        let label = RijksDescriptionLabel()
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
        view.backgroundColor = UIColor.systemBackground
        title = viewModel.artItem.title
        
        view.addTopSafeContentView(containerScrollStack)
        
        setupDetailsLabels()
    }
    
    private func setupDetailsLabels() {
        let detailsContainerStackView = UIStackView()
        detailsContainerStackView.translatesAutoresizingMaskIntoConstraints = false
        detailsContainerStackView.spacing = 12
        detailsContainerStackView.distribution = .equalSpacing
        
        [detailsContainerStackView, UIView()].forEach { containerScrollStack.stackView.addArrangedSubview($0) }
        
        let titlesStackView = UIStackView()
        titlesStackView.axis = .vertical
        titlesStackView.spacing = 4
        titlesStackView.alignment = .leading
        titlesStackView.distribution = .equalSpacing
        titlesStackView.translatesAutoresizingMaskIntoConstraints = false
        
        [titlesStackView, labelsStackView, UIView()].forEach { detailsContainerStackView.addArrangedSubview($0) }

        let labels = [datingLabel, artistsLabel, materialsLabel, mediumLabel, productionPlacesLabel]
        let artItem = viewModel.artItem

        labels.enumerated().forEach { (index, label) in
            // UI configuration
            let labelCase = ArtItemDetails.ArtItemDetailsLabels.allCases[index]
            let title = labelCase.title
            let titleLabel = RijksDescriptionLabel(fontWeight: .medium, textColor: .label)
            titleLabel.text = title

            switch labelCase {
            case .dating:
                label.text = "\(artItem.dating.yearLate)"
            case .artists:
                label.text = artItem.principalMakersLabel
            case .materials:
                label.text = artItem.materialsLabel
            case .medium:
                label.text = artItem.physicalMedium
            case .productionPlaces:
                label.text = artItem.productionPlacesLabel
            }

            // UI setup
            titlesStackView.addArrangedSubview(titleLabel)
            labelsStackView.addArrangedSubview(label)
        }
    }
}
