import SwiftUI

enum TabItem: String, CaseIterable {
    case home, activities, breathe, schedule, profile

    var title: String {
        switch self {
        case .home: return "Home"
        case .activities: return "Move"
        case .breathe: return "Breathe"
        case .schedule: return "Plan"
        case .profile: return "Me"
        }
    }

    var icon: AppIcon {
        switch self {
        case .home: return .home
        case .activities: return .activity
        case .breathe: return .wind
        case .schedule: return .calendar
        case .profile: return .user
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

                BreatheView(vm: vm)
                    .tabItem {
                        IconView(.wind, size: 22, color: selectedTab == .breathe ? .cozyPrimary : .cozyTextTertiary)
                        Text(TabItem.breathe.title)
                    }
                    .tag(TabItem.breathe)

                ScheduleView(vm: vm)
                    .tabItem {
                        IconView(.calendar, size: 22, color: selectedTab == .schedule ? .cozyPrimary : .cozyTextTertiary)
                        Text(TabItem.schedule.title)
                    }
                    .tag(TabItem.schedule)

                ProfileView(vm: vm)
                    .tabItem {
                        IconView(.user, size: 22, color: selectedTab == .profile ? .cozyPrimary : .cozyTextTertiary)
                        Text(TabItem.profile.title)
                    }
                    .tag(TabItem.profile)
            }
            .tint(.cozyPrimary)
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.configureWithDefaultBackground()
                appearance.backgroundColor = .systemBackground
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}
