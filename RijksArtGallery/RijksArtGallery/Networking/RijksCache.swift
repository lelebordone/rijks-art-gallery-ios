import Foundation

final class RijksCache<Key: Hashable, Value> {
    private let wrapped = NSCache<WrappedKey, Entry>()
    
    func insert(_ value: Value, forKey key: Key) {
        let entry = Entry(value: value)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }
    
    func value(forKey key: Key) -> Value? {
        let entry = wrapped.object(forKey: WrappedKey(key))
        
        return entry?.value
    }
    
    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }
}

private extension RijksCache {
    final class WrappedKey: NSObject {
        let key: Key
        
        init(_ key: Key) { self.key = key }
        
        override var hash: Int { return key.hashValue }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else { return false }
            
            return value.key == key
        }
    }
}

private extension RijksCache {
    final class Entry {
        let value: Value
        
        init(value: Value) {
            self.value = value
        }
    }
}

// MARK: Subscript extension
// Useful extension for using RijksCache with the intuitive subscript sintax (e.g. cacheInstance[key] = value)
extension RijksCache {
    subscript(key: Key) -> Value? {
        get { return value(forKey: key) }
        set {
            guard let value = newValue else {
                // If nil was assigned using our subscript, then we remove any value for that key
                removeValue(forKey: key)
                return
            }
            
            insert(value, forKey: key)
        }
    }
}
