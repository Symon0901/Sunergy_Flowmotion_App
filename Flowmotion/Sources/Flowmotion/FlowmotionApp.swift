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
            .overlay(
                Group {
                    if vm.showLevelUp {
                        LevelUpOverlay(
                            level: vm.pet.level,
                            reward: vm.lastUnlockedReward,
                            onDismiss: {
                                vm.showLevelUp = false
                                vm.lastUnlockedReward = nil
                            }
                        )
                    }
                }
            )
            .onAppear {
                vm.checkDailyReset()
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

struct LevelUpOverlay: View {
    let level: Int
    let reward: UnlockReward?
    let onDismiss: () -> Void

    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture { onDismiss() }

            VStack(spacing: 20) {
                Text("Level Up!")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.cozyPrimary)

                ZStack {
                    Circle()
                        .fill(Color.cozyGold)
                        .frame(width: 80, height: 80)

                    Text("\(level)")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.cozyGoldText)
                }

                Text("Cozymo is now Level \(level)")
                    .font(.cozyTitle3)
                    .foregroundColor(.cozyTextPrimary)

                if let reward = reward {
                    VStack(spacing: 8) {
                        Text("New Unlock!")
                            .font(.cozyOverline)
                            .foregroundColor(.cozyPrimary)

                        HStack(spacing: 12) {
                            Image(systemName: reward.icon)
                                .font(.system(size: 24))
                                .foregroundColor(.cozyPrimary)

                            VStack(alignment: .leading, spacing: 2) {
                                Text(reward.rawValue)
                                    .font(.cozyBodyMedium)
                                    .foregroundColor(.cozyTextPrimary)

                                Text(reward.description)
                                    .font(.cozyCaption)
                                    .foregroundColor(.cozyTextSecondary)
                            }

                            Spacer()
                        }
                        .padding(14)
                        .background(Color.cozyPrimary.opacity(0.08))
                        .cornerRadius(12)
                    }
                }

                Button(action: onDismiss) {
                    Text("Awesome!")
                        .font(.cozyBodyMedium)
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .background(Color.cozyPrimary)
                        .cornerRadius(14)
                }
            }
            .padding(24)
            .background(Color.cozyCard)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 10)
            .padding(.horizontal, 40)
            .scaleEffect(scale)
            .opacity(opacity)
        }
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                scale = 1.0
                opacity = 1.0
            }
        }
    }
}
