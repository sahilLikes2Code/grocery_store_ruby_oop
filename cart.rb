class Cart
  def initialize
    @items = []
  end

  def add_item(item)
    @items.push(item)
  end

  def amount_before_after_discount
    total_amount_before_discount = @items.map { |item| item.regular_price }.inject { |sum, n| sum + n }
    items_group = @items.group_by { |item| item.name }
    discounted_amount = items_group.inject(0) { |total, (name, list)|
      total += collection_bulk_price(list)
    }

    [total_amount_before_discount, discounted_amount]
  end

  private

  def collection_bulk_price(collection)
    return 0 if (collection.nil? || collection.empty?)

    size = collection.size
    item = collection[0]
    return size * item.regular_price if item.sale_price.nil?

    quotient = size / item.min_qty_for_dscnt
    remainder = size % item.min_qty_for_dscnt
    (quotient * item.sale_price) + (remainder * item.regular_price)
  end
end
