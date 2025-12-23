extension Components.Schemas.CarrierResponse {
    var resolvedCarrier: Components.Schemas.Carrier? {
        switch self {
        case .case1(let payload):
            return payload.carrier

        case .case2(let payload):
            return payload.carriers?.first
        }
    }
}
