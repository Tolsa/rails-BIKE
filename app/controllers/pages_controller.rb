class PagesController < ApplicationController

  def home

    @renderedText = 'scrape reddit data here'
    require 'open-uri'
    @doc = Nokogiri::HTML(open("https://www.leboncoin.fr/velos/offres/ile_de_france/paris/?th=1&q=v%E9lo%20course&location=Paris&pe=12"))

    @entries = @doc.css('.list_item').first(8)
    @entriestitle = []
    @entrieslink = []
    @entries.each do |entry|
      title = entry['title']
      link = entry['href']
      Entry.create(title: title, link: link)
    end
  end
end
