class Dinbrief < Prawn::Document
  def initialize(opts={})
    super({
      page_size: 'A4',
      
    }.merge(opts))
  end

  def header
    
  end

  def subject
    
  end

end

s = <<SSS
class A
  def self.new(*args, &block)
    n = super
    if block_given?
      begin
        yield(n)
      ensure
        n.zerstör
      end
    else
      n
    end
  end
  def initialize(x)
    @x=x
  end
  def f(x)
    x+@x
  end
end


brief = Dinbrief.new(....) do
  nowindowtics
  centeraddress
  ...
  suject "Ihr schreiben vom"
  closing "mfg"
  ...
end
SSS