# No chomp on the line as we need the newlines here
# When a line length is exactly one, we know it's a blank line (end of one passport, beginning of next)
# Steps I'm thinking:
# 1) Normalize input - make an array of arrays each child array being one passport's worth of information
# 2) Process each passport

# byr (Birth Year) - four digits; at least 1920 and at most 2002.
# iyr (Issue Year) - four digits; at least 2010 and at most 2020.
# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
# hgt (Height) - a number followed by either cm or in:
# If cm, the number must be at least 150 and at most 193.
# If in, the number must be at least 59 and at most 76.
# hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
# ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
# pid (Passport ID) - a nine-digit number, including leading zeroes.
# cid (Country ID) - ignored, missing or not.

PASSPORT_FIELDS = {
  byr: { expression: , min: 1920, max: 2002},
  iyr: { expression: , min: 2010, max: 2020},
  eyr: { expression: , min: 2020, max: 2030},
  hgt: { expression: , min: , max: },
  hcl: { expression: /\A#[0-9a-fA-F]{6}\z/ },
  ecl: { expression: },
  pid: { expression: },
  cid: { expression: }
}

OPTIONAL_PASSPORT_FIELD     = "cid"
PASSPORT_FIELDS_EXPRESSION  = /(?<entry>[a-zA-Z]+):(?<value>[\w\W]+)/
input_file                  = File.open( "input_day_4.txt", "r" )
input_passports             = []
valid_passports             = []
current_passport_info       = {}

# Normalize the input - capture each passport's information from the input file
input_file.each_line do | line |
  if line.length == 1
    # Start new passport
    input_passports << current_passport_info if current_passport_info.length != 0
    current_passport_info = {}
  else
    line.chomp.split(" ").each do | entry |
      matched_entry = entry.match( PASSPORT_FIELDS_EXPRESSION )
      current_passport_info[ matched_entry[:entry] ] = matched_entry[:value]
    end
  end
end
# Capture the last passport of the file
input_passports << current_passport_info if current_passport_info.length != 0

# Validate the normalized passports
input_passports.each do | passport_to_verify |
  passport_entries = passport_to_verify.keys
  valid_passport   = true
  PASSPORT_FIELDS.each do | passport_field |
    # cid is optional
    next if passport_field == OPTIONAL_PASSPORT_FIELD
    valid_passport = false unless passport_entries.include?( passport_field )
  end

  valid_passports << passport_to_verify if valid_passport

end

puts "Total Number of Passports: #{input_passports.length}"
puts "Number of Valid Passports: #{valid_passports.length}"


# Hair Color Validation: /\A#[0-9a-fA-F]{6}\z/