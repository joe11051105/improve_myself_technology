class Product
  def use
    raise NotImplementedError
  end
end

class Factory
  def create(owner)
    product = create_product(owner)
    register_product(product)
    product
  end

  def create_product(owner)
    raise NotImplementedError
  end

  def register_product(product)
    raise NotImplementedError
  end
end

class IDCard < Product
  attr_reader :owner

  def initialize(owner)
    @owner = owner
    puts "id card of #{@owner}"
  end

  def use
    puts "use id card of #{@owner}"
  end
end

class IDCardFactory < Factory
  attr_reader :owners

  def create_product(owner)
    IDCard.new(owner)
  end

  def register_product(product)
    @owners ||= []
    @owners << product.owner
  end
end

is_card_factory = IDCardFactory.new()
card_a =is_card_factory.create("Joe")
card_b = is_card_factory.create("Vicky")
card_c = is_card_factory.create("Harry")
card_a.use
card_b.use
card_c.use

