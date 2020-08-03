class Item
  attr_reader :name, :regular_price, :sale_price, :min_qty_for_dscnt

  def initialize(name, regular_price, sale_price, min_qty_for_dscnt)
    @name = name
    @regular_price = regular_price
    @sale_price = sale_price
    @min_qty_for_dscnt = min_qty_for_dscnt
  end
end
