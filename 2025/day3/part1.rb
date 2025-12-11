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
number_of_batteries_needed = 2

File.foreach( input_file ) do | input_file_line |
  input_file_line = input_file_line.chomp

  next if input_file_line.empty?

  max1 = 0
  max2 = 0
  length = input_file_line.split("").length

  # Find the highest digit in the space remaining
  # When we find a high digit, we can ignore all the values that came before it and scan for remaining digits

  input_file_line.split("").each_with_index do |battery, index|
    if (battery.to_i > max1) && (index != (length - 1))
      max1 = battery.to_i
      max2 = 0
    elsif battery.to_i > max2
      max2 = battery.to_i
    end
  end

  sum_of_maximum = sum_of_maximum + (max1.to_s << max2.to_s).to_i


end

puts "sum_of_maximum: #{sum_of_maximum}"
