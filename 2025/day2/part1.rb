input_file = ARGV[0]

unless input_file
  puts "You must specify an input file"
  exit
end

unless File.exist?( input_file )
  puts "#{input_file} is not a valid file"
  exit
end

sum_of_invalid_ids = 0

File.foreach( input_file ) do | input_file_line |
  input_file_line = input_file_line.chomp

  next if input_file_line.empty?

  input_file_line.split(",").each do |range|
    first, second = range.split("-")
    (first.to_i .. second.to_i).each do |range_member|
      range_member = range_member.to_s

      # We can ignore a number that is not an even length
      next unless range_member.length % 2 == 0
      left = range_member.slice(0, (range_member.length / 2))
      right = range_member.slice((range_member.length / 2), range_member.length)
      if left == right
        sum_of_invalid_ids += range_member.to_i
      end
    end
  end
end

puts "sum_of_invalid_ids: #{sum_of_invalid_ids}"