require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    data = Nokogiri::HTML(open(index_url))

    students = []

    data.css(".student-card").each do |student|
      name = student.css("h4.student-name").text
      location = student.css("p.student-location").text
      profile_url = student.css("a").attribute("href").value
      
      students << {:name => name, :location => location, :profile_url => profile_url}
    end
    
    students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end