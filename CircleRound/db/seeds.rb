# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  f=File.open('db/ProvinceAndCity.xml','r')
  doc = Nokogiri::XML(f)
  state= Hash.new
  city=Hash.new
  doc.xpath('//China/Province').each do |p|
  	state[(p.values[0].to_i)/10000]=p.values[1]
  	State.create([{name:p.values[1]}])
  end

  doc.xpath('//Province/City').each do |c|
    city[(c.values[0].to_i)/100]=c.values[1]
  	City.create(:name=>c.values[1], :state_id=>State.find_by_name(state[c.values[0].to_i/10000]).id)
  end

  doc.xpath('//City/Area').each do |a|
    Area.create(:name=>a.values[1], :city_id=>City.find_by_name(city[a.values[0].to_i/100]).id)
  end