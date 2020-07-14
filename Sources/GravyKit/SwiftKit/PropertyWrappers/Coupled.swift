
@propertyWrapper
public struct Coupled<Wrapped, Applicative> {
    public typealias Applicator = (Wrapped, Applicative) -> Wrapped

    // MARK: - Variables

    public var projectedValue: Applicative {
        didSet {
            performCoupling()
        }
    }

    public var wrappedValue: Wrapped {
        get {
            applicable
        }

        set {
            applicable = makeCouple(newValue, projectedValue)
        }
    }

    private var applicable: Wrapped

    private let makeCouple: Applicator

    // MARK: - Init

    public init(wrappedValue: Wrapped, with applicable: Applicative, coupledBy coupler: @escaping Applicator) {
        self.projectedValue = applicable
        self.makeCouple = coupler
        self.applicable = wrappedValue
        performCoupling()
    }

    // MARK: - Private

    private mutating func performCoupling() {
        self.applicable = makeCouple(self.applicable, projectedValue)
    }
}

extension Coupled where Wrapped: AnyObject {
    public typealias InplaceApplicator = (inout Wrapped, Applicative) -> Void

    public init(wrappedValue: Wrapped, with applicable: Applicative, onUpdate update: @escaping InplaceApplicator)  {
        self.init(wrappedValue: wrappedValue, with: applicable, coupledBy: { wrapped, applicative -> Wrapped in
            var value = wrapped
            update(&value, applicative)
            return value
        })
    }

    public init(wrappedValue: Wrapped, with applicable: Applicative, onUpdate update: @escaping (Wrapped) -> (Applicative) -> Void)  {
        self.init(wrappedValue: wrappedValue, with: applicable) {
            update($0)($1)
        }
    }
}
