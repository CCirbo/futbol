module SeasonStatistics
    def winningest_coach(season)
        ids = games_per_season(season)
        coaches = coaches_wins_losses_ties(ids)
        coaches = find_ratio(coaches)
        highest_percent = coaches.values.max
        (coaches.find {|coach, percent| percent == highest_percent})[0]
    end

    def worst_coach(season)
        ids = games_per_season(season)
        coaches = coaches_wins_losses_ties(ids)
        coaches = find_ratio(coaches)
        lowest_percent = coaches.values.min
        (coaches.find {|coach, percent| percent == lowest_percent})[0]
    end

    def most_accurate_team(season)
        ids = games_per_season(season)
        teams = team_shot_goal(ids)
        teams = find_ratio(teams)
        team = teams.max_by {|team_id, ratio| ratio}
        get_team_name(team[0])
    end

    def least_accurate_team(season)
        ids = games_per_season(season)
        teams = team_shot_goal(ids)
        teams = find_ratio(teams)
        team = teams.min_by {|team_id, ratio| ratio}
        get_team_name(team[0])
    end

    def most_tackles(season)
        ids = games_per_season(season)
        teams = team_tackles(ids)
        most_tackles = teams.values.max
        team_with_most_tackles = teams.find {|team, tackles| tackles == most_tackles }
        team_with_most_tackles
        get_team_name(team_with_most_tackles[0])
    end

    def fewest_tackles(season)
        ids = games_per_season(season)
        teams = team_tackles(ids)
        fewest_tackles = teams.values.min
        team_with_fewest_tackles = teams.find {|team, tackles| tackles == fewest_tackles }
        team_with_fewest_tackles
        get_team_name(team_with_fewest_tackles[0])
    end

    def games_per_season(season)
        game_ids = []
        games.find_all do |game| 
            if game.season == season
                game_ids << game.game_id
            end
        end
        game_ids
    end

    def coaches_wins_losses_ties(game_ids)
        coaches = {}
        game_teams.each do |object|
            if game_ids.include?(object.game_id)
                update_coaches(object, coaches)
                update_games(object, coaches)
            end
        end
        coaches
    end

    def update_coaches(game_teams_object, coaches)
        if coaches[game_teams_object.head_coach].nil?
            coaches[game_teams_object.head_coach] = [0, 0]
        end
        coaches
    end

    def update_games(game_teams_object, coaches)
        if game_teams_object.result == 'WIN'
            coaches[game_teams_object.head_coach][0] += 1 
        end
        coaches[game_teams_object.head_coach][1] += 1
        coaches
    end

    def find_ratio(hash)
        hash.each_pair do |id, values|
            ratio = (values[0].fdiv(values[1]))
            hash[id] = ratio
        end
        hash
    end

    def team_shot_goal(game_ids) 
        team_ids = {}
        game_teams.each do |object|
            if game_ids.include?(object.game_id)
                team_id_hash(object, team_ids)
                update_shots_goals(object, team_ids)
            end
        end
        team_ids
    end

    def team_id_hash(game_teams_object, team_ids)
        if team_ids[game_teams_object.team_id].nil?
            team_ids[game_teams_object.team_id] = [0, 0]
        end
        team_ids
    end

    def update_shots_goals(game_teams_object, team_ids)
        team_ids[game_teams_object.team_id][0] += game_teams_object.goals
        team_ids[game_teams_object.team_id][1] += game_teams_object.shots
        team_ids
    end

    def get_team_name(team_id)
        team_info = teams.find {|team| team.team_id == team_id}
        team_info.team_name
    end

    def team_tackles(game_ids)
        team_ids = {}
        game_teams.each do |object|
            if game_ids.include?(object.game_id)
                team_id_hashes(object, team_ids)
                update_tackles(object, team_ids)
            end
        end
        team_ids
    end

    def team_id_hashes(game_teams_object, team_ids)
        if team_ids[game_teams_object.team_id].nil?
            team_ids[game_teams_object.team_id] = 0
        end
        team_ids
    end

    def update_tackles(game_teams_object, team_ids)
        team_ids[game_teams_object.team_id] += game_teams_object.tackles
        team_ids
    end
end