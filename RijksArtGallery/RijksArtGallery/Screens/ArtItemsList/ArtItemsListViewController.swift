import UIKit

class ArtItemsListViewController: UIViewController {
    // MARK: - Properties
    private let artItemsListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let collectionViewPadding: CGFloat = 16
    private let collectionViewItemsHeight: CGFloat = 128
    
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
                self.artItemsListCollectionView.reloadData()
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
        layout.itemSize = CGSize(width: itemWidth, height: collectionViewItemsHeight)
        
        artItemsListCollectionView.setCollectionViewLayout(layout, animated: false)
        artItemsListCollectionView.dataSource = self
        artItemsListCollectionView.register(ArtItemsListCollectionViewCell.self,
                                            forCellWithReuseIdentifier: ArtItemsListCollectionViewCell.identifier)
    }
}

// MARK: - Collection View Data Source
extension ArtItemsListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sectionedDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section < viewModel.sectionedDataSource.count else { return 0 }
        
        return viewModel.sectionedDataSource[section].items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = ArtItemsListCollectionViewCell.identifier
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                          for: indexPath) as? ArtItemsListCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        let artItem = viewModel.sectionedDataSource[indexPath.section].items[indexPath.item]
        cell.configure(with: artItem)
        
        return cell
    }
}
