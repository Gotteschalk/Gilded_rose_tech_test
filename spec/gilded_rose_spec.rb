require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    context "When called on a standard item sellin date > 0" do

      items = [Item.new("Elixir of the Mongoose", 5, 10)]
      GildedRose.new(items).update_quality

      it "reduces the quality by 1" do
        expect(items[0].quality).to eq 9
      end

      it "reduces the SellIn value by 1" do
        expect(items[0].sell_in).to eq 4
      end

      it "will not reduce the quality to less than 0" do
        20.times{ GildedRose.new(items).update_quality }
      expect(items[0].quality).to eq 0
      end
    end

    context "When called on a standard item with Sellin days <= 0 " do
      items = [Item.new("Elixir of the Mongoose", 0, 10)]

      it "Decreases the quality value by 2" do
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 8
      end
    end

    context "Aged Brie" do
      items = [Item.new("Aged Brie", 5, 10)]

      it "Increases in quality by 1" do
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 11
      end

      it "Cannot have a quality greater than 50" do
        100.times{ GildedRose.new(items).update_quality }
        expect(items[0].quality).to eq 50
      end
    end

    context "Sulfuras, Hand of Ragnaros" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 1, 80)]

      it "Does change in Sellin date" do
        expect{GildedRose.new(items).update_quality}.to_not change{items[0].sell_in}.from(1)
      end

      it "Does not change in value" do
        expect{2.times{GildedRose.new(items).update_quality}}.to_not change{items[0].quality}.from(80)
      end
    end

    context "Backstage passes to a TAFKAL80ETC concert" do
      it "Increases by a quality of 1 when Sellin date > 10 days" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)]
        expect{GildedRose.new(items).update_quality}.to change{items[0].quality}.from(20).to(21)
      end

      it "Increases by a quality of 2 when Sellin date between 5-9 days" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 10
        expect(items[0].quality).to eq 21

        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 23
      end

      it "Increases by a quality of 3 when Sellin date between 5-9 days" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 5
        expect(items[0].quality).to eq 22

        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 4
        expect(items[0].quality).to eq 25
      end

      it "Has a quality of 0 when sell_in date is less than 0" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 0
        expect(items[0].quality).to eq 23

        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 0
      end
    end

    context "Conjured Mana Cake" do
      items = [Item.new("Conjured Mana Cake", 1, 20)]

      it "Decreases in quality twice as fast as normal items" do
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 0
        expect(items[0].quality).to eq 18

        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 14
      end
    end
  end
end
