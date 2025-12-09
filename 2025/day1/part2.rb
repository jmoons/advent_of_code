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

  spin_direction = input_file_line.slice!(0).upcase == "R" ? "+" : "-"

  input_file_line.to_i.times do |step|

    # Move the dial by one click
    current_position = current_position.send(spin_direction.to_sym, 1)

    if current_position == 100
      zero_total += 1
      current_position = 0
    elsif current_position == 0
      zero_total += 1
    elsif current_position == -1
      current_position = 99
    end
  end

end

puts "Zero Total: #{zero_total}"
puts "Correct Total Sample: 6"
puts "Correct Total Full: 5820"