require 'csv'

class Team
    attr_reader :team_id, :franchiseId, :teamName, :abbreviation, :stadium, :link

    def initialize(team_id, franchiseId, teamName, abbreviation, stadium, link)
      @team_id = team_id
      @franchiseId = franchiseId
      @teamName = teamName
      @abbreviation = abbreviation
      @stadium = stadium
      @link = link
    end

    def self.create_multiple_teams(path)
    team_path = []
    CSV.foreach(path, headers: true) do |row|
      team_path << Team.new(row["team_id"], row["franchiseId"], row["teamName"], row["abbreviation"], row["Stadium"], row["link"])
    end
   team_path
    binding.pry
    end
end