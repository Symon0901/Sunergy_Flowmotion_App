import SwiftUI

enum TabItem: String, CaseIterable {
    case home, activities, plan, profile

    var title: String {
        switch self {
        case .home:      return "Home"
        case .activities: return "Activities"
        case .plan:      return "Plan"
        case .profile:   return "Me"
        }
    }

    var icon: AppIcon {
        switch self {
        case .home:      return .home
        case .activities: return .activity
        case .plan:      return .calendar
        case .profile:   return .user
        }
    }
}

@main
struct FlowmotionApp: App {
    @State private var vm = AppViewModel()
    @State private var selectedTab: TabItem = .home

    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab) {
                HomeView(vm: vm, selectedTab: $selectedTab)
                    .tabItem {
                        IconView(.home, size: 22, color: selectedTab == .home ? .cozyPrimary : .cozyTextTertiary)
                        Text(TabItem.home.title)
                    }
                    .tag(TabItem.home)

                ActivitiesView(vm: vm)
                    .tabItem {
                        IconView(.activity, size: 22, color: selectedTab == .activities ? .cozyPrimary : .cozyTextTertiary)
                        Text(TabItem.activities.title)
                    }
                    .tag(TabItem.activities)

                PlanView(vm: vm)
                    .tabItem {
                        IconView(.calendar, size: 22, color: selectedTab == .plan ? .cozyPrimary : .cozyTextTertiary)
                        Text(TabItem.plan.title)
                    }
                    .tag(TabItem.plan)

                ProfileView(vm: vm)
                    .tabItem {
                        IconView(.user, size: 22, color: selectedTab == .profile ? .cozyPrimary : .cozyTextTertiary)
                        Text(TabItem.profile.title)
                    }
                    .tag(TabItem.profile)
            }
            .tint(.cozyPrimary)
            .onAppear {
                #if canImport(UIKit)
                let appearance = UITabBarAppearance()
                appearance.configureWithDefaultBackground()
                appearance.backgroundColor = .systemBackground

                let itemAppearance = UITabBarItemAppearance()
                let normalFont = UIFont.systemFont(ofSize: 12, weight: .medium)
                let selectedFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
                itemAppearance.normal.titleTextAttributes = [.font: normalFont]
                itemAppearance.selected.titleTextAttributes = [.font: selectedFont]
                appearance.stackedLayoutAppearance = itemAppearance

                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
                #endif
            }
        }
    }
}
