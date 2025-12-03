enum DepartureTimeRange: String, CaseIterable {
    case morning = "Утро 06:00 - 12:00"
    case day = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
}

enum TransferOption: String, CaseIterable {
    case yes = "Да"
    case no = "Нет"
}
