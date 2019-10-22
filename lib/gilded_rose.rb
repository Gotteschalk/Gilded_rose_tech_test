require_relative 'item'

class GildedRose

MAX_QUALITY = 50
MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
      else
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
                item.quality = item.quality + 1
            end
            if item.sell_in < 6
                item.quality = item.quality + 1
            end
          end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
          else
            item.quality = item.quality - item.quality
          end
        else
            item.quality = item.quality + 1
        end
      end
      enforce_min_and_max_qualities(item)
    end
  end

private

  def enforce_min_and_max_qualities(item)
    item.quality < MIN_QUALITY ? item.quality = MIN_QUALITY : item.quality = item.quality
    item.quality > MAX_QUALITY ? item.quality = MAX_QUALITY : item.quality = item.quality
  end
end
