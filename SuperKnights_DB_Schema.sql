

create table tblPlayer
(
	PlayerId int primary key identity(1,1),
	FirstName varchar(50),
	Surname varchar(50),
	NickName varchar(50),
	Bio varchar(200),
	BirthDate datetime,
	JoinedDate datetime,
) 

create table tblPlayerAttribute
(
	PlayerAtrId int primary key identity(1,1),
	PlayerId int not null constraint fk_players_playerAttributes references tblPlayer(PlayerId),
	BattingStyle int,
	BowlingStyle int,
	BowlingType int,
	WicketKeeping int
)

create table tblTeam
(
	TeamId int primary key identity(1,1),
	TeamName varchar(100),
	TeamDescription varchar(200),
	Continent int,
	Country int,
	CreatedOn datetime
)

create table tblTournamentFormat
(
	TournamentFormatId int primary key identity(1,1),
	TournamentFormat varchar(100),
	TournamentFormatDescription varchar(200)
)

create table tblTournament
(
	TournamentId int primary key identity(1,1),
	TounamentName varchar(100),
	Organizerid int,
	TotalRounds int,
	TournamentFormat int,
	PlayingConditions varchar(200), -- should be a link to 
	StartDate datetime,
	EndDate datetime
)

create table tblMatchFormat
(
	MatchFormatId int primary key identity(1,1),
	MatchFormat varchar(10),
	MatchFormatDescription varchar(10),
)

create table tblMatch
(
	MatchId int primary key identity(1,1),
	MatchRound int,
	TeamOne int not null constraint fk_teamOne_matches_team references tblTeam(TeamId),
	TeamTwo int not null constraint fk_teamTwo_matches_team references tblTeam(TeamId),
	WonBy int not null constraint fk_wonby_matches_team references tblTeam(TeamId),
	MatchFormatId int not null constraint fk_matchformat_match references tblMatchFormat(MatchFormatId),
	MatchStart datetime,
	MatchEnd datetime
)

-- Match, Drinks, Time Out, Tea, Lunch etc
create table tblMatchEventType 
(
	MatchTimelineTypeId int primary key identity(1,1),
	TimelineType varchar(50),
	TimelineTypeDescription varchar(200)
)

create table tblMatchEvent
(
	MatchDetailId int primary key identity(1,1),
	MatchId int not null constraint fk_matchevent_match references tblMatch(MatchId),
	MatchDay datetime,
	Start time,
	Finish time,
	TimeLineTypeId int -- indicates what type event it is - drinks, tea, lunch, match start etc
)

create table tblMatchSummary
(
	MatchSummaryId int primary key identity(1,1),
	MatchId int not null constraint fk_match_matchsummary references tblMatch(MatchId),
	TeamId int not null constraint fk_team_matchsummary references tblTeam(TeamId),
	Innings int,
	Total int,
	Wickets int,
	Byes int,
	LegByes int,
	NoBalls int,
	Wides int,
	Sixes int,
	Fours int,
	RunRate decimal
)

create table tblBattingDetails
(
	BattingDetailsId int primary key identity(1,1),
	MatchId int not null constraint fk_match_matchsummary references tblMatch(MatchId),
	TeamId int not null constraint fk_team_matchsummary references tblTeam(TeamId),
	Batter int not null constraint fk_player_battingdetails_batter references tblPlayer(PlayerId),
	Runs int,
	StrikeRate decimal,
	Sixes int,
	Fours int,
	HowOut int,
	Bowler int not null constraint fk_player_battingdetails_bowler references tblPlayer(PlayerId),
	Fielder int not null constraint fk_player_battingdetails_fielder references tblPlayer(PlayerId),
)

create table tblBowlingDetails
(
	BowlingDetailsId int primary key identity(1,1),
	MatchId int not null constraint fk_match_bowlingdetails references tblMatch(MatchId),
	TeamId int not null constraint fk_team_bowlingdetails references tblTeam(TeamId),
	Bowler int not null constraint fk_player_bowlingdetails_bowler references tblPlayer(PlayerId),
	Wickets int,
	NoBalls int,
	Wides int,
	Econ decimal,
	StrikeRate decimal,
	Economy decimal
)