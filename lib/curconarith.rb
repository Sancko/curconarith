class Money
	attr_accessor :amount, :currency

  def self.conversion_rates(currency_from, option={}) #class method
    @@hash_of_currency   = {}
    @@currency_of_system = currency_from

    option.each do |currency_to, rate|
      @@hash_of_currency[currency_to] = rate
    end
      
  end

  def initialize(amount, currency)
    self.amount   = amount
    self.currency = currency
  end

# convertation   
  def convert_to(currency_to) #instance method
    if @@hash_of_currency[currency_to] && self.currency == @@currency_of_system
     self.amount   = amount*@@hash_of_currency[currency_to]
     self.currency = currency_to
     self
    elsif @@hash_of_currency[currency_to] 
   # convert first to EUR that to given currency
     self.convert_to_currency_of_system
     self.convert_to(currency_to)
    else
     raise TypeError, 
     "There is no chance that you can convert #{self.inspect} to #{currency_to}"
    end
  end
  
  def convert_to_currency_of_system
    if self.currency == @@currency_of_system
      self.amount   
      self.currency
    else
      self.amount   = amount*(1/@@hash_of_currency[self.currency])
      self.currency = @@currency_of_system
    end
  end

  def inspect
    "\"#{@amount} #{@currency}\""    
  end
  
  def -@
    self.class.new(-amount, currency)
  end
  
  def abs
    self.class.new(amount.abs, currency)
  end

# Arithmetics

  def *(other)
    if other.is_a? Numeric
    self.class.new(other*amount, currency)
    else
      raise TypeError, "Please do not do that again!"
    end
  end  
  
  def /(other)
    if other.is_a?(Money)
      if currency == other.currency
        amount/other.amount
      else
        self.convert_to_currency_of_system
        other.convert_to_currency_of_system
        self/other
      end
    elsif other.is_a?(Numeric)
      self.class.new((amount/other.to_f), currency)
    else
      raise TypeError, "How on Earth you can do that"
    end
  end
  
  [:+,:-].each do |operator|
    define_method operator do |other| 
      if other.is_a?(Money)
        if currency == other.currency
          self.class.new(amount.public_send(operator, other.amount), currency)
        else
         self.convert_to_currency_of_system
         other.convert_to_currency_of_system
         self.class.new(amount.public_send(operator, other.amount), currency)
        end   
      else
        raise TypeError, "Nice try!" 
      end
    end
  end

  [:>, :>=, :<, :<=, :==].each do |operator|
    define_method operator do |other| 
      if other.is_a?(Money)
        if currency == other.currency
           amount.public_send(operator, other.amount)
        else
         self.convert_to_currency_of_system
         other.convert_to_currency_of_system
         amount.public_send(operator, other.amount)
        end   
      else
        raise TypeError, "Nice try!" 
      end
    end
  end

end


