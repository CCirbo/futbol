require 'rspec'
require './lib/team'
require 'pry'

RSpec.describe Team do
  

  describe "class methods" do
    it "should return Team objects when given a csv" do

      path = "./data/teams.csv"
      outcome = Team.create_multiple_teams(path)

      expect(outcome).to be_an Array
      first_team = outcome.first
      expect(first_team.team_id).to eq("1")
      expect(first_team.franchiseId).to eq("23")
      expect(first_team.teamName).to eq("Atlanta United")
      
    end
  end
end

# team_id,franchiseId,teamName,abbreviation,Stadium,link
# 1,23,Atlanta United,ATL,Mercedes-Benz Stadium,/api/v1/teams/1