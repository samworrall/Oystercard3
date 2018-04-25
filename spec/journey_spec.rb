require 'journey.rb'

describe Journey do

  context '#complete?' do
    it "returns nil by default" do
      expect(subject.complete?).to eq(nil)
    end
  end

  context '#start_journey' do
    it "sets complete to false when journey starts" do
      subject.start_journey
      expect(subject.complete?).to eq(false)
    end
  end
end
