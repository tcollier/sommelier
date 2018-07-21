namespace :sommelier do
  desc 'Apply Sommelier to a CSV with a headers row ["dish", "wine", "score"]'
  task :from_csv do
    unless ARGV.length == 2
      raise ArgumentError, 'Expecting a file as the first argument'
    end

    require 'csv'
    require 'sommelier'

    csv = CSV.open(ARGV[1], headers: true)
    sommelier = Sommelier.new
    csv.each do |row|
      sommelier.add_match(row[0], row[1], row[2].to_f)
    end
    sommelier.pairings.each do |dish, wine|
      puts "#{dish} => #{wine}"
    end
  end
end
