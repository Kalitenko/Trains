extension Components.Schemas.CarrierResponse {
    var resolvedCarrier: Components.Schemas.Carrier? {
        switch self {
        case .case1(let payload): payload.carrier
        case .case2(let payload): payload.carriers?.first
        }
    }
}
