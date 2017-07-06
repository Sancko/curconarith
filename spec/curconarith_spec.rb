require "spec_helper"
require "curconarith"

RSpec.describe Curconarith do
  describe "Money in general" do
    before {Money.conversion_rates('EUR','USD'=>2.0,'CAN'=>3.0)}
  
    # Creating and converting money
  
    it "should create money object " do
      money  = Money.new(5, 'EUR')
      expect(money.amount).to be   == 5
      expect(money.currency).to be == 'EUR'
    end
    
    it "should convert money from system currency to given one " do
      # convert from currency of the system given by Money.conversion_rates
      money1  = Money.new(5, 'EUR')
      money1.convert_to('CAN') 
      expect(money1.amount).to be   == 15
      expect(money1.currency).to be == 'CAN'
    end
    
    it "should convert money from any currency to given one" do
      # convert from currency different from given by Money.conversion_rates
      # convert first to EUR that to given currency
      money1 = Money.new(10, 'USD')
      money1.convert_to('CAN') # 10 'USD'=>  5 'EUR' => 15 'CAN'
      expect(money1.amount).to be   == 15
      expect(money1.currency).to be == 'CAN'
    end
    
    it "should not convert money  to the currency that is not given" do
      expect{ Money.new(5, 'EUR').convert_to('UAH')}.to raise_error(TypeError)
    end
        it "should swap positive to negative" do
      expect((-Money.new(10, 'USD')).inspect).to eq Money.new(-10, 'USD').inspect
    end
  end
  #Arithmetics

  describe "* action" do
    it "should multiply money 2 times" do
     expect((Money.new(10, 'USD')*2).inspect).to  eq Money.new(20, 'USD').inspect
    end
    it "should not multiply by any class but Numeric" do
      expect{(Money.new(20, 'USD'))*"sdf"}.to raise_error(TypeError)
    end
    it "should not multiply by any class but Numeric even money class" do
      expect{(Money.new(20, 'USD'))*(Money.new(10, 'USD'))}.to raise_error(TypeError)
    end
    
   # it "should multiply number by Money" do
   #   expect{(2*(Money.new(10, 'USD'))).inspect}.to eq Money.new(20, 'USD').inspect
   # end
  end

  describe "/ action" do
    it "should divide money for 2 parts" do
      expect((Money.new(10, 'USD')/2).inspect).to  eq Money.new(5.0, 'USD').inspect
    end
    it "should divide money for part of 5 USD each" do
      expect((Money.new(10, 'USD'))/(Money.new(5, 'USD'))).to eq 2
    end
    it "should divide money for part of 5 USD each" do
      expect((Money.new(20, 'USD'))/(Money.new(2, 'EUR'))).to eq 5
    end
    it "should not divide by any class but Money or Numeric" do
      expect{(Money.new(20, 'USD'))/"sdf"}.to raise_error(TypeError)
    end
  end

  describe "+ action" do
    it "should add money to money the same currency" do
      expect((Money.new(10, 'USD')+(Money.new(3, 'USD'))).inspect).to eq Money.new(13, 'USD').inspect
    end
    it "should add money to money different currency" do
      expect((Money.new(3, 'EUR')+(Money.new(10, 'USD'))).inspect).to eq Money.new(8.0, 'EUR').inspect
    end
    it "should not divide by any class but Money" do
      expect{(Money.new(20, 'USD'))+"sdf"}.to raise_error(TypeError)
    end
  end

  describe "- action" do
    it "should subtract money from money of the same currency" do
     expect((Money.new(10, 'USD')-(Money.new(3, 'USD'))).inspect).to eq Money.new(7, 'USD').inspect
    end
    it "should subtract money from money of a different currency" do
      expect((Money.new(10, 'EUR')-(Money.new(4, 'USD'))).inspect).to eq Money.new(8.0, 'EUR').inspect
    end
    it "should subtract any class but Money" do
      expect{(Money.new(20, 'USD'))-"sdf"}.to raise_error(TypeError)
    end
  end

  describe "> comparison" do
    it "should compare money the same currency" do
     expect(Money.new(10, 'USD')>(Money.new(3, 'USD'))).to  be true
     expect(Money.new(10, 'USD')>(Money.new(13, 'USD'))).to be false
    end
    it "should compare money different currency" do
     expect(Money.new(10, 'USD')>(Money.new(4, 'EUR'))).to be true
     expect(Money.new(6, 'USD')>(Money.new(15, 'EUR'))).to be false
    end
    
    it "should not compare money to different class" do
     expect{Money.new(10, 'USD')>'sdf'}.to raise_error(TypeError)
    end
  end
  
  describe ">= comparison" do
    it "should compare money the same currency" do
     expect(Money.new(10, 'USD')>=(Money.new(10, 'USD'))).to  be true
    end
    it "should compare money different currency" do
     expect(Money.new(10, 'USD')>=(Money.new(5, 'EUR'))).to be true
    end
  end

  describe "< comparison" do
    it "should compare money the same currency" do
     expect(Money.new(10, 'USD')<(Money.new(3, 'USD'))).to  be false
     expect(Money.new(10, 'USD')<(Money.new(13, 'USD'))).to be true
    end
    it "should compare money different currency" do
     expect(Money.new(10, 'USD')<(Money.new(4, 'EUR'))).to be false
     expect(Money.new(6, 'USD')<(Money.new(15, 'EUR'))).to be true
    end
  end
  
  describe "<= comparison" do
    it "should compare money the same currency" do
     expect(Money.new(10, 'USD')<=(Money.new(10, 'USD'))).to  be true
    end
    it "should compare money different currency" do
     expect(Money.new(10, 'USD')<=(Money.new(5, 'EUR'))).to be true
    end
  end

  describe "== comparison" do
    it "should compare money the same currency" do
     expect(Money.new(10, 'USD')==Money.new(3, 'USD')).to  be false
     expect(Money.new(10, 'USD')==Money.new(10, 'USD')).to be true
    end
    it "should compare money different currency" do
     expect(Money.new(8, 'USD')==(Money.new(4, 'EUR'))).to be true
     expect(Money.new(6, 'USD')==(Money.new(15, 'EUR'))).to be false
     expect(Money.new(0, 'USD')==(Money.new(0, 'EUR'))).to be true
    end
    it "should do some magic 'as usual to be precise' " do
     expect(Money.new(50, 'EUR').convert_to('USD') == Money.new(50, 'EUR')).to be true
    end
    it "should not compare money to different class" do
     expect{Money.new(10, 'USD')>'sdf'}.to raise_error(TypeError)
    end
  end
  
  describe "abs" do
    it "should do the same magic as abs in real life" do
     expect(Money.new(-10, 'USD').abs.amount).to  eq 10
     expect(Money.new(10, 'USD').abs.amount).to  eq 10
    end
  end

end
