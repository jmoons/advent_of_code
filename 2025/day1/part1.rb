input_file = ARGV[0]

unless input_file
  puts "You must specify an input file"
  exit
end

unless File.exist?( input_file )
  puts "#{input_file} is not a valid file"
  exit
end

zero_total = 0
current_position = 50
File.foreach( input_file ) do | input_file_line |
  input_file_line = input_file_line.chomp

  next if input_file_line.empty?

  if input_file_line.slice!(0).upcase == "R"
    current_position = current_position + input_file_line.to_i
    while current_position > 99
      current_position -= 100
    end
  else
    current_position = current_position - input_file_line.to_i
    while current_position < 0
      current_position = 100 - (current_position.abs)
    end

  end
  zero_total +=1 if current_position == 0
  puts "Current Position: #{current_position}"
end

puts "Zero Total: #{zero_total}"