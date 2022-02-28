import UIKit

// MARK: - Collection View Data Source
extension ArtItemsListViewController: UICollectionViewDataSource {
    // MARK: Number of sections and items
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sectionedDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section < viewModel.sectionedDataSource.count else { return 0 }
        
        return viewModel.sectionedDataSource[section].items.count
    }
    
    // MARK: Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: ArtItemsListHeaderView.identifier,
                                                                             for: indexPath) as? ArtItemsListHeaderView
            else { return UICollectionReusableView() }
            
            let headerTitle = viewModel.sectionedDataSource[indexPath.section].title
            header.configure(with: headerTitle)
            
            return header
        default:
            return UICollectionReusableView()
        }
    }

    // MARK: Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = ArtItemsListCollectionViewCell.identifier
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                          for: indexPath) as? ArtItemsListCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        let artItem = viewModel.sectionedDataSource[indexPath.section].items[indexPath.item]
        cell.configure(with: artItem, cellSize: CGSize(width: collectionView.contentSize.width - collectionViewPadding * 2,
                                                       height: collectionViewItemsHeight))
        return cell
    }
}

// MARK: - Collection View Delegate
extension ArtItemsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = viewModel.sectionedDataSource[indexPath.section].items[indexPath.item]
        viewModel.fetchArtItemDetails(with: selectedItem.objectNumber, using: .en) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let details):
                ArtCollectionCoordinator().push(.artItemDetail(artItem: details), from: self)
            case .failure(let error):
                // TODO: add proper error handling
                print(error.userFacingError)
            }
        }
    }
}
