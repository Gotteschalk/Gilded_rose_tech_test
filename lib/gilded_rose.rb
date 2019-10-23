require_relative 'item'

class GildedRose

MAXIMUM_QUALITY_VALUE = 50
MINIMUM_QUALITY_VALUE = 0
STD_QUALITY_DEPRECIATION = 1
STD_QUALITY_APPRECIATION = 1

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.depreciates?
        decrease_quality(item)
      elsif item.appreciates?
        increase_quality(item)
      end
      enforce_min_and_max_quality(item)
      decrease_sell_in_date(item)
    end
  end

private

  def enforce_min_and_max_quality(item)
    unless item.name == "Sulfuras, Hand of Ragnaros"
      item.quality < MINIMUM_QUALITY_VALUE ? item.quality = MINIMUM_QUALITY_VALUE : item.quality = item.quality
      item.quality > MAXIMUM_QUALITY_VALUE ? item.quality = MAXIMUM_QUALITY_VALUE : item.quality = item.quality
    end
  end

  def decrease_quality(item)
    item.sell_in > 0 ? item.quality -= STD_QUALITY_DEPRECIATION : item.quality -= 2 * STD_QUALITY_DEPRECIATION
    if item.name == "Conjured Mana Cake"
      item.sell_in > 0 ? item.quality -= STD_QUALITY_DEPRECIATION : item.quality -= 2 * STD_QUALITY_DEPRECIATION
    end
  end

  def increase_quality(item)
    item.quality += STD_QUALITY_APPRECIATION
    if item.name == "Backstage passes to a TAFKAL80ETC concert" && item.sell_in <= 0
        item.quality = MINIMUM_QUALITY_VALUE
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert" && item.sell_in <= 5
          item.quality += 2 * STD_QUALITY_APPRECIATION
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert" && item.sell_in <= 10
      item.quality += STD_QUALITY_APPRECIATION
    end
  end

  def decrease_sell_in_date(item)
    item.name != "Sulfuras, Hand of Ragnaros" ?  item.sell_in -= 1 : item.sell_in = item.sell_in
  end
end
