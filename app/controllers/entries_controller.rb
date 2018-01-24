class EntriesController < ApplicationController
  def index
    Entry.destroy_all
    require 'open-uri'
    urldelta = 1
    # urlbasis = "https://www.leboncoin.fr/velos/offres/ile_de_france/paris/?o=#{urldelta}&q=v%E9lo%20course&pe=12&location=Paris"
    # @doc = Nokogiri::HTML(open(urlbasis))

    while urldelta <= 6 do
      urlbasis = "https://www.leboncoin.fr/velos/offres/ile_de_france/paris/?o=#{urldelta}&q=v%E9lo%20course&pe=12&location=Paris"
      @doc = Nokogiri::HTML(open(urlbasis))
      @entries = @doc.css('.list_item').first(12)
      @entriestitle = []
      @entrieslink = []
      @entries.each do |entry|
        title = entry['title']
        link = entry['href']
        @doc2 = Nokogiri::HTML(open("https:#{link}"))
        @description = @doc2.css('.properties_description .value').inner_text
        @test = params[:query]
        @exception = "1m55"

        if @description.include? @test
        Entry.create(title: title, link: link)
        end
      end

      urldelta += 1
    end
  end

  def new
    @entry = Entry.new
  end



end
