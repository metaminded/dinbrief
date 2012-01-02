#encoding: utf-8

class Dinbrief
  class LetterBuilder
    
    def initialize(letter=nil)
      @letter = letter
    end
    
    [
      :body, :subject, :header, :return_address, :address,
      :yoursign, :yourmessage, :oursign, :ourmessage, 
      :name, :phone, :fax, :email,
      :date
    ].each do |nam|
      define_method nam do |s|
        instance_variable_set("@#{nam}", block_given? ? block : s)
      end
    end
    
  end
end