input_file = ARGV[0]

unless input_file
  puts "You must specify an input file"
  exit
end

unless File.exist?( input_file )
  puts "#{input_file} is not a valid file"
  exit
end

sum_of_maximum = 0
number_of_batteries_needed = 12
max_batteries = []

File.foreach( input_file ) do | input_file_line |
  input_file_line = input_file_line.chomp

  next if input_file_line.empty?

  bank_max = Array.new(number_of_batteries_needed, 0)

  input_file_line.split("").map(&:to_i).each_with_index do |battery, index|

    bank_max.each_with_index do |bank_battery, bank_index|
      # We have to see if this battery is bigger than one we've already pulled into our collection of large batteries
      # Also, we need to ensure there are enough remaining batteries to fill remaining spots in our collection
      if (battery > bank_battery) && ((input_file_line.length - index) >= (number_of_batteries_needed - bank_index))
        # We found a larger battery, stash away in our collection
        bank_max[bank_index] = battery
        # Now zero out all following batteries in our collection
        bank_max.fill(0, (bank_index+1))
        break
      end
    end
  end

  sum_of_maximum += bank_max.join.to_i
  max_batteries << bank_max.join

end

puts "max_batteries: #{max_batteries}"

puts "sum_of_maximum: #{sum_of_maximum}"

