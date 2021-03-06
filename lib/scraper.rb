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
    data = Nokogiri::HTML(open(profile_url))
    
    profile = {}
    
    data.css("div.social-icon-container a").each do |link|
      domain = link.attribute("href").value.gsub(/(http).*\/\//,"").gsub(/www./,"").gsub(/\..*/,"")
      if domain == "twitter"
        profile[:twitter] = link.attribute("href").value
      elsif domain == "linkedin"
        profile[:linkedin] = link.attribute("href").value
      elsif domain == "github"
        profile[:github] = link.attribute("href").value
      else
        profile[:blog] = link.attribute("href").value
      end
    end
    
    profile[:profile_quote] = data.css("div.profile-quote").text
    
    profile[:bio] = data.css("div.description-holder p").text
    
    profile
  end
end