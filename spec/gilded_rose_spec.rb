require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    context "When called on a standard item"

      items = [Item.new("foo", 5, 10)]
      GildedRose.new(items).update_quality

      it "reduces the quality by 1" do
        expect(items[0].quality).to eq 9
      end

      it "reduces the SellIn value by 1" do
        expect(items[0].sell_in).to eq 4
      end

      it "will not reduce the quality to less than 0" do
        11.times{ GildedRose.new(items).update_quality }
      expect(items[0].quality).to eq 0
    end
  end
  

end
