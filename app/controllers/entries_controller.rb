class EntriesController < ApplicationController
  def index
    Entry.destroy_all
    require 'open-uri'
    # urlbasis = "https://www.leboncoin.fr/velos/offres/ile_de_france/paris/?o=#{urldelta}&q=v%E9lo%20course&pe=12&location=Paris"
    # @doc = Nokogiri::HTML(open(urlbasis))
    if (params[:query] != "")
      urlbasis = "https://www.leboncoin.fr/velos/offres/ile_de_france/paris/?th=1&q=v%E9lo%20course%20taille%20#{params[:query]}&location=Paris&pe=12"
      @doc = Nokogiri::HTML(open(urlbasis))
      @entries = @doc.css('.list_item')
      @entries.each do |entry|
        pricediv = entry.css('.item_price').attr("content").value
        title = entry['title']
        link = "https:" + entry['href']
        # @picture = @itemimage.attr("data-imgsrc")
        # puts " ---------- #{@itemimage}"
        @doc2 = Nokogiri::HTML(open("#{link}"))
        @description = @doc2.css('.properties_description .value').inner_text
        puts "----------- #{@description}"
        @test = params[:query]

        if @description.include? @test
          Entry.create(title: title, link: link, price: pricediv.to_i, description: @description)
        end
      end
    end


    allEntry = Entry.all
    allEntry.each do |entry|
      urlsecond = entry.link
      @doc3 = Nokogiri::HTML(open(urlsecond))
      @imglink = @doc3.css('.lazyload').to_s
      re = /"https.*jpg"/
      @imglinkregex = re.match(@imglink)
      if @imglinkregex != nil
        puts @imglinkregex[0]
        @imgfine = @imglinkregex[0][1...-1]
        entry.picture = @imgfine
        entry.save
      end
      # if @imglinkok.include? @testbonus
      #   entry.picture = @imglinkok
      #   entry.save
      # end


    end


  end

  def new
    @entry = Entry.new
  end



end
