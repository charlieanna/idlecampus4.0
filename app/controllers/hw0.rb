def sum(numbers)
	sum = 0
	if numbers.length == 0
		return 0
	else
      numbers.each do |number|
      	sum+=number
      end
	end
	return sum
end

def max_2_sum(numbers)
	if numbers.length == 0
		return 0
	elseif numbers.length == 1
		return numbers[0]
	else
		
	end
end

