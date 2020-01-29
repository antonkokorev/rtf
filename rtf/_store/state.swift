//
//  state.swift
//  rtf
//
//  Created by Anton Elistratov on 07.01.2020.
//  Copyright © 2020 team. All rights reserved.
//

import ReSwift

struct AppState: StateType {
	var usersSubState: UsersState = UsersState()
	var bossSubState: BossState = BossState()
	var comparisonSubState: ComparisonState = ComparisonState()
	var feedbackPropsSubState: FeedbackPropsState = FeedbackPropsState()
	var messageSubState: MessageState = MessageState()
	var requestRatingSubState = requestRatingState()
    var statisticsSubState:StatisticsState = StatisticsState()
	var subordinatesSubState: SubordinatesState = SubordinatesState()
	var teamInfoSubState = teamInfoState()
	var thanksSubState = thanksState()
	var usersAllSubState = usersAllState()
	var usersFavouriteSubState = usersFavouriteState()
	var userHistorySubState = usersHistoryState()
	var usersInboxSubState = usersInboxState()
	var usersRecentSubState: UsersRecentState = UsersRecentState()
	var usersRequestSubState = usersRequestState()
	var usersTeamSubState = usersTeamState()
	var searchSubState: SearchState = SearchState()
	var errorSubState: ErrorState = ErrorState()
}

func appReducer(action: Action, state: AppState?) -> AppState {
	return AppState(
		usersSubState: usersReducer(action: action, state: state?.usersSubState),
		bossSubState: bossReducer(action: action, state: state?.bossSubState),
		comparisonSubState: comparisonReducer(action: action, state: state?.comparisonSubState),
		feedbackPropsSubState: feedbackPropsReducer(action: action, state: state?.feedbackPropsSubState),
		messageSubState: messageReducer(action: action, state: state?.messageSubState),
		requestRatingSubState: requestRatingReducer(action: action, state: state?.requestRatingSubState),
		statisticsSubState: statisticsReducer(action: action, state: state?.statisticsSubState),
		subordinatesSubState: subordinatesReducer(action: action, state: state?.subordinatesSubState),
		teamInfoSubState: teamInfoReducer(action: action, state: state?.teamInfoSubState),
		thanksSubState: thanksReducer(action: action, state: state?.thanksSubState),
		usersAllSubState: usersAllReducer(action: action, state: state?.usersAllSubState),
		usersFavouriteSubState: usersFavouriteReducer(action: action, state: state?.usersFavouriteSubState),
		userHistorySubState: usersHistoryReducer(action: action, state: state?.userHistorySubState),
		usersInboxSubState: usersInboxReducer(action: action, state: state?.usersInboxSubState),
		usersRecentSubState: usersRecentReducer(action: action, state: state?.usersRecentSubState),
		usersRequestSubState: usersRequestReducer(action: action, state: state?.usersRequestSubState),
		usersTeamSubState: usersTeamReducer(action: action, state: state?.usersTeamSubState),
		searchSubState: searchReducer(action: action, state: state?.searchSubState),
		errorSubState: errorReducer(action: action, state: state?.errorSubState)
	)
}

var AppEffects: Array = [
	userRecentEffect,
	subordinatesEffect,
	userRequestEffect,
	thanksEffect,
    userHistoryEffect,
    usersEffect,
	usersFavouriteEffect,
	searchEffect,
    statisticsEffect,
    feedbackPropsEffect
]
