# Model
def open_file(filepath)
	IO.readlines(filepath)
end

def check_if_expense(string)

	string.include?(" - ") ? true : false
end

# returns true if line above particular element is not an expense
def check_if_first_expense(array, index) 
	!check_if_expense(array[index - 1]) ? true : false 
end 

def create_text_file(filename)
	File.new("#{filename}.txt", "w+")
end

def split_string_on_char(string, char)
	string.split(char)
end

# Controller
puts "Enter valid text filename without the extension"
filename = gets.chomp

expenses = open_file("#{filename}.txt")
parsed_expenses = []
	
expenses.each_with_index  do |line, index|

	if check_if_expense(line) && check_if_first_expense(expenses, index)
		expenses_hash = {} # create new hash
		i = index # set i as index counter

		# sets key value pairs in hash until the end of that particular expenses block
		until check_if_expense(expenses[i]) == false
			type, cost = split_string_on_char(expenses[i], " - ")
			expenses_hash[type] = cost.chomp
			i += 1
		end

		# pushes the newly created hash to the new array
		parsed_expenses << expenses_hash
	elsif check_if_expense(line) == false
		parsed_expenses << line
	end

end

excel_parsed = create_text_file("#{filename}_parsed")

parsed_expenses.each do |element|

	if element.class == Hash
		element.each_key { |key| File.open(excel_parsed, "a") { |f| f << key + "\n" } }
		element.each_value { |value| File.open(excel_parsed, "a") { |f| f << value + "\n" } }
	else
		File.open(excel_parsed, "a") { |f| f << element } if element.class == String
	end

end




