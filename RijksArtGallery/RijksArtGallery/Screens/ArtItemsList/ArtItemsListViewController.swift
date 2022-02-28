import UIKit

class ArtItemsListViewController: UIViewController, Loadable {
    // MARK: - Properties
    let artItemsListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let collectionViewPadding: CGFloat = 16
    let loadingView = RijksLoadingView()
    
    let viewModel: ArtItemsListViewModel
    let imageCache: RijksCache<String, UIImage>
    
    // MARK: - Lifecycle
    init(viewModel: ArtItemsListViewModel,
         imageCache: RijksCache<String, UIImage> = .init()) {
        self.viewModel = viewModel
        self.imageCache = imageCache
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        showLoading(on: view)
        viewModel.fetchArtItemsCollection(using: .en) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.artItemsListCollectionView.reloadData()
            case .failure(let error):
                // TODO: add proper error handling
                print(error)
            }
            
            self.hideLoading()
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        title = "Rijksmuseum Art Gallery"
        
        setupArtItemsListCollectionView()
    }
    
    private func setupArtItemsListCollectionView() {
        view.addTopSafeContentView(artItemsListCollectionView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = collectionViewPadding
        layout.sectionInset = UIEdgeInsets(top: collectionViewPadding,
                                           left: collectionViewPadding,
                                           bottom: collectionViewPadding,
                                           right: collectionViewPadding)
        let itemWidth = view.frame.size.width - collectionViewPadding * 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 60 + 12)
        layout.headerReferenceSize = CGSize(width: view.frame.size.width, height: 60)
        
        artItemsListCollectionView.setCollectionViewLayout(layout, animated: false)
        artItemsListCollectionView.dataSource = self
        artItemsListCollectionView.delegate = self
        artItemsListCollectionView.register(ArtItemsListHeaderView.self,
                                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                            withReuseIdentifier: ArtItemsListHeaderView.identifier)
        artItemsListCollectionView.register(ArtItemsListCollectionViewCell.self,
                                            forCellWithReuseIdentifier: ArtItemsListCollectionViewCell.identifier)
    }
}
