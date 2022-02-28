import UIKit

extension UIImageView {
    func loadImage(from urlString: String,
                   imageCache: RijksCache<String, UIImage>? = nil,
                   placeholderID: String,
                   imageConfigurator: ((UIImage) -> UIImage)? = nil) {
        // Check for the image in the given cache using the urlString as key
        if let imageCache = imageCache, let image = imageCache[urlString] {
            let configuratedImage = imageConfigurator?(image)
            self.image = configuratedImage ?? image
            return
        }
        
        // Build the url
        guard let url = URL(string: urlString) else {
            // If this fails, set a placeholder image
            if let placeholder = UIImage(named: placeholderID) {
                let configuratedImage = imageConfigurator?(placeholder)
                image = configuratedImage ?? placeholder
            }
            return
        }
        
        // Asynchronously load the image
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        // Store the downloaded image in the given cache
                        if let imageCache = imageCache {
                            imageCache[urlString] = image
                        }
                        let configuratedImage = imageConfigurator?(image)
                        self?.image = configuratedImage ?? image
                    }
                }
            }
        }
    }
}

extension UIImage {
    func scaledPreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / self.size.width
        let heightRatio = targetSize.height / self.size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: self.size.width * scaleFactor,
            height: self.size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
    
    func centerCropped() -> UIImage {
        let sourceImage = self

        // The shortest side
        let sideLength = min(
            sourceImage.size.width,
            sourceImage.size.height
        )

        // Determines the x,y coordinate of a centered
        // sideLength by sideLength square
        let sourceSize = sourceImage.size
        let xOffset = (sourceSize.width - sideLength) / 2.0
        let yOffset = (sourceSize.height - sideLength) / 2.0

        // The cropRect is the rect of the image to keep,
        // in this case centered
        let cropRect = CGRect(
            x: xOffset,
            y: yOffset,
            width: sideLength,
            height: sideLength
        ).integral
        
        // Center crop the image
        let sourceCGImage = sourceImage.cgImage!
        let croppedCGImage = sourceCGImage.cropping(
            to: cropRect
        )!

        // Use the cropped cgImage to initialize a cropped
        // UIImage with the same image scale and orientation
        let croppedImage = UIImage(
            cgImage: croppedCGImage,
            scale: sourceImage.imageRendererFormat.scale,
            orientation: sourceImage.imageOrientation
        )
        
        return croppedImage
    }
}

extension Optional where Wrapped: UIImage {    
    func scaledPreservingAspectRatio(targetSize: CGSize) -> UIImage? {
        guard let self = self else { return nil }
        
        return self.scaledPreservingAspectRatio(targetSize: targetSize)
    }
}
