class Polynomial
  
  # Initialize function
  def initialize(coeffs)
    @coeffs = coeffs
    @my_poly = make_polynomial
  end

  # To print the polinomial of an oblect, this should be called
  def print_polynomial
    puts @my_poly
  end

  # The main function that creates the polynomial
  def make_polynomial()
    power = @coeffs.length
    power -= 1
    
    return "Need at least 2 coefficients." if @coeffs.length <= 2

    making_poly = ""
    @coeffs.each do |x|
      if x == 0
        # do nothing
      elsif x > 0
        making_poly << make_string(x,power,"+")
      else
      	making_poly << make_string(x/-1,power,"-")
      end
      power -= 1
    end

    making_poly = check_first_character(making_poly)

    return making_poly
  end


  def make_string(coeff,power,symbol)
    my_string = ""
    if coeff == 1
      my_string << symbol.to_s
      my_string << "x" if power > 0
      my_string << "^" if power > 1
      my_string << power.to_s if power > 1
    else
      my_string << symbol.to_s
      my_string << coeff.to_s
      my_string << "x" if power > 0
      my_string << "^" if power > 1
      my_string << power.to_s if power > 1
    end

    return my_string
  end
    
  # Remove the first character if it is '+'
  def check_first_character(string)
  	return string if string[0] == "-"
  	return string[1..string.length]
  end

end

poly1 = Polynomial.new([1,2,3,4])
poly1.print_polynomial
poly2 = Polynomial.new([-3,-4,1,0,6])
poly2.print_polynomial
poly3 = Polynomial.new([1,0,2])
poly3.print_polynomial
poly4 = Polynomial.new([-1,1,-3,0])
poly4.print_polynomial