import UIKit

class ArtItemsListViewController: UIViewController {
    // MARK: - Properties
    private let artItemsListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let viewModel: ArtItemsListViewModel
    
    // MARK: - Lifecycle
    init(viewModel: ArtItemsListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        viewModel.fetchArtItemsCollection(with: .en) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                print(self.viewModel.artItems)
            case .failure(let error):
                // TODO: add proper error handling
                print(error.userFacingError)
            }
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        
        title = "Rijksmuseum Art Gallery"
    }
}
