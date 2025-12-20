import SwiftUI


struct MainView: View {
    
    @State private var viewModel: MainViewModel
    
    @State private var isWhitherFlow = true
    
    @State private var stories = StoriesViewModel().stories
    @State private var showStories = false
    @State private var selectedStoryIndex = 0
    
    init(viewModel: MainViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ParentContainer(error: $viewModel.error) {
            VStack(spacing: 0) {
                storyCollectionView
                    .padding(.vertical, 24)
                routePointsSelectionView
                    .padding(.top, 20)
                    .fullScreenCover(isPresented: $viewModel.showFlow) {
                        let flowRouteSelectionViewModel = FlowRouteSelectionViewModel(
                            // TODO: -  allStationsService: CachedAllStationsService(remote: AllStationsService(client: viewModel.client))
                            allStationsService: CachedAllStationsService(remote: LocalAllStationsService())
                        ) { route in
                            if isWhitherFlow {
                                viewModel.whither = route
                            } else {
                                viewModel.whence = route
                            }
                            viewModel.showFlow = false
                        }
                        FlowView(
                            viewModel: flowRouteSelectionViewModel
                        )
                        .task {
                            await flowRouteSelectionViewModel.loadSettlements()
                        }
                    }
                    .fullScreenCover(isPresented: $viewModel.showCarriers) {
                        let carrierVM = CarrierSelectionViewModel(
                            whither: viewModel.whither,
                            whence: viewModel.whence,
                            networkMonitor: viewModel.networkMonitor
                        ) { carrier in
                            Logger.info("Выбран \(carrier.carrierName)")
                            viewModel.showCarrierInfo = true
                        }
                        
                        NavigationStack {
                            CarrierSelectionView(viewModel: carrierVM)
                                .navigationDestination(isPresented: $viewModel.showCarrierInfo) {
                                    CarrierInfoView()
                                }
                        }
                    }
                    .fullScreenCover(isPresented: $showStories) {
                        StoriesContentView(
                            stories: stories,
                            currentStoryIndex: $selectedStoryIndex
                        ) {
                            markStoryViewed(at: $0)
                        }
                    }
                button
                    .padding(.top, 16)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .appBackground()
        }
    }
    
    private var storyCollectionView: some View {
        StoryCollectionView(stories: $stories) { index in
            selectedStoryIndex = index
            showStories = true
        }
    }
    
    private var routePointsSelectionView: some View {
        RoutePointsSelectionView(
            whither: $viewModel.whither,
            whence: $viewModel.whence,
            whitherAction: {
                isWhitherFlow = true
                viewModel.showFlow = true
            },
            whenceAction: {
                isWhitherFlow = false
                viewModel.showFlow = true
            },
            swapAction: { swap() }
        )
    }
    
    private var button: some View {
        PrimaryButton(
            title: "Найти",
            width: 150) {
                viewModel.showCarriers = true
            }
            .opacity(viewModel.isSearchEnabled ? 1 : 0)
    }
    
    private func swap() {
        let temp = viewModel.whither
        viewModel.whither = viewModel.whence
        viewModel.whence = temp
    }
    
    private func markStoryViewed(at index: Int) {
        stories[index].isViewed = true
    }
}

private struct FlowView: View {
    
    @State private var path = NavigationPath()
    @State private var viewModel: FlowRouteSelectionViewModel
    
    init(viewModel: FlowRouteSelectionViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            
            SettlementSelectionView(
                settlements: viewModel.settlements
            ) { settlement in
                viewModel.selectSettlement(settlement)
                path.append("station")
            }
            .navigationDestination(for: String.self) { value in
                if value == "station" {
                    StationSelectionView(
                        stations: viewModel.stations
                    ) { station in
                        viewModel.selectStation(station)
                    }
                    .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

#Preview {
    let monitor = NetworkMonitor()
    MainView(viewModel: MainViewModel(networkMonitor: monitor))
        .environmentObject(monitor)
}

