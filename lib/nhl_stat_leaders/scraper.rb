class NhlStatLeaders::Scraper

  def self.get_page
    html = open("https://www.cbssports.com/nhl/stats/playersort/nhl/year-2018-season-regularseason-category-goals?print_rows=9999")
    Nokogiri::HTML(html)
  end

  def self.scrape_stats
    doc = self.get_page
    all_athlete_stat_lines = []
    stat_table = doc.css('table.data')
    
    stat_table.css('tr').each do |stats|
      athlete_stat_lines = {
        name: stats.css('td:nth-child(1)').text,
        position: stats.css('td:nth-child(2)').text,
        team: stats.css('td:nth-child(3)').text,
        games_played: stats.css('td:nth-child(4)').text.to_i,
        goals: stats.css('td:nth-child(5)').text.to_i,
        assists: stats.css('td:nth-child(6)').text.to_i,
        points: stats.css('td:nth-child(7)').text.to_i,
        plus_minus: stats.css('td:nth-child(8)').text.to_i,
        penalty_min: stats.css('td:nth-child(9)').text.to_i,
        power_play_goals: stats.css('td:nth-child(10)').text.to_i,
        short_handed_goals: stats.css('td:nth-child(11)').text.to_i,
        game_winning_goals: stats.css('td:nth-child(12)').text.to_i,
        overtime_goals: stats.css('td:nth-child(13)').text.to_i,
        shots_on_goal: stats.css('td:nth-child(14)').text.to_i,
        shooting_percentage: stats.css('td:nth-child(15)').text.to_f,
        time_on_ice_per_game: stats.css('td:nth-child(16)').text.sub(":", ".").to_f,
        average_shifts_per_game: stats.css('td:nth-child(17)').text.to_f,
        faceoff_percentage: stats.css('td:nth-child(18)').text.to_f,
        shootout_percentage: stats.css('td:nth-child(19)').text.to_f
      }
      
      all_athlete_stat_lines << athlete_stat_lines  
    end

  all_athlete_stat_lines[2..-2]
  end

end