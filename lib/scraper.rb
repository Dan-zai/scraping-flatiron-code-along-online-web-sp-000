require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  
  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end
  
  def get_courses
    self.get_page.css(".post")
  end 
  
  def make_courses
    self.get_courses.each do |article|
      course = Course.new
      course.title = article.css("h2").text.strip
      course.schedule = article.css("date").text.strip
      course.description = article.css("p").text.strip
    end
  end 
      


  
  
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end 

