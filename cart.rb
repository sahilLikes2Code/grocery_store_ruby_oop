class Cart
  def initialize
    @items = []
  end

  def add_item(grocery_item)
    @items.push(grocery_item)
  end
end
