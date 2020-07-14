
@propertyWrapper
public final class Coupled<Wrapped: AnyObject, Applicative> {
    public typealias Applicator = (Wrapped, Applicative) -> Void

    // MARK: - Variables

    public var projectedValue: Applicative {
        didSet {
            performCoupling()
        }
    }

    public var wrappedValue: Wrapped {
        didSet {
            performCoupling()
        }
    }

    private let makeCouple: Applicator

    // MARK: - Init

    public init(wrappedValue: Wrapped, with applicable: Applicative, coupledBy coupler: @escaping Applicator) {
        self.wrappedValue = wrappedValue
        self.projectedValue = applicable
        self.makeCouple = coupler

        performCoupling()
    }

    // MARK: - Private

    private func performCoupling() {
        makeCouple(wrappedValue, projectedValue)
    }
}
